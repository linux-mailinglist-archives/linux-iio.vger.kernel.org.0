Return-Path: <linux-iio+bounces-15607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70CA37667
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7668616B429
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7299019D884;
	Sun, 16 Feb 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opne2cLH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3092EAE4;
	Sun, 16 Feb 2025 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728476; cv=none; b=N1869AysOkScE5RHr+jvfISSykXTHug4wvxrLAGaWxzrtAzPy+8i7rKxejTsYQgVrlKbDCvZe/H2vTNT6o0JP5fVxMEZFIU3VumR4MtuUXE+0ocuVG0FmIDn7xH+2sRtt8/QkwUZidp8dAS1Iv7UUzQUM+dqTiaFh7nc1XiOfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728476; c=relaxed/simple;
	bh=wHlcJwuBFGmMIbZkTGtUDa1ND9mOVzGHQ1jRKquPGY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfB+hyGR5efeZ92qnc/Mlsq81gRpdz5U7YKozOrz97nEzarS+vkTpsko6Yu0D2eX/TKNWmItL6dZMhIyI4uX3Hi8M6B0r2tXFwU0kMKVXA8lmBcAMtfIKXnCVLyWTo2474Bf6AmIHim6bHTq8RMYU15ixJwqRgcT2W8cGJLmxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opne2cLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BFFC4CEDD;
	Sun, 16 Feb 2025 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739728475;
	bh=wHlcJwuBFGmMIbZkTGtUDa1ND9mOVzGHQ1jRKquPGY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=opne2cLHfCfBJB5qNQbw7/9VD6UoGNzKjc1sHnRe7S9z3pCIKPqxs8MU38Gf+iz6Z
	 ZqLcbWYVJz9owg0E/jo3coKZlQrgYq3YJTohLpCSku2cWSBDM6E1eSK1gbTUpwdgwg
	 08CrfyQfX2v8k4/knUlEd//FrOv5ekgOgTiBGGsmARb/rKpbCbGQ+6/qBbqb42KjJ6
	 0gZEAsDafjH3ddBo+2DOQrKD/1x9aEIL9UIUI72wR434T5YircV6XZipKUabn9sfDr
	 gu09kGr/Mv9QgTwCLUL88CkQNwk3eCKEzFQSJbSXRLA+C06pQWTq8ipfAwSskvdu80
	 UB9N7vpgDUcqQ==
Date: Sun, 16 Feb 2025 17:54:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 13/14] iio: accel: adxl345: add coupling detection
 for activity/inactivity
Message-ID: <20250216175427.70cc3be1@jic23-huawei>
In-Reply-To: <20250210110119.260858-14-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-14-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:18 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add coupling activity/inactivity detection by the AC/DC bit. This is an
> addititional enhancement for the detection of activity states and
> completes the activity / inactivity feature of the ADXL345.

Give a little more info here.  This is a somewhat unusual feature.
The AC description is odd terminology as it is really about
referencing to when the event is enabled, nothing is alternating.

The activity one is fairly simple.  The inactivity seems not.
I'm not entirely sure what the value used as reference is:

"Similarly, in ac-coupled operation for inactivity detection,
a reference value is used for comparison and is updated whenever
the device exceeds the inactivity threshold. After the reference
value is selected, the device compares the magnitude of the
difference between the reference value and the current acceleration
with THRESH_INACT. If the difference is less than the value in
THRESH_INACT for the time in TIME_INACT, the device is considered
inactive and the inactivity interrupt is triggered."

What is it updated to?  Is it updated to effectively the maximum
activity value? Or just a snap shot of whatever triggered the
inactivity be left (so takes into account which axis the
activity occurred on.)

I've no idea.

The definition we have for mag referenced is vague enough
to incorporate this so not a problem if we can't figure out
exactly what it is!

Jonathan



> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 77 ++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 7de869fac799..411ae7bf6b97 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -36,7 +36,9 @@
>  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
>  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
> +#define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
>  #define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
> +#define ADXL345_REG_INACT_ACDC_MSK	BIT(3)
>  #define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
>  
>  enum adxl345_axis {
> @@ -86,6 +88,11 @@ static const unsigned int adxl345_act_thresh_reg[2] = {
>  	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
>  };
>  
> +static const unsigned int adxl345_act_acdc_msk[2] = {
> +	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_ACDC_MSK,
> +	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
> +};
> +
>  static const unsigned int adxl345_act_axis_msk[2] = {
>  	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
>  	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_AXIS_MSK,
> @@ -178,9 +185,11 @@ struct adxl345_state {
>  	enum adxl345_range range;
>  
>  	u32 act_axis_ctrl;
> +	bool act_ac;
>  	u8 act_threshold;
>  
>  	u32 inact_axis_ctrl;
> +	bool inact_ac;
>  	u8 inact_threshold;
>  	u8 inact_time_s;
>  
> @@ -237,6 +246,18 @@ static struct iio_event_spec adxl345_events[] = {
>  			BIT(IIO_EV_INFO_VALUE) |
>  			BIT(IIO_EV_INFO_PERIOD),
>  	},
> +	{
> +		/* activity, activity - ac bit */
> +		.type = IIO_EV_TYPE_MAG_REFERENCED,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		/* activity, inactivity - ac bit */
> +		.type = IIO_EV_TYPE_MAG_REFERENCED,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> +	},
>  };
>  
>  #define ADXL345_CHANNEL(index, reg, axis) {					\
> @@ -334,6 +355,35 @@ static int adxl345_write_act_axis(struct adxl345_state *st,
>  	return 0;
>  }
>  
> +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> +				   enum adxl345_activity_type type, bool *ac)
> +{
> +	if (type == ADXL345_ACTIVITY)
> +		*ac = st->act_ac;
> +	else
> +		*ac = st->inact_ac;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_act_inact_ac(struct adxl345_state *st,
> +				    enum adxl345_activity_type type, bool ac)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> +				 adxl345_act_acdc_msk[type], ac);
> +	if (ret)
> +		return ret;
> +
> +	if (type == ADXL345_ACTIVITY)
> +		st->act_ac = ac;
> +	else
> +		st->inact_ac = ac;
> +
> +	return 0;
> +}
> +
>  static int adxl345_is_act_inact_en(struct adxl345_state *st,
>  				   enum adxl345_activity_type type, bool *en)
>  {
> @@ -959,6 +1009,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return int_en;
> +	case IIO_EV_TYPE_MAG_REFERENCED:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = adxl345_is_act_inact_ac(st, ADXL345_ACTIVITY, &int_en);
> +			if (ret)
> +				return ret;
> +			return int_en;
> +		case IIO_EV_DIR_FALLING:
> +			ret = adxl345_is_act_inact_ac(st, ADXL345_INACTIVITY, &int_en);
> +			if (ret)
> +				return ret;
> +			return int_en;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1008,6 +1073,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
>  		}
>  	case IIO_EV_TYPE_MAG:
>  		return adxl345_set_ff_en(st, state);
> +	case IIO_EV_TYPE_MAG_REFERENCED:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return adxl345_set_act_inact_ac(st, ADXL345_ACTIVITY, state);
> +		case IIO_EV_DIR_FALLING:
> +			return adxl345_set_act_inact_ac(st, ADXL345_INACTIVITY, state);
> +		default:
> +			return -EINVAL;
> +		}
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1619,6 +1694,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	 */
>  	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
>  	st->inact_axis_ctrl = ADXL345_REG_INACT_AXIS_MSK;
> +	st->inact_ac = 0;			/*    0 [dc]              */
> +	st->act_ac = 0;
>  	st->int_map = 0x00;			/* reset interrupts */
>  
>  	/* Init with reasonable values */


