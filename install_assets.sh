#!/usr/bin/env bash
TF_VERSION=2.5

ASSETS_DIR="assets"
MODEL_FILENAME="text_classification.tflite"
VOCAB_FILENAME="text_classification_vocab.txt"

MODEL_URL="https://storage.googleapis.com/download.tensorflow.org/models/tflite/text_classification/${MODEL_FILENAME}"
VOCAB_URL="https://github.com/am15h/tflite_flutter_plugin/blob/master/example/assets/${VOCAB_FILENAME}"

download () {
    curl -o "${ASSETS_DIR}/$1" "$2"
}

download $MODEL_FILENAME $MODEL_URL
download $VOCAB_FILENAME $VOCAB_URL