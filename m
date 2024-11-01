Return-Path: <linux-iio+bounces-11754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E99B8CBE
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 09:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF631F21C39
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C19156649;
	Fri,  1 Nov 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Umu2T/Dd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421684A5E;
	Fri,  1 Nov 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448893; cv=none; b=sx6hyuR9axzrKWnnO3FiRXtOkrW7ueW2tYvpnOm0/G7Yc/s6R9KnxxNRLD58fer+NHlz+sUOpxps+8EpyXsmGOZj1PKvHjWnd4BtgZDbwEd8WH+0g7p0yOpJF+8yd6ernNS7QKx9gtA+vbfZYvLx8Gsge0eIj3JPvO8b+wuCmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448893; c=relaxed/simple;
	bh=frMBq+2pGCfTjE+s9bnLUtG+16nweQfByWAnfaMoVYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0Lr8+Gaf0fFSx2iLMWa6GV346yAp19GagN8DJcEOXO2yE7JH2bqKH/a7FBoRzSWhz+lcJs3/yauXeoDgPkFs1gMTePLIOqHhSvzL0KdJQbPgOWOJP2Gx8SZw46KFARUNk5U6SgAo6bx1e4MIds9SGtCOaJdjJP4FP7mU62948A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Umu2T/Dd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730448891; x=1761984891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frMBq+2pGCfTjE+s9bnLUtG+16nweQfByWAnfaMoVYQ=;
  b=Umu2T/DdYx9iZVGj8SWsHm3ghoI61L/uFzXxWGKSpyvrp7MZZUQSTpSG
   1MekaRRrOZuUKToJkRRPgDswJpPvHgBNItzeezc3SkM1ZhgqqNxmfxgNX
   iVn0Nvo+wW7VPXJmYy+zq4ePM9O2uPKk3MDI8d/VcxL2HpXd5aWMD2+yQ
   bTCtQPmWO1uWGKPnzwoFYahEzHyh6tqE2HAKtInHxVS4KKvJPD67UCTu/
   79bmrA373u4U+EqZCFcDHoUTChsHz52E+VacyEP1RdiVW3Qhg+n+pDoo1
   gRcMMJvMRmRWNWyoZZ6QKPIPDrpZLYA86sdc01ygbQT7LaKrY5yNea/dg
   Q==;
X-CSE-ConnectionGUID: /fgjaE1pRSWXCO1lk3usVw==
X-CSE-MsgGUID: 4ZYNTsKkQ2GXbMs5oVJWyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41579085"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="41579085"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:14:50 -0700
X-CSE-ConnectionGUID: crDuP7F+RkmFvMMWZMOrpw==
X-CSE-MsgGUID: soI9w6vVQ/+h/82JVO5plg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="88023626"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:14:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6mnt-00000009xWB-2yGL;
	Fri, 01 Nov 2024 10:14:45 +0200
Date: Fri, 1 Nov 2024 10:14:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1 1/4] iio: acpi: Fill data with NULL when
 iio_get_acpi_device_name_and_data() fails
Message-ID: <ZySN9b9PsRmNlvAu@smile.fi.intel.com>
References: <20241030160756.2099326-1-andriy.shevchenko@linux.intel.com>
 <20241030160756.2099326-2-andriy.shevchenko@linux.intel.com>
 <20241031191717.1a521f03@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031191717.1a521f03@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 31, 2024 at 07:17:17PM +0000, Jonathan Cameron wrote:
> On Wed, 30 Oct 2024 18:02:17 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Fill data with NULL, if provided, when returning NULL from
> > iio_get_acpi_device_name_and_data(). Note, the current users check
> > for name to be valid, except one case which was initially doing
> > like that and has to be fixed separately.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain
> > Fixes: dc60de4eb0a4 ("iio: acpi: Add iio_get_acpi_device_name_and_data() helper function")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This is counter intuitive as usual expectation would be no side effects on an
> error return.  How hard to fix all the users to initialize to NULL if they
> care about that?

v2 just has been sent, indeed the result looks much better, thanks for the review!

> There is still a chance we set it to NULL in here anyway, but that should only happen
> if we know the return is good in the sense of no error (missing ACPI etc)
> but not necessarily that dev_name() won't return NULL.
> 
> Don't think dev_name() can currently return NULL but 'maybe' it could...

dev_name() can't return NULL on the properly initialised device (either with
device_add(), or via dev_set_name() call). I do not think we can ever get to
the ->probe() without the above. Tell me, if I'm wrong.

-- 
With Best Regards,
Andy Shevchenko



