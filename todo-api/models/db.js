
module.exports.params = {
  dbname: process.env.TODO_DB_NAME,
  username: process.env.TODO_DB_USER,
  password: process.env.TODO_DB_PASSWORD,
  params: {
      host: process.env.TODO_DB_SERVICE_HOST,
      port: process.env.TODO_DB_SERVICE_PORT,
      dialect: 'mysql'
  }
};
