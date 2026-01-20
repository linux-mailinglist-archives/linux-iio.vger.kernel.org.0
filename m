Return-Path: <linux-iio+bounces-28037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE7FD3C089
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55B084F7BD7
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFA39902D;
	Tue, 20 Jan 2026 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTODPf2C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097C397AB5
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893603; cv=none; b=NxdfrIe0WYvuuXOZpGAdGCCkPdPtmdKrrgmowz0wVSkg+2YiX/6QVpKqGrcZU6tvRopc8xPk9zDzPpjSh9KYyO10Ic5EOC7LmlUbhzAUxBwQ74Tgeo7BJYg658SbaErJKT6OOiX8/cQikbVt8p1ESVIn6ouJw3FFg+qH1KLkPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893603; c=relaxed/simple;
	bh=IEp6admrtxFcogF13I0f90HIhqKvnppjQVgrMc4Qfs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiDr4GLbHtmvIgrQ3XBdZj3LNH7FN0gvXtH8DJ6QqrQYV7/8NS13m0o55WCNqvglt6SdOL/n5Bq/AZMZZ37SurTr+Dkod0eMAYFk7xOMa8q8NcpeaPN3b02GvQbA7V7EJ9/y072QIo6QuXof8NEntDcL56AjWNfKkZFQrtCDoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTODPf2C; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768893597; x=1800429597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IEp6admrtxFcogF13I0f90HIhqKvnppjQVgrMc4Qfs0=;
  b=iTODPf2CSrLgw7yL6TEwW52QImjUQU6qJfLj4VX6cvoZCFVzkk7nBVXd
   Ja41RnM4MgDjMQM0agI+Lk+0nzuBE0pwuPgAGX5RSq1sr5urK/DL9juOw
   zjQmdEaGlhsimeWEhz9YDal8yD65kLGyVm2JCnBirs0Oagamm6xQfqI7r
   C8t8bnJb7RyLOrDFbP4PloouJVf0tBkIHe7dCyJLXqHJL80Urx1zyKNPa
   wrmUpVe4XVAUDKKWVPIi4rkHoB3SZj5fmeUQAU+y5b+K1Ub6gueQlSckp
   dfRT1i7ewfmBUgdLwN8BHF3CZ6M1dVOgTPBFEt46oOz4mcjhe5Ef0lHOw
   w==;
X-CSE-ConnectionGUID: na8u3zjpT2yShUMex3TXKA==
X-CSE-MsgGUID: FGlue32DQpCRXFoJFSUcbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70182438"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70182438"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:19:52 -0800
X-CSE-ConnectionGUID: 2ZC+IoW3Q0aP/mKTHJeTdw==
X-CSE-MsgGUID: iCJLOXc8TQWQi0xoSfDjnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205844705"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:19:50 -0800
Date: Tue, 20 Jan 2026 09:19:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	jorge.marques@analog.com,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: ad4062: Switch from struct i3c_priv_xfer to
 struct i3c_xfer
Message-ID: <aW8sk9mD-dOHeJZg@smile.fi.intel.com>
References: <20260119213617.745603-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119213617.745603-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 09:36:17PM +0000, Jonathan Cameron wrote:

> commit 9904232ae30bc ("i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()")

Commit ?
The commit ?

> currently in the i3c/for-next tree removes the deprecated
> struct i3c_priv_xfer and i3c_device_do_priv_xfers().
> 
> Switch to struct i3c_xfer and i3c_device_do_xfers(..., I3C_SDR)
> now rather causing a build issue when both trees are merged.

Not sure if we need a Fixes tag.

> Suggested-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Cc: jorge.marques@analog.com

Can we move this to be after the '---' cutter line?

> ---
> I'm already carrying this on my tree to resolve the issue in next
> but feedback still welcome!

The rest is fine to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



