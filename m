Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089703FB35D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 11:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhH3JsK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 05:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235733AbhH3JsJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 05:48:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CA16103C;
        Mon, 30 Aug 2021 09:47:15 +0000 (UTC)
Date:   Mon, 30 Aug 2021 10:50:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: accel: fxls8962af: add wake on event
Message-ID: <20210830105028.0da90628@jic23-huawei>
In-Reply-To: <20210830081032.267891-2-sean@geanix.com>
References: <20210830081032.267891-1-sean@geanix.com>
        <20210830081032.267891-2-sean@geanix.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Aug 2021 10:10:32 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> This adds ways for the SoC to wake from accelerometer wake events.
> 
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
> 
> If buffered reads are enabled they will be deactivated before suspend.
> As the onboard buffer is only holding up to 32 12-bit X/Y/Z data
> triplets.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
lgtm

J
> ---
> Changes since v1:
>  - Fixed comments fron Andy (Thanks)
> 
>  drivers/iio/accel/fxls8962af-core.c | 46 +++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index dd639420fb0f..ef0f6560953c 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -160,6 +160,7 @@ struct fxls8962af_data {
>  	} scan;
>  	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
>  	struct iio_mount_matrix orientation;
> +	int irq;
>  	u8 watermark;
>  	u8 enable_event;
>  	u16 lower_thres;
> @@ -1123,6 +1124,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  	data = iio_priv(indio_dev);
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
> +	data->irq = irq;
>  
>  	ret = iio_read_mount_matrix(dev, &data->orientation);
>  	if (ret)
> @@ -1192,6 +1194,9 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  	if (ret)
>  		return ret;
>  
> +	if (device_property_read_bool(dev, "wakeup-source"))
> +		device_init_wakeup(dev, true);
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
> @@ -1217,9 +1222,46 @@ static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
>  	return fxls8962af_active(data);
>  }
>  
> +static int __maybe_unused fxls8962af_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +	if (device_may_wakeup(dev) && data->enable_event) {
> +		enable_irq_wake(data->irq);
> +
> +		/*
> +		 * Disable buffer, as the buffer is so small the device will wake
> +		 * almost immediately.
> +		 */
> +		if (iio_buffer_enabled(indio_dev))
> +			fxls8962af_buffer_predisable(indio_dev);
> +	} else {
> +		fxls8962af_runtime_suspend(dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused fxls8962af_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +	if (device_may_wakeup(dev) && data->enable_event) {
> +		disable_irq_wake(data->irq);
> +
> +		if (iio_buffer_enabled(indio_dev))
> +			fxls8962af_buffer_postenable(indio_dev);
> +	} else {
> +		fxls8962af_runtime_resume(dev);
> +	}
> +
> +	return 0;
> +}
> +
>  const struct dev_pm_ops fxls8962af_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
>  	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
>  			   fxls8962af_runtime_resume, NULL)
>  };

