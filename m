Return-Path: <linux-iio+bounces-27533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28AD001B0
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 22:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF6D3045CF8
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41403338F5B;
	Wed,  7 Jan 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITi58j5Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68961338F40;
	Wed,  7 Jan 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819900; cv=none; b=sZorK4mwc7sPZ4g+9K+wzm5f0gmZ6UfnPv6Ldr/Ht3ed7r1D2bRAzYztiAwDO2Trw87i/gqVM0G45WihXJOnBUCX/n6Kgq9sgvbCd+lSxSxVN4HsLysEd8i0uL0OyAov0eR3VHEjg/5q9AiDFSd0kVPJh6p1kL/6g1O/mbE/iGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819900; c=relaxed/simple;
	bh=B49lYPR21dBOlhf27eCzjOyf3dFDv8GA6LKS41ILDnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1OoOIRsRdF+GstZfgk2O8MPLx+zr0Ox26GF6pQFX9wKlgwiyhlsJitgGD0g5EOIrNmTJoyiF2B9sWK9mYeVdT23xBuSNPs1Rx6hDvpechBEZFLliA67ixNw+reFjjn6Qy+E7x3uduGCl+S4YRBHMIhxpquJ+Ml2zZ5pah2yMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITi58j5Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767819898; x=1799355898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B49lYPR21dBOlhf27eCzjOyf3dFDv8GA6LKS41ILDnU=;
  b=ITi58j5QezDOvCTL5bIMRRhUf63wzJGxxL33OlUKCbG1XoraI2XlR/eo
   6HHe9RmPmmhLucpIpSKskRfV82u4wI2SI3VrBDwdxPatpflWRDJ30qpzN
   xxHt1CAcBZazPN8gqviGRAFxsub/XsUmMoCi2pcurgYD+MT1YxB19Cm0w
   DlETwaU6lnGeS127TRDKTVo4bv58NkQqidomnE9bDLNZLex0JL+IKhEH8
   J6Ig+bw3BUMJLWh4WTJwUPid4nqPEc5/24Js5CM82eb2/FeKtKk//nfgd
   wqBVjzjJAuIFU/AoO9uSsi/sCEosMzZkJm1sHnsE4Vu4gDBM76sL7XxYY
   w==;
X-CSE-ConnectionGUID: qzL4tVFHQc2rePEtqKKkxA==
X-CSE-MsgGUID: LfKSRts/QgO46jyos3fdOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80650255"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="80650255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:04:57 -0800
X-CSE-ConnectionGUID: +xQXAbXdQdecu/iDuwVhZg==
X-CSE-MsgGUID: j2NqLM2IQHewWoDb9SG4Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="203077811"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:04:56 -0800
Date: Wed, 7 Jan 2026 23:04:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: bmi270_i2c: Add MODULE_DEVICE_TABLE for BMI260/270
Message-ID: <aV7KdXkQkI5XsoF3@smile.fi.intel.com>
References: <20260106054519.566796-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106054519.566796-1-derekjohn.clark@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 06, 2026 at 05:45:19AM +0000, Derek J. Clark wrote:
> Currently BMI260 & BMI270 devices do not automatically load this
> driver. To fix this, add missing MODULE_DEVICE_TABLE for the i2c,
> acpi, and of device tables so the driver will load when the hardware
> is detected.
> 
> Tested on my OneXPlayer F1 Pro.

No objections,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



