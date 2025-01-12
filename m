Return-Path: <linux-iio+bounces-14238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09700A0AAD4
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7863A4808
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C11BD9E1;
	Sun, 12 Jan 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSLk9jJZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C120DF4;
	Sun, 12 Jan 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699243; cv=none; b=cX69CkIf3wHz7JOHftwrJxd8lM6Hak8WsFUM3ThIwZ7IYvaSQmclgRx7lREK9jEdeNUqMOZn0c3zPyvBJt/+rYdvSeW7zP0WWsS5kYhMSwYhlaBQCuL0Q5wndy4YUfiG5rjCZAmzUn8mVbV+04HdSkBpnue03id7uqB8GmsDUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699243; c=relaxed/simple;
	bh=EyhKgF7+Cgs6p2dFdrFGigS3qS9Esq3t4gzcyqsunFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7X+IPULglo7rGqlHJGBcXAvW8x690uAQtSCwvnHesU575DmBq8N8llHXBVUyjKwE2AGJZKn9hV6oI45VbcTkD8HqelviokYl7WhfWSoHnRL1KBceM6RbFXwh+81Hho/s9bBI5NDCgMFapH9iiheIrs55ltn9XTz8oFF1zH+suA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSLk9jJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CC3C4CEDF;
	Sun, 12 Jan 2025 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736699242;
	bh=EyhKgF7+Cgs6p2dFdrFGigS3qS9Esq3t4gzcyqsunFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NSLk9jJZagjHQExu+BYBXFFiXh+511zOyric1GhrWM1vv54+e8/3ROIoliGCU1wwe
	 VItoah0EcuCdx/x6ctvKKhBH7cQsgsSCC+VtR1kK2AqHa2cJeU7x5vvv0ribKjQDhv
	 IPCn+WSnAhi72i1XEM4c0Azq69ez9rC5hy2YhpVv7nJiBMXOyOqu8DzXVneck3rObp
	 FFgIUjqRNM8oNfpy06//Ni+uA9LbruOZhzyweZ62QRNKKn2KeBx90xyQXW7CqWiEIB
	 sGxsSK5UIOjtbwcyUpln/5Tg2h8T5xl+xQMLh942NK07MxoP2A8i+fM1/YfiGgvpa7
	 HWl+Mw3RB+F9Q==
Date: Sun, 12 Jan 2025 16:27:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: add temperature channel
Message-ID: <20250112162715.16249380@jic23-huawei>
In-Reply-To: <20250111-bmi270-temp-v1-1-76ee38211bf2@gmail.com>
References: <20250111-bmi270-temp-v1-1-76ee38211bf2@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 14:26:18 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> The BMI270 IMU includes a temperature sensor. Add a channel for reading
> the temperature.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Hi Gustavo,

A few minor comments inline,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 49 ++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 7fec52e0b48624f07031b63a9caf6c318f33f5dc..c7853923aa69f83a829a71979135f1f7a7ef29ec 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -5,6 +5,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -28,10 +29,11 @@
>  #define BMI270_INTERNAL_STATUS_REG			0x21
>  #define BMI270_INTERNAL_STATUS_MSG_MSK			GENMASK(3, 0)
>  #define BMI270_INTERNAL_STATUS_MSG_INIT_OK		0x01
> -
>  #define BMI270_INTERNAL_STATUS_AXES_REMAP_ERR_MSK	BIT(5)
>  #define BMI270_INTERNAL_STATUS_ODR_50HZ_ERR_MSK		BIT(6)
>  
> +#define BMI270_TEMPERATURE_0_REG			0x22
> +
>  #define BMI270_ACC_CONF_REG				0x40
>  #define BMI270_ACC_CONF_ODR_MSK				GENMASK(3, 0)
>  #define BMI270_ACC_CONF_ODR_100HZ			0x08
> @@ -69,6 +71,10 @@
>  #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
>  #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
>  
> +/* See datasheet section 4.6.14, Temperature Sensor */
> +#define BMI270_TEMP_OFFSET				11776
> +#define BMI270_TEMP_SCALE				1953125
> +
>  #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
>  #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
>  
> @@ -109,6 +115,7 @@ EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, "IIO_BMI270");
>  enum bmi270_sensor_type {
>  	BMI270_ACCEL	= 0,
>  	BMI270_GYRO,
> +	BMI270_TEMP,
>  };
>  
>  struct bmi270_scale {
> @@ -136,6 +143,10 @@ static const struct bmi270_scale bmi270_gyro_scale[] = {
>  	{ 0, 66 },
>  };
>  
> +static const struct bmi270_scale bmi270_temp_scale[] = {
> +	{BMI270_TEMP_SCALE / MEGA, BMI270_TEMP_SCALE % MEGA},

	{ BMI270_TEMP_SCALE / MEGA, BMI270_TEMP_SCALE % MEGA },

Maybe MICRO is the better choice (and same value).

 
> +};
> +
>  struct bmi270_scale_item {
>  	const struct bmi270_scale *tbl;
>  	int num;
> @@ -150,6 +161,10 @@ static const struct bmi270_scale_item bmi270_scale_table[] = {
>  		.tbl	= bmi270_gyro_scale,
>  		.num	= ARRAY_SIZE(bmi270_gyro_scale),
>  	},
> +	[BMI270_TEMP] = {
> +		.tbl	= bmi270_temp_scale,
> +		.num	= ARRAY_SIZE(bmi270_temp_scale),
> +	},
>  };
>  
>  static const struct bmi270_odr bmi270_accel_odr[] = {
> @@ -255,7 +270,7 @@ static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
>  }
>  
>  static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
> -			    int *uscale)
> +			    int *scale, int *uscale)
>  {
>  	int ret;
>  	unsigned int val;
> @@ -280,6 +295,10 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
>  		val = FIELD_GET(BMI270_GYR_CONF_RANGE_MSK, val);
>  		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
>  		break;
> +	case IIO_TEMP:
> +		val = 0;
> +		bmi270_scale_item = bmi270_scale_table[BMI270_TEMP];
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -287,6 +306,7 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
>  	if (val >= bmi270_scale_item.num)
>  		return -EINVAL;
>  
> +	*scale = bmi270_scale_item.tbl[val].scale;
>  	*uscale = bmi270_scale_item.tbl[val].uscale;
>  	return 0;
>  }
> @@ -399,6 +419,9 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
>  	case IIO_ANGL_VEL:
>  		reg = BMI270_ANG_VEL_X_REG + (axis - IIO_MOD_X) * 2;
>  		break;
> +	case IIO_TEMP:
> +		reg = BMI270_TEMPERATURE_0_REG;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -427,12 +450,20 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		ret = bmi270_get_scale(bmi270_device, chan->type, val2);
> +		ret = bmi270_get_scale(bmi270_device, chan->type, val, val2);
>  		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = BMI270_TEMP_OFFSET;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = bmi270_get_odr(bmi270_device, chan->type, val, val2);
>  		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +

Unrelated change.  Good to remove these before posting a patch as it
just adds noise.  If you want to tidy up white space that is fine but
not in the same patch as anything making functional changes.

>  	default:
>  		return -EINVAL;
>  	}
> @@ -544,6 +575,13 @@ static const struct iio_chan_spec bmi270_channels[] = {
>  	BMI270_ANG_VEL_CHANNEL(X),
>  	BMI270_ANG_VEL_CHANNEL(Y),
>  	BMI270_ANG_VEL_CHANNEL(Z),
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = -1, /* No buffer support */
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
>  };
>  
> @@ -646,7 +684,8 @@ static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
>  	ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
>  			      BMI270_PWR_CTRL_AUX_EN_MSK |
>  			      BMI270_PWR_CTRL_GYR_EN_MSK |
> -			      BMI270_PWR_CTRL_ACCEL_EN_MSK);
> +			      BMI270_PWR_CTRL_ACCEL_EN_MSK |
> +			      BMI270_PWR_CTRL_TEMP_EN_MSK);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
>  
> 
> ---
> base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
> change-id: 20250111-bmi270-temp-e9d253619180
> 
> Best regards,


