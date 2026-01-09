Return-Path: <linux-iio+bounces-27586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F408D0C0E3
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 20:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 417B43017390
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 19:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4927FD48;
	Fri,  9 Jan 2026 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBYpX9aM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E41F4C8E;
	Fri,  9 Jan 2026 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986535; cv=none; b=vGXxOVhng48jkKoBjBiMGmQScdIng+bFSGP7gaSTxnc1ITMDlnpCnom5/KIj69/2V9KsQHBASflQYidNhNiMpMK3SM5Ox15c2qDr5bDgIpkSxjL9unX2vFD+3T89yAp5GzTp8870YJLoRfeaVzBVT0hRt1E5tcXlkkwZmEAaw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986535; c=relaxed/simple;
	bh=DZAhLbgB/7OtIpIjsxzt/3pZ6GUrMAtfR6ag2Z3LrnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGgne30ZwGwQAwc4oqglEka7sJWRYtYD51At226JDq1zG+/wGePoWiyhxVgfsip60rzejDA8UlGOtQTYmrq0PdXS8o0jQ/yZiZ1zAuearM/KcDVJdVIS2nitV4eI/G90sFGSY+Nzk4Ud5q0q4IqBWhBLql8PQ6Ns6dfDYDhEaLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBYpX9aM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767986534; x=1799522534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZAhLbgB/7OtIpIjsxzt/3pZ6GUrMAtfR6ag2Z3LrnI=;
  b=cBYpX9aMsEKg5ItibyGxi4vn1VT81tfLMxtp1cf5Jee7U3zSeO4HLKc8
   nMHeXtoYGSukGpgFo2JTtveZ+U9qJAMEfMOCZzhcfJzeayvppXcUhmda3
   82FkwEqCBBjB5ectIa0LP0SjjIswNDDR1d0hYwtfuL5vfOO1x0Uu0Zu4d
   iLFwyzph9klu8c6Gl6ni4kzTnPC/OudqXX7xfHFxx38/Rfzk7b9M2JwGS
   zuv0eOX/G3Ia6zN4VL8nRwo3e1a106Fzbdtzpw/dcFnrdh5wUJTpg4f07
   CueymnmOX6mOdNJK8OU53UNctVsyhHbXsVTqPUSwxceFP9tycQE6imH+o
   w==;
X-CSE-ConnectionGUID: F3Buv0sATm2QaY2MTeI5cQ==
X-CSE-MsgGUID: XPGaHJ1PStWNsvE5n7K0Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69355566"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69355566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 11:22:14 -0800
X-CSE-ConnectionGUID: hQQ0aYugRJGeXGKNVNVbXA==
X-CSE-MsgGUID: VwFaQdJdTHeEwS8PnXhw/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="208374589"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 11:22:11 -0800
Date: Fri, 9 Jan 2026 21:22:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: add support for rotation sensor
Message-ID: <aWFVYefhhVn27vku@smile.fi.intel.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
 <20260109181528.154127-4-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109181528.154127-4-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 09, 2026 at 07:15:28PM +0100, Francesco Lavra wrote:
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
> 
> Tested on LSMDSV16X.

...

> enum st_lsm6dsx_sensor_id {

>  	ST_LSM6DSX_ID_EXT0,
>  	ST_LSM6DSX_ID_EXT1,
>  	ST_LSM6DSX_ID_EXT2,
> +	ST_LSM6DSX_ID_SF,
>  	ST_LSM6DSX_ID_MAX,

At some point please either get rid of _ID_MAX, or drop the trailing comma
(maybe some other places also need the same treatment).

...

> +static int st_lsm6dsx_sf_set_page(struct st_lsm6dsx_hw *hw, bool enable)
> +{
> +	const struct st_lsm6dsx_reg *mux;
> +	int err;
> +
> +	mux = &hw->settings->sf_settings.page_mux;
> +	if (enable)
> +		mutex_lock(&hw->page_lock);
> +	err = regmap_assign_bits(hw->regmap, mux->addr, mux->mask, enable);
> +	if (!enable || err < 0)
> +		mutex_unlock(&hw->page_lock);
> +
> +	return err;
> +}

Why not having properly made functions with the respective sparse annotations?
And drop this "enable" parameter.

...

> +int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_reg *enable_reg;
> +	int err;
> +
> +	enable_reg = &hw->settings->sf_settings.enable;
> +	err = st_lsm6dsx_sf_set_page(hw, true);
> +	if (err < 0)
> +		return err;
> +
> +	err = regmap_assign_bits(hw->regmap, enable_reg->addr, enable_reg->mask,
> +				 enable);

One line? The variable name can be shortened as well.

> +	st_lsm6dsx_sf_set_page(hw, false);
> +
> +	return err;
> +}

...

> +static int st_lsm6dsx_sf_read_raw(struct iio_dev *iio_dev,
> +				  struct iio_chan_spec const *ch,
> +				  int *val, int *val2, long mask)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = sensor->hwfifo_odr_mHz / MILLI;
> +		*val2 = (sensor->hwfifo_odr_mHz % MILLI) * MILLI;

Strictly speaking the multiplier in the second one should be "(MICRO / MILLI)".

> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
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
> +		u32 odr_mHz;
> +		u8 odr_val;
> +
> +		odr_mHz = val * MILLI + val2 / MILLI;


Ditto.

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

> +	return 0;

Perhaps move it to the only case that needs it?

> +}

...

> +static ssize_t st_lsm6dsx_sf_sampling_freq_avail(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	int i, len = 0;
> +
> +	settings = &sensor->hw->settings->sf_settings;
> +	for (i = 0; i < settings->odr_table.odr_len; i++) {

	for (unsigned int i ...) {

> +		u32 val = settings->odr_table.odr_avl[i].milli_hz;
> +
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%lu.%03lu ",
> +				 val / MILLI, val % MILLI);

Hmm... I think this has to be sysfs_emit_at().

> +	}
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}

...

> +static struct attribute *st_lsm6dsx_sf_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,

> +	NULL,

No comma here.

> +};


...

> +int st_lsm6dsx_sf_probe(struct st_lsm6dsx_hw *hw, const char *name)
> +{
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	struct st_lsm6dsx_sensor *sensor;
> +	struct iio_dev *iio_dev;
> +
> +	iio_dev = devm_iio_device_alloc(hw->dev, sizeof(*sensor));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	settings = &hw->settings->sf_settings;
> +	sensor = iio_priv(iio_dev);
> +	sensor->id = ST_LSM6DSX_ID_SF;
> +	sensor->hw = hw;
> +	sensor->hwfifo_odr_mHz = settings->odr_table.odr_avl[0].milli_hz;
> +	sensor->watermark = 1;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->info = &st_lsm6dsx_sf_info;
> +	iio_dev->channels = settings->chan;
> +	iio_dev->num_channels = settings->chan_len;

> +	scnprintf(sensor->name, sizeof(sensor->name), "%s_sf", name);

What's the point of "c" here, please?

> +	iio_dev->name = sensor->name;
> +
> +	/**

Huh?!

> +	 *  Put the IIO device pointer in the iio_devs array so that the caller
> +	 *  can set up a buffer and register this IIO device.
> +	 */
> +	hw->iio_devs[ST_LSM6DSX_ID_SF] = iio_dev;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



