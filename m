Return-Path: <linux-iio+bounces-14904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89787A2572B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CADC3A72BF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3C201258;
	Mon,  3 Feb 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBsG0+s/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FA20101A;
	Mon,  3 Feb 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579365; cv=none; b=UsK0HTSSd+BT/4OeqbJ1GC07nKfOtOFLyEOOyHQSQDFTldWJzZoF1KTwzJjPl/+K/a06eJ1nIQ1xS4Z6Yfec7xw7ie0u3dvDTCAZyI8hVjBl2xrsy9i3UihzIHngrcTqARIMgT1Ozvd/UTQ4Zt887wf4muIxC0OO/VzFaWzfBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579365; c=relaxed/simple;
	bh=TBWAx2fus3LuuRfx5m3K8jJ3PGhPyP0ZM7asMbiIpk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fealJ/vkb0j/SPD1eAKm5fPddJzlAPAUtkdAcUD6HSv5a6s04EPDdDR10FLwkE/GGB6/LX4HJbycBQoQXDuu6EnLpuZmrQVXEsF0HX3wKZcp7FcVXQQmtxGOSfBfQrMOGwS+Kka2nMj/GLaNjHkJJ1bmw3I209LExtAaITFXgcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBsG0+s/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738579364; x=1770115364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TBWAx2fus3LuuRfx5m3K8jJ3PGhPyP0ZM7asMbiIpk8=;
  b=gBsG0+s/NRtaRmfkPWJrpqqJbQbyF8d5oQk5ZpeJyoSTqiNkl3fCTBqO
   AIcwJuMX74+5GBWG3ykNsMhIoO3rxFIqMGYv0NHfYjidq0rsZVPwT/9kR
   IQFBn/3/GAeF0vtUsL4oqbyhSVzGWbQjqvoa2jJOPL8P8A8GbHxdorGji
   EOmZqE8Q9jy/WkR6HyDVCm4LQLRpO2+pxbsLAZlhQiPa75BkRskKVQ2jP
   y9xIhzEkIIQuv855RPKsBzawD1JSyjDA5EWRr/piPAuTs2GyjjEu3ga6Y
   Uk8r77dIwO3pe59hApIvW88ePkhtOsEukeeIvtQX8+phhMu45xTyD8VJ9
   w==;
X-CSE-ConnectionGUID: QWWHIwmPRR2FuBk5H3cv7w==
X-CSE-MsgGUID: 1YtJ1Q7fSySD1B3cpv9lEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="41900133"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="41900133"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 02:42:43 -0800
X-CSE-ConnectionGUID: aF5+2nxySfCNBldLM6IrKw==
X-CSE-MsgGUID: h3K4+QF7QAaTdiEYQByQ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110085031"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 02:42:39 -0800
Date: Mon, 3 Feb 2025 12:42:36 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 14/20] iio: adc: xilinx-xadc-core: use
 devm_kmemdup_array()
Message-ID: <Z6CdnPryJkBHO9PK@black.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-15-raag.jadav@intel.com>
 <Z6CSYn7ZDVNELIIv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CSYn7ZDVNELIIv@smile.fi.intel.com>

On Mon, Feb 03, 2025 at 11:54:42AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 03, 2025 at 01:38:56PM +0530, Raag Jadav wrote:
> > Convert to use devm_kmemdup_array() which is more robust.
> 
> ...
> 
> > -	channels = devm_kmemdup(dev, channel_templates,
> > -				sizeof(channels[0]) * max_channels, GFP_KERNEL);
> > +	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
> > +				      sizeof(channels[0]), GFP_KERNEL);
> 
> I would use more regular sizeof(*channels)

This might get confusing since we're assigning it back to channels.

Raag

