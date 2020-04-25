Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437DD1B881E
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDYRbG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYRbG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:31:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50EB420700;
        Sat, 25 Apr 2020 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587835865;
        bh=R7Qntes1OBA7zYuxrTQo62id3hHxzx+G5xq4kCy53nU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z4si8L6t0Z4c2Yzn5dWRFJ71AEUZF6NP5DXVBsnxZoygJxkZSzUJojxQYph4Qi++c
         3I6HE+6ZVGU5RYvedrHSl78vwj8jVtD6phuB2ONBWPadabAAFKDcqDseuWa3xKT9Qn
         iGG0JAMAEZJfwNeM1MQcTkzYkI/7EC4w4R56xh1s=
Date:   Sat, 25 Apr 2020 18:31:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: cros_ec_light: Add support for RGB sensor
Message-ID: <20200425183101.531b49be@archlinux>
In-Reply-To: <20200423000230.82750-3-gwendal@chromium.org>
References: <20200423000230.82750-1-gwendal@chromium.org>
        <20200423000230.82750-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 17:02:30 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add support for color sensors behind EC like TCS3400.
> The color data can be presented in Red Green Blue color space (RGB) or
> the CIE 1931 XYZ color space (XYZ).
> In XYZ mode, the sensor is configured for auto calibrating its channels
> and is the "normal" mode.
> The driver tells the EC to switch between the 2 modes by using the
> calibration command.
> When the sensor is in calibration mode, only clear and RGB channels are
> available. In normal mode, only clear and XYZ are.
> When RGB channels are enabled, the sensor switches to calibration mode
> when the buffer is enabled.
> 
> When reading trhough sysfs command, set calibration mode and then read
> the channel(s). A command will be issue for each read, so the channels
> may come from different sensor sample.
> When using the buffer, after setting the mask, when the buffer is
> enabled, the calibration will be set based on the channel mask.
> 
> libiio tools can be used to gather sensor information:
> iio_readdev -s 10 cros-ec-light \
> illuminance_clear illuminance_x illuminance_y illuminance_z
Illuminance is not defined for color channels.  It's units are LUX which
is only defined wrt to a model of the human eye's response to
'brightness' (kind of).

For RGB colour channels they are normally unit free so use intensity
instead.  For XYZ.. hmm not sure.

As Peter pointed out we need some doc updates to cover this use
of x, y and z. 

> 
> To match IIO ABI, the clear illuminance channel has been renamed
> in_illuminance_clear_raw from in_illuminance_input.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
A few additional comments inline.

J
> ---
>  drivers/iio/light/cros_ec_light_prox.c        | 470 +++++++++++++++---
>  drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
>  .../linux/iio/common/cros_ec_sensors_core.h   |   1 -
>  .../linux/platform_data/cros_ec_commands.h    |   2 +
>  4 files changed, 405 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 2198b50909ed0..57eee557a785c 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -17,82 +17,190 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_ec_sensorhub.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
>  /*
> - * We only represent one entry for light or proximity. EC is merging different
> - * light sensors to return the what the eye would see. For proximity, we
> - * currently support only one light source.
> + * We may present up to 7 channels:
> + *
> + * +-----+-----+-----+-----+-----+-----+-----+
> + * |Clear|  X  |  Y  |  Z  | RED |BLUE |GREEN|
> + * |Prox |     |     |     |     |     |     |
> + * +-----+-----+-----+-----+-----+-----+-----+
> + *
> + * Prox[imity] is presented by proximity sensors.
> + * The clear channel is supported by single and color light sensors.
> + * Color light sensor either reports color information in the RGB space or
> + * the CIE 1931 XYZ (XYZ) color space.
>   */
> -#define CROS_EC_LIGHT_PROX_MAX_CHANNELS (1 + 1)
> +#define CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK 1
> +#define CROS_EC_LIGHT_XYZ_SPACE_MASK (0x7 << 1)
> +#define CROS_EC_LIGHT_RGB_SPACE_MASK (0x7 << 4)
> +
> +/*
> + * We always represent one entry for light or proximity, and all
> + * samples can be timestamped.
> + */
> +#define CROS_EC_LIGHT_PROX_MIN_CHANNELS (1 + 1)
> +
> +static const unsigned long cros_ec_light_prox_bitmasks[] = {
> +	CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK,
> +	CROS_EC_LIGHT_XYZ_SPACE_MASK,
> +	CROS_EC_LIGHT_XYZ_SPACE_MASK | CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK,
> +	CROS_EC_LIGHT_RGB_SPACE_MASK,
> +	CROS_EC_LIGHT_RGB_SPACE_MASK | CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK,
> +	0,
> +};
> +
> +#define CROS_EC_IDX_TO_CHAN(_idx) (((_idx) - 1) % CROS_EC_SENSOR_MAX_AXIS)
>  
>  /* State data for ec_sensors iio driver. */
>  struct cros_ec_light_prox_state {
>  	/* Shared by all sensors */
>  	struct cros_ec_sensors_core_state core;
> +	struct iio_chan_spec *channel;

Plural?

>  
> -	struct iio_chan_spec channels[CROS_EC_LIGHT_PROX_MAX_CHANNELS];
> +	/* Calibration information for the color channels. */
> +	struct calib_data rgb_calib[CROS_EC_SENSOR_MAX_AXIS];
>  };
>  
> +static void cros_ec_light_channel_common(struct iio_chan_spec *channel)
> +{
> +	channel->info_mask_shared_by_all =
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	channel->info_mask_shared_by_all_available =
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> +	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
> +	channel->scan_type.shift = 0;

You zero the whole thing first, and this is the 'obvious' default
so you can skip setting shift.

> +	channel->scan_index = 0;
> +	channel->ext_info = cros_ec_sensors_ext_info;
> +	channel->scan_type.sign = 'u';
> +}
> +
> +static int
> +cros_ec_light_extra_send_host_cmd(struct cros_ec_sensors_core_state *state,
> +				  int increment, u16 opt_length)
> +{
> +	u8 save_sensor_num = state->param.info.sensor_num;
> +	int ret;
> +
> +	state->param.info.sensor_num += increment;
> +	ret = cros_ec_motion_send_host_cmd(state, opt_length);
> +	state->param.info.sensor_num = save_sensor_num;
> +	return ret;
> +}
> +
> +static int cros_ec_light_prox_read_data(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					int *val)
> +{
> +	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
> +	int ret;
> +	int idx = chan->scan_index;
> +	s16 data;
> +
> +	/*
> +	 * The data coming from the light sensor is
> +	 * pre-processed and represents the ambient light
> +	 * illuminance reading expressed in lux.
> +	 */
> +	if (idx == 0) {
> +		ret = cros_ec_sensors_read_cmd(indio_dev, 1, &data);
> +		if (ret < 0)
> +			return ret;
> +		*val = data;
> +	} else {
> +		ret = cros_ec_light_extra_send_host_cmd(
> +				&st->core, 1, sizeof(st->core.resp->data));
> +		if (ret)
> +			return ret;
> +		*val = st->core.resp->data.data[CROS_EC_IDX_TO_CHAN(idx)];
> +	}
> +	return IIO_VAL_INT;
> +}
> +
> +static int cros_ec_light_read_color_scale(struct cros_ec_light_prox_state *st,
> +					  int idx, int *val, int *val2)
> +{
> +	int ret, i;
> +	u16 scale;
> +
> +	st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_SCALE;
> +	st->core.param.sensor_scale.flags = 0;
> +	if (idx == 0)
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +	else
> +		ret = cros_ec_light_extra_send_host_cmd(&st->core, 1, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (idx == 0) {
> +		scale = st->core.resp->sensor_scale.scale[0];
> +		st->core.calib[0].scale = scale;
> +	} else {
> +		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> +			st->rgb_calib[i].scale =
> +				st->core.resp->sensor_scale.scale[i];
> +		scale = st->rgb_calib[CROS_EC_IDX_TO_CHAN(idx)].scale;
> +	}
> +	/*
> +	 * scale is a number x.y, where x is coded on 1 bit,
> +	 * y coded on 15 bits, between 0 and 9999.
> +	 */
> +	*val = scale >> 15;
> +	*val2 = ((scale & 0x7FFF) * 1000000LL) /
> +		MOTION_SENSE_DEFAULT_SCALE;
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
>  static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec const *chan,
>  				   int *val, int *val2, long mask)
>  {
>  	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
> -	u16 data = 0;
> -	s64 val64;
> -	int ret;
> +	int i, ret = IIO_VAL_INT;

I'd rather you left this set explicitly next to where the values
come from.  Makes it easier to know it is correct.

>  	int idx = chan->scan_index;
> +	s64 val64;
>  
>  	mutex_lock(&st->core.cmd_lock);
> -
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (chan->type == IIO_PROXIMITY) {
> -			ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> -						     (s16 *)&data);
> -			if (ret)
> -				break;
> -			*val = data;
> -			ret = IIO_VAL_INT;
> -		} else {
> -			ret = -EINVAL;
> -		}
> -		break;
> -	case IIO_CHAN_INFO_PROCESSED:
> -		if (chan->type == IIO_LIGHT) {
> -			ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> -						     (s16 *)&data);
> -			if (ret)
> -				break;
> -			/*
> -			 * The data coming from the light sensor is
> -			 * pre-processed and represents the ambient light
> -			 * illuminance reading expressed in lux.
> -			 */
> -			*val = data;
> -			ret = IIO_VAL_INT;
> -		} else {
> -			ret = -EINVAL;
> -		}
> +		ret = cros_ec_light_prox_read_data(indio_dev, chan, val);
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
>  		st->core.param.sensor_offset.flags = 0;
>  
> -		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (idx == 0)
> +			ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		else
> +			ret = cros_ec_light_extra_send_host_cmd(
> +					&st->core, 1, 0);
>  		if (ret)
>  			break;
> -
> -		/* Save values */
> -		st->core.calib[0].offset =
> -			st->core.resp->sensor_offset.offset[0];
> -
> -		*val = st->core.calib[idx].offset;
> +		if (idx == 0) {
> +			*val = st->core.calib[0].offset =
> +				st->core.resp->sensor_offset.offset[0];
> +		} else {
> +			for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS;
> +			     i++)
> +				st->rgb_calib[i].offset =
> +					st->core.resp->sensor_offset.offset[i];
> +			*val = st->rgb_calib[CROS_EC_IDX_TO_CHAN(idx)].offset;
> +		}
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (indio_dev->num_channels > CROS_EC_LIGHT_PROX_MIN_CHANNELS) {
> +			ret = cros_ec_light_read_color_scale(st, idx, val,
> +							     val2);
> +			break;
> +		}
> +		/* RANGE is used for calibration in 1 channel sensors. */
> +		fallthrough;
> +	case IIO_CHAN_INFO_SCALE:
>  		/*
>  		 * RANGE is used for calibration
>  		 * scale is a number x.y, where x is coded on 16 bits,
> @@ -121,29 +229,84 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int cros_ec_light_write_color_scale(struct cros_ec_light_prox_state *st,
> +					   int idx, int val, int val2)
> +{
> +	int i;
> +	u16 scale;
> +
> +	if (val >= 2) {
> +		/*
> +		 * The user space is sending values already
> +		 * multiplied by MOTION_SENSE_DEFAULT_SCALE.
> +		 */
> +		scale = val;
> +	} else {
> +		u64 val64 = val2 * MOTION_SENSE_DEFAULT_SCALE;
> +
> +		do_div(val64, 1000000);
> +		scale = (val << 15) | val64;
> +	}
> +
> +	st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_SCALE;
> +	st->core.param.sensor_offset.flags = MOTION_SENSE_SET_OFFSET;
> +	st->core.param.sensor_offset.temp = EC_MOTION_SENSE_INVALID_CALIB_TEMP;
> +	if (idx == 0) {
> +		st->core.calib[0].scale = scale;
> +		st->core.param.sensor_scale.scale[0] = scale;
> +		return cros_ec_motion_send_host_cmd(&st->core, 0);
> +	}
> +
> +	st->rgb_calib[CROS_EC_IDX_TO_CHAN(idx)].scale = scale;
> +	for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> +		st->core.param.sensor_scale.scale[i] = st->rgb_calib[i].scale;
> +	return cros_ec_light_extra_send_host_cmd(&st->core, 1, 0);
> +}
> +
>  static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask)
>  {
>  	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
> -	int ret;
> +	int ret, i;
>  	int idx = chan->scan_index;
>  
>  	mutex_lock(&st->core.cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		st->core.calib[idx].offset = val;
>  		/* Send to EC for each axis, even if not complete */
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
>  		st->core.param.sensor_offset.flags = MOTION_SENSE_SET_OFFSET;
> -		st->core.param.sensor_offset.offset[0] =
> -			st->core.calib[0].offset;
>  		st->core.param.sensor_offset.temp =
>  					EC_MOTION_SENSE_INVALID_CALIB_TEMP;
> -		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (idx == 0) {
> +			st->core.calib[0].offset = val;
> +			st->core.param.sensor_offset.offset[0] = val;
> +			ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		} else {
> +			st->rgb_calib[CROS_EC_IDX_TO_CHAN(idx)].offset = val;
> +			for (i = CROS_EC_SENSOR_X;
> +			     i < CROS_EC_SENSOR_MAX_AXIS;
> +			     i++)
> +				st->core.param.sensor_offset.offset[i] =
> +					st->rgb_calib[i].offset;
> +			ret = cros_ec_light_extra_send_host_cmd(
> +					&st->core, 1, 0);
> +		}
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (indio_dev->num_channels > CROS_EC_LIGHT_PROX_MIN_CHANNELS) {
> +			ret = cros_ec_light_write_color_scale(st, idx,
> +							      val, val2);
> +			break;
> +		}
> +		/*
> +		 * For sensors with only one channel, _RANGE is used
> +		 * instead of _SCALE.
> +		 */
> +		fallthrough;
> +	case IIO_CHAN_INFO_SCALE:
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
>  		st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
>  		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> @@ -159,27 +322,154 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int cros_ec_light_push_data(struct iio_dev *indio_dev,
> +				   s16 *data,
> +				   s64 timestamp)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	unsigned long scan_mask;
> +
> +	if (!st || !indio_dev->active_scan_mask)

How would you get here with st not being valid?
I'm fairly sure we don't sanity check iio_priv so if indio_dev
is valid you'll get a value that passes that check.

> +		return 0;
> +
> +	scan_mask = *indio_dev->active_scan_mask;
> +	if ((scan_mask & ~CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK) == 0)
> +		/*
> +		 * Only one channel at most is used.
> +		 * Use regular push function.
> +		 */
> +		return cros_ec_sensors_push_data(indio_dev, data, timestamp);
> +
> +	if (scan_mask & CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK)
> +		/*
> +		 * Save clear channel, will be used when RGB data arrives.
> +		 */
> +		st->samples[0] = data[0];
> +
> +	return 0;
> +}
> +
> +static int cros_ec_light_push_data_rgb(struct iio_dev *indio_dev,
> +				       s16 *data,
> +				       s64 timestamp)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	s16 *out;
> +	unsigned long scan_mask;
> +	unsigned int i;
> +
> +	if (!st || !indio_dev->active_scan_mask)
> +		return 0;
> +
> +	scan_mask = *indio_dev->active_scan_mask;
> +	/*
> +	 * Send all data needed.
> +	 */
> +	out = (s16 *)st->samples;
> +	for_each_set_bit(i,
> +			 indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		if (i > 0)
> +			*out = data[CROS_EC_IDX_TO_CHAN(i)];
> +		out++;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->samples, timestamp);
> +	return 0;
> +}
> +
> +static irqreturn_t cros_ec_light_capture(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret, i, idx = 0;
> +	s16 data;
> +	const unsigned long scan_mask = *indio_dev->active_scan_mask;
> +
> +	mutex_lock(&st->cmd_lock);
> +
> +	/* Clear capture data. */
> +	memset(st->samples, 0, indio_dev->scan_bytes);
> +
> +	/* Read first channel. */
> +	ret = cros_ec_sensors_read_cmd(indio_dev, 1, &data);
> +	if (ret < 0) {
> +		mutex_unlock(&st->cmd_lock);
> +		goto done;
> +	}
> +	if (scan_mask & CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK)
> +		((s16 *)st->samples)[idx++] = data;
> +
> +	/* Read remaining channels. */
> +	if ((scan_mask & CROS_EC_LIGHT_XYZ_SPACE_MASK) ||
> +	    (scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)) {
> +		ret = cros_ec_light_extra_send_host_cmd(
> +				st, 1, sizeof(st->resp->data));
> +		if (ret < 0) {
> +			mutex_unlock(&st->cmd_lock);
> +			goto done;
> +		}
> +		for (i = 0; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> +			((s16 *)st->samples)[idx++] = st->resp->data.data[i];
> +	}
> +	mutex_unlock(&st->cmd_lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
> +					   iio_get_time_ns(indio_dev));
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cros_ec_light_prox_update_scan_mode(struct iio_dev *indio_dev,
> +					       const unsigned long *scan_mask)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret;
> +	bool enable_raw_mode;
> +
> +	if (*scan_mask & CROS_EC_LIGHT_XYZ_SPACE_MASK)
> +		enable_raw_mode = false;
> +	else if (*scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)
> +		enable_raw_mode = true;
> +	else
> +		/* Just clear channel or proxmity, nothing to do. */
> +		return 0;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_PERFORM_CALIB;
> +	st->param.perform_calib.enable = enable_raw_mode;
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	mutex_unlock(&st->cmd_lock);
> +
> +	return ret;
> +}
> +
>  static const struct iio_info cros_ec_light_prox_info = {
>  	.read_raw = &cros_ec_light_prox_read,
>  	.write_raw = &cros_ec_light_prox_write,
>  	.read_avail = &cros_ec_sensors_core_read_avail,
> +	.update_scan_mode = &cros_ec_light_prox_update_scan_mode,
>  };
>  
>  static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_light_prox_state *state;
>  	struct iio_chan_spec *channel;
> -	int ret;
> +	int ret, i, num_channels = CROS_EC_LIGHT_PROX_MIN_CHANNELS;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> -					cros_ec_sensors_capture,
> -					cros_ec_sensors_push_data);
> +					cros_ec_light_capture,
> +					cros_ec_light_push_data);
>  	if (ret)
>  		return ret;
>  
> @@ -189,28 +479,40 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  	state = iio_priv(indio_dev);
>  	state->core.type = state->core.resp->info.type;
>  	state->core.loc = state->core.resp->info.location;
> -	channel = state->channels;
>  
> -	/* Common part */
> -	channel->info_mask_shared_by_all =
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ);
> -	channel->info_mask_shared_by_all_available =
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ);
> -	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> -	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
> -	channel->scan_type.shift = 0;
> -	channel->scan_index = 0;
> -	channel->ext_info = cros_ec_sensors_ext_info;
> -	channel->scan_type.sign = 'u';
> +	/* Check if we need more sensors for RGB (or XYZ). */
> +	state->core.param.cmd = MOTIONSENSE_CMD_INFO;
> +	if (cros_ec_light_extra_send_host_cmd(&state->core, 1, 0) == 0 &&
> +	    state->core.resp->info.type == MOTIONSENSE_TYPE_LIGHT_RGB)
> +		num_channels += 2 * CROS_EC_SENSOR_MAX_AXIS;
> +
> +	channel = devm_kcalloc(dev, num_channels, sizeof(*channel), 0);
> +	if (!channel)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = channel;
> +	indio_dev->num_channels = num_channels;
> +	indio_dev->available_scan_masks = cros_ec_light_prox_bitmasks;
>  
> +	cros_ec_light_channel_common(channel);
>  	/* Sensor specific */
>  	switch (state->core.type) {
>  	case MOTIONSENSE_TYPE_LIGHT:
>  		channel->type = IIO_LIGHT;
> +		if (num_channels > CROS_EC_LIGHT_PROX_MIN_CHANNELS) {
> +			/*
> +			 * To set a global scale, as CALIB_SCALE for RGB sensor
> +			 * is limited between 0 and 2.
> +			 */
> +			channel->info_mask_shared_by_all |=
> +				BIT(IIO_CHAN_INFO_SCALE);
> +		}
>  		channel->info_mask_separate =
> -			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_RAW) |

Didn't we just change the ABI by doing this?

>  			BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  			BIT(IIO_CHAN_INFO_CALIBSCALE);
> +		channel->modified = 1;
> +		channel->channel2 = IIO_MOD_LIGHT_CLEAR;
>  		break;
>  	case MOTIONSENSE_TYPE_PROX:
>  		channel->type = IIO_PROXIMITY;
> @@ -223,20 +525,48 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  		dev_warn(dev, "Unknown motion sensor\n");
>  		return -EINVAL;
>  	}
> +	channel++;
> +
> +	if (num_channels > CROS_EC_LIGHT_PROX_MIN_CHANNELS) {
> +		u8 sensor_num = state->core.param.info.sensor_num;
> +		int idx;
> +
> +		for (i = CROS_EC_SENSOR_X, idx = 1; i < CROS_EC_SENSOR_MAX_AXIS;
> +				i++, channel++, idx++) {
> +			cros_ec_light_channel_common(channel);
> +			channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +			channel->scan_index = idx;
> +			channel->modified = 1;
> +			channel->channel2 = IIO_MOD_X + i;
> +			channel->type = IIO_LIGHT;
> +		}
> +		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS;
> +				i++, channel++, idx++) {
> +			cros_ec_light_channel_common(channel);
> +			channel->info_mask_separate =
> +				BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE);
> +			channel->scan_index = idx;
> +			channel->modified = 1;
> +			channel->channel2 = IIO_MOD_LIGHT_RED + i;
> +			channel->type = IIO_LIGHT;
> +		}
> +		cros_ec_sensorhub_register_push_data(
> +				sensor_hub,
> +				sensor_num + 1,
> +				indio_dev,
> +				cros_ec_light_push_data_rgb);
> +	}
>  
>  	/* Timestamp */
> -	channel++;
>  	channel->type = IIO_TIMESTAMP;
>  	channel->channel = -1;
> -	channel->scan_index = 1;
> +	channel->scan_index = num_channels - 1;
>  	channel->scan_type.sign = 's';
>  	channel->scan_type.realbits = 64;
>  	channel->scan_type.storagebits = 64;
>  
> -	indio_dev->channels = state->channels;
> -
> -	indio_dev->num_channels = CROS_EC_LIGHT_PROX_MAX_CHANNELS;
> -
>  	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
>  	return devm_iio_device_register(dev, indio_dev);
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> index b7f2c00db5e1e..f85191ab2ee34 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -103,6 +103,9 @@ static int cros_ec_sensorhub_register(struct device *dev,
>  		case MOTIONSENSE_TYPE_LIGHT:
>  			name = "cros-ec-light";
>  			break;
> +		case MOTIONSENSE_TYPE_LIGHT_RGB:
> +			/* Processed with cros-ec-light. */
> +			continue;
>  		case MOTIONSENSE_TYPE_ACTIVITY:
>  			name = "cros-ec-activity";
>  			break;
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 7bc961defa87e..c31766c64bf94 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -26,7 +26,6 @@ enum {
>  
>  /*
>   * 4 16 bit channels are allowed.
> - * Good enough for current sensors, they use up to 3 16 bit vectors.
>   */
>  #define CROS_EC_SAMPLE_SIZE  (sizeof(s64) * 2)
>  
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 3286ac00b0436..72ee6b049da62 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -2342,6 +2342,7 @@ enum motionsensor_type {
>  	MOTIONSENSE_TYPE_ACTIVITY = 5,
>  	MOTIONSENSE_TYPE_BARO = 6,
>  	MOTIONSENSE_TYPE_SYNC = 7,
> +	MOTIONSENSE_TYPE_LIGHT_RGB = 8,
>  	MOTIONSENSE_TYPE_MAX,
>  };
>  
> @@ -2375,6 +2376,7 @@ enum motionsensor_chip {
>  	MOTIONSENSE_CHIP_LSM6DS3 = 17,
>  	MOTIONSENSE_CHIP_LSM6DSO = 18,
>  	MOTIONSENSE_CHIP_LNG2DM = 19,
> +	MOTIONSENSE_CHIP_TCS3400 = 20,
>  	MOTIONSENSE_CHIP_MAX,
>  };
>  

