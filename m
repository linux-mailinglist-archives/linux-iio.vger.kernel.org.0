Return-Path: <linux-iio+bounces-23675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1089FB41BFF
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 12:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DAC1BA5F71
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD512ECD11;
	Wed,  3 Sep 2025 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaIE1ubK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E52EBDD9;
	Wed,  3 Sep 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895864; cv=none; b=dHD8wwe7BVU88+GgtFrCxLRW80fDYPZm9tH1waAdhl0iT+1+l5b0VSkcv2nhOhxE1GGEaUDsuQMj5mMeQOXmkJK4e7op4Bn9/73RaxqeaY4WqTs6co8Gl/lb2lOi9sgCLTxGnLQW8KjVd6iE54afoUPKVM7c5C9MOBFRHJuhzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895864; c=relaxed/simple;
	bh=Lfo4jcAKp/pnHLEzvJi5SJDxARnSzwZ9vzqotnTGkSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2TFu+LEKcgrCJSDajutCxFdczuld1oF7r/rpaxXo5mebW0KILvtYF/hpxCRda0ZR5LoNGWe/CaY6pV3bkv1Gkltvr/aMEz+FKh+ArC8i91jBIvT8KevCg1wkiyLSggaqNrNkKk3UeUE1v46Xrh5VR5kGvze2UhdYvbxBBlunO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaIE1ubK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756895863; x=1788431863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Lfo4jcAKp/pnHLEzvJi5SJDxARnSzwZ9vzqotnTGkSg=;
  b=HaIE1ubKq4QIpKGRByuUPZ263wA2JFXJp5rinx+JpjtZm0q8kp9iIPzz
   KAtQnZjRmef0RzN88IiSo3jucFKy0/doEP7/wm7mR+7setUu40ihO5aIp
   fhxlEyiuQLpL+Cim1ZbDFFFk1zUAUzmpyE8ujTy+MwSLuh/pxWCXaEmgl
   8PtL7hgnaodOp+9BKwXtc1u3KwAYPaH4Se50eWxxTY9CFrg3Uf5UgoYDn
   eez2njY3vUy8Xm+eJhk01jLH3wf9dwX8P9LxUReub+351j1lQZiroYy1X
   m0/IOsxQ/oFc/EsnsAwbpOye6sD/eUyf0TUjPMk1GwqEf4vTLQJaqo/90
   w==;
X-CSE-ConnectionGUID: YhAz1w2IRsy4Kf+nrCmd1Q==
X-CSE-MsgGUID: 5DYF/xGOQE2yCmS2JZG+2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81789676"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81789676"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:37:42 -0700
X-CSE-ConnectionGUID: 7+2GAz/ERVun8rqsEVJ7JQ==
X-CSE-MsgGUID: YgC7aelUTjeM2gJ4SlcWKg==
X-ExtLoop1: 1
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:37:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utkrw-0000000AxTO-2xSM;
	Wed, 03 Sep 2025 13:37:36 +0300
Date: Wed, 3 Sep 2025 13:37:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: ltr390: Implement runtime PM support
Message-ID: <aLgacK0MMojkaKuW@smile.fi.intel.com>
References: <20250901184238.34335-1-akshayaj.lkd@gmail.com>
 <aLbptFRh9ZvAVfLn@smile.fi.intel.com>
 <CAE3SzaTnNckFDRMDqGPDAg471bRskJ=_n5C_qSLKQeq3F-Lu_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE3SzaTnNckFDRMDqGPDAg471bRskJ=_n5C_qSLKQeq3F-Lu_g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 09:15:53AM +0530, Akshay Jindal wrote:
> On Tue, Sep 2, 2025 at 6:27 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Sep 02, 2025 at 12:12:36AM +0530, Akshay Jindal wrote:

...

> > >       /* Ensure that power off and interrupts are disabled */
> > > -     if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > > -                             LTR390_LS_INT_EN) < 0)
> > > -             dev_err(&data->client->dev, "failed to disable interrupts\n");
> > > +     if (data->irq_enabled) {
> > > +             if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > > +                                     LTR390_LS_INT_EN) < 0)
> >
> > Wrong indentation, hard to read line, either one line, or do better.
> > Actually why not assign it to ret? The above not only simple style issue,
> > but also makes readability much harder as the semantics of '0' is
> > completely hidden. This style is discouraged.
> Earlier did not use ret here, because powerdown function is of type void.
> But if readability is the issue, I have used ret.
> 
> Regarding clubbing into 1 line, I have my reservations there. I think we
> should not violate the 80 char line limit.

Shouldn't != mustn't, esp. when it's about readability.

> Also since the line is already 1-level indented (begins at 9th column, due to
> if(data->irq_enabled) check), the spillover will be too much. The readability
> does not seem to be taking a substantial hit here. Let me know if this is
> non-negotiable for you. Will happily make the changes.

		ret = regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);

only 88 characters. One can make it shorter, yes

	struct regmap *map = data->regmap;

		ret = regmap_clear_bits(map, LTR390_INT_CFG, LTR390_LS_INT_EN);


79 characters.

-- 
With Best Regards,
Andy Shevchenko



