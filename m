Return-Path: <linux-iio+bounces-26702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB68CA0048
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73897304F12F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5836C5A0;
	Wed,  3 Dec 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZX4QjcS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6636C58B
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779514; cv=none; b=qqDXi4TgVUXDOJ2idd4cefFlDJ5mVQ9RNlHIFLP3DVaRLs/JNoCkVdjD4xCOz4rLWtv2bNCWjrW36YfjgFilA+7lUGFTZxuG87sxU1o0eoZTzGUr+8fzClOM252rvI2EEXPYwf1jsKMasokvGkxRRpA4xLWk2cDpWa5U1oop7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779514; c=relaxed/simple;
	bh=yV5vZHXGbBd32RkaJW/K+8xXWFo207XQM2VaZ4hQ4Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ynbrk+q2pIr2jOvK9boTDFEhh4BtaoxneQzq6xuu4NnRtX1G+ObrPKDwI/WVExeC0b+krxo2ccGHg6EEauUV4hd/V4aYBTD7fxSb3y8WpoxlTUZ0mJsSPuz+l+54IkeTkZoOXEboaTFrq9r4FAYFEmYNGUlAqXp4LRiqB8J7FwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZX4QjcS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764779513; x=1796315513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yV5vZHXGbBd32RkaJW/K+8xXWFo207XQM2VaZ4hQ4Qg=;
  b=ZZX4QjcS+ScG82qOqAt5LlI8hupNrAlfEikQbOCzf5ZEt1nK+9tiXMiJ
   LcmKZlNaKHrdFP7vtKakyXQI7vXHBaPLYT9WPHmGTIjvsOgwvE0f+ViFH
   aQYZJcFkR9ChUNxYIJDtJkDTH9/CDNgXx7cn/8jXTxHqSxAW8OMpdNG+G
   infrE9n3Gq560v4GCTYHuh6Yo6Qwio0car3fCT+BAUT2R4Uzdx25RsswZ
   W8J22g2yMMPCtvSJqGa5iI8qQHUfz+8+OGLyeBKR/+OcdN+2CdSukSj7m
   bn0Mgw1TMWFsx+2SieZLBfm38lOrD8lknGQc/LErnIkGG81eIFv0sCm1b
   A==;
X-CSE-ConnectionGUID: CaesbRugQGWOlH2SAhTZKg==
X-CSE-MsgGUID: wFrqDE+eR3CMAvbC3AG9mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84377680"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="84377680"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:31:53 -0800
X-CSE-ConnectionGUID: ONzlZO1WTzy80IaHnv6CrQ==
X-CSE-MsgGUID: MId2YwuJRN2xvqwa85FMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="199149703"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:31:51 -0800
Date: Wed, 3 Dec 2025 18:31:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 6/6] iio: buffer-dmaengine: Fix coding style complains
Message-ID: <aTBl9U1KS__Lkfbt@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-6-0e4907ce7322@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-6-0e4907ce7322@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 03:11:41PM +0000, Nuno Sá via B4 Relay wrote:

> Just making sure checkpatch is happy. No functional change intended.

...but trigger the fighters for 80 rule!

-- 
With Best Regards,
Andy Shevchenko



