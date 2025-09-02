Return-Path: <linux-iio+bounces-23628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2477B3FB39
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 11:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A671616B57A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551C92F49FE;
	Tue,  2 Sep 2025 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmDZFSnK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8B8F49;
	Tue,  2 Sep 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806614; cv=none; b=ZzsohBLdr5kPW0SswBka7uMygQOTWaZF/NgEv4ozWn7xJWnTWkVArbSnSI8NKAbE5rg4mvHirA9iY9ATJDPuNxKpyS2HuIjuaj1xEcvHKOsMbBcMpUN75MoeRqOKYawAsA2arRLcExadpi6p69IxRGXTVIqIXCGg7RARrsqjWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806614; c=relaxed/simple;
	bh=A2Fv5RDR544whpRy4Vv95fjWFBquzxcBPQkrdLpUAso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE8PmNCMm6HdavZ2NypnpBcBBq0tLwM9BFzsBoxZtmkYXM41AMUWDeCqHmtdxEYgo8Ffe+FkVGGKZYqsC/e6eqD4TrmIy1okz22qzZymVVZscrmfk7k+HQO7XIdmsGzIwWV89u4iipn1PGB/sqHoGCixiLmyZUVLz1m0lOjFluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmDZFSnK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756806612; x=1788342612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A2Fv5RDR544whpRy4Vv95fjWFBquzxcBPQkrdLpUAso=;
  b=lmDZFSnKaFOVjokz+vw7SymOavSEbvI7GpaNYkeU/kMJ4xFwQr2j+7zY
   dvC57iOu4ZUAv1BIUCrJV/4lR4P7eW5Q1/qbnuYfBN04Wl2TauV+/sQw2
   P+3llk6++UyS0Zgc0l/fOO9yjk0z2ex6Hm8J5HL2xU85mrk2YjIHssIz5
   9DWss6rABBxQcJD//GWtwsT08l17U+81OpUiAijIpxro/Qyu67A9PqaYN
   wJwuXbS0eKO7bSygXH3dAGCtnc+MaWQY3Nd1nNqtDfdP9tQ+C7tpfLchu
   RQMHqY1CgCz0/4KBlPyU4Y6ZkzyeBwkUafk9W9toHuwEV11BsW0LTQl+4
   A==;
X-CSE-ConnectionGUID: DFYlQKWBRi2SNlnv1SXpWg==
X-CSE-MsgGUID: rHaECquQSX6TRc95d1ABHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70174250"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70174250"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 02:50:12 -0700
X-CSE-ConnectionGUID: fhCWKXC+Q0i1cOxPYiuDVA==
X-CSE-MsgGUID: 0rsr/RUeTIOZHYHBMtqPAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175612542"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 02:50:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utNeP-0000000Aev1-1FkK;
	Tue, 02 Sep 2025 12:50:05 +0300
Date: Tue, 2 Sep 2025 12:50:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Message-ID: <aLa9zbls-Cl4PNQd@smile.fi.intel.com>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
 <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
 <aLW9O1rnhUqqh02r@smile.fi.intel.com>
 <3031049.e9J7NaK4W3@radijator>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3031049.e9J7NaK4W3@radijator>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 01, 2025 at 06:51:19PM +0200, Duje Mihanović wrote:
> On Monday, 1 September 2025 17:35:23 Central European Summer Time Andy Shevchenko wrote:
> > On Sun, Aug 31, 2025 at 12:33:05PM +0200, Duje Mihanović wrote:

...

> > > +	.max_register = PM886_REG_GPADC_VBAT_SLP + 1,
> > 
> > What is this + 1 register? Why is it not defined / documented?
> 
> It is the second field of the vbat_slp channel.

Can you define it separately? Or define _MAX_REGISTER to be equal to that and
put a comment that _VBAT_SLP takes two (byte) offsets.

...

> > > +err:
> > > +	gpadc_set_bias(gpadc, chan->channel, false);
> > 
> > You do the same in the other branch and checking there for an error. Why this
> > one is so special?
> 
> My rationale here was to not override the error from either the first
> gpadc_set_bias() call or the subsequent gpadc_find_bias_current() call.

Maybe this needs splitting / refactoring to call bias setting separately?

...

> > > +	iio->dev.of_node = dev->parent->of_node;
> > 
> > No, use device_set_node() with the respective parameters.
> > 
> > But rather debug why firmware node (or OF in your case) is not propagated from
> > the parent device.
> 
> I guess it is because the IIO device is registered as a child of the
> GPADC platform device, which does not have a node unlike the PMIC
> device (GPADC pdev's parent). It seems that the regulator cell
> registers its regulators directly under the PMIC dev, so maybe I should
> do the same here with the IIO dev?

Maybe. Not an expert in DT.

-- 
With Best Regards,
Andy Shevchenko



