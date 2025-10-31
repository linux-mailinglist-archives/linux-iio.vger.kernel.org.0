Return-Path: <linux-iio+bounces-25727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEBC244A3
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 10:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD9DA4ED4A6
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04C334689;
	Fri, 31 Oct 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Grj0I0sM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05D333443;
	Fri, 31 Oct 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904481; cv=none; b=JpVOiigNuUBhF8IUlhBDL0K/w+Bly4G0h6VeQ184pDKyGiiWh+u9oZQOS6RRNFLokuPi9+lTqx3iKI3ThawxPP8pj20ZPgIURVKeeZ3fe/R0JAsZSNZdUnSLQ84EllrS2/0A9bnJgrBW1j3cyQFTAGZGYdDqzt+ezoI3UEdPTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904481; c=relaxed/simple;
	bh=v6cA50shDse4b25yyBe2a2iAc/jDGF6aKsH7khX41VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywm0b8KOu5SRTasFv14YJmKmoJp5m8UuwAy2AYlEwD9diyGeKGdGGVPHTJrIjaR1rtcXFy0Bfc+6swUUzwPpjqFEsduoYsJHtTIPLYU94CaSydeLLwV5RU3ITPc3xJp/kG0OaAWKbMJN5xV4bvErsMdT7B7pktOV7z9udRtwdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Grj0I0sM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761904479; x=1793440479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v6cA50shDse4b25yyBe2a2iAc/jDGF6aKsH7khX41VA=;
  b=Grj0I0sMvvIaOfT+6IDF8lVlw+SD/6Nl2TMpObur75Ks1K+IoOoXFJ5K
   iMpLoAF5+8dThjMaBif2Njg14A0ALeZDzLXVVkLWp/sgkTeyxlPRHszp5
   YMO/qUMfqZsblXZ0eT8QAzBjZCtqZXgA/dHQYQwKrAY8ZJsTkDHvBJTzy
   Adw9/+DD2AOMpXNF2jlBEbwxxO6dJjmn85LKgBh50pSUubrWzcTwDE+K9
   RGgiFVAMQn5nyWJuETVoeOUsR4rRtZYvDRYG6CrfqDKLx5VqpQqJ8S1PB
   WnLffxngH6PL+Fv0Du4KlETWZ+8VnYal9cd2wskBFBPYvbGxWFBBysDrZ
   A==;
X-CSE-ConnectionGUID: BFArgXLQQguUVaupAAJtng==
X-CSE-MsgGUID: 4QptMlgiS9ez/2NBA5rnxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63269853"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63269853"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 02:54:38 -0700
X-CSE-ConnectionGUID: rjQq+IrBQB6lTHj3dXT+ug==
X-CSE-MsgGUID: VUcsmbyoRhqWiLd9scZVdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="191343912"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 02:54:37 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vElq3-00000004EGH-2YMt;
	Fri, 31 Oct 2025 11:54:31 +0200
Date: Fri, 31 Oct 2025 11:54:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2()
 with ilog2()
Message-ID: <aQSHVsWGXzigTEMe@smile.fi.intel.com>
References: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
 <20251031094336.6f352b4f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031094336.6f352b4f@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 09:43:36AM +0000, David Laight wrote:
> On Fri, 31 Oct 2025 08:45:00 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> >  		tstamp_scale = sensor->sensor_info->tstamp_scale +
> > -			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
> > +			       ilog2(NSEC_PER_SEC) / ilog2(10);
> 
> Is that just a strange way of writing 9 ?

Why? It's correct way of writing log¹⁰(NSEC_PER_SEC), the problem here is that
"i" people do not think about :-) But we have intlog10(), I completely forgot
about it.

> Mathematically log2(x)/log2(10) is log10(x) - which would be 9.
> The code does seem to be 'in luck' though.
> NSEC_PER_SEC is 10^9 or 0x3b9aca00, so ilog2(NSEC_PER_SEC) is 29.
> ilog2(10) is 3, and 29/3 is 9.
> 
> Do the same for 10^10 and you get 11.

That code looks like working by luck entirely, TBH. I just took the scope of
the patch to start dropping const_ilog2() usages.

-- 
With Best Regards,
Andy Shevchenko



