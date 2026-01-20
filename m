Return-Path: <linux-iio+bounces-28046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F25AAD3C438
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 10:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C618549E83
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B47B3EF0A8;
	Tue, 20 Jan 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBm5S77y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2A3DA7FE;
	Tue, 20 Jan 2026 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901772; cv=none; b=dG3pIhGU/I/qeXpxBuMQvOORucVsx6fJBrtq2PjTMEOtjYjC8mK/VIawGKIX5G0mNq3CR/XUCoOwwicNtig+CXFwt07O/qWL7KpECHw53/6kXH2QFOGir4d9WpjcOcSOZvLRYaQMpBi5jx3v4LsEpWqlpBrkMkqfNHD3S5gxQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901772; c=relaxed/simple;
	bh=1ZjQqOpehWGCG5dN9GnXwSsfByQsfYENPH+DmkEeSzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRkrVZxUCBNv4H7v+3NdoTwhzIT927odXN8OQh6XNMunNeTLFCma1rubfkSt0kpEUHBLYiSK3U7aIaEqU1rco26JL7pLXBp380EJ4qsmSMqPoMGmecdkVJcNrb9kKPJnxcFO7ScVSGaE085/+UM6xymBK8UskukZl02m3R/44hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBm5S77y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768901772; x=1800437772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1ZjQqOpehWGCG5dN9GnXwSsfByQsfYENPH+DmkEeSzw=;
  b=IBm5S77yreElhtYDEM35QNBucSVAyjZ3ky4Aqx1ESMHfdSVKJZymMk09
   uW96jQu0rzVcnKaVd3zoJTgL/hjQQMFNB7pWWish/cVPJytc3j5vdod1b
   I+DkI8LJ+bq/sgW/gJAtiwCB1huMZ+0svSSrwWOFHYYD9IvoU5KqfPHwc
   /rhTGxPmzfN9/WvKKIhxxpESPyt68AokLbwehF+beE4ktVtLohu/n4aQ+
   njGpidWG4OETW9jXwsxnW/4Y+pQkxYECicqaksf7iohTOy/9j3crFp8M2
   8wmot5x3BiHikKEw731f43nLF4Sjd8+HSu/xZkhASUuNjBiXTylZnaUNd
   Q==;
X-CSE-ConnectionGUID: 7y7Mc+mNTzGaDGzsG6IYPQ==
X-CSE-MsgGUID: C5kfZm01TFeriK6Hq67dRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="87519697"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="87519697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 01:36:11 -0800
X-CSE-ConnectionGUID: 0XMMBhhFSDCYrrr4o6UoEg==
X-CSE-MsgGUID: u9wvEBRHQhuaMZPIjjXN3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="211088986"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 01:36:08 -0800
Date: Tue, 20 Jan 2026 11:36:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
Message-ID: <aW9MhYO_xhlQXFn2@smile.fi.intel.com>
References: <20260119100449.1559624-1-flavra@baylibre.com>
 <20260119100449.1559624-4-flavra@baylibre.com>
 <aW4Ic5bUId3MG4em@smile.fi.intel.com>
 <851180c6f41f8c9cc79d6412eb97f381f0312f00.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <851180c6f41f8c9cc79d6412eb97f381f0312f00.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 10:28:15AM +0100, Francesco Lavra wrote:
> On Mon, 2026-01-19 at 12:33 +0200, Andy Shevchenko wrote:
> > On Mon, Jan 19, 2026 at 11:04:49AM +0100, Francesco Lavra wrote:

...

> > > +       snprintf(sensor->name, sizeof(sensor->name), "%s_sf", name);
> > 
> > Does GCC complain on this (`make W=1` build)?
> > Since this can cut the string and we don't check the return value, the Q
> > is:
> > is this okay to have a reduced string?
> 
> gcc does not complain with W=1. sensor->name is appropriately sized to
> accommodate the longest possible name; if it wasn't, the string would be
> cut in the accel and gyro IIO devices too (which use a longer suffix than
> "_sf").

Right, the question is if compiler can prove that or not.

We have several patches in input subsystem to hide the warning by switching
to scnprintf(), which I consider not the best approach, but still it depends
if we care about cut or not. If we do, we should check for overflow.

-- 
With Best Regards,
Andy Shevchenko



