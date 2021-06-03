const express = require('express')
const { Client } = require('pg')
const client = new Client({
    user: process.env.PG_USER || 'postgres',
    database: process.env.PG_DATABASE || 'postgres',
    password: process.env.PG_PASSWORD || 'password',
    port: process.env.PG_PORT || 30432,
    host: process.env.PG_HOST || 'localhost',
    keepAlive: process.env.PG_KEEP_ALIVE || true,
    ssl: process.env.PG_SSL || false
})
const app = express()

 
app.get('/:id', async function (req, res) {
    const queryText = `SELECT p2."name" as altName, p2.brand as altBrand from paints p
    inner join paints p2 on p2.id in (
        select ptpr.alt_paint_id from paint_to_paint_rel ptpr
        where p.id = ptpr.paint_id
    )
    where p.id = $1
    `
    const {rows} = await client.query(queryText, [req.params.id])
    res.send({statusCode: 200, body: rows})
})
 
startDatabase()
const PORT = process.env.PORT || 9090
app.listen(PORT)

async function startDatabase() {
    await client.connect()
}
