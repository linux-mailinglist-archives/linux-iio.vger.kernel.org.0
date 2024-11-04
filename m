Return-Path: <linux-iio+bounces-11880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1399BAE21
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDBC1C20FDF
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DAD18B488;
	Mon,  4 Nov 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJ8A/9N5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C72132111;
	Mon,  4 Nov 2024 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709139; cv=none; b=sxODZdQPhZQefISMDKbwQDQaUmw/j2/p1ctVOwXKys8q3DwqQliP8FSEGLfJKcE6ySyx/WxZV6K3/w+xR0oueBUHhkWhku1mlYGAT9lDCNlw3WBsNqqfMww5lX07qX/yGcWdjOs5bY4qelSZDJ8cxcQ1Ud2eEocfEyFqbBR6O/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709139; c=relaxed/simple;
	bh=zAp+R+E7m6ywEIK/+UhcHQD4V6TJ0Wiyk2ppk67o1KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEOageZ0z03HEDdBs7IGrR3sO0YyUVZmKLUH9AqyT9ZZ1OfMvQk+NC5IADeRGy9yiB8nN/8P4o3g4EyXrKBCG0GkadP9ElWCYRwrskTIcXtrpylgvn5XvI4VkEjtBan5+uSr3xrM5xwXlFZC2XBkqBRcNcGffv6t9gvR/E/48/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJ8A/9N5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730709137; x=1762245137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zAp+R+E7m6ywEIK/+UhcHQD4V6TJ0Wiyk2ppk67o1KU=;
  b=YJ8A/9N5eW+B3reVOYQqVfnd3yzE056XK9EF11daadb3yuPbTN+fY8hL
   BgoB8HoHfp8ICk8wkmMQ2Bas4BYNp1s9ELF1YPXTG5WQATIIVz2+mLtpq
   VT4Gk7xmfhlMmU5LJDYzxJElQcjh+xe2lbEnkLGj9UnRCPKfiPTYEQpcz
   PaEmr7d12KOgHom04cwjT44OV9Lap7OqdBVUpeob5JZ6HorD7Zs+gSvlX
   XWRWg3QsHutOSDEclEBo79U1XeWzxoZhC5zl+bcNAdoFuTY1IpdjHCQ3l
   1xtqlbWplT7WUtJPAZFd3EfTFK9N2fCOWbqZ8532GlbTp4CiC4ULLHaX9
   g==;
X-CSE-ConnectionGUID: YVGwuMy0QrS7n7gvbFsF7A==
X-CSE-MsgGUID: aA6Cj+QiRKixkm6OBHn1Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52955087"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52955087"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:32:17 -0800
X-CSE-ConnectionGUID: ++ai5ejURxymdXTSysQxNA==
X-CSE-MsgGUID: GoHmC6LZSP2kLjSzGTo2gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114367291"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:32:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t7sVN-0000000Ayz5-0Hed;
	Mon, 04 Nov 2024 10:32:09 +0200
Date: Mon, 4 Nov 2024 10:32:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: light: stk3310: handle all remove logic with
 devm callbacks
Message-ID: <ZyiGiK6bSd_d0VQ6@smile.fi.intel.com>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-7-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102195037.3013934-7-aren@peacevolution.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 02, 2024 at 03:50:37PM -0400, Aren Moynihan wrote:
> Using devm callbacks helps to make the ordering of probe / remove
> operations easier to reason about and removes some duplicate code
> between the probe error path and driver remove.

Where is SoB?

...

> +	ret = devm_add_action_or_reset(&client->dev, stk3310_set_state_disable, data);

Why not simply 'dev' as in below call?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register cleanup function\n");

...

> -	mutex_init(&data->lock);
> +	devm_mutex_init(&client->dev, &data->lock);

Missed error check, otherwise what's the point?


Also can add a temporary variable for 'dev'.

-- 
With Best Regards,
Andy Shevchenko



