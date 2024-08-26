Return-Path: <linux-iio+bounces-8791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926295EE6E
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1005A1F2256E
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBDC14900F;
	Mon, 26 Aug 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElIHq7Il"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E1142E67;
	Mon, 26 Aug 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667845; cv=none; b=JSvwRDTuoVShcb7NqCgQNyZAiwQ+gQ0WqJoow9foStMJTFQo2LYxDPwcziscyX835PcOQVjfyc94UpSNHtaCNmepyp1ec4DI/L+2F9LqOZvxifi8hRm9PZ8hvcTs/UD0RkH24kucBXF0JeTvZFYH+nOoLLJzqsrCrVBqEoRf98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667845; c=relaxed/simple;
	bh=IvAVlVJonYi/7M/pzQ0hSSlCZkPgEn0Pce4bQ7psSMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEFQtdsmbnqQksHKpayfHodGkPdoFywJcHEhTyPJCzMqUo8FXcGYPDwD8vRjGeO2OMLoNy51XBFOQIJzodQ2pf+RQAovEy0rq4byKmV8W91VU7h9Akx8Lz1c0aIYh+8LlwCZhrIe/M8afVI4T8Z2zTYNsKzlpajpMf5Wdtpd4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElIHq7Il; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724667844; x=1756203844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvAVlVJonYi/7M/pzQ0hSSlCZkPgEn0Pce4bQ7psSMQ=;
  b=ElIHq7Ilv+WhqPkn6vaaoX1o3gV8KKa8g1wMy5FswUHnmcoFOG5kV5bK
   51jUP3MKIStCcFJUzaiT9CvnixsUTKg0LT5i6FMObNfGeeeAWj2hNEk2s
   FGz89keQVmyhru/9pPvP2mpKtRFlEPel1GYDVv504UUOaDSquLBo3dlxK
   XM9ijwIBZr8biZ1y6lIrr/mX8D+c6SRLurx2LxYQceWtMcDJTkslPboG0
   smH5zhYNbcAc54By2oeTYI66hXgWVdl7srUDqT83pfW0mof1gI2NJw251
   TPyxEvsCDMBNJoV5Ek0kvfxum3XNtAvx2B6mCTkYeHx+VKwYP4s44dzCo
   Q==;
X-CSE-ConnectionGUID: C3tXSUzqRnaQ2erQXdGGqQ==
X-CSE-MsgGUID: rLYacerYQk+Qxg5SmNMOnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="34238065"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="34238065"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:24:03 -0700
X-CSE-ConnectionGUID: +xQud3KXR6+jR0CArLQrmQ==
X-CSE-MsgGUID: Y3na5YOeTJKF9DZMQpFrNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62305089"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:23:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siWtA-00000001pZJ-3rJi;
	Mon, 26 Aug 2024 13:23:56 +0300
Date: Mon, 26 Aug 2024 13:23:56 +0300
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
Message-ID: <ZsxXvGy4GNrZWs-D@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-7-vassilisamir@gmail.com>
 <ZsjrxLlhmx-TzwXF@smile.fi.intel.com>
 <20240824120222.GG9644@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824120222.GG9644@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 24, 2024 at 02:02:22PM +0200, Vasileios Amoiridis wrote:
> On Fri, Aug 23, 2024 at 11:06:28PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 23, 2024 at 08:17:13PM +0200, Vasileios Amoiridis wrote:

...

> > > +static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
> > > +				  const struct iio_trigger_ops *trigger_ops,
> > > +				  int (*int_config)(struct bmp280_data *data),
> > 
> > > +				  irqreturn_t (*irq_thread_handler)(int irq, void *p))
> > 
> > irq_handler_t
> 
> But the function returns an irqreturn_t type, no?

The type of the last parameter is irq_handler_t, no need to open code it.

...

> > > +	fwnode = dev_fwnode(data->dev);
> > > +	if (!fwnode)
> > > +		return -ENODEV;
> > 
> > Why do you need this? The below will fail anyway.
> 
> Because If I don't make this check then fwnode might be garbage and I will
> pass garbage to the fwnode_irq_get() function. Or do I miss something?

Yes, the function validates fwnode before use. So, please drop unneeded (or
even duplicate) check.

...

> > > +	irq = fwnode_irq_get(fwnode, 0);
> > > +	if (!irq)
> > 
> > Are you sure this is correct check?
> > 
> Well, I think yes, because the function return either the Linux IRQ number
> on success or a negative errno on failure.

Where is 0 mentioned in this?

> https://elixir.bootlin.com/linux/v6.10.6/source/drivers/base/property.c#L987
> 
> > > +		return dev_err_probe(data->dev, -ENODEV,
> > 
> > Shadowed error code.
> 
> I am not sure I understand what you mean here. You mean that there is no
> chance that the first one will pass and this one will fail?

-ENODEV is not what fwnode_irq_get() returns on error.

> > > +				     "No interrupt found.\n");

...

> > > +	desc = irq_get_irq_data(irq);
> > > +	if (!desc)
> > > +		return -EINVAL;
> > 
> > When may this fail?
> 
> I think that this will fail when Linux were not able to actually
> register that interrupt.

Wouldn't fwnode_irq_get() fail already?

...

> > 	if (ret)
> > 		dev_err(data->dev, "Could not enable/disable interrupt\n");

Btw you may use str_enable_disable() here.

> > 	return ret;
> > 
> > ?
> 
> All the other if statements follow the style that I typed. If I
> follow yours, will make it different just for this one, does it
> make sense?

When a comment is given, it's assumed that the _full_ patch (or patch series)
should be revisited for it. Or should I add to every comment something like
this:

"Please, check the entire code for the same or similar case and amend
accordingly."

?

-- 
With Best Regards,
Andy Shevchenko



