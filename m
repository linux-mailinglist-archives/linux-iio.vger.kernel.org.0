Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38246F45B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfGURet (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 13:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGURes (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 13:34:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C25A205C9;
        Sun, 21 Jul 2019 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563730487;
        bh=ogT2y9nvJhxO8o2y0Z86frTfbrjtzmAYaUMx3G2/Xsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wdodawWW1XqwqQ/euGiynPvGoKX+8+X1L7SrnE49ElsZsvY0Q2dgwO2OTY+2aQxe2
         PE4YzEgGjGejhtUyJrERZOtDCo2gOZKRFzPlu8Yojl5lEJsHlEnuZTAqo/LLWgPWta
         cE70V6NNZh3pQ/w49TDaHH1daw7UKjSoSuJv/muY=
Date:   Sun, 21 Jul 2019 18:34:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Add calibscale for 3d MEMS
Message-ID: <20190721183441.6b3c0eb9@archlinux>
In-Reply-To: <20190718232825.183662-1-gwendal@chromium.org>
References: <20190718232825.183662-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 16:28:24 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add calibration scale support to accel, gyro and magnetometer.
> 
> Check on eve with current firmware, check reading calibscale returns 1.0,
> check with newer firmware values are applied.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing.
If anyone wants to comment, there is still time as I won't be
pushing that out as non rebasing for a while yet.

Thanks,

Jonathan

> ---
> 
>  .../common/cros_ec_sensors/cros_ec_sensors.c  | 51 +++++++++++++++++--
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  2 +-
>  drivers/iio/light/cros_ec_light_prox.c        | 12 ++---
>  drivers/iio/pressure/cros_ec_baro.c           |  2 -
>  .../linux/iio/common/cros_ec_sensors_core.h   |  5 +-
>  5 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 17af4e0fd5f8..2af09606c438 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -63,10 +63,35 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>  
>  		/* Save values */
>  		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> -			st->core.calib[i] =
> +			st->core.calib[i].offset =
>  				st->core.resp->sensor_offset.offset[i];
>  		ret = IIO_VAL_INT;
> -		*val = st->core.calib[idx];
> +		*val = st->core.calib[idx].offset;
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_SCALE;
> +		st->core.param.sensor_offset.flags = 0;
> +
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret == -EPROTO) {
> +			/* Reading calibscale is not supported on older EC. */
> +			*val = 1;
> +			*val2 = 0;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
> +		} else if (ret) {
> +			break;
> +		}
> +
> +		/* Save values */
> +		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> +			st->core.calib[i].scale =
> +				st->core.resp->sensor_scale.scale[i];
> +
> +		*val = st->core.calib[idx].scale >> 15;
> +		*val2 = ((st->core.calib[idx].scale & 0x7FFF) * 1000000LL) /
> +			MOTION_SENSE_DEFAULT_SCALE;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> @@ -134,7 +159,7 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		st->core.calib[idx] = val;
> +		st->core.calib[idx].offset = val;
>  
>  		/* Send to EC for each axis, even if not complete */
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> @@ -142,10 +167,25 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
>  			MOTION_SENSE_SET_OFFSET;
>  		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
>  			st->core.param.sensor_offset.offset[i] =
> -				st->core.calib[i];
> +				st->core.calib[i].offset;
>  		st->core.param.sensor_offset.temp =
>  			EC_MOTION_SENSE_INVALID_CALIB_TEMP;
>  
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		st->core.calib[idx].scale = val;
> +		/* Send to EC for each axis, even if not complete */
> +
> +		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_SCALE;
> +		st->core.param.sensor_offset.flags =
> +			MOTION_SENSE_SET_OFFSET;
> +		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> +			st->core.param.sensor_scale.scale[i] =
> +				st->core.calib[i].scale;
> +		st->core.param.sensor_scale.temp =
> +			EC_MOTION_SENSE_INVALID_CALIB_TEMP;
> +
>  		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> @@ -206,7 +246,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  		/* Common part */
>  		channel->info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_CALIBBIAS);
> +			BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +			BIT(IIO_CHAN_INFO_CALIBSCALE);
>  		channel->info_mask_shared_by_all =
>  			BIT(IIO_CHAN_INFO_SCALE) |
>  			BIT(IIO_CHAN_INFO_FREQUENCY) |
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 130362ca421b..96d5aa1f4bd5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -118,7 +118,7 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
>  	} else {
>  		/* Save values */
>  		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> -			st->calib[i] = st->resp->perform_calib.offset[i];
> +			st->calib[i].offset = st->resp->perform_calib.offset[i];
>  	}
>  	mutex_unlock(&st->cmd_lock);
>  
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 308ee6ff2e22..b81746a99f1f 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -88,9 +88,10 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>  		}
>  
>  		/* Save values */
> -		st->core.calib[0] = st->core.resp->sensor_offset.offset[0];
> +		st->core.calib[0].offset =
> +			st->core.resp->sensor_offset.offset[0];
>  
> -		*val = st->core.calib[idx];
> +		*val = st->core.calib[idx].offset;
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		/*
> @@ -134,11 +135,12 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		st->core.calib[idx] = val;
> +		st->core.calib[idx].offset = val;
>  		/* Send to EC for each axis, even if not complete */
>  		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
>  		st->core.param.sensor_offset.flags = MOTION_SENSE_SET_OFFSET;
> -		st->core.param.sensor_offset.offset[0] = st->core.calib[0];
> +		st->core.param.sensor_offset.offset[0] =
> +			st->core.calib[0].offset;
>  		st->core.param.sensor_offset.temp =
>  					EC_MOTION_SENSE_INVALID_CALIB_TEMP;
>  		if (cros_ec_motion_send_host_cmd(&st->core, 0))
> @@ -205,8 +207,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  	channel->ext_info = cros_ec_sensors_ext_info;
>  	channel->scan_type.sign = 'u';
>  
> -	state->core.calib[0] = 0;
> -
>  	/* Sensor specific */
>  	switch (state->core.type) {
>  	case MOTIONSENSE_TYPE_LIGHT:
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 034ce98d6e97..d3acba7ba582 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -152,8 +152,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  	channel->ext_info = cros_ec_sensors_ext_info;
>  	channel->scan_type.sign = 'u';
>  
> -	state->core.calib[0] = 0;
> -
>  	/* Sensor specific */
>  	switch (state->core.type) {
>  	case MOTIONSENSE_TYPE_BARO:
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 0c636b9fe8d7..bb03a252bd04 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -62,7 +62,10 @@ struct cros_ec_sensors_core_state {
>  	enum motionsensor_type type;
>  	enum motionsensor_location loc;
>  
> -	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
> +	struct calib_data {
> +		s16 offset;
> +		u16 scale;
> +	} calib[CROS_EC_SENSOR_MAX_AXIS];
>  
>  	u8 samples[CROS_EC_SAMPLE_SIZE];
>  

