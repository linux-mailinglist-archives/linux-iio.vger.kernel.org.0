Return-Path: <linux-iio+bounces-19338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2091AB034A
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C71C21C20
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73695288C97;
	Thu,  8 May 2025 19:00:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BCA286D66;
	Thu,  8 May 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730816; cv=none; b=EVslYzh81wvJQdu/cxMRSm9fi/NnBt6CSXqQK6kNAZgx7lCTsrPCOYuKb1MXUSjM3YApuHaSb/8u5TFaUBGeC3KLQTXJ5Pd0GavOXmuv06n9g/c5IjUy2Z5ZARYWy17yzJNi6S+WSyu/fwLoK3zZuJCzhkKfyp6tHKmkz9LKcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730816; c=relaxed/simple;
	bh=LCEbPff3OoPgMZ1212eZM05B+dddMMp2LVFvzweKsBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGQOk/iGNWbnCvFPZFCLc9QNgICvcynf1lPmxMla4CVg9fj0lvXZ7pwF9ah3JR/RlVT5slS0GASm24gjTXxI/nvmIRh4XOjzvtwIs+ylsO0UXHC1yA54bAFWBJQzYux5Fukd5HeXuYtQN3U7di/QOIEeBO91Q4L38dztRJSKazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 1P76WaSZSzakuq+yn2QCHg==
X-CSE-MsgGUID: pF0LCqTRQuC4ihGE+yKZQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48616475"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="48616475"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:00:13 -0700
X-CSE-ConnectionGUID: topa9xxbS4aY5lLo6/vMEA==
X-CSE-MsgGUID: 2bfKK5PUQJm8MK/FvnZZhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="141139512"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:00:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uD6TX-00000004Coa-02NT;
	Thu, 08 May 2025 22:00:07 +0300
Date: Thu, 8 May 2025 22:00:06 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: adc: ad7606: add gain calibration support
Message-ID: <aBz_Nlgx18UK2GIc@smile.fi.intel.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-5-91a3f2837e6b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-wip-bl-ad7606-calibration-v4-5-91a3f2837e6b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 08, 2025 at 12:06:09PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
> 
> Usage example in the fdt yaml documentation.

...

> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int num_channels = st->chip_info->num_adc_channels;
> +	struct device *dev = st->dev;
> +	int ret;
> +
> +	/*
> +	 * This function is called once, and parses all the channel nodes,
> +	 * so continuing on next channel node on errors, informing of them.
> +	 */
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 reg, r_gain;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			continue;

> +		/* Chan reg is a 1-based index. */
> +		if (reg < 1 || reg > num_channels) {
> +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
> +			continue;
> +		}

But this will allow to have a broken DT. This check basically diminishes the
effort of the DT schema validation. If there are limits one still would be able
to create a DT that passes the driver but doesn't pass the validation.

> +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> +					       &r_gain);
> +		if (ret)
> +			/* Keep the default register value. */
> +			continue;
> +
> +		if (r_gain > AD7606_CALIB_GAIN_MAX) {
> +			dev_warn(dev, "wrong gain calibration value");
> +			continue;
> +		}
> +
> +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> +		if (ret) {
> +			dev_warn(dev, "error writing r_gain");
> +			continue;
> +		}
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



