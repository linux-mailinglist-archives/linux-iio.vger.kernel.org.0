Return-Path: <linux-iio+bounces-16341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC4A4DFA4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980A23B28FF
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE3204875;
	Tue,  4 Mar 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIcMOqvT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8E20485B;
	Tue,  4 Mar 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096170; cv=none; b=AUgSb9xmu1/5NZhl3knbDgSW1BkTeOHlyAwevEF0mRS4c4SVO0mD+aQzcKy9zlweNDTno2anRw6WoWaH3oOUyeiiHN0REh+FroHjYbLW1FeJYvK+qesXrGD6/PvEeC90YWOZkJ4gghaLtjepQn+8TlQwguay1fNGdezs2FHyR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096170; c=relaxed/simple;
	bh=fyxWa29VHQSI5ZvMqSHC2xD1q88BTq69e8l69PiolJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhlDEyUUg14tqgejermmJlDjPTmOeTSIIn+bBU8t/6r9wlkC/OezJoJQf7vp1+kYMdRK7KwS5PioGGaX97k94F0JJspMYExMdYknD60ADWoDM3PITQ9BwOb127xtxTHtI37itw/meGU1zXPps9dnsbigpqsijlAK9Me79vg1whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIcMOqvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333A7C4CEE7;
	Tue,  4 Mar 2025 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096169;
	bh=fyxWa29VHQSI5ZvMqSHC2xD1q88BTq69e8l69PiolJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OIcMOqvTNBMiyUl66s0VRn5M2wztYf2DYCD6BxJeGvPuZK2NlDlVjeKuIjuf9gcb4
	 AhvIgRfX2KV5zOeLjrWxmYzBImT7Wk6CSkIB+tlBj6KIgwhVnwQHaW9TaKaVkl6Y2C
	 co/5TIpP4sIRJ70gM3g3VJKLU3kaDD0FraIi3xETDTuhikLBg74sGcViZzU5EfzWjJ
	 KbTfdj48KX9U/Qe6LFVNcqUsDs/6wo+viwiItqwNvcC64hXfNh+71bokUOR3nbtPBc
	 sxV4yDscmw3e3alx5N+ostgayp9Y3H7xeAFpkn3d+zxvEWRtO4PdWLTWmEM6WJC7R6
	 l1ZtP5c9MzGfA==
Date: Tue, 4 Mar 2025 13:49:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 12/15] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250304134918.797e6386@jic23-huawei>
In-Reply-To: <20250220104234.40958-13-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-13-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:31 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Make the sensor detect and issue interrupts at activity. Activity
> events are configured by a threshold stored in regmap cache.
> 
> Activity, together with ODR and range setting are preparing a setup
> together with inactivity coming in a follow up patch.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Some questions / comments inline.

This review is has been at random moments whilst travelling (hence
over several days!) so it may be less than thorough or consistent!
I should be back to normal sometime next week.

> @@ -258,6 +284,73 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
>  }
>  
> +/* act/inact */
> +
> +static int adxl345_write_act_axis(struct adxl345_state *st,
> +				  enum adxl345_activity_type type, bool en)
> +{
> +	int ret;
> +
> +	/*
> +	 * The ADXL345 allows for individually enabling/disabling axis for
> +	 * activity and inactivity detection, respectively. Here both axis are
> +	 * kept in sync, i.e. an axis will be generally enabled or disabled for
> +	 * both equally, activity and inactivity detection.

Why?  Can definitely see people only being interested in one case
and not the other.  What advantage is there in always having both
or neither over separate controls?

> +	 */
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
> +	}
> +	return 0;
> +}


> +static int adxl345_set_act_inact_en(struct adxl345_state *st,
> +				    enum adxl345_activity_type type, bool cmd_en)
> +{
> +	bool axis_en, en = false;
I'm not keen on mix of set and unset in a declaration line.  Better to 
use two lines here as it can be hard to spot when things are or aren't
initialized when that is not the intent.

	bool en = false;
	bool axis_en;

> +	unsigned int threshold;
> +	int ret;
> +
> +	ret = adxl345_write_act_axis(st, type, cmd_en);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
> +	if (ret)
> +		return ret;
> +
> +	if (type == ADXL345_ACTIVITY) {
> +		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
> +		en = axis_en && threshold > 0;
> +	}
> +
> +	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> +				  adxl345_act_int_reg[type],
> +				  en ? adxl345_act_int_reg[type] : 0);
> +}
> +

> @@ -842,6 +972,23 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				ret = regmap_write(st->regmap,
> +						   adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> +						   val);
> +				break;
This collection of breaks and nested functions suggests maybe we can either
return directly (I've lost track of what happens after this) or that
we should factor out some of this code to allow direct returns in the
function we put that code in.  Chasing the breaks is not great if it
doesn't lead to anything interesting.
> +			default:
> +				ret = -EINVAL;
> +			}
> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
> +		break;
>  	case IIO_EV_TYPE_GESTURE:
>  		switch (info) {
>  		case IIO_EV_INFO_VALUE:
> @@ -1124,6 +1271,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
>  			return ret;
>  	}
>  
> +	if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							act_tap_dir,
> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_RISING),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
>  		ret = iio_push_event(indio_dev,
>  				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> @@ -1157,6 +1315,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
>  		if (ret)
>  			return ret;
> +		/* tap direction */

Belongs in earlier patch?

>  		if (FIELD_GET(ADXL345_Z_EN, regval) > 0)
>  			act_tap_dir = IIO_MOD_Z;
>  		else if (FIELD_GET(ADXL345_Y_EN, regval) > 0)
> @@ -1165,6 +1324,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  			act_tap_dir = IIO_MOD_X;
>  	}
>  
> +	if (FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0) {
> +		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
> +		if (ret)
> +			return ret;
> +		/* activity direction */
> +		if (FIELD_GET(ADXL345_Z_EN, regval >> 4) > 0)

I'm not following the shifts here.   That looks like we don't have
defines that we should but instead use the ones for the lower fields.

> +			act_tap_dir = IIO_MOD_Z;
> +		else if (FIELD_GET(ADXL345_Y_EN, regval >> 4) > 0)
> +			act_tap_dir = IIO_MOD_Y;
> +		else if (FIELD_GET(ADXL345_X_EN, regval >> 4) > 0)
> +			act_tap_dir = IIO_MOD_X;
> +	}



