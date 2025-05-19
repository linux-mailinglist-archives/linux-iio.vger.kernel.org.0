Return-Path: <linux-iio+bounces-19665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8846FABBC44
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 13:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199AF3B89A6
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE2274FCD;
	Mon, 19 May 2025 11:23:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832333FBB3;
	Mon, 19 May 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653804; cv=none; b=qIROPMjlV+Oc54ooPWoA9wVPlaygX9RlAdI+s7JafnpiWhg7fmQUVMCj2hfLmO3+zRWmo+iJ1lC+cE5f13YcE2zM0gHkkdFXD0ptUKguGWBhQ/SztLzvNUu/3ekK/b9UwlRuyesoHj4yJsge9rNQ654ylS/40M/2yjdCThtBJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653804; c=relaxed/simple;
	bh=LO4ZzpcLYiKL9qXnnzJToKDxOUeDAfuMKn7i3ncEilo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBA37XFVrup31p5/JakD1rzSQRETxdtmFrBYViWtr/zyM8puJdHQ+i8QOm6fBjpRznggzYm8B30qybPjd+gCnn+TaqD6eDb0bO1EN2iQV3GZX1aIdi97jwE4k3IFzqRgizCJZ+lkS0Jq+Jl7ImCE9jlbYZOnOcyFsIKEpfqUZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: QU5UROcuTK+8+DcSz2expw==
X-CSE-MsgGUID: HJnIgzuoQYKKHI+q3i6Oog==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="74950302"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="74950302"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:23:22 -0700
X-CSE-ConnectionGUID: dBynV8rxQzW/LHlpPV4Biw==
X-CSE-MsgGUID: Ega1bhtpTjOpFxqThKTyHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="176456786"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:23:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uGyaS-0000000314y-00MM;
	Mon, 19 May 2025 14:23:16 +0300
Date: Mon, 19 May 2025 14:23:15 +0300
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
Subject: Re: [PATCH v5 5/5] iio: adc: ad7606: add gain calibration support
Message-ID: <aCsUo9LOMGbse3KO@smile.fi.intel.com>
References: <20250519-wip-bl-ad7606-calibration-v5-0-4054fc7c9f3d@baylibre.com>
 <20250519-wip-bl-ad7606-calibration-v5-5-4054fc7c9f3d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519-wip-bl-ad7606-calibration-v5-5-4054fc7c9f3d@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 19, 2025 at 12:13:42PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
> 
> Usage example in the fdt yaml documentation.

...

> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 reg, r_gain;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			continue;
> +
> +		/* Chan reg is a 1-based index. */
> +		if (reg < 1 || reg > num_channels) {
> +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
> +			continue;
> +		}

Like I said, we should leave the validation to the schema or do it correctly here.
Otherwise it's an inconsistency between DT schema validator and this check.
I.o.w. this check *allows* the b0rken DT to be handled and I think this is simply
wrong.

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

Same here.

> +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> +		if (ret) {
> +			dev_warn(dev, "error writing r_gain");
> +			continue;

Not sure about this, though.

> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko



