Return-Path: <linux-iio+bounces-14744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB354A23395
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 19:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A581886156
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA821EF091;
	Thu, 30 Jan 2025 18:11:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB684D34
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260677; cv=none; b=SIsZFRurFX5JxPgjCd25Tt8iwlxE80RPh7b49ObYcChWU1ETc1K5IyvYe34QjDROvcSuDNseYC9ae8bsQ8qO1G/ikUOoE8Jacg66Gs0eL+6e1gh1TuBIcNBbG5P8Sp5F6mxlymEgdVWJ9URHvhcAFS9oAPQUbPEWbrumtVuSxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260677; c=relaxed/simple;
	bh=Fc1+8CxV2l3zs553BAJQB9mcR4UrYTnHGNYMRcwwbPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpVMAt3d/bJucukV1f8R4vfLCGNlkInndCsuPIQe/ZcbtA9Gxi9JRj1a9makz0iowFQlSpDOkCIOYpBz98mHyNGSWocSZipLYPvkMRbOlB8cdR5NpMs72sxKpkv/7yhitEEim/96USk1YTFKP3nXLLnjYLRbiKQ1dhzO9EYQiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Zgq8kyRMRJKtl0NcwwBWkw==
X-CSE-MsgGUID: aZIdnhJDSSq7mdNT188sDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="50208480"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="50208480"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 10:11:14 -0800
X-CSE-ConnectionGUID: 663BVU+ESk6ypWJh6wVYpA==
X-CSE-MsgGUID: RrWKynwGSieBpKR0sx8J6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140295729"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 10:11:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tdZ0O-00000006kCj-2VkH;
	Thu, 30 Jan 2025 20:11:08 +0200
Date: Thu, 30 Jan 2025 20:11:08 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad7173: Fix comparison of channel configs
Message-ID: <Z5vAvO1jD0K29FmY@smile.fi.intel.com>
References: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
 <aa397f3749403477ee4a8f416b5890099f430ca5.1738258777.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa397f3749403477ee4a8f416b5890099f430ca5.1738258777.git.u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 30, 2025 at 06:45:02PM +0100, Uwe Kleine-König wrote:
> Checking the binary representation of two structs (of the same type)
> for equality doesn't have the same semantic as comparing all members for
> equality. The former might find a difference where the latter doesn't in
> the presence of padding or when ambiguous types like float or bool are
> involved. (Floats typically have different representations for single
> values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
> at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
> true, but memcmp finds a difference.)

memcmp()

> When searching for a channel that already has the configuration we need,
> the comparison by member is the one that is needed.
> 
> Convert the comparison accordingly to compare the members one after
> another. Also add a BUILD_BUG guard to (somewhat) ensure that when

static_assert() will give a better messaging.

> struct ad7173_channel_config::config_props is expanded, the comparison
> is adapted, too.

-- 
With Best Regards,
Andy Shevchenko



