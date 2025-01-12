Return-Path: <linux-iio+bounces-14195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB73CA0A92B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65913A6BB1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC62C1B2192;
	Sun, 12 Jan 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTrxsHUw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEF198A25;
	Sun, 12 Jan 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685347; cv=none; b=WrI3fePXFnt/f/MVTtl/ZxgZYVmyp+o9h4tJD6nPG1XLdkbdwPmPIxXFaqvG9SgT0QJt0Z83fI3o0y6OU/FB3Rn00RcJttxT8oLwVVgQZmceZvD+zTuzesyNa96LYQ7kxi50vCZbISBSPHPxLGEZxcE8L70Hjrg7g/r7CG/TXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685347; c=relaxed/simple;
	bh=WJi9MC9r4CpsrKzQK6s43VJJ4YUkedN/cAarNJtig4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOKGdriyPB/yBEp/lyF7AAZYoSdQe+H1r8a5Yp4oTIA4GOa+L7tqJNbPApotPhe00QewHrbllJmitXygP5Mlo/JlW3CvgNl9xbx31DAMKhLMVJwYPrmZnuAzCJCLNLcgsekHTtxr8Qq5gD0J4eYvGQNi5KtMcn+J20d22tMpRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTrxsHUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE5C4CEDF;
	Sun, 12 Jan 2025 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736685347;
	bh=WJi9MC9r4CpsrKzQK6s43VJJ4YUkedN/cAarNJtig4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTrxsHUw/pQJ2ww6VH+vk56zqWfEGhFWt8GpZvZG2Me+dmCHC6wSDZDi5C9KT7x0j
	 zLD2dGenNLG2S3YAPmmEISTtAvkdmaBWsgVv6S0a21ZCGjWamlgyzqM/xUFNIVkrSl
	 r6jBDOyy4fyeF7ZWn0b1MgM1DtkTHNdZTEzShyv/pe7vDb2QU6/Jq66JuCyKp64/EU
	 tOrIkoLveKYGw59CiMMMsOq4yk11iyvxOyv1wEvjzor5gVo8n+ktqt0xw7A8B6D8S/
	 RrLfKWnd2fxI1EMe1XvDW1JTlJlPjhIyi9Rg7wyhn466XYduPDX2sjzeZVSiwVLb3X
	 5vFo334G0ry/Q==
Date: Sun, 12 Jan 2025 12:35:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 07/15] iio: adc: ad7768-1: Add reset gpio
Message-ID: <20250112123537.214d0ba6@jic23-huawei>
In-Reply-To: <6b60de31-4bbb-4a94-a62b-63ccbacdf1b4@baylibre.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<45cfd15501384a183a97d871b6848fb79fdb7b39.1736201898.git.Jonathan.Santos@analog.com>
	<6b60de31-4bbb-4a94-a62b-63ccbacdf1b4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 17:40:53 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/7/25 9:25 AM, Jonathan Santos wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > Depending on the controller, the default state of a gpio can vary. This
> > change excludes the probability that the dafult state of the ADC reset
> > gpio will be HIGH if it will be passed as reference in the deivcetree.

devicetree

> > 
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > ---
> >  drivers/iio/adc/ad7768-1.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 881446462ff5..f73b9aec8b0f 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -161,6 +161,7 @@ struct ad7768_state {
> >  	struct completion completion;
> >  	struct iio_trigger *trig;
> >  	struct gpio_desc *gpio_sync_in;
> > +	struct gpio_desc *gpio_reset;
> >  	const char *labels[ARRAY_SIZE(ad7768_channels)];
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> > @@ -441,6 +442,18 @@ static int ad7768_setup(struct ad7768_state *st)
> >  {
> >  	int ret;
> >  
> > +	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> > +						 GPIOD_OUT_LOW);  
> 
> Could be simplified by setting this to GPIOD_OUT_HIGH and drop
> 
> 	gpiod_direction_output(st->gpio_reset, 1);
> 
> > +	if (IS_ERR(st->gpio_reset))
> > +		return PTR_ERR(st->gpio_reset);
> > +
> > +	if (st->gpio_reset) {
> > +		gpiod_direction_output(st->gpio_reset, 1);

It's an output already, gpiod_set_value() should work I think?
Possibly even then sleep allowing variants


> > +		usleep_range(10, 15);
> > +		gpiod_direction_output(st->gpio_reset, 0);
> > +		usleep_range(10, 15);  
> 
> prefer fsleep()
> 
> > +	}
> > +  
> 
> We can move the code below in an else since we don't need to do 2 resets.
> 
> >  	/*
> >  	 * Two writes to the SPI_RESET[1:0] bits are required to initiate
> >  	 * a software reset. The bits must first be set to 11, and then  
> 


