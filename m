Return-Path: <linux-iio+bounces-25761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA663C25CA5
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EF0188AC14
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939A220F5D;
	Fri, 31 Oct 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kR0murrP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53951DD543
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923306; cv=none; b=HtFu1ApV93r/JZR2fhV4QdWLO9JQ7B3zzk7Tzu9Kx/6otno1WCgMmBYbPa0pfDHpu7CiPsBf7rJU3qzyOgylXwDg3OW20CSpsxw/GJjjGGTRe8/19sO6j/ja/qc/+0zpsq85RY9ULSimZr4WDThuUoLwR9NAPr576rDAZQyjwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923306; c=relaxed/simple;
	bh=djnlzVgOMsmSB/nqXGgvUll0Ew/fU2Sig1E37NvoEP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okPDz7Xx2BreB+cCOo/y95IZg+DH26XXts85KcPVHY2nIENHxdBAlfC3lOwuVSItDiEDYnrNzyk/AewScOQaYLVB4XnHbjp9o3bRR6+cRNIUAdaYqce4sbOyjsA16wx/NVfYHE07iU61tj1efnivNThPIJCi++fw12YGoihtNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kR0murrP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761923304; x=1793459304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=djnlzVgOMsmSB/nqXGgvUll0Ew/fU2Sig1E37NvoEP8=;
  b=kR0murrPPAnxHGbPTDskKineC1MHiytMqbHt+EwU9C05PMFa74cKGzYl
   swYM8nfhtDoyMKi+Ro5lckRIenum1hfGTXbby9UelP6EY6M6hYhps/M1f
   Pk2epQIgW3pyqa4IOHWHtXT0Bw5YSBAtwZoPcGF6CARTG11L9CE+WLSco
   72IkmZp5ONN++t4LUz39AR6d5vW2Bwl5fDVbBfxd9eYN96AyJ6ga9DXqb
   beuvyCFHIT49RBTuA1HsHjP5Rg8g+RKNlXlnYxCafAo/5e2RZwc5MvLNz
   nby6CCik8/9sQuqjsabEEOht1lw0dDbUan+DeFdXv7cjNcY1tPp0EiCV7
   A==;
X-CSE-ConnectionGUID: 7OQzDZtGSqiGDtW1r3KMFg==
X-CSE-MsgGUID: NKOcSP6DTY+3sIuuSJ2nnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63105584"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63105584"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:08:23 -0700
X-CSE-ConnectionGUID: HV3c+yEdQRKvuC55zenVpw==
X-CSE-MsgGUID: jg/uTV+JQ/ygxQGgnQ3Bqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190603798"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:08:22 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEqji-00000004Iw0-0H7f;
	Fri, 31 Oct 2025 17:08:18 +0200
Date: Fri, 31 Oct 2025 17:08:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 04/10] iio: dac: ad5446: Move to single chip_info
 structures
Message-ID: <aQTQ4Zn3W99ZZITL@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
 <20251031-dev-add-ad5542-v3-4-d3541036c0e6@analog.com>
 <aQS9-NofUjxBoPyu@smile.fi.intel.com>
 <c7fa340961e12157d7a2ee67177e02e81e523aa3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7fa340961e12157d7a2ee67177e02e81e523aa3.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 03:05:41PM +0000, Nuno Sá wrote:
> On Fri, 2025-10-31 at 15:47 +0200, Andy Shevchenko wrote:
> > On Fri, Oct 31, 2025 at 12:31:25PM +0000, Nuno Sá via B4 Relay wrote:

...

> > > +static const struct ad5446_chip_info ad5310_chip_info = {
> > > +	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
> > > +	.write = ad5446_write,
> > > +};
> > > +
> > > +static const struct ad5446_chip_info ad5320_chip_info = {
> > > +	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
> > > +	.write = ad5446_write,
> > > +};
> > > +
> > > +static const struct ad5446_chip_info ad5444_chip_info = {
> > > +	.channel = AD5446_CHANNEL(12, 16, 2),
> > > +	.write = ad5446_write,
> > > +};
> > > +
> > > +static const struct ad5446_chip_info ad5446_chip_info = {
> > > +	.channel = AD5446_CHANNEL(14, 16, 0),
> > > +	.write = ad5446_write,
> > > +};
> > > +
> > > +static const struct ad5446_chip_info ad5450_chip_info = {
> > > +	.channel = AD5446_CHANNEL(8, 16, 6),
> > > +	.write = ad5446_write,
> > > +};
> > > +
> > > +static const struct ad5446_chip_info ad5451_chip_info = {
> > > +	.channel = AD5446_CHANNEL(10, 16, 4),
> > > +	.write = ad5446_write,
> > > +};
> > > +
> > > +static const struct ad5446_chip_info ad5541a_chip_info = {
> > > +	.channel = AD5446_CHANNEL(16, 16, 0),
> > > +	.write = ad5446_write,
> > > +};
> > > +
> > > +static const struct ad5446_chip_info ad5512a_chip_info = {
> > > +	.channel = AD5446_CHANNEL(12, 16, 4),
> > > +	.write = ad5446_write,
> > > +};
> > > +
> > > +static const struct ad5446_chip_info ad5553_chip_info = {
> > > +	.channel = AD5446_CHANNEL(14, 16, 0),
> > > +	.write = ad5446_write,
> > > +};
> > 
> > > +static const struct ad5446_chip_info ad5600_chip_info = {
> > > +	.channel = AD5446_CHANNEL(16, 16, 0),
> > > +	.write = ad5446_write,
> > > +};
> > 
> > Seems same as ad5541a_chip_info(). Do we need duplicates _now_?
> 
> Yeah, it seems it was a duplicate before. I guess it could be a precursor
> patch. Or if there's no real need for a re-spin (other than this), it
> could be a follow up one, maybe?

Ideally, if possible to implement, this should be a precursor cleanup.

-- 
With Best Regards,
Andy Shevchenko



