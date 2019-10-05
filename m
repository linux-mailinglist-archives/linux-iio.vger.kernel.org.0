Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0CCCB26
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfJEQfj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 12:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfJEQfj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 12:35:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC628218AC;
        Sat,  5 Oct 2019 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570293338;
        bh=co8QYOFq2+Bv+EHOsHtw/4B/LNeErn2t4IQMxcF09c0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lHIcNztXo+boy4i4JgE2isR2TmBBabKeGgh2EWLesnkB41aHDlvBcvvYzHcld/TFe
         kBY7QAoxySBRl1vb64Y3szeBx9HYHdQrGLWR3U4OgLVmUi+w79BkfPaWQB7KgabHgR
         7VzbISi4tJSkxPvUoWXUhbeFFo5836LQPDbkhrMY=
Date:   Sat, 5 Oct 2019 17:35:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/13] iio: cros_ec: Expose hwfifo_timeout
Message-ID: <20191005173532.20fa7bcd@archlinux>
In-Reply-To: <20190922175021.53449-12-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-12-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:19 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Expose EC sampling rate through buffer/hwfifo_timeout.

This seems a bit odd unless EC term "sampling rate"
is rather different from what I'd expect. Code looks
fine though ;)

> Rename frequency to sampling_frequency to match IIO ABI.

That looks like a straight forward bug.  We might
want to think about pushing that back to older kernels.

> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   1 -
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 110 +++++++++++++-----
>  drivers/iio/light/cros_ec_light_prox.c        |   3 +-
>  drivers/iio/pressure/cros_ec_baro.c           |   3 +-
>  4 files changed, 81 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index b78a942ac8e5..95a4b4cf8f87 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -255,7 +255,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  			BIT(IIO_CHAN_INFO_CALIBSCALE);
>  		channel->info_mask_shared_by_all =
>  			BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_FREQUENCY) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  		channel->info_mask_shared_by_all_available =
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ);
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index c4c37c6df301..a31a761e3a81 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -11,6 +11,7 @@
>  #include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
> @@ -84,6 +85,75 @@ static void get_default_min_max_freq(enum motionsensor_type type,
>  	}
>  }
>  
> +static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
> +				      int rate)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +	st->param.ec_rate.data = rate;
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	if (ret == 0)
> +		st->curr_sampl_freq = rate;
> +	mutex_unlock(&st->cmd_lock);
> +	return ret;
> +}
> +
> +static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int integer, fract, ret;
> +	int latency;
> +
> +	ret = iio_str_to_fixpoint(buf, 100000, &integer, &fract);
> +	if (ret)
> +		return ret;
> +
> +	/* EC rate is in ms. */
> +	latency = integer * 1000 + fract / 1000;
> +	ret = cros_ec_sensor_set_ec_rate(st, latency);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int latency, ret;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +	st->param.ec_rate.data = EC_MOTION_SENSE_NO_VALUE;
> +
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	latency = st->resp->ec_rate.ret;
> +	mutex_unlock(&st->cmd_lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d.%06u\n",
> +		       latency / 1000,
> +		       (latency % 1000) * 1000);
> +}
> +
> +static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
> +		       cros_ec_sensor_get_report_latency,
> +		       cros_ec_sensor_set_report_latency, 0);
> +
> +static const struct attribute *cros_ec_sensor_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> +	NULL,
> +};
> +
>  int cros_ec_sensors_push_data(
>  		struct iio_dev *indio_dev,
>  		s16 *data,
> @@ -194,6 +264,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			if (!buffer)
>  				return -ENOMEM;
>  
> +			iio_buffer_set_attrs(buffer,
> +					     cros_ec_sensor_fifo_attributes);
> +
>  			iio_device_attach_buffer(indio_dev, buffer);
>  			indio_dev->modes = INDIO_BUFFER_SOFTWARE;
>  			ret = cros_ec_sensorhub_register_push_data(
> @@ -553,18 +626,6 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> -		st->param.ec_rate.data =
> -			EC_MOTION_SENSE_NO_VALUE;
> -
> -		ret = cros_ec_motion_send_host_cmd(st, 0);
> -		if (ret)
> -			break;
> -
> -		*val = st->resp->ec_rate.ret;
> -		ret = IIO_VAL_INT;
> -		break;
> -	case IIO_CHAN_INFO_FREQUENCY:
>  		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
>  		st->param.sensor_odr.data =
>  			EC_MOTION_SENSE_NO_VALUE;
> @@ -613,23 +674,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  	int ret;
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_FREQUENCY:
> +	case IIO_CHAN_INFO_SAMP_FREQ:
>  		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
>  		st->param.sensor_odr.data = val;
>  
>  		/* Always roundup, so caller gets at least what it asks for. */
>  		st->param.sensor_odr.roundup = 1;
>  
> -		ret = cros_ec_motion_send_host_cmd(st, 0);
> -		break;
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> -		st->param.ec_rate.data = val;
> -
>  		ret = cros_ec_motion_send_host_cmd(st, 0);
>  		if (ret)
>  			break;
> -		st->curr_sampl_freq = val;
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -643,6 +697,7 @@ static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret = 0;
>  
>  	if (st->curr_sampl_freq == 0)
>  		return 0;
> @@ -652,13 +707,10 @@ static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
>  	 * sleep. Set sampling to a long period if necessary.
>  	 */
>  	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> -		mutex_lock(&st->cmd_lock);
> -		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> -		st->param.ec_rate.data = CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY;
> -		cros_ec_motion_send_host_cmd(st, 0);
> -		mutex_unlock(&st->cmd_lock);
> +		ret = cros_ec_sensor_set_ec_rate(st,
> +				CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY);
>  	}
> -	return 0;
> +	return ret;
>  }
>  
>  static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
> @@ -670,11 +722,7 @@ static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
>  		return;
>  
>  	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> -		mutex_lock(&st->cmd_lock);
> -		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> -		st->param.ec_rate.data = st->curr_sampl_freq;
> -		cros_ec_motion_send_host_cmd(st, 0);
> -		mutex_unlock(&st->cmd_lock);
> +		cros_ec_sensor_set_ec_rate(st, st->curr_sampl_freq);
>  	}
>  }
>  
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index d58f010880ce..e9b0072d5c88 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -199,8 +199,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  
>  	/* Common part */
>  	channel->info_mask_shared_by_all =
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_FREQUENCY);
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  	channel->info_mask_shared_by_all_available =
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index c7538e93d24f..aa3cae5a1a15 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -148,8 +148,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>  	channel->info_mask_shared_by_all =
>  		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_FREQUENCY);
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
>  	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
>  	channel->scan_type.shift = 0;

