Return-Path: <linux-iio+bounces-20964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E49AE8BCD
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 19:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A3C5A6CF2
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E42D542A;
	Wed, 25 Jun 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XV0xBzNu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B631DB15F;
	Wed, 25 Jun 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874135; cv=none; b=id5XbmoK6lgGoPjfiYlgPcaaRGEmkUdLp2340R+/gozB8kj+ZWB7n3DW0WYYksIXCZ+RTAITYI5FPmAJYUm25V6NbYYvh/sAfx5kpXBmJixwO8CkVn1svibjqv9NF/laAMnBQMsofm8Qx90t1Z3kHxvcgtRGK6pgpyPQdbbf62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874135; c=relaxed/simple;
	bh=bc/an0HM948dBtrCpXDgu0KuaUudMg8ggwitTHr5qIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo8UgsgvMmE+K0t1QJj48FOtvXD/nrz2gfqgRlkLx0ODqELJ12wv3mybcMdg2YPj0rBFHtn2ZyfJHuYoXRgC3a4n5dXP/b5PNT6G99hB8W4t7gEOnGpH7mBmGUmBPhiHkc/NW6wCsCPLOl/nFuYkghjUy36IsSh/VdTF+Hp/15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XV0xBzNu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750874133; x=1782410133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bc/an0HM948dBtrCpXDgu0KuaUudMg8ggwitTHr5qIQ=;
  b=XV0xBzNuJZGTnUnUO9t9N7fNVutFvaCzJn+KRwEmQFiDfuHsgXbs7/A6
   SlFnRdJyuvHa7ZF2BRtnGgQu8mCqdm+U25E1dk4EdkyBsx1Mts9U17EMV
   Ma1QD3xUTsxfSYnbk7nF5Zi8V6Z6sUC1aPYxH7aa3RnURJhG8JyUrhtlT
   TgQVy3ZtWv5vwkSfQaEzHPpOumVJO+7tNouSSLvvL+LPtsbtgaoSd74fu
   /NiJUXo9Ucyw+4F52I2bGDvsUXfWd1UxPCO/P1xoI7wKo1UPrlR9kuU5b
   oDUYj/ShqG7dtcB1cij6/I4PehsU26HWX+kjEltXDR6eC8qOva9Hr4ywH
   w==;
X-CSE-ConnectionGUID: 5uGOrMJ4TSaE23v+1L1wHg==
X-CSE-MsgGUID: 8S0h16R4QQaqtTGa27a+WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53120048"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53120048"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:55:33 -0700
X-CSE-ConnectionGUID: jpdpmPXLRWawDZcdyJfwGg==
X-CSE-MsgGUID: 9nlGD+WXTPCJPw4inXrHaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="183179255"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:55:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uUULH-00000009w0U-3H8z;
	Wed, 25 Jun 2025 20:55:27 +0300
Date: Wed, 25 Jun 2025 20:55:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: mazziesaccount@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for
 adc121s021
Message-ID: <aFw4D0CMlUitvxhS@smile.fi.intel.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
 <20250625170218.545654-2-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625170218.545654-2-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 05:02:17PM +0000, Lothar Rubusch wrote:
> Add support for the single channel variant(s) of this ADC.

...

> -	{ }

> +	{ },

Stray change.

-- 
With Best Regards,
Andy Shevchenko



