Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE976F467
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGURkR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 13:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfGURkR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 13:40:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53AC2085A;
        Sun, 21 Jul 2019 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563730815;
        bh=RUwhWVbUL14IRol0RUGSko+CviOaKV+9cKBZjBLKF5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ivCYv0AlAmx6QgUfOt+/2ydtWb4ZiLWcYmqsnCnLZn9qnUK/yC1Iee4cky8MfRcqV
         IcYCzau5xeZMfgYPLH+3nST72YgmRjD5QFNeLBUFYNFeoQTGqWvArow5VyIcahhJim
         z1mHfe2tdJHhmkmgY1dTIVFz6B8xqioaob9VBRRU=
Date:   Sun, 21 Jul 2019 18:40:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Remove replacing error code with -EIO
Message-ID: <20190721184009.583c9031@archlinux>
In-Reply-To: <20190718222238.60087-1-gwendal@chromium.org>
References: <20190718222238.60087-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:22:37 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Due to an API misread, error code can be different for -EIO when reading
> a sysfs entry. Return the error reported by the cros_ec stack.
> 
> Check the proper error message (protocol error, not supported) is
> reported when there is an error returned by the EC stack.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Hi Gwendal,

If you are going to send a series of small patches for a driver
and they will inherently cause fuzz for each other, please just
have a small series called something like "misc fixes".

I clearly applied these in a different order to you, so needed
a bit of fixing up. I think I got it right, but please check.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 44 +++++++++++--------
>  drivers/iio/light/cros_ec_light_prox.c        | 36 +++++++--------
>  drivers/iio/pressure/cros_ec_baro.c           | 17 ++++---
>  3 files changed, 51 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 130362ca421b..ed29ac22dff8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -33,6 +33,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> +	int ret;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> @@ -60,9 +61,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  
>  		state->param.cmd = MOTIONSENSE_CMD_INFO;
>  		state->param.info.sensor_num = sensor_platform->sensor_num;
> -		if (cros_ec_motion_send_host_cmd(state, 0)) {
> +		ret = cros_ec_motion_send_host_cmd(state, 0);
> +		if (ret) {
>  			dev_warn(dev, "Can not access sensor info\n");
> -			return -EIO;
> +			return ret;
>  		}
>  		state->type = state->resp->info.type;
>  		state->loc = state->resp->info.location;
> @@ -86,7 +88,7 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>  
>  	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
>  	if (ret < 0)
> -		return -EIO;
> +		return ret;
>  
>  	if (ret &&
>  	    state->resp != (struct ec_response_motion_sense *)state->msg->data)
> @@ -396,7 +398,7 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
>  {
> -	int ret = IIO_VAL_INT;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -404,22 +406,27 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  		st->param.ec_rate.data =
>  			EC_MOTION_SENSE_NO_VALUE;
>  
> -		if (cros_ec_motion_send_host_cmd(st, 0))
> -			ret = -EIO;
> -		else
> -			*val = st->resp->ec_rate.ret;
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
> +		if (ret)
> +			break;
> +
> +		*val = st->resp->ec_rate.ret;
> +		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_FREQUENCY:
>  		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
>  		st->param.sensor_odr.data =
>  			EC_MOTION_SENSE_NO_VALUE;
>  
> -		if (cros_ec_motion_send_host_cmd(st, 0))
> -			ret = -EIO;
> -		else
> -			*val = st->resp->sensor_odr.ret;
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
> +		if (ret)
> +			break;
> +
> +		*val = st->resp->sensor_odr.ret;
> +		ret = IIO_VAL_INT;
>  		break;
>  	default:
> +		ret = -EINVAL;
>  		break;
>  	}
>  
> @@ -431,7 +438,7 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_FREQUENCY:
> @@ -441,17 +448,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  		/* Always roundup, so caller gets at least what it asks for. */
>  		st->param.sensor_odr.roundup = 1;
>  
> -		if (cros_ec_motion_send_host_cmd(st, 0))
> -			ret = -EIO;
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
>  		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
>  		st->param.ec_rate.data = val;
>  
> -		if (cros_ec_motion_send_host_cmd(st, 0))
> -			ret = -EIO;
> -		else
> -			st->curr_sampl_freq = val;
> +		ret = cros_ec_motion_send_host_cmd(st, 0);
> +		if (ret)
> +			break;
> +		st->curr_sampl_freq = val;
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 308ee6ff2e22..943fa305af91 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -42,7 +42,7 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
>  	u16 data = 0;
>  	s64 val64;
> -	int ret = IIO_VAL_INT;
> +	int ret;
>  	int idx = chan->scan_index;
>  
>  	mutex_lock(&st->core.cmd_lock);
> @@ -50,23 +50,22 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (chan->type == IIO_PROXIMITY) {
> -			if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> -						     (s16 *)&data) < 0) {
> -				ret = -EIO;
> +			ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> +						     (s16 *)&data);
> +			if (ret)
>  				break;
> -			}
>  			*val = data;
> +			ret = IIO_VAL_INT;
>  		} else {
>  			ret = -EINVAL;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_PROCESSED:
>  		if (chan->type == IIO_LIGHT) {
> -			if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> -						     (s16 *)&data) < 0) {
> -				ret = -EIO;
> +			ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> +						     (s16 *)&data);
> +			if (ret)
>  				break;
> -			}
>  			/*
>  			 * The data coming from the light sensor is
>  			 * pre-processed and represents the ambient light
> @@ -82,15 +81,15 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
>  		st->core.param.sensor_offset.flags = 0;
>  
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
> -			ret = -EIO;
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret)
>  			break;
> -		}
>  
>  		/* Save values */
>  		st->core.calib[0] = st->core.resp->sensor_offset.offset[0];
>  
>  		*val = st->core.calib[idx];
> +		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		/*
> @@ -101,10 +100,9 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
>  		st->core.param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
>  
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
> -			ret = -EIO;
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret)
>  			break;
> -		}
>  
>  		val64 = st->core.resp->sensor_range.ret;
>  		*val = val64 >> 16;
> @@ -127,7 +125,7 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
>  			       int val, int val2, long mask)
>  {
>  	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;
>  	int idx = chan->scan_index;
>  
>  	mutex_lock(&st->core.cmd_lock);
> @@ -141,14 +139,12 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
>  		st->core.param.sensor_offset.offset[0] = st->core.calib[0];
>  		st->core.param.sensor_offset.temp =
>  					EC_MOTION_SENSE_INVALID_CALIB_TEMP;
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0))
> -			ret = -EIO;
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
>  		st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0))
> -			ret = -EIO;
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
>  		break;
>  	default:
>  		ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 034ce98d6e97..a648582b14a7 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -39,26 +39,29 @@ static int cros_ec_baro_read(struct iio_dev *indio_dev,
>  {
>  	struct cros_ec_baro_state *st = iio_priv(indio_dev);
>  	u16 data = 0;
> -	int ret = IIO_VAL_INT;
> +	int ret;
>  	int idx = chan->scan_index;
>  
>  	mutex_lock(&st->core.cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> -					     (s16 *)&data) < 0)
> -			ret = -EIO;
> +		ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> +					     (s16 *)&data);
> +		if (ret)
> +			break;
> +
>  		*val = data;
> +		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
>  		st->core.param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
>  
> -		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
> -			ret = -EIO;
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret)
>  			break;
> -		}
> +
>  		*val = st->core.resp->sensor_range.ret;
>  
>  		/* scale * in_pressure_raw --> kPa */

