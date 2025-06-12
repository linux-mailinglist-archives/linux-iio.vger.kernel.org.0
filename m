Return-Path: <linux-iio+bounces-20545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0CAD709F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537C83A0A8A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78B01DF754;
	Thu, 12 Jun 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cek8NItr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50762F4326;
	Thu, 12 Jun 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732074; cv=none; b=XEUKw0T4h4u3pLR+8XstPPcfJ3U+v7HzPCLfroB0VbjugXSQEs2tVq7GYebS5JanbGkuUDclJKoi0nH5qbBzP37l2/zSI8m+8K/Xu5bjRD4eaoPcZIhO4eHKQHKU3T8Eu7QRHoQL5tEolNAihSC1G12e3MMD9G/7v1mjHqTxQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732074; c=relaxed/simple;
	bh=GPx47ZNv+igRsgoY9s4VuSgva7jzA22yGk+M8NK0yYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyXrUK1pkhLHl/ti7NhJ4ca/xe3zbWaD6iBZRP9hDyoRqsxRmCKXVSoQywjXpkxcE1XiALQFlpK9mi3KywappJAOztlfw36ZdkKkU0HQvQQkTogst9wQ6My8RBwmLlC4jFgBZMcQnchwpTN3bzaXBlw6epPWl1nAqxC1irPbdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cek8NItr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749732073; x=1781268073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GPx47ZNv+igRsgoY9s4VuSgva7jzA22yGk+M8NK0yYI=;
  b=Cek8NItrX8Kxm1ZKPVXzHsFkIEDYtTatulUSyOInefYS9BQJfem0XdTI
   4NlAh6fEOT7TOphXP45uYPrGYoFo6n5Cs4p29gGeKir/QWaZunwGYJ2VS
   3bNxhfTop8LGBuM0j9MiY42Lelnnq3UhQAu63iVneB4i47YkgmRUmjjCu
   +TIJWer9oqykU4JAfTSvG8t3SOO3G/Agu3d3esrISfmGWE0Y0/JIquVY3
   mpMPdm+qUBA7tu3Dg0nLaSRN8sEXz2SG0J8pqzo7WpQqMOeersUH/kKbq
   JB0x1/bFlFcHyG0z4rarCK3DJ+3dzCbB/YMcV5Nkqf6Wga9qBVny+hQ3v
   A==;
X-CSE-ConnectionGUID: yBSG3Ni0SS+YIaGZ0gzvKw==
X-CSE-MsgGUID: dh+klCrGT5eWlLgJ6RMifw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52004976"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="52004976"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:41:12 -0700
X-CSE-ConnectionGUID: 5Nu0z7AXSn+5oHtdzU0yBg==
X-CSE-MsgGUID: Z9bB9wIETAKpC+I4MQv6nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147388494"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:41:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPhEw-00000005wzH-3wGa;
	Thu, 12 Jun 2025 15:41:06 +0300
Date: Thu, 12 Jun 2025 15:41:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <aErK4ij3I83ETw-X@smile.fi.intel.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
 <aDz5WoBFlLiRptza@archie.me>
 <CAFXKEHZQZuKYS-DJ_KSmHzEO7OAGmKXCeEZ3VaLR-JJdb3Sw6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHZQZuKYS-DJ_KSmHzEO7OAGmKXCeEZ3VaLR-JJdb3Sw6Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 10:04:17PM +0200, Lothar Rubusch wrote:
> On Mon, Jun 2, 2025 at 3:07 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On Sun, Jun 01, 2025 at 05:21:28PM +0000, Lothar Rubusch wrote:
> > > The patch set covers the following topics:
> > > - add debug register and regmap cache
> > > - prepare iio channel scan_type and scan_index
> > > - prepare interrupt handling
> > > - implement fifo with watermark
> > > - add activity/inactivity together with auto-sleep with link bit
> > > - add ac coupled activity/inactivity, integrate with auto-sleep and link bit
> > > - documentation
> >
> > The series doesn't cleanly apply on iio/testing tree. Base commit or tree?
> >
> > Confused...
> 
> I'm sorry for that. My base tree is "testing" here:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
> 
> Since this patch could be applied, I guess it could be a good base commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=d4d10d3535639b946007fb7ffb5bff2d878df921

Don't you use --base when creating series?
If not, use it.

Bagas, you should refer to the last lines of the (cover letter) message where
should be base commit written. When you use `b4` tool, it does automatically
for you find the correct base, so one needs just to call `b4 shazam -M
$MessageID` on top of the clean vanilla tag, and it will do the rest for you.

-- 
With Best Regards,
Andy Shevchenko



