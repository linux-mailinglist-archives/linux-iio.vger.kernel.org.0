Return-Path: <linux-iio+bounces-25826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3FC2A942
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 09:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB73A39C0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E872DEA83;
	Mon,  3 Nov 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="La9rBQQK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99072605;
	Mon,  3 Nov 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158634; cv=none; b=uRxvhRjeW4WWy74ovl/bDgGsfxS0Zz46+nPw6Mx3u/VZRWpkVLHJJHeZQ6baSv1QOUxBCmA8kfFCcycxl6DIZ0hIMRrzugsyPDiIF7cQYnaeOLO1rmkM5+7LlRwZh2oos3V3bvSn+AtHXq445xVrf4GXqmNt7EtXzCcc+kXO78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158634; c=relaxed/simple;
	bh=S6yyFzMmtyqyR4pOSLkTbp/pNg+DaRIc5SyGLiJx7Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZALLcSpyTEvTUSPMjY2cjTbTzwrs5qVVefTr6M0+l5BoVNpK7h3EoMcqp2MAaifDQ3+X/g639I1LsH+0t4rUltBTxIPITzCz1Qq6NrFTSgm4rvo1FTFkGgmGxi2w7qQcio4j5sCHWPENUlJE8+p9+BkwmC3BSJcnKjOrF18xbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=La9rBQQK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762158633; x=1793694633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6yyFzMmtyqyR4pOSLkTbp/pNg+DaRIc5SyGLiJx7Tk=;
  b=La9rBQQKhlRLpm2Vop00F5NTgdlxJfBVWDmhTuS/0x5ebbKKA3ko1JWk
   1Ik30eAUDzfdM8iWQSQ8+o23kykA8SCJST/Xloyrqk96WOJUQLXdaz8Eo
   /S5jbpRYmbmo3KXTPM58kgo59lihGHm2yc5ojn1I2Id9TrdDVNLWh/nWT
   2QQVNthJzF2A6GpuHmB0YJRA8U8VYIa8mde0s6lfuTPsNi3i/918B4Frj
   il4ftnxM2gKA3r2ueVKEhtqFSaZbVfeDTZ4n78zlA5PD3jYUcld3iO1+1
   n3QKMibYb2/At/ZaE4NhK3m876AHG3A1DSXVs6b8y5NSlbplrvrT0mZRT
   g==;
X-CSE-ConnectionGUID: wlsW7mKFT/WzTXdsmGis0g==
X-CSE-MsgGUID: 6OY6XwcITjeghiG0MZklJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="51799318"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="51799318"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:30:32 -0800
X-CSE-ConnectionGUID: 4J3sswDESXyOmYqwBLmOJQ==
X-CSE-MsgGUID: r3Xr3olwRH2nwfQhwDgr8g==
X-ExtLoop1: 1
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:30:28 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFpxH-000000055de-1ZOH;
	Mon, 03 Nov 2025 10:30:23 +0200
Date: Mon, 3 Nov 2025 10:30:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2()
 with ilog2()
Message-ID: <aQhoHj0s_bjI1gNs@smile.fi.intel.com>
References: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
 <20251031094336.6f352b4f@pumpkin>
 <aQSHVsWGXzigTEMe@smile.fi.intel.com>
 <20251031124530.3db7805b@pumpkin>
 <aQSw7V7tYjBOtJ7k@smile.fi.intel.com>
 <20251031161331.0f0ef347@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031161331.0f0ef347@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 04:13:31PM +0000, David Laight wrote:
> On Fri, 31 Oct 2025 14:51:57 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 31, 2025 at 12:45:30PM +0000, David Laight wrote:

...

> > Do you have an idea how to improve that?
> 
> Not sure I'd want to get cpp to generate a high-precision log.
> It if definitely doable, but will be a mind-blowing mess.
> (and I'm not sure how many MB the expanded line would be).
> An ilog10() would be easier (probably looking like const_ilog2()).
> 
> But for this code just use '+ 9' and add a suitable comment :-)

v2 is sent: 20251103082937.4081863-1-andriy.shevchenko@linux.intel.com


-- 
With Best Regards,
Andy Shevchenko



