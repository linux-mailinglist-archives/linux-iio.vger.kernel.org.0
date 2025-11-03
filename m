Return-Path: <linux-iio+bounces-25832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B3C2AD08
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246583B5E46
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA032EFDA5;
	Mon,  3 Nov 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGr1HiU5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAA2EF673;
	Mon,  3 Nov 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162852; cv=none; b=PkH072Hnjuqlag9lSiBb8nDZqC6hV2h6AAdpL5lS8mLL3AJ753jyCO4OG2UZxO+dC/65UlT8n1JZ6+8Vwu5EVxMc4b1hlEf3Q/IfuS0uCgPZkdhKECMv73XEWXMnfJLg3CJB2ONJq7U5fEo2Pa/Dvlmzn1RBRLA6aCQzosRLpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162852; c=relaxed/simple;
	bh=dehoV9KLM13JDfOGG3L/KDN69atezT+OU8bv2DS9BCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3evDfBhtrr6FaHD1aQIWMMZ/NaJ00yFMuTShjlWtF456ITN1v64xd7z+aQCbBbxtsYSYxdR8LdPxui26UZqMntg0OtDtpGdraDeWCwTeJ28s4AMdTcc455yU4fWmo7lU8VXcfVi9oWqYBoneqDdxH4Z2jUYpIrmFq7LWIkMn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGr1HiU5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762162851; x=1793698851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dehoV9KLM13JDfOGG3L/KDN69atezT+OU8bv2DS9BCo=;
  b=hGr1HiU5iLAy6we+zQ/9m2sWez0++NB+Bto694idxY/D8cpkpxrR2457
   coM5v7mkl2Q15sf2JDIR41y9ML6mBlWtWsjpJr0ARG4M4d/J5nxwcV67W
   8g9j+MIQ8XqYpOozG8+JBi/C+m1KXE2Jp1wE1LfeA5w0+5jwNNjHW4Q+X
   8fflc+w+ArkshigRt/ehTjmo5/3Icl6ONyVH6UrzdVUq+F0OfNWXJZDEd
   dOZdt8CizKOnkjkqg/dRUynbnWJKDwcv172DsYu5oPlzOSKoWUZJi2cQL
   lXACC5qBxNkiE2EtnMV4apI6WjYUJUVqGYjmKI3sPTj0H0zJZXUG7WZ14
   g==;
X-CSE-ConnectionGUID: 3CWCUFPtQhWVAmpUJcU2Mg==
X-CSE-MsgGUID: UBJdOWsTT/OpU6mJvGO8mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64272767"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="64272767"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:40:51 -0800
X-CSE-ConnectionGUID: s69GYdGMQWCeCbeKqYwTUw==
X-CSE-MsgGUID: 7iB2PpBVQMKqYZ4pvSgfEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="191164298"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:40:49 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFr3M-000000056qo-1p96;
	Mon, 03 Nov 2025 11:40:44 +0200
Date: Mon, 3 Nov 2025 11:40:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
Message-ID: <aQh4m25uVBV8A09F@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-7-flavra@baylibre.com>
 <aQMbb6BUBHQUXX9y@smile.fi.intel.com>
 <32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
 <aQNs8VVoStUJ6YHB@smile.fi.intel.com>
 <20251102112958.435688d5@jic23-huawei>
 <CAHp75Ve2+eU2X30EvC8dOuhEo3XZBwFrUH60itEYdYdGM7HvOA@mail.gmail.com>
 <25732d2be08156b4f55e97f5306d1fd080255ae7.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25732d2be08156b4f55e97f5306d1fd080255ae7.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:34:28AM +0100, Francesco Lavra wrote:
> On Sun, 2025-11-02 at 15:45 +0200, Andy Shevchenko wrote:
> > On Sun, Nov 2, 2025 at 1:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Thu, 30 Oct 2025 15:49:37 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > On Thu, Oct 30, 2025 at 12:10:08PM +0100, Francesco Lavra wrote:
> > > > > On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote:

...

> > > > > > > +       *val = (data & reg->mask) >> __ffs(reg->mask);
> > > > > > 
> > > > > > Seems like yet another candidate for field_get() macro.
> > > > > 
> > > > > FIELD_GET() can only be used with compile-time constant masks.
> > > > > And apparently this is the case with u8_get_bits() too, because you
> > > > > get a
> > > > > "bad bitfield mask" compiler error if you try to use u8_get_bits().
> > > > 
> > > > We are talking about different things.
> > > > Here are the pointers to what I'm talking:
> > > > 
> > > > - git grep -n -w 'field_get'
> > > > -
> > > > https://lore.kernel.org/linux-gpio/cover.1761588465.git.geert+renesas@glider.be/
> > > > 
> > > True that it will be a usecase for that, but given plan is to merge
> > > that through
> > > a different tree in next merge window, it's not available for us yet. 
> > > Hence would
> > > be a follow up patch next cycle.
> > 
> > Yes, but we can still define them here. Dunno either with #under or
> > under (namespaced) names, but still possible to use now.
> 
> OK, I will define an ST_LSM6DSX_FIELD_GET() macro.

With small letters, as this is about run-time helpers (non-constant).

-- 
With Best Regards,
Andy Shevchenko



