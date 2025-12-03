Return-Path: <linux-iio+bounces-26697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92838C9FF85
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 808E13007244
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332DA357A5D;
	Wed,  3 Dec 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBvjANV3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1F357A4D
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778828; cv=none; b=G2SLs4Q7dP9drQbIDvFXfRlc8AncVECcmkI99cUZkJkAsfe3tR29Rdpr+a7okKMb7sjYu7FBWUavgrJJ2RPLzBOSbtrPuaANWcQJ8wnJCsnDdRFwnztbVh9LgVrrGVS26NYJtZn4QAUnHBdd42cZiARWx0EqDpvsZlu297SpR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778828; c=relaxed/simple;
	bh=diPez7Gr+6e0zYI/4QI7wgbyqJDhXwXsw1nFKS8sEnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLK6W66v3v6ShliAtxBVZgFdcXiA+v+FApnIXPNJCajrb4QOng1hkDOZGAC0rCBD2O5KKLuTIs9Cyp0kfnIOXuksI9A6qOSSMbkqVVTIfWIfbAdS6+1DKHIrpdoaNBOc+JLGNtBu9StbJbdF6Y87FN+o156FcNAGtB1I9igrZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBvjANV3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764778826; x=1796314826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=diPez7Gr+6e0zYI/4QI7wgbyqJDhXwXsw1nFKS8sEnE=;
  b=eBvjANV3aOSu8j09zWwZW/LsBI4638mgdX38Cg0hS4z78HIcT12vqg4c
   T6DltauywKo/8EOijp4L+ym/wSPJPAraa02v6WLcuUusao91nTk3CPmem
   lT1sMxcI1gi8cTDAf5p0C6JZxosVKXtWUcW3vjTZZ1miZG9J6sK0bAD61
   6vPmHNEJuYI6/U1YJvvoB12cl8N7hJxWwDbr/Yy5LRTinDQ3w2rhqHSyi
   Kyi4RC9KLfZTFm4uEbddYBiyd3ECISyXPyXfL6RoZNdnL9AcEgVinhY+0
   TUFcrwGOUvdm7qbd2Wl0YpXZqNUel3m439UrGMgs664CJE7waOe9R4sZg
   g==;
X-CSE-ConnectionGUID: dcBMmxS5S4OdYKaC/ja60Q==
X-CSE-MsgGUID: xKR6Q5ZFSkSkfHnuKJckag==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66499916"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="66499916"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:20:25 -0800
X-CSE-ConnectionGUID: pa4BZQuQQiW2SJZThoe1Nw==
X-CSE-MsgGUID: wUuu3qj+TZqw+/l0NO2rtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="225405096"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:20:24 -0800
Date: Wed, 3 Dec 2025 18:20:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/6] iio: buffer-dma: use lockdep instead of WARN()
Message-ID: <aTBjRQ-FLZizHZn7@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-1-0e4907ce7322@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-1-0e4907ce7322@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 03:11:36PM +0000, Nuno Sá via B4 Relay wrote:
> 
> As documented, WARN() should be used with care given that it can panic
> running kernels (depending on command line options). So, instead of
> using it to make sure a lock is held, use the annotations we already
> have in the kernel for the very same reason.

Which also will be a WARN :-)

I believe the main value is a bit different here, i.e. to have code being
annotated with the existing infrastructure.

In any case I support this change
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



