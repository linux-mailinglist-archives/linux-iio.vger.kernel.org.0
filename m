Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73B3342E4D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 17:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCTQSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 12:18:30 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:55340 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhCTQSN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 12:18:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 195C19E0057;
        Sat, 20 Mar 2021 16:18:10 +0000 (GMT)
Date:   Sat, 20 Mar 2021 16:18:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan.Cameron@huawei.com, ardeleanalex@gmail.com,
        andy.shevchenko@gmail.com, groeck@chromium.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7] iio: cros: unify hw fifo attributes without API
 changes
Message-ID: <20210320161809.1ddf4a26@jic23-huawei>
In-Reply-To: <20210318184857.2679181-1-gwendal@chromium.org>
References: <20210318184857.2679181-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Mar 2021 11:48:57 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> should be reverted as it set buffer extended attributes at
> the wrong place. However, to revert it will requires to revert more
> commits:
> commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> commit 21232b4456ba ("iio: buffer: remove iio_buffer_set_attrs() helper")).
> and we would still have conflict with more recent development.
> commit ee708e6baacd ("iio: buffer: introduce support for attaching more IIO buffers")
> 
> Instead, this commit reverts the first 2 commits without re-adding
> iio_buffer_set_attrs() and set the buffer extended attributes at the
> right place:
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
> 
> 3. Use devm_iio_triggered_buffer_setup_ext() when EC has a FIFO to
> specify the buffer extended attributes.
> 
> Fixes: 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> Fixes: 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks for your hard work on this and the detailed description of
the mess you are sorting out.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
> Changes since v6:
> Added review tags.
> 
> Changes since v5:
> Explain why a single patch solution was preferred to multiple commit
> reverts.
> 
> Changes since v4:
> Applied on top of commit ("iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant")
> https://patchwork.kernel.org/project/linux-iio/patch/20210311091042.22417-1-aardelean@deviqon.com/
> Remove the slim trigger and use devm_iio_triggered_buffer_setup_ext() instead.
> 
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
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |  3 +--
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +--
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 24 +++++++------------
>  drivers/iio/light/cros_ec_light_prox.c        |  3 +--
>  drivers/iio/pressure/cros_ec_baro.c           |  3 +--
>  .../linux/iio/common/cros_ec_sensors_core.h   |  3 +--
>  7 files changed, 14 insertions(+), 27 deletions(-)
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
> index f8824afe595e4..094df3ddb2cd0 100644
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
> @@ -334,9 +333,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			 * We can not use trigger here, as events are generated
>  			 * as soon as sample_frequency is set.
>  			 */
> -			ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> -							  INDIO_BUFFER_SOFTWARE,
> -							  NULL);
> +			ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
> +							      INDIO_BUFFER_SOFTWARE, NULL,
> +							      cros_ec_sensor_fifo_attributes);
>  			if (ret)
>  				return ret;
>  
> @@ -355,21 +354,14 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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

