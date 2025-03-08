Return-Path: <linux-iio+bounces-16542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D8EA57A61
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0773B289F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119BD1C3C04;
	Sat,  8 Mar 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwYWr4sN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1B137E;
	Sat,  8 Mar 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741439713; cv=none; b=jmD96pIPjI750W8Qsy0kgSTEXQKK1RwTDehHdfeBBXG/DqqUuWik9kInKBywM0BVxi64/GX3T8bna2KMaaLMwFP08jaUmecAibVhrsIPrahWg4z1VgG46TrJpaPj7BnMQvKwl8GxpzVFNbc7A+abuPjV1U0/fnEUQZBrSDl3UaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741439713; c=relaxed/simple;
	bh=s8BILcS17WPtk+s6E1t2xrjrEw6KDOLQSM2Go7SuGvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBHGxTTaVcQsn4C1lp/rNQ8pgbRGZj1ShR2JvC8G4W5/8bD+BaQjm5Eb8NCuCpx2dXeJ6AfOKiS/06d+PxX3DkXE3X6BQrmxqOK/fY9SKjT2PoYd1jgn39IPX7feweWCFgXDQsqH2AzvEicGSNavxwrmOgtfClePcDzaj/xsqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwYWr4sN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B426C4CEE0;
	Sat,  8 Mar 2025 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741439713;
	bh=s8BILcS17WPtk+s6E1t2xrjrEw6KDOLQSM2Go7SuGvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwYWr4sNoILgvgR8ICvxZMvIUNvYFH/MQpcUO39iexrx6R8v1CTaXD4wPAWF6HJzN
	 G81XzByT4Ef+R8itR1p++YfO2azd+LZPLp5UXKDxd/e3P/ISuFbPkdXGaX2ES5vJrP
	 YyuQxVoh6DzvfSv5AIH5H7enlUgKOSgshWg7bITHvH42tS1gEsXnrWrtqMBITKqYdO
	 IXUtO3CjmNhIEam1MxZE0H31gqGDITXU5P3IMEtOUUG0nECL9GXKDzn2LantlnAV//
	 FdV+eRLk3WSSR2aARwROlsikdPVzRCjlMXo6UOpiLLzbMkkPP9qeBoT5bsh1Dvug8U
	 MaP1IiFwlvbww==
Date: Sat, 8 Mar 2025 13:15:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
 jonath4nns@gmail.com
Subject: Re: [PATCH v4 02/17] iio: adc: ad7768-1: set MOSI idle state to
 prevent accidental reset
Message-ID: <20250308131502.69af9479@jic23-huawei>
In-Reply-To: <Z8rhWLz32fdySDyN@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<c2a2b0f3d54829079763a5511359a1fa80516cfb.1741268122.git.Jonathan.Santos@analog.com>
	<Z8rhWLz32fdySDyN@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 09:06:48 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 03/06, Jonathan Santos wrote:
> > Datasheet recommends Setting the MOSI idle state to high in order to
> > prevent accidental reset of the device when SCLK is free running.
> > This happens when the controller clocks out a 1 followed by 63 zeros
> > while the CS is held low.
> > 
> > Check if SPI controller supports SPI_MOSI_IDLE_HIGH flag and set it.
> > 
> > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---  
> 
> LGTM
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Applied on assumption the answer to Marcelo's question doesn't
result in changes.

> 
> > v4 Changes:
> > * None.
> > 
> > v3 Changes:
> > * Patch moved closer to the start of the patch set.
> > 
> > v2 Changes:
> > * Only setup SPI_MOSI_IDLE_HIGH flag if the controller supports it, otherwise the driver
> >   continues the same. I realized that using bits_per_word does not avoid the problem that
> >   MOSI idle state is trying to solve. If the controller drives the MOSI low between bytes
> >   during a transfer, nothing happens.  
> 
> When you say nothing happens if the controller drives MOSI low between data
> bytes you mean the data is still good in that case? Just trying to understand
> the device behavior.
> 
> Thanks,
> Marcelo
> 
> > ---
> >  drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index c3cf04311c40..2e2d50ccb744 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -574,6 +574,21 @@ static int ad7768_probe(struct spi_device *spi)
> >  		return -ENOMEM;
> >  
> >  	st = iio_priv(indio_dev);
> > +	/*
> > +	 * Datasheet recommends SDI line to be kept high when data is not being
> > +	 * clocked out of the controller and the spi clock is free running,
> > +	 * to prevent accidental reset.
> > +	 * Since many controllers do not support the SPI_MOSI_IDLE_HIGH flag
> > +	 * yet, only request the MOSI idle state to enable if the controller
> > +	 * supports it.
> > +	 */
> > +	if (spi->controller->mode_bits & SPI_MOSI_IDLE_HIGH) {
> > +		spi->mode |= SPI_MOSI_IDLE_HIGH;
> > +		ret = spi_setup(spi);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> >  	st->spi = spi;
> >  
> >  	st->vref = devm_regulator_get(&spi->dev, "vref");
> > -- 
> > 2.34.1
> >   


