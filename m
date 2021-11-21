Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7651E45858A
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbhKURtj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 21 Nov 2021 12:49:39 -0500
Received: from aposti.net ([89.234.176.197]:37180 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238269AbhKURti (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 12:49:38 -0500
Date:   Sun, 21 Nov 2021 17:46:21 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 15/15] Documentation: iio: Document high-speed DMABUF
 based API
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Message-Id: <91OX2R.MG3TG0PKKKRK3@crapouillou.net>
In-Reply-To: <20211121151026.0cc95f40@jic23-huawei>
References: <20211115141925.60164-1-paul@crapouillou.net>
        <20211115142243.60605-1-paul@crapouillou.net>
        <20211115142243.60605-4-paul@crapouillou.net>
        <20211121151026.0cc95f40@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le dim., nov. 21 2021 at 15:10:26 +0000, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> On Mon, 15 Nov 2021 14:22:43 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  Document the new DMABUF based API.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> Hi Paul,
> 
> A few trivial things inline but looks good to me if we do end up 
> using DMABUF
> anyway.
> 
> Jonathan
> 
>>  ---
>>   Documentation/driver-api/dma-buf.rst |  2 +
>>   Documentation/iio/dmabuf_api.rst     | 94 
>> ++++++++++++++++++++++++++++
>>   Documentation/iio/index.rst          |  2 +
>>   3 files changed, 98 insertions(+)
>>   create mode 100644 Documentation/iio/dmabuf_api.rst
>> 
>>  diff --git a/Documentation/driver-api/dma-buf.rst 
>> b/Documentation/driver-api/dma-buf.rst
>>  index 2cd7db82d9fe..d3c9b58d2706 100644
>>  --- a/Documentation/driver-api/dma-buf.rst
>>  +++ b/Documentation/driver-api/dma-buf.rst
>>  @@ -1,3 +1,5 @@
>>  +.. _dma-buf:
>>  +
> 
> Why this change?

I have this line in the file:
For more information about manipulating DMABUF objects, see: 
:ref:`dma-buf`.

For the :ref: to work I need a label at the reference point, if I 
understood correctly.

>>   Buffer Sharing and Synchronization
>>   ==================================
>> 
>>  diff --git a/Documentation/iio/dmabuf_api.rst 
>> b/Documentation/iio/dmabuf_api.rst
>>  new file mode 100644
>>  index 000000000000..b4e120a4ef0c
>>  --- /dev/null
>>  +++ b/Documentation/iio/dmabuf_api.rst
>>  @@ -0,0 +1,94 @@
>>  +===================================
>>  +High-speed DMABUF interface for IIO
>>  +===================================
>>  +
>>  +1. Overview
>>  +===========
>>  +
>>  +The Industrial I/O subsystem supports access to buffers through a 
>> file-based
>>  +interface, with read() and write() access calls through the IIO 
>> device's dev
>>  +node.
>>  +
>>  +It additionally supports a DMABUF based interface, where the 
>> userspace
>>  +application can allocate and append DMABUF objects to the buffer's 
>> queue.
> 
> I would note somewhere that this interface is optional for a given 
> IIO driver.
> I don't want people to start assuming their i2c ADC will support this 
> and
> wondering why it doesn't work :)

Their I2C ADC will support it, as long as the driver supports the 
dmaengine buffer interface. I can make that explicit, yes.

>>  +
>>  +The advantage of this DMABUF based interface vs. the fileio
>>  +interface, is that it avoids an extra copy of the data between the
>>  +kernel and userspace. This is particularly userful for high-speed
>>  +devices which produce several megabytes or even gigabytes of data 
>> per
>>  +second.
>>  +
>>  +The data in this DMABUF interface is managed at the granularity of
>>  +DMABUF objects. Reducing the granularity from byte level to block 
>> level
>>  +is done to reduce the userspace-kernelspace synchronization 
>> overhead
>>  +since performing syscalls for each byte at a few Mbps is just not
>>  +feasible.
>>  +
>>  +This of course leads to a slightly increased latency. For this 
>> reason an
>>  +application can choose the size of the DMABUFs as well as how many 
>> it
>>  +allocates. E.g. two DMABUFs would be a traditional double buffering
>>  +scheme. But using a higher number might be necessary to avoid
>>  +underflow/overflow situations in the presence of scheduling 
>> latencies.
>>  +
>>  +2. User API
>>  +===========
>>  +
>>  +``IIO_BUFFER_DMABUF_ALLOC_IOCTL(struct iio_dmabuf_alloc_req *)``
>>  +----------------------------------------------------------------
>>  +
>>  +Each call will allocate a new DMABUF object. The return value (if 
>> not
>>  +a negative errno value as error) will be the file descriptor of 
>> the new
>>  +DMABUF.
>>  +
>>  +``IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *)``
>>  +--------------------------------------------------------
>>  +
>>  +Place the DMABUF object into the queue pending for hardware 
>> process.
>>  +
>>  +These two IOCTLs have to be performed on the IIO buffer's file
>>  +descriptor (either opened from the corresponding /dev/iio:deviceX, 
>> or
>>  +obtained using the `IIO_BUFFER_GET_FD_IOCTL` ioctl).
>>  +
>>  +3. Usage
>>  +========
>>  +
>>  +To access the data stored in a block by userspace the block must be
>>  +mapped to the process's memory. This is done by calling mmap() on 
>> the
>>  +DMABUF's file descriptor.
>>  +
>>  +Before accessing the data through the map, you must use the
>>  +DMA_BUF_IOCTL_SYNC(struct dma_buf_sync *) ioctl, with the
>>  +DMA_BUF_SYNC_START flag, to make sure that the data is available.
>>  +This call may block until the hardware is done with this block. 
>> Once
>>  +you are done reading or writing the data, you must use this ioctl 
>> again
>>  +with the DMA_BUF_SYNC_END flag, before enqueueing the DMABUF to the
>>  +kernel's queue.
>>  +
>>  +If you need to know when the hardware is done with a DMABUF, you 
>> can
>>  +poll its file descriptor for the EPOLLOUT event.
>>  +
>>  +Finally, to destroy a DMABUF object, simply call close() on its 
>> file
>>  +descriptor.
>>  +
>>  +For more information about manipulating DMABUF objects, see: 
>> :ref:`dma-buf`.
>>  +
>>  +A typical workflow for the new interface is:
>>  +
>>  +    for block in blocks:
>>  +      DMABUF_ALLOC block
>>  +      mmap block
>>  +
>>  +    enable buffer
>>  +
>>  +    while !done
>>  +      for block in blocks:
>>  +        DMABUF_ENQUEUE block
>>  +
>>  +        DMABUF_SYNC_START block
>>  +        process data
>>  +        DMABUF_SYNC_END block
>>  +
>>  +    disable buffer
>>  +
>>  +    for block in blocks:
>>  +      close block
>>  diff --git a/Documentation/iio/index.rst 
>> b/Documentation/iio/index.rst
>>  index 58b7a4ebac51..9ce799fbf262 100644
>>  --- a/Documentation/iio/index.rst
>>  +++ b/Documentation/iio/index.rst
>>  @@ -10,3 +10,5 @@ Industrial I/O
>>      iio_configfs
>> 
>>      ep93xx_adc
>>  +
>>  +   dmabuf_api
> 
> Given this is core stuff rather than driver specific, perhaps move it 
> up a few lines?

Alright.

Cheers,
-Paul


