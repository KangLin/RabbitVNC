/* Copyright (C) 2002-2005 RealVNC Ltd.  All Rights Reserved.
 * 
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this software; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307,
 * USA.
 */

//
// ZlibInStream streams from a compressed data stream ("underlying"),
// decompressing with zlib on the fly.
//

#ifndef __RDR_ZLIBINSTREAM_H__
#define __RDR_ZLIBINSTREAM_H__

#include <rdr/BufferedInStream.h>

struct z_stream_s;

namespace rdr {

  class ZlibInStream : public BufferedInStream {

  public:
    ZlibInStream();
    virtual ~ZlibInStream();

    void setUnderlying(InStream* is, size_t bytesIn);
    void flushUnderlying();
    void reset();

  private:
    void init();
    void deinit();

    virtual bool fillBuffer(size_t maxSize);

  private:
    InStream* underlying;
    z_stream_s* zs;
    size_t bytesIn;
  };

} // end of namespace rdr

#endif
