Return-Path: <linux-iio+bounces-14445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 956EAA15C98
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0325918889AB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF218A959;
	Sat, 18 Jan 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRErZucm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF132913;
	Sat, 18 Jan 2025 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202178; cv=none; b=X2fBQTPqJjrzGVkqC9MC22CL5OKeRvUHIo1H6XXkCAIw3r0qzrTZLRMy4ZmGF3X1O3sQsI1YynuNN7nAKMVCbg99kHtqJT+858BnfdjJmkNO6pJK1NqHbCFITBn7A82TskxECMhvJKbXPq6p6cDLvw3P5/zjhtIUA8lft+49rcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202178; c=relaxed/simple;
	bh=+QzY0ffQEFAkjh3zr9/im3TEfOf3Oo48401oAKKLueg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4Oa0QEcQY1TPqJ5NjhtasZt0t02NmbyJ+FlD2RBaCykanmeXFjxUyDs8+GjV85TD5EOJZmd8rhVOCVq12WQsUOAPZvMISk6ZS+f3WI9tCZmdMCzgVuOF6/DwHmo0e7N5ai5VdBjyv4Fg9muLK6wa2UjqTk++XYM4e/dVXhxuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRErZucm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BF9C4CED1;
	Sat, 18 Jan 2025 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737202177;
	bh=+QzY0ffQEFAkjh3zr9/im3TEfOf3Oo48401oAKKLueg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oRErZucmbepNNkRMJ3lCvU823NYh0sISFsYueDrMpFtC/n1j3hfqO1ngQwMOcHyH0
	 oCBsblxVpFe2pClI8KrI0L5LrfuTc+/XnkDAco97DtfZiH6BILply76ldpIKiKWBHv
	 Q//dLc4Ms4zcxzmuXdVysotal2Hx2qvFQifYEMU7bBuvXZWEvc3JuiPCvPqPo0nNFU
	 1/C93HVmsien2RfAtFqLOTOzoE+Nc8gMP6MsWW5ir4EZJT0qEiRHRYzbVundqSkZx7
	 DpVpcsvJ9ALjdsXW1wP4THYpG169ayrg9Bekl3GArheRTiu/sD1ZgpftHmOB+mza3Q
	 Dc6Bo6w48z3oQ==
Date: Sat, 18 Jan 2025 12:09:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Santos
 <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v1 05/15] iio: adc: ad7768-1: set MOSI idle state to
 high
Message-ID: <20250118120927.08f21fbc@jic23-huawei>
In-Reply-To: <Z4UE3p6HCsD8PiGh@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<714ff48341753de0509208e3c553b19c1c43e480.1736201898.git.Jonathan.Santos@analog.com>
	<4449ec60-08cd-4074-ba0b-95603864a458@baylibre.com>
	<Z4GXikxVw6mHIYHc@debian-BULLSEYE-live-builder-AMD64>
	<20250112123023.75dc7750@jic23-huawei>
	<Z4UE3p6HCsD8PiGh@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 09:19:42 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/12, Jonathan Cameron wrote:
> > On Fri, 10 Jan 2025 18:56:26 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >   
> > > On 01/07, David Lechner wrote:  
> > > > On 1/7/25 9:25 AM, Jonathan Santos wrote:    
> > > > > All supported parts require that the MOSI line stays high
> > > > > while in idle.
> > > > > 
> > > > > Configure SPI controller to set MOSI idle state to high.
> > > > > 
> > > > > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > > ---    
> > > ...  
> > > > > @@ -574,6 +574,15 @@ static int ad7768_probe(struct spi_device *spi)
> > > > >  		return -ENOMEM;
> > > > >  
> > > > >  	st = iio_priv(indio_dev);
> > > > > +	/*
> > > > > +	 * The ADC SDI line must be kept high when
> > > > > +	 * data is not being clocked out of the controller.
> > > > > +	 * Request the SPI controller to make MOSI idle high.
> > > > > +	 */
> > > > > +	spi->mode |= SPI_MOSI_IDLE_HIGH;
> > > > > +	ret = spi_setup(spi);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > >  	st->spi = spi;
> > > > >  
> > > > >  	st->vref = devm_regulator_get(&spi->dev, "vref");    
> > > > 
> > > > Very few SPI controllers currently have the SPI_MOSI_IDLE_HIGH capability flag
> > > > set in Linux right now (whether they actually support it or not), so this could
> > > > break existing users.    
> > > 
> > > Good point. Maybe only dev_warn() if SPI_MOSI_IDLE_HIGH is not supported?
> > >   
> > > >     
> > > ...  
> > > > 
> > > > If we ever do implement a data read of more than 64 bits without toggling CS,
> > > > then we could just set the TX data to be all 0xFF and have the same effect
> > > > without requiring the SPI controller to support SPI_MOSI_IDLE_HIGH.    
> > > 
> > > One point of having SPI_MOSI_IDLE_HIGH is that the controller may bring MOSI low
> > > between data words of a transfer. I think all transfer words are going to be
> > > either 16 or 24 with the new patches setting bits_per_word in all transfers but
> > > that might still not be enough if eventually the controller is unable to support
> > > those word sizes.   
> > 
> > Can we make the use of SPI_MOSI_IDLE_HIGH only apply if controller doesn't support
> > what is required to do the transfers in one go?  
> 
> I think so, but that would require tweaking spi controller drivers since we
> don't know at spi_setup() what transfers will ask for their bits_per_word.
> Not excited with this idea but may try something if that makes it easier to
> support these unusual SPI devices.

I'm confused. Here it is a client driver question I think. That driver knows what
it is asking for.  It can query if that word length is supported, if not query
if SPI_MOSI_IDLE_HIGH is possible and if neither fail to probe with suitable
error message. 

Jonathan


> 
> >   
> > > Plus you would have the complication of filling the tx_buf for
> > > all transfers.  
> > 
> > Wrap that up in a regmap, or read and write functions and that should be easy enough.
> >   
> > > 
> > > For the part that instigated the development of SPI_MOSI_IDLE_HIGH, the MOSI line
> > > also had to be high in between transfers. The diagrams at AD7768-1 datasheet
> > > page 51 suggest the same would be needed for this chip too.  
> > 
> > Whilst the datasheet indeed draws lines for that, i doubt it notices except on
> > clock transitions and between transfers the clock won't do anything.
> > If we confirm that the device does notice, then I don't mind limiting the controllers
> > to those with that can ensure it doesn't get set wrong.
> > 
> > Jonathan
> > 
> >   


