#!/bin/bash

set -e

zip -r results . -i '*.bam' -i '*.bai'

