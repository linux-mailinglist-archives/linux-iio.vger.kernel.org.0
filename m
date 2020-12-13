Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE182D8E1F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 16:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLMPFc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 10:05:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgLMPFc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 10:05:32 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F9223121;
        Sun, 13 Dec 2020 15:04:50 +0000 (UTC)
Date:   Sun, 13 Dec 2020 15:04:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        linus.walleij@linaro.org, denis.ciocca@st.com
Subject: Re: [PATCH v3] iio: common: st_sensors: fix possible infinite loop
 in st_sensors_irq_thread
Message-ID: <20201213150447.119eec7c@archlinux>
In-Reply-To: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
References: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  8 Dec 2020 15:36:40 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Return a boolean value in st_sensors_new_samples_available routine in
> order to avoid an infinite loop in st_sensors_irq_thread if
> stat_drdy.addr is not defined or stat_drdy read fails
> 
> Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

One trivial inline. Note I'm looking for an Ack form Dennis on this one
as it may result in a some breakage if any devices are using
edge interrupts.

It's possible we would be better falling back to interrupt free support
in that case rather than failing to probe at all.
I think that would be best done by moving the check out to the
various per type drivers so we fail in the same fashion as no irq
provided + a warning.

thanks,

Jonathan


> ---
> Changes since v2:
> - return -EOPNOTSUPP if the drv requests edge IRQ and the sensor does not support
>   status register
> 
> Changes since v1:
> - return true if the sensor does not have stat_drdy register
> ---
>  .../common/st_sensors/st_sensors_trigger.c    | 31 ++++++++++---------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 0507283bd4c1..2dbd2646e44e 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -23,35 +23,31 @@
>   * @sdata: Sensor data.
>   *
>   * returns:
> - * 0 - no new samples available
> - * 1 - new samples available
> - * negative - error or unknown
> + * false - no new samples available or read error
> + * true - new samples available
>   */
> -static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> -					    struct st_sensor_data *sdata)
> +static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
> +					     struct st_sensor_data *sdata)
>  {
>  	int ret, status;
>  
>  	/* How would I know if I can't check it? */
>  	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> -		return -EINVAL;
> +		return true;
>  
>  	/* No scan mask, no interrupt */
>  	if (!indio_dev->active_scan_mask)
> -		return 0;
> +		return false;
>  
>  	ret = regmap_read(sdata->regmap,
>  			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
>  			  &status);
>  	if (ret < 0) {
>  		dev_err(sdata->dev, "error checking samples available\n");
> -		return ret;
> +		return false;
>  	}
>  
> -	if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> -		return 1;
> -
> -	return 0;
> +	return !!(status & sdata->sensor_settings->drdy_irq.stat_drdy.mask);

No need for the !! as you can rely on type conversion to a boolean.

>  }
>  
>  /**
> @@ -180,9 +176,15 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  
>  	/* Tell the interrupt handler that we're dealing with edges */
>  	if (irq_trig == IRQF_TRIGGER_FALLING ||
> -	    irq_trig == IRQF_TRIGGER_RISING)
> +	    irq_trig == IRQF_TRIGGER_RISING) {
> +		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
> +			dev_err(&indio_dev->dev,
> +				"edge IRQ not supported w/o stat register.\n");
> +			err = -EOPNOTSUPP;
> +			goto iio_trigger_free;
> +		}
>  		sdata->edge_irq = true;
> -	else
> +	} else {
>  		/*
>  		 * If we're not using edges (i.e. level interrupts) we
>  		 * just mask off the IRQ, handle one interrupt, then
> @@ -190,6 +192,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  		 * interrupt handler top half again and start over.
>  		 */
>  		irq_trig |= IRQF_ONESHOT;
> +	}
>  
>  	/*
>  	 * If the interrupt pin is Open Drain, by definition this

