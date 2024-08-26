Return-Path: <linux-iio+bounces-8795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2928195EEAF
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D44D1F23069
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266C14A4E1;
	Mon, 26 Aug 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4eiOgzW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9D1482F5;
	Mon, 26 Aug 2024 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668969; cv=none; b=Zvk2Xp4095MLf7mYmX/GUcxXGy9LG+FcEAMVf1LPv+HOZHPVZ9Tua43r4Xx/qoZidb691x9WHZdQyRTYCDwDyGc6pbiR04lmB3fAZ6G8BQsVm+GOv794NgE6bcFrtczXzmyVO8EHM2m8oRqdpkKltU2owy9eY+r+8olRwqLnxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668969; c=relaxed/simple;
	bh=9dh5giGN/NKD5kz5JVWSuqtsglWlEf+AhSpHcdrDvo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKeZDeKW6oh67fN7aZgMOI20eOub4wUFizq+7RupjSP5OtR9LTeJWrTJd7SG0cGy1Q6ixMmcf22ZCHhz6t6lfN7N3trPHEwML2QxAYjB9WNU5QYG6mUmEERlfFKXwXN7hBR4DY/UidxnxMuS4z8Gn841EWhMESsfE8/0MHQh1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4eiOgzW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724668967; x=1756204967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9dh5giGN/NKD5kz5JVWSuqtsglWlEf+AhSpHcdrDvo4=;
  b=a4eiOgzWSPsuRgotOZ7Oqm4qMa9tAdaKpyI3I7g4Z92YMYLhbG93XpO4
   d5SKT70YIMUzgDGR+x1tXVOWmB6SiyYR4oJ91g5/gqPWidgQVwZsTxU2n
   xQbQh+oYrRkGNjKLQkZw5kGSLL28/RjJHT4H3TI3j9yaMzCZufUlkztYb
   MJUs59/mTQYqbxyOxaUqd4TyeP/l085cmErApYfaAMd/N6cQseZM2rvq7
   Z1Kh4rMdgx5atx+/5UrPrA0mXvgKlflLSfinviUENJvlMKg/YcxQTPgYg
   JTuZ1k7rKe7m08iHKkUZySce4joYt1i2+l5vuZGm0hQaufrhCpDczkMrs
   A==;
X-CSE-ConnectionGUID: 47LDJakaSB+HjwOa8HPMgQ==
X-CSE-MsgGUID: pA+aHIfIS06u6fLILVAokA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="40588730"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="40588730"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:42:46 -0700
X-CSE-ConnectionGUID: sXCb1H7PRaCzD7fBLgSJow==
X-CSE-MsgGUID: Y9Qaky/tTGOdfRzCXeP2UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62624159"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:42:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1siXBG-00000001psm-47Zf;
	Mon, 26 Aug 2024 13:42:38 +0300
Date: Mon, 26 Aug 2024 13:42:38 +0300
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
Message-ID: <ZsxcHv9RzzKkadoa@smile.fi.intel.com>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
 <20240819-ak09918-v4-1-f0734d14cfb9@mainlining.org>
 <20240823193203.7772a6b0@jic23-huawei>
 <Zsje0_gd41N1P0eE@black.fi.intel.com>
 <20240826113920.092d9ec7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826113920.092d9ec7@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 11:39:20AM +0100, Jonathan Cameron wrote:
> On Fri, 23 Aug 2024 22:11:15 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Aug 23, 2024 at 07:32:03PM +0100, Jonathan Cameron wrote:
> > > On Mon, 19 Aug 2024 00:29:39 +0200
> > > Barnabás Czémán <barnabas.czeman@mainlining.org> wrote:  

...

> > > > +	/* Let driver to probe on unknown id for support more register  
> > > Comment style wrong, I'll fix it up.
> > > 
> > > With that tweak applied to the togreg branch of iio.git

> > > > +	 * compatible variants.
> > > > +	 */  
> > 
> > There is another one also wrong.
> > 
> > +	[AK09918] = {
> > +		/* ak09918 is register compatible with ak09912 this is for avoid
> > +		 * unknown id messages.
> > +		 */
> 
> I think unrelated to this series, but nice to cleanup.
> Patches welcome :)

Sure, but I leave this to newbies to have a material to exercise on.

> Or it I get bored, I might do a scrub of the full subsystem to get everything
> in the same style and not provide incorrect choices to cut and paste.

:-)

I believe we still have more interesting cases, than white space cleanups.

-- 
With Best Regards,
Andy Shevchenko



