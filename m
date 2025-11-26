Return-Path: <linux-iio+bounces-26492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DDEC8B977
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 20:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92FAE4E047B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 19:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B2340279;
	Wed, 26 Nov 2025 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKwjqm2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFD33F8CF;
	Wed, 26 Nov 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185709; cv=none; b=tPcT9YLsAu/IqDoqvieNvtMLeR5Sdf/bJywlfr0wkYvIbn8sNVcTbasBZhenPb8vaOHILTw9VA4cgAFg3Ll62PDa5+afv0bSxMTlv91PNXEBzz6uVHQdIpuLmf/vL2PuLNelz0njm3zozqxVahuhO0AX1hMqfwaVTMVn6/orG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185709; c=relaxed/simple;
	bh=V/tY/LkE5aM8Mi7kUDYdcTMk4q+TlFr3zN8NEXuctqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDJAOAu4XmRo5NpKlhO7fBwhcNYO7QLkeflZf8QMMPdHcp96T86sUtiBDo9RmEaqEhPSuCJRGM7sJoXe8Hx9rEVnZV5zqN40gizTCnvCjsIBDzGQccW9HglKtIBD48gebmkirmdWM5p4b+S90FSXoRZ0CaIyHRALtIL3EO+rCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKwjqm2/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764185707; x=1795721707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/tY/LkE5aM8Mi7kUDYdcTMk4q+TlFr3zN8NEXuctqE=;
  b=LKwjqm2/artiDLCxajLRaGDN60tHf/AHuhLnsQMbsd4JwE5KOu6KpVyg
   rKTgvC3f6XhK5XSVJigFpgRn87taA/F7+hThI90K0p12THTiYAn3zCNH4
   aGuOykEOPi5PfyGdU3dttmnqo6tPiqRABxZAITQKroCvMka/GkKDQU3Uc
   wE/bXban7QA9aIiC2OQPglMyXEq7caaXjWzNwuJ1f2saEYRgS0bWwAsuF
   AHEvX9xd6MkSEXITAVwWNCcJMDZqzDQQ11biZ0x3FqwOHF2ygMDqQLC4R
   Wh9HBFq8F3J9hWumdbOm49HDOe85pd3+P1eaAz+N9nM8h2dUNvf1IX28f
   g==;
X-CSE-ConnectionGUID: crA/YPnbR7au/g99Fs+inw==
X-CSE-MsgGUID: 1h+Dy+S0Soiz89yop1nSDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66266235"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="66266235"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 11:35:06 -0800
X-CSE-ConnectionGUID: wSVj+NBFS6Gqarr0L9KDWw==
X-CSE-MsgGUID: 19qz3E/XQqigtSwc35TZiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="193838126"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 11:35:04 -0800
Date: Wed, 26 Nov 2025 21:35:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: isl29018.c: replace sprintf with safer
 alternatives
Message-ID: <aSdWZQmmvlvJr-Kn@smile.fi.intel.com>
References: <20251126172432.5532-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126172432.5532-1-tomasborquez13@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 02:24:32PM -0300, Tomas Borquez wrote:
> This patch replaces sprintf with sysfs_emit and sysfs_emit_at safer alternative

sprintf()
"...sysfs_emit() and sysfs_emit_at()..."

alternatives

OR

"...sysfs_emit() or sysfs_emit_at()..."

> with no functional changes.

...

> -		len += sprintf(buf + len, "%d.%06d ",
> +		len += sysfs_emit_at(buf, len, "%d.%06d ",
>  			       isl29018_scales[chip->int_time][i].scale,
>  			       isl29018_scales[chip->int_time][i].uscale);

Forgot to update indentation.

...

>  	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i)
> -		len += sprintf(buf + len, "0.%06d ",
> +		len += sysfs_emit_at(buf, len, "0.%06d ",
>  			       isl29018_int_utimes[chip->type][i]);

Ditto.

-- 
With Best Regards,
Andy Shevchenko



