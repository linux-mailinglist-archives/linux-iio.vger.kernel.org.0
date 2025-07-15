Return-Path: <linux-iio+bounces-21682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22469B0580F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DA93BFD70
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AEE2D837B;
	Tue, 15 Jul 2025 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9icJ8Xc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB61D9A70;
	Tue, 15 Jul 2025 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576161; cv=none; b=kGz0VWTQBOwzlyAhHwR52Z4hiYd+FQ6xUaCSfxJ09ccUlseVEZMYpmpAP85bVzzLECTWJrBsvaDdxQwuCx05vzLy+lOV/DVHotMXOqXo0qnhatny6etrdtezjtWiP5sfNXI9QYSqstupEV/g5QPsvP856GxAUM0bZ0BW/Fz9/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576161; c=relaxed/simple;
	bh=qPvGaKZPuwIuu9H/djUeWBfbuZULyNCjjRuj3wYvkwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT/kXdk8HNhmWqJ/r3ly/T/cVlNvy73VgiRV2R6xitVotfDddSaDkSUSeVihuVzrJSrAw2ROJe5qBFEOzyMqlHopUB2TjM4UbF6LT8tzorVeJi7CLtctMDmcUlJbvtlCI93SCI3ZeJ/c+DLDv5NNfIuS7xhLjre9tmziEcXqnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9icJ8Xc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752576159; x=1784112159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qPvGaKZPuwIuu9H/djUeWBfbuZULyNCjjRuj3wYvkwM=;
  b=C9icJ8XczebumfsqrngmAleLfW1ZPtclpPsu0HGYcLEgAQTJV2HS8w9H
   3YyPql/esGM7U1p9PIb2MtBdh9gYcayfY0noNwuVCLW9RdoddNcgjEGkq
   58aZovJ7wlyuophlKupXKGDGuzZob9dMA2e6g4Y6aAVdfsrH+EgJdW3l9
   T5NtCcN0R9UPPu09/lmQe04Xf6fIflpJjCVbOPXh0036Zdk8r7JX0Rfga
   tXkRD9aBOh4wMEo1fsf0qvBXc4mqcdCUrpKEZ62lrsbFHadQICd5Jz4R+
   eQ2zg4dcsQgDSPCLhqR11E9FhggpUDHSzIB/UeIb+PfYIiO0nZKdEElmc
   g==;
X-CSE-ConnectionGUID: c3yobWWxQlysfDzBE7vytw==
X-CSE-MsgGUID: QV1srw1nRvevSOhcO4z9cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58445765"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58445765"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 03:42:38 -0700
X-CSE-ConnectionGUID: dmjPbJpiSbiGp3SPSf7lKw==
X-CSE-MsgGUID: /JEWBtDaS7uWpRZYqR/N6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157730369"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 03:42:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubd7I-0000000Fckz-48BA;
	Tue, 15 Jul 2025 13:42:32 +0300
Date: Tue, 15 Jul 2025 13:42:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <aHYwmEv1sCI-qi0T@smile.fi.intel.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
 <aG-ID7O3HgVc1EOX@smile.fi.intel.com>
 <FR2PPF4571F02BC5366477EC02E9C44041A8C4BA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aHD7zEzvVuwSB9Ke@smile.fi.intel.com>
 <FR2PPF4571F02BC69DF6807BAA188B2B3A08C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR2PPF4571F02BC69DF6807BAA188B2B3A08C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 09:11:47AM +0000, Remi Buisson wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com> 
> >Sent: Friday, July 11, 2025 1:56 PM
> >On Fri, Jul 11, 2025 at 11:32:48AM +0000, Remi Buisson wrote:
> >> >From: Andy Shevchenko andriy.shevchenko@intel.com<mailto:andriy.shevchenko@intel.com>
> >> >Sent: Thursday, July 10, 2025 11:30 AM
> >> >On Thu, Jul 10, 2025 at 08:57:57AM +0000, Remi Buisson via B4 Relay wrote:

...

> >> >> +#define INV_ICM45600_SENSOR_CONF_INIT                        {-1, -1, -1, -1}
> >> >
> >> >Unused.
> >> This is used in later patch of the serie.
> >> I will move this definition to the patch using it.
> >
> >Yes, unused in this code. You should compile the series incrementally,
> >so each patch will get a compilation test. This is called compile-time
> >bisectability. Also run the system each time to confirm no regressions
> >(this is called run-time bisectability).

> Yes I did that for each patch, everything build successfully.
> In that case, nothing is broken due to this early definition of the macro.
> But I'll definitely move it to later patch for clarity. 

Yeah, the problem is that the (unused) definitions are not warned even when
`make W=1`. And I guess I understand why. We have tons of unused definitions
in the drivers that usually substitute (on whatever reasons) the actual
documentation. It's hard to catch for the definitions like this without reading
the code.

...

> >> It's probably safer to keep the delay even in case of failure to make sure
> >> the device is ready before next operation.
> >
> >I am not sure about it. Why? This has to be well justified as it's quite
> >unusual pattern.

> Ok I understand, the hardware needs that delay if the access was actually
> done on the bus (to not jeopardize next access).  If a regmap error means
> that no real access occured then the delay is avoidable.

Perhaps you need to have this delay embedded in the IO accessors? Also do
read _and_ write need this or only one of them?

-- 
With Best Regards,
Andy Shevchenko



