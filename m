Return-Path: <linux-iio+bounces-17417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529FAA76481
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7357F1889357
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37761E1C09;
	Mon, 31 Mar 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIzpGlpb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1C1E1A3B;
	Mon, 31 Mar 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418051; cv=none; b=Rz/HdCxJvCyLExEXndsj1TPNnJZCgzCRu5QMWYAoW+qILb3OP6/oAcfM/5/n6uHhs1nlpKfuL7CYY+KvPrNufJptXbv3FSAdhQ/xSetVpcDe6xaG+LvwxSnIkR/Xn4CX/yKB8gZSqhif4S2bImw7cJj7oBzVPdrLvgy/pnF4qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418051; c=relaxed/simple;
	bh=S137TtYHdRApnd/ionbntMo0ZSY3w1xaepUPlR3u1z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux8gw/i/Ta6jEkMVnvJAI+s69b8SlP/IeEpy0Xoa44nVfeqQC6KZb20F51hSf9gMC5sIzSCLmsDX/Jg/A+ZJlWEykm34w+nc5kxNQJVZmXDqtU0ZbIKFxydWon/OiSgsYWI81ZWbLwLe2miiZ3zSBZYjNtU1MMyq6Qv6QlI9Xb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIzpGlpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5968EC4CEE3;
	Mon, 31 Mar 2025 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743418051;
	bh=S137TtYHdRApnd/ionbntMo0ZSY3w1xaepUPlR3u1z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KIzpGlpbj3mB6TTuD16gGaHYa9LobvnKcztR9l1tppwh/e1jPP/F01xqTTK91lyQ/
	 +BqFsqsqwkrXd0FMYk/TAfdLAcoFW7YjXq6cH/Vr4o+/la8LTgH/9NOkjkXKfrWekc
	 u2Bf3g5EK49SkkccwN/n5rJ+pYPneLThUFH2aw4VU2Ype04CJZIyxOjiYdIJTUDJ6R
	 v2sfuvsaZPNyvTmhArRPoCTVJ83E+0YtYo7jVml5fnUIx3vIoumuXi4XEQ5M83GZsp
	 t41IZbCHhEh2Qk56ldgjrax21iK/8IblihkJpNrSAOJ/OgLC1kyHv/VIgFRotj4ATt
	 MrAH+jFHhoqlg==
Date: Mon, 31 Mar 2025 11:47:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 09/11] iio: accel: adxl345: add inactivity feature
Message-ID: <20250331114724.2c2c2e9b@jic23-huawei>
In-Reply-To: <20250318230843.76068-10-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 23:08:41 +0000
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

A few comments inline.  The magic handling of the value 0 is
a bit of unexpected ABI.

Jonathan

> @@ -327,6 +358,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
>  				    bool cmd_en)
>  {
>  	bool axis_en, en;
> +	unsigned int inact_time_s;
>  	unsigned int threshold;
>  	u32 axis_ctrl = 0;
>  	int ret;
> @@ -345,6 +377,20 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
>  		default:
>  			return -EINVAL;
>  		}
> +	} else {
> +		switch (axis) {
> +		case IIO_MOD_X:
> +			axis_ctrl = ADXL345_INACT_X_EN;
> +			break;
> +		case IIO_MOD_Y:
> +			axis_ctrl = ADXL345_INACT_Y_EN;
> +			break;
> +		case IIO_MOD_Z:
> +			axis_ctrl = ADXL345_INACT_Z_EN;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  	}
>  
>  	if (cmd_en)
> @@ -365,11 +411,67 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
>  	if (type == ADXL345_ACTIVITY) {
>  		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) > 0;
>  		en = axis_en && threshold > 0;
> +	} else {

So previous suggestion on setting en doesn't work but you can still combine
the bits other than the type match to simplify code and get rid of axis_en
in both paths.

> +		ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
> +		if (ret)
> +			return ret;
> +
> +		axis_en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, axis_ctrl) > 0;
> +		en = axis_en && threshold > 0 && inact_time_s > 0;
>  	}

> +/**
> + * adxl345_set_inact_time_s - Configure inactivity time explicitly or by ODR.
> + * @st: The sensor state instance.
> + * @val_s: A desired time value, between 0 and 255.
> + *
> + * If val_s is 0, a default inactivity time will be computed. It should take
> + * power consumption into consideration. Thus it shall be shorter for higher
> + * frequencies and longer for lower frequencies. Hence, frequencies above 255 Hz
> + * shall default to 10 s and frequencies below 10 Hz shall result in 255 s to
> + * detect inactivity.

I'd missed this previously.  I've no problem with a default time being set
on driver load, but a later write of 0 should not result in something very different
as that's not standard use of the ABI.  If a user wants to go back to a sensible
default then they should have stored out what was set initially.

I don't mind if you update the default until the point where they first override
it, but from there on we should obey what they request or error out if the
value requested is not possible.

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

> @@ -1546,10 +1697,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		if (ret)
>  			return ret;
>  
> +		ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, 3);
> +		if (ret)
> +			return ret;
> +
>  		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, 6);
>  		if (ret)
>  			return ret;
>  
> +		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_INACT, 4);

Comments on defaults are good.

> +		if (ret)
> +			return ret;
> +
>  		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, tap_threshold);
>  		if (ret)
>  			return ret;


