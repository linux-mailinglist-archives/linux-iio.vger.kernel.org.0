Return-Path: <linux-iio+bounces-18691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14622A9DB60
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C4A1BA12CF
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6525C6ED;
	Sat, 26 Apr 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8r8QSwh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022217E4;
	Sat, 26 Apr 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745676737; cv=none; b=tb5vyOYUFK+8csMXzZHsvd0EDZRMoSVAPReCxZa4XPZHvHVKwHxfcO78kpM5eXhGQfLMFS1K00y3+nhNHGRp6KjviRGsWiAbZ6EsnEQoQwruco2I4vj0mnnwmWWkAi42NRThQ6UFrhBqr/EkmhlVOCFfG2Eh7FxmcYMDGjEzIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745676737; c=relaxed/simple;
	bh=uAJ+Hnm34at5kZHgOSrPTWhqpXg50ruO+0MgBxZLBAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nN1rRUKfRx+IkJBd892mv44hUAgnyJNbLslnJpEBEvGYgUcs8LLa67gkLMkRbNlca5q2YEXtDidJVvAhWulSvJ9dYwEteE5KNj0drQ7Qhwe/acqTs5ahLd1D2gXlP5kopCyLRaV9dnGhnUhd2/24IuCt53H5OipX1Ro1zNYwqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8r8QSwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4901DC4CEE2;
	Sat, 26 Apr 2025 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745676735;
	bh=uAJ+Hnm34at5kZHgOSrPTWhqpXg50ruO+0MgBxZLBAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8r8QSwhDmM82ZQ4bOQ3fThpT3C+4sTODlFXHNM90GCGGU5hjI6KH5KpX7IsufBpp
	 h4ZoCr9JbfMrut1WEFLpRz5XkyhRa9k5KxYI497Ozg0WHVH7NfeXeHIOcm5XshGOQN
	 4MZyxnaLcnUPbLoO1bVaXmPsZyPp8CAaCF+MFjCuuAN4iMYjOb7H+Eq94ePEnUCno3
	 u6u1WWsShvPc4GXO7sFet2hgLlU+1pruujG7s5x/6Dy08PuVEVwhi4oabrzfeMNYWq
	 qfoU8gUpwJkiDcxAs5HqmIdfOVFLcIHDLBcPx011GBJArkVMkA/0E0ettCcWYG+Og/
	 2paZ8cQqPTbPw==
Date: Sat, 26 Apr 2025 15:12:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <20250426151209.46301c4e@jic23-huawei>
In-Reply-To: <20250424-bmi270-events-v1-3-a6c722673e5f@gmail.com>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
	<20250424-bmi270-events-v1-3-a6c722673e5f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 21:14:52 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Add support for any-motion/no-motion events based on acceleration slope
> on each axis. Threshold and duration can be configured from userspace.
Hi Gustavo,

These events are a bit of a pain (as Lothar +CC has been discovering recently).

The detection of activity / motion is the (slightly) easier one, though here it sounds
like an adaptive threshold event. Despite wording it has nothing to do with the
slope that I can tell as no reference to dividing by number of samples / time
or similar.  It's just a difference from an estimate of a last state that was interesting
(where there was considered to be motion)

So I think this is best described as an adaptive threshold? But on a magnitude...
Similar to,
in_accel_x|y|z_adaptive_thresh_rising_*
so we probably need to define
in_accel_x|y|z_adaptive_mag_rising_*

Though it has separate channel enables so
in_accel_x_adaptive_mag_rising_*
etc and report an or event as we don't know which axis tripped it (as you
did in this patch).

So no-motion.  The challenge Lothar ran into recently was how we make it
clear what is going on wrt to x&y&z and with separate enables.  We concluded
in the end there was little use for a no motion type detector if we didn't
enable it on all axes.  Otherwise we have to do x&y, x&z an y&z event channels
and event codes just to describe what is enabled.

This time it does seem to be rate of change, so you need a 'pseudo' (made
up additional) channel for x&y&z and then have

in_accel_x&y&z_roc_rising

I can't figure out where deta_t is coming from however so the scaling
of that is non obvious.

Given that means you need some significant changes in how this looks I haven't
reviewed the code in detail this time.

I was discussing with Lothar the other day that we need better documentation
for how to map from datasheet descriptions of events to actual events.
How different devices detect 'motion/nomotion' seems to vary a lot, so it
will need a fairly complex description.

Jonathan


> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 230 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 229 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 07a24ed9a4edabeafd98a746ba09469f9e41c38a..57734f9cf5906aa77b7a14dfba793559a817c1e7 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -31,6 +31,8 @@
>  
>  #define BMI270_INT_STATUS_0_REG				0x1c
>  #define BMI270_INT_STATUS_0_STEP_CNT_MSK		BIT(1)
> +#define BMI270_INT_STATUS_0_NOMOTION_MSK		BIT(5)
> +#define BMI270_INT_STATUS_0_MOTION_MSK			BIT(6)
>  
>  #define BMI270_INT_STATUS_1_REG				0x1d
>  #define BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK		GENMASK(7, 6)
> @@ -81,6 +83,8 @@
>  #define BMI270_INT1_MAP_FEAT_REG			0x56
>  #define BMI270_INT2_MAP_FEAT_REG			0x57
>  #define BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK		BIT(1)
> +#define BMI270_INT_MAP_FEAT_NOMOTION_MSK		BIT(5)
> +#define BMI270_INT_MAP_FEAT_ANYMOTION_MSK		BIT(6)
>  
>  #define BMI270_INT_MAP_DATA_REG				0x58
>  #define BMI270_INT_MAP_DATA_DRDY_INT1_MSK		BIT(2)
> @@ -106,10 +110,25 @@
>  #define BMI270_STEP_SC26_RST_CNT_MSK			BIT(10)
>  #define BMI270_STEP_SC26_EN_CNT_MSK			BIT(12)
>  
> +#define BMI270_FEAT_MOTION_DURATION_MSK			GENMASK(12, 0)
> +#define BMI270_FEAT_MOTION_XYZ_MSK			GENMASK(15, 13)
> +#define BMI270_FEAT_MOTION_THRESHOLD_MSK		GENMASK(10, 0)
> +#define BMI270_FEAT_MOTION_OUT_CONF_MSK			GENMASK(14, 11)
> +#define BMI270_FEAT_MOTION_ENABLE_MSK			BIT(15)
> +
> +#define BMI270_MOTION_XYZ_MSK				GENMASK(2, 0)
> +
> +#define BMI270_MOTION_THRES_SCALE			GENMASK(10, 0)
> +#define BMI270_MOTION_DURAT_SCALE			50
> +
>  /* See datasheet section 4.6.14, Temperature Sensor */
>  #define BMI270_TEMP_OFFSET				11776
>  #define BMI270_TEMP_SCALE				1953125
>  
> +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) ((val) * (scale) + \
> +						  ((val2) * (scale)) / MEGA)
> +#define BMI270_RAW_TO_MICRO(raw, scale) ((((raw) % (scale)) * MEGA) / scale)
> +
>  #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
>  #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
>  
> @@ -301,6 +320,13 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
>  };
>  
>  enum bmi270_feature_reg_id {
> +	/* Page 1 registers */
> +	BMI270_ANYMO1_REG,
> +	BMI270_ANYMO2_REG,
> +	/* Page 2 registers */
> +	BMI270_NOMO1_REG,
> +	BMI270_NOMO2_REG,
> +	/* Page 6 registers */
>  	BMI270_SC_26_REG,
>  };
>  
> @@ -310,6 +336,22 @@ struct bmi270_feature_reg {
>  };
>  
>  static const struct bmi270_feature_reg bmi270_feature_regs[] = {
> +	[BMI270_ANYMO1_REG] = {
> +		.page = 1,
> +		.addr = 0x3c,
> +	},
> +	[BMI270_ANYMO2_REG] = {
> +		.page = 1,
> +		.addr = 0x3e,
> +	},
> +	[BMI270_NOMO1_REG] = {
> +		.page = 2,
> +		.addr = 0x30,
> +	},
> +	[BMI270_NOMO2_REG] = {
> +		.page = 2,
> +		.addr = 0x32,
> +	},
>  	[BMI270_SC_26_REG] = {
>  		.page = 6,
>  		.addr = 0x32,
> @@ -426,6 +468,72 @@ static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
>  
>  	set_mask_bits(&data->feature_events,
>  		      BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, field_value);
> +
> +	return 0;
> +}
> +
> +static int bmi270_motion_config_reg(enum iio_event_direction dir)
> +{
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		return BMI270_ANYMO1_REG;
> +	case IIO_EV_DIR_FALLING:
> +		return BMI270_NOMO1_REG;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bmi270_motion_event_en(struct bmi270_data *data,
> +				  enum iio_event_direction dir, bool state)
> +{
> +	int ret, config1, config2, irq_reg;
> +	int irq_msk, irq_field_val;
> +
> +	irq_reg = bmi270_int_map_reg(data->irq_pin);
> +	if (irq_reg < 0)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		config1 = BMI270_ANYMO1_REG;
> +		config2 = BMI270_ANYMO2_REG;
> +		irq_msk = BMI270_INT_MAP_FEAT_ANYMOTION_MSK;
> +		irq_field_val = FIELD_PREP(BMI270_INT_MAP_FEAT_ANYMOTION_MSK,
> +					   state);
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		config1 = BMI270_NOMO1_REG;
> +		config2 = BMI270_NOMO2_REG;
> +		irq_msk = BMI270_INT_MAP_FEAT_NOMOTION_MSK;
> +		irq_field_val = FIELD_PREP(BMI270_INT_MAP_FEAT_NOMOTION_MSK,
> +					   state);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&data->mutex);
> +	ret = bmi270_update_feature_reg(data, config1,
> +					BMI270_FEAT_MOTION_XYZ_MSK,
> +					FIELD_PREP(BMI270_FEAT_MOTION_XYZ_MSK,
> +						   state ? BMI270_MOTION_XYZ_MSK : 0));
> +	if (ret)
> +		return ret;
> +
> +	ret = bmi270_update_feature_reg(data, config2,
> +					BMI270_FEAT_MOTION_ENABLE_MSK,
> +					FIELD_PREP(BMI270_FEAT_MOTION_ENABLE_MSK,
> +						   state));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, irq_reg, irq_msk, irq_field_val);
> +	if (ret)
> +		return ret;
> +
> +	set_mask_bits(&data->feature_events, irq_msk, irq_field_val);
> +
>  	return 0;
>  }
>  
> @@ -604,6 +712,20 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
>  	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))
>  		iio_trigger_poll_nested(data->trig);
>  
> +	if (FIELD_GET(BMI270_INT_STATUS_0_MOTION_MSK, status0))
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							     IIO_MOD_X_OR_Y_OR_Z,
> +							     IIO_EV_TYPE_MAG,
> +							     IIO_EV_DIR_RISING),
> +			       timestamp);
> +
> +	if (FIELD_GET(BMI270_INT_STATUS_0_NOMOTION_MSK, status0))
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
No motion tends to be X_AND_Y_AND_Z.

Which we tend to need to represent as a separate 'pseudo' channel so that we
can have in_accel_x&y&z_mag_falling or similar.



> +							     IIO_MOD_X_OR_Y_OR_Z,
> +							     IIO_EV_TYPE_MAG,
> +							     IIO_EV_DIR_FALLING),
> +			       timestamp);
> +
>  	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
>  							     IIO_NO_MOD,
> @@ -820,6 +942,20 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static IIO_CONST_ATTR(in_accel_mag_value_available, "[0.0 0.00049 1.0]");
> +
> +static IIO_CONST_ATTR(in_accel_mag_period_available, "[0.0 0.02 162.0]");
> +
> +static struct attribute *bmi270_event_attributes[] = {
> +	&iio_const_attr_in_accel_mag_value_available.dev_attr.attr,
> +	&iio_const_attr_in_accel_mag_period_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group bmi270_event_attribute_group = {
> +	.attrs = bmi270_event_attributes,
> +};
> +
>  static int bmi270_write_event_config(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     enum iio_event_type type,
> @@ -828,6 +964,8 @@ static int bmi270_write_event_config(struct iio_dev *indio_dev,
>  	struct bmi270_data *data = iio_priv(indio_dev);
>  
>  	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		return bmi270_motion_event_en(data, dir, state);
>  	case IIO_EV_TYPE_CHANGE:
>  		return bmi270_step_wtrmrk_en(data, state);
>  	default:
> @@ -847,6 +985,17 @@ static int bmi270_read_event_config(struct iio_dev *indio_dev,
>  	guard(mutex)(&data->mutex);
>  
>  	switch (chan->type) {
> +	case IIO_ACCEL:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return FIELD_GET(BMI270_INT_MAP_FEAT_ANYMOTION_MSK,
> +					 data->feature_events) ? 1 : 0;
> +		case IIO_EV_DIR_FALLING:
> +			return FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK,
> +					 data->feature_events) ? 1 : 0;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_STEPS:
>  		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
>  				 data->feature_events) ? 1 : 0;
> @@ -864,10 +1013,42 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
>  {
>  	struct bmi270_data *data = iio_priv(indio_dev);
>  	unsigned int raw;
> +	int reg;
>  
>  	guard(mutex)(&data->mutex);
>  
>  	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		reg = bmi270_motion_config_reg(dir);
> +		if (reg < 0)
> +			return -EINVAL;
> +
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			if (!in_range(val, 0, 1))
> +				return -EINVAL;
> +
> +			raw = BMI270_INT_MICRO_TO_RAW(val, val2,
> +						      BMI270_MOTION_THRES_SCALE);
> +
> +			return bmi270_update_feature_reg(data, reg,
> +				BMI270_FEAT_MOTION_THRESHOLD_MSK,
> +				FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK,
> +					   raw));
> +		case IIO_EV_INFO_PERIOD:
> +			if (!in_range(val, 0, 163))
> +				return -EINVAL;
> +
> +			raw = BMI270_INT_MICRO_TO_RAW(val, val2,
> +						      BMI270_MOTION_DURAT_SCALE);
> +
> +			return bmi270_update_feature_reg(data, reg,
> +				BMI270_FEAT_MOTION_DURATION_MSK,
> +				FIELD_PREP(BMI270_FEAT_MOTION_DURATION_MSK,
> +					   raw));
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_EV_TYPE_CHANGE:
>  		if (!in_range(val, 0, 20461))
>  			return -EINVAL;
> @@ -891,12 +1072,39 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
>  {
>  	struct bmi270_data *data = iio_priv(indio_dev);
>  	unsigned int raw;
> +	int ret, reg;
>  	u16 reg_val;
> -	int ret;
>  
>  	guard(mutex)(&data->mutex);
>  
>  	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		reg = bmi270_motion_config_reg(dir);
> +		if (reg < 0)
> +			return -EINVAL;
> +
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = bmi270_read_feature_reg(data, reg, &reg_val);
> +			if (ret)
> +				return ret;
> +
> +			raw = FIELD_GET(BMI270_FEAT_MOTION_THRESHOLD_MSK, reg_val);
> +			*val = raw / BMI270_MOTION_THRES_SCALE;
> +			*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_THRES_SCALE);
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_EV_INFO_PERIOD:
> +			ret = bmi270_read_feature_reg(data, reg, &reg_val);
> +			if (ret)
> +				return ret;
> +
> +			raw = FIELD_GET(BMI270_FEAT_MOTION_DURATION_MSK, reg_val);
> +			*val = raw / BMI270_MOTION_DURAT_SCALE;
> +			*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_DURAT_SCALE);
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_EV_TYPE_CHANGE:
>  		ret = bmi270_read_feature_reg(data, BMI270_SC_26_REG, &reg_val);
>  		if (ret)
> @@ -917,6 +1125,23 @@ static const struct iio_event_spec bmi270_step_wtrmrk_event = {
>  			       BIT(IIO_EV_INFO_VALUE),
>  };
>  

