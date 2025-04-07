Return-Path: <linux-iio+bounces-17740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A0A7D918
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D8616BEF7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AEB22F160;
	Mon,  7 Apr 2025 09:11:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18721D011
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017115; cv=none; b=SfvOtOMPksNYYEJVcXBLkltoirH/xxG4NUhMYqAcfOZjID5kGMYlQUYX1882V6PEmpjsEYKBRgtvs2cfYO9J6UiJe+8RwR5pmhXsBG5hAX9k9cIhTWXdanHmnu8snkqF+KIRgyTc897S6Su1Q7OvPU5/bWF00XaXxueAvCZpZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017115; c=relaxed/simple;
	bh=yb5/Pw6Y5hiwMfPe03geu3m8HKsFeIkn9fRfaNG/Ccc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6TvwM/QHz9i4zryy6vi8mrwnTilY/FeI5F9No34O7c892o102haMmQdiHuMCEqSzylzqZA5lcz910Y2VWZMpdjgx3W6eg1Xy8T4foa6VVDK+zCV0jhRPDkc6A19FBmzg/t8HYH4jL+rD6bHSoR8dGt2ALtYbZisRuFOZHRNW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: GQ4T2+vIQSKZEgP06u24WA==
X-CSE-MsgGUID: RaMpXAkhRFiTgtUlPNR6gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="49045508"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="49045508"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:11:53 -0700
X-CSE-ConnectionGUID: u2Z6Hh8ASEmIb5c/ZCV9DA==
X-CSE-MsgGUID: OTqpilMOSsaNdEO4URjYEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="128222347"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:11:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1iWC-0000000A0yk-2bA5;
	Mon, 07 Apr 2025 12:11:48 +0300
Date: Mon, 7 Apr 2025 12:11:48 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 03/20] iio: adc: dln2: Use aligned_s64 for timestamp
Message-ID: <Z_OW1K3TWim1ncIz@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-4-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-4-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:44PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Here the lack of marking allows the overall structure to not be
> sufficiently aligned resulting in misplacement of the timestamp
> in iio_push_to_buffers_with_timestamp(). Use aligned_s64 to
> force the alignment on all architectures.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



