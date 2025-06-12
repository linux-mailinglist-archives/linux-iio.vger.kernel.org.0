Return-Path: <linux-iio+bounces-20555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F3AD71CD
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D721D3B5CA3
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E0453365;
	Thu, 12 Jun 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4v/MX/S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B92744D;
	Thu, 12 Jun 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734579; cv=none; b=sTvLgO4iF6Zu3nwIgEr4Hl3cni55BP3ASmElapOZb8oFwSetCnSf6m7Y61vFhsMpTXv6XO+4/JZXS6KD4+282mGZdggeF75uExaomgcTYgvz8u4TrEFgbCAwo1TAq1lJwj4qyxasJMDoE+H2xaUyafCNSOb1rDSryHI+UZs4SGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734579; c=relaxed/simple;
	bh=z31TFJJA6H9aGmzIDY67vP6/BIVJXmTiHnogd+G0yC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WadQuHd6ANYcr5HfnM9+iof8TCboJ28dVuwwnQi9T3DKmshP9t8d27IfOW/BK7W9RF7+f8RnXotcwlgEyioW2x8+IhiHpkfqwrhHYiTgx743Nui9+rGCBKxG4+NxqpRnjyZoTmLOhxAhzYynGCZzVugwc3PKPvGv9gfUmeBbYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4v/MX/S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749734578; x=1781270578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z31TFJJA6H9aGmzIDY67vP6/BIVJXmTiHnogd+G0yC4=;
  b=P4v/MX/SE/mapbjkQ5Q8nzXqBOOfHElgxk0cfkUWVZebfgNBFdAuV40V
   FY48Y4CIOtvwgVbDE6lSSeadaIMQcXRa98kot9xZNdrsvnB4/3vmoM9Sz
   sZ0T6KaWup/Wm7nDbXhJ0AYYCnj1nGEcNfXhl5mc+RGKQRiwtKgT2zHuw
   qVymgNphM+/0+XS7ybbq7ylezKTqpLfnxTSl/Sp4JZ3UZy4am+YLNAp7A
   DuQHXFnp5k5gCdmjGrooLVGSc0jTvhSFDZ0RzD3NNSdMTjZMNjDS3mOfr
   N0lNqzbkJ5pz+aA4rztp/X/busMuNxOKrZkUcdBvJhHhiSEPK7v7PGdB9
   g==;
X-CSE-ConnectionGUID: 0rGfpxluSEiBOuNOFT/9rQ==
X-CSE-MsgGUID: g+WKv91WT3+8k1KWP1IlsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51999197"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51999197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:22:58 -0700
X-CSE-ConnectionGUID: e2UBrUH8QLGUjuuspRu4wQ==
X-CSE-MsgGUID: +EQhxeZQRW2qwWDBtGKd9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="148409670"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:22:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPhtM-00000005xWB-0lGu;
	Thu, 12 Jun 2025 16:22:52 +0300
Date: Thu, 12 Jun 2025 16:22:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	jstephan@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
Message-ID: <aErUqzdFL9nG6Bxc@smile.fi.intel.com>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-3-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611194648.18133-3-andrew.lopes@alumni.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 04:39:20PM -0300, Andrew Ijano wrote:
> Remove usages of sca3000_read_data() and sca3000_read_data_short()
> functions, replacing it by spi_w8r8() and spi_w8r16be() helpers. Just
> one case that reads large buffers is left using an internal helper.
> 
> This is an old driver that was not making full use of the newer
> infrastructure.

...

> +	ret |= (mode & SCA3000_REG_MODE_MODE_MASK);

Unneeded parentheses.

...

> +			ret = spi_w8r16be(st->us,
> +						SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));

Make it simply one line. The above formatting is ugly.

...

>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct sca3000_state *st = iio_priv(indio_dev);
> -	int len = 0, ret, val;
> +	int len = 0, ret;

Ideally it's better to split them and len should never be signed.
Moreover, the function  should be switched to sysfs_emit_at() if this is part
of ABI.

>  	mutex_lock(&st->lock);
> -	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> -	val = st->rx[0];
> +	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
>  	mutex_unlock(&st->lock);
>  	if (ret)
>  		return ret;

...

>  		}, {
>  			.len = len,
> -			.rx_buf = rx,
> +			.rx_buf = st->rx,
>  		}
>  	};

> -

Stray change. Doesn't checkpatch complain on this?

> -			(st->rx[0] | SCA3000_REG_MODE_RING_BUF_ENABLE));
> +			(ret | SCA3000_REG_MODE_RING_BUF_ENABLE));

> -			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> +			(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));

In the original code and still now too many parentheses.

-- 
With Best Regards,
Andy Shevchenko



