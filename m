Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C32B2E63
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNQU0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKNQU0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:20:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0AAF2073C;
        Sat, 14 Nov 2020 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605370825;
        bh=c7//lZptrSCn5Tc3/y0soyXRAxiju3ZoN96GftmNXNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H9KP2loE1tBpLco1nWQ1MS5AAi53VtKv+ivKHdNt5zUawXRFRt2oYeCGyzltNxCa6
         h665Jqhqna1RirQLYGNKFbeEA5QISGGAYhwv0sAFL1BR2zmhOX8GIehCCybh41qba0
         v47CosCdslLVTsVEsPXvl6wk+jX4N1olqCcf6qWw=
Date:   Sat, 14 Nov 2020 16:20:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexandru.tachici@analog.com>, <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: ad_sigma_delta: Don't put SPI transfer buffer
 on the stack
Message-ID: <20201114162021.3caebdab@archlinux>
In-Reply-To: <20201113094059.152651-1-alexandru.ardelean@analog.com>
References: <20201112091050.84991-1-alexandru.ardelean@analog.com>
        <20201113094059.152651-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 11:40:59 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Use a heap allocated memory for the SPI transfer buffer. Using stack memory
> can corrupt stack memory when using DMA on some systems.
> 
> This change moves the buffer from the stack of the trigger handler call to
> the heap of the buffer of the state struct. The size increases takes into
> account the alignment for the timestamp, which is 8 bytes.
> So the buffer is put at an offset of 8 bytes.
> 
> Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

There are neater options for solving this problem - see inline.

In particular I don't think you have a problem with setting the
rx and tx buffers to use the same memory.

> ---
> 
> Changelog v1 -> v2:
> * bumped the buffer on state struct to 24 bytes
> * increased the offset to 8 bytes to account for the timestamp alignment
> 
>  drivers/iio/adc/ad_sigma_delta.c       | 2 +-
>  include/linux/iio/adc/ad_sigma_delta.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 86039e9ecaca..9f730c9d6aaa 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -395,9 +395,9 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +	uint8_t *data = &sigma_delta->data[8];
>  	unsigned int reg_size;
>  	unsigned int data_reg;
> -	uint8_t data[16];
>  
>  	memset(data, 0x00, 16);
>  
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index a3a838dcf8e4..8fb74755f873 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -80,7 +80,7 @@ struct ad_sigma_delta {
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
>  	 */

If you do end up with something like this, it needs a clear explanation of 'why'
the size is 24 bytes.  No good just having it in the patch description.

> -	uint8_t				data[4] ____cacheline_aligned;
> +	uint8_t				data[24] ____cacheline_aligned;

This is downright confusing.  I'd just split the buffer into tx and rx
parts.   The first (doesn't matter which) needs to be marked __cacheline_aligned.
If the rx is second mark it __aligned(8) to force that to be appropriate for
the timestamp.

Or... (I haven't checked thoroughly for this from point of view of how it is used
in the drivers) use the same buffer for tx and rx.  That is supposed to be safe for
SPI drivers though wonderfully there is a ? after the statement of that in
include/linux/spi.h.  I think that is just pointing out that microwire doesn't
support duplex rather than saying it's invalid in general...



>  };
>  
>  static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,

