Return-Path: <linux-iio+bounces-21916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB6B0F6DC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484083A453C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBCB1DE3C8;
	Wed, 23 Jul 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRKRaDrr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BC2E5B19
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283834; cv=none; b=QE36SFV1dp1xvxyj6GDu9i2eraTHO75sUbN+lpc185rB09/SY7ihBL+kre4f+vYiHimb+tbOzSn4jB4FrZ+jshlHStl0tDgN9QxlFNKDMyqARJYgYVJIwHhoq/cy/ai1wALraSmytbqiRFZcg9IkKbZb36KUrwMfvKhWOKgFdgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283834; c=relaxed/simple;
	bh=R89cfYHClBdOw5qfbSx6ceV2IUZ8EDo+5S9PQnnhTSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWq1ssu2R8V1L29bECQfazPSQElNOKFnx87XJ4TGFVa/ViKoPfEg1KhcJoToLFSaKiky0oQnFEPTavnSX/6W0VOEo8ZEEYL6zyruSwGNMSxHWyP2Ox1agZtNiPpDbE0lzWexUK4yhzhf7WRfOmK+Jmt7+6O1pKcs794YcTveU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRKRaDrr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753283833; x=1784819833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R89cfYHClBdOw5qfbSx6ceV2IUZ8EDo+5S9PQnnhTSs=;
  b=eRKRaDrroVPzCFAinh+du15C4NTgs4QC2/ixtsnqx0ktiKTDgRKleHLE
   ZHqG6yChmNle6bdpaJyjousv8tyxvP1qVxAV0DVx8ybwyns8zgTZ+KmF1
   DeNgG1HPsfG0PdikTDhj09JDqUT1kQDUYAGKo0Y/P5gdgsF335bskgfTM
   jGZqJceJVV/o67w61rcoedBw2bNFFIhIaYMnlb47OYzZOjPWIb2DxLXXs
   Nm5G44WieI+i26ee8VbyWBHwfkKEP1knLGzQCrfCp22OZBi3nLiKAJsOj
   xfakSrbY10yXqsjexyVHdeJ1eK6UAVVTjDwyQDa4ciG60ZVL0gUsYRmR8
   Q==;
X-CSE-ConnectionGUID: LyX263IrSi+RFG/pupbs/w==
X-CSE-MsgGUID: LgCFVPs7SvmlAzfyYxQCjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55718919"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55718919"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:17:12 -0700
X-CSE-ConnectionGUID: PIz7BazTRaSVNdUb5FBe0g==
X-CSE-MsgGUID: 9+xL3FjzSbuiPicxHLkzgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163792080"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:17:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uebDP-00000000K7n-3stu;
	Wed, 23 Jul 2025 18:17:07 +0300
Date: Wed, 23 Jul 2025 18:17:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
Message-ID: <aID88zkMzDJsFywy@smile.fi.intel.com>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-2-hansg@kernel.org>
 <73409000-c68b-4c22-966e-aaa56ca3744b@baylibre.com>
 <94e006f6-0800-4105-92ed-626399ff62f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e006f6-0800-4105-92ed-626399ff62f3@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 21, 2025 at 08:42:36PM +0200, Hans de Goede wrote:
> On 21-Jul-25 7:59 PM, David Lechner wrote:
> > On 7/21/25 10:06 AM, Hans de Goede wrote:

...

> > Also, would just use MICRO from linux/units.h instead of 1000000LLU.
> 
> iio_convert_raw_to_processed_unlocked() uses 1000000LL, so for
> consistency I would prefer to change this to 1000000LL (dropping the 'U').

If you need a signed one, make it so `(s64)MICRO` (or whatever signed type you
want that holds it).


> >> +			break;
> >> +		case IIO_VAL_INT_PLUS_NANO:
> >> +			*val *= scale;
> >> +			*val += div_u64((u64)val2 * scale, 1000000000LLU);
> > 
> > Same applies here of course.
> 
> Ack.

-- 
With Best Regards,
Andy Shevchenko



