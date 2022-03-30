Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230F84EBD8D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Mar 2022 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbiC3JYM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Mar 2022 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiC3JYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Mar 2022 05:24:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D32AE0B
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 02:22:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so823231wms.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6nD/I4kMAKrtqDEqRY0M5yAOEN5U7/IDEqc6nl8dsQE=;
        b=WhmUMZcJlNyvp9GaS3eS2dmZlgPvM0A8M829EOkDwvb1RZq4PRuBuvwhdLJK6Yt3Uz
         cQfrMCTDEcybEbu1sVI+uFEVpW96hau4zUCF599xAzPy9QdHMD+7resniasNMwkg4I01
         qjUXS6h7HB6LqwkJ53mESZHi0wRbdpEGpaFAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6nD/I4kMAKrtqDEqRY0M5yAOEN5U7/IDEqc6nl8dsQE=;
        b=OwXBsYQ/gWDMM6kiicsygvpDHxqOcca6QR7bYyTMj9lITNu5LQ3PaDF04ECnWrO+Kn
         LcvzmuDswq8wFZ3Pb2e19by3Ze2653ifVRwm5kL28S0z3mOVGulrDelnyj4YiTDPTdaw
         TE32W5wnyPXFAp1T7qtLHAVHaG7s7Enk5Xmqrva8qOe5LZIQ/0/1kMADWMG4KlOdOjrK
         /tc7a7CAq0tM6ArPW6xIAqsGoJbXnQ3cJDRBpngh1inVH/ni/Zk7om88aZ7g8bwk0bm2
         2R7Hep2w+8YkzvpCV3T86b/tIHnV+8ERmNWuxR2TzqWelR9ZULDLR8nuGVspQJMy4u2v
         YAzA==
X-Gm-Message-State: AOAM532Ab/SlDL3Ctqp9cfk7Ri/9jPkrWgIE3fWrVevl3qACBzRYv1o0
        gEl7AMwJg0kZC2VaP9dSYwXSMQ==
X-Google-Smtp-Source: ABdhPJzGWB1LDAO/Hz2gcmh/frjW/+Is2Xz8GPTL1nfINGJb8XtPCpcE3mAtT5+0Y3SgFxlFYgkyXg==
X-Received: by 2002:a05:600c:1ca7:b0:38e:27a6:5546 with SMTP id k39-20020a05600c1ca700b0038e27a65546mr3463771wms.188.1648632144805;
        Wed, 30 Mar 2022 02:22:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c144a00b0038ccc75a6adsm4263403wmi.37.2022.03.30.02.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 02:22:24 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:22:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 12/12] Documentation: iio: Document high-speed DMABUF
 based API
Message-ID: <YkQhTvwJOh0+ooQp@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20220207125933.81634-1-paul@crapouillou.net>
 <20220207130140.81891-1-paul@crapouillou.net>
 <20220207130140.81891-2-paul@crapouillou.net>
 <YkLJU7Pp98CPIHfY@phenom.ffwll.local>
 <Z63I9R.MKYUKBH4V8L41@crapouillou.net>
 <YkMSmcQy1sKQJ5rJ@phenom.ffwll.local>
 <AUOI9R.I8SSZ2CC5S2W2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AUOI9R.I8SSZ2CC5S2W2@crapouillou.net>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 29, 2022 at 06:34:58PM +0100, Paul Cercueil wrote:
> 
> 
> Le mar., mars 29 2022 at 16:07:21 +0200, Daniel Vetter <daniel@ffwll.ch> a
> �crit :
> > On Tue, Mar 29, 2022 at 10:47:23AM +0100, Paul Cercueil wrote:
> > >  Hi Daniel,
> > > 
> > >  Le mar., mars 29 2022 at 10:54:43 +0200, Daniel Vetter
> > > <daniel@ffwll.ch> a
> > >  �crit :
> > >  > On Mon, Feb 07, 2022 at 01:01:40PM +0000, Paul Cercueil wrote:
> > >  > >  Document the new DMABUF based API.
> > >  > >
> > >  > >  v2: - Explicitly state that the new interface is optional and
> > > is
> > >  > >        not implemented by all drivers.
> > >  > >      - The IOCTLs can now only be called on the buffer FD
> > > returned by
> > >  > >        IIO_BUFFER_GET_FD_IOCTL.
> > >  > >      - Move the page up a bit in the index since it is core
> > > stuff
> > >  > > and not
> > >  > >        driver-specific.
> > >  > >
> > >  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  > >  ---
> > >  > >   Documentation/driver-api/dma-buf.rst |  2 +
> > >  > >   Documentation/iio/dmabuf_api.rst     | 94
> > >  > > ++++++++++++++++++++++++++++
> > >  > >   Documentation/iio/index.rst          |  2 +
> > >  > >   3 files changed, 98 insertions(+)
> > >  > >   create mode 100644 Documentation/iio/dmabuf_api.rst
> > >  > >
> > >  > >  diff --git a/Documentation/driver-api/dma-buf.rst
> > >  > > b/Documentation/driver-api/dma-buf.rst
> > >  > >  index 2cd7db82d9fe..d3c9b58d2706 100644
> > >  > >  --- a/Documentation/driver-api/dma-buf.rst
> > >  > >  +++ b/Documentation/driver-api/dma-buf.rst
> > >  > >  @@ -1,3 +1,5 @@
> > >  > >  +.. _dma-buf:
> > >  > >  +
> > >  > >   Buffer Sharing and Synchronization
> > >  > >   ==================================
> > >  > >
> > >  > >  diff --git a/Documentation/iio/dmabuf_api.rst
> > >  > > b/Documentation/iio/dmabuf_api.rst
> > >  > >  new file mode 100644
> > >  > >  index 000000000000..43bb2c1b9fdc
> > >  > >  --- /dev/null
> > >  > >  +++ b/Documentation/iio/dmabuf_api.rst
> > >  > >  @@ -0,0 +1,94 @@
> > >  > >  +===================================
> > >  > >  +High-speed DMABUF interface for IIO
> > >  > >  +===================================
> > >  > >  +
> > >  > >  +1. Overview
> > >  > >  +===========
> > >  > >  +
> > >  > >  +The Industrial I/O subsystem supports access to buffers
> > > through a
> > >  > > file-based
> > >  > >  +interface, with read() and write() access calls through the
> > > IIO
> > >  > > device's dev
> > >  > >  +node.
> > >  > >  +
> > >  > >  +It additionally supports a DMABUF based interface, where the
> > >  > > userspace
> > >  > >  +application can allocate and append DMABUF objects to the
> > > buffer's
> > >  > > queue.
> > >  > >  +This interface is however optional and is not available in all
> > >  > > drivers.
> > >  > >  +
> > >  > >  +The advantage of this DMABUF based interface vs. the read()
> > >  > >  +interface, is that it avoids an extra copy of the data
> > > between the
> > >  > >  +kernel and userspace. This is particularly useful for
> > > high-speed
> > >  > >  +devices which produce several megabytes or even gigabytes of
> > > data
> > >  > > per
> > >  > >  +second.
> > >  > >  +
> > >  > >  +The data in this DMABUF interface is managed at the
> > > granularity of
> > >  > >  +DMABUF objects. Reducing the granularity from byte level to
> > > block
> > >  > > level
> > >  > >  +is done to reduce the userspace-kernelspace synchronization
> > >  > > overhead
> > >  > >  +since performing syscalls for each byte at a few Mbps is just
> > > not
> > >  > >  +feasible.
> > >  > >  +
> > >  > >  +This of course leads to a slightly increased latency. For this
> > >  > > reason an
> > >  > >  +application can choose the size of the DMABUFs as well as how
> > > many
> > >  > > it
> > >  > >  +allocates. E.g. two DMABUFs would be a traditional double
> > > buffering
> > >  > >  +scheme. But using a higher number might be necessary to avoid
> > >  > >  +underflow/overflow situations in the presence of scheduling
> > >  > > latencies.
> > >  >
> > >  > So this reads a lot like reinventing io-uring with pre-registered
> > >  > O_DIRECT
> > >  > memory ranges. Except it's using dma-buf and hand-rolling a lot of
> > >  > pieces
> > >  > instead of io-uring and O_DIRECT.
> > > 
> > >  I don't see how io_uring would help us. It's an async I/O
> > > framework, does it
> > >  allow us to access a kernel buffer without copying the data? Does
> > > it allow
> > >  us to zero-copy the data to a network interface?
> > 
> > With networking, do you mean rdma, or some other kind of networking?
> > Anything else than rdma doesn't support dma-buf, and I don't think it
> > will
> > likely ever do so. Similar it's really tricky to glue dma-buf support
> > into
> > the block layer.
> 
> By networking I mean standard sockets. If I'm not mistaken, Jonathan Lemon's
> work on zctap was to add dma-buf import/export support to standard sockets.
> 
> > Wrt io_uring, yes it's async, but that's not the point. The point is
> > that
> > with io_uring you pre-register ranges for reads and writes to target,
> > which in combination with O_DIRECT, makes it effectively (and
> > efficient!)
> > zero-copy. Plus it has full integration with both networking and normal
> > file io, which dma-buf just doesn't have.
> > 
> > Like you _cannot_ do zero copy from a dma-buf into a normal file. You
> > absolutely can do the same with io_uring.
> 
> I believe io_uring does zero-copy the same way as splice(), by
> duplicating/moving pages? Because that wouldn't work with DMA coherent
> memory, which is contiguous and not backed by pages.

Yeah if your memory has to be contig and/or write-combined/uncached for
dma reasons, then we're much more firmly into dma-buf territory. But also
that means we really need dma-buf support in the networking stack, and
that might be a supreme challenge.

E.g. dma-buf is all about pre-registering memory (dma_buf_attach is
potentilly very expensive) for a specific device. With full generality
networking, none of this is possible since until you make the dynamic
decision to send stuff out, you might not even know the device the packets
go out on.

Also with filtering and everything cpu access is pretty much assumed, and
doing that with dma-buf is a bit a challenge.
-Daniel

> 
> > >  > At least if the entire justification for dma-buf support is
> > > zero-copy
> > >  > support between the driver and userspace it's _really_ not the
> > > right
> > >  > tool
> > >  > for the job. dma-buf is for zero-copy between devices, with cpu
> > > access
> > >  > from userpace (or kernel fwiw) being very much the exception (and
> > > often
> > >  > flat-out not supported at all).
> > > 
> > >  We want both. Using dma-bufs for the driver/userspace interface is a
> > >  convenience as we then have a unique API instead of two distinct
> > > ones.
> > > 
> > >  Why should CPU access from userspace be the exception? It works
> > > fine for IIO
> > >  dma-bufs. You keep warning about this being a terrible design, but
> > > I simply
> > >  don't see it.
> > 
> > It depends really on what you're trying to do, and there's extremely
> > high
> > chances it will simply not work.
> 
> Well it does work though. The userspace interface is stupidly simple here -
> one dma-buf, backed by DMA coherent memory, is enqueued for processing by
> the DMA. The userspace calling the "sync" ioctl on the dma-buf will block
> until the transfer is complete, and then userspace can access it again.
> 
> 
> > Unless you want to do zero copy with a gpu, or something which is in
> > that
> > ecosystem of accelerators and devices, then dma-buf is probably not what
> > you're looking for.
> > -Daniel
> 
> I want to do zero-copy between a IIO device and the network/USB, and right
> now there is absolutely nothing in place that allows me to do that. So I
> have to get creative.
> 
> Cheers,
> -Paul
> 
> > > 
> > >  > >  +
> > >  > >  +2. User API
> > >  > >  +===========
> > >  > >  +
> > >  > >  +``IIO_BUFFER_DMABUF_ALLOC_IOCTL(struct iio_dmabuf_alloc_req
> > > *)``
> > >  > >
> > > +----------------------------------------------------------------
> > >  > >  +
> > >  > >  +Each call will allocate a new DMABUF object. The return value
> > > (if
> > >  > > not
> > >  > >  +a negative errno value as error) will be the file descriptor
> > > of
> > >  > > the new
> > >  > >  +DMABUF.
> > >  > >  +
> > >  > >  +``IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *)``
> > >  > >  +--------------------------------------------------------
> > >  > >  +
> > >  > >  +Place the DMABUF object into the queue pending for hardware
> > >  > > process.
> > >  > >  +
> > >  > >  +These two IOCTLs have to be performed on the IIO buffer's file
> > >  > >  +descriptor, obtained using the `IIO_BUFFER_GET_FD_IOCTL`
> > > ioctl.
> > >  > >  +
> > >  > >  +3. Usage
> > >  > >  +========
> > >  > >  +
> > >  > >  +To access the data stored in a block by userspace the block
> > > must be
> > >  > >  +mapped to the process's memory. This is done by calling
> > > mmap() on
> > >  > > the
> > >  > >  +DMABUF's file descriptor.
> > >  > >  +
> > >  > >  +Before accessing the data through the map, you must use the
> > >  > >  +DMA_BUF_IOCTL_SYNC(struct dma_buf_sync *) ioctl, with the
> > >  > >  +DMA_BUF_SYNC_START flag, to make sure that the data is
> > > available.
> > >  > >  +This call may block until the hardware is done with this
> > > block.
> > >  > > Once
> > >  > >  +you are done reading or writing the data, you must use this
> > > ioctl
> > >  > > again
> > >  > >  +with the DMA_BUF_SYNC_END flag, before enqueueing the DMABUF
> > > to the
> > >  > >  +kernel's queue.
> > >  > >  +
> > >  > >  +If you need to know when the hardware is done with a DMABUF,
> > > you
> > >  > > can
> > >  > >  +poll its file descriptor for the EPOLLOUT event.
> > >  > >  +
> > >  > >  +Finally, to destroy a DMABUF object, simply call close() on
> > > its
> > >  > > file
> > >  > >  +descriptor.
> > >  > >  +
> > >  > >  +For more information about manipulating DMABUF objects, see:
> > >  > > :ref:`dma-buf`.
> > >  > >  +
> > >  > >  +A typical workflow for the new interface is:
> > >  > >  +
> > >  > >  +    for block in blocks:
> > >  > >  +      DMABUF_ALLOC block
> > >  > >  +      mmap block
> > >  > >  +
> > >  > >  +    enable buffer
> > >  > >  +
> > >  > >  +    while !done
> > >  > >  +      for block in blocks:
> > >  > >  +        DMABUF_ENQUEUE block
> > >  > >  +
> > >  > >  +        DMABUF_SYNC_START block
> > >  > >  +        process data
> > >  > >  +        DMABUF_SYNC_END block
> > >  > >  +
> > >  > >  +    disable buffer
> > >  > >  +
> > >  > >  +    for block in blocks:
> > >  > >  +      close block
> > >  > >  diff --git a/Documentation/iio/index.rst
> > >  > > b/Documentation/iio/index.rst
> > >  > >  index 58b7a4ebac51..669deb67ddee 100644
> > >  > >  --- a/Documentation/iio/index.rst
> > >  > >  +++ b/Documentation/iio/index.rst
> > >  > >  @@ -9,4 +9,6 @@ Industrial I/O
> > >  > >
> > >  > >      iio_configfs
> > >  > >
> > >  > >  +   dmabuf_api
> > >  > >  +
> > >  > >      ep93xx_adc
> > >  > >  --
> > >  > >  2.34.1
> > >  > >
> > >  >
> > >  > --
> > >  > Daniel Vetter
> > >  > Software Engineer, Intel Corporation
> > >  > http://blog.ffwll.ch
> > > 
> > > 
> > 
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
