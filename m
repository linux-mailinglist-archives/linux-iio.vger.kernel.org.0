Return-Path: <linux-iio+bounces-26797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D8CA8685
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 17:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6E93030FDA
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC734C137;
	Fri,  5 Dec 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0PRu4aP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504F34A796;
	Fri,  5 Dec 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947275; cv=none; b=o4iMfEp4GwqqIQycqCzUheoHhxSdNtFTqxxjxqDYfx8rD0DMldf7HUMqdJUcMlThASFBmGJlt9RuEO8xZ7N1DWRs3eaPlZzan1INubRyh3/pZksXw6MJ2czJObPwhy+GgronWAyUlJzDJBkXZtXJ6aKAC6EWnNBt4dtds6TqNyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947275; c=relaxed/simple;
	bh=+yu0wE0kaKy310FXiVjofPJXEiQOEMZpkUyP8EfatQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAohf6PAKIAzNdWEBbLE8rWFUD6+MrTjay8iHdDtT2mVyqZKFli1AtFxjB3nrOTEwcIdnWpyZD4z2WxtipiI/C7HLDyfPfHfD75rcRFG5A0MfaXVN5P4m1PPrvd5nq4FM7N+10dJ1hypUOKi1Q9IVr5oM55m5oMXyNIWpRiPfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0PRu4aP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764947273; x=1796483273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+yu0wE0kaKy310FXiVjofPJXEiQOEMZpkUyP8EfatQs=;
  b=A0PRu4aPqv8+EnU+IvbDpgxbJXe+X+uX5Ph0fSz3OTrPL4F1zZzMKZJL
   8oResMF1KSjtRPxds407l81XDWqnwvU5tKhfVDFR76heX+O21raQK0ujT
   lOmjpQ5iAAloyPYRLXXvd1Ghr0ylfByaNmXb2wWFuXW2dwNIVvIkEEwWr
   W90Pw1O0QuULpE19TXI2pT4mKtFHxoCRvkjzUHzMkey6Y2rwwXqKFXkPc
   meb502TehaCTPZkB2CJm2lXYbD113XzqPoDFurZeNdK6vQ76FbGKRETjM
   Ap+MXGUmBS5thl6U2Gfd+fFGQ9FO91rOLLIlSXkq/DnIgMw5i4yLQoy+F
   g==;
X-CSE-ConnectionGUID: CIqAx9arS2+f4rUFdbOrCA==
X-CSE-MsgGUID: RQ4qOYLMTQCa/rpfEooGiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="54528125"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="54528125"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:07:50 -0800
X-CSE-ConnectionGUID: 0quxj2OgRs+SSE4yhb3xUA==
X-CSE-MsgGUID: ZsZubdahQ5W0oVI4rzTv4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="218666949"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:07:46 -0800
Date: Fri, 5 Dec 2025 17:07:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: frequency: adf4377: add clk provider support
Message-ID: <aTL1QB1hPOkU0MJG@smile.fi.intel.com>
References: <20251205143848.989-1-antoniu.miclaus@analog.com>
 <20251205143848.989-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205143848.989-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 05, 2025 at 04:38:46PM +0200, Antoniu Miclaus wrote:
> Add clk provider feature for the adf4377.
> 
> Even though the driver was sent as an IIO driver in most cases the
> device is actually seen as a clock provider.
> 
> This patch aims to cover actual usecases requested by users in order to
> completely control the output frequencies from userspace.

Now LGTM, thanks
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/clkdev.h>

+ container_of.h

>  #include <linux/delay.h>
>  #include <linux/device.h>

-- 
With Best Regards,
Andy Shevchenko



