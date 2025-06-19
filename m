Return-Path: <linux-iio+bounces-20786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E0BAE0A65
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA6418830BC
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D1225403;
	Thu, 19 Jun 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnL++znr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26EE21E098;
	Thu, 19 Jun 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346632; cv=none; b=Jg+EXKYJFsvkI8Ev06OaWxMlzuUIPh/JruExpSo2MiQkStI9QUaODIBYzByZs3Cs8hDajYd+1VrOkeM3B2HK6YnY+qMN1TiPYyfiCpCOtFgiHRhyZB8533ixQ+5b+8egGobP6Z5uwRVTBXWoe4Me5VV1fWoOVw9Htl1QvBNUWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346632; c=relaxed/simple;
	bh=SAPSibnvoFkQAm2LXXJ23uVq+hOW9HO1Q+emB1Vxlmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY7E/KlZ3VGBnNmUpD+z2qHfzObgNDSuxsr9/ZHuCv6BNUpZmdkk6eldgGPHmkDEOYYqWphwz8zDhIGQbfrYqZxoz9QOOi1YZVjVA30nkMUiZXHTPL/xjfmz4KcVyn79daFdoc74/h+Qb9gbPX3BuISUJM7Tk+phWhalbijMtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnL++znr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750346630; x=1781882630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SAPSibnvoFkQAm2LXXJ23uVq+hOW9HO1Q+emB1Vxlmk=;
  b=BnL++znrfUjdZu9cIrUkQTZ9ft6uwtEp8LEpxC0hhQNFECCiSjWXCfEc
   7cJGreeQJ7/dM+R8YFg320v9T+4VztKnoTqgCkQpkBLV9jtry/xBlS8ze
   t18GJ0ppIUoZCx+DQ4lxRqqbSTE/ts6Ir6rpf48WY1L8Uc9yspWPEHydH
   s+NiDk6jXETC/Z3InmPT0hAL6ZVkoSsFcmeyO5oNAT+hrYym2rtn8UZJb
   SH1CdvKecYswJb+krmvEuVXl5E1jfVg+T8g7hACpZTNGZ9zOyhkvkXoeT
   F3hAemKfULmp3Novwtci8pWVXbcah/CEFNE68LNPlTtngooys656GukZy
   g==;
X-CSE-ConnectionGUID: N+pAGazjSgC08NG/EtmZ4w==
X-CSE-MsgGUID: zwFerSJ8Q3umNwnD72DCvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56423330"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="56423330"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 08:23:50 -0700
X-CSE-ConnectionGUID: mBayyjwIT42xD6bdlkqaEA==
X-CSE-MsgGUID: KWTdNev7QXe/q3ncIkseFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="151237289"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 08:23:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uSH7A-000000086Ta-2Ptv;
	Thu, 19 Jun 2025 18:23:44 +0300
Date: Thu, 19 Jun 2025 18:23:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	andrew.lopes@alumni.usp.br, gustavobastos@usp.br,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	jstephan@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] iio: accel: sca3000: simplify by using newer
 infrastructure
Message-ID: <aFQrgEw4zw9RSAO3@smile.fi.intel.com>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
 <CAHp75Ve4yAp6sViUWZY+0abRoNZ0W+rQLCmsbijEcrh8kguVOA@mail.gmail.com>
 <CANZih_S9_8OdY=oKyVPBCTSTqYm_z_rkE=xbPym3uHOSsHMv6A@mail.gmail.com>
 <aFL6PE-8KLLKZun_@smile.fi.intel.com>
 <CANZih_QeeA_G5mFOAb=TMNYiR4eo9SUD5iW1G-5LBGL27NpTRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANZih_QeeA_G5mFOAb=TMNYiR4eo9SUD5iW1G-5LBGL27NpTRw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 18, 2025 at 03:20:06PM -0300, Andrew Ijano wrote:
> On Wed, Jun 18, 2025 at 2:41 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jun 18, 2025 at 09:24:19AM -0300, Andrew Ijano wrote:
> > > On Wed, Jun 18, 2025 at 2:56 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Jun 18, 2025 at 6:17 AM Andrew Ijano <andrew.ijano@gmail.com> wrote:
> > > > >
> > > > > The sca3000 driver is old and could be simplified by using newer
> > > > > infrastructure.
> > > >
> > > > I haven't found any reference to a base commit here. Have you
> > > > forgotten to use --base when preparing the series?
> > > > In any case, please clarify what this series is based on.
> > >
> > > Thank you for pointing this out! I think I forgot to use --base for
> > > it. In this case, should I submit a new version of the whole patchset
> > > with this information or is there a better way to do it?
> >
> > For now just reply here what is the base. I asked this question above.
> 
> Ok! No problem. So the base for this patchset is the commit
> 3c23416f69f2870bea83697d7ab03c6a8497daa7.

No such commit in the repository. :-(
You are doing something interesting here [1].

So, make sure you are based on the iio/testing or so, make sure that the base
commit is the one that may be found on git.kernel.org. Use that in the next
version. Due to above this version is ambiguous to even start reviewing it.

[1] I have connected IIO subsystem as a remote, so I have access to many trees
from kernel.org (but not to all of them).

-- 
With Best Regards,
Andy Shevchenko



