Return-Path: <linux-iio+bounces-21533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68917B002E1
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 15:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CE3189BC81
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6D27055C;
	Thu, 10 Jul 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqsxXGEV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BE1DC9A3;
	Thu, 10 Jul 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152855; cv=none; b=MpDNTvBDomL71VDJYBcz2TW6/xkshJay0xjjJ400onpck00PIR1JPIdfbkYhRwyZkPvfJWR00Ss/nZqqeTPbq0fswNZ8IbkmBse/4hb/+UtbcnomBoMm+4SKUNeECfXr78AcuBWSenZul90fQ8MABocXVRn53m9/Y9Lgs+ybenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152855; c=relaxed/simple;
	bh=sViiFudVlKDb69/dolczRJAnvbkAjSLXUPKK5foFX7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWcVVG50L0AoNHVY7wFGKtL4C9PZNYIgNMCuldAwJnXlsNzR/2RZUz/HnKmsX6AdMBQj54KQGT4oACMhPrgvCf1t1DJ+N35fWKP7yE57BcdJmQJ9RCNffGbrr1kELfTSxXrMWtvxLQU27WUlENlO2rcPkex3yuNvx4kmttvZFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqsxXGEV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752152854; x=1783688854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sViiFudVlKDb69/dolczRJAnvbkAjSLXUPKK5foFX7w=;
  b=AqsxXGEVeq2bDQIQu4shcE0sXLSSfhMVhAMFZoyLyFFaHS+o6KQRmDJF
   QF4dMeJrsrk3KomRXIvS5zMSAihVtpfgCH5tnflVFZknFHRXWl5xWbTpT
   pzrrQ8aIc5Q/5jbwa6sqrUYCwL1E7pek5NW+26L2g9v+6kpacUAdk+EPJ
   cVWuJV/r8Dt6kY4BUSuRWZu5Ys3/14ALHMcrxh6Nj71s5uwMPexc4/lNZ
   gdmp1i7r2PKPdzZtrlawm/K9WOkgQtzXzSVnVE+W00crR59lKz5fGdzS7
   Uqb4sbizKTTBbTz/9N+CSTssFUnFPEYnsDb24UyHcZoIOSTyH1HDDDGBg
   A==;
X-CSE-ConnectionGUID: EqexGjwzTgWr7/Ux0g/q/w==
X-CSE-MsgGUID: 62RjOl0MQiWqgNzS6//T9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="79868409"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="79868409"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:07:33 -0700
X-CSE-ConnectionGUID: NW2W9VGWR/uZVFO1i6ZC5g==
X-CSE-MsgGUID: NqK79zl9SJyY2qt25iBOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156197764"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:07:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZqzn-0000000EClz-18WZ;
	Thu, 10 Jul 2025 16:07:27 +0300
Date: Thu, 10 Jul 2025 16:07:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: imu: inv_icm42600: Remove redundant error msg
 on regulator_disable()
Message-ID: <aG-7DrG4Jku5q-72@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
 <20250709-icm42pmreg-v1-3-3d0e793c99b2@geanix.com>
 <aG-B3uv6SsP1Ap0U@smile.fi.intel.com>
 <pt3qh3xaxvbaf7ojib474d7cpgpcehuhzfj6qfg6qv2ivcbb7z@iyen7qvzd7zo>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pt3qh3xaxvbaf7ojib474d7cpgpcehuhzfj6qfg6qv2ivcbb7z@iyen7qvzd7zo>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 10:47:08AM +0000, Sean Nyekjaer wrote:
> On Thu, Jul 10, 2025 at 12:03:26PM +0100, Andy Shevchenko wrote:
> > On Wed, Jul 09, 2025 at 02:35:11PM +0200, Sean Nyekjaer wrote:
> > > The regulator framework already emits an error message when
> > > regulator_disable() fails, making the local dev_err() redundant.
> > > Remove the duplicate message to avoid cluttering the kernel log
> > > with the same error twice.
> > 
> > To me this sounds like a potential backporting material as it might full
> > the logs (in case the module probed-removed zillion of time. Hence,
> > I would put it to be the first patch in the series (yes, it will involve
> > to fix something that you are removing in the following change, but still).
> 
> I have never seen this printed, so I don't think it's a huge issue.
> But it's quite easy to add a Fixes tag if prefered.

Or move it to the end and explain in cover letter that this doesn't fix
(apparently) any problem IRL.

-- 
With Best Regards,
Andy Shevchenko



