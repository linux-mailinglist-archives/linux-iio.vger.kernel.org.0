Return-Path: <linux-iio+bounces-2767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AC85A2B6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D251228439D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343DA33CC6;
	Mon, 19 Feb 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6diq3ed"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DA31A7E
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343985; cv=none; b=QEyyDDVzh4aO+7yukUcpEn8cZNxl+qWSxMRA/EUMCdvLxCQWO+2Vw28PzsfHNr0vT9EXd7pSw0Sx8nsByLYgT7KPH7zTe+j+Q+mpjAJJVgCJGihvHYPZdhIP8ByABu3F05heowh4dHQ8co09Fvj+iaRV67BS5f1CT7iuMUUP194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343985; c=relaxed/simple;
	bh=54YSOaq1BNIOLytkRgBMTG7M88cY7cH+LztNCeg+7Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwRBpyA5a1ChGBVU4gGNGlHe6PGpS6UBve/j9Z9jUgOTN4OvcjyxgoKGTU8vfEqmSoboBl2BiYVadZbkjb2gOn4/xNiIuZVj3xGsrwoqu7ThsdOhfYI4zKFLPkMvwl19M/Y6g8yU+ioR7nQw+loaYldPh1q39h/8Rvc3gJfxsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6diq3ed; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343984; x=1739879984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=54YSOaq1BNIOLytkRgBMTG7M88cY7cH+LztNCeg+7Uc=;
  b=J6diq3ed7KGtm24dTIdPKore33c1CRRyv/NKV9dFbyn3TKRG1jR/mmNi
   AU3t8JhyPq5IoHC3Y4ZWsecLMXkMR0jn/kFHyUJ/tOGAJhFmE2E1jv2m9
   ly0UcQwQ2wHtfIJxJGMtxuSY+ExOP5B4v06wAYjfM2X88RH6uQapG8A84
   N1rE9FMLOSyCjbKD4g9/pB2qLEH7U/eXDcwMS4UB5XQkwwgIdsMJUvh9+
   FshyIz+Byg3bLEo/VAqhfJdKqoyw/OYGf+Aplw7SfIfGh3GpNnQyUjo4+
   CaFPj/5k6hTxhXSeX2yrGxt1jfkWPn0z/tqKVlipffY6BeJ+jtHuFCMA4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19951330"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19951330"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912863165"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912863165"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:59:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2J6-00000005oTQ-24Yn;
	Mon, 19 Feb 2024 13:59:36 +0200
Date: Mon, 19 Feb 2024 13:59:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/8] iio: adc: ad7124: Switch from of specific to fwnode
 based property handling
Message-ID: <ZdNCqIyWjvYSAfzF@smile.fi.intel.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
 <20240218172731.1023367-4-jic23@kernel.org>
 <7f4f569b9e8edd017f92d1fb583bdbe419fe4e87.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f4f569b9e8edd017f92d1fb583bdbe419fe4e87.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 10:24:59AM +0100, Nuno Sá wrote:
> On Sun, 2024-02-18 at 17:27 +0000, Jonathan Cameron wrote:

...

> > +		cfg->buf_positive =
> > +			fwnode_property_read_bool(child, "adi,buffered-
> > positive");
> > +		cfg->buf_negative =
> > +			fwnode_property_read_bool(child, "adi,buffered-
> > negative");
> 
> I think this is one of those cases where 80col limit hurts readability...

I like long lines, but to be honest this is also usual pattern on how to
split long lines. I leave this to you, folks, to solve :-)

-- 
With Best Regards,
Andy Shevchenko



