Return-Path: <linux-iio+bounces-24198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBEB800B3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C6E1C03A61
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 07:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A87E2D24A4;
	Wed, 17 Sep 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WudmjGv9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06FB248861;
	Wed, 17 Sep 2025 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092623; cv=none; b=SMFX1bjtgvi9viDEmLQllcmZZPx8v0m8TL0FtuaXZNJIFbocdoYQbcCknvei90lLkgZWwR7EzIxjc18Q5hEd3UwCaQsZIrEyDzAGKFBWZ12UoKP8N/qc7/146Rab+GkSjMAJmGtp55O0lB9C1KM3wKJXMGy78XkzpDo0mCnzAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092623; c=relaxed/simple;
	bh=EgCG+hVHYiVWi4m8cYgfpmMJhtRxVZO9yGSARbeWCpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ+5gf+hRjR+Jo9enzHszyCvu4u6FEApBXtAJdYcEuv8Vig3HhhHpZmTbZDmfBaqkQ/0P8U/NHSOuSXm7V0WdlMBW2tDYcrz1Y7dyzvkNST+MnxT9RUFN1dubofVL4r5O8LWh74n6m8PhnGa/223T7ehBO1xavKu4XNwGULZwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WudmjGv9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758092622; x=1789628622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EgCG+hVHYiVWi4m8cYgfpmMJhtRxVZO9yGSARbeWCpI=;
  b=WudmjGv98rv29rKCd4Zz7nSVgT4LHeT8kG+1hyKDckMLWYKqIE0Kbdg0
   9g8jsVwESo7Hw3ORXbrY2uiCFXL403umvgwuk0nw96SUxajT2HLR6F51R
   gQp3o0O2rPhxpcJOrGvvtnoU51RZuomfeV3qm+U8RhtjX3oKl42sqvopW
   A9ckv+vGBQaXpRXUfCw2BLi8UPqBpxjpLjxKHQ7g54bjbPJlHZlf7vbot
   WarreH53UHCd8Gq7dYCE2Yxrfj0kcgG3slntUbUQwXIBx0uSVTojLUQ/8
   UO1wHMxLkEKFnVEvdnMUDpLPPo0bf2GLqd1+qj9n/5rRQyZJOFgD4oZmv
   Q==;
X-CSE-ConnectionGUID: 8+OBYxHfTSOFE8t2nx/wmA==
X-CSE-MsgGUID: iy0T6ZWHTT6PFay6ge7Oyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60316671"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60316671"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:03:41 -0700
X-CSE-ConnectionGUID: cjp2Wl9NTPKAVDYEk8hRCQ==
X-CSE-MsgGUID: nifEwfYmTIiYnxFDv8g+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174966062"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:03:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uymCU-00000003je1-1vNt;
	Wed, 17 Sep 2025 10:03:34 +0300
Date: Wed, 17 Sep 2025 10:03:34 +0300
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
Message-ID: <aMpdRhAh9g71dt7M@smile.fi.intel.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-4-fd4e781d33b9@bootlin.com>
 <aMlj1OcfH8r9Zz6x@smile.fi.intel.com>
 <8772650.T7Z3S40VBb@fw-rgant>
 <aMpc64pctVA1bvmr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMpc64pctVA1bvmr@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 17, 2025 at 10:02:03AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 04:27:25PM +0200, Romain Gantois wrote:
> > On Tuesday, 16 September 2025 15:19:16 CEST Andy Shevchenko wrote:
> > > On Tue, Sep 16, 2025 at 12:24:09PM +0200, Romain Gantois wrote:

...

> > > /*
> > >  * Besides missing period at the end this is not correct multi-line style of
> > > * the comments. Use this example.
> > >  */
> > > 
> > > > +	tmp = LTM8054_MIN_CTL_V * (u64)priv->max_uA;
> > 
> > This cast avoids an overflow of the multiplication, since the result may
> > easily exceed 32 bytes in size.
> 
> It's better to read in a way of
> 
> 	tmp = (u64)priv->max_uA * LTM8054_MIN_CTL_mV;

I just realised that in previous mails and here I meant _uV postfix for the
predefined voltage thresholds. Sorry for the confusion.

-- 
With Best Regards,
Andy Shevchenko



