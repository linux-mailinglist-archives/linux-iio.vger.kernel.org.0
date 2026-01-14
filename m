Return-Path: <linux-iio+bounces-27806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E76F2D20750
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9101307F02E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201722E0925;
	Wed, 14 Jan 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2qL/z1M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B962DEA87;
	Wed, 14 Jan 2026 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410480; cv=none; b=e89UhleTLA03le+8p3sTcmXBPhvBP1vlyKpElEFVftVHhi6a/qyQFNUNTTU31Im++Co3PtUwhxsjWWj6VNGcelLSAAlv4e3Pyt4qKrqVYI5h5zDMtSLOTbMZxwhk01/p5ZnLztlQ1obhDLpodiVWblTrywdfWuVNvBQhZuz2+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410480; c=relaxed/simple;
	bh=hKfowasPUYc6X15pRratDjXGaeplP5F30WbBuGKI164=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKVM3stiBkmRRoSalafVDUmttdymA/GaMCjMsscyT/voCJDAzzsPLFYJsHyHaixO4+0B1ZqJAheQPv6L4BZVOkOxg1tIhz7MbarxzZhqWjMcMpln3JNYy1ajxPXTpoeffnYOVYMdSHy8H5nYmLY5zs4g2lMbpXqg2FAqM9M6rRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2qL/z1M; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768410479; x=1799946479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hKfowasPUYc6X15pRratDjXGaeplP5F30WbBuGKI164=;
  b=Q2qL/z1MGYXUCd4oew/AlLf32wmXmhYrRD1sFT2BxWXe9yVwxIqjw2K6
   KIZGgWERkbVSP880OVIVz9WxpM8L6TLIxHoLDwt1wys0rUhiPmPVFFA0K
   GL7VO+ilFFiv6NkXHmpNjtFLC8qgyixsD+AoePwwFLLpMKGg6dfKGjmk5
   KNVxa5XqPFoPTZ78uK+iD1D2uCaP4LXPVoChFZ8HFN3ueR/czlcBZLjxR
   IPJVEQMdcnhlAeb0YvzQzeDauWbvnRGZ1sd+MBnNHmoD+KUnBTkdHuitn
   RCbgodO6oZn8wbk8W0Yb2c1mSSdGeNYvR7663xp7EtpjSA3wJF/mx+hdl
   g==;
X-CSE-ConnectionGUID: lBtTuEDkRaCSxHEcijauqw==
X-CSE-MsgGUID: 8KF37U8lQmKOoPrREgICwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68724641"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68724641"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:07:59 -0800
X-CSE-ConnectionGUID: 8N32nG9+S5icAp6ohdoLZw==
X-CSE-MsgGUID: xG8eJajxTBujxjxaWEr0hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204514222"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:07:57 -0800
Date: Wed, 14 Jan 2026 19:07:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 03/13] iio: pressure: mprls0025pa: fix interrupt flag
Message-ID: <aWfNauwMv1EFczD8@smile.fi.intel.com>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
 <20260114-mprls_cleanup-v3-3-bc7f1c2957c2@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-mprls_cleanup-v3-3-bc7f1c2957c2@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 06:55:32PM +0200, Petre Rodan wrote:
> Interrupt falling/rising flags should only be defined in the device tree.

...

>  	if (data->irq > 0) {
> -		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> -				       IRQF_TRIGGER_RISING,
> -				       dev_name(dev),
> -				       data);
> +		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler, 0,
> +				       dev_name(dev), data);
>  		if (ret)

>  			return dev_err_probe(dev, ret,
>  					  "request irq %d failed\n", data->irq);

Also drop this (in a separate change?) as devm_request_*irq*() prints the
similar one.

-- 
With Best Regards,
Andy Shevchenko



