Return-Path: <linux-iio+bounces-11882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C779BAE42
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ACA1F23088
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85418C326;
	Mon,  4 Nov 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNzuLcPE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71318A947;
	Mon,  4 Nov 2024 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709479; cv=none; b=q5ReBr9JEH0JUSr03BbWeOutuBDBVWdjLWlWpJEUPUnQi0yU+6uPj0QI4e7x1dCWYFrO6LSmUOicN8nUrhpFeiI2mSSj8HVA7gdihG3bMsaMHtwZsPmK1dYWv/VKmozHUAJ7Swx2mGlKQnzK7WWtJ7Z/bLZMrFWX/6ZHBHb9kIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709479; c=relaxed/simple;
	bh=ML6JuLR5aGTGkpWrKYsMlJoQ/UheugXHDbe7zvn2E4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxpAprvZwl23uhO+IOc0wA6B7Ve0nqN3zEMKr6Q4nl6+eVHPS4u4KJTpPmN1yhauMAdGsOWfVOS0F/1SC+JZKsXzbbJFgmPqaUlDHuIss52oFuYN0cvXTkAtoK2yBtg2K5LpHbg2uvxwdQaU3Gi/pqYx1EuVm2ZEe5DeWrmQD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNzuLcPE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730709479; x=1762245479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ML6JuLR5aGTGkpWrKYsMlJoQ/UheugXHDbe7zvn2E4g=;
  b=JNzuLcPEtsgvhr7hlCAwN6UugFErwvoEccLoCPsGNWbeCl48VBU7SqZK
   uL0CKIqvQyDze4KayxCG5TUIj3Mc0fAqg/b6UZoK6Hv8CFFMEJ60xOG8N
   HbcwLpu8HnlKz6ru3WP3AXKiwLDiSP9Op0WuKTjEWZZ8qBx+s+Ni1kGOR
   z0hruqZIRxGCm/zH0A09HpOjOtxB6zEOZcc5B4vnzGl9fEef0huztsNV8
   YBW7uFOjsznNe28RraiiDzr3iZKgXBbIMFDTo5DCuX9RA2NMs9BHUOPBN
   1noLar4ChcnoGEGi1h1oBJKaxBlIFl9CU9C5LtWxN+RGhN0Eio0VrQ4s3
   g==;
X-CSE-ConnectionGUID: bMfzltfsQbWPwhRsYMNq9g==
X-CSE-MsgGUID: rzKvuV0fS3C8rYXYTXB09A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41502023"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41502023"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:37:58 -0800
X-CSE-ConnectionGUID: VctOKoJRQM2VqqPSh3Rvkg==
X-CSE-MsgGUID: +3dMFlo4Q2icgewC0wY8Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88166032"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:37:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t7sas-0000000Az4Q-200R;
	Mon, 04 Nov 2024 10:37:50 +0200
Date: Mon, 4 Nov 2024 10:37:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aren <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
Message-ID: <ZyiH3lkMZoAS-toj@smile.fi.intel.com>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-9-aren@peacevolution.org>
 <20241103112933.60f96f97@jic23-huawei>
 <cx5bvcqfabsptn37uzscooh73j73dsoqadmfaibzxrzjk3byx4@ofwu7qa6ht4f>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cx5bvcqfabsptn37uzscooh73j73dsoqadmfaibzxrzjk3byx4@ofwu7qa6ht4f>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Nov 03, 2024 at 11:11:13AM -0500, Aren wrote:
> On Sun, Nov 03, 2024 at 11:31:03AM +0000, Jonathan Cameron wrote:
> > On Sat,  2 Nov 2024 15:50:39 -0400
> > Aren Moynihan <aren@peacevolution.org> wrote:

...

> > For this Andy was asking for consistency.  Generally we don't insist on a
> > particular ordering in IIO drivers, but we do prefer them to be the same.
> > Your new ordering is inconsistent between resume and suspend.  Whilst
> > existing code may be inconsistent, you can still pick most common ordering
> > and use that for your new code.
> > 
> > If the existing driver is inconsistent then feel free to tidy that up but
> > do it in a precursor patch so there is a consistent style for you to then
> > carry on.
> 
> Oh right, the order of declarations in stk3310_suspend also needs to be
> flipped. Is that simple enough that you can fix it when applying this?
> 
> Apparently I was being dense, I checked the rest of the driver to see
> what it did (it's consistent about putting shorter lines & ones without
> an assignment first), and fixed the case Andy pointed out to match that,
> but failed to check the rest of the patch.

Thanks!

You may ignore my comment about RCT order if it's not that one that being
commonly used in the driver.

-- 
With Best Regards,
Andy Shevchenko



