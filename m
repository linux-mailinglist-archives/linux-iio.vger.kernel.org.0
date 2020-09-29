Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8315127D389
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgI2QXm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 12:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgI2QXl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 12:23:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1067221548;
        Tue, 29 Sep 2020 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601396621;
        bh=LdBtfC8GVlPycb+DDCNGugGOm5JDifRZwYM4+DBP2e0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jPmf6qMM4ipXwBDXsHWqITED0ALNcz2r4jdOLCCVF7Vq7i8rWAMYW4h2Fspkh23lz
         EYbGpB6gDcm11gTYA32RwlHkV50WWO2KdeAxrD+GbLF25ZDKsETV2i7BcLo/+4CDUu
         i2OfE7Kda+TOGn1PZCS9ywrra2r3jmISuX81fDQw=
Date:   Tue, 29 Sep 2020 17:23:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH 5/5] iio: adc: rockchip_saradc: Replace indio_dev->mlock
 with own device lock
Message-ID: <20200929172329.778ab2c6@archlinux>
In-Reply-To: <20200928131333.36646-5-mircea.caprioru@analog.com>
References: <20200928131333.36646-1-mircea.caprioru@analog.com>
        <20200928131333.36646-5-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 16:13:33 +0300
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

Another driver with buffered support which means we need to think
harder about what is going on with these locks.

> ---
>  drivers/iio/adc/rockchip_saradc.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1f3d7d639d37..80084c526cc6 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -53,6 +53,15 @@ struct rockchip_saradc {
>  	const struct rockchip_saradc_data *data;
>  	u16			last_val;
>  	const struct iio_chan_spec *last_chan;
> +	 /*
> +	  * Lock to protect the device state during a potential concurrent
> +	  * read access from userspace. Reading a raw value requires a sequence
> +	  * of register writes, then a wait for a completion callback,
> +	  * and finally a register read, during which userspace could issue
> +	  * another read request. This lock protects a read access from
> +	  * ocurring before another one has finished.
> +	  */
> +	struct mutex		lock;
>  };
>  
>  static void rockchip_saradc_power_down(struct rockchip_saradc *info)
> @@ -92,17 +101,17 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&info->lock);

Probably a case for iio_device_claim_direct_mode() as I doubt we want
to enter buffered mode when halfway through this.


>  
>  		ret = rockchip_saradc_conversion(info, chan);
>  		if (ret) {
>  			rockchip_saradc_power_down(info);
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);
>  			return ret;
>  		}
>  
>  		*val = info->last_val;
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&info->lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = regulator_get_voltage(info->vref);
> @@ -254,7 +263,7 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
>  	int ret;
>  	int i, j = 0;
>  
> -	mutex_lock(&i_dev->mlock);
> +	mutex_lock(&info->lock);
Hmm. I wonder what this was meant to protect?

I can't see why we need it if we are claiming direct mode correctly above.

>  
>  	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
>  		const struct iio_chan_spec *chan = &i_dev->channels[i];
> @@ -271,7 +280,7 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
>  
>  	iio_push_to_buffers_with_timestamp(i_dev, &data, iio_get_time_ns(i_dev));
>  out:
> -	mutex_unlock(&i_dev->mlock);
> +	mutex_unlock(&info->lock);
>  
>  	iio_trigger_notify_done(i_dev->trig);
>  
> @@ -332,6 +341,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  		info->reset = NULL;
>  	}
>  
> +	mutex_init(&info->lock);
> +
>  	init_completion(&info->completion);
>  
>  	irq = platform_get_irq(pdev, 0);

