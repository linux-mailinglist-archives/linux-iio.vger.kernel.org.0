Return-Path: <linux-iio+bounces-26498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F762C8C1DF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFE544E346D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276531A556;
	Wed, 26 Nov 2025 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmYpbwAM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98281201278;
	Wed, 26 Nov 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194067; cv=none; b=itnXds2RGacl9kvaOXazsu9R/kxB5sc37qSPHsV9brtJG+YeMa7cTn6bgdHG3JWTyD3NuPkAtoMyuvOuXy0a6HAm8VLJGBHmPU6nboBWh0X1In4dxfNXalLIPKnWN6iZyNR7kA5Zqzib7snjuAk0+wsQHBAy35TUR5wDlBbbtYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194067; c=relaxed/simple;
	bh=CKdN1wqWE0clEKAHEdkAbOHNpeu/QCO/ZNrbQ3B/MTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPSMQBkuTDUBRVlkXrM4ZOjjMPLuIthXPDN4d1d99ulNy/PRGpPwLXkxhTObFD6nIyhDEx8cPv+9hTDl9iHVV0USzpDC4HnViCgS6eORaVcHjMHbm7ORZ+nvn593MtLULKpjauIKmOZFXWYjLp0Kb5wg0TLvP2kJWQX0MqeuSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmYpbwAM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764194066; x=1795730066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CKdN1wqWE0clEKAHEdkAbOHNpeu/QCO/ZNrbQ3B/MTo=;
  b=hmYpbwAMKuCvMJ+pIPsjeAL2c8oNwRJ9lEFMhnNTxvNH7Sbgpas1GPcB
   IDDGnqk6MDyCL/CwR0e9ewWJSdkOy7DyPcIe8wZpM3EfTkxOb6q2L57Mj
   1+MnmEtk8w4iNW7rOcAI4dNLN8wEVfMoeSFNJU2WbfN8EXpJPvlFqh2CJ
   ZOMQ+mu7kGT9+YG6ES+V+rk+kwrQaOBpy7b78BZ0hnfwBGe746J6eFwqT
   FE/cNLstZLuYqVnwB17GCS/C6A3zR7rRbte4NqdNeW/Adr19S0ivgFbNc
   6aunq5OtdCb49aqxMiwV2gn3iwguqsE2ydPHlSezEYhbLHlK2NH2Q3Vv6
   w==;
X-CSE-ConnectionGUID: TzX4kzsjSmOoVZ9RsRaBjA==
X-CSE-MsgGUID: ijaODjaRSd2XFdnBx7RfMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="68834943"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="68834943"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 13:54:25 -0800
X-CSE-ConnectionGUID: UzZiqx0wQr+k1uUB+oqfKg==
X-CSE-MsgGUID: 5oANI2zNR2yayUwwsQsNXQ==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 13:54:23 -0800
Date: Wed, 26 Nov 2025 23:54:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3] iio: isl29018.c: replace sprintf with safer
 alternatives
Message-ID: <aSd3DT7XfcG5frc5@smile.fi.intel.com>
References: <20251126172432.5532-1-tomasborquez13@gmail.com>
 <20251126203240.13466-1-tomasborquez13@gmail.com>
 <aSdsc6jhQLHLVfkR@smile.fi.intel.com>
 <aSd0Q7qCueXDSZtN@Lewboski.localdomain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSd0Q7qCueXDSZtN@Lewboski.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 06:46:18PM -0300, Tomas Borquez wrote:
> On Wed, Nov 26, 2025 at 11:09:07PM +0200, Andy Shevchenko wrote:
> > This is a bit too long. Usually in the commit message the ~75 is a good
> > threshold.

...

> > P.S. Do NOT resend if not asked so. Jonathan may amend this whilst applying.
> > Also note, this most likely misses the v6.19-rc1, so we have plenty of time,
> > no rush with it.

> Ah I see, my bad, its my first patch so I'm still adjusting to the workflow.
> Thanks for the feedback, will keep everything in mind!

NP and welcome aboard!

-- 
With Best Regards,
Andy Shevchenko



