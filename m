Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7431F6914
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 14:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfKJNSP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 08:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfKJNSP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 08:18:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C2D20842;
        Sun, 10 Nov 2019 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573391893;
        bh=ttNsqtlhC3s9gNi3Yvjbbb3tMaYzWGEMq+w2YH8wkXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SfEmjbTXYeNxiSQtQNVdWAbCoG3pWrx48WyloHkbA1//k6U8upiBBK+aVLub82JP/
         EEIHmkt4o7hmZRjJzRTZB4HQW//tT9a/VTVEYNa21vt81gUqv8vv9DdkJXFUCsqSgm
         02o7mrAhqxDOy49AR+3q7NkiJ4KcZAnMpq6323W4=
Date:   Sun, 10 Nov 2019 13:18:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 14/17] iio: cros_ec: Remove pm function
Message-ID: <20191110131805.2b592b3b@archlinux>
In-Reply-To: <20191105222652.70226-15-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-15-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Nov 2019 14:26:49 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Since cros_ec_sensorhub is shutting down the FIFO when the device
> suspends, no need to slow down the EC sampling period rate.
> It was necesseary to do that before command CMD_FIFO_INT_ENABLE was
> introduced, but now all supported chromebooks have it.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> No changes in v4, v3.
> New in v2.
> 
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |  1 -
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  1 -
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 47 -------------------
>  drivers/iio/light/cros_ec_light_prox.c        |  1 -
>  .../linux/iio/common/cros_ec_sensors_core.h   |  5 --
>  5 files changed, 55 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> index e30a59fcf0f9..af801e203623 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -127,7 +127,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
>  static struct platform_driver cros_ec_lid_angle_platform_driver = {
>  	.driver = {
>  		.name	= DRV_NAME,
> -		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_lid_angle_probe,
>  	.id_table	= cros_ec_lid_angle_ids,
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 62a0dd970988..9d0b8ad7a0a5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -315,7 +315,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
>  static struct platform_driver cros_ec_sensors_platform_driver = {
>  	.driver = {
>  		.name	= "cros-ec-sensors",
> -		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_sensors_probe,
>  	.id_table	= cros_ec_sensors_ids,
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 904cd26dd31f..879b69527cae 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -723,52 +723,5 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
>  
> -static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> -
> -	if (st->curr_sampl_freq == 0)
> -		return 0;
> -
> -	/*
> -	 * If the sensors are sampled at high frequency, we will not be able to
> -	 * sleep. Set sampling to a long period if necessary.
> -	 */
> -	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> -		mutex_lock(&st->cmd_lock);
> -		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> -		st->param.ec_rate.data = CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY;
> -		cros_ec_motion_send_host_cmd(st, 0);
> -		mutex_unlock(&st->cmd_lock);
> -	}
> -	return 0;
> -}
> -
> -static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> -
> -	if (st->curr_sampl_freq == 0)
> -		return;
> -
> -	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> -		mutex_lock(&st->cmd_lock);
> -		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> -		st->param.ec_rate.data = st->curr_sampl_freq;
> -		cros_ec_motion_send_host_cmd(st, 0);
> -		mutex_unlock(&st->cmd_lock);
> -	}
> -}
> -
> -const struct dev_pm_ops cros_ec_sensors_pm_ops = {
> -#ifdef CONFIG_PM_SLEEP
> -	.prepare = cros_ec_sensors_prepare,
> -	.complete = cros_ec_sensors_complete
> -#endif
> -};
> -EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
> -
>  MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 698b2ee81ebf..ccdc6d8958c6 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -256,7 +256,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
>  static struct platform_driver cros_ec_light_prox_platform_driver = {
>  	.driver = {
>  		.name	= "cros-ec-light-prox",
> -		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_light_prox_probe,
>  	.id_table	= cros_ec_light_prox_ids,
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index b8f573ca9dcc..96ea4551945e 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -30,9 +30,6 @@ enum {
>   */
>  #define CROS_EC_SAMPLE_SIZE  (sizeof(s64) * 2)
>  
> -/* Minimum sampling period to use when device is suspending */
> -#define CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY 1000  /* 1 second */
> -
>  typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
>  
>  /**
> @@ -117,8 +114,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask);
>  
> -extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
> -
>  /* List of extended channel specification for all sensors */
>  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
>  

