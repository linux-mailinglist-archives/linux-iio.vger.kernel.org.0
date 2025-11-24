Return-Path: <linux-iio+bounces-26413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FCC7FA9D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9ADD4E22D1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4D2F60C7;
	Mon, 24 Nov 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HD5JNrH+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FEC2F5465;
	Mon, 24 Nov 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976981; cv=none; b=ebGEJHxFfMyP6fj5/A1xpXU0vwCj6V4bDANTQYtXne2ASldlFKdTNmpMn9WSEvZfcAaxHziY4sOTIjjw63wYQrAT8QigZ6J7or4xBh5PDA07GNj6L8SV+Uo0osv0RE3+fA66IZMrxD0ht4Bt6f3n0ptH2/FHiCwhPL+XVDk6ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976981; c=relaxed/simple;
	bh=V0qerlrtNZqBpFKg+N9laGJk6nVd3gEUb27Uxk15PNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiMjlu1+WNxiwzbjMc1PFhHz19PFiu+XaB7TaP/NIYRQlLNZkUb4AqDbxYt/cRFw1oKWS3Uqvcu9mZ3Al2MZQ6hwWRqrgtNfiwkxlq73v7u013LM/RIapNCHJxy87LYrRnSBHLpOYxCsLiOSAT83si9Qn+DMQefYxLRFmQ8RJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HD5JNrH+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763976980; x=1795512980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V0qerlrtNZqBpFKg+N9laGJk6nVd3gEUb27Uxk15PNM=;
  b=HD5JNrH+TtgocZv884PL23IyO6mHmdAa6RbaSq2IGGn4CRwRDAAEOI7u
   +G6PsATyD1XuJbWKomASRihykrWsBiatz7KkZct8uEGWbc9ICrnHcERKH
   Wu97AU2c06IU7yxoMYGcu3eQwKK/rtr9RmoBJ49BPfI9T1Bze/WpaLA8X
   YeY8pGlXBzj7FZTlIlStrwn/j5L/Y/R9sZbNejJOH3l6mMiWcxN2uwLWd
   KWY8rW3vRrKxDrpxvchB13cQjcVZrgmUfzBxIFULtQrwgDP9/OEK6l4ee
   j1ajaCR0XCD0cSZwh8kks4HY/Qb3oyy5H7HzWwEi3DVnw9GX9MUMvVUYg
   w==;
X-CSE-ConnectionGUID: +/5t9wo+Sx+bQHudlKMVxQ==
X-CSE-MsgGUID: EmQwJSCsRDm9awOGBguw7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="83360369"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="83360369"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 01:36:19 -0800
X-CSE-ConnectionGUID: 8Ppew+02R1yotk90oqeDzw==
X-CSE-MsgGUID: XhIxGgG1RUCS0TUsoDinHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="191446304"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 01:36:15 -0800
Date: Mon, 24 Nov 2025 11:36:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iio: adc: ad4062: Add IIO Trigger support
Message-ID: <aSQnDMsE13zwM1YO@smile.fi.intel.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-5-a375609afbb7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-staging-ad4062-v2-5-a375609afbb7@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 10:18:04AM +0100, Jorge Marques wrote:
> Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
> signal, if not present, fallback to an I3C IBI with the same role.
> The software trigger is allocated by the device, but must be attached by
> the user before enabling the buffer. The purpose is to not impede
> removing the driver due to the increased reference count when
> iio_trigger_set_immutable or iio_trigger_get is used.

We refer to the functions as func(). Mind the parentheses.

...

> +	struct ad4062_state *st = container_of(work, struct ad4062_state,
> +					       trig_conv);

I think the

	struct ad4062_state *st =
		container_of(work, struct ad4062_state, trig_conv);

reads better.

> +	int ret;

...

> +	/* Read current conversion, if at reg CONV_READ, stop bit triggers
> +	 * next sample and does not need writing the address.
> +	 */

/*
 * The multi-line comment style is as in
 * this example. Please, check and update.
 */

> +static irqreturn_t ad4062_poll_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	schedule_work(&st->trig_conv);
> +
> +	return IRQ_HANDLED;
>  }

...

> +static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4062_set_operation_mode(st, st->mode);
> +	if (ret)
> +		goto out_mode_error;
> +
> +	/* CONV_READ requires read to trigger first sample. */
> +	struct i3c_priv_xfer t[2] = {
> +		{
> +			.data.out = &st->reg_addr_conv,
> +			.len = sizeof(st->reg_addr_conv),
> +			.rnw = false,
> +		},
> +		{
> +			.data.in = &st->buf.be32,
> +			.len = sizeof(st->buf.be32),
> +			.rnw = true,
> +		}
> +	};
> +
> +	ret = i3c_device_do_priv_xfers(st->i3cdev, t, st->gpo_irq[1] ? 2 : 1);
> +	if (ret)
> +		goto out_mode_error;
> +	return 0;
> +
> +out_mode_error:
> +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> +
> +	return ret;

I guess with ACQUIRE() this function will look better, because the explicit
reference count bumping (with an associated comment) is more descriptive on
what's going on here with PM. Same for other related functions.

> +}

...

>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");
>  
> +	INIT_WORK(&st->trig_conv, ad4062_trigger_work);

This is mixture of devm_*() and non-devm_*() calls. How did you (stress) test
the removal and error paths here? Wouldn't devm-helpers.h APIs help here to
make / keep order correct?

>  	return devm_iio_device_register(dev, indio_dev);

-- 
With Best Regards,
Andy Shevchenko



