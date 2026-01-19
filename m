Return-Path: <linux-iio+bounces-27951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EFED3A51B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0748F300529E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C82D9492;
	Mon, 19 Jan 2026 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcHwoIYP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651FC2D5935;
	Mon, 19 Jan 2026 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818810; cv=none; b=RtHL+d4Wjthkj1svFg4dVDvvOa12af6MGzJEt6qlW0UB2TDqAlY+Bj59IwMynrDMk5nDbP80mb6AnpCg048ofwNHi+eDYmiLL27DIyzmzD03Xy3eKD7Tp60zc/6rV4a2iIv5eiuRuxd/lH9GE0J5QTHoCg5qnJQinZb0EqM9sLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818810; c=relaxed/simple;
	bh=+s2uctthhEOYLWXOLJxsh9v1LHD08GUD5mdqXVW7+sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzQtjbBxBaoPBuiR7GgaQG/9cBTPWtVIi9qJnXqnQPwP/F0b0GVnZiXt9WL4cz1EZWwOJ2Qkvzy3wQjaH/onWx0qQtS5MY3rtAem/wpRbc/4fPH6voRSk00uIT0CHpLyf6Hfa5Fm8ngGAbeERQSrp0kC2QaBJjh2gZnrWSIIgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcHwoIYP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768818809; x=1800354809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+s2uctthhEOYLWXOLJxsh9v1LHD08GUD5mdqXVW7+sw=;
  b=IcHwoIYPbn4oWtwRNZHU4lwMMlKrxCJkGVmnqQIvb4URdmWQ4cnjybZv
   pSsHeWA0DwuvFI8nVt6HVHbfXXYHm2rcE42NLAE7gzt1Pe0dmQ8ZIR//n
   YWjrbk3dQRkSb9ESbVS0xqwGDNmx0yVdcvnUOZpeehrVQ1gKECusreoim
   v0+hDo1uMh+AaZjpWRNYf5OVIXK8AhtO12fTtWwqqNbmI8CIeHG152hqZ
   eB8onmOQBmkEAWDUVQ85oPKUXmG0YY6ZQoBkFNi0SeTKx9jCwxHEFAsEM
   KJjxMo7pmqNsrr9q3dKVharqHfLQp2xV8wH+hfYUoXtF3HgPottKp+2yR
   Q==;
X-CSE-ConnectionGUID: VSI6xEODRK6uSuEuHd2wEg==
X-CSE-MsgGUID: ZFyPytvMSGOfefrbQVIQDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="87610010"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="87610010"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 02:33:28 -0800
X-CSE-ConnectionGUID: orMWnJN3Rr+qoPggVGW4FA==
X-CSE-MsgGUID: e7IZM9XOQCqVr0FLukHJNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205625968"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 02:33:25 -0800
Date: Mon, 19 Jan 2026 12:33:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
Message-ID: <aW4Ic5bUId3MG4em@smile.fi.intel.com>
References: <20260119100449.1559624-1-flavra@baylibre.com>
 <20260119100449.1559624-4-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119100449.1559624-4-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 11:04:49AM +0100, Francesco Lavra wrote:
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

...

> st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,

>  	case ST_LSM6DSX_EXT2_TAG:
>  		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
>  		break;
> +	case ST_LSM6DSX_ROT_TAG:
> +		/*
> +		 * The sensor reports only the {X, Y, Z} elements of the
> +		 * quaternion vector; set the W value to 0 (it can be derived
> +		 * from the {X, Y, Z} values due to the property that the vector
> +		 * is normalized).
> +		 */
> +		*(u16 *)(data + ST_LSM6DSX_SAMPLE_SIZE) = 0;

This looks confusing taking into account

	s16 val = le16_to_cpu(*(__le16 *)data);

(which actually should use le16_to_cpup() instead of the direct conversion).

> +		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_SF];
> +		break;
>  	default:
>  		return -EINVAL;
>  	}

...

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

Do you need ' < 0' here? Why isn't it required at the end of the function?

> +		return err;
> +
> +	err = regmap_assign_bits(hw->regmap, en_reg->addr, en_reg->mask, enable);
> +	if (err < 0) {

' < 0' is not needed.

> +		st_lsm6dsx_sf_set_page(hw, false);
> +		return err;
> +	}
> +
> +	return st_lsm6dsx_sf_set_page(hw, false);
> +}

And IIRC I replied that these _sf_set_page() seems to be used only with
the explicit boolean value, which means a good hint that it needs to be
split just to two functions doing for true and false. It will increase
the readability of the code in both places (in the caller and callee).

...

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

Can we use reversed xmas tree ordering?

> +		st_lsm6dsx_sf_get_odr_val(settings, sensor->hwfifo_odr_mHz,
> +					  &odr_val);
> +		data = ST_LSM6DSX_SHIFT_VAL(odr_val, reg->mask);
> +		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 data);
> +		if (err < 0)
> +			goto out;
> +	}
> +
> +	err = regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
> +				 settings->fifo_enable.mask, enable);
> +	if (err < 0)
> +		goto out;
> +
> +	return st_lsm6dsx_sf_set_page(hw, false);
> +
> +out:
> +	st_lsm6dsx_sf_set_page(hw, false);
> +
> +	return err;
> +}

...

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
> +		u32 odr_mHz = val * MILLI + val2 * MILLI / MICRO;

Probably "(MILLI / MICRO)" (with parentheses) to avoid potential overflows,

> +		u8 odr_val;
> +
> +		/* check that the requested frequency is supported */
> +		err = st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
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

...

> +	snprintf(sensor->name, sizeof(sensor->name), "%s_sf", name);

Does GCC complain on this (`make W=1` build)?
Since this can cut the string and we don't check the return value, the Q is:
is this okay to have a reduced string?

-- 
With Best Regards,
Andy Shevchenko



