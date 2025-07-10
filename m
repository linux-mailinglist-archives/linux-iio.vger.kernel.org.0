Return-Path: <linux-iio+bounces-21530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B071B00181
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 14:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6233588006
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8D2505BA;
	Thu, 10 Jul 2025 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJBiKqna"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6624DD12;
	Thu, 10 Jul 2025 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150014; cv=none; b=rJGdVmQ7Ox0g6ESW/Roj2EgeK7yn/eWFKJMVJe81T4w9JRAtOm7bzSZitIM6wBWFA74o7D9KAdjXX8+jGTeVFM3Gs7WEtAYvDib58mH8VhQ4wO5ZYhB8imoqHVV4/1tHxt94PhrsEkKPCKkY/RR57innuN4SXG6saWTKo1P09os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150014; c=relaxed/simple;
	bh=1Ars87cWfPNJmxmVVHggBVpUXosQcIraO2lesp921A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAhrUhrpOoCltr04lR/JGDLztVpu7SjXeq20+DvRVZYS27WGZqAFwQGTVHftJ6PYenovP99/dw3LQiOp3YFKuC+oNKNWrn6Y+N1opd4mLAfCmZJ0lSr72t7ARaci5/XWnxIRpkaNrCJE1gex4SEHhjKIX0OSAD0Kz+onW3056Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJBiKqna; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752150013; x=1783686013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Ars87cWfPNJmxmVVHggBVpUXosQcIraO2lesp921A0=;
  b=oJBiKqna+//afVa5igz8zN7OT0RSBBv486V4FDd/V4vGpDZEtQ+2vOl0
   6+m1sBIBQzpV2mJQEGwnO5NRE6XAW2pBBpuAR8U6+TW4cIfmUaXLb8Y52
   fvFah/ptUZMANt6YYmFCr4DwNYehLxNfVYWQz3PT8mtLbMSZuLYAJLfJh
   ZAFX8aOFjMtIfddzfCUIJcXnoe0Cd/Z0mf9ATujAvFsfRD8DGuztLejsB
   F4tmW/b52PpIQXbwPlObGUGQHsildfW7CXkZ4Pmir8hfUeXKutd8Znvw1
   amqtqzTmpDhLgOwZney8Am7ySenKvwiL2n5Y7APJqnMb2Vjj8NDqpdoYi
   A==;
X-CSE-ConnectionGUID: CizJc7eISD2nWtsYFUezwQ==
X-CSE-MsgGUID: arGY67idTyW/mru3848Pxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71877347"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="71877347"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 05:20:12 -0700
X-CSE-ConnectionGUID: GXz77hyaR7K/tYrlBBMkog==
X-CSE-MsgGUID: kYPUpfJ0QvqQJaA5ZICfig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160078428"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 05:20:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZqFw-0000000EC0t-26Sd;
	Thu, 10 Jul 2025 15:20:04 +0300
Date: Thu, 10 Jul 2025 15:20:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de, andrej.picej@norik.com
Subject: Re: [PATCH 2/2] iio: adc: imx93: Make calibration parameters
 configurable
Message-ID: <aG-v9IxJ-XAxmnyh@smile.fi.intel.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-3-primoz.fiser@norik.com>
 <aG-GZqhABwErcEyM@smile.fi.intel.com>
 <42dd658e-555a-43f7-a7bf-e5365d508f4a@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42dd658e-555a-43f7-a7bf-e5365d508f4a@norik.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 12:23:58PM +0200, Primoz Fiser wrote:
> On 10. 07. 25 11:22, Andy Shevchenko wrote:
> > On Thu, Jul 10, 2025 at 09:39:04AM +0200, Primoz Fiser wrote:

...

> >> +	ret = device_property_read_u32(adc->dev, "nxp,calib-avg-en", &val);
> >> +	if (!ret) {
> >> +		if (val != 0 && val != 1) {
> >> +			dev_err(adc->dev, "invalid nxp,calib-avg-en: %d\n", val);
> >> +			return -EINVAL;
> >> +		}
> >> +		reg = val;
> >> +		mcr &= ~IMX93_ADC_MCR_AVGEN_MASK;
> >> +		mcr |= FIELD_PREP(IMX93_ADC_MCR_AVGEN_MASK, reg);
> >> +	}
> > 
> > Please, since it's optional, do other way around.
> > 
> > 	val = $DEFAUTL;
> > 	device_property_read_u32(adc->dev, "nxp,calib-avg-en", &val);
> > 	FIELD_MODIFY(...)
> > 
> > Similar approach may be used for the other properties.
> 
> OK, I guess I could implement it like you suggested to explicitly set
> the default parameter values.
> 
> But in current implementation MCR values are read at the beginning of
> imx93_adc_calibration(), meaning calibration parameters are register POR
> defaults. With you suggestion, we put defaults in software rather than
> reading them from the hw directly.

I see, then you need to read, do FIELD_GET()/device_property_read()/FIELD_MODIFY().
You got the idea.

...

> > Please, factor out this to the function, so we won't see the direct IO in the
> > ->probe().
> 
> Sorry I don't understand this part.
> 
> What do you mean by factoring out this writel()?
> 
> Do you perhaps suggest to implement function
> imx93_adc_configure_calibration() and put all our changes into it?
> 
> But we are already in imx93_adc_calibration() which is separate from
> probe().

Ah, sorry for the mistakenly read the function name. Ignore this comment.

-- 
With Best Regards,
Andy Shevchenko



