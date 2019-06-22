Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766444F538
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFVKYt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKYt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:24:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8502075E;
        Sat, 22 Jun 2019 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561199087;
        bh=VjzOGq4qSjU2otwWrhmgp2KrXvatZO5AWOw3LpxCCCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hHziDQ4O33yFHDPsO6Mz3wOQoYbq1Z/rnOG1HsWBe9GofG9DFTGa+v0i2zt4uMnIj
         sZ/wqNYGp0mQBXkwrsakA4C+t+g4FpudyZNT93cYpa7MYzHgt9jnT6f+3MTZYh78qH
         wZTailu74Yhxnf9BZvTTP22M2MBDQJIr1BHV7IKQ=
Date:   Sat, 22 Jun 2019 11:24:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iio: common: cros_ec_sensors: use core structure
Message-ID: <20190622112442.2ae00342@archlinux>
In-Reply-To: <b157495630a05a3e3cd7c1601cc3645c0a649578.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
        <b157495630a05a3e3cd7c1601cc3645c0a649578.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jun 2019 11:06:36 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> Drivers based on cros_ec_sensors_core have structure containing the
> core structure. In order to simplify, we drop all the specific and
> useless structure to use the same one in all drivers.
> If a future driver need specific field, we can add a private pointer
> to that data.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
This is the one I wanted to say seemed entirely sensible and
I'll pick up once the other minor bits and bobs are resolved!

Sorry for the confusion.

Jonathan

> ---
>  .../common/cros_ec_sensors/cros_ec_sensors.c  | 114 ++++++++----------
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
>  drivers/iio/light/cros_ec_light_prox.c        |  85 ++++++-------
>  drivers/iio/pressure/cros_ec_baro.c           |  62 +++++-----
>  .../linux/iio/common/cros_ec_sensors_core.h   |   3 +-
>  5 files changed, 121 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index c4bee9265246..1f0d1c614ffc 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -24,58 +24,52 @@
>  
>  #define CROS_EC_SENSORS_MAX_CHANNELS 4
>  
> -/* State data for ec_sensors iio driver. */
> -struct cros_ec_sensors_state {
> -	/* Shared by all sensors */
> -	struct cros_ec_sensors_core_state core;
> -};
> -
>  static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
>  {
> -	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	s16 data = 0;
>  	s64 val64;
>  	int i;
>  	int ret;
>  	int idx = chan->scan_index;
>  
> -	mutex_lock(&st->core.cmd_lock);
> +	mutex_lock(&st->cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = st->core.read_ec_sensors_data(indio_dev, 1 << idx, &data);
> +		ret = st->read_ec_sensors_data(indio_dev, 1 << idx, &data);
>  		if (ret < 0)
>  			break;
>  		ret = IIO_VAL_INT;
>  		*val = data;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> -		st->core.param.sensor_offset.flags = 0;
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> +		st->param.sensor_offset.flags = 0;
>  
> -		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
>  		if (ret < 0)
>  			break;
>  
>  		/* Save values */
>  		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> -			st->core.calib[i] =
> -				st->core.resp->sensor_offset.offset[i];
> +			st->calib[i] =
> +				st->resp->sensor_offset.offset[i];
>  		ret = IIO_VAL_INT;
> -		*val = st->core.calib[idx];
> +		*val = st->calib[idx];
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> -		st->core.param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
>  
> -		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
>  		if (ret < 0)
>  			break;
>  
> -		val64 = st->core.resp->sensor_range.ret;
> -		switch (st->core.type) {
> +		val64 = st->resp->sensor_range.ret;
> +		switch (st->type) {
>  		case MOTIONSENSE_TYPE_ACCEL:
>  			/*
>  			 * EC returns data in g, iio exepects m/s^2.
> @@ -110,11 +104,10 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	default:
> -		ret = cros_ec_sensors_core_read(&st->core, chan, val, val2,
> -						mask);
> +		ret = cros_ec_sensors_core_read(st, chan, val, val2, mask);
>  		break;
>  	}
> -	mutex_unlock(&st->core.cmd_lock);
> +	mutex_unlock(&st->cmd_lock);
>  
>  	return ret;
>  }
> @@ -123,49 +116,48 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask)
>  {
> -	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	int i;
>  	int ret;
>  	int idx = chan->scan_index;
>  
> -	mutex_lock(&st->core.cmd_lock);
> +	mutex_lock(&st->cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		st->core.calib[idx] = val;
> +		st->calib[idx] = val;
>  
>  		/* Send to EC for each axis, even if not complete */
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> -		st->core.param.sensor_offset.flags =
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> +		st->param.sensor_offset.flags =
>  			MOTION_SENSE_SET_OFFSET;
>  		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> -			st->core.param.sensor_offset.offset[i] =
> -				st->core.calib[i];
> -		st->core.param.sensor_offset.temp =
> +			st->param.sensor_offset.offset[i] =
> +				st->calib[i];
> +		st->param.sensor_offset.temp =
>  			EC_MOTION_SENSE_INVALID_CALIB_TEMP;
>  
> -		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (st->core.type == MOTIONSENSE_TYPE_MAG) {
> +		if (st->type == MOTIONSENSE_TYPE_MAG) {
>  			ret = -EINVAL;
>  			break;
>  		}
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> -		st->core.param.sensor_range.data = val;
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->param.sensor_range.data = val;
>  
>  		/* Always roundup, so caller gets at least what it asks for. */
> -		st->core.param.sensor_range.roundup = 1;
> +		st->param.sensor_range.roundup = 1;
>  
> -		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
>  		break;
>  	default:
> -		ret = cros_ec_sensors_core_write(
> -				&st->core, chan, val, val2, mask);
> +		ret = cros_ec_sensors_core_write(st, chan, val, val2, mask);
>  		break;
>  	}
>  
> -	mutex_unlock(&st->core.cmd_lock);
> +	mutex_unlock(&st->cmd_lock);
>  
>  	return ret;
>  }
> @@ -175,7 +167,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
> -	struct cros_ec_sensors_state *state;
> +	struct cros_ec_sensors_core_state *state;
>  	int ret, i;
>  
>  	if (!ec_dev || !ec_dev->ec_dev) {
> @@ -183,8 +175,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	ret = cros_ec_sensors_core_init(pdev, sizeof(*state),
> -					CROS_EC_SENSORS_MAX_CHANNELS, true);
> +	ret = cros_ec_sensors_core_init(pdev, CROS_EC_SENSORS_MAX_CHANNELS,
> +					true);
>  	if (ret)
>  		return ret;
>  
> @@ -192,46 +184,46 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  	state = iio_priv(indio_dev);
>  	for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++) {
>  		/* Common part */
> -		cros_ec_core_channel_init(state->core.channels, i + 1);
> -		state->core.channels[i + 1].info_mask_separate =
> +		cros_ec_core_channel_init(state->channels, i + 1);
> +		state->channels[i + 1].info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_CALIBBIAS);
> -		state->core.channels[i + 1].info_mask_shared_by_all =
> +		state->channels[i + 1].info_mask_shared_by_all =
>  			BIT(IIO_CHAN_INFO_SCALE) |
>  			BIT(IIO_CHAN_INFO_FREQUENCY) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ);
> -		state->core.channels[i + 1].scan_index = i;
> -		state->core.channels[i + 1].modified = 1;
> -		state->core.channels[i + 1].channel2 = IIO_MOD_X + i;
> -		state->core.channels[i + 1].scan_type.sign = 's';
> +		state->channels[i + 1].scan_index = i;
> +		state->channels[i + 1].modified = 1;
> +		state->channels[i + 1].channel2 = IIO_MOD_X + i;
> +		state->channels[i + 1].scan_type.sign = 's';
>  
>  		/* Sensor specific */
> -		switch (state->core.type) {
> +		switch (state->type) {
>  		case MOTIONSENSE_TYPE_ACCEL:
> -			state->core.channels[i + 1].type = IIO_ACCEL;
> +			state->channels[i + 1].type = IIO_ACCEL;
>  			break;
>  		case MOTIONSENSE_TYPE_GYRO:
> -			state->core.channels[i + 1].type = IIO_ANGL_VEL;
> +			state->channels[i + 1].type = IIO_ANGL_VEL;
>  			break;
>  		case MOTIONSENSE_TYPE_MAG:
> -			state->core.channels[i + 1].type = IIO_MAGN;
> +			state->channels[i + 1].type = IIO_MAGN;
>  			break;
>  		default:
>  			dev_err(&pdev->dev, "Unknown motion sensor\n");
>  			return -EINVAL;
>  		}
>  	}
> -	state->core.channels[0].scan_index = CROS_EC_SENSOR_MAX_AXIS;
> +	state->channels[0].scan_index = CROS_EC_SENSOR_MAX_AXIS;
>  
> -	state->core.info.read_raw = &cros_ec_sensors_read;
> -	state->core.info.write_raw = &cros_ec_sensors_write;
> +	state->info.read_raw = &cros_ec_sensors_read;
> +	state->info.write_raw = &cros_ec_sensors_write;
>  
>  	/* There is only enough room for accel and gyro in the io space */
> -	if ((state->core.ec->cmd_readmem != NULL) &&
> -	    (state->core.type != MOTIONSENSE_TYPE_MAG))
> -		state->core.read_ec_sensors_data = cros_ec_sensors_read_lpc;
> +	if ((state->ec->cmd_readmem != NULL) &&
> +	    (state->type != MOTIONSENSE_TYPE_MAG))
> +		state->read_ec_sensors_data = cros_ec_sensors_read_lpc;
>  	else
> -		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> +		state->read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
>  	return cros_ec_sensors_core_register(pdev, indio_dev);
>  }
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 3880849c5cca..57034e212fe1 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -27,7 +27,6 @@ static char *cros_ec_loc[] = {
>  };
>  
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
> -			      int sizeof_priv,
>  			      int num_channels,
>  			      bool physical_device)
>  {
> @@ -40,7 +39,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	if (num_channels > CROS_EC_SENSORS_CORE_MAX_CHANNELS)
>  		return -EINVAL;
>  
> -	indio_dev = devm_iio_device_alloc(dev, sizeof_priv);
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 73f5dcbda0d5..6e1075dc6458 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -27,23 +27,17 @@
>   */
>  #define CROS_EC_LIGHT_PROX_MAX_CHANNELS (1 + 1)
>  
> -/* State data for ec_sensors iio driver. */
> -struct cros_ec_light_prox_state {
> -	/* Shared by all sensors */
> -	struct cros_ec_sensors_core_state core;
> -};
> -
>  static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec const *chan,
>  				   int *val, int *val2, long mask)
>  {
> -	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	u16 data = 0;
>  	s64 val64;
>  	int ret = IIO_VAL_INT;
>  	int idx = chan->scan_index;
>  
> -	mutex_lock(&st->core.cmd_lock);
> +	mutex_lock(&st->cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -77,18 +71,18 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> -		st->core.param.sensor_offset.flags = 0;
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> +		st->param.sensor_offset.flags = 0;
>  
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
> +		if (cros_ec_motion_send_host_cmd(st, 0)) {
>  			ret = -EIO;
>  			break;
>  		}
>  
>  		/* Save values */
> -		st->core.calib[0] = st->core.resp->sensor_offset.offset[0];
> +		st->calib[0] = st->resp->sensor_offset.offset[0];
>  
> -		*val = st->core.calib[idx];
> +		*val = st->calib[idx];
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		/*
> @@ -96,26 +90,26 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  		 * scale is a number x.y, where x is coded on 16 bits,
>  		 * y coded on 16 bits, between 0 and 9999.
>  		 */
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> -		st->core.param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
>  
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
> +		if (cros_ec_motion_send_host_cmd(st, 0)) {
>  			ret = -EIO;
>  			break;
>  		}
>  
> -		val64 = st->core.resp->sensor_range.ret;
> +		val64 = st->resp->sensor_range.ret;
>  		*val = val64 >> 16;
>  		*val2 = (val64 & 0xffff) * 100;
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	default:
> -		ret = cros_ec_sensors_core_read(&st->core, chan, val, val2,
> +		ret = cros_ec_sensors_core_read(st, chan, val, val2,
>  						mask);
>  		break;
>  	}
>  
> -	mutex_unlock(&st->core.cmd_lock);
> +	mutex_unlock(&st->cmd_lock);
>  
>  	return ret;
>  }
> @@ -124,37 +118,37 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask)
>  {
> -	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	int ret = 0;
>  	int idx = chan->scan_index;
>  
> -	mutex_lock(&st->core.cmd_lock);
> +	mutex_lock(&st->cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		st->core.calib[idx] = val;
> +		st->calib[idx] = val;
>  		/* Send to EC for each axis, even if not complete */
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> -		st->core.param.sensor_offset.flags = MOTION_SENSE_SET_OFFSET;
> -		st->core.param.sensor_offset.offset[0] = st->core.calib[0];
> -		st->core.param.sensor_offset.temp =
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> +		st->param.sensor_offset.flags = MOTION_SENSE_SET_OFFSET;
> +		st->param.sensor_offset.offset[0] = st->calib[0];
> +		st->param.sensor_offset.temp =
>  					EC_MOTION_SENSE_INVALID_CALIB_TEMP;
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0))
> +		if (cros_ec_motion_send_host_cmd(st, 0))
>  			ret = -EIO;
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> -		st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0))
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->param.sensor_range.data = (val << 16) | (val2 / 100);
> +		if (cros_ec_motion_send_host_cmd(st, 0))
>  			ret = -EIO;
>  		break;
>  	default:
> -		ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
> +		ret = cros_ec_sensors_core_write(st, chan, val, val2,
>  						 mask);
>  		break;
>  	}
>  
> -	mutex_unlock(&st->core.cmd_lock);
> +	mutex_unlock(&st->cmd_lock);
>  
>  	return ret;
>  }
> @@ -164,7 +158,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
> -	struct cros_ec_light_prox_state *state;
> +	struct cros_ec_sensors_core_state *state;
>  	int ret;
>  
>  	if (!ec_dev || !ec_dev->ec_dev) {
> @@ -172,36 +166,35 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	ret = cros_ec_sensors_core_init(pdev, sizeof(*state),
> -					CROS_EC_LIGHT_PROX_MAX_CHANNELS, true);
> +	ret = cros_ec_sensors_core_init(pdev, CROS_EC_LIGHT_PROX_MAX_CHANNELS, true);
>  	if (ret)
>  		return ret;
>  
>  	indio_dev = platform_get_drvdata(pdev);
>  	state = iio_priv(indio_dev);
> -	state->core.info.read_raw = &cros_ec_light_prox_read;
> -	state->core.info.write_raw = &cros_ec_light_prox_write;
> +	state->info.read_raw = &cros_ec_light_prox_read;
> +	state->info.write_raw = &cros_ec_light_prox_write;
>  
>  	/* Common part */
> -	cros_ec_core_channel_init(state->core.channels, 1);
> -	state->core.channels[1].info_mask_shared_by_all =
> +	cros_ec_core_channel_init(state->channels, 1);
> +	state->channels[1].info_mask_shared_by_all =
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_FREQUENCY);
>  
> -	state->core.calib[0] = 0;
> +	state->calib[0] = 0;
>  
>  	/* Sensor specific */
> -	switch (state->core.type) {
> +	switch (state->type) {
>  	case MOTIONSENSE_TYPE_LIGHT:
> -		state->core.channels[1].type = IIO_LIGHT;
> -		state->core.channels[1].info_mask_separate =
> +		state->channels[1].type = IIO_LIGHT;
> +		state->channels[1].info_mask_separate =
>  			BIT(IIO_CHAN_INFO_PROCESSED) |
>  			BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  			BIT(IIO_CHAN_INFO_CALIBSCALE);
>  		break;
>  	case MOTIONSENSE_TYPE_PROX:
> -		state->core.channels[1].type = IIO_PROXIMITY;
> -		state->core.channels[1].info_mask_separate =
> +		state->channels[1].type = IIO_PROXIMITY;
> +		state->channels[1].info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  			BIT(IIO_CHAN_INFO_CALIBSCALE);
> @@ -211,7 +204,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> +	state->read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
>  	return cros_ec_sensors_core_register(pdev, indio_dev);
>  }
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index f8107a8b8e72..a2703771a6d1 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -25,22 +25,16 @@
>   */
>  #define CROS_EC_BARO_MAX_CHANNELS (1 + 1)
>  
> -/* State data for ec_sensors iio driver. */
> -struct cros_ec_baro_state {
> -	/* Shared by all sensors */
> -	struct cros_ec_sensors_core_state core;
> -};
> -
>  static int cros_ec_baro_read(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int *val, int *val2, long mask)
>  {
> -	struct cros_ec_baro_state *st = iio_priv(indio_dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	u16 data = 0;
>  	int ret = IIO_VAL_INT;
>  	int idx = chan->scan_index;
>  
> -	mutex_lock(&st->core.cmd_lock);
> +	mutex_lock(&st->cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -50,26 +44,26 @@ static int cros_ec_baro_read(struct iio_dev *indio_dev,
>  		*val = data;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> -		st->core.param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
>  
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
> +		if (cros_ec_motion_send_host_cmd(st, 0)) {
>  			ret = -EIO;
>  			break;
>  		}
> -		*val = st->core.resp->sensor_range.ret;
> +		*val = st->resp->sensor_range.ret;
>  
>  		/* scale * in_pressure_raw --> kPa */
>  		*val2 = 10 << CROS_EC_SENSOR_BITS;
>  		ret = IIO_VAL_FRACTIONAL;
>  		break;
>  	default:
> -		ret = cros_ec_sensors_core_read(&st->core, chan, val, val2,
> +		ret = cros_ec_sensors_core_read(st, chan, val, val2,
>  						mask);
>  		break;
>  	}
>  
> -	mutex_unlock(&st->core.cmd_lock);
> +	mutex_unlock(&st->cmd_lock);
>  
>  	return ret;
>  }
> @@ -78,29 +72,28 @@ static int cros_ec_baro_write(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int val, int val2, long mask)
>  {
> -	struct cros_ec_baro_state *st = iio_priv(indio_dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	int ret = 0;
>  
> -	mutex_lock(&st->core.cmd_lock);
> +	mutex_lock(&st->cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> -		st->core.param.sensor_range.data = val;
> +		st->param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->param.sensor_range.data = val;
>  
>  		/* Always roundup, so caller gets at least what it asks for. */
> -		st->core.param.sensor_range.roundup = 1;
> +		st->param.sensor_range.roundup = 1;
>  
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0))
> +		if (cros_ec_motion_send_host_cmd(st, 0))
>  			ret = -EIO;
>  		break;
>  	default:
> -		ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
> -						 mask);
> +		ret = cros_ec_sensors_core_write(st, chan, val, val2, mask);
>  		break;
>  	}
>  
> -	mutex_unlock(&st->core.cmd_lock);
> +	mutex_unlock(&st->cmd_lock);
>  
>  	return ret;
>  }
> @@ -110,7 +103,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
> -	struct cros_ec_baro_state *state;
> +	struct cros_ec_sensors_core_state *state;
>  	int ret;
>  
>  	if (!ec_dev || !ec_dev->ec_dev) {
> @@ -118,37 +111,36 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	ret = cros_ec_sensors_core_init(pdev, sizeof(*state),
> -					CROS_EC_BARO_MAX_CHANNELS, true);
> +	ret = cros_ec_sensors_core_init(pdev, CROS_EC_BARO_MAX_CHANNELS, true);
>  	if (ret)
>  		return ret;
>  
>  	indio_dev = platform_get_drvdata(pdev);
>  	state = iio_priv(indio_dev);
> -	state->core.info.read_raw = &cros_ec_baro_read;
> -	state->core.info.write_raw = &cros_ec_baro_write;
> +	state->info.read_raw = &cros_ec_baro_read;
> +	state->info.write_raw = &cros_ec_baro_write;
>  
>  	/* Common part */
> -	cros_ec_core_channel_init(state->core.channels, 1);
> -	state->core.channels[1].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> -	state->core.channels[1].info_mask_shared_by_all =
> +	cros_ec_core_channel_init(state->channels, 1);
> +	state->channels[1].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	state->channels[1].info_mask_shared_by_all =
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_FREQUENCY);
>  
> -	state->core.calib[0] = 0;
> +	state->calib[0] = 0;
>  
>  	/* Sensor specific */
> -	switch (state->core.type) {
> +	switch (state->type) {
>  	case MOTIONSENSE_TYPE_BARO:
> -		state->core.channels[1].type = IIO_PRESSURE;
> +		state->channels[1].type = IIO_PRESSURE;
>  		break;
>  	default:
>  		dev_warn(dev, "Unknown motion sensor\n");
>  		return -EINVAL;
>  	}
>  
> -	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> +	state->read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
>  	return cros_ec_sensors_core_register(pdev, indio_dev);
>  }
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 60f40d253f4a..3e6de427076e 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -105,14 +105,13 @@ struct platform_device;
>  /**
>   * cros_ec_sensors_core_init() - basic initialization of the core structure
>   * @pdev:		platform device created for the sensors
> - * @sizeof_priv:	size of the private structure
>   * @num_channels:	Number of channel
>   * @physical_device:	true if the device refers to a physical device
>   *
>   * Return: 0 on success, -errno on failure.
>   */
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
> -			      int sizeof_priv, int num_channels,
> +			      int num_channels,
>  			      bool physical_device);
>  
>  /**

