Return-Path: <linux-iio+bounces-16342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA375A4DFD2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D0C3A9E71
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF7204875;
	Tue,  4 Mar 2025 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHxby4vO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42019202F79;
	Tue,  4 Mar 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096470; cv=none; b=tibrKgxLuVNNDH2lDXMT0ZGx0VH1TR5c5QxdJHz/Mw3r3kmI5GqT4ddkOoVkuPNwJMVnrsNVz3az2Zux/vHjLv2SvNvBWKfhpzd7pP2/kwTioJU6GTXGbft7pfPoTbBwHb8bpwSns3fxNjW6oxVDSJ8HanhVPC8OCy2pP0OcrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096470; c=relaxed/simple;
	bh=lO5BtaIVLzbtcYLXtGTa+c0cComEL9XeqqwE2ZowYN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wvghv9uDyJH0tl1/Q0dv8NTDmQxJZ9iZsDsbWX3kdGzBtEFrUXQulNuJSy5ju2DFdAMrqp3JqHMAd32bBSQMtTbxyXlfEBSi2+CLJykmcRu41e1mbRK8temn4maQTyhH7EZzB53cr+f+qcA5EU/aMrmKLJ0HkSKWZJes01IKSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHxby4vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81343C4CEEE;
	Tue,  4 Mar 2025 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096469;
	bh=lO5BtaIVLzbtcYLXtGTa+c0cComEL9XeqqwE2ZowYN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHxby4vOd9mmKB5AKTsvqDExNbjqt+Tk7jCpbFyyzoz0K0OAWrgv+dOyg9fBusKtD
	 FkfErCLscs2aHbEJOOMP8xFB/RgslOu853lHyYODAfgJzLm1+FNExP04+o1BnhLuic
	 34+gleVDg2Hga4qG8d8LJ4WnJeUpq1pzwtTEtzl9VU85plnLFSkNvmwsNLp3bB9PX7
	 GVt7wCluKb/M4agsxT0/YldGaJG8HrWaeRiSALxlFblo27OylzmfsjZm7W4QyLFdoP
	 7MOFLL3kiHmU+clZkjAwSCzTktivZUAqWLeyM4OygvI+palpZml42Yprdv2/6DlN4A
	 gnhmrpRydLBeg==
Date: Tue, 4 Mar 2025 13:54:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 13/15] iio: accel: adxl345: add inactivity feature
Message-ID: <20250304135417.6ca9258c@jic23-huawei>
In-Reply-To: <20250220104234.40958-14-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-14-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:32 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the inactivity feature of the sensor. When activity and inactivity
> are enabled, a link bit will be set linking activity and inactivity
> handling. Additionally, the auto-sleep mode will be enabled. Due to the
> link bit the sensor is going to auto-sleep when inactivity was
> detected.
This to me looks like the justification that comment in the previous
patch should mention for why we enable /disable the two together.
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

A few things inline.

> @@ -307,6 +322,17 @@ static int adxl345_write_act_axis(struct adxl345_state *st,
>  					 st->act_axis_ctrl);
>  		if (ret)
>  			return ret;
> +
Probably drop this blank line.
> +	} else {
> +		st->inact_axis_ctrl = en
> +			? st->inact_axis_ctrl | ADXL345_REG_INACT_AXIS_MSK
> +			: st->inact_axis_ctrl & ~ADXL345_REG_INACT_AXIS_MSK;
> +
> +		ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> +					 adxl345_act_axis_msk[type],
> +					 st->inact_axis_ctrl);
> +		if (ret)
> +			return ret;
Maybe it is worth returning in both legs of the if / else?
For this one can just return regmap_update_bits()...

>  	}
>  	return 0;
>  }
> +
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
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	if (ret)
> +		return ret;

	return regmap_write()

> +
> +	return 0;
>  }


