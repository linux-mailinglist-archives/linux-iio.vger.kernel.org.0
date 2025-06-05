Return-Path: <linux-iio+bounces-20240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A252ACF150
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 15:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE323ACED4
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584027465C;
	Thu,  5 Jun 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epgr8JOB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F132741A4;
	Thu,  5 Jun 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131532; cv=none; b=QS9ri0LBLAft/xFeF3YBpXZL49CZPYzIhRNOD4CkGQUC+czlhsrXVUzvqCNe1MocI8cZOpPw7keU8VJ6eKTgiYVOQ88kkiXi2bxiLADUy6dxsuQiI9LPhFQSKdQUrC6Z/lD/N9ymzljfdAVibVgJe2J2ht+FoJM+2LhFqXaxam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131532; c=relaxed/simple;
	bh=OEi12Lmi5YITJkvxZt4IvCwmlqEWCmXok9rCvTypycg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueOfNpPZ60biLudq7lhMqT+u7K7cAdYwXIi6IPaNTf8sBdBSJ7w0YM+clCnyP0ge4eNmhmeW38xr4BbFyzjZ1YxhcdZqLTTLwmwSCgrHow8JWckPE/fsRMUhQ3spTwlg0LREQoEtjOlyJUmUNAi2CbwssPI49SgMwH4HrgHQYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epgr8JOB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749131531; x=1780667531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OEi12Lmi5YITJkvxZt4IvCwmlqEWCmXok9rCvTypycg=;
  b=epgr8JOBLQ+tBWq86j0i7nLhC8POYtHwtDAupvJOYUsFT9j47BnUrd8O
   DkZlkext23/BugGrggWHbNU2+ogPTW977nia+LFXgFKaqN6Uo3gJVv9Ls
   cIGANVmyAQYYOW4RAIWGEg1wo/S2df5JLbT4pOc6P5YpdF7eLTM7GExWm
   91NWGtscaYE+NU+1h1dOUqHaq2qKlPM3X/KrXkHUoDbBmh4gL9p7Y73CJ
   6DeZbJm5gOBrytTyd2x24X67cDtKM3GomF0W7zBrikw5/DHpdc1LLseAR
   jfXoMqCRoD79Z6ZM7DePlBN4dR/1xUOWBxPi57MHywN1QCfRhjqnTSyjN
   g==;
X-CSE-ConnectionGUID: FjlCWzh7TrqUd2eRXJK75g==
X-CSE-MsgGUID: ut46IR/YTQ653whvyvWigw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="61871057"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="61871057"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:52:10 -0700
X-CSE-ConnectionGUID: IhciTlgHTfmBlgMyd0MgSw==
X-CSE-MsgGUID: yV2MX031TjeT3OKJqwBolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="176476213"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:52:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uNB0k-00000003sSd-16ab;
	Thu, 05 Jun 2025 16:52:02 +0300
Date: Thu, 5 Jun 2025 16:52:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Ioan-daniel, Pop" <Pop.Ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
	"Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
	"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] iio: adc: ad7405: add ad7405 driver
Message-ID: <aEGhAa1a9GHPNQjH@smile.fi.intel.com>
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
 <20250604133413.1528693-6-pop.ioan-daniel@analog.com>
 <aEBlqPqxd0-C7j63@smile.fi.intel.com>
 <PH0PR03MB63350BE9DC927335D0FEBEE2D16FA@PH0PR03MB6335.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR03MB63350BE9DC927335D0FEBEE2D16FA@PH0PR03MB6335.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jun 05, 2025 at 01:42:50PM +0000, Ioan-daniel, Pop wrote:
> 
> > On Wed, Jun 04, 2025 at 04:34:07PM +0300, Pop Ioan Daniel wrote:
> > > Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> > > 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> > > analog input signal into a high speed, single-bit data stream.
> > 
> > Hmm...
> > Have you seen these?
> 
> Just a question for my clarification. 
> Except for comment from David Lechner, what should I do in the
> next patch that is different from this patch regarding your requests?

I believe those are generic advice, use them in any code you submit.

-- 
With Best Regards,
Andy Shevchenko



