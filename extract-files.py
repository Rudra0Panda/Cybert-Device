#!/usr/bin/env -S PYTHONPATH=/home/rudra/android-extract/tools/extract-utils:../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/motorola/cybert',
]

module = ExtractUtilsModule(
    'cybert',
    'motorola',
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
