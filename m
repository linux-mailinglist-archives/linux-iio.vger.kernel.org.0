Return-Path: <linux-iio+bounces-18174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074FA907B7
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 17:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950031907AB8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2C20A5F0;
	Wed, 16 Apr 2025 15:28:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3E18A6AE;
	Wed, 16 Apr 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817311; cv=none; b=qPzanA82TgzM/ghjT5eKGgmIcu5DprbMH3pfXqxF172Km/2PHR9RB0YOhEZC4Qcm8xMfUGukqsD/Cw+3d/5Dcj3icSG0a6/fa/pv/vxafsAcWvCbfBE1rdxaZsjLkKUZ/CN0Mcf8bCWyOGe2E36/2TYDsUWO7uFyhfbFa2aeRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817311; c=relaxed/simple;
	bh=RgI1o+XxLxQB23YF/Dqsu7X9RDMwa8iK3d9xfzCl/kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N82RqD8iYp3cUdZLcmXsY3xrgaMXICsHKrzoGpR8GmZ+fyQUXc4xA0htxjpA4ngvCw8mRkA6Su+TyfHHpiCeC6z7/MTEGz0nRAmSdw16iZMDUCnpS0h2r1puorwJYqKNRtW/di0nrscnfaqPKKu93GIyUi20KEfJaRzBUUXzDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: TmkhVHyZR0ymvp1KwwboCw==
X-CSE-MsgGUID: WCT9WYCdQmWKndWpHK9mEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46385870"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="46385870"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 08:28:28 -0700
X-CSE-ConnectionGUID: Gnf0r/AJT3q3dQn8EEsw2A==
X-CSE-MsgGUID: Ic8+6FHiQA+WYeQ+2V0SbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="161475482"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 08:28:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1u54gZ-0000000CtkW-1J0u;
	Wed, 16 Apr 2025 18:28:23 +0300
Date: Wed, 16 Apr 2025 18:28:23 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <Z__Ml-NvzgC8-ltv@smile.fi.intel.com>
References: <20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com>
 <20250415-losd-3-inv-icm42600-add-wom-support-v2-1-de94dfb92b7e@tdk.com>
 <CAHp75VdZDovPuRqQMpP=TkjeBr9AgRssPFJfmsjnXC=wUXxFHg@mail.gmail.com>
 <FR3P281MB1757B4BF12AD9F6AC5F8F361CEBD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <CAHp75VciPdgt13GbWtH08_k-f6VHQ-e3aA+CibKNAS6WRWE9Ng@mail.gmail.com>
 <FR3P281MB1757AA98627383BC411A35F5CEBD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FR3P281MB1757AA98627383BC411A35F5CEBD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 02:40:50PM +0000, Jean-Baptiste Maneyrol wrote:
> OK, understood.
> 
> But for this particular patch, do I need to stay consistent with the existing
> driver by keeping the standard type or use kernel types and mix with standard
> types?

Yes, consistency with the existing code is priority, if the change is a fix.
If it's a feature, better to clean up first (i.e. switch the types elsewhere)
and then add a new feature.

> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> Sent: Wednesday, April 16, 2025 15:06
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> On Wed, Apr 16, 2025 at 3:41 PM Jean-Baptiste Maneyrol
> <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> >
> > concerning usage of kernel types, my understanding was that we should
> > conform to existing types usage in a driver. That's why I'm keeping the
> > standard types instead of kernel ones. I could change them in the patch,
> > but it would mix usage of both standard and kernel types.
> >
> > Another thing not related, by reading the coding style documentation I
> > would think that for new driver we can use whatever we prefer between
> > standard types and kernel types. Is it not the case?
> 
> It's not for the repositories Greg KH maintaining directly or indirectly:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20170411140919.GC4388@kroah.com/__;!!FtrhtPsWDhZ6tw!ACor8Q-WyU0CorzLpw0OtWqNk59Wn2Z_s7KKOZuNnglKBzN4jTqb3c6oea83KLER97bFxkEIgSl8_IcKHTxvaRKCUwVCP5wunvo$[lore[.]kernel[.]org]

-- 
With Best Regards,
Andy Shevchenko



