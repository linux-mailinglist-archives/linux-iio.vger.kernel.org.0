Return-Path: <linux-iio+bounces-15431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F57A323C1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10BC57A1DF1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A1209663;
	Wed, 12 Feb 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmtZQn1B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E89209674;
	Wed, 12 Feb 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357032; cv=none; b=YRD/9hnXsrDL7wvAOznziDPrFARwNL9TFmLTDDqmgk64zSiRAUYXMkCaD24sy891dqXlgwUjKCT2sTG3tto5HEMGrIrn/4YVTw9mBfUcOfjA2TAvwB0Ccz4rSkjjifR36hRprw/lFwzeWPTr4VcD6DdTyaUhpvI4KXZbpXhV5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357032; c=relaxed/simple;
	bh=X2eltLRhw1w4UIkkJvn+viee4/SqEPKwaFrktrUEYQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW0LomOY+MkvwLS0dZMI6HibLpf+dF/xpbrvRDjffGFpxkl/Fw7hZrxwb0oKwLZRNXdNFUjT8n+P1z/2OzuRxIy+F58xjFoO222CFR7MDidpmVxpzJa0PsDxtcRbJlykpDUtFpbxVmZZr1XWMGjDoY2njbgyqvgt0o17FFGzKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmtZQn1B; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739357031; x=1770893031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X2eltLRhw1w4UIkkJvn+viee4/SqEPKwaFrktrUEYQ0=;
  b=FmtZQn1BLzus6bNFcNKWSJtoVzBdQSBws7WBsJqo/epOY77IAtFfcg5L
   3H3B5YYjPRd3KHfOJmo0v+59CrbWMXHEVOPEjRrjB2adDHipBKWjAws1j
   A3/o48xZrW8roOxpgtSSq4fjiMdOqiUbxreKsZyF20vS7QpdjHI2lrBwP
   xyxh7tVRml6njGbXjIY2nfsR3nkFatRP+gnKrwDwC4IHvBlmn6yKFsJMg
   HMiCxx3Gcg1tuNc+b3fZYM0xFsxk118egeULleh/7s751RlaDtLaMnGWQ
   s2S0pmBcihFwKtpZJvZiy4Nvqmj18hwdwyPKs7lwyGHJ4EQV1zhga6Uhd
   Q==;
X-CSE-ConnectionGUID: MF+EgDxRSRGhAXdkTPap3A==
X-CSE-MsgGUID: VR1FiWZFRj6YdwqvQD9Vew==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40032078"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40032078"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:43:51 -0800
X-CSE-ConnectionGUID: 9ogGZln/SR2AoJP2f85ftg==
X-CSE-MsgGUID: 082GvNeQSUKxR8PlBtUqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112998158"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:43:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiADW-0000000Ao56-16Qk;
	Wed, 12 Feb 2025 12:43:42 +0200
Date: Wed, 12 Feb 2025 12:43:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 6/8] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <Z6x7XgtGr8Thx08Z@smile.fi.intel.com>
References: <20250208211325.992280-2-aren@peacevolution.org>
 <20250208211325.992280-8-aren@peacevolution.org>
 <Z6jAEEU2dqn_FJVp@smile.fi.intel.com>
 <20250211194311.5255f25b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211194311.5255f25b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 07:43:11PM +0000, Jonathan Cameron wrote:
> On Sun, 9 Feb 2025 16:47:44 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Feb 08, 2025 at 04:13:24PM -0500, Aren Moynihan wrote:
> > > Using dev_err_probe instead of dev_err and return makes the errors  
> > 
> > Use dev_err_probe()
> > dev_err()
> > 
> > > easier to understand by including the error name, and saves a little
> > > code.  
> > 
> > I believe this patch will make more sense before switching to local 'dev'
> > variable. Then the previous one will have an additional justification as
> > the "struct device *dev = ...;" lines in some cases will be added already
> > by this patch.
> 
> I'm not sure I follow this one comment.
> The only line that has struct device *dev =  added in this patch is
> replacing an existing client->dev lookup that could have been pushed
> to previous patch if this patch ordering was maintained.
> 
> For dev_err() to dev_err_probe() the number of references to dev
> is the same after all. The only additional justification this patch
> makes is some longer lines that using a local dev pointer shortens
> again.

When converting to dev_err_probe() in some cases it makes sense to add a
temporary variable at the same time.

	if (ret) {
		dev_err(&pdev->dev, ...);
		return ...;
	}

===>

	struct device *dev = &pdev->dev;
	...
	if (ret)
		return dev_err_probe(dev, ...);

which reduces automatically the churn in the patch that wants to (re)use that
temporary variable and also adds to the justification as "we already have that
variable, just want to use it".

-- 
With Best Regards,
Andy Shevchenko



