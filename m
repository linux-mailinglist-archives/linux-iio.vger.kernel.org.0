Return-Path: <linux-iio+bounces-15811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D566A3CB05
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 22:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518E03B4CA0
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 21:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA964253F08;
	Wed, 19 Feb 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxr0ytLL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A42566E4;
	Wed, 19 Feb 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999163; cv=none; b=BI4M/4pEomSQ5MxVpNOba60I1Uvs5YsIg3Hgj+yNkBZ0R70hsVz/dPa0fDgrRxmwI3YVx29YGVfCliF027JlKDgnPtIruGOSJl94JNRuWNUSJ0ShTYA9dsebIHNAuU2nkIZvCbDH0RA42gkvVInbl/YT3H4/0xRTSORIZCVJ9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999163; c=relaxed/simple;
	bh=vJJXb6273FpYyDVHDeZ/DSOZp5pyezaXoAVndtWcrPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbZp65S1sFNf9TYOEpZGSLew28yD5IvmLVrrJrcxNBNEO5TU6nS+gXQYvuRjId8SUeB7XbCBU5ekAflHl2ml4QsuL11uyC/aSpc/k5hNEF57V7Sv/Qwj3VQ3D4XRAu6Rin27GUmeij4bknc2k4rH+wdc3ORkQXGxFoTSvPgT7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxr0ytLL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739999161; x=1771535161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vJJXb6273FpYyDVHDeZ/DSOZp5pyezaXoAVndtWcrPc=;
  b=fxr0ytLLO7QhtSMN6P649n+0n7kOMFBPehvd+II4yh7gR2HB7ebZvZLb
   Ip3xYJ8iEnjYaun2dRnw4uc/va0RCGSYmV0enq1BfoloGt08RZmZ0nWyx
   EvNNTqyM9albrODsETIHOPblYUoyBY+g6t7R/+HT6IYtZEaTh7pyvCpVh
   vqgJRjHwn58z9jEL0VAwLyFUeJM65LR1sp4Tq7Iqq4E2KkKvYogQX5lsH
   x1NgghPTzY3A/ozP8Mrieo9Y7wnRAgtGUrxrJc/SMWyIzaaCLDP8sHEwW
   JpE0TAIJUy9wQ68ybenqax8yzoja4xM+82om7W1vtklS90zQUOnkfFOqv
   A==;
X-CSE-ConnectionGUID: H8wotGlZTuC7Ls3hU/j6lA==
X-CSE-MsgGUID: a+5zDJUNT+KNnXs6Lo+jFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58300744"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58300744"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:06:00 -0800
X-CSE-ConnectionGUID: JxVBcCOcTNuWZV16Khlvlw==
X-CSE-MsgGUID: SniAxXf2Qd+v4RXsDoeXCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114577344"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:41:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tkqsg-0000000D7u9-160Q;
	Wed, 19 Feb 2025 22:41:18 +0200
Date: Wed, 19 Feb 2025 22:41:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 2/9] iio: adc: add helpers for parsing ADC nodes
Message-ID: <Z7ZB7RQhyI5Dohrq@smile.fi.intel.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 19, 2025 at 02:30:27PM +0200, Matti Vaittinen wrote:
> There are ADC ICs which may have some of the AIN pins usable for other
> functions. These ICs may have some of the AIN pins wired so that they
> should not be used for ADC.
> 
> (Preferred?) way for marking pins which can be used as ADC inputs is to
> add corresponding channels@N nodes in the device tree as described in
> the ADC binding yaml.
> 
> Add couple of helper functions which can be used to retrieve the channel
> information from the device node.

...

>  - Rename iio_adc_device_get_channels() as

as?

...

> obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>  obj-$(CONFIG_GEHC_PMC_ADC) += gehc-pmc-adc.o
>  obj-$(CONFIG_HI8435) += hi8435.o
>  obj-$(CONFIG_HX711) += hx711.o

> +obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o

Shouldn't this be grouped with other IIO core related objects?

>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
>  obj-$(CONFIG_IMX93_ADC) += imx93_adc.o

...


+ bitops.h

> +#include <linux/device.h>
> +#include <linux/errno.h>

+ export.h

+ module.h

> +#include <linux/property.h>

+ types.h

...

> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);

No namespace?

...

> +	if (!allowed_types || allowed_types & (~IIO_ADC_CHAN_PROP_TYPE_ALL)) {

Unneeded parentheses around negated value.

> +		dev_dbg(dev, "Invalid adc allowed prop types 0x%lx\n",
> +			allowed_types);
> +
> +		return -EINVAL;
> +	}
> +	if (found_types & (~allowed_types)) {

Ditto.

> +		long unknown_types = found_types & (~allowed_types);

Ditto and so on...

Where did you get this style from? I think I see it first time in your
contributions. Is it a new preferences? Why?

> +		int type;
> +
> +		for_each_set_bit(type, &unknown_types,
> +				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
> +			dev_err(dev, "Unsupported channel property %s\n",
> +				iio_adc_type2prop(type));
> +		}
> +
> +		return -EINVAL;
> +	}

...

> +int iio_adc_device_channels_by_property(struct device *dev, int *channels,
> +		int max_channels, const struct iio_adc_props *expected_props)
> +{
> +	int num_chan = 0, ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 ch, diff[2], se;
> +		struct iio_adc_props tmp;
> +		int chtypes_found = 0;
> +
> +		if (!fwnode_name_eq(child, "channel"))
> +			continue;
> +
> +		if (num_chan == max_channels)
> +			return -EINVAL;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return ret;
> +
> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     &diff[0], 2);

						     diff, ARRAY_SIZE(diff));

(will require array_size.h)


> +		if (!ret)
> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_DIFF;
> +
> +		ret = fwnode_property_read_u32(child, "single-channel", &se);
> +		if (!ret)
> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED;
> +
> +		tmp = *expected_props;
> +		/*
> +		 * We don't bother reading the "common-mode-channel" here as it
> +		 * doesn't really affect on the primary channel ID. We remove
> +		 * it from the required properties to allow the sanity check
> +		 * pass here  also for drivers which require it.
> +		 */
> +		tmp.required &= (~BIT(IIO_ADC_CHAN_PROP_COMMON));

Redundant outer parentheses. What's the point, please?

> +		ret = iio_adc_prop_type_check_sanity(dev, &tmp, chtypes_found);
> +		if (ret)
> +			return ret;
> +
> +		if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_DIFF)
> +			ch = diff[0];
> +		else if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED)
> +			ch = se;
> +
> +		/*
> +		 * We assume the channel IDs start from 0. If it seems this is
> +		 * not a sane assumption, then we can relax this check or add
> +		 * 'allowed ID range' parameter.
> +		 *
> +		 * Let's just start with this simple assumption.
> +		 */
> +		if (ch >= max_channels)
> +			return -ERANGE;
> +
> +		channels[num_chan] = ch;
> +		num_chan++;
> +	}
> +
> +	return num_chan;
> +
> +}

...

> +int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
> +				const struct iio_chan_spec *template,
> +				struct iio_chan_spec **cs,
> +				const struct iio_adc_props *expected_props)
> +{
> +	struct iio_chan_spec *chan;
> +	int num_chan = 0, ret;
> +
> +	num_chan = iio_adc_device_num_channels(dev);
> +	if (num_chan < 1)
> +		return num_chan;
> +
> +	*cs = devm_kcalloc(dev, num_chan, sizeof(**cs), GFP_KERNEL);
> +	if (!*cs)
> +		return -ENOMEM;
> +
> +	chan = &(*cs)[0];

This and above and below will be easier to read if you introduce a temporary
variable which will be used locally and assigned to the output later on.
Also the current approach breaks the rule that infiltrates the output even in
the error cases.

> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 ch, diff[2], se, common;
> +		int chtypes_found = 0;
> +
> +		if (!fwnode_name_eq(child, "channel"))
> +			continue;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return ret;
> +
> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     &diff[0], 2);

As per above.

> +		if (!ret)
> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_DIFF;
> +
> +		ret = fwnode_property_read_u32(child, "single-channel", &se);
> +		if (!ret)
> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED;

> +		ret = fwnode_property_read_u32(child, "common-mode-channel",
> +					       &common);

I believe this is okay to have on a single line,

> +		if (!ret)
> +			chtypes_found |= BIT(IIO_ADC_CHAN_PROP_COMMON);
> +
> +		ret = iio_adc_prop_type_check_sanity(dev, expected_props,
> +						     chtypes_found);
> +		if (ret)
> +			return ret;
> +
> +		*chan = *template;
> +		chan->channel = ch;
> +
> +		if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_DIFF) {
> +			chan->differential = 1;
> +			chan->channel = diff[0];
> +			chan->channel2 = diff[1];
> +
> +		} else if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED) {
> +			chan->channel = se;
> +			if (chtypes_found & BIT(IIO_ADC_CHAN_PROP_COMMON))
> +				chan->channel2 = common;
> +		}
> +
> +		/*
> +		 * We assume the channel IDs start from 0. If it seems this is
> +		 * not a sane assumption, then we have to add 'allowed ID ranges'
> +		 * to the struct iio_adc_props because some of the callers may
> +		 * rely on the IDs being in this range - and have arrays indexed
> +		 * by the ID.
> +		 */
> +		if (chan->channel >= num_chan)
> +			return -ERANGE;
> +
> +		chan++;
> +	}
> +
> +	return num_chan;
> +}

...

> +#ifndef _INDUSTRIAL_IO_ADC_HELPERS_H_
> +#define _INDUSTRIAL_IO_ADC_HELPERS_H_

+ bits.h

> +#include <linux/iio/iio.h>

I'm failing to see how this is being used in this header.

> +struct device;
> +struct fwnode_handle;
> +
> +enum {
> +	IIO_ADC_CHAN_PROP_REG,
> +	IIO_ADC_CHAN_PROP_SINGLE_ENDED,
> +	IIO_ADC_CHAN_PROP_DIFF,
> +	IIO_ADC_CHAN_PROP_COMMON,
> +	IIO_ADC_CHAN_NUM_PROP_TYPES
> +};
> +
> +/*
> + * Channel property types to be used with iio_adc_device_get_channels,
> + * devm_iio_adc_device_alloc_chaninfo, ...

Looks like unfinished sentence...

> + */
> +#define IIO_ADC_CHAN_PROP_TYPE_REG BIT(IIO_ADC_CHAN_PROP_REG)
> +#define IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED BIT(IIO_ADC_CHAN_PROP_SINGLE_ENDED)
> +#define IIO_ADC_CHAN_PROP_TYPE_SINGLE_COMMON					\
> +	(BIT(IIO_ADC_CHAN_PROP_SINGLE_ENDED) | BIT(IIO_ADC_CHAN_PROP_COMMON))
> +#define IIO_ADC_CHAN_PROP_TYPE_DIFF BIT(IIO_ADC_CHAN_PROP_DIFF)
> +#define IIO_ADC_CHAN_PROP_TYPE_ALL GENMASK(IIO_ADC_CHAN_NUM_PROP_TYPES - 1, 0)

> +int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
> +				const struct iio_chan_spec *template,
> +				struct iio_chan_spec **cs,
> +				const struct iio_adc_props *expected_props);
> +
> +int iio_adc_device_channels_by_property(struct device *dev, int *channels,
> +				int max_channels,
> +				const struct iio_adc_props *expected_props);
> +#endif /* _INDUSTRIAL_IO_ADC_HELPERS_H_ */


-- 
With Best Regards,
Andy Shevchenko



