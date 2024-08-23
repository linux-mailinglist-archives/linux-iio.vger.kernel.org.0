Return-Path: <linux-iio+bounces-8734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43F95D5E3
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 21:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC9DB216B2
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5CC1925B3;
	Fri, 23 Aug 2024 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ct4zG9vK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0021925A1;
	Fri, 23 Aug 2024 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440281; cv=none; b=cFf7IEu2I/QIJl811XBkWbJSZP2kYc5RUHzBzCh7V2GeLYEum0UhF/aKLJy6eoGcUzPStbQVYI7nQ4KyWPRDEe2oxQ5NiFtaW2BgCETxRsMe1mBazNDxWHkLHO3tr5qOhnv0wFymUucL8UXDztv95z7jTGYr0vTL3eI+NMNlxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440281; c=relaxed/simple;
	bh=0xul+mPNDqvXZJx6aYvZntkRM//3GEL2r5uhTzfrWL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGzEP0ea/766DLIhxyQkZ9LktDWZVGRv/UsaqpehopcEy/dIVXn7uwWfOIE9s49DAqNKq3ne3PokH6G5Cz6lpdAd2Ij3fig6wcO1Gyt9MyNbnT9de4lc8/l5gJMvtA9o+IDGkGSfPRdKQxgZEatkHucg5ZFSzPNYzbBD7TyeTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ct4zG9vK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724440280; x=1755976280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0xul+mPNDqvXZJx6aYvZntkRM//3GEL2r5uhTzfrWL0=;
  b=ct4zG9vKuyddSxd2hZae1duHlTWIbO3g+d0cndWS7XQCv3hdu9zGsrbe
   2RlVp5/JvxvCGY2eykVr6hZG43e/6pinHjZOCwcr5KXtsOqTYtLm96gl3
   IyqJ1vBU+5BhxPxYi/R0gG4gn+pHjubDoem3JimwJL+3BoJvlvtLg/9Cy
   HMBktqAfGzpv7NPwiOa2VmcfrPr3tDRWnfkw2JV2uaL9wU0VeblzFuUqy
   bgVCtfBoS+9+b2uZpebukUEdUorFFCoQ/AudigtdFxAbTc7fgW0b68t0m
   q8Ar/9b3CzKK8xEsjUuRFC6g2pabLZqmjB70qlUoJHG6JBTA+igECknE/
   A==;
X-CSE-ConnectionGUID: BfO/ylP0SsWN4EHyhgScHw==
X-CSE-MsgGUID: D/iwmg9oRmqmyu533J+F/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26795279"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="26795279"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:11:19 -0700
X-CSE-ConnectionGUID: C4ySPsprRA2NpXrcAEXuWA==
X-CSE-MsgGUID: 3UlZOUJJQim8P/a81e66SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="66201999"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2024 12:11:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4232F209; Fri, 23 Aug 2024 22:11:15 +0300 (EEST)
Date: Fri, 23 Aug 2024 22:11:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Albrieux <jonathan.albrieux@gmail.com>,
	Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux@mainlining.org
Subject: Re: [PATCH v4 1/4] iio: magnetometer: ak8975: Relax failure on
 unknown id
Message-ID: <Zsje0_gd41N1P0eE@black.fi.intel.com>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
 <20240819-ak09918-v4-1-f0734d14cfb9@mainlining.org>
 <20240823193203.7772a6b0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823193203.7772a6b0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 07:32:03PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Aug 2024 00:29:39 +0200
> Barnabás Czémán <barnabas.czeman@mainlining.org> wrote:

...

> > +	/* Let driver to probe on unknown id for support more register
> Comment style wrong, I'll fix it up.
> 
> With that tweak applied to the togreg branch of iio.git
> 
> Thanks,
> 
> Jonathan
> 
> 
> > +	 * compatible variants.
> > +	 */

There is another one also wrong.

+	[AK09918] = {
+		/* ak09918 is register compatible with ak09912 this is for avoid
+		 * unknown id messages.
+		 */


-- 
With Best Regards,
Andy Shevchenko



