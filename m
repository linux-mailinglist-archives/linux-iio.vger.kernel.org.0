Return-Path: <linux-iio+bounces-14194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01143A0A927
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22A93A6A78
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA01B218F;
	Sun, 12 Jan 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApFOpOxq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80E3232;
	Sun, 12 Jan 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685033; cv=none; b=JXuvPZaHQfpqeHymGhsRSB+uKeS+c+d9seVQNnvwAOiNWthmi/Q9aKgOsgS6x9DUwsArofjYn3imqtowBkErEQRAHUNOMH+Rd3V690pd1HQOZ7TP1JFL2EIon4xIG4Cxm6c0hwFe0PCnOZ5mWyi+8aXQWUjmi0bPFtFcZzyDX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685033; c=relaxed/simple;
	bh=5h5xs1inuhF6iOgl16LMuCRdGTY1joMZRij9/bhd7ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+6GdxWRKBylB0w/I72QXW7rHSHMK85oUeO4xPxcbppLMCR6teSMUmCXzb/bzLbhf4qSBK0Ck5IdbCVrTRka2gqnhL/0FtNMwMOZ3kPs0DWgKU9IQwvU5LdAr00BCp0qAh2z594TQWegpXJBIR8ZehhHwSU41saI2W3ij5Bdjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApFOpOxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C8AC4CEDF;
	Sun, 12 Jan 2025 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736685033;
	bh=5h5xs1inuhF6iOgl16LMuCRdGTY1joMZRij9/bhd7ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ApFOpOxqC6amGgyrUt3Ij/DqWmaU3BsYcPTKVda3IuyAfRfLkGrRFTKVZECJfQAB2
	 6UUU9JDgDJCANojJBku9C+GnNm5pslSOEI7dWX5h4wXhCUQD//rluZCahGMP3MrUmJ
	 B/iv7a57rC8UXdR2IZiqAVw+3mawkkfaHKmoy3rcFvnsq21RQyxmHWCL2CeaOXO4GX
	 O1LVYU8t6k07SDwzkoKKFEv8TX0+3zLos7JpscG7QhThlmg3XQKdmN00A54WltbfLw
	 XMR+gmzFCxSnBI4lj3q7OBgKBorVLpznenUfzAFiuAF6P4lq+sWTRcbZQojar2Z+lE
	 bL3XahDLpms7g==
Date: Sun, 12 Jan 2025 12:30:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Santos
 <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v1 05/15] iio: adc: ad7768-1: set MOSI idle state to
 high
Message-ID: <20250112123023.75dc7750@jic23-huawei>
In-Reply-To: <Z4GXikxVw6mHIYHc@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<714ff48341753de0509208e3c553b19c1c43e480.1736201898.git.Jonathan.Santos@analog.com>
	<4449ec60-08cd-4074-ba0b-95603864a458@baylibre.com>
	<Z4GXikxVw6mHIYHc@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 18:56:26 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/07, David Lechner wrote:
> > On 1/7/25 9:25 AM, Jonathan Santos wrote:  
> > > All supported parts require that the MOSI line stays high
> > > while in idle.
> > > 
> > > Configure SPI controller to set MOSI idle state to high.
> > > 
> > > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---  
> ...
> > > @@ -574,6 +574,15 @@ static int ad7768_probe(struct spi_device *spi)
> > >  		return -ENOMEM;
> > >  
> > >  	st = iio_priv(indio_dev);
> > > +	/*
> > > +	 * The ADC SDI line must be kept high when
> > > +	 * data is not being clocked out of the controller.
> > > +	 * Request the SPI controller to make MOSI idle high.
> > > +	 */
> > > +	spi->mode |= SPI_MOSI_IDLE_HIGH;
> > > +	ret = spi_setup(spi);
> > > +	if (ret < 0)
> > > +		return ret;
> > >  	st->spi = spi;
> > >  
> > >  	st->vref = devm_regulator_get(&spi->dev, "vref");  
> > 
> > Very few SPI controllers currently have the SPI_MOSI_IDLE_HIGH capability flag
> > set in Linux right now (whether they actually support it or not), so this could
> > break existing users.  
> 
> Good point. Maybe only dev_warn() if SPI_MOSI_IDLE_HIGH is not supported?
> 
> >   
> ...
> > 
> > If we ever do implement a data read of more than 64 bits without toggling CS,
> > then we could just set the TX data to be all 0xFF and have the same effect
> > without requiring the SPI controller to support SPI_MOSI_IDLE_HIGH.  
> 
> One point of having SPI_MOSI_IDLE_HIGH is that the controller may bring MOSI low
> between data words of a transfer. I think all transfer words are going to be
> either 16 or 24 with the new patches setting bits_per_word in all transfers but
> that might still not be enough if eventually the controller is unable to support
> those word sizes. 

Can we make the use of SPI_MOSI_IDLE_HIGH only apply if controller doesn't support
what is required to do the transfers in one go?

> Plus you would have the complication of filling the tx_buf for
> all transfers.

Wrap that up in a regmap, or read and write functions and that should be easy enough.

> 
> For the part that instigated the development of SPI_MOSI_IDLE_HIGH, the MOSI line
> also had to be high in between transfers. The diagrams at AD7768-1 datasheet
> page 51 suggest the same would be needed for this chip too.

Whilst the datasheet indeed draws lines for that, i doubt it notices except on
clock transitions and between transfers the clock won't do anything.
If we confirm that the device does notice, then I don't mind limiting the controllers
to those with that can ensure it doesn't get set wrong.

Jonathan



