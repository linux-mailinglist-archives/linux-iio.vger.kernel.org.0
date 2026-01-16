Return-Path: <linux-iio+bounces-27885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00AD38696
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 21:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B57FD30802A0
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C8A399A43;
	Fri, 16 Jan 2026 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGNS/0ga"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7A34D4CB;
	Fri, 16 Jan 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593900; cv=none; b=u2JMxibAoGzr5X46rzQ/orJ3wivjzQRuYD8bK7dS+ZBSc5+Cr4s+Gbwmld8Fb6cSrQWS04y4myNZ7fv6XjxUqyVQDqQkXmMO3f2TLOKB4pOa8RmKlVuuCVPZI1LJWDZ1MM900IplMIrLbKuDQLz0bC3b+pDaiLJnjlz0BvLGEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593900; c=relaxed/simple;
	bh=3CRqyEuCMk1/C8KiVAfQjQwoi5unasJXCqw/clwrOfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ena2Dkbf79na3MwcwKmd2Gl90v18JrWDBz23UEm1Hom9veCNWJS2KLOpzj4Ioot6iM73zwgn4SrJUIr8HejZVL4SQyZiKhjLHmChsSBFCPrDm9TkFtjIB89VdbybkPCXnnmYH/bBKw06x7PPAxx+hXmMf4tnshf2U0Gvo8JydLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGNS/0ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE7EC116C6;
	Fri, 16 Jan 2026 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768593900;
	bh=3CRqyEuCMk1/C8KiVAfQjQwoi5unasJXCqw/clwrOfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GGNS/0gaM2mXfNlrkeKKbLBC1t7UszlbfzmMYKfp1IdX+rRH7dO0JU5xw1cAJmVr5
	 VWR1ojEdIJSwNs81f1uYhFlR7UxwZUr3T4djiiVvL2P1/DOEsOaIgeFvHGjl75dxX4
	 gsZMSxwSoI6gpA0RyENM7SC1Wfg6pMd/OQJ6uPBn0OcaVg2mGHjCc95PUBtgMNF5Iu
	 Y1F8trKfxS5VnH8mqxjHkLAXhYcuGhEuv88zQulH1n9gFbzh/Bipb6BV6BN0t6MtYA
	 XdCAqcg5skuHUiWgVCCG9cwqOYWaaxbeXIS2fBc/VuEKEgZ+jOefGLZxvoiYStbmVS
	 NbacVyQ8XGWRw==
Date: Fri, 16 Jan 2026 20:04:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <20260116200451.4c951e3f@jic23-huawei>
In-Reply-To: <20260115122431.1014630-4-flavra@baylibre.com>
References: <20260115122431.1014630-1-flavra@baylibre.com>
	<20260115122431.1014630-4-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 13:24:31 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
> 
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding this
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
> 
> Tested on LSMDSV16X.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Nice. A couple of really minor comments inline.

Jonathan

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> new file mode 100644
> index 000000000000..3594d97a98ff
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

> +
> +int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_reg *en_reg;
> +	int err;
> +
> +	guard(mutex)(&hw->page_lock);
> +
> +	en_reg = &hw->settings->sf_settings.enable;
> +	err = st_lsm6dsx_sf_set_page(hw, true);
> +	if (err < 0)
> +		return err;
> +
> +	err = regmap_assign_bits(hw->regmap, en_reg->addr, en_reg->mask, enable);
> +	st_lsm6dsx_sf_set_page(hw, false);

Similar to below. Feels odd to check all the other accesses but not the one
setting the page back to normal page.

> +
> +	return err;
> +}
> +
> +int st_lsm6dsx_sf_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	u8 data;
> +	int err;
> +
> +	guard(mutex)(&hw->page_lock);
> +
> +	err = st_lsm6dsx_sf_set_page(hw, true);
> +	if (err < 0)
> +		return err;
> +
> +	settings = &hw->settings->sf_settings;
> +	if (enable) {
> +		u8 odr_val;
> +		const struct st_lsm6dsx_reg *reg = &settings->odr_table.reg;
> +
> +		st_lsm6dsx_sf_get_odr_val(settings, sensor->hwfifo_odr_mHz,
> +					  &odr_val);
> +		data = ST_LSM6DSX_SHIFT_VAL(odr_val, reg->mask);
> +		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 data);
> +		if (err < 0)
> +			goto out;
> +	}
> +	err = regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
> +				 settings->fifo_enable.mask, enable);
> +
> +out:
> +	st_lsm6dsx_sf_set_page(hw, false);

Whilst there isn't much we can do about it, might be worth the dance
to check return value of this (but not overwrite the original one if
we came here via an error.

Maybe simply duplicate the call
	return st_lsm6dsx_sf_set_page(hw, false);

out:
	st_lsm6dsx_sf_set_page(hw, false);

	return err;


> +
> +	return err;
> +}

> +
> +static int st_lsm6dsx_sf_write_raw(struct iio_dev *iio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int val, int val2, long mask)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	int err;
> +
> +	settings = &sensor->hw->settings->sf_settings;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		u32 odr_mHz;
> +		u8 odr_val;
> +
> +		odr_mHz = val * MILLI + val2 * MILLI / MICRO;
> +		err = st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);

Why are we getting something we don't use in here? I guess this is checking
what was asked for is supported. I'd add a comment to make that clear
as it's not that obvious (I got confused anyway!)

> +		if (err)
> +			return err;
> +
> +		sensor->hwfifo_odr_mHz = odr_mHz;
> +		return 0;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}


