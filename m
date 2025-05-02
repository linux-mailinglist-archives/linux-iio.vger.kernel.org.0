Return-Path: <linux-iio+bounces-18993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6915AA73F0
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A24B1B63E38
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4D2561CE;
	Fri,  2 May 2025 13:36:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA45255F2F;
	Fri,  2 May 2025 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192995; cv=none; b=sIZYMUg8l4RNallqxOfqB3wXGUT3CWSGTJ4UkSqZ2NPzOROtVOdEYqjWg1xRWhAQ/vl6X1xxOPm7+3LLf8c/ZDpyoC2ETSNNyY3UxnUV53HAVOylxIvO90WkTsbxwaf0YqdOPBkyy7HBnRLWP+8Ez7/iO5OX5OetSBHuTfZ40+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192995; c=relaxed/simple;
	bh=YkL5Sek6sKkNb5QPcwiGHgAOXcB7VAT2/hWfW0vv42c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS3BKuA243ghpfIvhwx8qseA+LBUdx0g0k9ATpRX/orfn8OmYXZh7i4E59fbtcE7TdgnFaUHCyAyRJHHbJiiSSXzf3Bsb5LKaurYiLgkvZr6gu0P044hEQEzk19/t3ZvmcgY7JAO/4PO4m4OEcW8LLKFI87TYKVOw7iV/qBmpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: LuQl2AJBRty9VMF7cKpb0A==
X-CSE-MsgGUID: qnNuzaWoS7G6GVcUAA/haQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010918"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010918"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 06:36:32 -0700
X-CSE-ConnectionGUID: iT+/KeGTTMmXK8SB/AUeuQ==
X-CSE-MsgGUID: co/n8w5QTjCuGHdPXo51sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165705967"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 06:36:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uAqZ1-00000002DAq-1LQ3;
	Fri, 02 May 2025 16:36:27 +0300
Date: Fri, 2 May 2025 16:36:27 +0300
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
Subject: Re: [PATCH v2 5/5] iio: adc: ad7606: add gain calibration support
Message-ID: <aBTKW538TX-jw977@smile.fi.intel.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-5-174bd0af081b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-5-174bd0af081b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 02, 2025 at 03:27:02PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
> 
> Usage example in the fdt yaml documentation.

...

> +	device_for_each_child_node_scoped(dev, child) {
> +		int reg, r_gain;

Both are defined in DT as unsigned. Are you able to use int as u32 in DT compiler?

> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return ret;
> +
> +		/* channel number (here) is from 1 to num_channels */
> +		if (reg < 1 || reg > num_channels) {
> +			dev_warn(dev, "invalid ch number (ignoring): %d\n", reg);
> +			continue;
> +		}
> +
> +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> +					       &r_gain);
> +		if (ret == -EINVAL)
> +			/* Keep the default register value. */
> +			continue;
> +		if (ret)
> +			return ret;

> +		if (r_gain < AD7606_CALIB_GAIN_MIN ||
> +		    r_gain > AD7606_CALIB_GAIN_MAX)

Seems like minimum check is not needed. See above why.

> +			return dev_err_probe(st->dev, -EINVAL,
> +					     "wrong gain calibration value.");
> +
> +		/* Chan reg is 1-based index. */
> +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> +					  r_gain / AD7606_CALIB_GAIN_STEP);

Wonder if we need DIV_ROUND_CLOSEST() instead...

> +		if (ret)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko



