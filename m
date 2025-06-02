Return-Path: <linux-iio+bounces-20174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAB0ACBCAE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 23:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90303A2549
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66771990C7;
	Mon,  2 Jun 2025 21:26:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073402C3251
	for <linux-iio@vger.kernel.org>; Mon,  2 Jun 2025 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748899564; cv=none; b=pO8c3Gohw4pMJOzwg0zkRwRc9XxYPJrA9oCjXOdnBfYF0moUvvIWLqtQStsX/4DHkfPaP5oBSJs1xmLivfHTrqs6jSjxoeEEcR9VU5LJa3Sc7vb9BvdoEFM91d+tAFA+bldeFl8xe6hhqHrtwXE8t0Tm2tUc6SmA+W+2knBJr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748899564; c=relaxed/simple;
	bh=jNUNQAqQgPC6l0XchUq2j78f67t3HtqKvRqBBAoRDbU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUZUflvKgxLgDntVwELXeLPf2yqNLno2zKbNClTKz+pBrLz370wWg6H6/Su3yVzWOUu8TthbkPms+eFbprEiMct4BUXkzC3Nz0MhCkG4QwzBam3Kuo8ZTKj3jYmB13GEUAzLcrOYHepFe1G+eSYeNTKqwO/vTZlNmHruek80n5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 220d7b81-3ff8-11f0-a94d-005056bdfda7;
	Tue, 03 Jun 2025 00:25:41 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Jun 2025 00:25:40 +0300
To: andriy.shevchenko@linux.intel.com
Cc: Andy Shevchenko <andy@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com, rafael@kernel.org,
	djrscally@gmail.com
Subject: Re: [PATCH v9 09/12] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <aD4WndkKGIWVVWx6@surfacebook.localdomain>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
 <27cccb51cc56f1bb57cb06d279854a503d779e25.1748447035.git.Jonathan.Santos@analog.com>
 <aDnuvAdkcTAP2tMt@smile.fi.intel.com>
 <aD3cK5PioN7Rw3pP@JSANTO12-L01.ad.analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD3cK5PioN7Rw3pP@JSANTO12-L01.ad.analog.com>

Mon, Jun 02, 2025 at 02:15:23PM -0300, Jonathan Santos kirjoitti:
> On 05/30, Andy Shevchenko wrote:
> > On Thu, May 29, 2025 at 07:50:29PM -0300, Jonathan Santos wrote:

...

> > > +static int ad7768_trigger_sources_sync_setup(struct device *dev,
> > > +					     struct fwnode_handle *dev_fwnode,
> > > +					     struct ad7768_state *st)
> > > +{
> > > +	struct fwnode_reference_args args;
> > > +
> > > +	struct fwnode_handle *fwnode __free(fwnode_handle) =
> > > +		fwnode_find_reference_args(dev_fwnode, "trigger-sources",
> > > +					   "#trigger-source-cells", 0,
> > > +					   AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);
> > 
> > I don't see how args are being used. This puts in doubt the need of the first
> > patch.
> 
> If the wrapper is the issue, maybe it is better doing this instead?
> 
> static int ad7768_trigger_sources_sync_setup(struct device *dev,
> 					     struct fwnode_handle *dev_fwnode,

Name it fwnode...

> 					     struct ad7768_state *st)
> {
> 	struct fwnode_reference_args args;
> 	struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;

...and this one something like 'ref'. Also I'm not sure the __free() will do
what you expect from it.

> 	int ret;
> 
> 	ret = fwnode_property_get_reference_args(dev_fwnode, "trigger-sources",
> 						 "#trigger-source-cells", 0,
> 						 AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);
> 	if (ret)
> 		return ret;
> 
> 	fwnode = args.fwnode;

Yes, please. This looks better.

> > > +	/* First, try getting the GPIO trigger source */
> > > +	if (fwnode_device_is_compatible(fwnode, "gpio-trigger")) {
> > > +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, fwnode,
> > > +							       NULL,
> > > +							       0,
> > > +							       GPIOD_OUT_LOW,
> > > +							       "sync-in");
> > > +		return PTR_ERR_OR_ZERO(st->gpio_sync_in);
> > > +	}
> > > +
> > > +	/*
> > > +	 * TODO: Support the other cases when we have a trigger subsystem
> > > +	 * to reliably handle other types of devices as trigger sources.
> > > +	 *
> > > +	 * For now, return an error message. For self triggering, omit the
> > > +	 * trigger-sources property.
> > > +	 */
> > > +	return dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> > > +}
> 
> Then we can get rid of the first patch.

-- 
With Best Regards,
Andy Shevchenko



