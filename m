Return-Path: <linux-iio+bounces-21317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F79AF7CB9
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303997B1945
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD7223DDA;
	Thu,  3 Jul 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5xt1+MA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485819DF61;
	Thu,  3 Jul 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557531; cv=none; b=ZlNmjydKfykuz9xrICelXYeadXg08eVCAjDK18UGSjJE4d9outIIQWsKd7qz/B6etEFrDbi/NBSaqsheHNHkHSJ7KYnT8CmaPLQiyL73txDnMnWCb36Uz4UYpaHInUesV04sDAwV6IyijglSqQneXZ5dwgW6erd9Hs9Emeb3Fd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557531; c=relaxed/simple;
	bh=8qLi44poKRoblhr2C3ruUsFr604c9UYKBm11l8n99CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZOhUN/hXGak/p2J8g13A8rCmAQwLWlL5lnur5qhJHYUW8H4NhzDA5A/PS/sOc4+QGw9rEScsr7aUiWROiba79rQOKXCiUrjmAxCAu2a26W7gbd+Elx/TE7gYqA7y3dRZCFDvzdgCTgEegcJ4eCsB9/MnT19dY6bbMN/s4n0m6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5xt1+MA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751557529; x=1783093529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8qLi44poKRoblhr2C3ruUsFr604c9UYKBm11l8n99CM=;
  b=b5xt1+MANymvQWDUabx/u38XVcXAgAWSFwSQvo2wLUT4f5hE5N3aq+nR
   TP41wBiv33dzXLXkSDTk7uTqfE9JDu7J8dbJ3W+n+aFcEp6JX/b/heDuH
   MLhbnq8tBq3tj0z1C+q5VKVEChN9ayUuQWxlZCc6107FqO43RfHW0pedd
   +gPJSJ4l59kPWZxzHzpFy7FBWTF7CLwkq/sJd8WImtIMeyfNf2s19vkal
   r89xA6M8K8MgbCFxwgvPBEZh1ZtmjUmU1loGxGSbN4gSy2xx6VJ9Um2bu
   UL7q1RDaC7SJEdALbXVDsZV21Lquqa0kGBovBirmHda74A1UQXcQy1yjI
   Q==;
X-CSE-ConnectionGUID: ryuPhG5RThi41PpMzAG2Vw==
X-CSE-MsgGUID: P5ItKD/bQM+2EFzo4KGMHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71329432"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="71329432"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:45:29 -0700
X-CSE-ConnectionGUID: NnComOITQdK4pQxSKP4Mgw==
X-CSE-MsgGUID: qu82479pRqauvpL6VVdZ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154172233"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:45:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uXM7m-0000000CFHy-0sN8;
	Thu, 03 Jul 2025 18:45:22 +0300
Date: Thu, 3 Jul 2025 18:45:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v11 4/8] iio: accel: adxl345: add inactivity feature
Message-ID: <aGalkb42uRQ12Wr0@smile.fi.intel.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
 <20250702230315.19297-5-l.rubusch@gmail.com>
 <aGaTH6gVqHxn9Xct@smile.fi.intel.com>
 <CAFXKEHb4MQk=6hyh-02Fq_XmkQmMiwc-WT4ZSviP6x4XA463mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHb4MQk=6hyh-02Fq_XmkQmMiwc-WT4ZSviP6x4XA463mQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 03, 2025 at 04:59:50PM +0200, Lothar Rubusch wrote:
> On Thu, Jul 3, 2025 at 4:26 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jul 02, 2025 at 11:03:11PM +0000, Lothar Rubusch wrote:

...

> > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > >  #define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > +#define ADXL345_REG_INACT_AXIS_MSK   GENMASK(2, 0)
> > > +#define ADXL345_POWER_CTL_INACT_MSK  (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
> > >
> > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > >  #define ADXL345_TAP_Y_EN             BIT(1)
> > >  #define ADXL345_TAP_X_EN             BIT(2)
> > >
> > > +#define ADXL345_INACT_Z_EN           BIT(0)
> > > +#define ADXL345_INACT_Y_EN           BIT(1)
> > > +#define ADXL345_INACT_X_EN           BIT(2)
> > > +#define ADXL345_INACT_XYZ_EN         (ADXL345_INACT_Z_EN | ADXL345_INACT_Y_EN | ADXL345_INACT_X_EN)
> > > +
> > >  #define ADXL345_ACT_Z_EN             BIT(4)
> > >  #define ADXL345_ACT_Y_EN             BIT(5)
> > >  #define ADXL345_ACT_X_EN             BIT(6)
> >
> > Now it's even more mess. I am lost in understanding which bits/masks are from
> > the same offset and which are not.
> >
> 
> I'm sorry for that. I mean, while the above is supposed to make it
> clear where the "values" are coming from, I also could setup something
> like the following which is shorter.
> +#define ADXL345_INACT_XYZ_EN        GENMASK(2,0)
> +#define ADXL345_ACT_XYZ_EN        GENMASK(6,4)
> 
> As I understand you, you'd rather prefer to see the latter one in the kernel?

My personal preference can be found, for example, in
drivers/pinctrl/intel/pinctrl-intel.c. But I'm not insisting to use
_my_ schema. Just find a way how to group them semantically.

-- 
With Best Regards,
Andy Shevchenko



