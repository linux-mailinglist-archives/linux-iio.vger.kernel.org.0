Return-Path: <linux-iio+bounces-15601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C06A3764B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786EF18853C3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA919D083;
	Sun, 16 Feb 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX+f3Til"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D93A27B;
	Sun, 16 Feb 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739727206; cv=none; b=IiK/XkfiKCf2mnz4+pYkq8PLD0ndL2TKv0eTOz73D8enkH4uiR2sMs4PJF3Ae8JvIQ8ecmj0REowwqdvbSu2fw9fz/YushFLWuIP1W5bkFbF0uoDD/ZVq2jOpsCf7Vsz+78llHs1PRWLdBbUFG29MziTmwRxGWzeHOOsA81jTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739727206; c=relaxed/simple;
	bh=V/7RDCTWufI+dHhuXq9U38eKpYjAVhq8byX2HgsMczk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QK1/wzjcmjHjJeTFM1WDvIXYnd/3cGVmPrnWoqKUfMQ3OqKsejfWtUxDLe5ABCakPy0gdQS6cfjkNzJWiS9oDoesuj+4I5+AVvCJLkIK+WCxG3j6Trvs8VCBC9vWwKDzCrwKhE/JgXO8OXSakkA5GuA6RIuF4Y3Uh4AUrMmC3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX+f3Til; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07F8C4CEDD;
	Sun, 16 Feb 2025 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739727205;
	bh=V/7RDCTWufI+dHhuXq9U38eKpYjAVhq8byX2HgsMczk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mX+f3Til4ffsR0sPW6uNk/ruZZNn+4ChO3PMIIXFbbsb1cp9LxfyBWP8RWTuS9lZt
	 OltNkHQYjmo2BZd12Ae7hACrjIOpmYWcd0FIdzJoERiO/YYRwTP8ZlvyYXEkp75xrc
	 QhkTi1GAZ1d6PYTfWsSaGZAthg/Z4hN2/URvwB2uwYRlDCpSwgu/tKMZ0yqq1PACYn
	 mAYFW/ArDSqVsfGF3q1aXM61l8EFU15Nb4yUAderO7iew/Gc6mC4gDaLQ9YwHjyGfh
	 /SLtKkFTpUvzM2/MpBhcccy/x6KwVo7gzeVmL2HDnMik7cUKGgLmNIS2dJM6gd75uJ
	 6vfnSz+nRLIRg==
Date: Sun, 16 Feb 2025 17:33:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 08/14] iio: accel: adxl345: add freefall feature
Message-ID: <20250216173318.0e7f588c@jic23-huawei>
In-Reply-To: <20250210110119.260858-9-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:13 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the freefall detection of the sensor together with a threshold and
> time parameter. A freefall event is detected if the measuring signal
> falls below the threshold.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

A few follow on comments from earlier suggestions.

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 118 +++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index b6966fee3e3d..56c5a4d85d71 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -84,6 +84,9 @@ struct adxl345_state {
>  	u32 tap_window_us;
>  	bool tap_suppressed;
>  
> +	u8 ff_threshold;
> +	u32 ff_time_ms;
> +
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
>  
> @@ -104,6 +107,14 @@ static struct iio_event_spec adxl345_events[] = {
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
>  };
>  
>  #define ADXL345_CHANNEL(index, reg, axis) {					\
> @@ -354,6 +365,68 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
>  	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
>  }
>  
> +/* ff */

Spell it out.  Otherwise this comment doesn't add anything given function
names all include ff.

> +
> +static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);

Why read into regval then use intmap?
I would just use regval.

> +	if (ret)
> +		return ret;
> +
> +	*en = FIELD_GET(ADXL345_INT_FREE_FALL, st->int_map) > 0;

It's a single bit isn't it?  In which case just set to that value
which will be 1 or 0 anyway.

I'm not sure this function adds enough to be worth keeping.
Maybe just do the regmap_read() and FIELD_GET at the call site.

> +
> +	return 0;
> +}
> +
> +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> +{
> +	bool en = cmd_en && st->ff_threshold > 0 && st->ff_time_ms > 0;
> +
> +	en ? __set_bit(ilog2(ADXL345_INT_FREE_FALL), (unsigned long *)&st->int_map)
> +		: __clear_bit(ilog2(ADXL345_INT_FREE_FALL), (unsigned long *)&st->int_map);
> +
> +	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);

As before, if we just use the regmap cache can use the regmap functions
for clearing and setting bits.

> +}
> +
>

