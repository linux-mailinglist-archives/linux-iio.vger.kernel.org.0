Return-Path: <linux-iio+bounces-20548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95292AD70EA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEF81BC3700
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE6239E6B;
	Thu, 12 Jun 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/obIHik"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F92356CF;
	Thu, 12 Jun 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732993; cv=none; b=raGLqxrYCTXpUoA/khEzrH8i+7NFmoLGr7zLl6reaqkds3sEp3S7lGSivhtQ2IbIaEiFXgezkmMrdAfHbp3q75gL1uKutX3IwvUHzJL4VjjZeB6n9WKjbQeHYLJBm0xaAmyzFly+VJgCzaLka8oU03givN992qOGKT7OIws69AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732993; c=relaxed/simple;
	bh=5VQcWOVMTlAY0crpaeUn5nwVb3YtFrMoZYFeJE9THBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUUQ/AkPfAmntJpEMbJblW7chQQJNmFAYylJjlmpkfTy/ZQjdUqJDiKzP1Eemvz79Zh4lPtqNXpbaOiwRDHliiU1AnIv749Vsp2PZH6X5721Z34ow+iL2Zdo2W1WVbHigDadKVZeesrVTmM+ymt4eGlCtUop69spExQP7kEu7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/obIHik; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749732992; x=1781268992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5VQcWOVMTlAY0crpaeUn5nwVb3YtFrMoZYFeJE9THBU=;
  b=B/obIHikTT+VQvGeGX27TCLTbzxN5C+Yww2pagWvboKtY923Noloz3MU
   ISCjGrvIBG5SxzffgeAzpHNrLRaWQqID5Oz7gvtbWmRjSCGX9zt9XNzon
   cVXr/rndquVgcv8kg9GKR0498iR46FIjkKD1wvwtTLGyUiB8MVHvQSDR2
   rDt6J5gcRwsTezFqPAnLqQfmv84L+4osKuOCvT0uTY1fWoI3/ZVOAV70r
   /pNemOjZo6LG5GbVoVDzIisvFLqMRjxtJTqEMCuWs755W6WYIGM0NXvcS
   ZvNtJv1AtkjTcZI8OLF6eOsH7AEjYqSQ2WnKKjD96k+TNmc2nC8SljQ0C
   w==;
X-CSE-ConnectionGUID: K3cCyovKQeyNQ7RGRHcGiw==
X-CSE-MsgGUID: N7nyWYe+QZ6b3gJppPVwtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52057184"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="52057184"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:56:31 -0700
X-CSE-ConnectionGUID: z3MHPM8yTDWh3VS/ZZRMlA==
X-CSE-MsgGUID: oWyZ3jJWR3eCPoBxFN1jCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="148405195"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:56:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uPhTm-00000005xCP-27aH;
	Thu, 12 Jun 2025 15:56:26 +0300
Date: Thu, 12 Jun 2025 15:56:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	jstephan@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] iio: accel: sca3000: replace error_ret labels by
 simple returns
Message-ID: <aErOevItBLmKm4Jv@smile.fi.intel.com>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-2-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611194648.18133-2-andrew.lopes@alumni.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 04:39:19PM -0300, Andrew Ijano wrote:
> Replace usage of error_ret labels by returning directly when handling
> errors. Cases that do a mutex unlock were not changed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



