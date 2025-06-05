Return-Path: <linux-iio+bounces-20236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03655ACEA1D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 08:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66667A8D07
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 06:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092581F1531;
	Thu,  5 Jun 2025 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeXeixm5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293862566;
	Thu,  5 Jun 2025 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104609; cv=none; b=EXrNKt7E2cY0fw8kM23KrUsTNssFizj4rOPrKa8HOE4wmPfBZnZ1ZHF0W24rpALhbqTsB7wIJmJAhBzUBmGd/KbAbRtA+G9KPHJEI+n0y5tUoOxssgJAoQqQckYf3uFP0fPjqw6tOfjwTpvnpSSYXf2jpMiIPSVVinAoX630ZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104609; c=relaxed/simple;
	bh=jBuHRfP899u5ghZRYqgzJi60BSxq6ObInAOlKjyOpxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9HxnmJWUWuYc2uDxV06ZL9yh2fW4/66ug9WW+XAhzZ78lEPGJfaPK2ds+arxfKUx2PuhZGDfKJqyTY1Q3WBy5ccundjW+BvcojdL8NEi4o/GC9u0pjJTGmBdZYiFcEIi2BTBidFWq+jNerIVp+GI62ubLCr4t60FV+oLYnOF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeXeixm5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749104609; x=1780640609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jBuHRfP899u5ghZRYqgzJi60BSxq6ObInAOlKjyOpxA=;
  b=BeXeixm5JXEt4Tj2HLCwXUy3jR1tSJwybxwN7WEWT3IuBLbcmzL1bEw3
   Pcc9v1ndD6SLqTJ4q6p+ISxX3/pmFFONvJjg8cNq74crc7ITT+UNV0GmX
   /86fj7Fb1i6XQ2Kre/wy2eMFREptcXQaPzXHdzAE991If9eNFhs8JR/sN
   z3hXWxmsRD/h9D3ANJ3UXVVuqDbm6iqMgd2yqiCDaEQ8Ztd7xE0qT46fa
   LfY8GEnj3MEUnqDqZQD/IIvh5u5Y/+hu2467Uf0BnTfewqv9nvT0wy/L6
   Ku5AFrPSX7Ryax619zxqMuq2ZXy580ljcdEl0/JTZvumhPSz5oorHhdtu
   w==;
X-CSE-ConnectionGUID: GRzo+4xwSVGOMibZ7tfidA==
X-CSE-MsgGUID: VT206sS9Qsm0swUm4hax4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51208526"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="51208526"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:23:28 -0700
X-CSE-ConnectionGUID: UDH0INfzSKqt0MbVQP3xuQ==
X-CSE-MsgGUID: Uc/yvJtcT2eRs65eCjNlbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="146351637"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:23:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uN40W-00000003mRx-2L5w;
	Thu, 05 Jun 2025 09:23:20 +0300
Date: Thu, 5 Jun 2025 09:23:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 00/12] iio: adc: ad7768-1: Add features,
 improvements, and fixes
Message-ID: <aEE32At2OOlbY-xH@smile.fi.intel.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 04, 2025 at 04:35:06PM -0300, Jonathan Santos wrote:
> This patch series introduces some new features, improvements,
> and fixes for the AD7768-1 ADC driver. 
> 
> The goal is to support all key functionalities listed in the device
> datasheet, including filter mode selection, common mode voltage output
> configuration and GPIO support. Additionally, this includes fixes 
> for SPI communication and for IIO interface, and also code improvements
> to enhance maintainability and readability.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(Note, some of the lines here and in changelogs all over the series have
 trailing spaces.)

-- 
With Best Regards,
Andy Shevchenko



