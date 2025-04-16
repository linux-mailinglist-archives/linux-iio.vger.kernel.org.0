Return-Path: <linux-iio+bounces-18164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA3A8B7AA
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 13:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCAE5A0ECC
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C5523D297;
	Wed, 16 Apr 2025 11:27:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C861221FDC;
	Wed, 16 Apr 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744802825; cv=none; b=d9EnvhbZ8DmZRO6zrVGueA0X6ind2PUg5h/qg1HS/MWnEC6FAue0oGxROwTSRo8wKPF7bl3EMmmhbydeuhlvycw5qyRVJnPm9ju5X76EOdbrzU12UEW7EX9JbCPWnvrktC/OkL9p+ijE7hHlnjZ1OiCT0Azekjk9pbK4HeNwtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744802825; c=relaxed/simple;
	bh=98d1DazeTGeaIZptiNcIburiw/CHNUg1DwaYADTKS+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5gBo6v4yTh0MolUiPdc2zgwTlDOZ5yutDEGeSO8ti2WdZyH11hVdBGJnoQwI1a4TL5vFageLEx2wKg8cYXebqMDDoBRYjX9OlLR9jIUfBWtBCm/KGsw6b+4mjQM+4GPV+PThbbFPrQpvdHev0YCTZxxohO5M25bafIiGf72GJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: fcN8r1ixQ2qAD/lHrXCiNQ==
X-CSE-MsgGUID: cpiDv62AT7GxpkCaHiMhbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57711676"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="57711676"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 04:27:04 -0700
X-CSE-ConnectionGUID: tWNrAjUfSAyMDyiqv4Ti9Q==
X-CSE-MsgGUID: TE6fxFmKTzi0+ZNEL17EiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130459644"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 04:27:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u50uw-0000000Cpsh-3qeg;
	Wed, 16 Apr 2025 14:26:58 +0300
Date: Wed, 16 Apr 2025 14:26:58 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iio: dac: ad5592r: Delete stray unlock in
 ad5592r_write_raw()
Message-ID: <Z_-UAozhav-hMFrT@smile.fi.intel.com>
References: <Z_-P7bsD3KL5K25R@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_-P7bsD3KL5K25R@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 02:09:33PM +0300, Dan Carpenter wrote:
> This code was converted to use guard locks but one of the unlocks was
> accidentally overlooked.  Delete it.

Yeah, looks like missed one.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



