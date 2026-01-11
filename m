Return-Path: <linux-iio+bounces-27624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CE8D0F770
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 17:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DDFF3019489
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05381F8AC5;
	Sun, 11 Jan 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQIU3cZS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4169330311;
	Sun, 11 Jan 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768150021; cv=none; b=TgOr+924nu5hmVAKA4M6fQEdMTDLuv74dFrMp/OuapQTVo7UScLdMQ1zvuxOPVCmTnf4Z9e140A6duAHz3s36jG3oSYUUx4aslXgfTYEDMTwyQ8Yr3h/DloHx1duRctX1Srm31Z20Q5kUI9fg/iUP2RJY4diPmQhUR9biVLUjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768150021; c=relaxed/simple;
	bh=0ae9tNM8ESH78nsWWpCdzxGiqjWqd6dQSsnI4lkRPjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWgSm2IQJRv9G84xvja0H9kRYGQBXUqQ1FMiA8Oi8vPCYcunKMXGEiwN2kXYsmDtibs0OSAZYbbF2yTTECAdZW6lcBH5Di6Meb1bM10Rn5w539pGVaeOyLx+7l8OATSRPiXgYTVByB1AYVCPR4kW+4V4wYtXIHmBrSjRW6atNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQIU3cZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB63C116C6;
	Sun, 11 Jan 2026 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768150021;
	bh=0ae9tNM8ESH78nsWWpCdzxGiqjWqd6dQSsnI4lkRPjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQIU3cZSqC4JNkZWu41yCxy6ZPGdhxQ+55OVgi8W0ufQLYlSdygfi2LwdPO0ALNvI
	 wNYibCJW5/+1MjFDAOD8G9Lw3cwfxgpgDsZBPMY3yBg73fUI3PHbTyzLEFTHqX12y5
	 rv9+ROFcB+HBBgOKevaArP5lJfrxvCfHXO5HWy0W7HeOpdbDHZtBBIDU+wNBPokfmc
	 nVUH0qrCNKsYEaGAz89poLpVAqVRY9W2QliC3hVniXNVmw1jj3rZixYdPSMTmpttQA
	 Ez1jwzwZH+0BfLonWFvyt7kJLUcETRfXIk2pdJ6L5pO6j5H9WElbWXgwsGy4wzgk+Q
	 XNkgDz6yOBldw==
Date: Sun, 11 Jan 2026 16:46:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
Message-ID: <20260111164651.56a0cf14@jic23-huawei>
In-Reply-To: <20260109181528.154127-4-flavra@baylibre.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
	<20260109181528.154127-4-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Jan 2026 19:15:28 +0100
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
> an existing device) because each of the existing devices handles data
> coming from a single sensor, while sensor fusion data comes from multiple
> sensors.
That doesn't really justify the extra IIO device.  We used to do this
because the IIO buffers aren't tagged with channel info
(unlike say driver/input) and so if the data for different channels
/sub parts of the sensor can come out at different rates, we have to
split them up.  So real question here is what data rate is this generated
at?  If it matches an existing sensor we should add the channel there,
if not fine to have yet another IIO device. All this changes is
the explanation in this patch description. Code is fine.

Note as an FYI, we now support multiple buffers per IIO device. I think
there are probably still some corners that need ironing out, but in theory
that was to handle this sort of sensor in a single IIO device.

> 
> Tested on LSMDSV16X.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>


> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> new file mode 100644
> index 000000000000..7c78f14cbb91
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics st_lsm6dsx IMU sensor fusion
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/sprintf.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include "st_lsm6dsx.h"

> +/**
> + * st_lsm6dsx_sf_set_page - Enable or disable access to sensor fusion
> + * configuration registers.
> + * @hw: Sensor hardware instance.
> + * @enable: True to enable access, false to disable access.
> + *
> + * The register page lock is acquired when enabling access, and released when
> + * disabling access. Therefore, a function call with @enable set to true must be
> + * followed by a call with @enable set to false (unless the first call returns
> + * an error value).
> + *
> + * Return: 0 on success, negative value on error.
> + */
> +static int st_lsm6dsx_sf_set_page(struct st_lsm6dsx_hw *hw, bool enable)
> +{

I'm curious what sparse thinks of this.  Try a make C=1 build.
I'd expect it to be fussy that it can't figure out the acquires and releases.
Maybe it can see enough to figure it out.  If not you might need to break
it into two functions so you can add the markings __acquires() etc

Personally I think I'd just take the page lock out of here and use guard() in the
callers.


> +	const struct st_lsm6dsx_reg *mux;
> +	int err;
> +
> +	mux = &hw->settings->sf_settings.page_mux;

Just to check, can you use regmaps support for paging instead of doing this by hand?
That would avoid future problems with enabling caching or similar


> +	if (enable)
> +		mutex_lock(&hw->page_lock);
> +	err = regmap_assign_bits(hw->regmap, mux->addr, mux->mask, enable);
> +	if (!enable || err < 0)
> +		mutex_unlock(&hw->page_lock);
> +
> +	return err;
> +}
> +

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
> +		odr_mHz = val * MILLI + val2 / MILLI;
> +		err = st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
> +		if (err)
> +			return err;
> +
> +		sensor->hwfifo_odr_mHz = odr_mHz;
> +		break;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
Might as well return instead of break above and save a couple of lines + avoid
anyone having to go see what happens after the switch statement.

> +}

> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sf_sampling_freq_avail);
> +static struct attribute *st_lsm6dsx_sf_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,

No comma as nothing should come after this.  Ideally would be replaced with
code using the read_avail callback and appropriate bit set in the
info mask avail bitmaps.


> +};

Thanks

Jonathan

