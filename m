Return-Path: <linux-iio+bounces-20283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38639AD0D54
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 14:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73655189076A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852892206BF;
	Sat,  7 Jun 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON2RV2ra"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B431FA859;
	Sat,  7 Jun 2025 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749298759; cv=none; b=uGC4HpbA4UzHs+oXdLQZ4NL64Ko8yKaRnyjRKZ35GWkS7Idvjh1L/AWy5OvEYt+QbczcUXM1L3UucEb+YMvZDLZAJt7A8swzQZFTc/KFdLorjup4KS/x/CsspwWrANC+sk7WW6wpm8loZOXCdIJpMlvgKi+cMLxqgde8DcDacnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749298759; c=relaxed/simple;
	bh=w2DyumJs7cOJbwAL33h6oxUYA9Api2hkt43KHYq+pT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdvfwUgSxDZE3DYiFuYMEQDheZQDmXNn3Umwmj5fPCEbzIYr8cSYyFIaKD3cw3w19mhnu5FFV8/tXyS9TjdZETwmOWUX1cV7XEAda6ZMiK2u+FvdF44cdDLah+0XoU3HWN2xm5D952OMmy4BdcY+/Qjlcbm9Iky6fgo2X45qDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON2RV2ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8787C4CEE4;
	Sat,  7 Jun 2025 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749298758;
	bh=w2DyumJs7cOJbwAL33h6oxUYA9Api2hkt43KHYq+pT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ON2RV2ramxoF5zguFHhUHn7LVYh9wpZyiCbg+syejc3q3DgrsHBGJqrlhN5cSnJLf
	 W4uUIAR5Q/LpJyZWHqfL9AAx0+a3AARedtzhkNTU8enoPdbAyRN/Ae3MIXiQOzgQze
	 uCRKPQwLbF01cRXmg3qrURo+8pXIQW2A8OTKAxcTdetBtdiTqJwMfJAzEQE4auwoBI
	 JKXs4CENbBVYh9NlWIauO7ya85xGFkcBTCINWAT7nelwsb20MfAJFdyeuJAClG1vhn
	 DlWaH/NyK2p80l/gJHxHx1K5FYOqI+hEHcuL+InKAl44W1jhkraiJI+6rs/xB5Scih
	 HyjS9OxfCw8rQ==
Date: Sat, 7 Jun 2025 13:19:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, Andy Shevchenko <andy@kernel.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, dlechner@baylibre.com, rafael@kernel.org,
 djrscally@gmail.com
Subject: Re: [PATCH v9 09/12] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <20250607131905.4e42cbcd@jic23-huawei>
In-Reply-To: <aD4WndkKGIWVVWx6@surfacebook.localdomain>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
	<27cccb51cc56f1bb57cb06d279854a503d779e25.1748447035.git.Jonathan.Santos@analog.com>
	<aDnuvAdkcTAP2tMt@smile.fi.intel.com>
	<aD3cK5PioN7Rw3pP@JSANTO12-L01.ad.analog.com>
	<aD4WndkKGIWVVWx6@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Jun 2025 00:25:40 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Mon, Jun 02, 2025 at 02:15:23PM -0300, Jonathan Santos kirjoitti:
> > On 05/30, Andy Shevchenko wrote:  
> > > On Thu, May 29, 2025 at 07:50:29PM -0300, Jonathan Santos wrote:  
> 
> ...
> 
> > > > +static int ad7768_trigger_sources_sync_setup(struct device *dev,
> > > > +					     struct fwnode_handle *dev_fwnode,
> > > > +					     struct ad7768_state *st)
> > > > +{
> > > > +	struct fwnode_reference_args args;
> > > > +
> > > > +	struct fwnode_handle *fwnode __free(fwnode_handle) =
> > > > +		fwnode_find_reference_args(dev_fwnode, "trigger-sources",
> > > > +					   "#trigger-source-cells", 0,
> > > > +					   AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);  
> > > 
> > > I don't see how args are being used. This puts in doubt the need of the first
> > > patch.  
> > 
> > If the wrapper is the issue, maybe it is better doing this instead?
> > 
> > static int ad7768_trigger_sources_sync_setup(struct device *dev,
> > 					     struct fwnode_handle *dev_fwnode,  
> 
> Name it fwnode...
> 
> > 					     struct ad7768_state *st)
> > {
> > 	struct fwnode_reference_args args;
> > 	struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;  
> 
> ...and this one something like 'ref'. Also I'm not sure the __free() will do
> what you expect from it.
> 
> > 	int ret;
> > 
> > 	ret = fwnode_property_get_reference_args(dev_fwnode, "trigger-sources",
> > 						 "#trigger-source-cells", 0,
> > 						 AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);
> > 	if (ret)
> > 		return ret;
> > 
> > 	fwnode = args.fwnode;  
> 
> Yes, please. This looks better.

Take a look at the guidance in cleanup.h first.  Linus made it very clear
that the = NULL then set it later pattern was not the way to go. That was
one of the things buried deep in a discussion thread soon after the cleanup.h
stuff was proposed and the lack of general knowledge of that preference lead
to Dan adding that documentation to cleanup.h.

If __free is used Linus always wants to see the constructor and destructor in the same line. 

That is why I suggested the approach in patch 1.

If that isn't acceptable (yet), wrap this up in a local function doing the equivalent
of patch 1 and we can wait and see how common this ends up being.

Jonathan


> 
> > > > +	/* First, try getting the GPIO trigger source */
> > > > +	if (fwnode_device_is_compatible(fwnode, "gpio-trigger")) {
> > > > +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, fwnode,
> > > > +							       NULL,
> > > > +							       0,
> > > > +							       GPIOD_OUT_LOW,
> > > > +							       "sync-in");
> > > > +		return PTR_ERR_OR_ZERO(st->gpio_sync_in);
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * TODO: Support the other cases when we have a trigger subsystem
> > > > +	 * to reliably handle other types of devices as trigger sources.
> > > > +	 *
> > > > +	 * For now, return an error message. For self triggering, omit the
> > > > +	 * trigger-sources property.
> > > > +	 */
> > > > +	return dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> > > > +}  
> > 
> > Then we can get rid of the first patch.  
> 


