Return-Path: <linux-iio+bounces-20975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B642AEA561
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318A85644FA
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808C2EE5FE;
	Thu, 26 Jun 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn+X2vUp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA1267F53;
	Thu, 26 Jun 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962491; cv=none; b=Y3rAWjHRJSOPCyohbU1+WRaRgURTIYlca6fUx5/IdpEAZzkl6fv4QIWeiYDGM7NFKutF5m0gTTZv2SGJ3DAUJ2Us4NAC9OKQanyBhHoD+4yaWT0GT2ufpGDYNRmRV5GtSxI3vaOX0ENIfH5S+ANrhXXnRQ+z+NFJGVZ2kI8AYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962491; c=relaxed/simple;
	bh=C67qEJM9v5AY+XsQ4MwWqlTDL/IrPPvkZHheDP+YMRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1PVZBUdSa2Bup0UvK/+V3zf0o0V0dMyfLYhUZaLikw2r4t5k+VuxVzmC5MbHtIEwcjzU7YuDsmhSG9+1t6kxbQkSL65fqtMddzgplO7eFR8QrIDAWe68raFpMi1obhYd6aMJX4D3aHW1WitYGojpZ9TGUEO7a3DJ41V3c03ZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn+X2vUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6298AC4CEEB;
	Thu, 26 Jun 2025 18:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962490;
	bh=C67qEJM9v5AY+XsQ4MwWqlTDL/IrPPvkZHheDP+YMRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mn+X2vUpAmQrkjPBZ97SVG3D4RtZwtrrXGLvyVCUrgNjzsssBp7u9p1MgoapJToWB
	 5byiyz8JJwtqBdlgnMkA/9f/5z7T3JuO8LKTwkapqZescaLi4iyQ2h0hxvN9GQSol1
	 H1T1eMgt62KyUNm4qr64EBcde8CG935CouU5++/0idIeo9G0/W12NEvnfCXbxkMvkJ
	 rDXHH4W0/s75b7FIW/BzNZzXD+Zov6kpNcK96QTLzqVmvO9k/J1d6ECdIkBBuAKmf9
	 md7GE6Z5X+1LnupsZTKCeNj6f9/QLQswmDk72gbSAYEn3wXQomr63C448mbnnPJmmA
	 X/WIpD+rAVAJA==
Date: Thu, 26 Jun 2025 19:28:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for
 adc121s021
Message-ID: <20250626192802.0079d579@jic23-huawei>
In-Reply-To: <8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
	<20250625170218.545654-2-l.rubusch@gmail.com>
	<8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 08:24:41 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Lothar,
> 
> On 25/06/2025 20:02, Lothar Rubusch wrote:
> > Add support for the single channel variant(s) of this ADC.
> > 
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>  
> 
> Thanks for this addition. In principle, this looks good to me but I am 
> afraid there is another colliding series being worked on:
> 
> https://lore.kernel.org/all/20250614091504.575685-3-sbellary@baylibre.com/
> 
> Maybe you can align the effort with Sukrut?
+CC Sukrut.

> 
> What I specifically like (and think is the right thing to do) in 
> Sukrut's series is replacing the 'adc122s021_channels' -array with 
> individual structures. In my opinion the array is just unnecessary 
> complexity and individual structures are simpler.
> 
> Other than that, this looks good to me.


Sukrut, perhaps you could add this to the end of your series, rebased
to those changes?  Would save a synchronization step for your v5 (and
later if needed)

No problem if not, but I agree with Matti that we should take your
series first.

Jonathan


> 
> Yours,
> 	-- Matti
> 
> 
> > ---
> >   drivers/iio/adc/ti-adc128s052.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index 1b46a8155803..cf271c39e663 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -7,6 +7,7 @@
> >    * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
> >    * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
> >    * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> > + * https://www.ti.com/lit/ds/symlink/adc121s021.pdf
> >    */
> >   
> >   #include <linux/cleanup.h>
> > @@ -110,6 +111,10 @@ static const struct iio_chan_spec adc128s052_channels[] = {
> >   	ADC128_VOLTAGE_CHANNEL(7),
> >   };
> >   
> > +static const struct iio_chan_spec adc121s021_channels[] = {
> > +	ADC128_VOLTAGE_CHANNEL(0),
> > +};
> > +
> >   static const struct iio_chan_spec adc122s021_channels[] = {
> >   	ADC128_VOLTAGE_CHANNEL(0),
> >   	ADC128_VOLTAGE_CHANNEL(1),
> > @@ -143,6 +148,10 @@ static const struct adc128_configuration adc128_config[] = {
> >   		.refname = "vdd",
> >   		.other_regulators = &bd79104_regulators,
> >   		.num_other_regulators = 1,
> > +	}, {
> > +		.channels = adc121s021_channels,
> > +		.num_channels = ARRAY_SIZE(adc121s021_channels),
> > +		.refname = "vref",
> >   	},
> >   };  
> 
> I'd love seeing this array split to individual structs.
> 
> >   
> > @@ -207,7 +216,10 @@ static const struct of_device_id adc128_of_match[] = {
> >   	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
> >   	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
> >   	{ .compatible = "rohm,bd79104", .data = &adc128_config[3] },
> > -	{ }
> > +	{ .compatible = "ti,adc121s021", .data = &adc128_config[4] },
> > +	{ .compatible = "ti,adc121s051", .data = &adc128_config[4] },
> > +	{ .compatible = "ti,adc121s101", .data = &adc128_config[4] },
> > +	{ },
> >   };
> >   MODULE_DEVICE_TABLE(of, adc128_of_match);
> >   
> > @@ -220,6 +232,9 @@ static const struct spi_device_id adc128_id[] = {
> >   	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
> >   	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
> >   	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
> > +	{ "adc121s021", (kernel_ulong_t)&adc128_config[4] },
> > +	{ "adc121s051", (kernel_ulong_t)&adc128_config[4] },
> > +	{ "adc121s101", (kernel_ulong_t)&adc128_config[4] },
> >   	{ }
> >   };
> >   MODULE_DEVICE_TABLE(spi, adc128_id);  
> 


