Return-Path: <linux-iio+bounces-20087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A1FAC9C14
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6797F3BEA4E
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C819ABD1;
	Sat, 31 May 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCAuOuZc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E23B19A;
	Sat, 31 May 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748713375; cv=none; b=jfpDbMCW7Y8mDKY0Y2wXkwMHdtkye/MyPYATqt4RKDcZFReT3idZ/fw5LV7NR4Hbk3L+bqqe/O4i8bFhVUVVIPf21FO6qi87z1AHHcPI85WHmq+X9SlR/ljYKRVTRxEv1bJFKxrY26WfbmyZdZT/KxmzknQ1LH/YIlfgZS4tZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748713375; c=relaxed/simple;
	bh=Iva5rHF/MAVSoSgGRlbmsQ1Mf85wBltXL8rYWFF5QzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRtav2EBVDZ67L6xSj+wDNEFEwg68DgwpAOdam6F7+CUCqk9UymARGkII1h1xVDJr/aINkbvLrH0SkXVj1t4OS3fRoWqM8+Xd65PLNUkDVsjn42qmAafsY6Hk2sXETMITqGjqIRohDbN/fkLQsZYO1KYA0Osikhw0H8o2OjkdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCAuOuZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2912C4CEE3;
	Sat, 31 May 2025 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748713374;
	bh=Iva5rHF/MAVSoSgGRlbmsQ1Mf85wBltXL8rYWFF5QzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iCAuOuZccwSniju3wtQ1/YL9YqNaTH2yu61vHn1g4dZ2nHLwe1LAVeZKm7qn/33bB
	 2FIjNOOeg7q3Gb7WbN716cp6sauzZuYJ2ONRo4I7w99uo23Zr3Yt/6uCiUOdsCeMn3
	 GMeSg3thU3fDis892ECaOvSnIdl6Ra4PLAhR6d3WGsfereNBb/ZUoaKUgeA6KITfMC
	 X/JgXBzlvlPpWe+3c+WNYwVTJzVJ67LZD/mDeFh+zYXpPNHgHRWJKoSAdV4q9XAgJ3
	 /3kgbEAR806TcWJAi0htKC4lOkpxExlcvKxPmK3w+/7aGiFJ50REvqBxblZRYJjqMe
	 KgFerdgsoTsGQ==
Date: Sat, 31 May 2025 18:42:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
 rafael@kernel.org, djrscally@gmail.com
Subject: Re: [PATCH v9 09/12] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <20250531184242.468e9e27@jic23-huawei>
In-Reply-To: <aDnuvAdkcTAP2tMt@smile.fi.intel.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
	<27cccb51cc56f1bb57cb06d279854a503d779e25.1748447035.git.Jonathan.Santos@analog.com>
	<aDnuvAdkcTAP2tMt@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 20:45:32 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, May 29, 2025 at 07:50:29PM -0300, Jonathan Santos wrote:
> > The synchronization method using GPIO requires the generated pulse to be
> > truly synchronous with the base MCLK signal. When it is not possible to
> > do that in hardware, the datasheet recommends using synchronization over
> > SPI, where the generated pulse is already synchronous with MCLK. This
> > requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
> > 
> > Use trigger-sources property to enable device synchronization over SPI
> > and multi-device synchronization while replacing sync-in-gpios property.  
> 
> ...
> 
> > struct ad7768_state {  
> 
> >  	struct iio_trigger *trig;
> >  	struct gpio_desc *gpio_sync_in;
> >  	struct gpio_desc *gpio_reset;  
> 
> > +	bool en_spi_sync;  
> 
> I'm wondering if moving this...
> 
> >  	const char *labels[ARRAY_SIZE(ad7768_channels)];
> >  	struct gpio_chip gpiochip;  
> 
> ...to here saves a few bytes in accordance to `pahole`.
> 
> >  };  
> 
> ...
> 
> > +static int ad7768_trigger_sources_sync_setup(struct device *dev,
> > +					     struct fwnode_handle *dev_fwnode,
> > +					     struct ad7768_state *st)
> > +{
> > +	struct fwnode_reference_args args;
> > +
> > +	struct fwnode_handle *fwnode __free(fwnode_handle) =
> > +		fwnode_find_reference_args(dev_fwnode, "trigger-sources",
> > +					   "#trigger-source-cells", 0,
> > +					   AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);  
> 
> I don't see how args are being used. This puts in doubt the need of the first
> patch.

That did get discussed (more context needed in the commit message for patch 1).
I wasn't happy with ignoring #trigger-source-cells which is required in the
binding but here is known to be 0.

If it was larger than 0 but we didn't care about the arguments I believe
we'd still need to use this call to take the right stride through the
data array that this is coming from.
Ultimately I think that is this bit of code establishing the end of the phandle.
https://elixir.bootlin.com/linux/v6.15/source/drivers/of/base.c#L1300

I might have gotten it wrong how this all works though!

J

