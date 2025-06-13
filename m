Return-Path: <linux-iio+bounces-20594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A20AD8C9C
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AE81E2DB7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B30200A3;
	Fri, 13 Jun 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1Gq8nO5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC861CAA4;
	Fri, 13 Jun 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819272; cv=none; b=ZSFRf2+N9lhrzkDImMBBoskmZ1g4XCy1O96p8wyHKgnCvyDPQwwi6Yo/hrR64Oj3XTIwcIwn5/cHUfFYBCYDNhebwocL8W7DaXUv/zhTe0gnHpTzOpnp4BtpPyhPwZ90m8ybCBEGxjg6Mr25/rD9PNM2M2EzW/qReGJ31AAlBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819272; c=relaxed/simple;
	bh=I1quJrY/4Wb61BqLz3/Y0Rl043912WMh95rEDI9InB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcPasgENAkkgphlcu16ljapqCLOfAavevhtiE+MOwj+h8Knh+3AI+ySGNUFV5RvfY/vsA/xiQPihbdw1kdm8j/NZ/o3Z/41O2YKmthQzn6wIhGOzFh/5alBDWnVP7y3f9AoO5jfcnf1ClCGKK97HoRQRXOcCRR7sC0/iPPATfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1Gq8nO5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749819270; x=1781355270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I1quJrY/4Wb61BqLz3/Y0Rl043912WMh95rEDI9InB4=;
  b=D1Gq8nO581QT2E6tubueov8LgUxlIMhkAG0bYTmZCs4T0eONd/EuQkca
   S8YLrYOnIgVk8sOBlmyGl3zAuOcmbpvunViuAWD7IshZaiCpu6kmBoIv9
   Wfu2Fwy+HQo3Bg9ltYURLroYvaNpFQOiECnXjJSJ0tyuJrxNElj91adWA
   /XWbYLpnlXx/kGp0Ez+FjXV6NYJNNpZ5BocxNl+luAcEPGQDtON0bSIA0
   8hipfJb7Xjhqe9k4IdbEjEWj5ruUxRMulmbv2WDpMCMd+q0zlf3ZoKKFs
   bVCmykxnHWH5uSPzp3oG3Q6JWg3p0OEm60ePOE2hGbWttOIsp3Kr9a9eJ
   A==;
X-CSE-ConnectionGUID: l7cnL/BsQ5SsG3uE+Aw0ag==
X-CSE-MsgGUID: QFZZ7yL4S3O4QyohYOv++w==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52128328"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="52128328"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:54:30 -0700
X-CSE-ConnectionGUID: vyrE4TroS9K8ntiac2XJlg==
X-CSE-MsgGUID: 9PnAMZTjSPC0tZAR7Bkg5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="147667503"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:54:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ3vN-00000006FVN-0KZU;
	Fri, 13 Jun 2025 15:54:25 +0300
Date: Fri, 13 Jun 2025 15:54:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <aEwfgP3tiio52Rj-@smile.fi.intel.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <aEvhZiXHLLIRe41-@smile.fi.intel.com>
 <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEwfUMgLTnQxOh_k@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEwfUMgLTnQxOh_k@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 13, 2025 at 03:53:36PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 13, 2025 at 12:46:46PM +0000, Jean-Baptiste Maneyrol wrote:
> > >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >Sent: Friday, June 13, 2025 10:29
> > >On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

...

> > >Overall, looking to this patch again, I think it would be better to prepend it
> > >by replacing *int*_t types by the respective uXX ones. Because in this patch
> > >we add dozens of new ones which increases an unneeded churn in the future.
> > >
> > In my opinion, to respect the rule don't mix *int*_t and uXX types, it is better
> > to keep *int*_t types. If it need to be changed, we can change afterward the
> > whole driver types with a replace tool and send it in a separate patch.
> 
> It will be never ending story, sorry. We need someone to solve this tech debt.
> And since this patch adds more than 3 new users of it, I think it's a candidate
> to embrace the burden.

For your convenience I can mock-up a change...

-- 
With Best Regards,
Andy Shevchenko



