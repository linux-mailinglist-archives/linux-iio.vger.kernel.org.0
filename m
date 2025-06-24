Return-Path: <linux-iio+bounces-20935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD3AE5D90
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDD71B62A4A
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE7524EA85;
	Tue, 24 Jun 2025 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnDQZLiZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338686347;
	Tue, 24 Jun 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749658; cv=none; b=OVGr4luED5sHj0n6XxgBtz5fEg6lH50AQcSU5D9M9WC4fThGwZZHDRtn1QKLWxDeXTIGhZiwFrDhlBrf6JjBzDPLGBzBnCj/bNdY0WskX2bvkPIwDJxZDvsMoQRgjSpyJ1cFmw6aDifpF23bIiHkInbIis8o4D8aILhyfmAWwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749658; c=relaxed/simple;
	bh=HvSZSrdL1NnkCo3Suic53nwcH+R7YoRUxgYQYmv+rkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG9dBdNAi2vYBJuxJWuCLSTGHPx9PFkFq4ZScTgQGVCoUJMSbkG9S8rBFxEq57WhAVQKOEDJAfYC01actT5ea1sFp1V+oEYRUA5p+XDDftOmIMcxs78hfnzuaoYDhYhmFB+RsbSVCQGZDfWoTtIlfcOiQSV122UH9pv4pbjwNQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnDQZLiZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750749656; x=1782285656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HvSZSrdL1NnkCo3Suic53nwcH+R7YoRUxgYQYmv+rkY=;
  b=bnDQZLiZ/puPxH2BTMN60LV8OIrg91lSvnKE4l3tvp9TYQWEAb+oc5Cl
   efURaY/Rv76PYo9IGkJgQ+xQ3e8Z7mafNsTDh14z+xzzDMJxia1ougZjo
   wW3aTsFKkrUWYhJiecTWTLoagCprXpdyW/UYBRBVMt5XcRc5/Ht4AaJgC
   M4vSqQ3rBkkYxpSi6gRb1HkPwlP8erNCJ4j9gXwqXX2khMP2cmpl4PG1y
   hC5GZNPEbgmW6nJ1Zq3eyjNo0bBAcXFmE5VK7QAXp84+72HeOPQlwI4ht
   nnHSrAbGoUJH4C7K8cV2P6IbaOBIyixMxJ980e8ouDFGmTZKcT49nWCs+
   Q==;
X-CSE-ConnectionGUID: /+4/nAcTRweoGK4nYie56g==
X-CSE-MsgGUID: bn3SL3GSSmu+RnOU+qckCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53047842"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53047842"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:20:55 -0700
X-CSE-ConnectionGUID: tjwPEGqZRY24kUuNOWrP9g==
X-CSE-MsgGUID: +rYwwwFOSsO/6xuhAWIW+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="156407388"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:20:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTxxX-00000009P4j-3x8d;
	Tue, 24 Jun 2025 10:20:47 +0300
Date: Tue, 24 Jun 2025 10:20:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/9] iio: adc: ad_sigma_delta: use u8 instead of uint8_t
Message-ID: <aFpRz9GtlEYn_UoF@smile.fi.intel.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-2-0766f6297430@baylibre.com>
 <aFj5eEvn2uw_HSl0@smile.fi.intel.com>
 <CAMknhBHuJY=8rxgJsMhvRNxZskmPhEZc1jJMQnHzQHFFoucWRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBHuJY=8rxgJsMhvRNxZskmPhEZc1jJMQnHzQHFFoucWRA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 23, 2025 at 03:48:30PM -0600, David Lechner wrote:
> On Mon, Jun 23, 2025 at 12:51 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Fri, Jun 20, 2025 at 05:20:08PM -0500, David Lechner wrote:
> > > Replace uint8_t with u8 in the ad_sigma_delta driver.

...

> > >       unsigned int reset_length = sigma_delta->info->num_resetclks;
> > > -     uint8_t *buf;
> > > +     u8 *buf;
> > >       unsigned int size;
> > >       int ret;
> >
> > Wondering if in the cases like this we may make it to be reversed xmas tree.
> 
> Fine with me as long as Jonathan doesn't mind the noise since it looks
> like I will be doing a v2 anyway.

I mean the cases when you touch already the variables and this won't be any
*additional* churn to what the change has.

> >         unsigned int reset_length = sigma_delta->info->num_resetclks;
> >         unsigned int size;
> >         u8 *buf;
> >         int ret;

-- 
With Best Regards,
Andy Shevchenko



