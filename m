Return-Path: <linux-iio+bounces-19347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F9AB03B5
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD137B7D6B
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF328A1EE;
	Thu,  8 May 2025 19:31:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A878C9C;
	Thu,  8 May 2025 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732681; cv=none; b=GCsm6KCse6f9RgVi9HfLuRqTwLzeCxykLYTvWlCwwALmAgwSYbPeIU21i3ZeNIZYrZIKDHYP/mWbadKaBdramsGxRP3NkiVkDTmKStUD5m4ourXu2BLeGGg2QBdwJKxWZdFeiZfPaKQhWAoZAlW9Zo/0CpcxxuV00V1MH33GC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732681; c=relaxed/simple;
	bh=k+VrMB7UvnOXssbGqj/LNHxp7BW9rZ+ypvLuFylf+ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNFZeGZxmSy7KA5fSTE5MgrFNHq6hO9TXE3IaNOvmQm9etRKBB1Va+VHB3UjvU2t5VM4KdmLQCD2680iMXbKzxejN5SnyqwudjQOFaC4Q01bFXS3L5z79jnNcXZak8vIEVyc8+XgR350HOFM7cLdJ+CB7tbMRNAvud8kLM9FLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: cKmrvkzuT72hRNgtblm8Hw==
X-CSE-MsgGUID: +KLkYc+IStaMCz/E+1d+hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52345455"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="52345455"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:31:14 -0700
X-CSE-ConnectionGUID: /v4p4tvlTeuYWc+cJfE6eQ==
X-CSE-MsgGUID: JM3RWZDyTj2L4H7+TO4akQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="167468005"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:31:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uD6xX-00000004DFS-1Zu5;
	Thu, 08 May 2025 22:31:07 +0300
Date: Thu, 8 May 2025 22:31:07 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v7 10/12] iio: adc: ad7768-1: replace manual attribute
 declaration
Message-ID: <aB0GeyWALeE3mDOx@smile.fi.intel.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
 <7987725e62f53c4b2cf74dacced0a47ad055f4a9.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7987725e62f53c4b2cf74dacced0a47ad055f4a9.1746662899.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 08, 2025 at 02:05:13PM -0300, Jonathan Santos wrote:
> Use read_avail callback from struct iio_info to replace the manual
> declaration of sampling_frequency_available attribute.

...

> +static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
> +		st->samp_freq_avail[i] = DIV_ROUND_CLOSEST(st->mclk_freq,
> +							   ad7768_clk_config[i].clk_div);

		st->samp_freq_avail[i] =
			DIV_ROUND_CLOSEST(st->mclk_freq, ad7768_clk_config[i].clk_div);

is slightly better formatting for this.

> +}


-- 
With Best Regards,
Andy Shevchenko



