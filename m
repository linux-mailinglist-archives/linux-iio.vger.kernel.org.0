Return-Path: <linux-iio+bounces-25559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25399C13BA1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363C71B20FC1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975132E974A;
	Tue, 28 Oct 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gd1oIQom"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23232D060D;
	Tue, 28 Oct 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642581; cv=none; b=u5ARvQ98GZDobysyNtRz39IZHo4hmm/1Pwole+xEgpA+/mPLMfkBHg5aFtfkw+Bs8+rXjwmfUMvNA3yBE4vM8MpI8abWNHHEWeUQw1+H7EF+mo09MRZqp4rYpM+9ABLAEJPdnqCjUIuRZm3gvNP621SbTiozqvnNyvAJ2qDK3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642581; c=relaxed/simple;
	bh=Wu3kHClzZm/yBtJftXjupb8//qLfBcni2nABKYf1f08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMHJprpU6ffb5yjE5Coir7uXf9Lcwh9f7QhI7ax1gJxSCEPxMFqs1QBCM8TXuG3SWGHdTMzeR/vTzIQcOEQbrowCfEXk2RD+mjOcDvI5bMVS4RS9yR8MOfMqOVTs2ZByJpd2CLgwLnXz27aHdIZpKV2TvCVUCOM2MOERAT7ET18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gd1oIQom; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761642579; x=1793178579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wu3kHClzZm/yBtJftXjupb8//qLfBcni2nABKYf1f08=;
  b=gd1oIQomWzGdtlCJe35P7AjPaH3IwHReXL7GfGpsbWQ6bf6E+ZxcB7j3
   AHe9zc/LRjzbxVnqq+Od0IzKJnQ75BS5t+YKanmAAAcQy2NB4yTFi4LWw
   UUya/rdOYtdqgD5qrHKq3+LapV24vFRBM/4mcok2EKGMmCZJGV8Sv84SW
   lMmBG/rV8JMAEo/NJYDOKS6NJF1MvugXAbkA478beFQVgts0Mxhmmh1Jo
   i5i5+3Hxui/75rSF9B05pmmhJgYdIGboohXZ+bPzQpjinzl73WJjAf1Si
   R1w9PL50/e68kPqzylfdSmfdaIt886g9mjqSV3DrDYYf83w1JGUxjXbcQ
   w==;
X-CSE-ConnectionGUID: Qv4U80ELQCStPjWAumad0g==
X-CSE-MsgGUID: jxcFeR+3TC67J7EFNyq3CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63639304"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63639304"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:09:39 -0700
X-CSE-ConnectionGUID: 8xibrKxvSouQvWOZ+RALvQ==
X-CSE-MsgGUID: W1IZdoFhRL6oE+BwG758lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="190488942"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:09:36 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDfhu-00000003GNN-1LvP;
	Tue, 28 Oct 2025 11:09:34 +0200
Date: Tue, 28 Oct 2025 11:09:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: KRIISHSHARMA <kriish.sharma2006@gmail.com>, nuno.sa@analog.com,
	olivier.moysan@foss.st.com, jic23@kernel.org, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: fix kernel-doc warnings in industrialio-backend.c
Message-ID: <aQCITnF4kft6g64z@smile.fi.intel.com>
References: <20251027092159.918445-1-kriish.sharma2006@gmail.com>
 <23069e05-82d3-422f-9af7-fc100d4d1466@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23069e05-82d3-422f-9af7-fc100d4d1466@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 10:35:02AM -0500, David Lechner wrote:
> On 10/27/25 4:21 AM, KRIISHSHARMA wrote:

...

> >   * iio_backend_oversampling_ratio_set - set the oversampling ratio
> >   * @back: Backend device
> > + * @chan: Channel number
> >   * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
> >   *
> >   * Return:
> 
> I guess it would not hurt to change this to RETURNS: to match the
> rest of the file either.

Good catch! KRIISHSHARMA, please check the whole file for this as it's not a
direct mistake from kernel-doc perspective, there is a mistake from consistency
point of view and hence needs to be addressed.

...

> > + * RETURNS:
> > + * Pointer to the driver private data associated with the backend.

-- 
With Best Regards,
Andy Shevchenko



