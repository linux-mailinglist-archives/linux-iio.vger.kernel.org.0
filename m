Return-Path: <linux-iio+bounces-9792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0198753D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE03287D6A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A6C13BC0E;
	Thu, 26 Sep 2024 14:13:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698267A0D;
	Thu, 26 Sep 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359998; cv=none; b=e3pPHQ9ivBeYz6ky3r3JVMgsUq3dGg2XmfTNiqVLWtp12ynQsBc/agZG/tQLhyB/s8wg95pb/ne3/3qkW6kV+jOtL4B74j1NTUBNJTRLqow5t1juRpKwTaCpsO3tAvPI1I3UTPbmv4C11PWIVY6z+feQwz2sfJexzqjnDwq16NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359998; c=relaxed/simple;
	bh=bUsqSxfTTdLhGI0lndn1enj7zbOey/NMjNPBHQSerzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXuig31wgmKrukxEu4ICqfftHR3BJzbMSwlxJcNozq0X80PdTj4PrdZ5oj4jL95ptUqQxJitHc9PcbLHq6Ja0EB/ShKhUdrSGggXhKYybvVqMhNz8HfYPsIy2/wcs013VbaUbr1URoIlTKbhhv4Ww6t99Z4Lbv3+VhlIDFNVLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: kDBfr1TMT5Cpe3oF3A4pNQ==
X-CSE-MsgGUID: iTGaCSmQTt+i90FxRWLSLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="14076020"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="14076020"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:12:58 -0700
X-CSE-ConnectionGUID: PLtiYzTVTteSXp/8UUONgQ==
X-CSE-MsgGUID: zzFgYcMWQlO6u4NhSnopKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76530400"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:12:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1stpEh-0000000DDfI-0sY5;
	Thu, 26 Sep 2024 17:12:51 +0300
Date: Thu, 26 Sep 2024 17:12:50 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <ZvVr4nu_UgsmyWnE@smile.fi.intel.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
 <20240926135418.8342-3-ramona.nechita@analog.com>
 <ZvVrsXrm8XBYGeRn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvVrsXrm8XBYGeRn@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 26, 2024 at 05:12:02PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 26, 2024 at 04:53:56PM +0300, Ramona Alexandra Nechita wrote:

...

> > +Description:
> > +		Reading returns a list with the possible filter modes. Options
> > +		for the attribute:
> > +			* "sinc3"	- The digital sinc3 filter. Moderate 1st conversion time.
> > +		    Good noise performance.
> > +			* "sinc4"       - Sinc 4. Excellent noise performance. Long
> > +			1st conversion time.
> > +			* "sinc5"	- The digital sinc5 filter. Excellent noise performance
> > +			* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
> > +		    time.
> > +			* "sinc3+rej60" - Sinc3 + 60Hz rejection.
> > +			* "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
> > +		    time.
> > +			* "sinc3+pf1"   - Sinc3 + device specific Post Filter 1.
> > +			* "sinc3+pf2"   - Sinc3 + device specific Post Filter 2.
> > +			* "sinc3+pf3"   - Sinc3 + device specific Post Filter 3.
> > +			* "sinc3+pf4"   - Sinc3 + device specific Post Filter 4.
> 
> I still think that a compromise to leave the existing values as an example in

> the existing bindings is a good to have.

s/existing/generic/


-- 
With Best Regards,
Andy Shevchenko



