Return-Path: <linux-iio+bounces-18289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268BA93CE0
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB847B3594
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3622578A;
	Fri, 18 Apr 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvjHq0QD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900222541C;
	Fri, 18 Apr 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001260; cv=none; b=ts1i9G/o1qgomJnw4gtQUJKAaV88ayj4xPxv7/O+6tK0s6R5oaLxyAF1AHUPMPK5vN0HuA3CN49dix6bGJMgBAeJL0AoamSNGeQ9wSOblyT54VyIPEvrtmn/YxEVGKYFwvfainkYwS628WnPzsUhq4zEBlULWQ5ms5ERRBdMGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001260; c=relaxed/simple;
	bh=FIXqyEgN8djbMnz6M52LLP9Fcc8mMMOnGHMLKvGIrF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTN8uZQEqxMdx3ied5aEloeWrVRGfifuLo1dSxfkmMtPb9tXJCOAn36uftidZ/5cSDPy4TaUHaP1XHFHJIqWMifP4HuXKVBxEQl48FNAvm0BXyRHhAUyjK7H43kMXglowVA+59Lh9dBA704X1ef6M4gLnmZTPQeQSvMlG7w4dvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvjHq0QD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36338C4CEE2;
	Fri, 18 Apr 2025 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745001259;
	bh=FIXqyEgN8djbMnz6M52LLP9Fcc8mMMOnGHMLKvGIrF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KvjHq0QDPF/hR500jhetMspxBZuSG7SCq1YxUsD+wXrBB7GQDq5jDVirp5RlAMChT
	 Pztiuefxw9ChrQzuNpC8VgOIrQ952P4bMMOgdgm9t+43PydglthgoGdCMzY7vNumn5
	 CKsZ88rEyPMDvN4z40R6sC9uMgZI9lHIZ4LzB4sAW8G3w1M9ePrxa0Djd/StLFPPfn
	 uYbKQqCoOiEfWF2n+1wXdq+bawsmHmkcjVwMH7a7qU0YB2Jw1j7wWViqinT7oCRMHG
	 +CK8iohchoN8giBh/X+bsZVPdVcX+s42k3XQB6wkqofWUdMC1z93m5GP673Vf6mF9Z
	 M2/Zg/pttkcfw==
Date: Fri, 18 Apr 2025 19:34:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v6 09/11] iio: accel: adxl345: add inactivity feature
Message-ID: <20250418193411.406bd974@jic23-huawei>
In-Reply-To: <20250414184245.100280-10-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
	<20250414184245.100280-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 18:42:43 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the inactivity feature of the sensor. When activity and inactivity
> are enabled, a link bit will be set linking activity and inactivity
> handling. Additionally, the auto-sleep mode will be enabled. Due to the
> link bit the sensor is going to auto-sleep when inactivity was
> detected.
> 
> Inactivity detection needs a threshold to be configured, and a time
> after which it will go into inactivity state if measurements under
> threshold.
> 
> When a ODR is configured this time for inactivity is adjusted with a
> corresponding reasonable default value, in order to have higher
> frequencies and lower inactivity times, and lower sample frequency but
> give more time until inactivity. Both with reasonable upper and lower
> boundaries, since many of the sensor's features (e.g. auto-sleep) will
> need to operate beween 12.5 Hz and 400 Hz. This is a default setting
> when actively changing sample frequency, explicitly setting the time
> until inactivity will overwrite the default.
> 
> Similarly, setting the g-range will provide a default value for the
> activity and inactivity thresholds. Both are implicit defaults, but
> equally can be overwritten to be explicitly configured.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

Patches 6-8 look good to me.

This runs into a similar issue to the freefall one. I haven't dug into
the datasheet but does it report on one channel going inactive, or
all being inactive at the same time?  I checked and it is the all
case so we should be both on a pseudo channel to describe it right
and reporting IIO_MOD_X_AND_Y_AND_Z not the OR form.

Sorry again that I'm only realising this on v6 :(

Difference is for Activity the definition is:
"The activity bit is set when acceleration greater than the value
stored in the THRESH_ACT register (Address 0x24) is experienced
on _any_ participating axis, set by the ACT_INACT_CTL register
(Address 0x27)."
vs Inactivity:
"The inactivity bit is set when acceleration of less than the value
stored in the THRESH_INACT register (Address 0x25) is experienced
for more time than is specified in the TIME_INACT
register (Address 0x26) on _all_ participating axes, as set by the
ACT_INACT_CTL register (Address 0x27). "

So all vs any.

> +
> +/**
> + * adxl345_set_inact_time_s - Configure inactivity time explicitly or by ODR.
> + * @st: The sensor state instance.
> + * @val_s: A desired time value, between 0 and 255.
> + *
> + * Inactivity time can be configured between 1 and 255 sec. If a val_s of 0
> + * is configured by a user, then a default inactivity time will be computed.
> + *
> + * In such case, it should take power consumption into consideration. Thus it
> + * shall be shorter for higher frequencies and longer for lower frequencies.
> + * Hence, frequencies above 255 Hz shall default to 10 s and frequencies below
> + * 10 Hz shall result in 255 s to detect inactivity.
> + *
> + * The approach simply subtracts the pre-decimal figure of the configured
> + * sample frequency from 255 s to compute inactivity time [s]. Sub-Hz are thus
> + * ignored in this estimation. The recommended ODRs for various features
> + * (activity/inactivity, sleep modes, free fall, etc.) lie between 12.5 Hz and
> + * 400 Hz, thus higher or lower frequencies will result in the boundary
> + * defaults or need to be explicitly specified via val_s.
> + *
> + * Return: 0 or error value.
> + */
> +static int adxl345_set_inact_time_s(struct adxl345_state *st, u32 val_s)
> +{
> +	unsigned int max_boundary = 255;
> +	unsigned int min_boundary = 10;
> +	unsigned int val = min(val_s, max_boundary);
> +	enum adxl345_odr odr;
> +	unsigned int regval;
> +	int ret;
> +
> +	if (val == 0) {
> +		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
> +		if (ret)
> +			return ret;
> +		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> +
> +		val = (adxl345_odr_tbl[odr][0] > max_boundary)
> +			? min_boundary : max_boundary -	adxl345_odr_tbl[odr][0];
> +	}
> +
> +	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
>  }
>  
>  /* tap */
> @@ -837,6 +943,13 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
>  			if (ret)
>  				return ret;
>  			return int_en;
> +		case IIO_EV_DIR_FALLING:
> +			ret = adxl345_is_act_inact_en(st, chan->channel2,

Does it makes sense to allow inactivity detection on a subset of channels but then
report it as XYZ?  I guess it didn't matter when it was and OR, but if we
change to AND as suggested that is going to be misleading.

we might have to allow separate enables but report an event as the combination
of channels that are enabled X_AND_Y, X_AND_Z etc  I guess we can improve activity
channel case as well by doing that with the X_OR_Y etc



> +						      ADXL345_INACTIVITY,
> +						      &int_en);
> +			if (ret)
> +				return ret;
> +			return int_en;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -881,6 +994,9 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
>  		case IIO_EV_DIR_RISING:
>  			return adxl345_set_act_inact_en(st, chan->channel2,
>  							ADXL345_ACTIVITY, state);
> +		case IIO_EV_DIR_FALLING:
> +			return adxl345_set_act_inact_en(st, chan->channel2,
> +							ADXL345_INACTIVITY, state);
>  		default:
>  			return -EINVAL;
>  		}

> @@ -1314,6 +1458,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
>  			return ret;
>  	}
>  
> +	if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							IIO_MOD_X_OR_Y_OR_Z,

So this is our open question. Similar to the free fall case. Do we have the boolean
logic right way around?

> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_FALLING),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> +

