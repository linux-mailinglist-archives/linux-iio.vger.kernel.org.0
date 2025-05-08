Return-Path: <linux-iio+bounces-19345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D10AB0393
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198101BA71C2
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FA528A1D7;
	Thu,  8 May 2025 19:23:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D31F582E;
	Thu,  8 May 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732180; cv=none; b=Jp3N8gdOk/5LT4tFKRIP92I/XJCtqw1xco/TcH3bA30sh55n5Cwl6NQBmaJHnnbSXlmGMo1qg7X6okiZorxGwcNtCKP7ZVtdLh4FX14ocnZ6XiBUfiiMAC+c996YZgwoycprailrJgYINcgUPdO5AecDe+H/y2tRGbWyaJ6Hqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732180; c=relaxed/simple;
	bh=3Cs92MWEtl8t/znHMEFBtrB1VsZUoHQ/AVInriHWiow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhSuImFhGX+2CzwZhXEv+W79ZbRl/2fGhcPo/WexuwZPhJhIxJXSuOVleZLfxyd/I6VTjpptXBDDUjn0THu46oS66p9CVEcTdXPN195q8i8jkKAZaWgisAG+37+77yTl8PFWvqYK2+nZki80bmP9mYUfRMGrD8xrFa1ufbpkRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: xcmifW+bSeeJtlIZXHO9vg==
X-CSE-MsgGUID: VZMFSwzcThqRDKQspzz+Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48650052"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="48650052"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:22:56 -0700
X-CSE-ConnectionGUID: GBX/tAdkTO278QtrggWbOw==
X-CSE-MsgGUID: jFcTJWwOQLy2JUXsT4R9vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="141590824"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:22:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uD6pS-00000004D9m-293I;
	Thu, 08 May 2025 22:22:46 +0300
Date: Thu, 8 May 2025 22:22:46 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v7 01/12] iio: adc: ad7768-1: reorganize driver headers
Message-ID: <aB0EhqbHd4QXmvxq@smile.fi.intel.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
 <1f7677d31a0165cb30d7eb3b4d613e1337937f9a.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7677d31a0165cb30d7eb3b4d613e1337937f9a.1746662899.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 08, 2025 at 02:03:04PM -0300, Jonathan Santos wrote:
> Remove kernel.h since it adds a lot of unnecessary dependencies.
> Add specific headers to ensure all functions and macros used in the driver
> are directly declared.

Suggested-by: ?

Nevertheless,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



