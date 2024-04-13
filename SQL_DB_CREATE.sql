USE master;
GO

CREATE DATABASE test_memory ON
(NAME = test_data,
    FILENAME = 'F:\my_story\pot\SQLmemory\test_memory_data_dat.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
(NAME = test_log,
    FILENAME = 'F:\my_story\pot\SQLmemory\test_memory_data_log.ldf',
    SIZE = 5 MB,
    MAXSIZE = 25 MB,
    FILEGROWTH = 5 MB);
GO