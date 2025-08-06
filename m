Return-Path: <linux-iio+bounces-22358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2FFB1CD5A
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 22:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F771898873
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2BC218AAD;
	Wed,  6 Aug 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOsZZ96V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19331E25ED;
	Wed,  6 Aug 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511407; cv=none; b=YNJS6slEosz13qlkcXcX+wR47yM8uKEUONJSzQx+R1SqzySEW3NkZwHF6d8hMCfdmxw1vROu4JAL++AVwPp1MSmplWvO3zgp3Xt1KQ2a6oofFs1kd9B84EfRxTQ7StDifYSltP+u17CTP/artWDlkjXpo0SrlF9yS9GFmhOBX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511407; c=relaxed/simple;
	bh=4gm/NH9HY/tikjaWjy3lE604bY+UTfp8kQMIKS5FNJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQqbgMaIoZrZp1ejDgvsle+miaD43KB2FD8q0lX4V6hQG4GZb+EhLsFrEwuDF7qGLvTPzZw6rsud5g4Uj7cNsBAnm8E0BOYy7A1aKCF7ZQL6Wfs0mlKZOu3WCUwd7mYoSumdBCRY9lSfYcxy/Y04RaOQ7DgxeXP4fiImL3cR+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOsZZ96V; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754511406; x=1786047406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4gm/NH9HY/tikjaWjy3lE604bY+UTfp8kQMIKS5FNJk=;
  b=LOsZZ96Vl2+zM/Mu3D70PBZNLzrnZDU65qpr4E6afQ3N0V6TFL47pNwZ
   hmAQLaSGwNnMjhF8dhtwY3LRnyRRUidgTqqHx64rGug5oYKrN5RjEq2Wj
   SxoY92M3khvQhiPwnzUeEzBTNA1+3qfpGAcp7ZubqciPOGZiUJgBJZ00/
   nCQ/mOkKtsgQ3aHEILeP0j1eSB6llDJaYFEsJDQTZuefl7xJNuyiW+Qww
   L014m8QOeEPolbIybpDo2jx0IeATCyDFxffwpKHziHO8Fa8YJxFCZGcf2
   siQilrli0x3jlQL53H44W2lXDDIFYK02ErqROqCWoTQmKHQcb2aOz+FtK
   A==;
X-CSE-ConnectionGUID: K6zCkvkwSKuvrkrGghPLbA==
X-CSE-MsgGUID: tzMXo7mlR4yjMm9w3PCXWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44432761"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="44432761"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:16:45 -0700
X-CSE-ConnectionGUID: UVSa5MDXRdGp68OFidv6EQ==
X-CSE-MsgGUID: MBuF6LgeRgG3x6VdGLYL2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164110100"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:16:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ujkYx-000000046fM-3c0q;
	Wed, 06 Aug 2025 23:16:39 +0300
Date: Wed, 6 Aug 2025 23:16:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stefano Manni <stefano.manni@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad799x: add reference voltage to ad7994
Message-ID: <aJO4JyBhOnkVkqaS@smile.fi.intel.com>
References: <20250806090158.117628-1-stefano.manni@gmail.com>
 <20250806090158.117628-3-stefano.manni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806090158.117628-3-stefano.manni@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 06, 2025 at 11:01:58AM +0200, Stefano Manni wrote:

Missing commit message.

> Signed-off-by: Stefano Manni <stefano.manni@gmail.com>

...

>  	[ad7994] = {
>  		.num_channels = 5,
> -		.has_vref = false,
> +		.has_vref = true,

As Jonathan said and I implied the false is default. This patch should be just
a oneliner with +1 line.

-- 
With Best Regards,
Andy Shevchenko



