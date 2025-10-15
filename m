Return-Path: <linux-iio+bounces-25249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62829BED5D7
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B31124ECB55
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915272609FC;
	Sat, 18 Oct 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qf9uh1fO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC821ABC1;
	Sat, 18 Oct 2025 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808930; cv=none; b=cRcBowwRda+iqkxrIRT0FO+TuBqqHqa/SbFtYXOPAGxIT4gA0a3AgdX/uBXR2ph7y87DdU9J5Jk/goXl3ksJxVHiEgubcLOAv7gpqZbFNmSFB2NZWddWkrYf6mHgECj8o0xAj14kxTY+dC9n2oKgn1znER+rdYk5GUDw6tRbqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808930; c=relaxed/simple;
	bh=DwngqxyBoLU3lOfg2UKKvpT0jQqzGP+BCUhYdDa5wHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDyev44xX0nKyjoFOMbDAj7udoOdniKivQxFmo1Z615WnpNiNualpmGfmiNaF1Wmlye8xM59/0iyGZT5b/e1ndTSasF0JF0G6lzK8ssLbzV/HWz6/tuVDThEtDGAYETvJcjGCIH/NTcQdXtGfg/wtQWhOBM7UrmiWZEPBuQNaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qf9uh1fO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808929; x=1792344929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DwngqxyBoLU3lOfg2UKKvpT0jQqzGP+BCUhYdDa5wHo=;
  b=Qf9uh1fOKtYEtk0F3C8hJnhuEV3ePFUNnzvpdJ3nteyVT6MbfJxIAtTT
   zehHC8CA2UVYxGSpjib7XzviSo+xRnI0inuDgst0mRUG1q3lCBMOOqvnU
   OJjI6+8epZ4LO9dtYX3cvklD62unTwI2zzmtI3qiHEeZ+6chadpgpoEZj
   3pR1l8WAUYYPLTbqG0izCWwS7Lk3C6NWvGCyTmXhCJdVvcn/S6RisFwFM
   vqZJTUMPv24abeCSMM/peLPs9KnS+iK6jR7KS6/HBihvM4mvbsmKveVFO
   9EOjkPh9ZJz/OdIqMoGkMqpLk2DQ0M8qKQQWbgmK9y+/tAQ+JedpFJWHV
   g==;
X-CSE-ConnectionGUID: q9cWj8wfR6eFDa6PMtp97w==
X-CSE-MsgGUID: nUau3VGoT92ldX1QPJCBsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62912196"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62912196"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:28 -0700
X-CSE-ConnectionGUID: jwYDZRQfTm+ESgUExNKtlw==
X-CSE-MsgGUID: LsK4YWDAQO+B21zexd15vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183400184"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:25 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1v91po-00000000KWF-47Ql;
	Wed, 15 Oct 2025 16:46:32 +0300
Date: Wed, 15 Oct 2025 16:46:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 4/7] iio: adc: ad4030: Use BIT macro to improve code
 readability
Message-ID: <aO-luIfTsekQC3e4@smile.fi.intel.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
 <ec78fd7e4348e2cbc99ae08004c48b7ea238ecf7.1760479760.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec78fd7e4348e2cbc99ae08004c48b7ea238ecf7.1760479760.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 14, 2025 at 07:21:58PM -0300, Marcelo Schmitt wrote:
> Use BIT macro to make the list of average modes more readable.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Okay, but...

...

>  static const int ad4030_average_modes[] = {
> -	1, 2, 4, 8, 16, 32, 64, 128,
> -	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> -	65536,
> +	BIT(0),					/* No averaging/oversampling */
> +	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
> +	BIT(5), BIT(6), BIT(7), BIT(8),		/* 32 to 256 */
> +	BIT(9), BIT(10), BIT(11), BIT(12),	/* 512 to 4096 */
> +	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */

...the comments now a bit odd as it's unclear in which step the values are.
Taking this into account I would rather drop the comments for all bits but
0.

Or even drop all and make a top comment to explain the meaning of values
0, 1, and bit permutations, if any.

>  };

-- 
With Best Regards,
Andy Shevchenko



