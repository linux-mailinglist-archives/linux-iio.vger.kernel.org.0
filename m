Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325BA320BC7
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBUQiM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:38:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhBUQiK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:38:10 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5177764E61;
        Sun, 21 Feb 2021 16:37:27 +0000 (UTC)
Date:   Sun, 21 Feb 2021 16:37:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH 1/5] iio: adc: spear_adc: Replace indio_dev->mlock with
 own device lock
Message-ID: <20210221163723.53d8c7a8@archlinux>
In-Reply-To: <20200928131333.36646-1-mircea.caprioru@analog.com>
References: <20200928131333.36646-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 16:13:29 +0300
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

I guess I was waiting for a v2 of the series.  Seeing as it has been a while
and the first 3 patches are fine on their own, I'll pick them up now.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/spear_adc.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index 1bc986a7009d..d93e580b3dc5 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -75,6 +75,15 @@ struct spear_adc_state {
>  	struct adc_regs_spear6xx __iomem *adc_base_spear6xx;
>  	struct clk *clk;
>  	struct completion completion;
> +	/*
> +	 * Lock to protect the device state during a potential concurrent
> +	 * read access from userspace. Reading a raw value requires a sequence
> +	 * of register writes, then a wait for a completion callback,
> +	 * and finally a register read, during which userspace could issue
> +	 * another read request. This lock protects a read access from
> +	 * ocurring before another one has finished.
> +	 */
> +	struct mutex lock;
>  	u32 current_clk;
>  	u32 sampling_freq;
>  	u32 avg_samples;
> @@ -146,7 +155,7 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  
>  		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
>  			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
> @@ -159,7 +168,7 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
>  		wait_for_completion(&st->completion); /* set by ISR */
>  		*val = st->value;
>  
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  
>  		return IIO_VAL_INT;
>  
> @@ -187,7 +196,7 @@ static int spear_adc_write_raw(struct iio_dev *indio_dev,
>  	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	if ((val < SPEAR_ADC_CLK_MIN) ||
>  	    (val > SPEAR_ADC_CLK_MAX) ||
> @@ -199,7 +208,7 @@ static int spear_adc_write_raw(struct iio_dev *indio_dev,
>  	spear_adc_set_clk(st, val);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  }
>  
> @@ -271,6 +280,9 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	st = iio_priv(indio_dev);
> +
> +	mutex_init(&st->lock);
> +
>  	st->np = np;
>  
>  	/*

