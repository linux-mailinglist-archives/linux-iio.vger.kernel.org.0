Return-Path: <linux-iio+bounces-27365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18171CDFE59
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C948C30080F0
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A69F254B19;
	Sat, 27 Dec 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCW19uPH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2EE2405FD;
	Sat, 27 Dec 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766849214; cv=none; b=jwP/OAg1ipUnNfERcKdN9/b6u0RfZmPvbT+wwq2zF6tus4uZbYLCuDIwCYlCN3+w0vIAUkT7ccrOlOXLn7XEOGfp09tvfmJy+xKxiIiVimnK76gBYn2Q1ZNoc/wDrgmUtqvjjgokh9y2Em0tHPHT2eDvZ0f2/glwXm8tWnIW6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766849214; c=relaxed/simple;
	bh=+bgrzL7Vn7co8u8odV39RHQzq148NxbZ/+552wFPotY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ4l5F3uqhQ/hRnDEMry+jKd1vUw6yeOvTxbvI+iVVfc59H7+90aXhl8wS6UepppGv/x9Uh6Gj3na9WHDvoSQdseGRnOamFRtUo25u5OWm5zxCQcphYJ1vnfdym0dQfO+r0OC2qNSLs++wT9N3AJZKHzw8+O5nM1O/J2BMIu2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCW19uPH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766849213; x=1798385213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+bgrzL7Vn7co8u8odV39RHQzq148NxbZ/+552wFPotY=;
  b=dCW19uPHi5XjZen/wI7WzCKMdUibu7ZjHATNN6LtC7yhBcpJzqpA5tWM
   B9glleRmhfL76Y4ZEqCIyDEphsQrPeUs/j1iXsH2eNpyMuV/Fr2F3pH1J
   jQwjnfQADbTi1bWxxeB3tv2MXg6jvXZhJHRjstPtTEjCSqBd0Ed0TKhlv
   jGIBwdJFv0b/r2ye0/EGPAnvLDIWQdBLjk2ZtD6rJqzy41N1i/44i1Q9t
   L55o68fBl7bMxloSpZHrAk7Ltr0BKYaNxYhOk2uJ0fqLFjrVKoGFXdiwD
   50LnSEk3oavv2Yfx3BfLD0LXp9ujhB+DtFIgzw4HUOxnmnynttYljsxke
   Q==;
X-CSE-ConnectionGUID: lHW1QFYiT/G0uZO61tGChA==
X-CSE-MsgGUID: 8/UOTGmvSp+LreVQZMOyXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="79664399"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="79664399"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:26:51 -0800
X-CSE-ConnectionGUID: 317osBiFRwqwOgkL2hc4bw==
X-CSE-MsgGUID: 19f7vn6ZTBGwFER+bf2XMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="205099357"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:26:49 -0800
Date: Sat, 27 Dec 2025 17:26:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: markus.koeniger@liebherr.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH] iio: accel: iis328dq: fix gain values
Message-ID: <aU_6tpGOgQ-pival@smile.fi.intel.com>
References: <20251222-iio-accel-iis328dq-fix-gains-v1-1-c2f337703e91@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222-iio-accel-iis328dq-fix-gains-v1-1-c2f337703e91@liebherr.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 22, 2025 at 03:50:04PM +0100, Markus Koeniger via B4 Relay wrote:
> From: Markus Koeniger <markus.koeniger@liebherr.com>
> 
> The sensors IIS328DQ and H3LIS331DL share one configuration but
> H3LIS331DL has different gain parameters, configs therefore
> need to be split up.
> The gain parameters for the IIS328DQ are 0.98, 1.95 and 3.91,
> depending on the selected measurement range.

> See sensor manuals, chapter 2.1 "mechanical characteristics",
> parameter "Sensitivity":
> IIS328DQ https://www.st.com/resource/en/datasheet/iis328dq.pdf
> H3LIS331DL https://www.st.com/resource/en/datasheet/h3lis331dl.pdf

You can make them as Datasheet tags:

  ...
  See sensor manuals, chapter 2.1 "mechanical characteristics",
  parameter "Sensitivity" in the datasheet.

  Datasheet: https://www.st.com/resource/en/datasheet/iis328dq.pdf
  Datasheet: https://www.st.com/resource/en/datasheet/h3lis331dl.pdf
  Fixes: ...
  ...

> Fixes: 46e33707fe95 ("iio: accel: add support for IIS328DQ variant")
> Reviewed-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> Signed-off-by: Markus Koeniger <markus.koeniger@liebherr.com>

-- 
With Best Regards,
Andy Shevchenko



