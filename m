Return-Path: <linux-iio+bounces-19859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73ECAC3382
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BC27ACE55
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC401EEA47;
	Sun, 25 May 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYDyzMA+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EB1E633C;
	Sun, 25 May 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748166106; cv=none; b=GxtW1fAnlVD+iMY/DuPzSnlyNU9kIy3JRqOfIg2TurhTJdGFHZNy6LTAT3t2WSRKHHLLjWL2PGNtoBLOZppfY52XOeg5hwvd9E3luOZewdID0n+iMiIPR4ue8d/mrtY/2MeFUSReUJp3XQ3P4n00DH+EfRHT7TPfgzRdELikOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748166106; c=relaxed/simple;
	bh=r9HzIRPgbmeJESQvUCAlvAlaFNhUXfcVE3jFVKC2nRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABR3MdCIw9Fg67vnfbZubVukmlrgSVRVmWOe/Iy+0D8nu5lelosaNtPaIPm89ZAwNO0gqBfH4xuOPHtjuEcrehOihQICSOQsaQ/k3H6CAiY2vfOyNKYSgRUUx6FmM9BQC2Mz269C4sDSeceYaur7S69bTOdqc8JNiW/j+yR3VoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYDyzMA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D83C4CEEF;
	Sun, 25 May 2025 09:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748166106;
	bh=r9HzIRPgbmeJESQvUCAlvAlaFNhUXfcVE3jFVKC2nRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nYDyzMA+/05HiyMAeBF4X18FxV3qM3tI/M6VCGLH1QI+DtxBxW/hU5hlO91rQbBxn
	 VQaH89vukuAFFweCRspw4E3+meBZ1xMcxBzr+ShxxeUvXC9ComgIZUoYeuIM6FcGEC
	 yWx/m4hNkJ2FojQ8MDIgdM9LB4gT0HwKxnqnJ2t6O9Xq8MC0mliHSylfTzxjyfQrBz
	 kHFh6fKVX8mb4DeZ1CHf5cZkIFXa7nzIihRzirWB1EteJydAiWNAMDhdhyY36BmHg1
	 VuEDBL17TbWZD8LJ4qjHXmoWLvIWfW7eS2GrMGMHWKUG2TYkEr8Yhd2MveKTHVsCQy
	 3rOUF6njZ0lTQ==
Date: Sun, 25 May 2025 10:41:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 20250518175832.77b8d670@jic23-huawei.smtp.subspace.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v8 08/11] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <20250525104133.1ccf5bca@jic23-huawei>
In-Reply-To: <aDEMEWQvu0r9stCh@JSANTO12-L01.ad.analog.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
	<59f45c9af16fa68f2a479f824129f5a9f2cd0997.1747175187.git.Jonathan.Santos@analog.com>
	<aCcFXolH0FVBSP11@smile.fi.intel.com>
	<20250518175832.77b8d670@jic23-huawei>
	<aDEMEWQvu0r9stCh@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 21:00:17 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 05/18, Jonathan Cameron wrote:
> > On Fri, 16 May 2025 12:29:02 +0300
> > Andy Shevchenko <andy@kernel.org> wrote:
> >   
> > > On Thu, May 15, 2025 at 06:13:56PM -0300, Jonathan Santos wrote:  
> > > > The synchronization method using GPIO requires the generated pulse to be
> > > > truly synchronous with the base MCLK signal. When it is not possible to
> > > > do that in hardware, the datasheet recommends using synchronization over
> > > > SPI, where the generated pulse is already synchronous with MCLK. This
> > > > requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
> > > > 
> > > > Use trigger-sources property to enable device synchronization over SPI
> > > > and multi-device synchronization while replacing sync-in-gpios property.    
> > Given some discussion in here I'll not (yet) pick up this series.
> > 
> > It's almost certainly just missed the coming merge window anyway so
> > we have time.
> >   
> > > 
> > > ...
> > >   
> > > > +static int ad7768_trigger_sources_get_sync(struct device *dev,
> > > > +					   struct ad7768_state *st)
> > > > +{
> > > > +	struct fwnode_reference_args args;
> > > > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> > > > +	 * to synchronize one or more devices:
> > > > +	 * 1. Using an external GPIO.
> > > > +	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
> > > > +	 *    synchronization pulse that drives the SYNC_IN pin.
> > > > +	 */
> > > > +	if (!fwnode_property_present(fwnode, "trigger-sources")) {    
> > > 
> > > I'm wondering if you can split the below to a separate function and do something like
> > > 
> > > 	if (fwnode_property_present(...))
> > > 		return setup_trigger_source(...);
> > > 
> > > 	...
> > > 	en_spi_sync = true;
> > > 	return 0;
> > >   
> > > > +		/*
> > > > +		 * In the absence of trigger-sources property, enable self
> > > > +		 * synchronization over SPI (SYNC_OUT).
> > > > +		 */
> > > > +		st->en_spi_sync = true;
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	ret = fwnode_property_get_reference_args(fwnode,
> > > > +						 "trigger-sources",
> > > > +						 "#trigger-source-cells",
> > > > +						 0,
> > > > +						 AD7768_TRIGGER_SOURCE_SYNC_IDX,
> > > > +						 &args);    
> > > 
> > > 
> > > __free(fwnode_handle) ?  
> > 
> > For args.fwnode?
> > 
> > That's fiddly to do and needs a different local variable to...
> > 
> > 
> >   
> > >   
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	fwnode = args.fwnode;  
> > 
> > this one.
> > 
> > You could wrap it up in a function to make that works cleanly.
> > So something similar to fwnode_find_reference() but with the
> > rest of the arguments.  Is there appetite for such a wrapper
> > in the generic property code?
> >  
> 
> you mean like:
> 
> fwnode_find_reference_args(const struct fwnode_handle *fwnode,
> 			   const char *name, const char *nargs_prop,
> 			   unsigned int nargs, unsigned int index,
> 			   struct fwnode_reference_args *args)
> 
> I don't know if it helps that much and since we are not handling
> arguments right know, I think fwnode_find_reference() would work (or not?).
> In that case maybe we add some note or TODO to explain why. 

The only reason for a new wrapper (exactly like you have it) is the
return of struct fwnode_handle * that lets you use 

struct fwnode_handle *fwnode __free(fwnode_handle) =
	fwnode_find_reference_args(fwnode, "trigger-sources",
				   "#trigger-source-cells", 0,
				    AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);

So basically making it look like normal cleanup.h handling.

I was hoping Any would chime in with a view on whether that is likely
to go down well added to property.h

Using fwnode_find_reference() is a bad idea because of the need for
a TODO etc to explain that we are assuming the cells are always 1.


> 
> >   
> > > > +	/* First, try getting the GPIO trigger source */
> > > > +	if (fwnode_device_is_compatible(fwnode, "gpio-trigger")) {
> > > > +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, fwnode,
> > > > +							       NULL,
> > > > +							       0,
> > > > +							       GPIOD_OUT_LOW,
> > > > +							       "sync-in");
> > > > +		ret = PTR_ERR_OR_ZERO(st->gpio_sync_in);
> > > > +		goto out_put_node;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * TODO: Support the other cases when we have a trigger subsystem to
> > > > +	 * reliably handle other types of devices as trigger sources.
> > > > +	 *
> > > > +	 * For now, return an error message. For self triggering, omit the
> > > > +	 * trigger-sources property.
> > > > +	 */
> > > > +	ret = dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> > > > +
> > > > +out_put_node:    
> > > 
> > > The above will allow to get rid of this label.
> > >   
> > > > +	fwnode_handle_put(args.fwnode);
> > > > +	return ret;
> > > > +}    
> > >   
> >   


