Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557C8DF35B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 18:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfJUQmM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 12:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUQmM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 12:42:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C0920659;
        Mon, 21 Oct 2019 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571676130;
        bh=DfTynszqvoZRv/OJ2qgpqzKgL6B0egi+I5el6+zThHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ghhWxQGZra3W5b7FRwXTVSjMu4x6oPG8zpQ4/XdNXneBuBnpUTnalXG9r8cfx0PUS
         EAY/73j+EdOIanS7Pw8qKeFS0euFChzsWCdK9WPNWBWb3ZMX1SjMlDfn5lBW/9gBaA
         ODAxOzKBpSZfocdJaOWmb8/dedFQavMsGSUzwAxE=
Date:   Mon, 21 Oct 2019 17:42:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 16/18] iio: cros_ec: Expose hwfifo_timeout
Message-ID: <20191021174204.2d8620b2@archlinux>
In-Reply-To: <20191021055403.67849-17-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
        <20191021055403.67849-17-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019 22:54:01 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Expose EC minimal interrupt period through buffer/hwfifo_timeout:
> - Maximal timeout is limited to 65s.
> - When timeout for all sensors is set to 0, EC will not send events,
>   even if the sensor sampling rate is greater than 0.
> - curr_sample_rate is no more, the pm functions have been removed.
> 
> Rename frequency to sampling_frequency to match IIO ABI.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

I'm keen to see this change, but what is your feeling on the likelihood
anyone will notice that we just changed the ABI for these devices?
Normally I let that go on for cases like this where we are bringing
it inline with the 'correct' ABI..

Assuming that's fine,

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Changes in v2:
> - Register fifo_attributes in sensors drivers that previously advertise
>   that feature.
> 
> 
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  4 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 95 ++++++++++++++-----
>  drivers/iio/light/cros_ec_light_prox.c        |  6 +-
>  drivers/iio/pressure/cros_ec_baro.c           |  6 +-
>  .../linux/iio/common/cros_ec_sensors_core.h   |  4 +-
>  5 files changed, 85 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 2eb4bb254fbde..8c57a3ade78ed 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -236,6 +236,9 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	iio_buffer_set_attrs(indio_dev->buffer,
> +			cros_ec_sensor_fifo_attributes);
> +
>  	indio_dev->info = &ec_sensors_info;
>  	state = iio_priv(indio_dev);
>  	for (channel = state->channels, i = CROS_EC_SENSOR_X;
> @@ -247,7 +250,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  			BIT(IIO_CHAN_INFO_CALIBSCALE);
>  		channel->info_mask_shared_by_all =
>  			BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_FREQUENCY) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  		channel->info_mask_shared_by_all_available =
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ);
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index e89c355bb4b35..92128c67a166e 100644
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
> +const struct attribute *cros_ec_sensor_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> +	NULL,
> +};
> +EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
> +
>  int cros_ec_sensors_push_data(
>  		struct iio_dev *indio_dev,
>  		s16 *data,
> @@ -609,18 +681,6 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
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
> @@ -690,7 +750,7 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  	int ret;
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_FREQUENCY:
> +	case IIO_CHAN_INFO_SAMP_FREQ:
>  		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
>  		st->param.sensor_odr.data = val;
>  
> @@ -699,15 +759,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
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
> index 6bac02cdd898a..059aaddc91fd8 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -183,6 +183,9 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	iio_buffer_set_attrs(indio_dev->buffer,
> +			cros_ec_sensor_fifo_attributes);
> +
>  	indio_dev->info = &cros_ec_light_prox_info;
>  	state = iio_priv(indio_dev);
>  	state->core.type = state->core.resp->info.type;
> @@ -191,8 +194,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
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
> index fb7daeb4b29f9..e933a1bb64d4b 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -139,6 +139,9 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	iio_buffer_set_attrs(indio_dev->buffer,
> +			cros_ec_sensor_fifo_attributes);
> +
>  	indio_dev->info = &cros_ec_baro_info;
>  	state = iio_priv(indio_dev);
>  	state->core.type = state->core.resp->info.type;
> @@ -148,8 +151,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
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
> index db3da7ffcc376..387ca9e61dac8 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -51,7 +51,6 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
>   *				the timestamp. The timestamp is always last and
>   *				is always 8-byte aligned.
>   * @read_ec_sensors_data:	function used for accessing sensors values
> - * @cuur_sampl_freq:		current sampling period
>   */
>  struct cros_ec_sensors_core_state {
>  	struct cros_ec_device *ec;
> @@ -74,8 +73,6 @@ struct cros_ec_sensors_core_state {
>  	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
>  				    unsigned long scan_mask, s16 *data);
>  
> -	int curr_sampl_freq;
> -
>  	/* Table of known available frequencies : 0, Min and Max in mHz */
>  	int frequencies[3];
>  };
> @@ -118,5 +115,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  
>  /* List of extended channel specification for all sensors */
>  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
> +extern const struct attribute *cros_ec_sensor_fifo_attributes[];
>  
>  #endif  /* __CROS_EC_SENSORS_CORE_H */

