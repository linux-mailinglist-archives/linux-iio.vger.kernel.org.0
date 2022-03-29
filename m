Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0654EA967
	for <lists+linux-iio@lfdr.de>; Tue, 29 Mar 2022 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiC2IfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Mar 2022 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiC2IfV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2022 04:35:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D515AAFA
        for <linux-iio@vger.kernel.org>; Tue, 29 Mar 2022 01:33:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so992681wmp.5
        for <linux-iio@vger.kernel.org>; Tue, 29 Mar 2022 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=an4yi95NWUJ9vdfubXa4o7OLSmBUdmTSmO+lpoU9caY=;
        b=F43INBPcC5vRzzbxc8D+H4OoGiyyOqLzBfWQrR6cpJvhga/EUYqiLUFMULT+SX5wu0
         qtPeh+mY8NpqAyjkyuxlFIyzdIvisj+VC/zt6ZDFafTiYByktf2a/N6kge+ZPecEjJMN
         c/WoMMtwfmiGKbaumyguHGYxtinOxnjo0ac5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=an4yi95NWUJ9vdfubXa4o7OLSmBUdmTSmO+lpoU9caY=;
        b=JK/uNZcBEJWFiI0JTozU6MBWLzAzvRun5xfZF8OXScykknMpIGkV7fduHNA7H0m8Hd
         LuF/vTjGzYq9C8WKxE6P1QYT+CSuJeUxR0ZvFQpVlEV3GY/Hka2CUlrhXI5NeIkYTOPG
         O7v2a2s2A2fRG8Q+RF6UwDH6UFS2m77wvuVYn+60QRN/m349q/QciYTVcWK0+QA++viQ
         n3hVKEmMXXVHPNkRjD1QIJktm1aT5qX5LoIFXrM3xNlopRgPQzbOdxE3DK/Ta5IUvxLZ
         6xi827ThGRWnffXZQbWOWiSNLFnok3uHtlcPDPRq01/ZbwlrCYtLakxCYTcRF+IOfmbn
         Q5NQ==
X-Gm-Message-State: AOAM531xhBefk1GvpwJ/r/pUNaXGNVGOvk5oTOBcPW+jzLda2Nii+Aus
        J024Quekhb422tMpumEcgM57bA==
X-Google-Smtp-Source: ABdhPJyq12cPHviwdu6GfWLAzr9FpplfeSQWQrp5Vs5dyxxFM7cg+QYaILgh3GJFF9HnV5mfJUNEpw==
X-Received: by 2002:a1c:2544:0:b0:381:18a:a46d with SMTP id l65-20020a1c2544000000b00381018aa46dmr5467015wml.26.1648542814691;
        Tue, 29 Mar 2022 01:33:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q2-20020adff502000000b00203f17d73dbsm14021596wro.12.2022.03.29.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:33:34 -0700 (PDT)
Date:   Tue, 29 Mar 2022 10:33:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 00/12] iio: buffer-dma: write() and new DMABUF based
 API
Message-ID: <YkLEXJzs8ukrxG8s@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20220207125933.81634-1-paul@crapouillou.net>
 <20220213184616.669b490b@jic23-huawei>
 <N8XC7R.5FP2M8552CGT3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <N8XC7R.5FP2M8552CGT3@crapouillou.net>
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

On Tue, Feb 15, 2022 at 05:43:35PM +0000, Paul Cercueil wrote:
> Hi Jonathan,
> 
> Le dim., févr. 13 2022 at 18:46:16 +0000, Jonathan Cameron
> <jic23@kernel.org> a écrit :
> > On Mon,  7 Feb 2022 12:59:21 +0000
> > Paul Cercueil <paul@crapouillou.net> wrote:
> > 
> > >  Hi Jonathan,
> > > 
> > >  This is the V2 of my patchset that introduces a new userspace
> > > interface
> > >  based on DMABUF objects to complement the fileio API, and adds
> > > write()
> > >  support to the existing fileio API.
> > 
> > Hi Paul,
> > 
> > It's been a little while. Perhaps you could summarize the various view
> > points around the appropriateness of using DMABUF for this?
> > I appreciate it is a tricky topic to distil into a brief summary but
> > I know I would find it useful even if no one else does!
> 
> So we want to have a high-speed interface where buffers of samples are
> passed around between IIO devices and other devices (e.g. USB or network),
> or made available to userspace without copying the data.
> 
> DMABUF is, at least in theory, exactly what we need. Quoting the
> documentation
> (https://www.kernel.org/doc/html/v5.15/driver-api/dma-buf.html):
> "The dma-buf subsystem provides the framework for sharing buffers for
> hardware (DMA) access across multiple device drivers and subsystems, and for
> synchronizing asynchronous hardware access. This is used, for example, by
> drm “prime” multi-GPU support, but is of course not limited to GPU use
> cases."
> 
> The problem is that right now DMABUF is only really used by DRM, and to
> quote Daniel, "dma-buf looks like something super generic and useful, until
> you realize that there's a metric ton of gpu/accelerator bagage piled in".
> 
> Still, it seems to be the only viable option. We could add a custom
> buffer-passing interface, but that would mean implementing the same
> buffer-passing interface on the network and USB stacks, and before we know
> it we re-invented DMABUFs.

dma-buf also doesn't support sharing with network and usb stacks, so I'm a
bit confused why exactly this is useful?

So yeah unless there's some sharing going on with gpu stuff (for data
processing maybe) I'm not sure this makes a lot of sense really. Or at
least some zero-copy sharing between drivers, but even that would
minimally require a dma-buf import ioctl of some sorts. Which I either
missed or doesn't exist.

If there's none of that then just hand-roll your buffer handling code
(xarray is cheap to use in terms of code for this), you can always add
dma-buf import/export later on when the need arises.

Scrolling through patches you only have dma-buf export, but no importing,
so the use-case that works is with one of the existing subsystems that
supporting dma-buf importing.

I think minimally we need the use-case (in form of code) that needs the
buffer sharing here.
-Daniel

> Cheers,
> -Paul
> 
> 
> > > 
> > >  Changes since v1:
> > > 
> > >  - the patches that were merged in v1 have been (obviously) dropped
> > > from
> > >    this patchset;
> > >  - the patch that was setting the write-combine cache setting has
> > > been
> > >    dropped as well, as it was simply not useful.
> > >  - [01/12]:
> > >      * Only remove the outgoing queue, and keep the incoming queue,
> > > as we
> > >        want the buffer to start streaming data as soon as it is
> > > enabled.
> > >      * Remove IIO_BLOCK_STATE_DEQUEUED, since it is now functionally
> > > the
> > >        same as IIO_BLOCK_STATE_DONE.
> > >  - [02/12]:
> > >      * Fix block->state not being reset in
> > >        iio_dma_buffer_request_update() for output buffers.
> > >      * Only update block->bytes_used once and add a comment about
> > > why we
> > >        update it.
> > >      * Add a comment about why we're setting a different state for
> > > output
> > >        buffers in iio_dma_buffer_request_update()
> > >      * Remove useless cast to bool (!!) in iio_dma_buffer_io()
> > >  - [05/12]:
> > >      Only allow the new IOCTLs on the buffer FD created with
> > >      IIO_BUFFER_GET_FD_IOCTL().
> > >  - [12/12]:
> > >      * Explicitly state that the new interface is optional and is
> > >        not implemented by all drivers.
> > >      * The IOCTLs can now only be called on the buffer FD returned by
> > >        IIO_BUFFER_GET_FD_IOCTL.
> > >      * Move the page up a bit in the index since it is core stuff
> > > and not
> > >        driver-specific.
> > > 
> > >  The patches not listed here have not been modified since v1.
> > > 
> > >  Cheers,
> > >  -Paul
> > > 
> > >  Alexandru Ardelean (1):
> > >    iio: buffer-dma: split iio_dma_buffer_fileio_free() function
> > > 
> > >  Paul Cercueil (11):
> > >    iio: buffer-dma: Get rid of outgoing queue
> > >    iio: buffer-dma: Enable buffer write support
> > >    iio: buffer-dmaengine: Support specifying buffer direction
> > >    iio: buffer-dmaengine: Enable write support
> > >    iio: core: Add new DMABUF interface infrastructure
> > >    iio: buffer-dma: Use DMABUFs instead of custom solution
> > >    iio: buffer-dma: Implement new DMABUF based userspace API
> > >    iio: buffer-dmaengine: Support new DMABUF based userspace API
> > >    iio: core: Add support for cyclic buffers
> > >    iio: buffer-dmaengine: Add support for cyclic buffers
> > >    Documentation: iio: Document high-speed DMABUF based API
> > > 
> > >   Documentation/driver-api/dma-buf.rst          |   2 +
> > >   Documentation/iio/dmabuf_api.rst              |  94 +++
> > >   Documentation/iio/index.rst                   |   2 +
> > >   drivers/iio/adc/adi-axi-adc.c                 |   3 +-
> > >   drivers/iio/buffer/industrialio-buffer-dma.c  | 610
> > > ++++++++++++++----
> > >   .../buffer/industrialio-buffer-dmaengine.c    |  42 +-
> > >   drivers/iio/industrialio-buffer.c             |  60 ++
> > >   include/linux/iio/buffer-dma.h                |  38 +-
> > >   include/linux/iio/buffer-dmaengine.h          |   5 +-
> > >   include/linux/iio/buffer_impl.h               |   8 +
> > >   include/uapi/linux/iio/buffer.h               |  30 +
> > >   11 files changed, 749 insertions(+), 145 deletions(-)
> > >   create mode 100644 Documentation/iio/dmabuf_api.rst
> > > 
> > 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
