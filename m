Return-Path: <linux-iio+bounces-25450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CECC0C4FE
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECBB14F0A64
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50062E7166;
	Mon, 27 Oct 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4cnJE4P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25041D6AA;
	Mon, 27 Oct 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553862; cv=none; b=LF0x3ctEy2ej8hbExvmi+b7q/AL8NskTAnH3vIgNmYjGtuT0CY28TPED7cFFqMlmESJbD6wX7C6Lw06WMLdLBd71ggKidQ6YjAjTq0SBvZnTCRkD97QLch8RN2oC1v/XMp3CX5KwMHiARMpsPq8JhNPDP1/Zpe5ECNHwdoDv2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553862; c=relaxed/simple;
	bh=A5/SKv0LoCB75dMRgjs+vVsYbkBrNxa68MZbhjTXs88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVYPI8YZR80Mkrh7ZGkArA/l8BJPmKicef+/Ft6ot3zD+c1qYOtV1EJn5awpZBeuwqualt5yzILYtwQ1RF8JkvJCNdlHjicdSFT2coww0pcoc6ZLl8Hy75Rj4r9uBFVzRP7neCsDPUfivzaAOKfqYponK7sMXRPbe5Y5baJELAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4cnJE4P; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761553861; x=1793089861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A5/SKv0LoCB75dMRgjs+vVsYbkBrNxa68MZbhjTXs88=;
  b=e4cnJE4Po45XrFSHY/VHFzxO5woyexPkiKLuNT+8+2hECWSv9cPUk4as
   gsLY6l7DvcgVl6E6QVEqYBs5FHR92rToM+MUMZlcfESlTblez680J21bw
   XM1OyW1+O/w38prD3/RkmlLA8Gvu55dRxlwktL55hnCokMjFFghmPIGFJ
   5VJKDCWuwCsKzlLnzp2p8BYz7fDVuQ9sNSCs24NtPcVNqeJXX3GaGuCdF
   o1YUWG2YYq+SVWsvtk815YLuX98rg142w57USUCZPQd7Gba/W24L0UE5i
   jBnfOpAUEEc9RbBFlIhqo0vQcJGO+K5LKyrhRwZnnJkwMuHfv4nTmXrWN
   Q==;
X-CSE-ConnectionGUID: PQpfSZTkQ5yctdgiLYOD2A==
X-CSE-MsgGUID: ZHdauaiWSYagLfp3w6JvKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63721379"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63721379"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:31:00 -0700
X-CSE-ConnectionGUID: HtXxKZduTUG8wYB8pdWJjg==
X-CSE-MsgGUID: xL6z9lUdSEqM3pq8l9qOHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185335793"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:30:58 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDIcx-00000002wr0-0rbc;
	Mon, 27 Oct 2025 10:30:55 +0200
Date: Mon, 27 Oct 2025 10:30:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gary =?utf-8?B?Q2h1KOalmuWFieW6hik=?= <chuguangqing@inspur.com>
Cc: lars <lars@metafoo.de>,
	"Michael.Hennerich" <Michael.Hennerich@analog.com>,
	jic23 <jic23@kernel.org>, dlechner <dlechner@baylibre.com>,
	"nuno.sa" <nuno.sa@analog.com>, andy <andy@kernel.org>,
	"subhajit.ghosh" <subhajit.ghosh@tweaklogic.com>,
	"javier.carrasco.cruz" <javier.carrasco.cruz@gmail.com>,
	linux-iio <linux-iio@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 4/4] iio: light: apds9960: convert to use maple tree
 register cache
Message-ID: <aP8tvj_IPbv65m0T@smile.fi.intel.com>
References: <abf45488369cbcce6298cc0ea19c0b3a24-10-25intel.com@sslemail.net>
 <aPs9HdeTZKoqFqdk@smile.fi.intel.com>
 <68fc4591.1.gk94qBPVZajhk94q@inspur.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68fc4591.1.gk94qBPVZajhk94q@inspur.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 25, 2025 at 11:36:45AM +0800, Gary Chu(楚光庆) wrote:
> >On Fri, Oct 24, 2025 at 03:38:23PM +0800, Chu Guangqing wrote:
> >> The maple tree register cache is based on a much more modern data structure
> >> than the rbtree cache and makes optimisation choices which are probably
> >> more appropriate for modern systems than those made by the rbtree cache.

...

> >>   .reg_defaults = apds9960_reg_defaults,
> >>   .num_reg_defaults = ARRAY_SIZE(apds9960_reg_defaults),
> >
> >^^^^ Be careful with such cases, the cache implementations may behave
> >differently. Have you tested this on the actual HW?
> >
> We have conducted tests on some hardware, and performance improvements were observed,
>  though tests have not been carried out on all hardware models.
> Neither rbtree nor maple tree directly depends on hardware types (such as CPU or peripheral
>  models). Instead, they rely on the address distribution characteristics (discrete/continuous)
>  of hardware registers. The optimal cache type is determined by the hardware layout.
> Red-black trees excel at individual operations on discrete addresses, while Maple Trees are
>  proficient in range operations on contiguous addresses.

It's not about the low-level cache implementation, it's about regmap
abstraction implementation that might differ from cache to cache
implementations. This all in regard how the cold cache is getting filled up.
There is a separate discussion (unrelated to the topic of your series) where
this was brought up. That's why I asked how this was tested.

In any case, up to Jonathan, but I had to rise a potential misbehave, so in my
opinion this kind of corner cases needs to be tested on real HW.

> >>   .max_register = APDS9960_REG_GFIFO_DIR(RIGHT),
> >> - .cache_type = REGCACHE_RBTREE,
> >> + .cache_type = REGCACHE_MAPLE,
> >>  };

-- 
With Best Regards,
Andy Shevchenko



