Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87EE320BC9
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBUQjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:39:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhBUQjN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:39:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F8564E2E;
        Sun, 21 Feb 2021 16:38:30 +0000 (UTC)
Date:   Sun, 21 Feb 2021 16:38:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH 2/5] iio: adc: palmas_gpadc: Replace indio_dev->mlock
 with own device lock
Message-ID: <20210221163826.10ba97be@archlinux>
In-Reply-To: <20200928131333.36646-2-mircea.caprioru@analog.com>
References: <20200928131333.36646-1-mircea.caprioru@analog.com>
        <20200928131333.36646-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 16:13:30 +0300
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

Thanks,

Jonathan

> ---
>  drivers/iio/adc/palmas_gpadc.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 889b88768b63..14874f11614d 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -90,6 +90,12 @@ static struct palmas_gpadc_info palmas_gpadc_info[] = {
>   *			3: 800 uA
>   * @extended_delay:	enable the gpadc extended delay mode
>   * @auto_conversion_period:	define the auto_conversion_period
> + * @lock:	Lock to protect the device state during a potential concurrent
> + *		read access from userspace. Reading a raw value requires a sequence
> + *		of register writes, then a wait for a completion callback,
> + *		and finally a register read, during which userspace could issue
> + *		another read request. This lock protects a read access from
> + *		ocurring before another one has finished.
>   *
>   * This is the palmas_gpadc structure to store run-time information
>   * and pointers for this driver instance.
> @@ -110,6 +116,7 @@ struct palmas_gpadc {
>  	bool				wakeup1_enable;
>  	bool				wakeup2_enable;
>  	int				auto_conversion_period;
> +	struct mutex			lock;
>  };
>  
>  /*
> @@ -388,7 +395,7 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
>  	if (adc_chan > PALMAS_ADC_CH_MAX)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&adc->lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -414,12 +421,12 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
>  		goto out;
>  	}
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&adc->lock);
>  	return ret;
>  
>  out:
>  	palmas_gpadc_read_done(adc, adc_chan);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&adc->lock);
>  
>  	return ret;
>  }
> @@ -516,6 +523,9 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  	adc->dev = &pdev->dev;
>  	adc->palmas = dev_get_drvdata(pdev->dev.parent);
>  	adc->adc_info = palmas_gpadc_info;
> +
> +	mutex_init(&adc->lock);
> +
>  	init_completion(&adc->conv_completion);
>  	dev_set_drvdata(&pdev->dev, indio_dev);
>  

