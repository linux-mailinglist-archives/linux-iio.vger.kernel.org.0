Return-Path: <linux-iio+bounces-20658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4EAD9D3F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 16:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C91894205
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5923185F;
	Sat, 14 Jun 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3RELpI4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9A1EEE6;
	Sat, 14 Jun 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749909633; cv=none; b=C3DBBIcK0qREPK/oV63gR1E/HNx1GE3uHQcTKj5gdjlBhpnfo9MtK5uNPclF7UGmrkKOydWHA6AAhAQiEvMx23TgMzELZhKYfye7kttxllLGRRkuam9MjlgZ0vvHX10C3Nm0yAWe9RQlPrhcSuQiEB4S3MXdWKO87T+/+E/NrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749909633; c=relaxed/simple;
	bh=pYdg0jmTz6Fesuvw+KBPP4TvYjlvCIdFuYa9ZjdiI6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWfsamKmv5wk+fyKF6EOiqjAl68Q6MUuiX2AgiCZjWQgk16cq1JMwsVRPGklWmhdesCPjv8QSEsqiB/JRCn2dCUVPQcgpXC6ZINEKAKdwSXSO0IfY607R+4ZUs1mCYI24EgoRyq+ShjlyX4aBetEH9jZv2kzEmdCtFxae+5h6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3RELpI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95647C4CEEB;
	Sat, 14 Jun 2025 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749909633;
	bh=pYdg0jmTz6Fesuvw+KBPP4TvYjlvCIdFuYa9ZjdiI6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B3RELpI457tXx0irtDBxRKKQeAiCSPd+5xKqulvZ6rlWCVslo8K+qWWncDc+hxaa2
	 9hZaejTRkM0wW3W9LfPgFWEpllCraGzfMKpHxG+HwYgxrEM2/0K2Zg58UjCt2pQgEG
	 1Zrv1HmtaDNq49GhQgiCOAh2r2oC/09xfKHYf8dE1wE9qKk8tqM1uaWue5nm1STjSH
	 dzzWgh1RNMid8P+fdKPp0Z46Ut2oCxCWe+9A7oQ82J1IMG2GvOzbCfuWDlOir162Ps
	 j29vLfa1hJ3qpDYRwKkCRhs5hr0I71edmXtQGH55bxCnCmhaz9+c+HKQSeSm/+qjcl
	 Hr3tZfa72A9IA==
Date: Sat, 14 Jun 2025 15:00:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 08/11] iio: accel: adxl345: add inactivity feature
Message-ID: <20250614150024.09c5add4@jic23-huawei>
In-Reply-To: <20250610215933.84795-9-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:30 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the inactivity feature of the sensor to the driver. When activity
> and inactivity are enabled, a link bit will be set linking activity and
> inactivity handling. Additionally, the auto-sleep mode will be enabled.
> Due to the link bit the sensor is going to auto-sleep when inactivity
> was detected.
> 
> Inactivity detection needs a threshold to be configured and a period of
> time in seconds. After, it will transition to inactivity state, if
> measurements stay below inactivity threshold.
> 
> When a ODR is configured the period for inactivity is adjusted with a
> corresponding reasonable default value, in order to have higher
> frequencies, lower inactivity times, and lower sample frequency but
> give more time until inactivity. Both with reasonable upper and lower
> boundaries, since many of the sensor's features (e.g. auto-sleep) will
> need to operate between 12.5 Hz and 400 Hz. This is a default setting
> when actively changing sample frequency, explicitly setting the time
> until inactivity will overwrite the default.
> 
> Similarly, setting the g-range will provide a default value for the
> activity and inactivity thresholds. Both are implicit defaults, but
> equally can be overwritten to be explicitly configured.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Just a few trivial comments from me.

J
> ---
>  drivers/iio/accel/adxl345_core.c | 238 +++++++++++++++++++++++++++++--
>  1 file changed, 227 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 04b9f155872f..1670315ebd63 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c

> @@ -334,12 +423,37 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
>  		en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
>  			threshold;
>  		break;
> +	case ADXL345_INACTIVITY:
> +		ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
> +		if (ret)
> +			return ret;
> +
> +		en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, axis_ctrl) &&
> +			threshold && inact_time_s;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
>  	ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> -				 adxl345_act_int_reg[type], cmd_en && en);
> +				 adxl345_act_int_reg[type], cmd_en);
> +	if (ret)
> +		return ret;
> +
> +	/* Set sleep and link bit when ACT and INACT are enabled. */
> +	act_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
> +	if (act_en < 0)
> +		return act_en;
> +
> +	inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
> +	if (inact_en < 0)
> +		return inact_en;
> +
> +	en = en && act_en && inact_en;
> +

For consistency with above, I'd drop this blank line.

> +	ret = regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
> +				 (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK),

Not sure that inner set of brackets are adding anything much to readability.

> +				 en);
>  	if (ret)
>  		return ret;
>  


> @@ -887,19 +1072,31 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
>  	case IIO_EV_TYPE_MAG:
>  		switch (info) {
>  		case IIO_EV_INFO_VALUE:
> +			val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);

Put it here in the earlier patch.  Though that might not makes sense when
you use some more helpers as Andy suggested.  No one really likes 3 levels
of switch!

>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
> -				val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
>  				ret = regmap_write(st->regmap,
>  						   adxl345_act_thresh_reg[ADXL345_ACTIVITY],
>  						   val);
>  				if (ret)
>  					return ret;
>  				break;
> +			case IIO_EV_DIR_FALLING:
> +				ret = regmap_write(st->regmap,
> +						   adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> +						   val);
> +				if (ret)
> +					return ret;
> +				break;

