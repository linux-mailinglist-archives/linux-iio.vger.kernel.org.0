Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A55CCB20
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfJEQaZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 12:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbfJEQaZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 12:30:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59CFE20862;
        Sat,  5 Oct 2019 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570293023;
        bh=RjId2eFUhdEkkPxQZVw2HxNbbdsYUHqf1ZzcLPC/eGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DC8Z7Fpj16jjvjnoNTphEdmhVthG2ZxIqV0xk1EiMtyhYeyDfZfvggmWUznrOD/s0
         /3RHml599SRB8uCoIBluJXzyzQ0O1Snhh5GFoE2fyEVSVhSKgIj64Da+o2L5LjyxMw
         KAplz6B6WmunA0ybIxBc8YzvXVYvXLT2ydkrOCTc=
Date:   Sat, 5 Oct 2019 17:30:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/13] iio: cros_ec: Use triggered buffer only when EC
 does not support FIFO
Message-ID: <20191005173017.23751aac@archlinux>
In-Reply-To: <20190922175021.53449-11-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-11-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:18 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> When EC supports FIFO, the samples will flow from the kernel by
> themselves.
> When no FIFO, the user space app needs to call trigger_new, or better
> register a high precision timer.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Trivial comments inline.

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  8 +--
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |  2 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  8 +--
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 61 +++++++++++++++++--
>  drivers/iio/light/cros_ec_light_prox.c        |  8 +--
>  drivers/iio/pressure/cros_ec_baro.c           |  8 +--
>  .../linux/iio/common/cros_ec_sensors_core.h   | 16 ++++-
>  7 files changed, 80 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 591c0d962c44..d607fbc52c95 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -179,7 +179,8 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> +			cros_ec_sensors_capture, cros_ec_sensors_push_data);
>  	if (ret)
>  		return ret;
>  
> @@ -199,11 +200,6 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  		state->sign[CROS_EC_SENSOR_Z] = -1;
>  	}
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> -			cros_ec_sensors_capture, NULL);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> index 1dcc2a16ab2d..e30a59fcf0f9 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -97,7 +97,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index a88dd8deade9..b78a942ac8e5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -239,7 +239,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> +			cros_ec_sensors_capture, cros_ec_sensors_push_data);
>  	if (ret)
>  		return ret;
>  
> @@ -301,11 +302,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  	else
>  		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> -			cros_ec_sensors_capture, NULL);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 43eb1d42820e..c4c37c6df301 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -12,6 +12,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
> @@ -83,15 +84,50 @@ static void get_default_min_max_freq(enum motionsensor_type type,
>  	}
>  }
>  
> +int cros_ec_sensors_push_data(
> +		struct iio_dev *indio_dev,
> +		s16 *data,
> +		s64 timestamp)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	s16 *out;
> +	unsigned int i;
> +
> +	/*
> +	 * It can happen if we get a samples before the iio device is fully
> +	 * registered.
> +	 */
> +	if (!st)
> +		return 0;
> +
> +	/* Ignore samples if the buffer is not set. */
> +	if (!indio_dev->active_scan_mask)

Odd test.  That tests if the core has created the bitmask.
Is the intent to check if any bits are enabled?

> +		return 0;
> +
> +	out = (s16 *)st->samples;
> +	for_each_set_bit(i,
> +			 indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		*out = data[i];
> +		out++;
> +	}

blank line.

> +	iio_push_to_buffers_with_timestamp(indio_dev, st->samples, timestamp);

blank line.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
> +
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev,
> -			      bool physical_device)
> +			      bool physical_device,
> +			      cros_ec_sensors_capture_t trigger_capture,
> +			      cros_ec_sensorhub_push_data_cb_t push_data)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
>  	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
>  	struct cros_ec_dev *ec = sensor_hub->ec;
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> +	struct iio_buffer *buffer;
>  	u32 ver_mask;
>  	int ret, i;
>  
> @@ -124,8 +160,6 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	indio_dev->name = pdev->name;
>  
>  	if (physical_device) {
> -		indio_dev->modes = INDIO_DIRECT_MODE;
> -
>  		state->param.cmd = MOTIONSENSE_CMD_INFO;
>  		state->param.info.sensor_num = sensor_platform->sensor_num;
>  		ret = cros_ec_motion_send_host_cmd(state, 0);
> @@ -154,9 +188,26 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			state->frequencies[2] =
>  			    state->resp->info_3.max_frequency;
>  		}
> -	}
>  
> -	return 0;
> +		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> +			buffer = devm_iio_kfifo_allocate(dev);
> +			if (!buffer)
> +				return -ENOMEM;
> +
> +			iio_device_attach_buffer(indio_dev, buffer);
> +			indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> +			ret = cros_ec_sensorhub_register_push_data(
> +					sensor_hub,
> +					sensor_platform->sensor_num,
> +					indio_dev, push_data);
> +		} else {
> +			indio_dev->modes = INDIO_DIRECT_MODE;
> +			ret = devm_iio_triggered_buffer_setup(
> +					dev, indio_dev, NULL,
> +					trigger_capture, NULL);
> +		}
> +	}
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
>  
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index c431e4d1482d..d58f010880ce 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -186,7 +186,8 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> +			cros_ec_sensors_capture, cros_ec_sensors_push_data);
>  	if (ret)
>  		return ret;
>  
> @@ -245,11 +246,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  
>  	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> -					      cros_ec_sensors_capture, NULL);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 2f4d6d3ab41d..c7538e93d24f 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -134,7 +134,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> +			cros_ec_sensors_capture, cros_ec_sensors_push_data);
>  	if (ret)
>  		return ret;
>  
> @@ -180,11 +181,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  
>  	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> -					      cros_ec_sensors_capture, NULL);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index abef66d0e884..60f78f0e4884 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -12,6 +12,7 @@
>  #include <linux/irqreturn.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_ec_sensorhub.h>
>  
>  enum {
>  	CROS_EC_SENSOR_X,
> @@ -32,6 +33,9 @@ enum {
>  /* Minimum sampling period to use when device is suspending */
>  #define CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY 1000  /* 1 second */
>  
> +typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
> +
> +
>  /**
>   * struct cros_ec_sensors_core_state - state data for EC sensors IIO driver
>   * @ec:				cros EC device structure
> @@ -110,11 +114,17 @@ struct platform_device;
>   * @pdev:		platform device created for the sensors
>   * @indio_dev:		iio device structure of the device
>   * @physical_device:	true if the device refers to a physical device
> + * @trigger_capture:    function pointer to call buffer is triggered,
> + *    for backward compatibility.
> + * @push_data:          function to call when cros_ec_sensorhub receives
> + *    a sample for that sensor.
>   *
>   * Return: 0 on success, -errno on failure.
>   */
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
> -			      struct iio_dev *indio_dev, bool physical_device);
> +			      struct iio_dev *indio_dev, bool physical_device,
> +			      cros_ec_sensors_capture_t trigger_capture,
> +			      cros_ec_sensorhub_push_data_cb_t push_data);
>  
>  /* To remove association of physical device to cros_ec_sensorhub. */
>  int cros_ec_sensors_core_clean(struct platform_device *pdev);
> @@ -132,6 +142,10 @@ int cros_ec_sensors_core_clean(struct platform_device *pdev);
>   * Return: IRQ_HANDLED
>   */
>  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
> +int cros_ec_sensors_push_data(
> +		struct iio_dev *indio_dev,
> +		s16 *data,
> +		s64 timestamp);
>  
>  /**
>   * cros_ec_motion_send_host_cmd() - send motion sense host command

