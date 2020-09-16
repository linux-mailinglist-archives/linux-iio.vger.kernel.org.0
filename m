Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21F426C6A6
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgIPR5T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 13:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbgIPR5A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 13:57:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24ABB2076B;
        Wed, 16 Sep 2020 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600279018;
        bh=MFXxW7c8Bd47NDptWFKGNuuTjE0WLMwsmiiwIaLU27c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iVzt6wO1ZrzmxzRxgl8FR9z10nC/jnBKwZODl53vHEudpe2Fr7rHOPkEz4j9js8LK
         SOjKaHCYgcV7nCn1kdJHOm7ZSRC9P9quhinhRXS+16gMFpS3slfBFB7MS7vw+ZJG4t
         SCzvmrbaJwKMKsjtstOiDCe/Ku3Y8OUieoHg/Yi0=
Date:   Wed, 16 Sep 2020 18:56:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ribalda@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH v2] iio: dac: ti-dac7612: Replace indio_dev->mlock with
 own device lock
Message-ID: <20200916185655.4d1d7424@archlinux>
In-Reply-To: <20200916092535.76527-1-alexandru.ardelean@analog.com>
References: <20200826064028.51540-1-alexandru.ardelean@analog.com>
        <20200916092535.76527-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 12:25:35 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state from potential concurrent write
> accesses from userspace. The write operation requires an SPI write, then
> toggling of a GPIO, so the lock aims to protect the sanity of the entire
> sequence of operation.
> 
> This is part of a bigger cleanup.
> Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ti-dac7612.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
> index 07c9f39d54f1..4c0f4b5e9ff4 100644
> --- a/drivers/iio/dac/ti-dac7612.c
> +++ b/drivers/iio/dac/ti-dac7612.c
> @@ -22,6 +22,14 @@ struct dac7612 {
>  	struct gpio_desc *loaddacs;
>  	uint16_t cache[2];
>  
> +	/*
> +	 * Lock to protect the state of the device from potential concurrent
> +	 * write accesses from userspace. The write operation requires an
> +	 * SPI write, then toggling of a GPIO, so the lock aims to protect
> +	 * the sanity of the entire sequence of operation.
> +	 */
> +	struct mutex lock;
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -101,9 +109,9 @@ static int dac7612_write_raw(struct iio_dev *iio_dev,
>  	if (val == priv->cache[chan->channel])
>  		return 0;
>  
> -	mutex_lock(&iio_dev->mlock);
> +	mutex_lock(&priv->lock);
>  	ret = dac7612_cmd_single(priv, chan->channel, val);
> -	mutex_unlock(&iio_dev->mlock);
> +	mutex_unlock(&priv->lock);
>  
>  	return ret;
>  }
> @@ -145,6 +153,8 @@ static int dac7612_probe(struct spi_device *spi)
>  	iio_dev->num_channels = ARRAY_SIZE(priv->cache);
>  	iio_dev->name = spi_get_device_id(spi)->name;
>  
> +	mutex_init(&priv->lock);
> +
>  	for (i = 0; i < ARRAY_SIZE(priv->cache); i++) {
>  		ret = dac7612_cmd_single(priv, i, 0);
>  		if (ret)

