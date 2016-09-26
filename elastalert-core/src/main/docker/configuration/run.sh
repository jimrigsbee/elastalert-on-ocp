#!/usr/bin/env bash

###
# #%L
# GarethHealy :: Elastoplast :: Rule1
# %%
# Copyright (C) 2013 - 2016 Gareth Healy
# %%
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# #L%
###

cd $ELASTALERT_HOME \
    && elastalert-create-index --index elastalert_status --old-index "" \
    && python -m elastalert.elastalert --verbose --rule rule-definition.yaml --start $(date --iso-8601)T00:00:00 --debug


