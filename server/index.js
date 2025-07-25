const { on } = require("events");
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require('./models/room');
var io = require("socket.io")(server);

const DB = "mongodb+srv://ashutoshdwivedi540:KnockOut%40101@cluster0.h3dgsbl.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

io.on("connection", (socket) => {
    console.log("connected");
    socket.on("createRoom", async ({ nickname }) => {
        console.log(nickname);
        //create room
        try {
            let room = new Room();
            let player = {
                socketId: socket.id,
                nickname,
                playerType: 'X',
            }
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            console.log(room);
            const roomId = room._id.toString();
            socket.join(roomId);

            io.to(roomId).emit('createRoomSuccess', room);
        } catch (e) {
            console.log(e);
        }
    });

    socket.on('joinRoom', async ({ nickname, roomId }) => {
        try {
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit('errorOccured', 'Please enter valid room id.');
                return;
            }
            let room = await Room.findById(roomId);
            if (room.isJoin) {
                let player = {
                    nickname,
                    socketId: socket.id,
                    playerType: 'O',
                }
                socket.join(roomId);
                room.isJoin = false;
                console.log('is join property changing to' + room.isJoin);
                room.players.push(player);
                room = await room.save();
                io.to(roomId).emit('joinRoomSuccess', room);
                io.to(roomId).emit('updatePlayers', room.players);
                io.to(roomId).emit('updateRoom', room);

            } else {
                socket.emit('errorOccured', 'The game is in progress.');
                return;
            }
        }
        catch (e) {
            console.log(e);
        }
    });

    socket.on('tap', async ({ index, roomId }) => {
        try {
            let room = await Room.findById(roomId);

            let choice = room.turn.playerType;

            if (room.turnIndex == 0) {
                room.turn = room.players[1];
                room.turnIndex = 1;
            } else {
                room.turn = room.players[0];
                room.turnIndex = 0;
            }
            room = await room.save();
            io.to(roomId).emit('tapped', {
                index,
                choice,
                room
            })
        } catch (e) {
            console.log(e);
        }
    });

    socket.on('winner', async ({ winnerSocketId, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let player = room.players.find((player) => player.socketId == winnerSocketId);
            let otherPlayer = room.players.find((player) => player.socketId != winnerSocketId);

            console.log(player);
            player.points += 1;
            await room.save();
            if (player.points + otherPlayer.points == room.maxRounds) {
                if (player.points > otherPlayer.points)
                    io.to(roomId).emit("endGame", player);
                else
                    io.to(roomId).emit("endGame", otherPlayer);
                await Room.findByIdAndDelete(roomId);
                console.log(`Room ${roomId} deleted after game end.`);
            } else {
                io.to(roomId).emit("pointIncrease", player);
            }
        } catch (error) {
            console.log(error);
        }
    });

    socket.on('disconnect', async () => {
        try {
            const roomId = socket.data.roomId;
            if (!roomId) return;

            let room = await Room.findById(roomId);
            if (!room) return;

            const disconnectedPlayer = room.players.find(p => p.socketId === socket.id);
            const otherPlayer = room.players.find(p => p.socketId !== socket.id);

            if (otherPlayer) {
                io.to(roomId).emit("endGameDueToError", {disconnectedPlayer});
            }

            await Room.findByIdAndDelete(roomId);
            console.log(`Room ${roomId} deleted due to disconnect.`);
        } catch (e) {
            console.log("Error in disconnect handler:", e);
        }
    });
})



mongoose
    .connect(DB)
    .then(() => {
        console.log("connected to database");
    })
    .catch((e) => {
        console.log(e);
    });

app.use(express.json());
server.listen(port, "0.0.0.0", () => {
    console.log(`server started on port ${port}`);
});
