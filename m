Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3419F2568CB
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgH2Prj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgH2Prh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:47:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B668020707;
        Sat, 29 Aug 2020 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598716056;
        bh=LGAP59dQwGylPusZsYh7gM1kHwHis7GuGYkd+ggywxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aHZQFwjNaEedxWs3cGjVVgllXqdEgsuY4V/CzEf+w8hkohOcIVMQS3UFLr8mmYeiE
         N2FQMjNmLn4yBODLrYDicqaGFkI9uzkEL74ew3rygLvPmGRqwO2d9XqdHLUE+ePa/i
         4Sc7vOuSuFdMO6tBTF5YH4ShzwecCCXf9sMyblVc=
Date:   Sat, 29 Aug 2020 16:47:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ribalda@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH] iio: dac: ti-dac7612: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200829164733.2a79a1cc@archlinux>
In-Reply-To: <20200826064028.51540-1-alexandru.ardelean@analog.com>
References: <20200826064028.51540-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 09:40:28 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/dac/ti-dac7612.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
> index 07c9f39d54f1..34c2aec204ef 100644
> --- a/drivers/iio/dac/ti-dac7612.c
> +++ b/drivers/iio/dac/ti-dac7612.c
> @@ -21,6 +21,7 @@ struct dac7612 {
>  	struct spi_device *spi;
>  	struct gpio_desc *loaddacs;
>  	uint16_t cache[2];
> +	struct mutex lock;
Looks fine with the exception of my usual request for a comment explaining
lock scope.

Thanks,

Jonathan

>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -101,9 +102,9 @@ static int dac7612_write_raw(struct iio_dev *iio_dev,
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
> @@ -145,6 +146,8 @@ static int dac7612_probe(struct spi_device *spi)
>  	iio_dev->num_channels = ARRAY_SIZE(priv->cache);
>  	iio_dev->name = spi_get_device_id(spi)->name;
>  
> +	mutex_init(&priv->lock);
> +
>  	for (i = 0; i < ARRAY_SIZE(priv->cache); i++) {
>  		ret = dac7612_cmd_single(priv, i, 0);
>  		if (ret)

