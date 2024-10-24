Return-Path: <linux-iio+bounces-11052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6719ADCFD
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5460D1F21BB4
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166C189BB0;
	Thu, 24 Oct 2024 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbaMdGCR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396617623F;
	Thu, 24 Oct 2024 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753305; cv=none; b=j1VcHRdnG/l2JzoItMuUvSxHegTPBYqMByNA3GLKhMghUJMvdlmaoiz1i1yXYRh3qtAeNYEnGseZQ+Xh0y9atwod2QUnkWmUVrG2Mb/+mjnRqqWPwz8kqf/wKxSYEEXEJaWg6SnjKmFFk1TY0jheL43ub4dfQ0oQ8cy1XtGizPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753305; c=relaxed/simple;
	bh=zJuO8LfaQvkp55X9u1k1lcwlOMehG39jXlnIzJQtNYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLIK2O0itNku6vKTmzK12ibn0E0SL/VQKMI1Xo0NZhVfsvzsY+otAjcHsIlPORybS1qNO1WjuHRpL4vj9xn2x2m0awK5noOxqyz1LKm3nf/LMDMck3Mfa3I3m0ICL0XAb6qhMAuUblg+NvrBTL2Q2K7PwIufZUGjz6Dq/ic0iKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbaMdGCR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729753304; x=1761289304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zJuO8LfaQvkp55X9u1k1lcwlOMehG39jXlnIzJQtNYI=;
  b=BbaMdGCRsmcRYAJxnVqXvi6gWaclX7uR1ALzLXDKn1qQeFnMX5LZxu5/
   e/NIVuaKYVOgUSpPSbTcsG03hsvheOv3wXAMBMGKHGi9ACOkhP5o4ak3T
   dudKgvVFhwe8fIipbXJl9UHhrWBlE3rX0+gSRQIlOxGUSpHUYfqjG8HcN
   GleBL2KNBpu/GzvNCX/0AK26dL2Xfs3hYjIdB4EU9oEW76QQxXzNPbht0
   TFeso6iIViY2l5cfcP4uG/azhFsKn5GAULedvmOyFHeJIn38cnIVKXnkW
   T/HDngOF19QSAvOlZoRkejqJArl5sGU1bRfdMTqKBQj4IzUP+9nliWEKa
   g==;
X-CSE-ConnectionGUID: Fw9q9hUgSiuw+tSkp/gvCA==
X-CSE-MsgGUID: M5DwRTl1Qz2kRwqf+ux0Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39980355"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="39980355"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 00:01:43 -0700
X-CSE-ConnectionGUID: g7Zf7rphQCKSTv1iM/8KTg==
X-CSE-MsgGUID: BjdgtSosQNSHOMAl3I7/2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80160958"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 00:01:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t3rqj-00000006U4F-3O78;
	Thu, 24 Oct 2024 10:01:37 +0300
Date: Thu, 24 Oct 2024 10:01:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Justin Weiss <justin@justinweiss.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Furkan Kardame <f.kardame@manjaro.org>,
	'Roman Gilg' <romangg@manjaro.org>
Subject: Re: [PATCH v3 4/6] iio: imu: bmi270: Add support for BMI260
Message-ID: <Zxnw0bZ5SRSYgzyr@smile.fi.intel.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
 <20241020220011.212395-5-justin@justinweiss.com>
 <87msiwm90s.fsf@justinweiss.com>
 <ae3213db-4edb-4fba-8f9d-c6f283735e9f@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae3213db-4edb-4fba-8f9d-c6f283735e9f@manjaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 01:40:50PM +0700, Philip Müller wrote:
> On 22/10/24 22:50, Justin Weiss wrote:
> > I couldn't find a shipping device with a bmi260 using the 10EC5280 ACPI
> > ID. Some prototype devices with the bmi260 may have used them:
> > https://lore.kernel.org/all/
> > CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/
> 
> The Arch wiki has some recordings of that. Most likely got fixed in newer
> BIOSs to the BMI0XXX coding.
> 
> https://wiki.archlinux.org/title/AYA_NEO_2021#IMU_(Accelerometer_+_Gyro)
> https://wiki.archlinux.org/title/GPD_Win_Max#IMU_(Accelerometer_+_Gyro)
> 
> On 22/10/24 22:50, Justin Weiss wrote:
> > I can't find any evidence of BOSC0260 being used, besides existing in
> > the Windows driver. As suggested in an earlier review, I added it here
> > to encourage people looking at this driver in the future to use the
> > correct ACPI ID.
> 
> Based on the BIOS code from the OrangePi Neo the default value was 10EC5280
> which got commented out and replaced by BMI0260. For BIOS v1.19 however
> OrangePi will use BOSC0260. I might provide a new DSDT dump as soon as I get
> the newer BIOS from the vendor.

Okay, at least that will be correct ID from the specification perspective.
Still, do  we have an (written) approval from Bosch to use that ID?

Anyway, that needs to be in its own patch with the DSDT excerpt and other
information.

P.S. And thanks for working on this, at least we are coming better to have
this mess to be sorted out and possibly preventing fake IDs from appearing
in the future.

-- 
With Best Regards,
Andy Shevchenko



