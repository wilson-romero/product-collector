const boom = require('@hapi/boom')

async function bodyDataHandler (req, res, next) {
    try {
        const { source, data } = req.body

        if (data === undefined) {
            throw new Error('The key <data> not exist')
        }

        if (!(data instanceof Array)) {
            throw new Error('The key <data> should be an Array')
        }

        if (data.length === 0) {
            throw new Error('<data> is an empty array')
        }

        if (source === undefined) {
            throw new Error('The key <source> not exist')
        }

        if (!(typeof source === 'string')) {
            throw new Error('The key <source> should be an String')
        }
    } catch (error) {
        console.error(error)
        return next(boom.badData(error.message))
    }
    next()
}

module.exports = bodyDataHandler
