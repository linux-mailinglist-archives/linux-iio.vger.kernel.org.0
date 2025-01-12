Return-Path: <linux-iio+bounces-14201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2FA0A959
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257591887EFC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706C71B4128;
	Sun, 12 Jan 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou2Xbpu9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F893C1F;
	Sun, 12 Jan 2025 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736686248; cv=none; b=ud4Np/Aw4oD6wlKgJNhFDwjwoGH/BDvSqDgpeKUmr2PSriJnUKM09ntm+Ms7ddxOd/qlqVdB0ABZdN4Em77paZVEjGiTyuquv06o/lJeKFQbOSVUmtSKDXbqWfB27EjznwyO4csWq3K4inLWxQ1pl5X3QHntnl1XPfqsdkuEVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736686248; c=relaxed/simple;
	bh=LQ3cm2feH8xlTKxiZiFpWAw1NsRXGqSPRRzYAd5h0ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2JSv5W2vdEQa2cGJiyQ4EUdfL2MkzklbNJi/jySE4EyM5An+yckC6kLF+HqyPO7TOxzUChJLKZF+ST8M0p8KuD1H3bevLIRkg/sprH5H5jr741Zx8XYaWSrFdY2/mqwWsdp9O+ODH8aqldhDdGAjE3+dAaAyQgymkfKBmXa+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou2Xbpu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7CFC4CEE2;
	Sun, 12 Jan 2025 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736686247;
	bh=LQ3cm2feH8xlTKxiZiFpWAw1NsRXGqSPRRzYAd5h0ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ou2Xbpu9Pw8wTNPOmoeIPZhWpUaedqPB99AKs8Ot36HJmnUYzn/rtit0bX3rtQgwE
	 oqvZBTFYS9gA9FihEeIwlfKfm6Qcw8bBupLlGAEeqay1FPhpWgL8oavgVAFpIEW3Rx
	 r6RMLHuMa1zJ2B68R13jQ0CfK8+xdrcwiewOzbkmku8XJ6k8/yRmk3ptCxUu95O9RK
	 WTnuDlVUIw/ORxzLyV8ByeeknNbPPBfrzDoTyONb84VMehbJ0rsAxTuZ979H1ClvqN
	 6mCrpTMF4zcLWSc42wF8WYnPAYORqBnETWAchKsUyqLZNdOqmnQ1ouIUqJKlNw6Ng6
	 Lo3K0LUp1dCpw==
Date: Sun, 12 Jan 2025 12:50:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 111f571d-1d88-42f7-b9a5-4b1cb328e26b@baylibre.com, David Lechner
 <dlechner@baylibre.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 13/15] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
Message-ID: <20250112125037.442c56c9@jic23-huawei>
In-Reply-To: <Z4M1QU8XQjAKqI4W@JSANTO12-L01.ad.analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<170c5ca1b6c45b2114f248d9085588572d6269b4.1736201898.git.Jonathan.Santos@analog.com>
	<111f571d-1d88-42f7-b9a5-4b1cb328e26b@baylibre.com>
	<Z4M1QU8XQjAKqI4W@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 00:21:37 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 01/07, David Lechner wrote:
> > On 1/7/25 9:26 AM, Jonathan Santos wrote:  
> > > When the device is configured to Sinc5 filter and decimation x8,
> > > output data is reduced to 16-bits in order to support 1 MHz of
> > > sampling frequency due to clock limitation.  
> > 
> > We aren't going to get a 1 MHz sample rate without SPI offload support so maybe
> > we should save this patch until then?
> > 
> > In this patch, we are still reading 24-bits per sample, so we aren't really
> > getting any benefit. It is probably fine for now to leave it as 24-bit even if
> > the last 8 bits are all 0 or just noise.  
> 
> Indeed we cannot achieve 1 MHz yet, but I believe it is good have this
> now so it is more mature for the time SPI offload is supported. Also, will
> allow us to backport this patch to other repos.
> 
> > 
> > Also, the datasheet says:
> > 
> > 	this path allows viewing of wider bandwidth; however, it is quantization
> > 	noise limited so that output data is reduced to 16 bits
> > 
> > So this doesn't actually seem related to higher sample rates. There is a CONVLEN
> > bit in the INTERFACE_FORMAT register that globally reduces the output size to
> > 16-bit, which I suspect would be what we will need for achieving the highest
> > sample rate when we add SPI offload support.
> >   
> 
> Right, that is true, but the reason we did this patch was to fix the
> output size when we configure the filter to sinc5 decx8. The datasheet
> says:
> 
> 	To configure the sinc5 filter for 1.024 MSPS output data rate,
> 	write 001 to the FILTER bits [6:4] of the DIGITAL_FILTER register
> 	(Register 0x19). The ADAQ7768-1 automatically changes the decimation
> 	rate to 8 and output data length is reduced to 16 bits from 24 bits 
> 	due to the maximum speed limitation of the digital serial interface.
> 
> In this case we don't even need to change the value of CONVLEN
> 
> > > 
> > > Use multiple scan types feature to enable the driver to switch
> > > scan type in runtime, making possible to support both 24-bit and
> > > 16-bit resolution.
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > >  drivers/iio/adc/ad7768-1.c | 65 ++++++++++++++++++++++++++++++++------
> > >  1 file changed, 56 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > > index 9741a6d47942..5e4e7d387f9a 100644
> > > --- a/drivers/iio/adc/ad7768-1.c
> > > +++ b/drivers/iio/adc/ad7768-1.c
> > > @@ -134,6 +134,11 @@ struct ad7768_clk_configuration {
> > >  	enum ad7768_pwrmode pwrmode;
> > >  };
> > >  
> > > +enum ad7768_scan_type {
> > > +	AD7768_SCAN_TYPE_NORMAL,
> > > +	AD7768_SCAN_TYPE_HIGH_SPEED,
> > > +};
> > > +
> > >  static const char * const ad7768_vcm_modes[] = {
> > >  	"(AVDD1-AVSS)/2",
> > >  	"2V5",
> > > @@ -145,6 +150,10 @@ static const char * const ad7768_vcm_modes[] = {
> > >  	"OFF",
> > >  };
> > >  
> > > +static const int ad7768_mclk_div_rates[4] = {
> > > +	16, 8, 4, 2,
> > > +};
> > > +
> > >  static const struct ad7768_clk_configuration ad7768_clk_config[] = {
> > >  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
> > >  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
> > > @@ -159,6 +168,21 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
> > >  	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
> > >  };
> > >  
> > > +static const struct iio_scan_type ad7768_scan_type[] = {
> > > +	[AD7768_SCAN_TYPE_NORMAL] = {
> > > +		.sign = 's',
> > > +		.realbits = 24,
> > > +		.storagebits = 32,  
> > 
> > What happened to .shift = 8, ? If there is a reason for removing it, please add
> > that to the commit description.
> >   
> 
> Sorry, will fix this
> 
> > > +		.endianness = IIO_BE,
> > > +	},
> > > +	[AD7768_SCAN_TYPE_HIGH_SPEED] = {
> > > +		.sign = 's',
> > > +		.realbits = 16,
> > > +		.storagebits = 32,  
> > 
> > I guess it doesn't matter much since we are reading one sample at a time, but
> > I would expect storagebits to be 16 instead of 32. Or if it really needs to be
> > 32, does it need shift = 16?
> >   
> 
> This is because the hw is configured to return the samples in a 32 bits
> format, so if storage is 16 we will get wrong data.

Currently we only support one channel (daisy chain mode support might change
that). Not particularly painful to repack and it doubles the data we can fit
in a fifo of a given size.

If this is tricky because of later patches, throw in a common on why.


> 
> > > +		.endianness = IIO_BE,
> > > +	},
> > > +};
> > > +
> > >  static int ad7768_get_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan);
> > >  static int ad7768_set_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan,
> > >  			  unsigned int mode);  
> > 
> > ...
> >   
> > > @@ -308,6 +329,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
> > >  	ret = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, &readval, 3);
> > >  	if (ret < 0)
> > >  		return ret;
> > > +
> > > +	/*
> > > +	 * When the decimation rate is set to x8, the ADC data precision is reduced
> > > +	 * from 24 bits to 16 bits. Since the AD7768_REG_ADC_DATA register provides
> > > +	 * 24-bit data, the precision is reduced by right-shifting the read value
> > > +	 * by 8 bits.
> > > +	 */
> > > +	if (st->dec_rate == 8)
> > > +		readval = readval >> 8;  
> > 
> > Why not change size of ad7768_spi_reg_read() instead of reading 3 bytes and
> > throwing one away?
> >   
> 
> Right, i will check this and fix in the next version
> 
> > >  	/*
> > >  	 * Any SPI configuration of the AD7768-1 can only be
> > >  	 * performed in continuous conversion mode.  


