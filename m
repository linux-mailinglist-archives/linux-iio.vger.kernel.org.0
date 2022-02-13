Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74A4B3CE6
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 19:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiBMSjn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Feb 2022 13:39:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiBMSjn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Feb 2022 13:39:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C3157B1C;
        Sun, 13 Feb 2022 10:39:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5946120F;
        Sun, 13 Feb 2022 18:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1936EC004E1;
        Sun, 13 Feb 2022 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644777576;
        bh=62G4pAU8FmHDbset5IKmCXHU7ITta7/U1Abf+yudxtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pwJQ1NO7br6owS38v9O55UrFNGA8LXTFnWMrfNKA9qbzqA4Mco85gRbDtaSkj48fu
         ciJf2jNVWazBul0qer4t6DTRsYXjBeaDtBNqtEJRlJI1sCBxFHdwUX4H7HPa8qq0wb
         VR3zjYrAGDR9zu5z/At01gwxCWTcFsvGjpZPB28PXAXZPnwLV0RaqDfXtBsUdp3clY
         yalK6rdNvJVbv+VwszApgUYBb5D539+KdNRrw8BchLVEk4BJB8howFwUWDdwd/LPY/
         6e0CrWvrSQeUdEwwHIu2lyjcCji7ecMw7eZfdrT4EqdItcUesBzaP0g8yue3huvwdY
         /glfHfZL2bnYg==
Date:   Sun, 13 Feb 2022 18:46:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 00/12] iio: buffer-dma: write() and new DMABUF based
 API
Message-ID: <20220213184616.669b490b@jic23-huawei>
In-Reply-To: <20220207125933.81634-1-paul@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Feb 2022 12:59:21 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> This is the V2 of my patchset that introduces a new userspace interface
> based on DMABUF objects to complement the fileio API, and adds write()
> support to the existing fileio API.

Hi Paul,

It's been a little while. Perhaps you could summarize the various view
points around the appropriateness of using DMABUF for this?
I appreciate it is a tricky topic to distil into a brief summary but
I know I would find it useful even if no one else does!

Thanks,

Jonathan

> 
> Changes since v1:
> 
> - the patches that were merged in v1 have been (obviously) dropped from
>   this patchset;
> - the patch that was setting the write-combine cache setting has been
>   dropped as well, as it was simply not useful.
> - [01/12]: 
>     * Only remove the outgoing queue, and keep the incoming queue, as we
>       want the buffer to start streaming data as soon as it is enabled.
>     * Remove IIO_BLOCK_STATE_DEQUEUED, since it is now functionally the
>       same as IIO_BLOCK_STATE_DONE.
> - [02/12]:
>     * Fix block->state not being reset in
>       iio_dma_buffer_request_update() for output buffers.
>     * Only update block->bytes_used once and add a comment about why we
>       update it.
>     * Add a comment about why we're setting a different state for output
>       buffers in iio_dma_buffer_request_update()
>     * Remove useless cast to bool (!!) in iio_dma_buffer_io()
> - [05/12]:
>     Only allow the new IOCTLs on the buffer FD created with
>     IIO_BUFFER_GET_FD_IOCTL().
> - [12/12]:
>     * Explicitly state that the new interface is optional and is
>       not implemented by all drivers.
>     * The IOCTLs can now only be called on the buffer FD returned by
>       IIO_BUFFER_GET_FD_IOCTL.
>     * Move the page up a bit in the index since it is core stuff and not
>       driver-specific.
> 
> The patches not listed here have not been modified since v1.
> 
> Cheers,
> -Paul
> 
> Alexandru Ardelean (1):
>   iio: buffer-dma: split iio_dma_buffer_fileio_free() function
> 
> Paul Cercueil (11):
>   iio: buffer-dma: Get rid of outgoing queue
>   iio: buffer-dma: Enable buffer write support
>   iio: buffer-dmaengine: Support specifying buffer direction
>   iio: buffer-dmaengine: Enable write support
>   iio: core: Add new DMABUF interface infrastructure
>   iio: buffer-dma: Use DMABUFs instead of custom solution
>   iio: buffer-dma: Implement new DMABUF based userspace API
>   iio: buffer-dmaengine: Support new DMABUF based userspace API
>   iio: core: Add support for cyclic buffers
>   iio: buffer-dmaengine: Add support for cyclic buffers
>   Documentation: iio: Document high-speed DMABUF based API
> 
>  Documentation/driver-api/dma-buf.rst          |   2 +
>  Documentation/iio/dmabuf_api.rst              |  94 +++
>  Documentation/iio/index.rst                   |   2 +
>  drivers/iio/adc/adi-axi-adc.c                 |   3 +-
>  drivers/iio/buffer/industrialio-buffer-dma.c  | 610 ++++++++++++++----
>  .../buffer/industrialio-buffer-dmaengine.c    |  42 +-
>  drivers/iio/industrialio-buffer.c             |  60 ++
>  include/linux/iio/buffer-dma.h                |  38 +-
>  include/linux/iio/buffer-dmaengine.h          |   5 +-
>  include/linux/iio/buffer_impl.h               |   8 +
>  include/uapi/linux/iio/buffer.h               |  30 +
>  11 files changed, 749 insertions(+), 145 deletions(-)
>  create mode 100644 Documentation/iio/dmabuf_api.rst
> 

