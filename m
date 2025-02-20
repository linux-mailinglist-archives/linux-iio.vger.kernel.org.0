Return-Path: <linux-iio+bounces-15853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5985A3DB49
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A30D17A56A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F21F8BBC;
	Thu, 20 Feb 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbYrHYae"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE9433BE;
	Thu, 20 Feb 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058141; cv=none; b=Xs0re0OdTSSrSh/BKW8ckXltobxHz6/YuelfWRRDIpkyCXCXZS9FmqiSOR+9/gphUzDYMxnEonor3TaRIeqH5+awVwYvp1qk7P3ufmZ+p18RhDeIeOT4rqc455tqwA0bWcu8aSIXyxG5n4oKYFl9cmptd1W/RpOdv4r8n34CKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058141; c=relaxed/simple;
	bh=aW7P36P7qMNdnr9pUg4pgp/inqglHOgptn1s3sqjY7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPUIjZsl5tzKtVNBilT4osZ7o91y9FRfiBJ3GhnAIkB68I90Pxq3ULcgK3BZNcBh0NLh7dqsqRiXeFnloqQkF4EkgA8Gh/d/sQkFdj1+AWJWM+DPPSBSgJSyFMBcAMoGW+KR4I2Ly6AOKv/BuO+7I3bf2JJX8e8HuddQ0Z7AO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbYrHYae; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471feaace60so541291cf.3;
        Thu, 20 Feb 2025 05:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740058138; x=1740662938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds16pcii8hIi7NE0pveG5m9mk6T8UXD/GemUMCtoarQ=;
        b=JbYrHYaeNCIvDlBr2wDIR4m8HnQoRMJZ2iDOZCPozrTUV07euAS6eB8efQoPzBeGqE
         GuKKDIuS8Vh0Dggap9CYEB5AsOCsgKhrOfy3WzE9l+62leojro6BcZmXAxnywyhqlCSZ
         NrmnOJJNoMwYAv90HMGv8ngGnYRLmwwCNbZrmBRISq14sstMvgAElIr5oO+77a5POMis
         C0HsihebvzsdfujIaKSPDYRNllL/4nHEzF8DC9l94AMOqQAP5vNR0owGDF6D0IFSGDgG
         +XEMsXmG8vCCFBcweRK9vjEcXMf8AUKPrVcYqf03iJjmeFUTlSIBhLtZviNvucyEjIVg
         81Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058138; x=1740662938;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds16pcii8hIi7NE0pveG5m9mk6T8UXD/GemUMCtoarQ=;
        b=WBrc3kjz4CZ8HfOM6VhO4jBiU6Okis7d4J4nAdJKli4ecsu2H86oW6VSb5tcoV5ajQ
         VdDig8eGJ0vtfxD+rjJlA6noAciBRlnTLaJmjhRpJEdJ4mfJBzluHyYiFLNqU9W2MHZO
         3o42KdoMujk7c+UzgTVtl9Pp6O4wTrA7FioOgmle0TbVlv9vkVFxRdZUSUYsKbbuu+Pb
         n0wEzPoAnsY4au5XHEomz9xOcHuoAMdJn/5+glbT7slOJFJcoA6t2eqtmr6NQuH6aygK
         cPypQt1gh2YaupuHTqh/EW2izoKnAY4HqrqzcS7osNTbDGgcQ2HmcTcF/pm75LAkDcD4
         F/4g==
X-Forwarded-Encrypted: i=1; AJvYcCUzQKur05p4KH0zs58JyxeIXRElg7LyrhQ7DnW9c67BqdlCqfnbNjAC3tlA3h0ijy1nfCVuq5FJiyL+@vger.kernel.org, AJvYcCVCby3ExQwxHWQqP3E6Jzu2NipM/lO9UemWHhwMwdEVAMJRMnXzuK9LqJEqJnRyy7tKnjmBk7boicat5qBM@vger.kernel.org, AJvYcCWJ6XrKuVYma7HZqt1dxrI+DQmyB4Z7T3/mlrGV2/9OFFQ+LG5jV4THWn6d4DlPcGhyKC9GLV7vPQ/+@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYvaKlMlkJX5y/LXR5hMiC3RPWq3UMUEns2/5EccnjZaY9Pj3
	zDZUQ3Nyd+AhR+N558GMUUZ10Y7LR0xmzbHPJD4As72x1aIJVfl5
X-Gm-Gg: ASbGncupXLM3yXzWZHtTxI6e94n6EqHypS+5OYOivLJS+T08X9OtsSH9OSVFlND90rL
	nVnosUi84O3XZ0+GzWuO/H9ckt86k0MbMH2f8ZyCLhsxnDEBTPbVLFd8Ddx4graAMVkt9eT5RXf
	1CKLTy/9cnlyax21bBLNPyaF8nIoMCdxuZN1JBO+uXMSj5NrKKYwTNCoFPwvM4gBLpy6j8UsdSw
	HKMTF9Vr4NbGx7nGN+OydXMNCDHLyIDS14TW0ec7/Gby4IhrEOLl2NqJkUeNRR45XSWPOW/LWKy
	y8kXbslwpLYaGO37TTV18gXb5wdYBQlvxuuz
X-Google-Smtp-Source: AGHT+IHPZCycB/Wz1WISGCZKdwZHNRLPreMsBCK1H3+677e2/gdlTibb/D6w/+3yimQAmZPY7g+QVw==
X-Received: by 2002:ac8:5710:0:b0:472:116f:94e1 with SMTP id d75a77b69052e-472116f97aemr22101861cf.11.1740058137951;
        Thu, 20 Feb 2025 05:28:57 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720d4340f4sm16095391cf.65.2025.02.20.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:28:57 -0800 (PST)
Date: Thu, 20 Feb 2025 10:28:52 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com, Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH RESEND v3 16/17] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <Z7cuFJQeqQPYpX6d@JSANTO12-L01.ad.analog.com>
Reply-To: 20250216163153.55a1ae97@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <2c3ce1701545e435238605342397e45657a0fb2a.1739368121.git.Jonathan.Santos@analog.com>
 <20250216163153.55a1ae97@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216163153.55a1ae97@jic23-huawei>

On 02/16, Jonathan Cameron wrote:
> On Wed, 12 Feb 2025 15:18:59 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
> > Separate filter type and decimation rate from the sampling frequency
> > attribute. The new filter type attribute enables sinc3, sinc3+rej60
> > and wideband filters, which were previously unavailable.
> > 
> > Previously, combining decimation and MCLK divider in the sampling
> > frequency obscured performance trade-offs. Lower MCLK divider
> > settings increase power usage, while lower decimation rates reduce
> > precision by decreasing averaging. By creating an oversampling
> > attribute, which controls the decimation, users gain finer control
> > over performance.
> > 
> > The addition of those attributes allows a wider range of sampling
> > frequencies and more access to the device features.
> > 
> > Co-developed-by: Pop Paul <paul.pop@analog.com>
> > Signed-off-by: Pop Paul <paul.pop@analog.com>
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> As below. We should aim to 'pre bake' the value arrays for
> get_available() to avoid the potential race conditions of a consumer
> seeing a partly updated set a parameters change.
> 
> Better to see a consistent but stale one.
> 
> Jonathan
> 
> > ---
> > v3 Changes:
> > * removed unsed variables.
> > * included sinc3+rej60 filter type.
> > * oversampling_ratio moved to info_mask_shared_by_type.
> > * reordered functions to avoid foward declaration.
> > * simplified regmap writes.
> > * Removed locking.
> > * replaced some helper functions for direct regmap_update_bits
> >   calls.
> > * Addressed other nits.
> > 
> > v2 Changes:
> > * Decimation_rate attribute replaced for oversampling_ratio.
> > ---
> >  drivers/iio/adc/ad7768-1.c | 359 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 290 insertions(+), 69 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 8aea38c154fe..18f1ea0bf66d 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> 
> > +
> > +/* Decimation Rate range for each filter type */
> > +static const int ad7768_dec_rate_range[][3] = {
> > +	[AD7768_FILTER_SINC5] = { 8, 8, 1024 },
> > +	[AD7768_FILTER_SINC3] = { 32, 32, 163840 },
> > +	[AD7768_FILTER_WIDEBAND] = { 32, 32, 1024 },
> > +	[AD7768_FILTER_SINC3_REJ60] = { 32, 32, 163840 },
> > +};
> > +
> > +/*
> > + * The AD7768-1 supports three primary filter types:
> > + * Sinc5, Sinc3, and Wideband.
> > + * However, the filter register values can also encode
> wrap at 80 chars.
> > + * additional parameters such as decimation rates and
> > + * 60Hz rejection. This utility function separates the
> > + * filter type from these parameters.
> > + */
> 
> >  
> > -	return 0;
> > +static int ad7768_get_fil_type_attr(struct iio_dev *dev,
> > +				    const struct iio_chan_spec *chan)
> > +{
> > +	struct ad7768_state *st = iio_priv(dev);
> > +	int ret;
> > +	unsigned int mode;
> > +
> > +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mode = FIELD_GET(AD7768_DIG_FIL_FIL_MSK, mode);
> > +
> > +	/*
> > +	 * From the register value, get the corresponding
> > +	 * filter type.
> 
> Very short line wrap.  Stick to 80 chars.
> 
> > +	 */
> > +	return ad7768_filter_regval_to_type[mode];
> >  }
> 
> >  
> > @@ -619,16 +798,25 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
> >  			     long info)
> >  {
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> > -	int i;
> > +	int i, freq_filtered, len = 0;
> >  
> >  	switch (info) {
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		*vals = (int *)ad7768_dec_rate_range[st->filter_type];
> > +		*type = IIO_VAL_INT;
> > +		return IIO_AVAIL_RANGE;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
> > -			st->samp_freq_avail[i] = DIV_ROUND_CLOSEST(st->mclk_freq,
> > -								   ad7768_clk_config[i].clk_div);
> > +		freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);
> 
> Ah. So now it is dynamic.  This hits the previously mentioned race.
> A consumer can be holding a copy of this and acting on it whilst holding no
> locks on this device - thus it can see a mixture of values as this update
> occurs. To avoid that you need to precompute the combinations +
> store the lot in arrays.  Then this code should simply be selecting the arrays.
> A consumer holding a stale one will get a consistent (if wrong) set.
>
Yes, before the available frequencies were static, but now they depend
on the oversampling ratio. I can create a helper function to precomput
and fill this array and call it after configuring the digital filter, 
where the filter type and OSR is set.

For the previous static case, i call this function in the probe.
> The < 50 check makes this more complex than normal but they are still static
> choices I think as long as the input clock doesn't change.
>

I will include this in the helper function.

> > +		for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> > +			st->samp_freq_avail[len] = DIV_ROUND_CLOSEST(freq_filtered,
> > +								     ad7768_mclk_div_rates[i]);
> > +			/* Sampling frequency cannot be lower than the minimum of 50 SPS */
> > +			if (st->samp_freq_avail[len] >= 50)
> > +				len++;
> > +		}
> >  
> >  		*vals = (int *)st->samp_freq_avail;
> > -		*length = ARRAY_SIZE(ad7768_clk_config);
> > +		*length = len;
> >  		*type = IIO_VAL_INT;
> >  		return IIO_AVAIL_LIST;
> >  	default:
> > @@ -636,20 +824,45 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
> >  	}
> >  }
> >  
> > -static int ad7768_write_raw(struct iio_dev *indio_dev,
> > -			    struct iio_chan_spec const *chan,
> > -			    int val, int val2, long info)
> > +static int __ad7768_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long info)
> >  {
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> > +	int ret;
> >  
> >  	switch (info) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> >  		return ad7768_set_freq(st, val);
> > +
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		ret = ad7768_configure_dig_fil(indio_dev, st->filter_type, val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Update sampling frequency */
> > +		return ad7768_set_freq(st, st->samp_freq);
> >  	default:
> >  		return -EINVAL;
> >  	}
> >  }
> >  
> > +static int ad7768_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long info)
> > +{
> > +	int ret;
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> Previously we didn't claim this to set the sampling frequency.
> That change looks like a potential ABI issue.  I'm fine with it
> if we should always have this protected.
> 
> If you are just using it to avoid racing between setting sampling
> frequency and oversampling ratio then don't use that, use a local
> lock where the scope can be clearly described.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = __ad7768_write_raw(indio_dev, chan, val, val2, info);
> > +	iio_device_release_direct_mode(indio_dev);
> > +
> > +	return ret;
> > +}

