Return-Path: <linux-iio+bounces-19655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7533ABBAC5
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0151681A1
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6A26F462;
	Mon, 19 May 2025 10:14:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F005881E;
	Mon, 19 May 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649664; cv=none; b=CUCLBSZFrrh6YRUiYe8dam9IqjjEvncoxX4wqai8RXl10seJqArLXZGoses3NshTvpK0bUP14/cOjifz9WUMhJkKqSjfiO8LAGCLDVe2KA9J8Eav8EMj9zHnoMY5nDUkixWsoglUZyI5PjrV/sH9hVA5+O4WQdrPnhyhHApXeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649664; c=relaxed/simple;
	bh=+qY/W+Tl5bBKT/y1ObIIiIHY/AW5ZPx+TXJ/Ggj8xHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAsHNIikVaxamKno1MplcZ2sIGkFGCcO9j7m4Cnmoj7KXiTAC9bBKSHHJ5Rk/XUnipEg1Q8/VXaTeZXPnctXovxsA5YvlmD0LpGLEHlr+i3wruht8qH/baIV6ekXxPqvNUtVDqIn9jUmDhrMAC64ywhjQDf0qCYhGRhzyPDdu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: FYz9cRoRTqmhHxWjgSLyaQ==
X-CSE-MsgGUID: /3UEGO4fREuR+ctDj8ntXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49697120"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49697120"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 03:14:22 -0700
X-CSE-ConnectionGUID: KXafi+e/TJekXaV/pJPQCQ==
X-CSE-MsgGUID: qj8D3cXCTpO2/sb/3vMoPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="140350370"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 03:14:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uGxVh-00000002yrh-1LHz;
	Mon, 19 May 2025 13:14:17 +0300
Date: Mon, 19 May 2025 13:14:17 +0300
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
Message-ID: <aCsEeQQyGdBg2ex9@smile.fi.intel.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-5-91a3f2837e6b@baylibre.com>
 <aBz_Nlgx18UK2GIc@smile.fi.intel.com>
 <shzx67wrpzaxje4vj6owwnof3pi5cuipdavd3k5svucyt5y527@mvytnov6zunk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shzx67wrpzaxje4vj6owwnof3pi5cuipdavd3k5svucyt5y527@mvytnov6zunk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 19, 2025 at 11:40:09AM +0200, Angelo Dureghello wrote:
> On 08.05.2025 22:00, Andy Shevchenko wrote:
> > On Thu, May 08, 2025 at 12:06:09PM +0200, Angelo Dureghello wrote:

...

> > > +	device_for_each_child_node_scoped(dev, child) {
> > > +		u32 reg, r_gain;
> > > +
> > > +		ret = fwnode_property_read_u32(child, "reg", &reg);
> > > +		if (ret)
> > > +			continue;
> > 
> > > +		/* Chan reg is a 1-based index. */
> > > +		if (reg < 1 || reg > num_channels) {
> > > +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
> > > +			continue;
> > > +		}
> > 
> > But this will allow to have a broken DT. This check basically diminishes the
> > effort of the DT schema validation. If there are limits one still would be able
> > to create a DT that passes the driver but doesn't pass the validation.
> 
> fixed all your points on other patches of this patch-set. Still your
> emails are going to google spam, just could catch them on friday. 
> Really not clear why.

DKIM which I still need to configure...

> About the above, i understand, but the check is actually the same as
> in ad7606_get_chan_config(), a warning that fdt is not correct, 
> i dont see a blocking issue here now, so not going to change it
> in this next patchset.

I think the 'continue' above is simply wrong. We should not allow to have
broken tables. And I think it's kinda blocking issue.

> > > +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> > > +					       &r_gain);
> > > +		if (ret)
> > > +			/* Keep the default register value. */
> > > +			continue;
> > > +
> > > +		if (r_gain > AD7606_CALIB_GAIN_MAX) {
> > > +			dev_warn(dev, "wrong gain calibration value");
> > > +			continue;
> > > +		}
> > > +
> > > +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> > > +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> > > +		if (ret) {
> > > +			dev_warn(dev, "error writing r_gain");
> > > +			continue;
> > > +		}
> > > +	}

-- 
With Best Regards,
Andy Shevchenko



