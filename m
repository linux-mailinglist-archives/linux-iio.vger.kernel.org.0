Return-Path: <linux-iio+bounces-24272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE28B86A71
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 21:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45011C8784F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B082C17B3;
	Thu, 18 Sep 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkL8S7Cb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF92571BE;
	Thu, 18 Sep 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223089; cv=none; b=K/VgUBOyRqKDo8TRmyykQJxuwoQymAvcvPsfopjNch9cV8qR8rQ/MgER7hYs5r4U2/w0irrkNZTUcQiUlP6mkhvrCA3hcIjd39zJ47t537e5pR9P9AI6hbeb2gJdr3t3CMWysYKaLmjpv2yJVSALuFuN2U8WG6hkkWrrl0+P7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223089; c=relaxed/simple;
	bh=3kT4c/sD9alTJ2vJ5tBL3nY9kiB30T9WSIAU8ap2IFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1mjk+d28622WP8eu5faMpDod02RaR2N9dy01bXsXxK7W4ROm7e9Clr9Pug0+IunBL40q6IgKEFKbmzB5G/S7AFWRTOgVxzSsGKlGy4r8/nUtLTjNb3B3D/Ta89H8tZvSVJnCgwajw2wERsRDVs3+iVIdSU9tDQgI9zi6qxiqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkL8S7Cb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758223087; x=1789759087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kT4c/sD9alTJ2vJ5tBL3nY9kiB30T9WSIAU8ap2IFo=;
  b=MkL8S7CbFnfDCFu2JHC4beCT+25BkrbRrDuN2pCs3vv7s6WxuLEYxNyV
   S2epHLfzQPLYFqX8PoHHlXYa9CmILiliNVWRpc4sSEIHDF0bBPaglHOob
   DSkEf6AMpQNaMmALabqfRgfrKzFCq/50YiwdPBTWhhY9QddKIvB8O/wVO
   aVDANMqhothpdbYF/wioZgHPDscJa8JPmT13VXR0IafN5/M8ASpsC4snz
   MDu/tfEtFYZmxJDqNgJzjGYtnC3Ha9o/m3/v6oCbJajPj29aON7eNkeuP
   4K0bhHYPGBQ47gHtTEllF597+XAGhWDCaHRjZ8wwMrS7RzQDIXumEnoZA
   A==;
X-CSE-ConnectionGUID: dzpmsl+LQLmUYGrHkSPoew==
X-CSE-MsgGUID: ttU/52y8Qw+FevLXlJGMOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="71677837"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="71677837"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:18:06 -0700
X-CSE-ConnectionGUID: z4IH6bzYQ021h4VgeDsBXg==
X-CSE-MsgGUID: ugXNOmAoQoajv0xQg7xISw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="176037873"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:18:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uzK8l-00000004Ass-3q1E;
	Thu, 18 Sep 2025 22:17:59 +0300
Date: Thu, 18 Sep 2025 22:17:59 +0300
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
Subject: Re: [PATCH 3/4] regulator: Support the LTM8054 voltage regulator
Message-ID: <aMxa5_LG3ADCjeHj@smile.fi.intel.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <aMliRTuUDNPkeM8C@smile.fi.intel.com>
 <5205519.GXAFRqVoOG@fw-rgant>
 <12775482.O9o76ZdvQC@fw-rgant>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12775482.O9o76ZdvQC@fw-rgant>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 18, 2025 at 11:31:50AM +0200, Romain Gantois wrote:
> On Tuesday, 16 September 2025 16:17:56 CEST Romain Gantois wrote:
> > On Tuesday, 16 September 2025 15:12:37 CEST Andy Shevchenko wrote:
> > > On Tue, Sep 16, 2025 at 12:24:08PM +0200, Romain Gantois wrote:

...

> > > > +#include <linux/of.h>
> > > 
> > > I think we have already something agnostic in regulator API to get a
> > > regulator from a firmware node (rather than from specific OF/etc one).
> > 
> > IIRC the "of_match" regulator descriptor property can be used for this, I'll
> > have a second look and see if I can use that instead.
> 
> Looks like I misread your comment sorry, the "of_match" property is pretty 
> much irrelevant to using fwnode_* wrappers, and I didn't find any of those in 
> the regulator subsystem. I'm missing a Kconfig dependency on "OF" though, I'll 
> have to add that.

Why do we need to add that dependency? Yes, probably it won't function,
but then it will decrease test coverage at compile time.

-- 
With Best Regards,
Andy Shevchenko



