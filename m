Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A931E97FB
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgEaN4S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaN4S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:56:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FFD820723;
        Sun, 31 May 2020 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590933377;
        bh=RV6TbQ6h25IfccTD8ik/iZmat9Uu37lD+/JKgn1oWe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wtt9tEWXO5Lkg9AB4Gv3hL84lJMxvq5713jcnZzSjJiNVbKLc5AiHoYrzmYl4rMe8
         GEMl+AKDQ0CYefc6mxn2B5x2RdeS/alxT48tAXsLNUcqeNZpb+tQ/HEEzan8cr1qjy
         aj3tKhGCa3jFJoDyQTNzql+bguGSyGBjh73VIvLw=
Date:   Sun, 31 May 2020 14:56:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     groeck@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Reapply range at resume
Message-ID: <20200531145613.353e4fbd@archlinux>
In-Reply-To: <20200527043517.240123-1-gwendal@chromium.org>
References: <20200527043517.240123-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 21:35:17 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> EC does not currently preserve range across sensor reinit.
> If sensor is powered down at suspend, it will default to the EC default
> range at resume, not the range set by the host.
> 
> Save range if modified, and apply at resume.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
one minor moan inline, but not important.

Applied to the togreg branch of iio.git and pushed out as testing.

There would be some logic to applying this as a fix and to stable.
If you like me to do that, let me know.

Thanks,

Jonathan

> ---
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  5 +++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 21 +++++++++++++++++++
>  drivers/iio/light/cros_ec_light_prox.c        |  6 +++++-
>  drivers/iio/pressure/cros_ec_baro.c           |  8 +++++--
>  .../linux/iio/common/cros_ec_sensors_core.h   | 11 +++++++++-
>  5 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index a66941fdb3855..130ab8ce0269b 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -200,6 +200,10 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
>  		st->core.param.sensor_range.roundup = 1;
>  
>  		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret == 0) {
> +			st->core.range_updated = true;
> +			st->core.curr_range = val;
> +		}
>  		break;
>  	default:
>  		ret = cros_ec_sensors_core_write(
> @@ -315,6 +319,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
>  static struct platform_driver cros_ec_sensors_platform_driver = {
>  	.driver = {
>  		.name	= "cros-ec-sensors",
> +		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_sensors_probe,
>  	.id_table	= cros_ec_sensors_ids,
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index c831915ca7e56..cda459b612067 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -824,5 +824,26 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
>  
> +static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (st->range_updated) {
> +		mutex_lock(&st->cmd_lock);
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->param.sensor_range.data = st->curr_range;
> +		st->param.sensor_range.roundup = 1;
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
> +		mutex_unlock(&st->cmd_lock);
> +	}
> +	return ret;
> +}
> +
> +SIMPLE_DEV_PM_OPS(cros_ec_sensors_pm_ops, NULL, cros_ec_sensors_resume);
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
> +
>  MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 2198b50909ed0..fed79ba27fda5 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -145,8 +145,11 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> -		st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
> +		st->core.curr_range = (val << 16) | (val2 / 100);
> +		st->core.param.sensor_range.data = st->core.curr_range;
>  		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret == 0)
> +			st->core.range_updated = true;
>  		break;
>  	default:
>  		ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
> @@ -256,6 +259,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
>  static struct platform_driver cros_ec_light_prox_platform_driver = {
>  	.driver = {
>  		.name	= "cros-ec-light-prox",
> +		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_light_prox_probe,
>  	.id_table	= cros_ec_light_prox_ids,
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index c079b89600824..f0938b6fbba07 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -96,8 +96,11 @@ static int cros_ec_baro_write(struct iio_dev *indio_dev,
>  		/* Always roundup, so caller gets at least what it asks for. */
>  		st->core.param.sensor_range.roundup = 1;
>  
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0))
> -			ret = -EIO;
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret == 0) {
> +			st->core.range_updated = true;
> +			st->core.curr_range = val;
> +		}
>  		break;
>  	default:
>  		ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
> @@ -199,6 +202,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_baro_ids);
>  static struct platform_driver cros_ec_baro_platform_driver = {
>  	.driver = {
>  		.name	= "cros-ec-baro",
> +		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_baro_probe,
>  	.id_table	= cros_ec_baro_ids,
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 7bc961defa87e..caa8bb279a346 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -42,6 +42,10 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
>   * @resp:			motion sensor response structure
>   * @type:			type of motion sensor
>   * @loc:			location where the motion sensor is placed
> + * @range_updated:		True if the range of the sensor has been
> + *				updated.
> + * @curr_range:			If updated, the current range value.
> + *				It will be reapplied at every resume.
>   * @calib:			calibration parameters. Note that trigger
>   *				captured data will always provide the calibrated
>   *				data
> @@ -65,6 +69,9 @@ struct cros_ec_sensors_core_state {
>  	enum motionsensor_type type;
>  	enum motionsensor_location loc;
>  
> +	bool range_updated;
> +	int curr_range;
> +
>  	struct calib_data {
>  		s16 offset;
>  		u16 scale;
> @@ -114,7 +121,9 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask);
>  
> -/* List of extended channel specification for all sensors */
> +extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
> +
> +/* List of extended channel specification for all sensors. */

If I were being fussy... This change is unrelated and shouldn't be in this patch.

>  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
>  extern const struct attribute *cros_ec_sensor_fifo_attributes[];
>  

