Return-Path: <linux-iio+bounces-22799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D881CB28D85
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA091C82321
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687E291C1C;
	Sat, 16 Aug 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA6d6NkB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD03248F4E;
	Sat, 16 Aug 2025 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755345614; cv=none; b=tOHygawomhP0lSH088p6vI3aq4eoAxBEQxCuFpAqkUTc45nACMDY6JJhxefHWgS7Jk4f46ql1L56bzPbGERelV9R6V5Ictn+B25IzbC59oTfj8ExEbQ8sdJYfnxEkhVP+JerzzK27Ql2afkXmq4bwJZMuiK56BUeK2OngWbd0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755345614; c=relaxed/simple;
	bh=YyT9VmgGsLPhHji6Xt5V9PnkrRS+Xqsx2HovdXgAOCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cw8zypgBqGnhlxFgDZLKBeK1DmIcpqMwv7g3OlaipeWAFAsZvLaydMErMEdELpXbGnzstH+A+mH6fXY0PSMJ8zhyeO/Sh8YwOT5NPMXVqvvRj576nlGYt+Ywp8kpp/CCyV+9hfyiASkgLtXDVc602YUeDOFGbW+ym3PgnWLbQpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA6d6NkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB8CC4CEF1;
	Sat, 16 Aug 2025 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755345614;
	bh=YyT9VmgGsLPhHji6Xt5V9PnkrRS+Xqsx2HovdXgAOCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AA6d6NkBOqOzwhLK5CEoSAPDKnuNnrZC57jvfubQ/C8ZcWmXdevlL9usA3yjSAYyD
	 U4JCVQAcROVlZHq3B/HegEIiyv6/SnHDb+TvzgpSRqkMpzkcfQuLHaRQ5PjL6g5jaq
	 0AifDpstHPmzT/iP9Lvgre6xqi04gv4tLZvvh3xDStBRMSXpdGVjhwHFNJXedIM640
	 5SUjjgwp+OzqjcmmWSkyHNZC6hVfXGjy4DTalcF14FgEMN/hV1BtdG+o/OKXD+1N4J
	 UM8BQZwgnaGDEL80yF6I7Z4b8JLJWlisjdf7+UK4NRPQKrR1+iVPY8EsU9Tz3hvx5T
	 A5UHz7TsY96gA==
Date: Sat, 16 Aug 2025 13:00:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/9] iio: imu: inv_icm45600: add buffer support in
 iio devices
Message-ID: <20250816130004.53021d6b@jic23-huawei>
In-Reply-To: <20250814-add_newport_driver-v4-3-4464b6600972@tdk.com>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
	<20250814-add_newport_driver-v4-3-4464b6600972@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 08:57:17 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add FIFO control functions.
> Support hwfifo watermark by multiplexing gyro and accel settings.
> Support hwfifo flush.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>

Comments inline.

Thanks,

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..59415e9b1e4ee21a641781275e3654402cf6d0a8
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c

> +/**
> + * inv_icm45600_buffer_update_watermark - update watermark FIFO threshold
> + * @st:	driver internal state
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + *
> + * FIFO watermark threshold is computed based on the required watermark values
> + * set for gyro and accel sensors. Since watermark is all about acceptable data
> + * latency, use the smallest setting between the 2. It means choosing the
> + * smallest latency but this is not as simple as choosing the smallest watermark
> + * value. Latency depends on watermark and ODR. It requires several steps:
> + * 1) compute gyro and accel latencies and choose the smallest value.
> + * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
> + *    ones. Otherwise it is possible that you don't meet a requirement. (for
> + *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
> + *    value of 4 will not meet accel latency requirement because 6 is not a
> + *    multiple of 4. You need to use the value 2.)
> + * 3) Since all periods are multiple of each others, watermark is computed by
> + *    dividing this computed latency by the smallest period, which corresponds
> + *    to the FIFO frequency.
> + */
> +int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st)
> +{
> +	const size_t packet_size = sizeof(struct inv_icm45600_fifo_2sensors_packet);
> +	unsigned int wm_gyro, wm_accel, watermark;
> +	u32 period_gyro, period_accel, period;
> +	u32 latency_gyro, latency_accel, latency;
> +
> +	/* Compute sensors latency, depending on sensor watermark and odr. */
> +	wm_gyro = inv_icm45600_wm_truncate(st->fifo.watermark.gyro, packet_size,
> +					   st->fifo.period);
> +	wm_accel = inv_icm45600_wm_truncate(st->fifo.watermark.accel, packet_size,
> +					    st->fifo.period);
> +	/* Use us for odr to avoid overflow using 32 bits values. */
> +	period_gyro = inv_icm45600_odr_to_period(st->conf.gyro.odr) / 1000UL;
> +	period_accel = inv_icm45600_odr_to_period(st->conf.accel.odr) / 1000UL;
> +	latency_gyro = period_gyro * wm_gyro;
> +	latency_accel = period_accel * wm_accel;
> +
> +	/* 0 value for watermark means that the sensor is turned off. */
> +	if (wm_gyro == 0 && wm_accel == 0)
> +		return 0;
> +
> +	if (latency_gyro == 0) {
> +		watermark = wm_accel;
> +		st->fifo.watermark.eff_accel = wm_accel;
> +	} else if (latency_accel == 0) {
> +		watermark = wm_gyro;
> +		st->fifo.watermark.eff_gyro = wm_gyro;
> +	} else {
> +		/* Compute the smallest latency that is a multiple of both. */
> +		if (latency_gyro <= latency_accel)
> +			latency = latency_gyro - (latency_accel % latency_gyro);
> +		else
> +			latency = latency_accel - (latency_gyro % latency_accel);
> +		/* Use the shortest period. */
> +		period = min(period_gyro, period_accel);
> +		/* All this works because periods are multiple of each others. */
> +		watermark = latency / period;
> +		if (watermark < 1)
> +			watermark = 1;

		watermark = max(latency/period, 1);

> +		/* Update effective watermark. */
> +		st->fifo.watermark.eff_gyro = latency / period_gyro;
> +		if (st->fifo.watermark.eff_gyro < 1)
> +			st->fifo.watermark.eff_gyro = 1;

		st->fifo.atermark.eff_gyro = max(latency / period_gyro, 1);

> +		st->fifo.watermark.eff_accel = latency / period_accel;
> +		if (st->fifo.watermark.eff_accel < 1)
> +			st->fifo.watermark.eff_accel = 1;
		max()
> +	}
> +
> +
> +	st->buffer.u16 = cpu_to_le16(watermark);
> +	return regmap_bulk_write(st->map, INV_ICM45600_REG_FIFO_WATERMARK,
> +				&st->buffer.u16, sizeof(st->buffer.u16));
> +}
> +
> +int inv_icm45600_buffer_init(struct inv_icm45600_state *st)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	st->fifo.watermark.eff_gyro = 1;
> +	st->fifo.watermark.eff_accel = 1;
> +
> +	/* Disable all FIFO EN bits. */
> +	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG3, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable FIFO and set depth. */
> +	val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> +				INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);

Align immediately after (


> +	val |= INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX;
> +	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable only timestamp in fifo, disable compression. */
> +	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG4,
> +			   INV_ICM45600_FIFO_CONFIG4_TMST_FSYNC_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable FIFO continuous watermark interrupt. */
> +	return regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG2,
> +			       INV_ICM45600_REG_FIFO_CONFIG2_WM_GT_TH);
> +}


> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> index 0fdf86cdfe547357d2b74d9c97092e9a1e5722a8..cad632fb2e5158e9cd7cee66f77eb56fe101ecc3 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> @@ -17,6 +17,7 @@


> +/**
> + * inv_icm45600_irq_init() - initialize int pin and interrupt handler
> + * @st:		driver internal state
> + * @irq:	irq number
> + * @irq_type:	irq trigger type
> + * @open_drain:	true if irq is open drain, false for push-pull
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm45600_irq_init(struct inv_icm45600_state *st, int irq,
> +				 int irq_type, bool open_drain)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	/* Configure INT1 interrupt: default is active low on edge. */
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +	case IRQF_TRIGGER_HIGH:
> +		val = INV_ICM45600_INT1_CONFIG2_ACTIVE_HIGH;
> +		break;
> +	default:
> +		val = INV_ICM45600_INT1_CONFIG2_ACTIVE_LOW;
> +		break;
> +	}
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_HIGH:
> +		val |= INV_ICM45600_INT1_CONFIG2_LATCHED;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!open_drain)
> +		val |= INV_ICM45600_INT1_CONFIG2_PUSH_PULL;
> +
> +	ret = regmap_write(st->map, INV_ICM45600_REG_INT1_CONFIG2, val);
> +	if (ret)
> +		return ret;
> +
> +	irq_type |= IRQF_ONESHOT;

I'd do that in the call and avoid changing the meaning of the irq_type
local variable in this function.

> +	return devm_request_threaded_irq(dev, irq, inv_icm45600_irq_timestamp,
> +					 inv_icm45600_irq_handler, irq_type,

					 irq_type | IRQF_ONESHOT,

> +					 "inv_icm45600", st);
> +}
> +
>  static int inv_icm45600_timestamp_setup(struct inv_icm45600_state *st)
>  {
>  	/* Enable timestamps. */
> @@ -556,6 +646,8 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
>  	struct fwnode_handle *fwnode;
>  	struct inv_icm45600_state *st;
>  	struct regmap *regmap_custom;
> +	int irq, irq_type;
> +	bool open_drain;
>  	int ret;
>  
>  	/* Get INT1 only supported interrupt. */
> @@ -563,6 +655,17 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
>  	if (!fwnode)
>  		return dev_err_probe(dev, -ENODEV, "Missing FW node\n");
>  
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err_probe(dev, irq, "Missing INT1 interrupt\n");
dev_err_probe() doesn't print on defer anyway. (or -ENOMEM)

What you've done here is stopped the debug logic for deferred probe reasons getting
the info on it being because we are waiting for an interrupt.  If this was intentional
then add a comment, otherwise just
		return dev_err_probe()
here

> +		return irq;
> +	}

> @@ -633,6 +748,23 @@ static int inv_icm45600_suspend(struct device *dev)
>  
>  		st->suspended.gyro = st->conf.gyro.mode;
>  		st->suspended.accel = st->conf.accel.mode;
> +
> +		/* Disable FIFO data streaming. */
> +		if (st->fifo.on) {
> +			unsigned int val;
> +
> +			ret = regmap_clear_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
> +						INV_ICM45600_FIFO_CONFIG3_IF_EN);
> +			if (ret)
> +				return ret;
> +			val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> +						INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
> +			ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
> +						INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
> +			if (ret)
> +				return ret;
> +		}
> +
>  	}
>  
>  	return pm_runtime_force_suspend(dev);
> @@ -653,10 +785,30 @@ static int inv_icm45600_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	scoped_guard(mutex, &st->lock)
> +	scoped_guard(mutex, &st->lock) {
> +
>  		/* Restore sensors state. */
>  		ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
>  						st->suspended.accel, NULL);
> +		if (ret)
> +			return ret;
> +
> +		/* Restore FIFO data streaming. */
Its a little odd to resume in a different order to how we took things down.
Perhaps add a comment if there is a reason for that.  If not reorder it
purely to make it easier to review.


> +		if (st->fifo.on) {
> +			unsigned int val;
> +
> +			inv_sensors_timestamp_reset(&gyro_st->ts);
> +			inv_sensors_timestamp_reset(&accel_st->ts);
> +			val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> +						INV_ICM45600_FIFO_CONFIG0_MODE_STREAM);
> +			ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
> +						INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
> +			if (ret)
> +				return ret;
> +			ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
> +					INV_ICM45600_FIFO_CONFIG3_IF_EN);
> +		}
> +	}
>  
>  	return ret;
>  }
> 


