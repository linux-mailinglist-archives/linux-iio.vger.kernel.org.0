Return-Path: <linux-iio+bounces-5186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0A8CC3CE
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644C31F22E06
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 15:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09924B2A;
	Wed, 22 May 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8eE1/mp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4C22F0D;
	Wed, 22 May 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390483; cv=none; b=SySQKtm4XinClsFyKqgGjlTveXwzaD4aHSEnid0UuKUpC0F3RDO949ZUGvOysjVDJSPSQdSv32vblRS4FSTAtHSDVQqkfzuDHm5mI1MKYRPaF23e6/D8jBdpuEQ36DthsZYhc0KRBjm69SlWfcZZHNBt8CYG8FKQxBfUwV560IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390483; c=relaxed/simple;
	bh=PpZwJfjlRA2zGPwkwSl4YW9dyiXTZREZRpX0Vrwmr6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDGfD6J5Yn4fai7db81ZBRm8ykHjeJi1hSCtMjYxJHy8lMROH0nbR3M+NGNm7rDfz1yOOHW11Ohc0txAdLtDtetePguOgwpiPduGOI0EOVJyq+U2Z53zdF0K3NZUlUZKAZnxOtlqBpOvO+GDJFQQ4A9oYWOQYHRFwIBk9bn0w2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8eE1/mp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716390482; x=1747926482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PpZwJfjlRA2zGPwkwSl4YW9dyiXTZREZRpX0Vrwmr6Q=;
  b=k8eE1/mp39J/YmpqtQ9LaphY1bDzux2ZbeGmGdiwHUwiNxi7zN9wd7ja
   2BaHupOs4gvzEN3HCqNzaE/1DKjILSlC0dtlB2rvoO9iEfpFpPl0AWzCJ
   xq1WrUIF+imgSzZ4xzALRl49WKskU2c60KB19cUo7c3MOTudW9UdCU2CX
   x23/rZkeq+7U0KvhuD/hhRlidrUc5ViolO+UlZpCMmFnMKjDKi1gabSXL
   +uzy8HOC85FXr9waf4evAcJCjLiCU2nV/cFORhFE3Wt/xGuJdbApSqOcN
   tmx7otIvvSsvir+2LNQ7v5pTTPeg5hYylDMDDBS/FBzqfFZdr4Wkqzvg2
   g==;
X-CSE-ConnectionGUID: /zR2jcxeSUqRenXsgesckg==
X-CSE-MsgGUID: uIyE62anSniEfZZaL7MfLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12525513"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12525513"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:08:01 -0700
X-CSE-ConnectionGUID: G21mYBgcRDqZgfLR7pEdNQ==
X-CSE-MsgGUID: t6qIuYpyR866F9sRIsACQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33233067"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:07:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9nZK-0000000A0m8-3RXe;
	Wed, 22 May 2024 18:07:54 +0300
Date: Wed, 22 May 2024 18:07:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: adc: add support for ad777x family
Message-ID: <Zk4KSlZ7NFgYx2Co@smile.fi.intel.com>
References: <20240522120005.18197-1-ramona.nechita@analog.com>
 <9c19faf6ee186f144a705f458da83ea25f7a3a34.camel@gmail.com>
 <SN6PR03MB4320549F56148C13C4BDBBA1F3EB2@SN6PR03MB4320.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR03MB4320549F56148C13C4BDBBA1F3EB2@SN6PR03MB4320.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 03:01:52PM +0000, Nechita, Ramona wrote:
> Hello Nuno,
> 
> I apologize, I accidentally submitted the updated version that I used for the
> project, instead of the one without axi. I will fix it and resend the patch
> asap.

First of all, do not top-post!

Second, don't do ASAP, take your time, read the comments given for this version
and address the same / similar issues in any code you are possessing before
sending.

> -----Original Message-----
> From: Nuno Sá <noname.nuno@gmail.com> 
> Sent: Wednesday, May 22, 2024 5:36 PM
> On Wed, 2024-05-22 at 14:59 +0300, ranechita wrote:
> > Added support for ad7770,ad7771,ad7779 ADCs. The data is streamed only 
> > on the spi-mode, without using the data lines.

> Is this even compiling? This is definitely not code to be upstreamed since it
> relies on the our out-of-tree/legacy driver for the adi-axi-adc. You need to
> convert this to use the IIO backend framework (adding new interfaces if
> needed).

-- 
With Best Regards,
Andy Shevchenko



