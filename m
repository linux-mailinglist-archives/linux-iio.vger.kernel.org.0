Return-Path: <linux-iio+bounces-18287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D4A93CBB
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B02D7A45BE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549622256D;
	Fri, 18 Apr 2025 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRtjQvdA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D013B2A4;
	Fri, 18 Apr 2025 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745000582; cv=none; b=gR8GtQ5n+YTYOpSkERfnUshGBAkyMEVW6fbz7S8rLWqe7wGI5OB52fZSpsD5Azs7DjuGUJDiGveVWLQxdnMGvBbPR2V3csEQvjvBS5wm69DzRYh8mdGPNZ9sjZNRkI2QbMjxxcorUVCA0i/ioqrIu0OPkPPohr0vBtBnwhhf96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745000582; c=relaxed/simple;
	bh=fp00QMplQNxd/bJnjPrrcq2TIqGFB8msq4zfzRnEjIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+qx4hir0NrG2vfWBzLtgSR6co25vXJURGzD1MJhMviq3cy4BxHo+zlLt2N5jWkYkDr+3EwIga4iN82CNMfcLMdRQlnFLpNCH5DNfnFRnfl7hRdaNUwuCv1xm/INAYt61fPGA+EXfOl62o4xh6IsnnQhMmPe2mhmekuy7rJZRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRtjQvdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994DEC4CEEA;
	Fri, 18 Apr 2025 18:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745000582;
	bh=fp00QMplQNxd/bJnjPrrcq2TIqGFB8msq4zfzRnEjIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VRtjQvdACeVO8YZwfZMsjPsbFZKR5NDcjjVA0KOXsmZhgfEP2xmAvDWxli/PKRrYn
	 gQn+wMAI7sTidsoL6xVq4RNTel2XPyabzS+hdFXAOin0d4Y2/mGgWMiHokw6JgSrlz
	 rrQFNwb27Q0VyVZyf7PTNra5VdWZ6OSFFKotTSSZ5Fhlpu5yq9cEzybaxUgZXVCFHy
	 CEVLLLYqAMJQXRCUg2reMJ0TlIWOWos+iLVLQdvjGQVGdwjeKQhYDTLLijVGZQF4x0
	 zbg+ncFRh0U12Aj54Fwainp12j974SgQNzjb2e112tfN2fndST0kGxe7TiMar4UzDT
	 v4HLlJiEFAcjQ==
Date: Fri, 18 Apr 2025 19:22:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v6 05/11] iio: accel: adxl345: add freefall feature
Message-ID: <20250418192254.0becd27d@jic23-huawei>
In-Reply-To: <20250414184245.100280-6-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
	<20250414184245.100280-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 18:42:39 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the freefall detection of the sensor together with a threshold and
> time parameter. A freefall event is detected if the measuring signal
> falls below the threshold.
> 
> Introduce a freefall threshold stored in regmap cache, and a freefall
> time, having the scaled time value stored as a member variable in the
> state instance.
> 
Reading this I wondered whether we had the event code consistent for
freefall detectors... Or indeed inactivity ones (which are kind of similarish)

:( We don't it seems.  The issue is that
freefall is actually that all channels are simultaneously under the the magnitude
threshold, not one of them.  So it should I think be
X_AND_Y_AND_Z not X_OR_Y_OR_Z

This is as opposed to activity detectors which tend to be any axis shows
activity and X_OR_Y_OR_Z applies.

Anyhow upshot is I think I lead you astray on this and we should make this
one IIO_MOD_X_AND_Y_AND_Z 

A few other things inline.

Unfortunately we don't deal with these events that often so I forget
what we did before :(

> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 125 +++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index c464c87033fb..ae02826e552b 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -75,6 +75,7 @@ struct adxl345_state {
>  	u32 tap_duration_us;
>  	u32 tap_latent_us;
>  	u32 tap_window_us;
> +	u32 ff_time_ms;
>  
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -96,6 +97,14 @@ static struct iio_event_spec adxl345_events[] = {
>  			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
>  			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
>  	},
> +	{
> +		/* free fall */
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_PERIOD),
> +	},
This is creating separate per axis enables, values and period. Does that make
sense?  If not you need to spin a kind of virtual channel (with mod X_AND_Y_AND_Z)
and add the events to it.

See how the sca3000 does it for example.
>  };
>  
>  #define ADXL345_CHANNEL(index, reg, axis) {					\
> @@ -383,6 +392,63 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
>  	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
>  }
>  
> +/* freefall */
> +
> +static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*en = FIELD_GET(ADXL345_INT_FREE_FALL, regval) > 0;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> +{
> +	unsigned int regval, ff_threshold;
> +	bool en;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_threshold);
> +	if (ret)
> +		return ret;
> +
> +	en = cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> +
> +	regval = en ? ADXL345_INT_FREE_FALL : 0x00;
> +
> +	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> +				  ADXL345_INT_FREE_FALL, regval);
> +}
> +
> +static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
> +			       u32 val_fract_us)
> +{
> +	unsigned int regval;
> +	int val_ms;
> +
> +	/*
> +	 * max value is 255 * 5000 us = 1.275000 seconds
> +	 *
> +	 * Note: the scaling is similar to the scaling in the ADXL380
> +	 */
> +	if (1000000 * val_int + val_fract_us > 1275000)
> +		return -EINVAL;
> +
> +	val_ms = val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
> +	st->ff_time_ms = val_ms;
> +
> +	regval = DIV_ROUND_CLOSEST(val_ms, 5);
> +
> +	/* Values between 100ms and 350ms (0x14 to 0x46) are recommended. */
> +	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
> +}
> +
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -495,6 +561,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_MAG:
> +		ret = adxl345_is_ff_en(st, &int_en);
> +		if (ret)
> +			return ret;
> +		return int_en;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -518,6 +589,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_MAG:
> +		return adxl345_set_ff_en(st, state);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -532,6 +605,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
>  	unsigned int tap_threshold;
> +	unsigned int ff_threshold;
>  	int ret;
>  
>  	switch (type) {
> @@ -565,6 +639,22 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_MAG:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF,
> +					  &ff_threshold);
> +			if (ret)
> +				return ret;
> +			*val = ff_threshold;
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_PERIOD:
> +			*val = st->ff_time_ms;
> +			*val2 = 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -612,6 +702,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  		break;
> +	case IIO_EV_TYPE_MAG:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
> +			if (ret)
> +				return ret;
> +			break;
> +		case IIO_EV_INFO_PERIOD:
> +			ret = adxl345_set_ff_time(st, val, val2);
> +			if (ret)
> +				return ret;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -865,6 +971,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
>  			return ret;
>  	}
>  
> +	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							IIO_MOD_X_OR_Y_OR_Z,

This is the event that got me thinking about whether we were doing this right..

> +							IIO_EV_TYPE_MAG,
> +							IIO_EV_DIR_FALLING),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> +


