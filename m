Return-Path: <linux-iio+bounces-23649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595FFB40696
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5A84E73B2
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75FC30BB8D;
	Tue,  2 Sep 2025 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMxAr+N9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D4C30C35A;
	Tue,  2 Sep 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823000; cv=none; b=r4zlKM4aXyV8jO5v83DmmVPXpqmBlVOa3aoF7uLyqEYkIPCUrc+0KziWbvEOC9I2zSM46RBQZ31lR/0tUrRsiCJjs6/W43wIqMajerFFnc/sVwyM9TpbYmvWHrqkOgfLjWGKy0qDcnc3kN2hn1YlxLasxBSv5giK1Xeb08eb7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823000; c=relaxed/simple;
	bh=ZDEfBItK5OVWEK7muhXSryNmSO0fwlQ1OYJ4jfJ/Hpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSWtdNRIIu2BzRhqq1XGiMlVm4Bekkm9VSC+cl0tW6LCU83boOKES4rfLzSNzkU3qPX/ZE4kF1ktu5RLqXhIyntzcVbGkZdQFKaFz2WjkkaUnHp8PgXNJsge3gdLD+NaCoGAOiSWWMWDCdX2o7RmoRuWg/fsSqklXvc9cyPHrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMxAr+N9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756822999; x=1788358999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZDEfBItK5OVWEK7muhXSryNmSO0fwlQ1OYJ4jfJ/Hpg=;
  b=IMxAr+N9YAcU2pCKJJhsGwdSptia5OgEIaQpDx7CQ6joT56+lGuzfC3C
   rWid1t71Xbo+4e6Vc00vQrLIRDxpotlNCTM1KAL+c5imzSAYcplobRDEt
   OJTIejNzHLgJfH1a30WG+G0E+ylKVzqx5nWrAzSiWjsIxE0kxrS7NSd7m
   6ARI5teHo69zuPV5dqRPBSb17BjKd/0sdLBO2NUTOmKe3ctlOcHJ+gG9a
   AfIL+ok/9ner/5guWjzL2a++7xKuqKiGQ+gH/re3V6wkJ0s7gFUk0odxg
   pK+SKBoRLeb9R6ZaK/mito3/4Zjq4sAUo0qCuvIluauMEy53ww+BEGvM9
   Q==;
X-CSE-ConnectionGUID: J/NLH6DlRbelfFsXWjmNew==
X-CSE-MsgGUID: cBu16YW7TheEa4cnrMPKDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81682080"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81682080"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 07:23:17 -0700
X-CSE-ConnectionGUID: 3IHK/4YAQIemMMCw44phpg==
X-CSE-MsgGUID: CyQ1gDCORhCe2qmXX3ha6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170861201"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 07:23:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utRug-0000000AiNo-13oB;
	Tue, 02 Sep 2025 17:23:10 +0300
Date: Tue, 2 Sep 2025 17:23:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v10 2/2] iio: adc: max14001: New driver
Message-ID: <aLb9zgkE0TVZiOmp@smile.fi.intel.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
 <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
 <aLb0_TKn96nGbk6l@smile.fi.intel.com>
 <0cc072ab-dbf6-40fb-b753-13453b904974@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc072ab-dbf6-40fb-b753-13453b904974@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 09:12:08AM -0500, David Lechner wrote:
> On 9/2/25 8:45 AM, Andy Shevchenko wrote:

...

> >> +	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");
> >> +	if (ret < 0) {
> >> +		st->vref_mv = 1250000 / 1000;
> > 
> > (MICRO / MILLI)
> > 
> >> +	} else {
> >> +		st->vref_mv = ret / 1000;
> > 
> > Ditto.
> > 
> >> +		ext_vrefin = 1;
> >> +	}
> > 
> > And with deduplication refactored code:
> > 
> > 	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");
> 
> 	if (ret < 0 && ret != -ENODEV)
> 		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
> 
> Most errors should be propagated, so we should also add this.
> Only -ENODEV means that the supply was omitted from the devicetree
> and we should use the internal reference voltage.

Good point.

> > 	if (ret < 0)
> > 		ret = 1250000;
> > 	else
> > 		ext_vrefin = 1;
> > 	st->vref_mv = ret / (MICRO / MILLI);

-- 
With Best Regards,
Andy Shevchenko



