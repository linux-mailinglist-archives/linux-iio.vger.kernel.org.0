Return-Path: <linux-iio+bounces-26704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B1CA0D0A
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 19:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D1E319A745
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18814346799;
	Wed,  3 Dec 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQm+Hq9o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C03446C4
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779704; cv=none; b=YwTqQ4IiBGr26hzFKcYuRu6mtmKtv2yZy16Glm8/7n+CINx4SHUblw1O+I2kWgRHR7BKnAihWkpKEyz8eO2r8dpKHJRyJZBSqJOq49pW+/xD0nvTxpErjVPE70f3vKemmUzu6KvanaBLL8D6EluxLgDe70APc1Bq9Jq2Jro8wLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779704; c=relaxed/simple;
	bh=1Ff3ZIzYM6U0oExFkCr+cQ2E0ZWOCEfHu5wAFyKyLJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h08OZDUpGLpKrztN4qmUlWZ9+dRLT/AKhu7zjD7nYn6ZVoFFE0XEiQncq9WelN3RgpKh9yda3dimNTNSnqMKPS0/RMynsy703UlmX3ieCMT7dauX1X2+Z15YsuVxOiyvFhtHQNuxFXuSYfJZ/396W3P8I31XTeJZ5Rz6BzPTh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQm+Hq9o; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764779700; x=1796315700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1Ff3ZIzYM6U0oExFkCr+cQ2E0ZWOCEfHu5wAFyKyLJg=;
  b=hQm+Hq9oEX+N6U1dSOgWi8wbFdj3GgG+hwjtuXs7w8wXFVzpV/u3IC9y
   1Ta0qx1vSKMiZFX+Ma9hEvRvnBIE2XjsJupgYq7S6BlWUT0co9lfXgggG
   OVDMxIPJKBaUixI/9DGQAKAulHIqGeUUyRhDBbFBOL2gBProR6mayO9sT
   troDANB6cPjV6/PX7Vc1OZSCTULrnUeUp5Epa7GGNqlqPVZMuD/tevMj0
   i7sPHYCFM90krAODdOplh2vUde6ljE5rO+w3Mnl1JPt6ktpzQbwNulWxj
   aK6Cy3l++O8q0pDvpSGQgbcXteQDZOun1YL1JhSD3ZUWAhPGHA9DB7Cfe
   A==;
X-CSE-ConnectionGUID: gYQxaT2tQFK8Vs8eWUSzCw==
X-CSE-MsgGUID: f6hYixQ9TB6lUwkDevAjbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="54331231"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="54331231"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:34:58 -0800
X-CSE-ConnectionGUID: a/Yb/cOmToqzYdeSs4vD/w==
X-CSE-MsgGUID: 602J7plBQNO5j+nip6f0MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="199197251"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:34:57 -0800
Date: Wed, 3 Dec 2025 18:34:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 3/6] iio: buffer-dma: Turn iio_dma_buffer_init() void
Message-ID: <aTBmriwVrMwlKiXX@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-3-0e4907ce7322@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-3-0e4907ce7322@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 03:11:38PM +0000, Nuno Sá via B4 Relay wrote:

> iio_dma_buffer_init() always return 0. Therefore there's no point in
> returning int.

> While at it, fix a mismatch between the function declaration and definition
> regarding the struct device (dma_dev != dev).

So, all others use simple dev?

-- 
With Best Regards,
Andy Shevchenko



