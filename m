Return-Path: <linux-iio+bounces-17234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2BA6D81D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA13B1031
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079B525D55A;
	Mon, 24 Mar 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCriW6/G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F12224EA;
	Mon, 24 Mar 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811209; cv=none; b=WEj0qhJ5nvU4L4XLZUrNz8u3RHkT0QUXCfCnoUUM3/29VkwaB7EvfmAklE08NFBBZqfPgwHQMpc2r2rj9iZdFJwyd2XFtIkY5Eb/MFOQMoihb3V2t5DBSy7DkJO0oJs13QzVqdG4hZZL9k9WUbvz6TfoQB4n/5Dn+8fYXTUDcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811209; c=relaxed/simple;
	bh=zMfZEepWCbGkaKDp5hr5k70cCA3t+S7pnp+IPcVwFL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2Oo83/USvitO6aasIPBAMy8uqgCDTQPzkU+i8wExytUlDfhJHWsriaXzIElP9imBVtNcyiFO0gFfFZybuW8hdwObkBrz6mGTkUq7sZv3kt2mVATl9Y4Lsdg5F45zZVRo+obihun3RhZY5sM0JNHzEUWqIgD6Lvd8K+gaLXDQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCriW6/G; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742811208; x=1774347208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMfZEepWCbGkaKDp5hr5k70cCA3t+S7pnp+IPcVwFL8=;
  b=PCriW6/GvwMXPay7jpbRLwvS8SCpUiJCEM8Ed4zpR4xqU82VqDXItLpm
   ClPTm/hFu8g5n/CTcd5rtkLCT+YHF/QkVoMRrDlYtieyx7NyERuI5Nxe6
   q77P3luyDrlvRovXPgl6cgCscI17TBSNVl3aC3vnZvJNZ3Lh2dQGqPTzx
   /7d5jh1UFvOgaQlsJ/1OFIqoX8ZDF7cvWCgNWirJDVcTSIPtbmMSt4Hzq
   eOeRs4zz3XSiylwX/VI23MigR4g40RwWS120miV0V8vqU9vSbRlmHu6Rb
   JCeuj3JlSFdCcbeVyhIpcxkFEcwY3lZH5NK3pdJQ3SH1flqIvmqNa4rUx
   Q==;
X-CSE-ConnectionGUID: wEcSssmHQgqT1mQsAhzyNg==
X-CSE-MsgGUID: e1xHhhqHRIymaW1pgzKRyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="31609414"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="31609414"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:13:27 -0700
X-CSE-ConnectionGUID: 0HBR9ZNAQKa9I/fEO9K2fw==
X-CSE-MsgGUID: cZCSTdUYTjWj8TqoDDydpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="129078206"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:13:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tweo2-00000005JEL-1Ee7;
	Mon, 24 Mar 2025 12:13:18 +0200
Date: Mon, 24 Mar 2025 12:13:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: backend: add support for decimation ratio set
Message-ID: <Z-EwPknex_gajz97@smile.fi.intel.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-2-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324090813.2775011-2-pop.ioan-daniel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 11:07:56AM +0200, Pop Ioan Daniel wrote:
> Add backend support for setting the decimation ratio used.

...

> +/**
> + * iio_backend_set_dec_rate - set decimation ratio
> + * @back: Backend device
> + * @rate: Rate in decimal
> +

Something is missing here...

> + * Return:
> + * 0 on success, negative error number on failure.

Please, double check that the style of Return section is the same as for the
rest of the functions in this file. If there are different styles choose one
which is simultaneously more recent and has more common sense in it (like
Returns: vs. Return, the preferred is the latter).

> + */

> +

Here is an uneeded blank line.

> +int iio_backend_set_dec_rate(struct iio_backend *back, unsigned int rate)
> +{

> +	if (!rate)
> +		return -EINVAL;

Yeah, besides missing style comment above, the function is undescribed. You
really need to add something meaningful in the kernel-doc and esp. explain
corner cases like this and choices made (why we fail it, what's wrong with 0?).

> +	return iio_backend_op_call(back, set_dec_rate, rate);
> +}

-- 
With Best Regards,
Andy Shevchenko



