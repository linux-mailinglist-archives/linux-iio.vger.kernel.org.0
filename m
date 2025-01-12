Return-Path: <linux-iio+bounces-14154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241CA0A711
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 04:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6CD1888CC1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2D81401B;
	Sun, 12 Jan 2025 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsYrqoQh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D216D528;
	Sun, 12 Jan 2025 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736652105; cv=none; b=HKoidO0ZXF0zVQsWPodIrJ9wj+UXQIZtL/K/RZYUtiLAWahpVP72Sv83vhIUFXlGmHShS8P2wUSLvd8Mof2W+AAwx0B4N8KjLyQbrceSJzM/0DDzF+mgt5pB4E3F8K44J9jVktUTACCHxU6egsHV4lmiNQ4zs+ai8+8t9y4OQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736652105; c=relaxed/simple;
	bh=GWIElKws9ISxS8FncPnbPpol9Wt8INg5R1YmsVUYME4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmINQtNYcECfe5I2Lh8gWaLhZeo9a34v7dfNl9ddJv1n4zo1aIGebPMKBJ1eexGdUXY+rwJzr7JXS9viCFkyTmRb9D9Xg+rz4HYlk1t2aFW2KIJUMCf7PCzzmeia7N+UMaBd09SYgY/QrJAwFhKrymMIRCwnhUO1zmijkQQPj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsYrqoQh; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ebba66c539so41954b6e.0;
        Sat, 11 Jan 2025 19:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736652102; x=1737256902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45DbvFMJDI5Q0Scw6jJ3gkVoTHPqyuQH0zuucpZd5t4=;
        b=LsYrqoQhg82dmVhSdtsssRXrEk9yeUUHaUnACFbEyiwz5AbNxlmMo8SHZsndR9kcz8
         LibfUy2tCo5z9JHENSRFHmBz9/6xUqvY36t+pthvcCaMYzmgQff1+r65PuMRr/ft4m5L
         8g//5s21Ugey3lYru8yUdWldUQ3yK2CHXlJ5d+a21VCgTbx3M1jn7I7SCcZyM0+s01c6
         K8nAHn4HnSiHD87fOAX74Kxuv+yf4vUSIEouwdAv9HOotFbGtsnPuWWdo8neEn4HUGN7
         cuC6h2FYBrt/2CBdElc+50wWobtPeKn4/ZFFMQ8oxu9V001XzcXRD3f2nPSJ9Lo0R+g0
         7Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736652102; x=1737256902;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45DbvFMJDI5Q0Scw6jJ3gkVoTHPqyuQH0zuucpZd5t4=;
        b=RKbWXCUsqzQ0LYdnl96K3F9Du5KOcoi3PU1hcIhHGWnVlqWMqCJiLZwHuhYbM7h3ih
         ZfvsXqeUO33OcP089Rte0zyPsZLe2vyRejypG1EXYDJ3MUXocId2ZpboT6Go+LLJtaDp
         mpLmEiZG0y9QZBHPAmncDS+bqpRhINJjsTjvCj7vA0Tu4lB8qS8aLvcYdsICjR9hYV/1
         uv4PX0d+LJbcK1x+DVDxytK0y/EDo7/m64twYEkxsKGsRtJ7bLlWJKxyM1bBx0yfP2U1
         vhOPTovt7Jnog740px9XslVr0NFlzL/8gGJ2RgyHVTt30i0ryR1dYK26YzfeAbtfyXVS
         +fOA==
X-Forwarded-Encrypted: i=1; AJvYcCUa81AkDKNwel26EpvqjtyDIspNDQfRSbPOGzAqN3xKypyZmVE/jHj6n2iihch5mtYqAnl894QfZl4LKnzc@vger.kernel.org, AJvYcCXKPNT74twZ9wGS0IfOa3LP53U1Mf/zmtFM7Bahdtlm7M9cbLY15lMkiqYf0nVAgIWPABq1gLQAxptu@vger.kernel.org, AJvYcCXKqMnMeMseTkr3S9EymIwoVcejY6FWtFgYfcgqr3XuFlYV+EW8kF8Gvl0UAa0a2xtdotUmPcTsMw8v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5H0gdAr+me4C3UW2oOn/QtWrcuN4G8+obwOYuT0pdV9m+dIdC
	bRH4puCG5V8FxjiWU/QzBMUNu+0hgkSfQ8DzmFi4x6NtUIPLYRJi
X-Gm-Gg: ASbGncvEE+Lcko46CxxYqEFADuEf+T+TCJj/A0enZznbhxEdKo0KKqxu0kdAexSmV00
	45cpGhFR+NxkdlLq/SL1kgFbUs288iz3BMnN1RjF3iOgEh4RA3hVrCYOieQFPOLu1NuWab6NPYl
	kEEqo98C43RY3vxLF8Z9AGMLgvy79ntI0IoeD9KB+aKkoe2RiOPGxY2JFXfBs0VFlYlR7bbdsKc
	hUZAvk1PcnikZw90KjO7epTEwr4EuFOPwe0keZB4jWhzV+qiMoOQhLU6bpKzBDy1iXIrJ7UXJsC
	RA==
X-Google-Smtp-Source: AGHT+IEgmLTBu75RMvDm2xylyNdf3+gSk40WaYagr6QENLIKJixgC9BDGY6zXEAkRItTWbtFBAF7SA==
X-Received: by 2002:a05:6871:53cb:b0:29e:38e8:1621 with SMTP id 586e51a60fabf-2aa06647973mr3239923fac.3.1736652102143;
        Sat, 11 Jan 2025 19:21:42 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad80a527fdsm2549471fac.50.2025.01.11.19.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 19:21:41 -0800 (PST)
Date: Sun, 12 Jan 2025 00:21:37 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 13/15] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
Message-ID: <Z4M1QU8XQjAKqI4W@JSANTO12-L01.ad.analog.com>
Reply-To: 111f571d-1d88-42f7-b9a5-4b1cb328e26b@baylibre.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <170c5ca1b6c45b2114f248d9085588572d6269b4.1736201898.git.Jonathan.Santos@analog.com>
 <111f571d-1d88-42f7-b9a5-4b1cb328e26b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111f571d-1d88-42f7-b9a5-4b1cb328e26b@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:26 AM, Jonathan Santos wrote:
> > When the device is configured to Sinc5 filter and decimation x8,
> > output data is reduced to 16-bits in order to support 1 MHz of
> > sampling frequency due to clock limitation.
> 
> We aren't going to get a 1 MHz sample rate without SPI offload support so maybe
> we should save this patch until then?
> 
> In this patch, we are still reading 24-bits per sample, so we aren't really
> getting any benefit. It is probably fine for now to leave it as 24-bit even if
> the last 8 bits are all 0 or just noise.

Indeed we cannot achieve 1 MHz yet, but I believe it is good have this
now so it is more mature for the time SPI offload is supported. Also, will
allow us to backport this patch to other repos.

> 
> Also, the datasheet says:
> 
> 	this path allows viewing of wider bandwidth; however, it is quantization
> 	noise limited so that output data is reduced to 16 bits
> 
> So this doesn't actually seem related to higher sample rates. There is a CONVLEN
> bit in the INTERFACE_FORMAT register that globally reduces the output size to
> 16-bit, which I suspect would be what we will need for achieving the highest
> sample rate when we add SPI offload support.
> 

Right, that is true, but the reason we did this patch was to fix the
output size when we configure the filter to sinc5 decx8. The datasheet
says:

	To configure the sinc5 filter for 1.024 MSPS output data rate,
	write 001 to the FILTER bits [6:4] of the DIGITAL_FILTER register
	(Register 0x19). The ADAQ7768-1 automatically changes the decimation
	rate to 8 and output data length is reduced to 16 bits from 24 bits 
	due to the maximum speed limitation of the digital serial interface.

In this case we don't even need to change the value of CONVLEN

> > 
> > Use multiple scan types feature to enable the driver to switch
> > scan type in runtime, making possible to support both 24-bit and
> > 16-bit resolution.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  drivers/iio/adc/ad7768-1.c | 65 ++++++++++++++++++++++++++++++++------
> >  1 file changed, 56 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 9741a6d47942..5e4e7d387f9a 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -134,6 +134,11 @@ struct ad7768_clk_configuration {
> >  	enum ad7768_pwrmode pwrmode;
> >  };
> >  
> > +enum ad7768_scan_type {
> > +	AD7768_SCAN_TYPE_NORMAL,
> > +	AD7768_SCAN_TYPE_HIGH_SPEED,
> > +};
> > +
> >  static const char * const ad7768_vcm_modes[] = {
> >  	"(AVDD1-AVSS)/2",
> >  	"2V5",
> > @@ -145,6 +150,10 @@ static const char * const ad7768_vcm_modes[] = {
> >  	"OFF",
> >  };
> >  
> > +static const int ad7768_mclk_div_rates[4] = {
> > +	16, 8, 4, 2,
> > +};
> > +
> >  static const struct ad7768_clk_configuration ad7768_clk_config[] = {
> >  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
> >  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
> > @@ -159,6 +168,21 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
> >  	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
> >  };
> >  
> > +static const struct iio_scan_type ad7768_scan_type[] = {
> > +	[AD7768_SCAN_TYPE_NORMAL] = {
> > +		.sign = 's',
> > +		.realbits = 24,
> > +		.storagebits = 32,
> 
> What happened to .shift = 8, ? If there is a reason for removing it, please add
> that to the commit description.
> 

Sorry, will fix this

> > +		.endianness = IIO_BE,
> > +	},
> > +	[AD7768_SCAN_TYPE_HIGH_SPEED] = {
> > +		.sign = 's',
> > +		.realbits = 16,
> > +		.storagebits = 32,
> 
> I guess it doesn't matter much since we are reading one sample at a time, but
> I would expect storagebits to be 16 instead of 32. Or if it really needs to be
> 32, does it need shift = 16?
> 

This is because the hw is configured to return the samples in a 32 bits
format, so if storage is 16 we will get wrong data.

> > +		.endianness = IIO_BE,
> > +	},
> > +};
> > +
> >  static int ad7768_get_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan);
> >  static int ad7768_set_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan,
> >  			  unsigned int mode);
> 
> ...
> 
> > @@ -308,6 +329,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
> >  	ret = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, &readval, 3);
> >  	if (ret < 0)
> >  		return ret;
> > +
> > +	/*
> > +	 * When the decimation rate is set to x8, the ADC data precision is reduced
> > +	 * from 24 bits to 16 bits. Since the AD7768_REG_ADC_DATA register provides
> > +	 * 24-bit data, the precision is reduced by right-shifting the read value
> > +	 * by 8 bits.
> > +	 */
> > +	if (st->dec_rate == 8)
> > +		readval = readval >> 8;
> 
> Why not change size of ad7768_spi_reg_read() instead of reading 3 bytes and
> throwing one away?
> 

Right, i will check this and fix in the next version

> >  	/*
> >  	 * Any SPI configuration of the AD7768-1 can only be
> >  	 * performed in continuous conversion mode.

