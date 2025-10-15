Return-Path: <linux-iio+bounces-25247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F48BED5AA
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F2024EE38A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B314E25C6E2;
	Sat, 18 Oct 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+mMUlTV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCB258CE7;
	Sat, 18 Oct 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808896; cv=none; b=ZNMDlp9Cr3EiR68BY3tLyk6rKarkKirxKNAor914Vv4J4HV7lmty7PaqnSpJ9AlbfuFUMn7agl05qpvS/iYFqszHvkru4or7o9bzJ0CvNDuKBYqKsf8UE4WOkhAe34M4JwYxcHQnnLeDLJLyZbgH5OrThgv8+qoej9wKdOQfpo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808896; c=relaxed/simple;
	bh=ar6B504mvYmuhWV6/bhqVQs7yOj+qiCmfIjXvsPefZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr6SP/GkwSBL5jxpDPAGsGrwqZ+q60YYQTQFNsp6KGytyun+TpBBuMC1lPAZU7KmKo6/xLHIlS2oCTXuKuiaotthl2deskmkFXMIHsONtJXmvsw5FzExI5cJHOhT2BucXSxzgxOwqfSxTKfWODKgM6kiqB3G9KfN1sPKagkyBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+mMUlTV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808895; x=1792344895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ar6B504mvYmuhWV6/bhqVQs7yOj+qiCmfIjXvsPefZ0=;
  b=a+mMUlTVVv+mfoOh8UNddVipqKHJ7NHjWQqe/hq8K6NT5PUOm/npTyFb
   T87FhO/5lw4OhVetgeUxYia4Qh8PfqgOpH+ez8sDq0WRquxG3Tvqmqy/C
   mwILsIFw34/yBvDD5EVlMr5vyOu7Yw9mP43ZNzfOcjqz+qdMhx6qz/dWD
   ADhyabWkjZewKAh+4NBn+TmgQLAmPOVl2dCP/6MCGgqzRCrzeiMzybVgk
   QRRbUbSBt2MwW9JSIjq7pe5lkHFJD9r3xB2puPhfUa/kEsRlbX/JDTxs+
   ncGQLsGYaBUvP/vHJqKYQP6hHSEbnt1F5m2fyTWHZUTdSylu8Lk7nMMyn
   g==;
X-CSE-ConnectionGUID: bjtfW5JOTfmbAxteu++41w==
X-CSE-MsgGUID: PEEfATrWSRW4IkB37ceffw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73670250"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="73670250"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:54 -0700
X-CSE-ConnectionGUID: UskWC8XCSKKNtuyfntSYxQ==
X-CSE-MsgGUID: KSQDGq5rQJCPAdkjev9zbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182532254"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:52 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1v92aa-00000000Ktf-1Opk;
	Wed, 15 Oct 2025 17:34:52 +0300
Date: Wed, 15 Oct 2025 17:34:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
Message-ID: <aO-xC_cg5PtpMLfo@smile.fi.intel.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
 <20251009173609.992452-3-flavra@baylibre.com>
 <CAHp75VfOfeS21=5SK6Qa9Fc-WQdjDkz1ecoTFrk=hT1NGGt0TA@mail.gmail.com>
 <aa0fc9e1bf78b9390642e80db3fc1c51e6217e95.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa0fc9e1bf78b9390642e80db3fc1c51e6217e95.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 10, 2025 at 08:44:50PM +0200, Francesco Lavra wrote:
> On Fri, 2025-10-10 at 17:55 +0300, Andy Shevchenko wrote:
> > On Thu, Oct 9, 2025 at 8:36 PM Francesco Lavra <flavra@baylibre.com>
> > wrote:

...

> > > +       ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
> > > +       if (ret)
> > > +               return ret;
> > > +       bdr = integer * 1000 + fract;
> > 
> > MILLI?
> 
> If you mean replacing fract with milli, will do.

I meant 1000 --> MILLI(?) or whatever SI prefix suits better?

-- 
With Best Regards,
Andy Shevchenko



