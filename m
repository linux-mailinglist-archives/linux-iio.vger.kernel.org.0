Return-Path: <linux-iio+bounces-14864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC12A24EC2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80593A569F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B71D63CA;
	Sun,  2 Feb 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twGCzp4P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE6381A3;
	Sun,  2 Feb 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738509336; cv=none; b=nelY2kcSq8pquZHoDE/05il3S7VpF3cUIMo3mDi7leQryc6KaylRCsh/ohqcUslmyaOs7d2oa+TMpweFa7tOlmjxp54H4KzvwxR218nYPrIQe025XJ+bwh2oRG2p9DbPPxMRToAjvZ18LXSQ1VXdzA1Zrf36Qlsn8kRTl98rApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738509336; c=relaxed/simple;
	bh=uAU7bmuKNbRNKUiGAVgwp9nVJvHKcC9CZxd/CiHOYgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FupYiZN8824D0L7n1hAd0nLY5FmDYJ13RbGW390ZQ/R5LMtTy93gEI0JS1HwvImP5N2Ej+0448OInJFgFS3w1y1v2pgoB6AF8HoezkFSM73FgrvdGmJ+cc+7ULhyI4mlddhmu9hukjBBndLDUeXBf5adEXqjrLVVGtz9refCvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twGCzp4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C67C4CED1;
	Sun,  2 Feb 2025 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738509334;
	bh=uAU7bmuKNbRNKUiGAVgwp9nVJvHKcC9CZxd/CiHOYgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=twGCzp4Pbyz9jCPmZ1oeAMGhN5YODbpg7gGbhidD406ocxIpMMH1bNo+/br1L6Xup
	 IqbKYZMRoXI/I0FjkCrf1hkkeAIKlajw8Fw81lkvRgjUNlAp4+Af1/ozoylAcRcolI
	 buq1AAuwSB3CEDWZPJ+nLSxRPVULUzPnQ7C83GRMtpLQzNUfLErDhDBhi12l+t9wNv
	 1PKJY8UKD72wdSM/r4jt7tbptxxqELO/HbshFMSdiqypQuj74a/s+CtFQ9IMV+hE9r
	 a2UNcNoGIM+OjVHhNNnhE/kfvNIi365Ylz/aiJZe2AojxqbRsADgYM6TLcXrW3HHEK
	 Z8kAnrk0jPv2w==
Date: Sun, 2 Feb 2025 15:15:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <swinchenbach@arka.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "Michael.Hennerich@analog.com"
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2] iio: filter: admv8818: Force initialization of SDO
Message-ID: <20250202151526.457eab08@jic23-huawei>
In-Reply-To: <SA1P110MB1069C9854F796B755E5E24C7BCEBA@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
References: <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
	<20250201111813.6b8cbf5b@jic23-huawei>
	<SA1P110MB1069C9854F796B755E5E24C7BCEBA@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 14:00:58 +0000
Sam Winchenbach <swinchenbach@arka.org> wrote:

> > > When a weak pull-up is present on the SDO line, regmap_update_bits 
> > > fails to write both the SOFTRESET and SDOACTIVE bits because it 
> > > incorrectly reads them as already set.  
> > 
> > I can see this as a valid micro optimization but I'm struggling a bit on how you can use the device if the pull up is weak enough that you can't read data back from it. Does the reset in some way solve that?
> > 
> > Having asked for the fixes tag, I'm less sure on whether this is a fix.
> > 
> > Antoniu, I'd also like your input on this one!
> >   
> 
> On power-up the device is configured without SDO enabled. This, alone, makes the read-modify-write during initialization incorrect - It is not possible to read from the device seeing it is not driving the output.
> 
> If the SPI bus, like in our situation, has a weak pull-up the situation is compounded. When the device initializes it reads backs all 1's as part of the read-modify-write sequence, falsely determines that the soft-reset bit is already set and skips resetting the device. The next step is to enable the SDO line. It reads back all 1's, falsely determines that the SDO is enabled and then skips writing to enable it. This leaves the device in a non-functioning state.
> 
> By writing directly to register it will always perform the reset, and it will always enable SDO regardless of the invalid values read back during initialization.
Ah ok.  So it's a bug with or without appropriate pull up.
Just happens to be worse if that is missing.
> 
> > >
> > > Since the soft reset disables the SDO line, performing a 
> > > read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line 
> > > doesn't make sense. This change directly writes to the register 
> > > instead of using regmap_update_bits.
> > >
> > > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> > >  
> > 
> > No blank line here.  Fixes is part of the tags block that various scripts scan.  
> 
> Is this the blank line after the fixes? I need to do some research to understand the tag block.
Yes - The block of all tags needs to be contiguous. No blank lines.

Greg has a script that moans about this, not sure if it also runs on linux-next

Jonathan
> 
> >   
> > > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > > ---
> > >  drivers/iio/filter/admv8818.c | 14 ++++----------
> > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/iio/filter/admv8818.c 
> > > b/drivers/iio/filter/admv8818.c index 195e58bc4..9cd1eee84 100644
> > > --- a/drivers/iio/filter/admv8818.c
> > > +++ b/drivers/iio/filter/admv8818.c
> > > @@ -577,21 +577,15 @@ static int admv8818_init(struct admv8818_state *st)
> > >       struct spi_device *spi = st->spi;
> > >       unsigned int chip_id;
> > >
> > > -     ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > > -                              ADMV8818_SOFTRESET_N_MSK |
> > > -                              ADMV8818_SOFTRESET_MSK,
> > > -                              FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
> > > -                              FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
> > > +     ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > > +                        ADMV8818_SOFTRESET_N_MSK | 
> > > + ADMV8818_SOFTRESET_MSK);
> > >       if (ret) {
> > >               dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
> > >               return ret;
> > >       }
> > >
> > > -     ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > > -                              ADMV8818_SDOACTIVE_N_MSK |
> > > -                              ADMV8818_SDOACTIVE_MSK,
> > > -                              FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
> > > -                              FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
> > > +     ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > > +                        ADMV8818_SDOACTIVE_N_MSK | 
> > > + ADMV8818_SDOACTIVE_MSK);
> > >       if (ret) {
> > >               dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
> > >               return ret;  


