Return-Path: <linux-iio+bounces-23112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BB9B2FF57
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055A1680110
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05EB258EE1;
	Thu, 21 Aug 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGe2P/fs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A22CCDB;
	Thu, 21 Aug 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791111; cv=none; b=mil6IrlZizg2OjafLyJ0IgIiFBZ1lxz9vK/qaQ4Yg406vzivcSpBQOmuiKmP6/7iutbOWMyEvfo2rIQFncDF9WgIJBDoOP2qgKs1hiNKDNn5a3gJmFVp6yLY1bGxGflRqjBw3c5uImg/MNU1SWpOjSVUkKIKl8j8gTHrMiOmj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791111; c=relaxed/simple;
	bh=sUaTTZ5z3P0I2y30Yrr0e1S9C/u+qXFJebBcuxqbU9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwdfwzK/CWT5Anl4+7tI2WVOVNTpAhoKizM5u6O2yAvAYR/WSnygvFtJn4pt39OWAHhqxr2ugx8AxncCu43RLmb4LIRsB2UBdgNjy20ZmkFgisM3QHPpo5qsPzPV/m/nc+QdtTuOH7nvrRXVw1XKOqrbVqtXGnpIXmD6UYtnDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGe2P/fs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755791110; x=1787327110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sUaTTZ5z3P0I2y30Yrr0e1S9C/u+qXFJebBcuxqbU9o=;
  b=hGe2P/fsUIqfgxRxpT1j208xRi7V6K/qfJRkuqNdNhpd7/ij38e/i6QV
   gwXF/6N24/D3EXEaAxNwdqQIWaZRsTGYAaaa/k+nX7jiMNmNAVNlfE63a
   QiBILB01UCMY0kvFQaN21H1Nf5RQtWfX4tFRjb+6DkGVkyNmPy9gYyaMg
   cZwTm/xiudCfVRJv7w6QL3cDhretVcbWTjBUvPnk2DyU7dvzsismYZMoA
   F0lh04TvSPm+1x1857hCciAJSD96qzRUZt1DAEad+bvRyZxRnxpIQ57il
   C4w+eA7K+q1HbdOj1jPuR/MJCkh4UZDsWX4SEe45u4w9aSrrXuLvbHFvP
   Q==;
X-CSE-ConnectionGUID: wZ7W4JdzTxOlI72M3LqhBw==
X-CSE-MsgGUID: 15NG/fBpRc6hXGbMogZSCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57946474"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57946474"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:45:09 -0700
X-CSE-ConnectionGUID: ItWiD1FtQgWDxLUKiBNn6g==
X-CSE-MsgGUID: wxYmrMXuQRewsVnIDk1lNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168862465"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:45:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1up7TK-00000007HAK-49XZ;
	Thu, 21 Aug 2025 18:45:02 +0300
Date: Thu, 21 Aug 2025 18:45:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: dimitri.fedrau@liebherr.com
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Lesiak <chris.lesiak@licorbio.com>
Subject: Re: [PATCH 1/2] iio: humditiy: hdc3020: fix units for temperature
 and humidity measurement
Message-ID: <aKc-_j84oUwCquHk@smile.fi.intel.com>
References: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
 <20250821-hdc3020-units-fix-v1-1-6ab0bc353c5e@liebherr.com>
 <aKc-2WHDTtGcXmCJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKc-2WHDTtGcXmCJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 21, 2025 at 06:44:25PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 21, 2025 at 05:23:54PM +0200, Dimitri Fedrau via B4 Relay wrote:

...

> >  		if (chan->type == IIO_TEMP)
> > -			*val = 175;
> > +			*val = 175000;
> >  		else
> > -			*val = 100;
> > +			*val = 100000;

> Perhaps  use " * MILL" uin both cases?

Perhaps  use " * MILLI" in both cases?

-- 
With Best Regards,
Andy Shevchenko



