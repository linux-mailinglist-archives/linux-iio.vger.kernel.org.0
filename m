Return-Path: <linux-iio+bounces-20775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D72ADF4BA
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 19:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09981653A5
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C00304303;
	Wed, 18 Jun 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuajJV0x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC314303816;
	Wed, 18 Jun 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268485; cv=none; b=Wg/0fj16JcBskcg5LMBulkTBJZ3GO3Ka67N5rfyPx892EOaKugYIg6Rn+L+gu3G+m1d/rVQU4jEVKUr6/bZHdQq0PHhxVcFSL79mhMqt8TKVSoJMpiSNM5Xd5KnpcanQziIiwVkjP2NNfOXEB/YPaTdvEQKMP38BURbhCvV1Ej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268485; c=relaxed/simple;
	bh=JMu1Wlmq6ChnFPF7YJWazqaT52K3k8V8s8GmsfUM3nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO/I1dcd8GUbw2q2rLJlvQL/FHO32DVRCYSKaGqXgZbsSLo7PoUo7987fu3aLPoae6cRI7M85MLlCoANoXXZGq3EfpK291+UYoJel3VQW8VSZ5mOub74/xN5Up9WkbLyYAgcEn2jfTNV3+64HO4SE9LfQQChq4u/xQRWwae4ZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuajJV0x; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268484; x=1781804484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JMu1Wlmq6ChnFPF7YJWazqaT52K3k8V8s8GmsfUM3nc=;
  b=SuajJV0xa/iNwjLmgXXL8LoSbl8dUmoDSIWG7qy1kOLRbgwcRkKb41DL
   LKgR0gOPu6a/hxko2UZy1UHsZz7NywNEmoPSSKq7ktiDYuOtTyHbvLrBh
   1aWU9AA0wk6EL/nL4ExFi+OUu0M1VKNhXW1EBV17me9czmkkZK8ZTaLll
   IT+J627+bhMu5zbOK3Zq8Dq+r/rHGkjpSgML1LluIJJ5kJRDJxuB4YleH
   y9hnjA7aE7CwfQV5vgnTWfAPivfav9ecO4qhgQ2RjN1RM0zt2JPtpP+E3
   KETkuF6KOfA4yQJY5QAAPyvlv/CccYz5sZ1kX+by3Hq8qDAFtFiQTxcQL
   g==;
X-CSE-ConnectionGUID: HM3vYmksSNmWWbSuwhAxQg==
X-CSE-MsgGUID: VACEKxoZTcifnIQEBwCzIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="70075607"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="70075607"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:41:22 -0700
X-CSE-ConnectionGUID: JG/bHWfcRVquepWKjGOfNA==
X-CSE-MsgGUID: fpjdxPPlS9KTs3wv2NcenA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="180909963"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:41:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uRwmi-00000007oWR-32Tx;
	Wed, 18 Jun 2025 20:41:16 +0300
Date: Wed, 18 Jun 2025 20:41:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	andrew.lopes@alumni.usp.br, gustavobastos@usp.br,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	jstephan@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] iio: accel: sca3000: simplify by using newer
 infrastructure
Message-ID: <aFL6PE-8KLLKZun_@smile.fi.intel.com>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
 <CAHp75Ve4yAp6sViUWZY+0abRoNZ0W+rQLCmsbijEcrh8kguVOA@mail.gmail.com>
 <CANZih_S9_8OdY=oKyVPBCTSTqYm_z_rkE=xbPym3uHOSsHMv6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANZih_S9_8OdY=oKyVPBCTSTqYm_z_rkE=xbPym3uHOSsHMv6A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 18, 2025 at 09:24:19AM -0300, Andrew Ijano wrote:
> On Wed, Jun 18, 2025 at 2:56 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jun 18, 2025 at 6:17 AM Andrew Ijano <andrew.ijano@gmail.com> wrote:
> > >
> > > The sca3000 driver is old and could be simplified by using newer
> > > infrastructure.
> >
> > I haven't found any reference to a base commit here. Have you
> > forgotten to use --base when preparing the series?
> > In any case, please clarify what this series is based on.
> 
> Thank you for pointing this out! I think I forgot to use --base for
> it. In this case, should I submit a new version of the whole patchset
> with this information or is there a better way to do it?

For now just reply here what is the base. I asked this question above.

-- 
With Best Regards,
Andy Shevchenko



