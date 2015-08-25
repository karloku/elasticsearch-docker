# 介绍
开发环境所用 Elasticsearch 的 Dockerfile, 包括 ik 分词器和 es-head 插件, 以及400万条分词词库

# 使用
docker run --name es-devel -p 9201:9200 -p 9301:9300 -d karloku/elasticsearch-devel