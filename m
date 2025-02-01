Return-Path: <linux-iio+bounces-14846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86BA24B0A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720183A6CA1
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F3A1CAA60;
	Sat,  1 Feb 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/eQICHH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B2208A9;
	Sat,  1 Feb 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430867; cv=none; b=FglOwIdZouQ5Svqsl9a9D7eWcYZUPYgXXsswuxdU00hP6vYLelVjc1G8dtD75H+q0zgEE7KkP6GWpkxcO+ShSpbJFNCCH/DX4OGQEI31ip6cfga137YAiqHOID6Nn9Tc1C8P66eLlYF1Zcg641YHKG2UukYwCr2Sdoa/9wwRd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430867; c=relaxed/simple;
	bh=cvc4P5ej72EJpo0sfP1dxv4MhBNr+PKrwBD0ycWpFoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syGLHMvOUuznvRocYr0nhqvXt2DUGA4LVnyvrsq+cTX1J8Hoj49Id5V2r5gXaamWc5epTzxprhWwLRx0wLi9ZdD2gh6USi9VDU5M45GYt3igb6ZBTJOzhhCqsPl9lWcl6/nRUvG4jbIh0Sl1MzR2Rc8dnyZg0VvEIS0M8XMBL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/eQICHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B283C4CED3;
	Sat,  1 Feb 2025 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738430866;
	bh=cvc4P5ej72EJpo0sfP1dxv4MhBNr+PKrwBD0ycWpFoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u/eQICHHrXXdMhSoEL676HILGhYrfzNPoYS1SNTNLq2xDoYMI8GWLPllxagAKcG5j
	 ZOEg+f1Y1uob4tr6jcwjsSGQgn4gzvtVdnIhYZEbVfYeDiW3AuL8slW14y5P/Uz+Do
	 nK362wVnDa9uOE1YhMCNi7HMPdIXkT0nxNJs9Cw3C2SjOJWle3+objLA5GMOJxHBAI
	 gl9DVDR0+2xI61RdLuNyeiIIi1KFG9BW1LyosGeT9SC8yVtJLP00wG1xNqJWApACmk
	 5wXq0s/jEQnGw7GFN3EjlcHXA7S6ZkTYi434pgVbRa+3uuBUaxoMnWvQ+ppLyXDFq+
	 sQzZwbnDp6CVw==
Date: Sat, 1 Feb 2025 17:27:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 11/12] iio: accel: adxl345: add activity feature
Message-ID: <20250201172739.40d12340@jic23-huawei>
In-Reply-To: <20250128120100.205523-12-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-12-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:59 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the handling of activity events, also add sysfs entries to
> configure threshold values to trigger the event. Allow to push the
> event over to the iio channel.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

I was going to guess these were rate of change detectors or ones
at least slightly compensating for g, but superficially
looks like a straight forward rising mag threshold.  Not seeing need
for new ABI.

We've had those interfaces with accelerometers for a long time.
Key is to map the pretty names in the datasheet into what is actually
being detected. That allows for a lot better generalization across manufacturers.

> ---
>  drivers/iio/accel/adxl345_core.c | 158 ++++++++++++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 62d75d28b6fc..94c3ad818ba5 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -121,6 +121,8 @@
>  
>  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
>  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
> +#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
> +#define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
>  
>  enum adxl345_axis {
>  	ADXL345_Z_EN = BIT(0),
> @@ -163,6 +165,10 @@ struct adxl345_state {
>  	u8 watermark;
>  	u8 fifo_mode;
>  
> +	u32 act_axis_ctrl;
> +	bool act_ac;
> +	u8 act_value;
> +
>  	u32 tap_axis_ctrl;
>  	u8 tap_threshold;
>  	u32 tap_duration_us;
> @@ -177,6 +183,11 @@ struct adxl345_state {
>  };
>  
>  static struct iio_event_spec adxl345_events[] = {
> +	{
> +		/* activity */
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +	},
>  	{
>  		/* single tap */
>  		.type = IIO_EV_TYPE_GESTURE,
> @@ -276,6 +287,117 @@ static inline int adxl345_write_interrupts(struct adxl345_state *st)
>  	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
>  }
>  
> +/* act/inact */
> +
> +static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
> +{
> +	int ret;
> +
> +	/*
> +	 * A setting of 0 selects dc-coupled operation, and a setting of 1
> +	 * enables ac-coupled operation. In dc-coupled operation, the current
> +	 * acceleration magnitude is compared directly with THRESH_ACT and
> +	 * THRESH_INACT to determine whether activity or inactivity is
> +	 * detected.
> +	 *
> +	 * In ac-coupled operation for activity detection, the acceleration
> +	 * value at the start of activity detection is taken as a reference
> +	 * value. New samples of acceleration are then compared to this
> +	 * reference value, and if the magnitude of the difference exceeds the
> +	 * THRESH_ACT value, the device triggers an activity interrupt.
> +	 *
> +	 * Similarly, in ac-coupled operation for inactivity detection, a
> +	 * reference value is used for comparison and is updated whenever the
> +	 * device exceeds the inactivity threshold. After the reference value
> +	 * is selected, the device compares the magnitude of the difference
> +	 * between the reference value and the current acceleration with
> +	 * THRESH_INACT. If the difference is less than the value in
> +	 * THRESH_INACT for the time in TIME_INACT, the device is  considered
> +	 * inactive and the inactivity interrupt is triggered.
> +	 */
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> +				 ADXL345_REG_ACT_ACDC_MSK, st->act_ac);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The ADXL345 allows for individually enabling/disabling axis for
> +	 * activity and inactivity detection, respectively. Here both axis are
> +	 * kept in sync, i.e. an axis will be generally enabled or disabled for
> +	 * both equally, activity and inactivity detection.
> +	 */
> +	st->act_axis_ctrl = en
> +		? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
> +		: st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> +				 ADXL345_REG_ACT_AXIS_MSK,
> +				 st->act_axis_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_act_int(struct adxl345_state *st)
> +{
> +	bool args_valid;
> +	bool axis_en;
> +
> +	axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
> +	args_valid = axis_en && st->act_value > 0;
> +	adxl345_intmap_switch_bit(st, args_valid, ADXL345_INT_ACTIVITY);
> +
> +	return adxl345_write_interrupts(st);
> +}
> +
> +static int _adxl345_is_act_en(struct adxl345_state *st, bool *en)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = adxl345_read_interrupts(st, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*en = FIELD_GET(ADXL345_INT_ACTIVITY, regval) > 0;
> +
> +	return 0;
> +}
> +
> +static int _adxl345_set_act_en(struct adxl345_state *st, bool en)
> +{
> +	int ret;
> +
> +	ret = adxl345_write_act_axis(st, en);
> +	if (ret)
> +		return ret;
> +
> +	return adxl345_set_act_int(st);
> +}
> +
> +static int adxl345_is_act_en(struct adxl345_state *st, bool *en)
> +{
> +	return _adxl345_is_act_en(st, en);
> +}
> +
> +static int adxl345_set_act_en(struct adxl345_state *st, bool en)
> +{
> +	return _adxl345_set_act_en(st, en);
> +}
> +
> +static int _adxl345_set_act_value(struct adxl345_state *st, u8 val)
> +{
> +	st->act_value = val;
> +
> +	return regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, val);
> +}
> +
> +static int adxl345_set_act_value(struct adxl345_state *st, u8 val)
> +{
> +	return _adxl345_set_act_value(st, val);
> +}


