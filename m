Return-Path: <linux-iio+bounces-8845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C70962A07
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04851F250F6
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA81898F7;
	Wed, 28 Aug 2024 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIRK2sRF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898D42A8E;
	Wed, 28 Aug 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854670; cv=none; b=p8PjwWlH6aeGjDm6Ji++E5yV0CeTmZ6YIiU0KvbdILl5K6/xsdaZr3P5C3hC/oW4MOb9rwTiRb1iWnW38BKNAXm30jhQOTArBh0GOeS9BqO+qe6uqdm7we3Z3HtyE+0XpWAIVkaixSh9/tEj9eFGW4CkcDdaQ2kKH6GKybCsLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854670; c=relaxed/simple;
	bh=Znii0Gu4u2xaHQfuHkXYV9iRjgMc8rCLjfx7GALBuGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aawJ/4xL7b02DuAm5DXPUAKa51hNglHr2V70VbDOcRHWX/HNUt+FcA1ORNdVJzENfXx2pDnhsunIXUaVkeni4FpgUkyWucDTbzdH+tNJZU9d2ud2gK1REGQhZctLcMcw1s4Uk9Dm+6iCRgtyNftG7XWQNn0sJn4C80uOQccnrPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIRK2sRF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724854668; x=1756390668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Znii0Gu4u2xaHQfuHkXYV9iRjgMc8rCLjfx7GALBuGQ=;
  b=NIRK2sRFvcCluzlTV3OX2grQuQtO9HftQ6hh+6EQY8XuWoDoXzf5egGr
   4qD3frB6LfTgieCqYcRRa3BfZneQHJfisZUguyk2vIK6MEpyaTk8XaSQw
   oHlPk7vXdOaLjBCsfR080PEdo0b7SpLM69SfcfJrpmQdnzZ5whi4nlYOx
   +3QBmDsSGJvQ3874dqO6+nEIHlVq0wuWYiDTo6xzIm7L8F8xfjrw37oWT
   ZVfLRZrh9mP3Cuh5dBtHuPSslPdZWPU9RtLt5if4Xvp2HoCD2p/PTj9LU
   Dc0JO3gjGcv3fbvI/+4QxfDUxCGtnWGNOh72aswQm92fZAR/Ab5x6acRC
   w==;
X-CSE-ConnectionGUID: GMkIPbLWQjWKFPELUbs2mg==
X-CSE-MsgGUID: Z5mXoxF0RP+EvzhP6yenNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="22969071"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="22969071"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 07:17:47 -0700
X-CSE-ConnectionGUID: vB+rwcLTTuKRLSfTJmJU4g==
X-CSE-MsgGUID: u3KghOOiTSaUxzX4Tll+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="100750764"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 07:17:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjJUS-00000002fZd-3JjK;
	Wed, 28 Aug 2024 17:17:40 +0300
Date: Wed, 28 Aug 2024 17:17:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <Zs8xhMaFahBVanwd@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-7-vassilisamir@gmail.com>
 <ZsjrxLlhmx-TzwXF@smile.fi.intel.com>
 <20240824120222.GG9644@vamoiridPC>
 <ZsxXvGy4GNrZWs-D@smile.fi.intel.com>
 <20240828140119.GB4934@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828140119.GB4934@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 04:01:19PM +0200, Vasileios Amoiridis wrote:
> On Mon, Aug 26, 2024 at 01:23:56PM +0300, Andy Shevchenko wrote:
> > On Sat, Aug 24, 2024 at 02:02:22PM +0200, Vasileios Amoiridis wrote:
> > > On Fri, Aug 23, 2024 at 11:06:28PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Aug 23, 2024 at 08:17:13PM +0200, Vasileios Amoiridis wrote:

...

> > > > > +	irq = fwnode_irq_get(fwnode, 0);
> > > > > +	if (!irq)
> > > > 
> > > > Are you sure this is correct check?
> > > > 
> > > Well, I think yes, because the function return either the Linux IRQ number
> > > on success or a negative errno on failure.
> > 
> > Where is 0 mentioned in this?
> > 
> > > https://elixir.bootlin.com/linux/v6.10.6/source/drivers/base/property.c#L987
> > > 
> > > > > +		return dev_err_probe(data->dev, -ENODEV,
> > > > 
> > > > Shadowed error code.
> > > 
> > > I am not sure I understand what you mean here. You mean that there is no
> > > chance that the first one will pass and this one will fail?
> > 
> > -ENODEV is not what fwnode_irq_get() returns on error.
> > 
> > > > > +				     "No interrupt found.\n");

...

> > > > > +	desc = irq_get_irq_data(irq);
> > > > > +	if (!desc)
> > > > > +		return -EINVAL;
> > > > 
> > > > When may this fail?
> > > 
> > > I think that this will fail when Linux were not able to actually
> > > register that interrupt.
> > 
> > Wouldn't fwnode_irq_get() fail already?
> 
> By looking at it again, I didn't reply correct here. This function
> internally calls the irq_to_desc() which basically returns the
> irq desctiptor for this irq. This function can return NULL in
> case the interrupt is not found in the maple tree (CONFIG_SPARSE_IRQ)
> or in case the interrupt number is bigger than the NR_IRQs which
> the irq controller can handle (!CONFIG_SPARSE_IRQ).
> 
> So in my opinion, it makes sense to keep this check.

So, you mean that if fwnode_irq_get() succeeded there is a chance that returned
Linux IRQ number is invalid?! If it's so, it's something new to me. I would like
to see the details, please!

-- 
With Best Regards,
Andy Shevchenko



