Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BF14FE9A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBBRZL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 12:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgBBRZL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 12:25:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB5020658;
        Sun,  2 Feb 2020 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580664309;
        bh=QFx6XAEnnx3HFShS5F8gddxgaI14tq5oojl9WOovMTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ssxlXcIguXyhwJ0EB9pYHRVRNABhxs+ndgIUISyrLOEsWRn7tjtsLJ0qvwMUqrgFh
         tm1EQzoe6e0tZDLJJ1Ob6ZHmcA8iLqjmX1/eXVuY5K/+W2Xt8qpGODgPnw68tWu+ld
         RzxvTkxUxM8TpFGNvyxGzY+0Hcfeqd0yexpOXt5o=
Date:   Sun, 2 Feb 2020 17:25:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, rpi-receiver@htl-steyr.ac.at,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: srf04: add power management feature
Message-ID: <20200202172505.4af0f6ef@archlinux>
In-Reply-To: <20200120164540.GA8725@arbad>
References: <20200120164540.GA8725@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jan 2020 17:45:41 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add suspend and resume operations for being used by optional power
> management.
> 
> The suspend function is switching off an GPIO which can be used by the
> hardware to switch power off. The resume function is switching the GPIO
> on and sleeps an adjustable time to give the device a chance to be up
> and running.
> 
> If activated the driver gets into autosuspend after some time of
> inactivity.
> 
> Suggested-by: Franz Parzer <rpi-receiver@htl-steyr.ac.at>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/srf04.c | 96 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 01eb8cc63076..568b76e06385 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -45,6 +45,7 @@
>  #include <linux/sched.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> @@ -56,6 +57,7 @@ struct srf04_data {
>  	struct device		*dev;
>  	struct gpio_desc	*gpiod_trig;
>  	struct gpio_desc	*gpiod_echo;
> +	struct gpio_desc	*gpiod_power;
>  	struct mutex		lock;
>  	int			irqnr;
>  	ktime_t			ts_rising;
> @@ -63,6 +65,7 @@ struct srf04_data {
>  	struct completion	rising;
>  	struct completion	falling;
>  	const struct srf04_cfg	*cfg;
> +	int			startup_time_ms;
>  };
>  
>  static const struct srf04_cfg srf04_cfg = {
> @@ -97,6 +100,9 @@ static int srf04_read(struct srf04_data *data)
>  	u64 dt_ns;
>  	u32 time_ns, distance_mm;
>  
> +	if (data->gpiod_power)
> +		pm_runtime_get_sync(data->dev);
> +
>  	/*
>  	 * just one read-echo-cycle can take place at a time
>  	 * ==> lock against concurrent reading calls
> @@ -110,6 +116,11 @@ static int srf04_read(struct srf04_data *data)
>  	udelay(data->cfg->trigger_pulse_us);
>  	gpiod_set_value(data->gpiod_trig, 0);
>  
> +	if (data->gpiod_power) {
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
> +	}
> +
>  	/* it should not take more than 20 ms until echo is rising */
>  	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);
>  	if (ret < 0) {
> @@ -268,6 +279,22 @@ static int srf04_probe(struct platform_device *pdev)
>  		return PTR_ERR(data->gpiod_echo);
>  	}
>  
> +	data->gpiod_power = devm_gpiod_get_optional(dev, "power",
> +								GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_power)) {
> +		dev_err(dev, "failed to get power-gpios: err=%ld\n",
> +						PTR_ERR(data->gpiod_power));
> +		return PTR_ERR(data->gpiod_power);
> +	}
> +	if (data->gpiod_power) {
> +
> +		if (of_property_read_u32(dev->of_node, "startup-time-ms",
> +						&data->startup_time_ms))
> +			data->startup_time_ms = 100;
> +		dev_dbg(dev, "using power gpio: startup-time-ms=%d\n",
> +							data->startup_time_ms);
> +	}
> +
>  	if (gpiod_cansleep(data->gpiod_echo)) {
>  		dev_err(data->dev, "cansleep-GPIOs not supported\n");
>  		return -ENODEV;
> @@ -296,14 +323,81 @@ static int srf04_probe(struct platform_device *pdev)
>  	indio_dev->channels = srf04_chan_spec;
>  	indio_dev->num_channels = ARRAY_SIZE(srf04_chan_spec);
>  
> -	return devm_iio_device_register(dev, indio_dev);
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(data->dev, "iio_device_register: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (data->gpiod_power) {
> +		pm_runtime_set_autosuspend_delay(data->dev, 1000);
> +		pm_runtime_use_autosuspend(data->dev);
> +
> +		ret = pm_runtime_set_active(data->dev);
> +		if (ret) {
> +			dev_err(data->dev, "pm_runtime_set_active: %d\n", ret);
> +			iio_device_unregister(indio_dev);
> +		}
> +
> +		pm_runtime_enable(data->dev);
> +		pm_runtime_idle(data->dev);
> +	}
> +
> +	return ret;
>  }
>  
> +static int srf04_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct srf04_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	if (data->gpiod_power) {
> +		pm_runtime_disable(data->dev);
> +		pm_runtime_set_suspended(data->dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused srf04_pm_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct srf04_data *data = iio_priv(indio_dev);
> +
> +	gpiod_set_value(data->gpiod_power, 0);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused srf04_pm_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct srf04_data *data = iio_priv(indio_dev);
> +
> +	gpiod_set_value(data->gpiod_power, 1);
> +	msleep(data->startup_time_ms);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops srf04_pm_ops = {
> +	SET_RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> +				srf04_pm_runtime_resume, NULL)
> +};
> +
>  static struct platform_driver srf04_driver = {
>  	.probe		= srf04_probe,
> +	.remove		= srf04_remove,
>  	.driver		= {
>  		.name		= "srf04-gpio",
>  		.of_match_table	= of_srf04_match,
> +		.pm		= &srf04_pm_ops,
>  	},
>  };
>  

