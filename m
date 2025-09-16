Return-Path: <linux-iio+bounces-24157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F012B59756
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022191BC6A3D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B1E2D4807;
	Tue, 16 Sep 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIdygYf6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C321CA0D;
	Tue, 16 Sep 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028765; cv=none; b=iDY/RvmhZIqKv95rMvELdiLt/je4aPxqNcAHZQZw022FoMm5Udja2MuaE30jHlYE6W+OcqUKlopWG7H4KTQsTkX12Vjy6Z6/CJJfbUKZLS5PUimcvL7aMT9s5a1hVlkPr2CKCxKwhYTeKnSNHNC/5uqSAkSzBf0JojWJ3D9drtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028765; c=relaxed/simple;
	bh=swAmRyPgI9YuMQ+XtIYDsJM9z8XrO81CMDQ/sQeaOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbp+SFgzeMde8CRtfCI5u+1LQb4tUKtvOEnbH/2sp/JveX2/hA7v1PpdpgEKofXyHV+qoL8lf9it5ptTFYvjswEOTKmmmxSXQ5rEbXQi3yEMYamviHlZcpKphXCZqQHQEbuh6k2jZyJwlFiZ6lsddr44fmK1UiAHImRNUHik8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIdygYf6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758028764; x=1789564764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=swAmRyPgI9YuMQ+XtIYDsJM9z8XrO81CMDQ/sQeaOnM=;
  b=CIdygYf61iiwfZTemSkG0lhq1iZXUBwLorpPNJr+Gbu4h8i8oaw+5USs
   sL9awe4A6TGy1MzcpCiFGnNFyk0ss9hKU/R1xfbGkbEtMW2wvWTvnV9Qq
   rx42YBF8+6vL0zQpd6/bUhi22gH1wVvKjE0h4anLoi1NHzRSYbuqkzPhP
   Dg+Lepi95CQARYEMOg6zhnxQWk7CN36iknA1HdleIBBnSjUAlXnLiyzMO
   lPtZW93XK7wRXHRA2sxcGTbndG2t/rFBcX2hC30CEzBpaOgeo3i7x+Vpt
   ehj4zdVZJemm4DEu7ppog9+Me0pYX2J4DDqYFDVgm1QeXPjH8tUc0GGkx
   w==;
X-CSE-ConnectionGUID: Cas7J+ZFSQ6JuOlTxpg+bA==
X-CSE-MsgGUID: RxRbDKQVTS6uasvPC2mS/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60176310"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60176310"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:19:23 -0700
X-CSE-ConnectionGUID: VE4/7CRCTP6XyoIlCANxaA==
X-CSE-MsgGUID: qwSxdJc8SZinMZtzgD2/+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="205722716"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:19:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uyVaW-00000003XBG-4AZF;
	Tue, 16 Sep 2025 16:19:16 +0300
Date: Tue, 16 Sep 2025 16:19:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] regulator: ltm8054: Support output current limit
 control
Message-ID: <aMlj1OcfH8r9Zz6x@smile.fi.intel.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-4-fd4e781d33b9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ltm8054-driver-v1-4-fd4e781d33b9@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 12:24:09PM +0200, Romain Gantois wrote:
> The LTM8054 supports setting a fixed output current limit using a sense
> resistor connected to a dedicated pin. This limit can then be lowered
> dynamically by varying the voltage level of the CTL pin.
> 
> Support controlling the LTM8054's output current limit.

...

> in microvolts

Yeah, using _mV postfix will make it visible that those are in micro-Volts.

...

> +static int ltm8054_set_current_limit(struct regulator_dev *rdev, int min_uA, int max_uA)
> +{
> +	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
> +	u64 vdac_uV;
> +
> +	min_uA = clamp_t(int, min_uA, priv->min_uA, priv->max_uA);
> +
> +	/* adjusted current limit = Rsense current limit * CTL pin voltage / max CTL pin voltage */
> +	vdac_uV = (u64)min_uA * LTM8054_MAX_CTL_V;
> +	do_div(vdac_uV, priv->max_uA);
> +
> +	dev_dbg(&rdev->dev,
> +		"Setting current limit to %duA, CTL pin to %duV\n", min_uA, (int)vdac_uV);

Why casting?

> +	/* Standard IIO voltage unit is mV, scale accordingly. */
> +	return iio_write_channel_processed_scale(priv->ctl_dac, vdac_uV, 1000);
> +}

...

> +	ret = of_property_read_u32(np, "lltc,iout-rsense-micro-ohms", &rsense);

device_property_read_u32()

> +	if (ret < 0) {

Be consistent with a style, in the previous patch it was 'if (ret)'.

> +		dev_err(dev, "failed to get sense resistor value\n");
> +		return ret;
> +	}
> +
> +	if (rsense == 0) {
> +		dev_err(dev, "invalid value zero for sense resistor\n");
> +		return -EINVAL;
> +	}
> +
> +	/* The maximum output current limit is the one set by the Rsense resistor */
> +	tmp = 1000000 * (u64)LTM8054_VOUT_IOUT_MAX;

Yo may use MICRO and drop the casting.

> +	do_div(tmp, rsense);
> +	priv->max_uA = tmp;
> +
> +	/* Applying a voltage below LTM8054_MAX_CTL_V on the CTL pin reduces
> +	 * the output current limit. If this level drops below
> +	 * LTM8054_MIN_CTL_V the regulator stops switching
> +	 */

/*
 * Besides missing period at the end this is not correct multi-line style of
 * the comments. Use this example.
 */

> +	tmp = LTM8054_MIN_CTL_V * (u64)priv->max_uA;
> +	do_div(tmp, (u32)LTM8054_MAX_CTL_V);

Why casting?

> +	priv->min_uA = tmp;

-- 
With Best Regards,
Andy Shevchenko



