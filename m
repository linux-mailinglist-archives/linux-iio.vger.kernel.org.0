Return-Path: <linux-iio+bounces-14892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEEAA25640
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF79B1645E4
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844EB1FFC55;
	Mon,  3 Feb 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSxH4Fyo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544B1FECC2;
	Mon,  3 Feb 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576142; cv=none; b=bsfSucEZY2vppHkq9iHQFXEdm1+RZkp3epnPDFCIInzKrwUspm54qsqJAwNPz0FH6BIQhW5u6mE7qzPkzSUC+IcPnmXzocIWeZ9z6YFz4Te1E7JWILCDTYTeKYzIZczLR9TKmmDQ6Jfq8BcbBxGaO3lSwSkaa+QlbHyBFkNWwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576142; c=relaxed/simple;
	bh=zWGrZS1Fj/UWGsQmGsxasXV1/TVm5sUBsUTBhpui6aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6UMWY9k90VnJ2+wQwpg+nGXsgnTtTygYakwViPTRfrqmXBXifNxHRGgkDPmfsM8XxVsWVfxkFBXrBNs5AplYTMbtZ3Hwc6cjbyujWJuSxQXZtzl6Bdu7dKTQmp7wrTITMgEwZfzw38ZX8NPW9Y+npIRi8iTjCDDqSOORKbZshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSxH4Fyo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738576142; x=1770112142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zWGrZS1Fj/UWGsQmGsxasXV1/TVm5sUBsUTBhpui6aI=;
  b=NSxH4FyouSpJaYLnIJD7lhf/+hxJTPXukKC8Z+qhJ8k6/oo6lzkCT3FO
   19LehAcZIY/yiF/fbJ8LV9I68nGyYB76sYnOcaELPZ2BhdZnn+1667V+U
   UgX6qHwBCM09kSF89q3KRRioZY5pHQgcQK+Q97nmmp404yrSiLhcOwHRC
   osGq0TVHyxuBbL5UIxuHEu7L9M/qVuJ7pbz3XuXYcGVOvz8DTl47jGUNu
   z9NlRtPoDzUC4ui+VqSkTW7FmBLUzADkGJRjchYfjLZJrYtvbSa+6OCUR
   Vl39JdJjQY9kjzWrikDO3jSa79G50O5GZp5/YX1px3wEyVZTyJRJygBxj
   Q==;
X-CSE-ConnectionGUID: YtLSqG1UQyerYepsKkMF0g==
X-CSE-MsgGUID: Gs/DId3rQESWPIyW3PHysg==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="50052859"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="50052859"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:49:01 -0800
X-CSE-ConnectionGUID: kd1tWlm7RnKODLNnZVynIg==
X-CSE-MsgGUID: tHzNomfkRlyabZ+PaOXD+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147441315"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:48:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tet4W-00000007mz6-3yhl;
	Mon, 03 Feb 2025 11:48:52 +0200
Date: Mon, 3 Feb 2025 11:48:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 00/20] Split devres APIs to device/devres.h and
 introduce devm_kmemdup_array()
Message-ID: <Z6CRBDpXpPha07mf@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080902.1864382-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 01:38:42PM +0530, Raag Jadav wrote:
> This series
> 
> 1. Splits device/devres.h for the users that are only interested in devres APIs.
>    Original work by Andy Shevchenko:
>    https://lore.kernel.org/r/20241203195340.855879-1-andriy.shevchenko@linux.intel.com
> 
> 2. Introduces a more robust and cleaner devm_kmemdup_array() helper and uses it
>    across drivers.
> 
> The idea behind embedding both work into a single series is to reduce conflicts
> and dependencies while merging.
> 
> v2: Use size_mul() for multiplication (Dmitry)
>     Update commit message (Dmitry)
> 
> v3: Embed devres.h work by Andy

>     Add more users of devm_kmemdup_array()

I understand the desire to cover as much as possible, but it becomes much
harder to coordinate. My proposal stays the same, i.e. I may take the GPIO/pin
control related (and already ACKed!) changes via Intel pin control tree and
the rest may use that immutable tag as needed.

What we need is an Ack for the first patch from Greg and perhaps I can take
IIO, if Jonathan gives an Ack.

>     Update tags and rebase

-- 
With Best Regards,
Andy Shevchenko



