Return-Path: <linux-iio+bounces-25668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638BC20463
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 14:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598DE462DC7
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F524418F;
	Thu, 30 Oct 2025 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcQ3x62v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859041D5CD1;
	Thu, 30 Oct 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831391; cv=none; b=qSXYtwehgv6KybUwgVVYRY5i/K+ftwiOMGcNNOQFP8pVR/P7fV4aG8yBtm20h7pBlXXIxgmFhM6wqy/6dFSeDC2oEjPO0BqLs6Pcn3BFy50yfYM0Iwp2iKVqCThvo3YEe/Bb5zd8afiRbc41JYmWzAO2N1K4xgFmae6VBBc3pBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831391; c=relaxed/simple;
	bh=XMTd1vz8r8FTmG8WfrXnU0vXL0LciQPKNsaUofKuV9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpMUF0gQrkFxvLYH7C7acE8zwYPaD73lLzTq4rPy+VNv5JUewhw02Q2U9pA+HPkTAFpvUC9qB506qVTCUsmziMXgJVJ2qK6UzkaXlAW9a2LzTC28HdSmUY4GwvV7C8+pqXzDQ0BFm6AW5pGPPjFHOcnE1YiLzZsIqFAa6t27moM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcQ3x62v; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761831389; x=1793367389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XMTd1vz8r8FTmG8WfrXnU0vXL0LciQPKNsaUofKuV9I=;
  b=DcQ3x62vIpKPVCCZbME1Sqy5GARqdUOss/Qm0eYj7p+ilp9GavlB8QdV
   eC79ZuOD8UTFsEuXZEMLV6sbqNs/p/idHWNjnI6dtZ0oByP+nyFlFSPo3
   zuMFHmFAZMRLbDF7MZThqy0NGrOhfwQm/8/EV7J+xHKFvSVhLjBpxDPne
   7k4gsj6QvOYM/V0nkEDalupRPFBW6v3PijjS8QXwl3+TMNsLRaWzQqsy/
   PPDvx6Y1O8b0wkdKZdTrgBkxY/89CERBHN0QNgkgSEhB53uXUVmu9wzpi
   jheK1ghTrAowmeOWTP9S2julIIKmqczzvPGa28uJMRofPTArkBUK8+IYd
   Q==;
X-CSE-ConnectionGUID: tPfARKEDSzeYiy3f1gFk5w==
X-CSE-MsgGUID: f3HPySQcQOqDNGJf4UXtzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64121946"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64121946"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:36:29 -0700
X-CSE-ConnectionGUID: PqLlZC5uTx2fazNvMvvPtg==
X-CSE-MsgGUID: G6ODadslQ0W9CqCG/PladA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="191096245"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:36:27 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vESpE-00000003vGs-2HJq;
	Thu, 30 Oct 2025 15:36:24 +0200
Date: Thu, 30 Oct 2025 15:36:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] iio: imu: st_lsm6dsx: make event management
 functions generic
Message-ID: <aQNp2PrS8BpFtGa0@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-8-flavra@baylibre.com>
 <aQMerfm6peHvHAz2@smile.fi.intel.com>
 <78f1502c131a7f5bd6dc24c364aceff154501ece.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78f1502c131a7f5bd6dc24c364aceff154501ece.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 12:17:52PM +0100, Francesco Lavra wrote:
> On Thu, 2025-10-30 at 10:15 +0200, Andy Shevchenko wrote:
> > On Thu, Oct 30, 2025 at 08:27:50AM +0100, Francesco Lavra wrote:

...

> > > +static bool
> > > +st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
> > 
> > Why not one line?
> 
> This function was already there as is, even though the diff makes it appear
> as a new function. Will make it one line.

Do you use --histogram diff algo when preparing patches? Perhaps that helps
without modifying the code?

...

> > > +       events_found = st_lsm6dsx_report_events(hw,
> > > ST_LSM6DSX_EVENT_WAKEUP, IIO_EV_TYPE_THRESH,
> > > +                                               IIO_EV_DIR_EITHER);
> > 
> > Indentation.
> 
> Seems good to me, what should I change?

First line is way too long for IIO which tries to keep 80 limit.


-- 
With Best Regards,
Andy Shevchenko



