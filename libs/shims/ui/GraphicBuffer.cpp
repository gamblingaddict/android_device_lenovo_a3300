/*
 * Copyright (C) 2016 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <string>
#include <stdint.h>
#include <cutils/native_handle.h>
#include <ui/GraphicBuffer.h>
#include <ui/Rect.h>

namespace android {

class GraphicBuffer;

extern "C" {
    void _ZN7android13GraphicBufferC1EjjijNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE(
        GraphicBuffer* self, uint32_t inWidth, uint32_t inHeight, int inFormat, uint32_t inUsage, std::string requestorName);

    void _ZN7android13GraphicBufferC1Ejjij(
        GraphicBuffer* self, uint32_t inWidth, uint32_t inHeight, int inFormat, uint32_t inUsage) {
        std::string requestorName = "<Unknown>";

        _ZN7android13GraphicBufferC1EjjijNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE(
            self, inWidth, inHeight, inFormat, inUsage, requestorName);
    }

    status_t _ZN7android13GraphicBuffer4lockEjPPvPiS3_(
        GraphicBuffer* self, uint32_t inUsage, void** vaddr, int32_t* outBytesPerPixel, int32_t* outBytesPerStride);

    status_t _ZN7android13GraphicBuffer4lockEjPPv(
        GraphicBuffer* self, uint32_t inUsage, void** vaddr) {
        return _ZN7android13GraphicBuffer4lockEjPPvPiS3_(
            self, inUsage, vaddr, nullptr, nullptr);
    }

    void _ZN7android13GraphicBufferC1EjjijjjP13native_handleb(
        GraphicBuffer* self, uint32_t inWidth, uint32_t inHeight, int inFormat, uint32_t inLayerCount, uint32_t inUsage, uint32_t inStride, native_handle_t* inHandle, bool keepOwnership);

    void _ZN7android13GraphicBufferC1EjjijjP13native_handleb(
        GraphicBuffer* self, uint32_t inWidth, uint32_t inHeight, int inFormat, uint32_t inUsage, uint32_t inStride, native_handle_t* inHandle, bool keepOwnership) {
        _ZN7android13GraphicBufferC1EjjijjjP13native_handleb(
            self, inWidth, inHeight, inFormat, 1, inUsage, inStride, inHandle, keepOwnership);
    }
} // extern "C"

} // namespace android