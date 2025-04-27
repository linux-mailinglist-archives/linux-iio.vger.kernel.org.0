Return-Path: <linux-iio+bounces-18732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D2A9E32B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95615189B062
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F07970810;
	Sun, 27 Apr 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfH5MD3w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8972E40B;
	Sun, 27 Apr 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758839; cv=none; b=IPZwIbSmIiI2rxAxYlrdsB5UpGHvcKLczLggP8JgTVgi/DZ5afqYsaYdzCC3DHq60OY6b5ulVzcRh4ec5vzfIAtd3R1banY2xjLgmRdFYSVzO59700UZ2GK4dOs+G8oGxEyWtcUYESspfKp9nKLIznxv/b5aGxcWsE5IbnsTyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758839; c=relaxed/simple;
	bh=6A3YPxnYIajY2KKSBg8ZauVcaWCp3yZ98jnEczEU+Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXTEjmgKEUpJPkJKKXmjfyrqw4nj6jpDJQWVr0zSiaq05bCqV2aa9aZmSdkm0DNA/Pxo6tMX9vRwv2BbZJByZ4OsBQd4KTFHHh9sRoXmq1UYBSeE3bKoTJauRZUj8ObSPyb/NBBh1PLd+ccmnN7YppRIn4HN99EcYU2nnyA1gdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfH5MD3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3D4C4CEE3;
	Sun, 27 Apr 2025 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745758839;
	bh=6A3YPxnYIajY2KKSBg8ZauVcaWCp3yZ98jnEczEU+Zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jfH5MD3wGcHrr1g+CVZ1f3l9Z3m9/U/TcOFUhMXxhVS9xJU7cZflsWWTgf4puPond
	 pxJvxa5huKDU5I4Zjpcpld2SSx+MTXbHBJPj7WfiYklQCUrdVKpC1/bug26JOWnDX6
	 4MeyBkJOEouGZyf4it/LGCSt8yTXvtE2wSGBecPSwYN1SIPaBqVVMfk7yQcej/aC1/
	 7ZEfbEsjQyXU+fw/GQXGEJwE6UeA+nRlo22WidgdsssY/zvelU+f8YmryADmT2PQng
	 5VfQsu7xn1Jys1A8E0bkFTL+6Lb64nwu+cfw10/u7poWuaTP/6u53nbd+hvkXSxIhg
	 tt+eOovsvap7Q==
Date: Sun, 27 Apr 2025 14:00:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 10/11] iio: accel: adxl345: add coupling detection
 for activity/inactivity
Message-ID: <20250427140032.3112f51b@jic23-huawei>
In-Reply-To: <20250421220641.105567-11-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:06:40 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add coupling activity/inactivity detection by the AC/DC bit. This is an
> addititional enhancement for the detection of activity states and
> completes the activity / inactivity feature of the ADXL345.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

I've dragged the table from the earlier patch into this one that actually uses it.
However I'm a little unsure on exactly how we present this feature.

So until those questions are resolved I've dropped the patch (you'll need
to rebase on my testing branch and fix up missing table for v8).

The bit that made me not apply this series (with some tweaks) was that
I'd expect enabling AC events to be visible as disabling of DC ones.

Also, I just noticed you aren't pushing the new event types.

These controls need to look like a separate event detector hardware block
with it's own controls + its own event codes.  The fact only this or
the DC version can be enabled at any time should only be exposed in the
reported state, not apparent via what files we expose etc.  On some
other device they may be independent hardware blocks.

Note I'd also expect to see value controls for these new events. You may
need to cache the values and update on event change if the meaning is
very different.   That's because the expectation would be an event
setup sequence from userspace is:

1) Set value of threshold
2) Enable event

On a change of event (due to shared hardware) The value set may scramble
the event already enabled.

So write the values into a cache and update to the right one when changing
event.

> ---
>  drivers/iio/accel/adxl345_core.c | 162 ++++++++++++++++++++++++++++++-
>  1 file changed, 159 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index b25efcad069b..c07ad5774c8a 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -37,7 +37,9 @@
>  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
>  #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
> +#define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
>  #define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
> +#define ADXL345_REG_INACT_ACDC_MSK	BIT(3)
>  #define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
>  
>  #define ADXL345_TAP_Z_EN		BIT(0)
> @@ -91,6 +93,11 @@ static const unsigned int adxl345_act_thresh_reg[] = {
>  	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
>  };
>  
> +static const unsigned int adxl345_act_acdc_msk[] = {
> +	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_ACDC_MSK,
> +	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
> +};
> +
>  enum adxl345_odr {
>  	ADXL345_ODR_0P10HZ = 0,
>  	ADXL345_ODR_0P20HZ,
> @@ -204,6 +211,18 @@ static struct iio_event_spec adxl345_events[] = {
>  			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
>  			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
>  	},
> +	{
> +		/* activity, activity - ac bit */
Comment says activity and inactivity but channel type wise this
is just activity (as rising)

> +		.type = IIO_EV_TYPE_MAG_REFERENCED,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		/* activity, inactivity - ac bit */

Likewise this seems to be inactivity.  Should this be in the x&y&z
channel, not this one?

> +		.type = IIO_EV_TYPE_MAG_REFERENCED,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> +	},
>  };
>  
>  #define ADXL345_CHANNEL(index, reg, axis) {					\
> @@ -320,6 +339,69 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  
>  /* act/inact */
>  
> +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> +				   enum adxl345_activity_type type, bool *ac)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (type == ADXL345_ACTIVITY)
> +		*ac = FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval);
> +	else
> +		*ac = FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval);
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_act_inact_ac(struct adxl345_state *st,
> +				    enum adxl345_activity_type type, bool ac)
> +{
> +	unsigned int act_inact_ac = ac ? 0xff : 0x00;
> +
> +	/*
> +	 * A setting of false selects dc-coupled operation, and a setting of
> +	 * true enables ac-coupled operation. In dc-coupled operation, the
> +	 * current acceleration magnitude is compared directly with
> +	 * ADXL345_REG_THRESH_ACT and ADXL345_REG_THRESH_INACT to determine
> +	 * whether activity or inactivity is detected.
> +	 *
> +	 * In ac-coupled operation for activity detection, the acceleration
> +	 * value at the start of activity detection is taken as a reference
> +	 * value. New samples of acceleration are then compared to this
> +	 * reference value, and if the magnitude of the difference exceeds the
> +	 * ADXL345_REG_THRESH_ACT value, the device triggers an activity
> +	 * interrupt.
> +	 *
> +	 * Similarly, in ac-coupled operation for inactivity detection, a
> +	 * reference value is used for comparison and is updated whenever the
> +	 * device exceeds the inactivity threshold. After the reference value
> +	 * is selected, the device compares the magnitude of the difference
> +	 * between the reference value and the current acceleration with
> +	 * ADXL345_REG_THRESH_INACT. If the difference is less than the value in
> +	 * ADXL345_REG_THRESH_INACT for the time in ADXL345_REG_TIME_INACT, the
> +	 * device is considered inactive and the inactivity interrupt is
> +	 * triggered. [quoted from p. 24, ADXL345 datasheet Rev. G]
> +	 *
> +	 * In a conclusion, the first acceleration snapshot sample which hit the
> +	 * threshold in a particular direction is always taken as acceleration
> +	 * reference value to that direction. Since for the hardware activity
> +	 * and inactivity depend on the x/y/z axis, so do ac and dc coupling.
> +	 * Note, this sw driver always enables or disables all three x/y/z axis
> +	 * for detection via act_axis_ctrl and inact_axis_ctrl, respectively.
> +	 * Where in dc-coupling samples are compared against the thresholds, in
> +	 * ac-coupling measurement difference to the first acceleration
> +	 * reference value are compared against the threshold. So, ac-coupling
> +	 * allows for a bit more dynamic compensation depending on the initial
> +	 * sample.
> +	 */
> +	return regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> +				 adxl345_act_acdc_msk[type], act_inact_ac);
> +}

>  static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
> @@ -797,9 +886,51 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
>  
>  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
>  {
> -	return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> +	unsigned int act_threshold, inact_threshold;
> +	unsigned int range_old;
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval);
> +	if (ret)
> +		return ret;
> +	range_old = FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> +
> +	ret = regmap_read(st->regmap,
> +			  adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> +			  &act_threshold);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap,
> +			  adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> +			  &inact_threshold);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
>  				 ADXL345_DATA_FORMAT_RANGE,
>  				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
> +	if (ret)
> +		return ret;
> +
> +	act_threshold = act_threshold
> +		* adxl345_range_factor_tbl[range_old]
> +		/ adxl345_range_factor_tbl[range];
> +	act_threshold = min(255, max(1, inact_threshold));
> +
This is first use of the range table. So introduce that in this patch.

> +	inact_threshold = inact_threshold
> +		* adxl345_range_factor_tbl[range_old]
> +		/ adxl345_range_factor_tbl[range];
> +	inact_threshold = min(255, max(1, inact_threshold));
> +
> +	ret = regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> +			   act_threshold);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> +			   inact_threshold);
>  }
>  
>  static int adxl345_read_avail(struct iio_dev *indio_dev,
> @@ -938,7 +1069,7 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
>  				     enum iio_event_direction dir)
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
> -	bool int_en;
> +	bool int_en, act_ac, inact_ac;
>  	int ret;
>  
>  	switch (type) {
> @@ -983,6 +1114,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return int_en;
> +	case IIO_EV_TYPE_MAG_REFERENCED:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = adxl345_is_act_inact_ac(st, ADXL345_ACTIVITY, &act_ac);

Do we not need a check in the enabling of the DC events as well?  If we have enabled
AC the DC one should report disabled (and if we enable that again then we should
update this.

> +			if (ret)
> +				return ret;
> +			return act_ac;
> +		case IIO_EV_DIR_FALLING:
> +			ret = adxl345_is_act_inact_ac(st, ADXL345_INACTIVITY, &inact_ac);
> +			if (ret)
> +				return ret;
> +			return inact_ac;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1019,6 +1165,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
>  		}
>  	case IIO_EV_TYPE_MAG:
>  		return adxl345_set_ff_en(st, state);
> +	case IIO_EV_TYPE_MAG_REFERENCED:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return adxl345_set_act_inact_ac(st, ADXL345_ACTIVITY, state);

Similar to read path.  The DC events should be affected by this as well as the AC ones.

> +		case IIO_EV_DIR_FALLING:
> +			return adxl345_set_act_inact_ac(st, ADXL345_INACTIVITY, state);
> +		default:
> +			return -EINVAL;
> +		}
> +
>  	default:
>  		return -EINVAL;
>  	}


