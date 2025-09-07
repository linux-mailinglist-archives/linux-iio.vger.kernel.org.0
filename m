Return-Path: <linux-iio+bounces-23862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDDB47B7B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1083C2013
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A07263C9F;
	Sun,  7 Sep 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E49iAZ5T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5624293C;
	Sun,  7 Sep 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757250159; cv=none; b=uCl9L2WTjbMS0WWDcvmaFlRKCKC78Ls8jMhEDCCk/tLCSQguXsiFo8tT+frmDVhATBc26lzY2TuR2TrdrVkFlp6lZI0X1Q/Pu+k23D49Mb5Ob+LQJcPe8pkRShlX/My7gH+Q+bFAC28uVbvEC4UXNl4G9EV6vS/dlrgI9Pp00rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757250159; c=relaxed/simple;
	bh=r2cv7lPuhPK95lN3Bw/Ri0iNbK6AfQQRmv7VsO8SQAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGWC41GoZjqPnqegtwBbKe4PCN798D6wRF17D4pqtOvoF3yDyxDcWOUwnuvDvd/vjaT5y0S0NPBiVGaa8VVo9uZfaypC4ImX6cKCinPmhhMrunxH7gbnAMnEhGOyhh/iItgK0Y0jehk+IX+3bivXdUmRU5iUGBvKXnHU7ym7O24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E49iAZ5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C50C4CEF0;
	Sun,  7 Sep 2025 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757250158;
	bh=r2cv7lPuhPK95lN3Bw/Ri0iNbK6AfQQRmv7VsO8SQAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E49iAZ5TBdjq4NkSX/DQDr9mU3cVU+3S7l31nhpHgQOdKrxDvqNWzx5SNruS9Xygc
	 08eG8R7EId854XSUcn3UsP3/UAE89ZO4oKohjSEiwNlszc6DS3Jn3RS+LOn7K+Qmck
	 SSlFEk0uJe7guEUFLSFJORhIxzusjc7cdpG0bSq6TkBw8ZORVuOptkfhBPFuiV/YUA
	 ZlaHL+JdwzuCdWy+TpfeQiq0teJIOBhDi8mC5HltHQ0VrwoiHIAQWFgB3IBb6TrmhY
	 mOntyGZYiRkiB7rU0xeJb2kdeax/ykZx4bBx0e7vgXsT4GL0gkarbJrdJH2nQFh5+Y
	 FHXidvYJ5AcdA==
Date: Sun, 7 Sep 2025 14:02:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 08/10] iio: accel: BMA220 add events
Message-ID: <20250907140231.67b01f96@jic23-huawei>
In-Reply-To: <20250901194742.11599-9-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-9-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 22:47:34 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add events for tap detection and low-g, high-g, slope conditions.
> Ignored the 80-column rule for readability.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
It might be worth splitting this up into types of event just to reduce
the amount of code and allow some description of event types in the patch
intro.

> ---
>  drivers/iio/accel/bma220_core.c | 686 ++++++++++++++++++++++++++++++++
>  1 file changed, 686 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 41889cdcef76..c8da6cc2eaf3 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -13,6 +13,37 @@
>   * scale (range)             | in_accel_scale                 | see _available
>   * cut-off freq (filt_config)| in_accel_filter_low_pass_...   | see _available
>   * ---------------------------------------------------------------------------
> + *
> + * Events:
> + * Register                  | IIO ABI (sysfs)                   | valid values
> + * --------------------------+-----------------------------------+------------

This feels like documentation that ultimately may grow to the point
where it isn't useful enough to justify it's presence. Maybe we'll see what
this looks like once all the code is ready to merge and then consider if it
is worth having this.

> + * high-g detection          |                                   |
> + *   enable/disable irq      | in_accel_*_thresh_rising_en       | 0/1
> + *   threshold (high_th)     | in_accel_thresh_rising_value      | 0-15
> + *   hysteresis (high_hy)    | in_accel_thresh_rising_hysteresis | 0-3
> + *   duration (high_dur)     | in_accel_thresh_rising_period     | 0-63
> + * low-g detection           |                                   |
> + *   enable/disable irq      | in_accel_*_thresh_falling_en      | 0/1
> + *   threshold (low_th)      | in_accel_thresh_falling_value     | 0-15
> + *   hysteresis (low_hy)     | in_accel_thresh_falling_hysteresis| 0-3
> + *   duration (low_dur)      | in_accel_thresh_falling_period    | 0-63
> + * slope detection           |                                   |
> + *   enable/disable irq      | in_accel_*_thresh_either_en       | 0/1
> + *   threshold (slope_th)    | in_accel_thresh_either_value      | 0-15
> + *   duration (slope_dur)    | in_accel_thresh_either_period     | 0-3
> + * tap sensing               |                                   |
> + *   enable/disable singletap| in_accel_*_gesture_singletap_en   | 0/1 [2]
> + *   enable/disable doubletap| in_accel_*_gesture_doubletap_en   | 0/1 [2]
> + *   threshold (tt_th)       | in_accel_gesture_singletap_value  | 0-15
> + *   duration (tt_dur)       | in_accel_gesture_doubletap_period | see [1]
> + * ----------------------------------------------------------------------------
> + *
> + * [1] The event related sysfs interface provides and expects raw register values
> + *         (unshifted bitfields) based on the chip specifications.
> + * [2] Do not mix singletap and doubletap interrupt enable flags.
> + *
> + * To be on the safe side do not enable two or more concurrent interrupt events
> + * of different types.
>   */

> 
> +static int bma220_reset_int(struct bma220_data *data)
> +{
> +	return regmap_update_bits(data->regmap, BMA220_REG_IE1, BMA220_INT_RST_MSK,
> +				  FIELD_PREP(BMA220_INT_RST_MSK, 1));

regmap_set_bits() is handy in these cases.

> +}
>

> +
> +static int bma220_set_slope_en(struct bma220_data *data,
> +			       enum iio_modifier axis,
> +			       bool en)

Wrap closer to 80 chars.

> +
> +static int bma220_set_high_en(struct bma220_data *data,
> +			      enum iio_modifier axis,
> +			      bool en)
> +{
> +	int ret;
> +
> +	switch (axis) {
> +	case IIO_MOD_X:
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
> +					 BMA220_INT_EN_HIGH_X_MSK,
> +					 FIELD_PREP(BMA220_INT_EN_HIGH_X_MSK, en));
> +		break;
> +	case IIO_MOD_Y:
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
> +					 BMA220_INT_EN_HIGH_Y_MSK,
> +					 FIELD_PREP(BMA220_INT_EN_HIGH_Y_MSK, en));
> +		break;
> +	case IIO_MOD_Z:
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
> +					 BMA220_INT_EN_HIGH_Z_MSK,
> +					 FIELD_PREP(BMA220_INT_EN_HIGH_Z_MSK, en));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (ret)

As below. Early returns simplify this.

> +		return ret;
> +
> +	return 0;
return ret;

> +}
>
> +// set if the event is enabled

All IIO comments are /* */ except the SPDX tags where appropriate.


> +static int bma220_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (dir) {
> +		case IIO_EV_DIR_SINGLETAP:
> +			ret = bma220_set_tap_en(data, chan->channel2,
> +						IIO_EV_DIR_SINGLETAP, state);
> +			break;
> +		case IIO_EV_DIR_DOUBLETAP:
> +			ret = bma220_set_tap_en(data, chan->channel2,
> +						IIO_EV_DIR_DOUBLETAP, state);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_EV_TYPE_THRESH:
> +		switch (dir) {
> +		case IIO_EV_DIR_EITHER:
> +			ret = bma220_set_slope_en(data, chan->channel2, state);
> +			break;
> +		case IIO_EV_DIR_RISING:
> +			ret = bma220_set_high_en(data, chan->channel2, state);
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
> +						 BMA220_INT_EN_LOW_MSK,
> +						 FIELD_PREP(BMA220_INT_EN_LOW_MSK, state));
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	return bma220_reset_int(data);
> +}
> +
> +static int bma220_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
Whilst it is more code, convention would be to be side effect free on error so.
			if (ret)
				return ret;

			*val = FIELD_GET(B...);
			return IIO_VAL_INT;

> +			*val = FIELD_GET(BMA220_TT_TH_MSK, reg_val);
> +			break;
> +		case IIO_EV_INFO_PERIOD:
> +			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
> +			*val = FIELD_GET(BMA220_TT_DUR_MSK, reg_val);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_EV_TYPE_THRESH:
> +		switch (dir) {
> +		case IIO_EV_DIR_EITHER:
> +			switch (info) {
> +			case IIO_EV_INFO_VALUE:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF4,
> +						  &reg_val);
> +				*val = FIELD_GET(BMA220_SLOPE_TH_MSK, reg_val);
> +				break;
> +			case IIO_EV_INFO_PERIOD:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF4,
> +						  &reg_val);
> +				*val = FIELD_GET(BMA220_SLOPE_DUR_MSK, reg_val);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case IIO_EV_DIR_RISING:
> +			switch (info) {
> +			case IIO_EV_INFO_VALUE:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF1,
> +						  &reg_val);
> +				*val = FIELD_GET(BMA220_HIGH_TH_MSK, reg_val);
> +				break;
> +			case IIO_EV_INFO_PERIOD:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF0,
> +						  &reg_val);
> +				*val = FIELD_GET(BMA220_HIGH_DUR_MSK, reg_val);
> +				break;
> +			case IIO_EV_INFO_HYSTERESIS:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF0,
> +						  &reg_val);
> +				*val = FIELD_GET(BMA220_HIGH_HY_MSK, reg_val);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			switch (info) {
> +			case IIO_EV_INFO_VALUE:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF1,
> +						  &reg_val);
> +				*val = FIELD_GET(BMA220_LOW_TH_MSK, reg_val);
> +				break;
> +			case IIO_EV_INFO_PERIOD:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF2,
> +						  &reg_val);
> +				*val = FIELD_GET(BMA220_LOW_DUR_MSK, reg_val);
> +				break;
> +			case IIO_EV_INFO_HYSTERESIS:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF2,
> +						  &reg_val);
> +				*val = FIELD_GET(BMA220_LOW_HY_MSK, reg_val);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
As below. I'd do early returns.  you may end up with a few more checks
but the code will be easier to follow (slightly!)
> +}
> +
> +static int bma220_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			if (!FIELD_FIT(BMA220_TT_TH_MSK, val))
> +				return -EINVAL;
> +			ret = regmap_update_bits(data->regmap, BMA220_REG_CONF3,
> +						 BMA220_TT_TH_MSK,
> +						 FIELD_PREP(BMA220_TT_TH_MSK, val));
I'm a fan of returning early if there is nothing else to do.  Saves
scrolling up and down if trying to follow the code flow for a specific
set of inputs.
			return regmap_update_bits();

> +			break;
> +		case IIO_EV_INFO_PERIOD:
> +			if (!FIELD_FIT(BMA220_TT_DUR_MSK, val))
> +				return -EINVAL;
> +			ret = regmap_update_bits(data->regmap, BMA220_REG_CONF3,
> +						 BMA220_TT_DUR_MSK,
> +						 FIELD_PREP(BMA220_TT_DUR_MSK, val));
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;

With early returns this will be dead code that should be dropped.

> +	case IIO_EV_TYPE_THRESH:
> +		switch (dir) {
> +		case IIO_EV_DIR_EITHER:
> +			switch (info) {
> +			case IIO_EV_INFO_VALUE:
> +				if (!FIELD_FIT(BMA220_SLOPE_TH_MSK, val))
> +					return -EINVAL;
> +				ret = regmap_update_bits(data->regmap,
> +							 BMA220_REG_CONF4,
> +							 BMA220_SLOPE_TH_MSK,
> +							 FIELD_PREP(BMA220_SLOPE_TH_MSK, val));
> +				break;
> +			case IIO_EV_INFO_PERIOD:
> +				if (!FIELD_FIT(BMA220_SLOPE_DUR_MSK, val))
> +					return -EINVAL;
> +				ret = regmap_update_bits(data->regmap,
> +							 BMA220_REG_CONF4,
> +							 BMA220_SLOPE_DUR_MSK,
> +							 FIELD_PREP(BMA220_SLOPE_DUR_MSK, val));
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case IIO_EV_DIR_RISING:
> +			switch (info) {
> +			case IIO_EV_INFO_VALUE:
> +				if (!FIELD_FIT(BMA220_HIGH_TH_MSK, val))
> +					return -EINVAL;
> +				ret = regmap_update_bits(data->regmap,
> +							 BMA220_REG_CONF1,
> +							 BMA220_HIGH_TH_MSK,
> +							 FIELD_PREP(BMA220_HIGH_TH_MSK, val));
> +				break;
> +			case IIO_EV_INFO_PERIOD:
> +				if (!FIELD_FIT(BMA220_HIGH_DUR_MSK, val))
> +					return -EINVAL;
> +				ret = regmap_update_bits(data->regmap,
> +							 BMA220_REG_CONF0,
> +							 BMA220_HIGH_DUR_MSK,
> +							 FIELD_PREP(BMA220_HIGH_DUR_MSK, val));
> +				break;
> +			case IIO_EV_INFO_HYSTERESIS:
> +				if (!FIELD_FIT(BMA220_HIGH_HY_MSK, val))
> +					return -EINVAL;
> +				ret = regmap_update_bits(data->regmap,
> +							 BMA220_REG_CONF0,
> +							 BMA220_HIGH_HY_MSK,
> +							 FIELD_PREP(BMA220_HIGH_HY_MSK, val));
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			switch (info) {
> +			case IIO_EV_INFO_VALUE:
> +				if (!FIELD_FIT(BMA220_LOW_TH_MSK, val))
> +					return -EINVAL;
> +				ret = regmap_update_bits(data->regmap,
> +							 BMA220_REG_CONF1,
> +							 BMA220_LOW_TH_MSK,
> +							 FIELD_PREP(BMA220_LOW_TH_MSK, val));
> +				break;
> +			case IIO_EV_INFO_PERIOD:
> +				if (!FIELD_FIT(BMA220_LOW_DUR_MSK, val))
> +					return -EINVAL;
> +				ret = regmap_update_bits(data->regmap,
> +							 BMA220_REG_CONF2,
> +							 BMA220_LOW_DUR_MSK,
> +							 FIELD_PREP(BMA220_LOW_DUR_MSK, val));
> +				break;
> +			case IIO_EV_INFO_HYSTERESIS:
> +				if (!FIELD_FIT(BMA220_LOW_HY_MSK, val))
> +					return -EINVAL;
> +				ret = regmap_update_bits(data->regmap,
> +							 BMA220_REG_CONF2,
> +							 BMA220_LOW_HY_MSK,
> +							 FIELD_PREP(BMA220_LOW_HY_MSK, val));
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
With all early returns as above this isn't needed as we'll never get here.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

> 
> @@ -584,6 +1230,7 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
>  	struct bma220_data *data = iio_priv(indio_dev);
>  	int rv;
>  	u8 bma220_reg_if[2];
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> 
>  	guard(mutex)(&data->lock);
>  	rv = regmap_bulk_read(data->regmap, BMA220_REG_IF0, bma220_reg_if,
> @@ -596,6 +1243,45 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
>  		goto done;
>  	}
> 
> +	if (FIELD_GET(BMA220_IF_HIGH, bma220_reg_if[1]))
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +						  IIO_MOD_X_OR_Y_OR_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_RISING),
> +			       timestamp);
> +	if (FIELD_GET(BMA220_IF_LOW, bma220_reg_if[1]))
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +						  IIO_MOD_X_OR_Y_OR_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_FALLING),
> +			       timestamp);
> +	if (FIELD_GET(BMA220_IF_SLOPE, bma220_reg_if[1]))
> +		iio_push_event(indio_dev,

Sounds like a ROC event. (Rate of change) not a simple threshold.

> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +						  IIO_MOD_X_OR_Y_OR_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +			       timestamp);
> +	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if[1])) {
> +
> +		if (data->tap_type == BMA220_TAP_TYPE_SINGLE)
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							  IIO_MOD_X_OR_Y_OR_Z,
> +							  IIO_EV_TYPE_GESTURE,
> +							  IIO_EV_DIR_SINGLETAP),
> +				       timestamp);
> +		else
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							  IIO_MOD_X_OR_Y_OR_Z,
> +							  IIO_EV_TYPE_GESTURE,
> +							  IIO_EV_DIR_DOUBLETAP),
> +				       timestamp);
> +	}

