Return-Path: <linux-iio+bounces-25754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C20AC254CC
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 14:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4078B463C7D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1B2236EB;
	Fri, 31 Oct 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWhklYVN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEDF34D38C
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918210; cv=none; b=fzS03BUOvrRJqzcUHH+8eaITjEX4Dv0/HevL/4nGYeprjxQ/PAkyGOGxB4a8PSapIKelsEk2fl3LocSWce5nT+3WkWOiiN2hhI3Y2fzCAvkEpfv9KRdf3QeoL+jJW5m5IGP4Tlq6RYLpQC3IzCnpnxSPLfk77WNKXE1g/nhSBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918210; c=relaxed/simple;
	bh=JzO4jRuCdS6MQ1MThONeQY+A08CVmKJv5LfaqjZj/vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXM6QW9fqayPKbWsSwMbTXEwQbzOBhsGBfquL0YReUcKCOhkIduYWGWq61zb8O+t+b/3b/BasLmSQVj4velrtRclzMZBFZLsWx5e+5zPDFNeW5inzXIQ0Mrs7kj1U20ZOI+cUZCcdYDzU2vvMj9FU9itAX14TjX8dtUtc2Odp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWhklYVN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761918209; x=1793454209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JzO4jRuCdS6MQ1MThONeQY+A08CVmKJv5LfaqjZj/vM=;
  b=dWhklYVNtWYOrN/L2Fx7DYPWKmvJhhdOi86oR3iAVrClK0opmqY48yXZ
   IRvjAG7a8y7HLOXu//ovW6Nc/szDExZTeFwiRRAKJclWECHWxwFTPJJVr
   rRpRhQzoOiSC7DoGW6mYlwH2OW6rlz8YMQ/Vuf5t8iEQOL6DywJWV+Uao
   d7yaNUjU1I9QTGoEd7YL+CcsXAt3xecdQQglbaEJtjrlXMsJ8xK2winab
   dkMOr1xn2OswBeQ41JXfFWGu8QKUpw8ogVZXnPaik8EgPOmcYSJLj4sfY
   72Q6qy2kKMdWC278LvvZcg9fw0csboBHoVViiRw+Nm5IDFqqtXRQbIkHT
   w==;
X-CSE-ConnectionGUID: 32FNI9DVSj6+1jDxZFPn6A==
X-CSE-MsgGUID: O7qfv0xBQOy6XPGTMwpbcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67734958"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="67734958"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:43:29 -0700
X-CSE-ConnectionGUID: Gc84obdXQLSCtD34rgH1+Q==
X-CSE-MsgGUID: 3TvehwTpSGK2V1Y9vzPWqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="209805189"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:43:27 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEpPX-00000004HVq-1RRN;
	Fri, 31 Oct 2025 15:43:23 +0200
Date: Fri, 31 Oct 2025 15:43:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 03/10] iio: dac: ad5446: Don't ignore missing regulator
Message-ID: <aQS8-tlbeHSD4sWz@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
 <20251031-dev-add-ad5542-v3-3-d3541036c0e6@analog.com>
 <aQS8OjeWFPtLRHAZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQS8OjeWFPtLRHAZ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 03:40:11PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 12:31:24PM +0000, Nuno Sá via B4 Relay wrote:

...

> >  	if (ret < 0 && ret != -ENODEV)
> >  		return ret;
> 
> Not exactly for your patch, but the whole chain can be refactored as
> 
> >  	if (ret == -ENODEV) {
> > -		if (chip_info->int_vref_mv)
> > -			st->vref_mv = chip_info->int_vref_mv;
> > -		else
> > -			dev_warn(dev, "reference voltage unspecified\n");
> > +		if (!chip_info->int_vref_mv)
> > +			return dev_err_probe(dev, ret,
> > +					     "reference voltage unspecified\n");
> > +
> > +		st->vref_mv = chip_info->int_vref_mv;
> >  	} else {
> >  		st->vref_mv = ret / 1000;
> >  	}
> 
> (assuming ret is never 0)
> 
> 	if (ret == -ENODEV)
> 		...
> 	else if (ret)
> 		return ret;
> 	else
> 		...
> 	if (!st->vref_mv)
> 		return dev_err_probe(dev, ret, "reference voltage unspecified\n");

Yeah, we still need to alter ret here... Whatever, just give a thought on it, maybe
you can up with something more beautiful.

-- 
With Best Regards,
Andy Shevchenko



