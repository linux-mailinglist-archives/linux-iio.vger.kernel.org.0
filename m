Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0179339F1A
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCMQ32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 11:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhCMQ3N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 11:29:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8815164ECE;
        Sat, 13 Mar 2021 16:29:12 +0000 (UTC)
Date:   Sat, 13 Mar 2021 16:29:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan.Cameron@huawei.com, alexandru.ardelean@analog.com,
        groeck@chromium.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: cros: unify hw fifo attributes without API
 changes
Message-ID: <20210313162909.24e60cdf@archlinux>
In-Reply-To: <20210311014114.3917453-1-gwendal@chromium.org>
References: <20210311014114.3917453-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Mar 2021 17:41:14 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")

I'm lost on what the purpose of this patch is.  Could you describe how the
above 2 patches broken the driver?

> 
> 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> - sensors send data a regular interval (accelerometer, gyro,
>   magnetomer, barometer, light sensor).
> - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> need to set buffer attributes.
> 
> 2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
> EC does not support FIFO, as there is no FIFO to manage.

Whilst true, that point is rather trivial as the non _ext() version
just calls that function with last parameter set to NULL.
I guess from a readability point of view, calling the non extended
version makes sense.

> 
> 3. Create a triggered buffer with devm_iio_triggered_buffer_setup_ext() when
> the EC support FIFO as it is the only clean way to set the
> buffer extended attributes.
> Add a slim trigger to be sure the samples can flow via callback from the
> EC FIFO to the IIO buffer.

There are some issues with doing that which make it somewhat fiddly (see inline).

Jonathan


> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v3:
> Remove Change-Id.
> 
> Changes since v2:
> Remove include of buffer_impl.
> Rebase on top of kernel/git/jic23/iio.git testing branch.
> 
> Changes since v1:
> Use a slim trigger when EC supports FIFO, to use
> devm_iio_triggered_buffer_setup_ext().
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |  3 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 56 ++++++++++++-------
>  drivers/iio/light/cros_ec_light_prox.c        |  3 +-
>  drivers/iio/pressure/cros_ec_baro.c           |  3 +-
>  .../linux/iio/common/cros_ec_sensors_core.h   |  3 +-
>  7 files changed, 41 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 8f1232c38e0d7..b6f3471b62dcf 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> -					cros_ec_sensors_capture, NULL, false);
> +					cros_ec_sensors_capture, NULL);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> index 752f59037715b..af801e203623e 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -97,8 +97,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL,
> -					NULL, false);
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index dee1191de7528..376a5b30010ae 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  
>  	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
>  					cros_ec_sensors_capture,
> -					cros_ec_sensors_push_data,
> -					true);
> +					cros_ec_sensors_push_data);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index f8824afe595e4..7b7a98922892d 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -12,6 +12,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
> @@ -240,7 +241,6 @@ static void cros_ec_sensors_core_clean(void *arg)
>   *    for backward compatibility.
>   * @push_data:          function to call when cros_ec_sensorhub receives
>   *    a sample for that sensor.
> - * @has_hw_fifo:	Set true if this device has/uses a HW FIFO
>   *
>   * Return: 0 on success, -errno on failure.
>   */
> @@ -248,8 +248,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev,
>  			      bool physical_device,
>  			      cros_ec_sensors_capture_t trigger_capture,
> -			      cros_ec_sensorhub_push_data_cb_t push_data,
> -			      bool has_hw_fifo)
> +			      cros_ec_sensorhub_push_data_cb_t push_data)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> @@ -329,19 +328,41 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		}
>  
>  		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> +			struct iio_trigger *trig;
> +
>  			/*
> -			 * Create a software buffer, feed by the EC FIFO.
> -			 * We can not use trigger here, as events are generated
> -			 * as soon as sample_frequency is set.
> +			 * Create a triggered buffer to be able to trigger data
> +			 * gathering manually, but by default, samples come from
> +			 * the EC FIFO.
>  			 */
> -			ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> -							  INDIO_BUFFER_SOFTWARE,
> -							  NULL);
> +			ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
> +					NULL, trigger_capture, NULL,
> +					cros_ec_sensor_fifo_attributes);
>  			if (ret)
>  				return ret;
>  
> -			ret = cros_ec_sensorhub_register_push_data(
> -					sensor_hub, sensor_platform->sensor_num,
> +			/*
> +			 * Register a trigger as plug to allow samples from the
> +			 * FIFO to flow.
> +			 * When cros-ec-sensor-ring is present, samples produced
> +			 * by the EC FIFO are directed to that ring only.
> +			 */
> +			trig = devm_iio_trigger_alloc(dev, "cros_ec%d-dev%d",
> +					sensor_platform->sensor_num, indio_dev->id);
> +			if (!trig)
> +				return -ENOMEM;
> +
> +			ret = devm_iio_trigger_register(dev, trig);
> +			if (ret < 0)
> +				return ret;
> +			indio_dev->trig = iio_trigger_get(trig);
Whilst this is a valid way of doing things, we normally only bother if the driver
is happy for that trigger to be changed and will function correctly with
a different trigger.

If the driver only supports one trigger, we do have iio_trigger_set_immutable()
Do you also need to stop other drivers using the trigger as it's a fake and
hence won't ever actually do result in the triggers being polled?
For that you need to set the validate_device() callback in the trigger ops.

It's a bit pointless though, so unless you have a strong reason, I think the
approach of just defining the devm_iio_kfifo_setup_buffer_ext() as Alex
suggested is cleaner.

> +
> +			/*
> +			 * Register the callback to use when a sensor sample is
> +			 * coming from the EC FIFO.
> +			 */
> +			ret = cros_ec_sensorhub_register_push_data(sensor_hub,
> +					sensor_platform->sensor_num,
>  					indio_dev, push_data);
>  			if (ret)
>  				return ret;
> @@ -355,21 +376,14 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
>  			if (ret)
>  				return ret;
> -		} else {
> -			const struct attribute **fifo_attrs;
> -
> -			if (has_hw_fifo)
> -				fifo_attrs = cros_ec_sensor_fifo_attributes;
> -			else
> -				fifo_attrs = NULL;
>  
> +		} else {
>  			/*
>  			 * The only way to get samples in buffer is to set a
>  			 * software trigger (systrig, hrtimer).
>  			 */
> -			ret = devm_iio_triggered_buffer_setup_ext(
> -					dev, indio_dev, NULL, trigger_capture,
> -					NULL, fifo_attrs);
> +			ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					NULL, trigger_capture, NULL);
>  			if (ret)
>  				return ret;
>  		}
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 75d6b5fcf2cc4..de472f23d1cba 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -182,8 +182,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  
>  	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
>  					cros_ec_sensors_capture,
> -					cros_ec_sensors_push_data,
> -					true);
> +					cros_ec_sensors_push_data);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index aa043cb9ac426..2f882e1094232 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -139,8 +139,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  
>  	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
>  					cros_ec_sensors_capture,
> -					cros_ec_sensors_push_data,
> -					true);
> +					cros_ec_sensors_push_data);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index c9b80be82440f..7ce8a8adad587 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -96,8 +96,7 @@ struct platform_device;
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev, bool physical_device,
>  			      cros_ec_sensors_capture_t trigger_capture,
> -			      cros_ec_sensorhub_push_data_cb_t push_data,
> -			      bool has_hw_fifo);
> +			      cros_ec_sensorhub_push_data_cb_t push_data);
>  
>  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
>  int cros_ec_sensors_push_data(struct iio_dev *indio_dev,

