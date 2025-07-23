Return-Path: <linux-iio+bounces-21909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2E4B0F57D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A38176B86
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEE72EF9BD;
	Wed, 23 Jul 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwbgEh0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A118E3F;
	Wed, 23 Jul 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281479; cv=none; b=dTg779sVKZhy44Fh0/+IP+O4Hrq6VmAzKxNARw/2ZnY88MAxdF1jx/7pc4DoNkcISuCKcsFQ5h2VF89B1Oyv+5C4beqZRXhWfnUJEmG3Hq4SWTHcn/BOI+iwNu7HWnOOllKuVNaL+bYBdiAXXXx6R50rbCvjj1n/ztSAYAsZ/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281479; c=relaxed/simple;
	bh=n2Ip6P1bDLbugzsbfTChU2rFmhWngseqqiPKszd5RG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmXRcQhNlL2v1iZZZCj2Lwy5SItKADvvZqmgfz5CVM/G8a3gN0JdGEEjID8bcmuK8zMA7Wi3TzidPX8ugA4yHWd/AB5+mIugLLMLutnNDN3qjxLxVDI0+ELaNgQrds6Y4qfgOMp+oGT/OrJuo/0mk2UkbMVnIy8EiKRENQJr5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwbgEh0K; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753281477; x=1784817477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n2Ip6P1bDLbugzsbfTChU2rFmhWngseqqiPKszd5RG8=;
  b=NwbgEh0Kcq4pYs/jK0IDo4RF/sKUNgJi8ljt2/7xBiggVwBdw2tP+sFQ
   bde8JK22avGEf/FxGv7PRpIuio25vjEflwet+HePA+Xw/Apg2lnUw2uEi
   SsCua+2o0rn/xE0V81OFvHXkvj12y12Xm57n7tjpSau5KNh5GU/soGUIj
   4DrdEc945ZtVnKpvXLeJ87eYTsRtf5xaWpkKLanZ2FODTxp/g5kh25Fd1
   S7W8NNToT1KQOviZVizgW88UTLSV7glbInBGQ9pywWLZMsw1om9YKg/ek
   XYGAGVCQ9a9uJf+O458mssI1m1YX3j23M5TYhtl5BLP9YkQbTnZL6OQuK
   Q==;
X-CSE-ConnectionGUID: o5qj3ihxQw6RgB1q0cK8vg==
X-CSE-MsgGUID: jxoEpU6aSSevh1O21yLIhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="81013939"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="81013939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:37:54 -0700
X-CSE-ConnectionGUID: QsZZcSX+S6S1i9sCZCGK5w==
X-CSE-MsgGUID: OeHGZhkCS2u9SPCiuSvmRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190495622"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:37:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueabN-00000000JZg-0sFt;
	Wed, 23 Jul 2025 17:37:49 +0300
Date: Wed, 23 Jul 2025 17:37:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
Message-ID: <aIDzvNYIaJnSuzOa@smile.fi.intel.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
 <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
 <aIDuEcHhaGtz2klP@smile.fi.intel.com>
 <795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 23, 2025 at 09:29:37AM -0500, David Lechner wrote:
> On 7/23/25 9:13 AM, Andy Shevchenko wrote:
> > On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:
> >> On 7/22/25 6:07 PM, David Lechner wrote:
> >>> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
> >>> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
> >>> the data before pushing it to the IIO buffer.
> > 
> >> It is odd to have data already in CPU-endian and convert it to LE
> >> before pushing to buffers. So I'm a bit tempted to do this instead
> >> since it probably isn't likely anyone is using this on a big-endian
> >> system:
> > 
> > I can say that first of all, we need to consult with the datasheet for the
> > actual HW endianess. And second, I do not believe that CPU endianess may be
> > used, 
> 
> Why not? Lot's of IIO drivers use IIO_CPU in their scan buffers.
> 
> > I can't imagine when this (discrete?) component can be integrated in such
> > a way. That said, I think your second approach even worse.
> 
> hx9023s_sample() is calling get_unaligned_le16() on all of the data
> read over the bus, so in the driver, all data is stored CPU-endian
> already rather than passing actual raw bus data to the buffer.

I see, now it makes a lot of sense. Thanks for clarifying this to me.

> So it seems a waste of CPU cycles to convert it back to little-endian
> to push to the buffer only for consumers to have to convert it back
> to CPU-endian again. But since most systems are little-endian already
> this doesn't really matter since no actual conversion is done in this
> case.

Right, but it's buggy on BE, isn't it?

-- 
With Best Regards,
Andy Shevchenko



