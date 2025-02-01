Return-Path: <linux-iio+bounces-14847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2FA24B2B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531B91886D88
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D141C8FB5;
	Sat,  1 Feb 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrjE7KlW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C01BD9C8;
	Sat,  1 Feb 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431688; cv=none; b=eXj7v5t0k7G9SenHOQpXY1/9+QwiylY08I6rJrh5/PA6Bt8wG0QCMMUinHFo/hpSpyZ8H9G0rfwd7E8fnHI5jKCAIe7EUKsqiSpySbHykR+mCnaC9X8mUcrsvu3pj/ZdNsNqHKmvd3PZwhnDzj19CnHWv6KJ/p/gVsvbZZDOSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431688; c=relaxed/simple;
	bh=XR5L8IT+dE8v6IzCoKRIoNKI+WAoBpzeY7E1DEE4VKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pslSey4N5x804Rp1YvIQTqHM4HqTMmocZU63znsM29RMIgHqnUK/ZzO/RS0MujREDVztw77lll98RlSQquDTMrtqJVqBMJYU0BAqcX4b6+FGrmd3G9a+1NNw4bzl7TxY05dt7VEom1lCiqi9yzYk4FmMw7Oln0rhwCBNTmd0mZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrjE7KlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39CDC4CED3;
	Sat,  1 Feb 2025 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738431687;
	bh=XR5L8IT+dE8v6IzCoKRIoNKI+WAoBpzeY7E1DEE4VKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RrjE7KlWofQ+dEJIBAPy39/Ye6iIuCYSJKXvN6vILB8hBrW0u9T28kYS+PIxyP5jN
	 xd4KM9XmkOTPBGPA6jht7B7leg3cTHXFxCkYBFB8GIcWdJhsgfarpgg7oUdW7tE97M
	 KTQg5Nsy1GxbESao5y3iQ0uC8aoSV98x71MFS9dfCXcz+fXIVYlixx42zQr6WzmqBL
	 doopUPCywLGr7HjWMS1hiOY5+u1JxjJaBrWPnyP1T/X+RLQcT/92OqxU3I6YU1cyFJ
	 ZAuPX3rWw8yd0hX1xDkkD1OOJ07nGc2jlfJk4SGJ6JyLCfMmJt2EKTFj2DIUOfLJ6O
	 MWNWeUKtjR5ug==
Date: Sat, 1 Feb 2025 17:41:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 12/12] iio: accel: adxl345: add inactivity feature
Message-ID: <20250201174122.3002e753@jic23-huawei>
In-Reply-To: <20250128120100.205523-13-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-13-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:01:00 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add handling for inactivity events, together with threshold and timeout
> to trigger the event. The event could be used for ODR and g range
> reduction for power saving using low power modes or sleep modes, not
> covered by this patch.

This is a falling magnitude threshold.  The complexity you'll hit
here is we don't support more than one on a given axis. So this clashes
with free fall detection.

Argument for that long ago was that it complicates the interface a lot
and is mostly pointless as we take action of the first event.
Whether that matters here depends on whether you can do freefall as
all axis (which is all that makes sense as falling devices tend to flip)
and this on a per axis basis. In which case can easily support both with
standard ABI. Just need a magic channel for the freefall configuration
that has only events and sets X_AND_Y_AND_Z as the direction as all
must be below the threshold to see an interrupt.

For the AC / DC thing we normally support that as TYPE_MAG_REFERENCED
which might also be a good choice.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 167 ++++++++++++++++++++++++++-----
>  1 file changed, 142 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 94c3ad818ba5..b9f42c56e8f1 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -123,6 +123,8 @@
>  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
>  #define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
> +#define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
> +#define ADXL345_REG_INACT_ACDC_MSK	BIT(3)
>  
>  enum adxl345_axis {
>  	ADXL345_Z_EN = BIT(0),
> @@ -155,6 +157,32 @@ static const unsigned int adxl345_tap_time_reg[3] = {
>  	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
>  };
>  
> +/* activity/inactivity */
> +enum adxl345_activity_type {
> +	ADXL345_ACTIVITY,
> +	ADXL345_INACTIVITY
> +};
> +
> +static const unsigned int adxl345_act_int_reg[2] = {
> +	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
> +	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
> +};
> +
> +static const unsigned int adxl345_act_thresh_reg[2] = {
> +	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
> +	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
> +};
> +
> +static const unsigned int adxl345_act_acdc_msk[2] = {
> +	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_ACDC_MSK,
> +	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK
> +};
> +
> +static const unsigned int adxl345_act_axis_msk[2] = {
> +	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
> +	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_AXIS_MSK
> +};
> +
>  struct adxl345_state {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> @@ -169,6 +197,11 @@ struct adxl345_state {
>  	bool act_ac;
>  	u8 act_value;
>  
> +	u32 inact_axis_ctrl;
> +	bool inact_ac;
> +	u8 inact_value;
> +	u8 inact_time_s;
> +
>  	u32 tap_axis_ctrl;
>  	u8 tap_threshold;
>  	u32 tap_duration_us;
> @@ -188,6 +221,11 @@ static struct iio_event_spec adxl345_events[] = {
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_RISING,
>  	},
> +	{
> +		/* inactivity */
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +	},
>  	{
>  		/* single tap */
>  		.type = IIO_EV_TYPE_GESTURE,
> @@ -289,7 +327,8 @@ static inline int adxl345_write_interrupts(struct adxl345_state *st)
>  
>  /* act/inact */
>  
> -static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
> +static int adxl345_write_act_axis(struct adxl345_state *st,
> +				  enum adxl345_activity_type type, bool en)
>  {
>  	int ret;
>  
> @@ -316,7 +355,9 @@ static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
>  	 * inactive and the inactivity interrupt is triggered.
>  	 */
>  	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> -				 ADXL345_REG_ACT_ACDC_MSK, st->act_ac);
> +				 adxl345_act_acdc_msk[type],
> +				 (type == ADXL345_ACTIVITY
> +				  ? st->act_ac : st->inact_ac));
>  	if (ret)
>  		return ret;
>  
> @@ -326,32 +367,52 @@ static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
>  	 * kept in sync, i.e. an axis will be generally enabled or disabled for
>  	 * both equally, activity and inactivity detection.
>  	 */
> -	st->act_axis_ctrl = en
> -		? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
> -		: st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
> +	if (type == ADXL345_ACTIVITY) {
> +		st->act_axis_ctrl = en
> +			? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
> +			: st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
> +
> +		ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> +					 adxl345_act_axis_msk[type],
> +					 st->act_axis_ctrl);
> +		if (ret)
> +			return ret;
>  
> -	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> -				 ADXL345_REG_ACT_AXIS_MSK,
> -				 st->act_axis_ctrl);
> -	if (ret)
> -		return ret;
> +	} else {
> +		st->inact_axis_ctrl = en
> +			? st->inact_axis_ctrl | ADXL345_REG_INACT_AXIS_MSK
> +			: st->inact_axis_ctrl & ~ADXL345_REG_INACT_AXIS_MSK;
>  
> +		ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> +					 adxl345_act_axis_msk[type],
> +					 st->inact_axis_ctrl);
> +		if (ret)
> +			return ret;
> +	}
>  	return 0;
>  }
>  
> -static int adxl345_set_act_int(struct adxl345_state *st)
> +static int adxl345_set_act_int(struct adxl345_state *st,
> +			       enum adxl345_activity_type type)
>  {
>  	bool args_valid;
>  	bool axis_en;
>  
> -	axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
> -	args_valid = axis_en && st->act_value > 0;
> -	adxl345_intmap_switch_bit(st, args_valid, ADXL345_INT_ACTIVITY);
> +	if (type == ADXL345_ACTIVITY) {
> +		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
> +		args_valid = axis_en && st->act_value > 0;
> +	} else {
> +		axis_en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, st->inact_axis_ctrl) > 0;
> +		args_valid = axis_en && st->inact_value > 0 &&
> +			st->inact_time_s > 0;
> +	}
> +	adxl345_intmap_switch_bit(st, args_valid, adxl345_act_int_reg[type]);
>  
>  	return adxl345_write_interrupts(st);
>  }
>  
> -static int _adxl345_is_act_en(struct adxl345_state *st, bool *en)
> +static int _adxl345_is_act_en(struct adxl345_state *st,
> +			      enum adxl345_activity_type type, bool *en)
>  {
>  	int ret;
>  	unsigned int regval;
> @@ -360,42 +421,76 @@ static int _adxl345_is_act_en(struct adxl345_state *st, bool *en)
>  	if (ret)
>  		return ret;
>  
> -	*en = FIELD_GET(ADXL345_INT_ACTIVITY, regval) > 0;
> +	*en = (adxl345_act_int_reg[type] & regval) > 0;
>  
>  	return 0;
>  }
>  
> -static int _adxl345_set_act_en(struct adxl345_state *st, bool en)
> +static int _adxl345_set_act_en(struct adxl345_state *st,
> +			       enum adxl345_activity_type type, bool en)
>  {
>  	int ret;
>  
> -	ret = adxl345_write_act_axis(st, en);
> +	ret = adxl345_write_act_axis(st, type, en);
>  	if (ret)
>  		return ret;
>  
> -	return adxl345_set_act_int(st);
> +	return adxl345_set_act_int(st, type);
>  }
>  
>  static int adxl345_is_act_en(struct adxl345_state *st, bool *en)
>  {
> -	return _adxl345_is_act_en(st, en);
> +	return _adxl345_is_act_en(st, ADXL345_ACTIVITY, en);
>  }
>  
>  static int adxl345_set_act_en(struct adxl345_state *st, bool en)
>  {
> -	return _adxl345_set_act_en(st, en);
> +	return _adxl345_set_act_en(st, ADXL345_ACTIVITY, en);
>  }
>  
> -static int _adxl345_set_act_value(struct adxl345_state *st, u8 val)
> +static int adxl345_is_inact_en(struct adxl345_state *st, bool *en)
>  {
> -	st->act_value = val;
> +	return _adxl345_is_act_en(st, ADXL345_INACTIVITY, en);
> +}
>  
> -	return regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, val);
> +static int adxl345_set_inact_en(struct adxl345_state *st, bool en)
> +{
> +	return _adxl345_set_act_en(st, ADXL345_INACTIVITY, en);
> +}
> +
> +static int _adxl345_set_act_value(struct adxl345_state *st,
> +				  enum adxl345_activity_type type, u8 val)
> +{
> +	switch (type) {
> +	case ADXL345_ACTIVITY:
> +		st->act_value = val;
> +		break;
> +	case ADXL345_INACTIVITY:
> +		st->inact_value = val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_write(st->regmap, adxl345_act_thresh_reg[type], val);
>  }
>  
>  static int adxl345_set_act_value(struct adxl345_state *st, u8 val)
>  {
> -	return _adxl345_set_act_value(st, val);
> +	return _adxl345_set_act_value(st, ADXL345_ACTIVITY, val);
> +}
> +
> +static int adxl345_set_inact_value(struct adxl345_state *st, u8 val)
> +{
> +	return _adxl345_set_act_value(st, ADXL345_INACTIVITY, val);
> +}
> +
> +static int adxl345_set_inact_time_s(struct adxl345_state *st, u32 val_s)
> +{
> +	st->inact_time_s = min(val_s, 0xff);
> +
> +	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT,
> +			    st->inact_time_s);
>  }
>  
>  /* tap */
> @@ -1027,6 +1122,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
>  
>  ADXL345_generate_iio_dev_attr_INT(activity, act, value);
> +ADXL345_generate_iio_dev_attr_INT(activity, inact, value);
> +ADXL345_generate_iio_dev_attr_INT(activity, inact, time_s);
>  ADXL345_generate_iio_dev_attr_INT(freefall, ff, value);
>  
>  ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
> @@ -1035,12 +1132,16 @@ ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO,
>  ADXL345_generate_iio_dev_attr_FRACTIONAL(freefall, ff, time, MILLI, ms);
>  
>  ADXL345_generate_iio_dev_attr_EN(activity, act);
> +ADXL345_generate_iio_dev_attr_EN(activity, inact);
>  ADXL345_generate_iio_dev_attr_EN(freefall, ff);
>  ADXL345_generate_iio_dev_attr_EN(gesture_doubletap, suppressed);
>  
>  static struct attribute *adxl345_event_attrs[] = {
>  	&iio_dev_attr_in_accel_activity_act_en.dev_attr.attr,
>  	&iio_dev_attr_in_accel_activity_act_value.dev_attr.attr,
> +	&iio_dev_attr_in_accel_activity_inact_en.dev_attr.attr,
> +	&iio_dev_attr_in_accel_activity_inact_value.dev_attr.attr,
> +	&iio_dev_attr_in_accel_activity_inact_time_s.dev_attr.attr,
>  	&iio_dev_attr_in_accel_freefall_ff_en.dev_attr.attr,
>  	&iio_dev_attr_in_accel_freefall_ff_value.dev_attr.attr,
>  	&iio_dev_attr_in_accel_freefall_time_ms.dev_attr.attr,
> @@ -1296,6 +1397,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
>  			return ret;
>  	}
>  
> +	if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							IIO_MOD_X_OR_Y_OR_Z,
> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_FALLING),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
>  		ret = iio_push_event(indio_dev,
>  				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> @@ -1412,6 +1524,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	 * setup.
>  	 */
>  	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
> +	st->inact_axis_ctrl = ADXL345_REG_INACT_AXIS_MSK;
> +	st->inact_ac = 0;			/*    0 [dc]              */
>  	st->act_ac = 0;
>  	st->int_map = 0x00;			/* reset interrupts */
>  
> @@ -1422,6 +1536,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	st->tap_latent_us = 20;			/*   20 [0x14] -> .025    */
>  
>  	st->act_value = 6;			/*    6 [0x06]            */
> +	st->inact_value = 4;			/*    4 [0x04]            */
> +	st->inact_time_s = 3;			/*    3 [0x03] -> 3       */
> +
>  	st->ff_value = 8;			/*    8 [0x08]            */
>  	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
>  


