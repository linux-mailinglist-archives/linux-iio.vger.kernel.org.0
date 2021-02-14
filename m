Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1743131B144
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 17:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBNQdf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 11:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhBNQde (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 11:33:34 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0A160232;
        Sun, 14 Feb 2021 16:32:52 +0000 (UTC)
Date:   Sun, 14 Feb 2021 16:32:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [RFC PATCH 0/5] iio: buffer: add output buffer and cyclic mode
Message-ID: <20210214163248.03d19fe1@archlinux>
In-Reply-To: <20210212102021.47276-1-alexandru.ardelean@analog.com>
References: <20210212102021.47276-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 12:20:16 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Largely, an adaptation of Lars' work, applied on the IIO multi-buffer
> support + high-speed/mmap support [1].
> Found here:
>   https://github.com/larsclausen/linux/commits/iio-high-speed-5.10
> But this isn't tested.
> 
> [1] Requires that these sets be applied (in this order):
> * https://lore.kernel.org/linux-iio/20210211122452.78106-1-alexandru.ardelean@analog.com/T/#t
> * https://lore.kernel.org/linux-iio/20210212101143.18993-1-alexandru.ardelean@analog.com/T/#t
> 
> Some of the variation from the original work are:
> 1. It's applied on top of the multibuffer support; so the direction of the
>    data is set per iio_buffer, and not iio_dev
> 2. Cyclic mode is a separate patch
> 3. devm_iio_dmaengine_buffer_alloc() requires the definition of
>    'enum iio_buffer_direction'; which means that 'linux/iio/buffer.h'
>    needs to be included in  buffer-dma.h; Lars tried to use a bool, but
>    using the enum seems a bit more consistent and allows us to maybe
>    go down the route of both I/O buffers (some day); not sure if
>    that's sane or not (you never know)
> 4. Various re-formatting; and added some docstrings where I remembered
>    to so so

Just thinking about how this is different from input buffers.
For now at least I guess we can assume there is no equivalent of multiple
consumers and the mux logic needed to support them.
However I can definitely see we may get inkernel 'consumers' of these
output buffers.

Come to think of it, we probably need to rework the inkern logic anyway
to deal with multiple buffer input devices.  Hopefully it just continues
working with the single buffer cases so there won't be any regressions
on that front.

Largest issue with this series is lack of users.  It all seems good
in principal but until drivers are making use of it, I'm not keen
on merging this extra infrastructure.

Jonathan

> 
> Lars-Peter Clausen (5):
>   iio: Add output buffer support
>   iio: kfifo-buffer: Add output buffer support
>   iio: buffer-dma: Allow to provide custom buffer ops
>   iio: buffer-dma: Add output buffer support
>   iio: buffer-dma: add support for cyclic DMA transfers
> 
>  drivers/iio/adc/adi-axi-adc.c                 |   5 +-
>  drivers/iio/buffer/industrialio-buffer-dma.c  | 120 ++++++++++++++++--
>  .../buffer/industrialio-buffer-dmaengine.c    |  57 +++++++--
>  drivers/iio/buffer/kfifo_buf.c                |  50 ++++++++
>  drivers/iio/industrialio-buffer.c             | 110 +++++++++++++++-
>  include/linux/iio/buffer-dma.h                |  11 +-
>  include/linux/iio/buffer-dmaengine.h          |   7 +-
>  include/linux/iio/buffer.h                    |   7 +
>  include/linux/iio/buffer_impl.h               |  11 ++
>  include/uapi/linux/iio/buffer.h               |   1 +
>  10 files changed, 348 insertions(+), 31 deletions(-)
> 

