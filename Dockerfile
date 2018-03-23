FROM ire7715/yarn-spark:h2.9.0-s2.3.0

RUN curl -s -o /tmp/scala-2.11.12.rpm https://downloads.lightbend.com/scala/2.11.12/scala-2.11.12.rpm && \
    yum install -y /tmp/scala-2.11.12.rpm

RUN yum install -y epel-release && \
    yum install -y python36 && \
    curl -s -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python36 /tmp/get-pip.py

RUN pip3 install jupyter && \
    pip3 install https://dist.apache.org/repos/dist/dev/incubator/toree/0.2.0-incubating-rc3/toree-pip/toree-0.2.0.tar.gz && \
    jupyter toree install --spark_home=/usr/local/spark --interpreters=Scala,PySpark

ENV PYTHONPATH=/usr/local/spark/python/:/usr/local/spark/python/lib/py4j-0.10.6-src.zip

RUN python /tmp/get-pip.py && \
    pip2.7 install numpy scipy scikit-learn pandas

RUN jupyter notebook --generate-config && \
    echo "c.Application.log_level = 'DEBUG'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = u'JUPYTER_AUTH_TOKEN'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.notebook_dir = '/data/jupyter'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.FileContentsManager.delete_to_trash = False" >> ~/.jupyter/jupyter_notebook_config.py && \
    mkdir /data/jupyter

COPY bootstrap.sh /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh"]
