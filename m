Return-Path: <linux-iio+bounces-12974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548B9E0C4E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0486D16527C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC631DE8A6;
	Mon,  2 Dec 2024 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP/HF7Sp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02D1DE893;
	Mon,  2 Dec 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168375; cv=none; b=dNGLTEZlaGOJO7tUYVAR2CCIeTcgtFOlg+kIMpjYsCct5xqvcrXxlL9M+SSlcvMhanQ7YcROP2WPnyLECTYQTnmbLi1K9LStVuJUB1foWFG0FsQj35KNUI29QuMtlgKxLwZitEmj6yWey80DOJHoj5i6o+txdStqVwjYysX+JxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168375; c=relaxed/simple;
	bh=ELAb8l5Gsy/ftM10z1411EjhX0fFdKa41HXQZK0rAU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF0rTiE0tYqFpgEAgUP8m63YFzLy147ISRr2Prd9dtUjmZZOxqGN7PSZ7NOtdFKZTffWCvx5KX9BYNHhAPq+7mT9Ab63HyiPoN7Gtw2k2hzH+kO+oWIc8hgSA4eES2wx8doE3nWR7mvpSv/dps/FwL+AqSANqOK3caRSBwV9U4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP/HF7Sp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733168374; x=1764704374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ELAb8l5Gsy/ftM10z1411EjhX0fFdKa41HXQZK0rAU4=;
  b=LP/HF7SpHb3q+FSnKXyJWnIxKFk/ZWJWEsjV1VNojAVOqDOgEkK57SuV
   tURIvo03eFrOlhbMepUdP1/2ijO8hLW/m0sZs6HfCfshR8+cvRNaIsBvC
   MtdXiE04Xg0Bpo/KmvXMjPARAoUaRa9mu1y/qg5ve7feKl9JZTAViKOWw
   VXzI1qevBUiTRA5GR6/VWBH5PmVr+tnhMIsnnN3xGSRK7PBMu+Tt+T3do
   DZRHG2z86I8zAyB0w5HfYpOMJjNKTGqrmp21ugiBjcwARjdVilirHy76x
   aYxPP+0JQR9e1oE/rsKWSfxD4ZqLgvozMDZOLxGzxmfWMwjLrF97ukPyy
   w==;
X-CSE-ConnectionGUID: 200lfTjTTZG+hapiavgHBQ==
X-CSE-MsgGUID: I/PPEV0CR1+/fbamr14hQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33230620"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33230620"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:39:25 -0800
X-CSE-ConnectionGUID: a80X3z8mS5uZnqnZnO4kKQ==
X-CSE-MsgGUID: YGElb9ROQXWsWxpozJ9vgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="116466901"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:39:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tICGN-00000003EVQ-3nuW;
	Mon, 02 Dec 2024 21:39:19 +0200
Date: Mon, 2 Dec 2024 21:39:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ajarizzo@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: pressure: bmp280: Minor cleanup
Message-ID: <Z04M552eW9LwYVhH@smile.fi.intel.com>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
 <Z03_fBy9PmqDGLg3@smile.fi.intel.com>
 <Z04JgFlg57-slCsU@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z04JgFlg57-slCsU@vamoirid-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 02, 2024 at 08:24:48PM +0100, Vasileios Amoiridis wrote:
> On Mon, Dec 02, 2024 at 08:42:04PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 02, 2024 at 07:19:04PM +0100, Vasileios Amoiridis wrote:

...

> > > Changes in v2:
> > > 
> > > Patch 1/3:
> > > 	- Switch if case for better readability
> > > 
> > > Patch 2/3:
> > > 	- Reword commit message
> > > 
> > > ---
> > > v1: https://lore.kernel.org/linux-iio/20241128232450.313862-1-vassilisamir@gmail.com/
> > > 
> > > This series adds the SPI interface description on the device-tree file
> > > of the sensor, adds proper self-described sized variables and performs
> > > a minor optimization in time variable names.
> > 
> > For some reason your patches still have v1 in them. I dunno how you prepare
> > your series but I recommend one of the two options:
> > 1) b4 relay
> > 2) my script: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

> Ah, my mistake! I didn't pay close attention. I use the --reroll-count
> from git format-patch. I was not aware of those automated ways, I will
> definitely use them. Thanks for pointing it out.
> 
> The patches are correct, the versioning is wrong, I can resend them if it
> is necessary. 

Up to Jonathan, if the patches are correct, I don't see the necessity of
resending until there are some issues being noted.

-- 
With Best Regards,
Andy Shevchenko



