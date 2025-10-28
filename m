Return-Path: <linux-iio+bounces-25555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2965C13843
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88B1D541CDA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E552D7D42;
	Tue, 28 Oct 2025 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pbb8Z4mA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0C2D6E64;
	Tue, 28 Oct 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639493; cv=none; b=mqEAR3hiIhEE19iG1lSKLg/zcsnsUIB3QGCp2KQnzsiP3YYPGKJ9wDPmAU/oYNXSvMtbSxBQZ5H6qKfKUYPYNKj3l4Z2uOdrIavAH8/VLdAGe3Oe4+g6oY3vwDUIPEhcyho7t/4zq4xN1V+EeOfN7l/PkSSbF4KEH6P+EAWuvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639493; c=relaxed/simple;
	bh=MVSFbwblKngEk79Y3sKxyk9wd5p4f7fVCW6a/4FzAi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq4/35Hb7lDQancJF4uHzo2vyCwyvxquCAnBEaFo6KefA2xkKYOXPdZnlLgz9s4D7jbELm0tZ7/oiFBhIfMA5lRo3VUs4noCid9o/1kd0hN+3tyvRLn2OAq0ppGAcmgw6bYz3bF0ssXNpOnNPxa+6tBpNhH4hPI6r62BozYChJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pbb8Z4mA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761639492; x=1793175492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MVSFbwblKngEk79Y3sKxyk9wd5p4f7fVCW6a/4FzAi8=;
  b=Pbb8Z4mAShzmp0ccl5xXUWnjg+QYQVkwoWj+nOylUzwACZzS8fNbNeuQ
   ClwKiJC4nHMKbSg2H42nHpM7klsSEGDumuOZbpctAe5TF0f03dS+f3VuI
   j//+Iwjs4IRcns5KKx8g78UnIIy7gv3jy4vR+xlUgx8q/BJ4FipARPvBa
   BLJVg0v2zx6N5Orp1n8eKuCsySq7YYEMnkZBK2biehi45eqoriK5muTuO
   73Uevim+WrsfUyHgJQg/JlbJssoRd4qBnA0fQRQLbWZkS/CDj7SQCjpPY
   cjkGFXd14taHke0wW+a3csIMR4+7/DlwbqjzroxCB96nn6ut+TowHpB1k
   A==;
X-CSE-ConnectionGUID: IJlYxyk2Q/CxCPyHxhbDyQ==
X-CSE-MsgGUID: Wme6R/jOT62TLFifrIzjRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74851740"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="74851740"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:18:11 -0700
X-CSE-ConnectionGUID: 4sZzpAyFS9aNK74HnA9pzw==
X-CSE-MsgGUID: PzQeqeG4QOCrmejYy7V5fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="189593645"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:18:09 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDeu5-00000003FRh-47UN;
	Tue, 28 Oct 2025 10:18:05 +0200
Date: Tue, 28 Oct 2025 10:18:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
Message-ID: <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027150713.59067-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer, which may be less than the requested
> 'count' if the buffer size is insufficient. However, the current code
> incorrectly uses 'count' as the index for null termination instead of
> the actual bytes copied, leading to out-of-bound write.
> 
> Add a check for the count and use the return value as the index.

...

> +	if (count >= sizeof(buf))
> +		return -ENOSPC;

But this makes the validation too strict now.

>  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
>  				     count);

You definitely failed to read the code that implements the above.

>  	if (ret < 0)
>  		return ret;
>  
> -	buf[count] = '\0';
> +	buf[ret] = '\0';

NAK.

This patch is an unneeded churn.

-- 
With Best Regards,
Andy Shevchenko



