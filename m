Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B17F6916
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 14:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfKJNV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 08:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfKJNV2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 08:21:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C9820842;
        Sun, 10 Nov 2019 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573392087;
        bh=iiCGTwXPOHn/SzNKqOHNBRXrrLaR0l3JIsNUPjpY29Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wNYHfVFx7z2Rl/2YYvCFVXKv/9zvLREraxyglO87PNckDQoaQQF/pT7vuzi6aN7uz
         yLp9EzK8CHJu5OASu0sFIGhriyB+mrK0niw22PGBJZ2WBPKDaFUzQRnHbT/IMGbFbS
         2RbwgtwNGBGu9N1gBbMjGkfNwpp/7IRBNDBBjZPs=
Date:   Sun, 10 Nov 2019 13:21:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 15/17] iio: cros_ec: Expose hwfifo_timeout
Message-ID: <20191110132119.5b9bdbca@archlinux>
In-Reply-To: <20191105222652.70226-16-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-16-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Nov 2019 14:26:50 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Expose EC minimal interrupt period through buffer/hwfifo_timeout:
> - Maximal timeout is limited to 65s.
> - When timeout for all sensors is set to 0, EC will not send events,
>   even if the sensor sampling rate is greater than 0.
> 
> Rename frequency to sampling_frequency to match IIO ABI.
Would have preferred this as two patches, but not that important as one
is really simple.

> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
One note on something else to tidy up inline (not relevant to this patch)
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes in v4:
> - Check patch with --strict option
>     Alignement
> No changes in v3.
> Changes in v2:
> - Register fifo_attributes in sensors drivers that previously advertise
>   that feature.
> 
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  4 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 95 ++++++++++++++-----
>  drivers/iio/light/cros_ec_light_prox.c        |  5 +-
>  drivers/iio/pressure/cros_ec_baro.c           |  5 +-
>  .../linux/iio/common/cros_ec_sensors_core.h   |  4 +-
>  5 files changed, 82 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 9d0b8ad7a0a5..6f511f9067d9 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -237,6 +237,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
> +
>  	indio_dev->info = &ec_sensors_info;
>  	state = iio_priv(indio_dev);
>  	for (channel = state->channels, i = CROS_EC_SENSOR_X;
> @@ -248,7 +250,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  			BIT(IIO_CHAN_INFO_CALIBSCALE);
>  		channel->info_mask_shared_by_all =
>  			BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_FREQUENCY) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  		channel->info_mask_shared_by_all_available =
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ);
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 879b69527cae..62dc1e4aa7a8 100644
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
> @@ -84,6 +85,77 @@ static void get_default_min_max_freq(enum motionsensor_type type,
>  	}
>  }
>  
> +static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
> +				      int rate)
> +{
> +	int ret;
> +
> +	if (rate > U16_MAX)
> +		rate = U16_MAX;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +	st->param.ec_rate.data = rate;
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	mutex_unlock(&st->cmd_lock);
> +	return ret;
> +}
> +
> +static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
> +						 struct device_attribute *attr,
> +						 const char *buf, size_t len)
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
> +						 struct device_attribute *attr,
> +						 char *buf)
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
> +const struct attribute *cros_ec_sensor_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> +	NULL,
> +};
> +EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
> +
>  int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
>  			      s16 *data,
>  			      s64 timestamp)
> @@ -616,18 +688,6 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
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
> @@ -697,7 +757,7 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  	int ret;
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_FREQUENCY:
> +	case IIO_CHAN_INFO_SAMP_FREQ:
>  		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
>  		st->param.sensor_odr.data = val;
>  
> @@ -706,15 +766,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  
>  		ret = cros_ec_motion_send_host_cmd(st, 0);
>  		break;
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> -		st->param.ec_rate.data = val;
> -
> -		ret = cros_ec_motion_send_host_cmd(st, 0);
> -		if (ret)
> -			break;
> -		st->curr_sampl_freq = val;
> -		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index ccdc6d8958c6..863d01994aae 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -184,6 +184,8 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
> +
>  	indio_dev->info = &cros_ec_light_prox_info;
>  	state = iio_priv(indio_dev);
>  	state->core.type = state->core.resp->info.type;
> @@ -192,8 +194,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
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
> index e1c86b22676c..0dee943f955e 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -140,6 +140,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
> +
>  	indio_dev->info = &cros_ec_baro_info;
>  	state = iio_priv(indio_dev);
>  	state->core.type = state->core.resp->info.type;
> @@ -149,8 +151,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>  	channel->info_mask_shared_by_all =
>  		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_FREQUENCY);
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
>  	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
>  	channel->scan_type.shift = 0;
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 96ea4551945e..5b0acc14c891 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -50,7 +50,6 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
>   *				the timestamp. The timestamp is always last and
>   *				is always 8-byte aligned.
>   * @read_ec_sensors_data:	function used for accessing sensors values
> - * @cuur_sampl_freq:		current sampling period

Side note. Seems that 'frequencies' is not documented... 

>   */
>  struct cros_ec_sensors_core_state {
>  	struct cros_ec_device *ec;
> @@ -73,8 +72,6 @@ struct cros_ec_sensors_core_state {
>  	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
>  				    unsigned long scan_mask, s16 *data);
>  
> -	int curr_sampl_freq;
> -
>  	/* Table of known available frequencies : 0, Min and Max in mHz */
>  	int frequencies[3];
>  };
> @@ -116,5 +113,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  
>  /* List of extended channel specification for all sensors */
>  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
> +extern const struct attribute *cros_ec_sensor_fifo_attributes[];
>  
>  #endif  /* __CROS_EC_SENSORS_CORE_H */

