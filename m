Return-Path: <linux-iio+bounces-19668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613D2ABBD6C
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2003BC3B3
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093227586A;
	Mon, 19 May 2025 12:15:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BF275846;
	Mon, 19 May 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656926; cv=none; b=qWOwPT3+qoDKjKLGvtIMJq41GI2lG0r1Z+/NJCpZFMmvRLe4KMWR2Xk0gucGgvoYlT6hreEtzD04kaubSxFesBCkXlcr65/DTWdZNPuOuIxD2jLzEYJkiXCmwVk5hx6EbjoriCWSdtJoVLru9nSRABM+Prb1ShkMb6yfnfqfu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656926; c=relaxed/simple;
	bh=tNM305ttJ97N5szcmiZosc3SsEJonoEDwtoWV06EsW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHuXg8ngJf2Nr5dqxRMocyAkslwGhunusufh8+YccQ4u5BAah71Fuo59FGB+kWREaHJE2ZoLZVkainO7/A0hNqU+J/+XRxZg5Ks8/USZxB8ZxPUB2l1Xx+CxsBR1rwVxLQB1cE9qXTOo3eLc3jyIP1SvRVBYzmx8IBK9od78tmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: zEjjuuF2SXOZ8c9yvnFH7A==
X-CSE-MsgGUID: NVY0tqKNQz2VJXX634cAyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49657670"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49657670"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:15:23 -0700
X-CSE-ConnectionGUID: g1C1h59sRKa7mLT+S9tB+w==
X-CSE-MsgGUID: /yvKf85WRYizI3FayBA+YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139395929"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:15:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uGzOn-000000031pb-3X9A;
	Mon, 19 May 2025 15:15:17 +0300
Date: Mon, 19 May 2025 15:15:17 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/12] iio: accel: adxl313: add activity sensing
Message-ID: <aCsg1XddkT6sGjev@smile.fi.intel.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
 <20250518111321.75226-10-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518111321.75226-10-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 18, 2025 at 11:13:18AM +0000, Lothar Rubusch wrote:
> Add possibilities to set a threshold for activity sensing. Extend the
> interrupt handler to process activity interrupts. Provide functions to set
> the activity threshold and to enable/disable activity sensing. Further add
> a fake channel for having x, y and z axis anded on the iio channel.
> 
> This is a preparatory patch. Some of the definitions and functions are
> supposed to be extended for inactivity later on.

...

> +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> +				   enum adxl313_activity_type type,
> +				   bool *en)
> +{
> +	unsigned int axis_ctrl;
> +	unsigned int regval;
> +	int ret;

> +	*en = false;

Even in case of an error? The rule of thumb is to avoid assigning output when
we know that the error will be returned to the caller.

> +	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
> +	if (ret)
> +		return ret;

> +	if (type == ADXL313_ACTIVITY)
> +		*en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> +
> +	if (*en) {

This doesn't need to re-write the value of *en. Just declare local boolean
temporary variable and use it and only assign it on success.

> +		ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
> +		if (ret)
> +			return ret;
> +
> +		*en = adxl313_act_int_reg[type] & regval;
> +	}
> +
> +	return 0;
> +}

...

> +static int adxl313_set_act_inact_en(struct adxl313_data *data,
> +				    enum adxl313_activity_type type,
> +				    bool cmd_en)
> +{
> +	unsigned int axis_ctrl = 0;
> +	unsigned int threshold;
> +	bool en;
> +	int ret;
> +
> +	if (type == ADXL313_ACTIVITY)
> +		axis_ctrl = ADXL313_ACT_XYZ_EN;
> +
> +	ret = regmap_update_bits(data->regmap,
> +				 ADXL313_REG_ACT_INACT_CTL,
> +				 axis_ctrl,
> +				 cmd_en ? 0xff : 0x00);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type], &threshold);
> +	if (ret)
> +		return ret;

> +	en = false;

Instead...

> +	if (type == ADXL313_ACTIVITY)
> +		en = cmd_en && threshold;

	else
		en = false;

> +	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> +				  adxl313_act_int_reg[type],
> +				  en ? adxl313_act_int_reg[type] : 0);
> +}

...

> +static int adxl313_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);

> +	bool int_en;

Why? You return the int here... I would expect rather to see unsigned int...

> +	int ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = adxl313_is_act_inact_en(data,
> +						      ADXL313_ACTIVITY,
> +						      &int_en);
> +			if (ret)
> +				return ret;
> +			return int_en;

...or even simply

			return adx1313...(...);

> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int adxl313_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	unsigned int act_threshold;
> +	int ret;
> +
> +	/* measurement stays enabled, reading from regmap cache */
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				ret = regmap_read(data->regmap,
> +						  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
> +						  &act_threshold);
> +				if (ret)
> +					return ret;
> +				*val = act_threshold * 15625;

> +				*val2 = 1000000;

MICRO?

> +				return IIO_VAL_FRACTIONAL;
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl313_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = adxl313_set_measure_en(data, false);
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:

This can be collapsed to the conditional, making indentation better overall.
Same applies to the other parts of the code outside of this function.

> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			/* The scale factor is 15.625 mg/LSB */
> +			regval = DIV_ROUND_CLOSEST(1000000 * val + val2, 15625);

MICRO?

> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				ret = regmap_write(data->regmap,
> +						   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
> +						   regval);
> +				if (ret)
> +					return ret;
> +				return adxl313_set_measure_en(data, true);
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +		ret = regmap_write(data->regmap, ADXL313_REG_ACT_INACT_CTL, 0);

0x00 ?

> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
> +		if (ret)
> +			return ret;

-- 
With Best Regards,
Andy Shevchenko



