Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4C320BCD
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhBUQju (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhBUQjt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:39:49 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C727664DA5;
        Sun, 21 Feb 2021 16:39:06 +0000 (UTC)
Date:   Sun, 21 Feb 2021 16:39:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH 3/5] iio: adc: npcm_adc: Replace indio_dev->mlock with
 own device lock
Message-ID: <20210221163902.617ee71d@archlinux>
In-Reply-To: <20200928131333.36646-3-mircea.caprioru@analog.com>
References: <20200928131333.36646-1-mircea.caprioru@analog.com>
        <20200928131333.36646-3-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 16:13:31 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> This is part of a bigger cleanup.
> Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied,

thanks,

Jonathan

> ---
>  drivers/iio/adc/npcm_adc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index d9d105920001..f7bc0bb7f112 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -25,6 +25,15 @@ struct npcm_adc {
>  	wait_queue_head_t wq;
>  	struct regulator *vref;
>  	struct reset_control *reset;
> +	/*
> +	 * Lock to protect the device state during a potential concurrent
> +	 * read access from userspace. Reading a raw value requires a sequence
> +	 * of register writes, then a wait for a event and finally a register
> +	 * read, during which userspace could issue another read request.
> +	 * This lock protects a read access from ocurring before another one
> +	 * has finished.
> +	 */
> +	struct mutex lock;
>  };
>  
>  /* ADC registers */
> @@ -135,9 +144,9 @@ static int npcm_adc_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&info->lock);
>  		ret = npcm_adc_read(info, val, chan->channel);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&info->lock);
>  		if (ret) {
>  			dev_err(info->dev, "NPCM ADC read failed\n");
>  			return ret;
> @@ -187,6 +196,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	info = iio_priv(indio_dev);
>  
> +	mutex_init(&info->lock);
> +
>  	info->dev = &pdev->dev;
>  
>  	info->regs = devm_platform_ioremap_resource(pdev, 0);

