Return-Path: <linux-iio+bounces-11296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668429B0A04
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077681F24D56
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD31865ED;
	Fri, 25 Oct 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEXPZ4hb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0F21A4C6;
	Fri, 25 Oct 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874072; cv=none; b=GbDjRtQ0zFMUvmsOcOS+gQegDvMTDdoD1cJBjW5AQAF/c23AsNJ88KO3gzOtjFQvxFxv78D93zdTTNk3NBSrAQQpUNYK2INbYKLcZJTKrBEeBLVbLMKwGWRt0KiJGgGEYw6gWA72u7WCgMXSMVLOt8o/UdHsOGl8QjffQ9+tnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874072; c=relaxed/simple;
	bh=aoQYr9SwzE3Hh7ivMcztmJbV+wNBFckz5/+ej30kNPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkdlnRpTJ6CFzkx3VMMKKLJT/8UuO3YbT+y77bZzxAQWu7/ZZBZudXIb/bOkesE8njGZxaOwd3G+M3691aQ9xAT5dT999jfIooIIzbAN0ET0pzJQmzBVJeUEiUC9VJZt4VnoQO5jR66RliQvHfGHrg+8jG023p0lWLP3W33d+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEXPZ4hb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729874071; x=1761410071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aoQYr9SwzE3Hh7ivMcztmJbV+wNBFckz5/+ej30kNPs=;
  b=kEXPZ4hbk6ut4WAVxGBB09rt+889glFQNT2QmAChPM90/ktoQlL6EZ46
   lv8i3JvA0LFLZBrBtRJD5kCYcdd1FXlCcyJTSuPqBzEyQbSepTtMWtWFD
   dKf7fPBNFaVp6iRwAVR+sseQrvBirtoVyGg6E711cNTmFaOVN+mkx0WuS
   C/0b6FIdCNgGsu0Ow3cLP5/aIbYR4keMjPACnAAEKOGWuIXoQEsVB/1Zb
   INMFGE6GSZbUrq7C/1ikIvo5ArKt6AVbNp+M/LcT7APAkpjZ8kW9u6R0l
   wZT9lVbP/sCh9d/ouNsqLgZrdszoNeT31yBNrbWWqOu32BcJK58RR12DQ
   g==;
X-CSE-ConnectionGUID: 2xzWLM/OS76yGeKHSTPWTA==
X-CSE-MsgGUID: nm23BlqxS/SzMha17y0CyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40136580"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="40136580"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:34:29 -0700
X-CSE-ConnectionGUID: EhgeUrP2RXev4iTUUtlvYw==
X-CSE-MsgGUID: D8V9tO9oTlGrEXwHSbVTbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="111789049"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:34:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4NGY-00000006yid-2RbM;
	Fri, 25 Oct 2024 19:34:22 +0300
Date: Fri, 25 Oct 2024 19:34:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justin Weiss <justin@justinweiss.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>,
	Alex Lanzano <lanzano.alex@gmail.com>
Subject: Re: [PATCH v3 4/6] iio: imu: bmi270: Add support for BMI260
Message-ID: <ZxvIjtopvUFmHe_h@smile.fi.intel.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
 <20241020220011.212395-5-justin@justinweiss.com>
 <87msiwm90s.fsf@justinweiss.com>
 <ZxfYq1Eo2xhVhIei@smile.fi.intel.com>
 <20241022203417.30971eea@jic23-huawei>
 <878quc194s.fsf@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878quc194s.fsf@justinweiss.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 08:42:59AM -0700, Justin Weiss wrote:
> Jonathan Cameron <jic23@kernel.org> writes:
> > On Tue, 22 Oct 2024 19:54:03 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> On Tue, Oct 22, 2024 at 08:50:43AM -0700, Justin Weiss wrote:
> >> > Justin Weiss <justin@justinweiss.com> writes:

...

> >> > I can't find any evidence of BOSC0260 being used, besides existing in
> >> > the Windows driver. As suggested in an earlier review, I added it here
> >> > to encourage people looking at this driver in the future to use the
> >> > correct ACPI ID.  
> >> 
> >> Are you official representative of Bosch or do you have a proof by the vendor
> >> that they allocated this ID? Otherwise we may NOT allocate IDs on their behalf
> >> and has not to be added.
> > Fair point. The provenance of the driver is a little disconnected from Bosch:
> > https://ayaneo-1305909189.cos.accelerate.myqcloud.com/ayaneo_com/download/2023/UMDF2.0_BMI260_V1.0.23_5ID_signed_20H1.zip
> >
> > Justin, if you have contacts at ayaneo, maybe they can confirm if the IDs come
> > from Bosch. Or maybe we can find someone at Bosch?
> 
> I've asked around a bit but haven't been able to find a contact at Bosch
> to help answer these questions. I also haven't heard back from AYANEO.

Hmm... Maybe we can grep for the added BOSC IDs in the kernel and see if it
gives any contacts / clues whom to contact, but I'm not insisting you to go
this way, only if you want to.

> In the meantime, I can reorder the patches to add the triggers and
> attributes first and leave the BMI260 support / ACPI ID additions at the
> end.
> 
> I'll include the BMI0160 ID (and DSDT) in the patch adding the initial
> support, since we know that one exists in the wild, and hold on adding
> BOSC0260 until there's a way to move forward on it.

Sounds like a plan!

> I'll also remove all ACPI IDs from the SPI driver since we haven't seen
> them at all yet. If we get clarification on the correct ACPI IDs to use,
> we can add it later on.

Since ACPI has the different resource types for these busses it's usually okay
to have the same ID in both, but there is no special requirement for following
or not following that. And taking a history of fake ACPI IDs in the past,
I would go defensive way as you put it here, i.e. no ID should be added until
we have a proof of them being used in the real products.

-- 
With Best Regards,
Andy Shevchenko



