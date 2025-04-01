Return-Path: <linux-iio+bounces-17495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C59A771D0
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 02:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851B83AA150
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 00:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7940855;
	Tue,  1 Apr 2025 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Bh5/NT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20E60B8A;
	Tue,  1 Apr 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466706; cv=none; b=Y8tp3Dlqqqyor8Pvo4dtJOGgPbwdvtqaOi/0Cb9R1uxVAcbUjesjQsZlQ+h11/1LO+u/b4mI5vtRWRJ6xqy32+YSV/tNjI8cE6/shysWTCr0WrrD7TBqa44B9O1RVnHaydd2fI3vi64oHIztzCCdyBImCVF6c8yrUS+Mo56n6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466706; c=relaxed/simple;
	bh=fwUzB6w4zZcCoUeAqpOI0L0qLhZknh+SGBUs2RB8p6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXQ5+f/IUENLzd4iSykcvDmt4iRUVawKobxq6cc0qLi/LXGRSo8TfUSluBym5I+VgHBKH2dByLYs3XL/xP//+N2KDVY+1biqCbL1sR21yw2L3mIxFo0mI+cWXfN3YkTTtEbEWK83D8Qk4rPu/XJbFEeO/b/T868NYlP7P1mwRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0Bh5/NT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5a3334fddso70195485a.1;
        Mon, 31 Mar 2025 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743466703; x=1744071503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HigWjTTf9tm9FITEpYy0RKddvQPPUYkq3puUFsgyEU=;
        b=R0Bh5/NTcRLaIOPDgdCrpP7wOZo00kHEdHmg5ySvDJh+ACWeNHUtGvRUi0eeZdrrJs
         xUW9O74/EpBF+XuPpz0EzkSDYeM/MIt/OKr1K0hKRdkIBAk/spNvASVAmYy1hDx4Sr/l
         vlNYCzLMaIRaEkP3WYDr8pjL78egDzV20TZPiEbuwxWDIgf61vBO3aff3ZDCCI62x7DH
         KtFH4RmXwgHcy292j+iyP7XSoMW1pC/6L+f3Pk7lRngpf+WIDqQ84Ik4NvR9PsA7l5mE
         NsHqiT++Z/VySTGaYN6fEJb+WkihIuPPqt6lJ52HM1IWTQU7oozakBtKz3jIOhgQ1tos
         CroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743466703; x=1744071503;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HigWjTTf9tm9FITEpYy0RKddvQPPUYkq3puUFsgyEU=;
        b=iZPM07pRhmvS7yGlE2QFfZjqDkb7fNwgeQExXTvd7Y3vWU69nykpudtSXK5B2BaB3b
         Pog5/1t3oA4Cz9nJCJz1pUWw7bxcY920VBGdmQOOCUzehUK2S2a5x/DI5WKVmzKYcYdt
         M05tVMe73A4YbCWsUE9/oJdoyRXdWp2anqPKgIT92Xpi6xb3w1YIPbgEpczD5Twt+hCd
         fSPSxi8gub0elBxLIJSesw6957rGbANAR8dx+U9uQS3prwb76+kUppsHdn72yhrKyxx6
         yf8B9+6RBnG3fA8ni+eXvJmc6jpd8bNvm1RrlKJQupkkGdNaxLw4Xzvq7PqGXTn/up80
         0PCA==
X-Forwarded-Encrypted: i=1; AJvYcCUXIzyLuXseTTgfHjxhayG3g6dy5XChViobBBnRl7dvlOZQ0aKpUUNDqJ5phUc0Gp2oPz3nFj69f6N7@vger.kernel.org, AJvYcCVj3fcB3JP/kbqrWNd7mEOqdsoOyfDR1p/qvPIBLQ/Giqcu0w1TfnDIZ1NtzCvmlN/th+Q6EBBru/FP+Q==@vger.kernel.org, AJvYcCWK/5ty0ZrBmgRMSep4Td9+Az5969q2IV5ek/ajFNE3Fz3Ef6E47oKmZVimgCfxDfq4AQbz/Gchg4Ni@vger.kernel.org, AJvYcCX6p9AhyjKcU+LyACtm98d6UibMU+YO0VMoX8KNlhqnQmMUWaFx+EctSCY7QCzKMaw5tVqgP2NRQjlmVGmw@vger.kernel.org
X-Gm-Message-State: AOJu0YxCa+6iVmkSgGukV/7P+FBv2Xp9PIiPQ7//OrxDXWd+us41ecXy
	2jEWBAp5KdEChbTyTDIH6y6Tg4o39671C5XZ8mhqE9zGDd5naBVx4rkh+kFV
X-Gm-Gg: ASbGncukXrJVri9TnjMC3tCIeI2WsSoHtBaeLd77g4L1EwFUlgsrHArOClduUqDFBZs
	fbc75qjnnGq2mxct1R13m3gaypjnsM3pCf1yM0EC5hXC+3XCAqowX2QGyPE9EZgUMLeWt1nnw5R
	z6z+ojj8AEUPS66vi1r6dro9I7Blq751kHddwQtWydR9zHGOzLSyUOr4oYb8uHV1Fsf6haxJInj
	WnHcUTSfB+HpmyOWRLqvpbN3WiEl5/TtNWPkWDE3fJgxLLeBx7kaaq2DA7BrW9VD6kdl7pwLX0v
	K02nWe8et5Q+KDCiootUmFXJhqBSUWeJ2TcwvPJezjJ/H6jpKQ5znue2igZzSQ0QIw==
X-Google-Smtp-Source: AGHT+IHs0WEd3vXTdHgsXfuFm4qf2zqMdH16GrCNj6R7Dn6j8Tk6CHYw1K70/NZDzA81yhcFmYDuMQ==
X-Received: by 2002:a05:620a:4141:b0:7c0:c024:d5 with SMTP id af79cd13be357-7c75cb2775bmr28163485a.8.1743466703232;
        Mon, 31 Mar 2025 17:18:23 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f777d700sm567114785a.103.2025.03.31.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 17:18:22 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:18:16 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com, Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v4 16/17] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <Z+swyCusIwl8zixt@JSANTO12-L01.ad.analog.com>
Reply-To: 20250308135620.3c95b951@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <3586a75e3b7bf09c271a44390b2fed9f1ffc8565.1741268122.git.Jonathan.Santos@analog.com>
 <20250308135620.3c95b951@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308135620.3c95b951@jic23-huawei>

On 03/08, Jonathan Cameron wrote:
> On Thu, 6 Mar 2025 18:04:24 -0300
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
F> > over performance.
> > 
> > The addition of those attributes allows a wider range of sampling
> > frequencies and more access to the device features. Sampling frequency
> > table is updated after every digital filter paramerter change.
> > 
> > Co-developed-by: Pop Paul <paul.pop@analog.com>
> > Signed-off-by: Pop Paul <paul.pop@analog.com>
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v4 Changes:
> > * Sampling frequency table is dinamically updated after every
> 
> Good to spell check. Dynamically
> 
> >   filter configuration.
> 
> Currently this runs into the potential race conditions we get with
> read_avail callbacks.  If we update the avail values in parallel
> with consumer code in a kernel driver reading them we can get tearing.
> So better if possible to do it all before those interfaces are exposed
> and just pick from a set of static arrays.
> 
I understand the problem, but the number of possible sampling
frequencies is quite large because of the decimation/OSR:

-> For wideband there are 6 decimations available.
-> For Sinc5 there are 8 decimations.
-> For sinc3 (here's the problem) we have up to 5119 decimation options.
From x32 to x163,840 (mclk_div = 2) with a 32 step.

BTW, that's why we use ranges for `oversampling_ratio_available`
attribute.

To reflect all sampling frequencies combinations (fref/(mclk_div *
OSR)), we would need a considerably large array. We did not have this
problem before because we were not supporting the sinc3 filter.

> > +static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
> > +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
> > +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
> > +	{ },
> 
> No trailing comma on a terminating entry as we don't want it to be easy
> to accidentally add stuff after this.
> 
> > +};
> 
> 
> > +static int ad7768_configure_dig_fil(struct iio_dev *dev,
> > +				    enum ad7768_filter_type filter_type,
> > +				    unsigned int dec_rate)
> > +{
> > +	struct ad7768_state *st = iio_priv(dev);
> > +	unsigned int dec_rate_idx, dig_filter_regval;
> > +	int ret;
> > +
> > +	switch (filter_type) {
> > +	case AD7768_FILTER_SINC3:
> > +		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC3);
> > +		break;
> > +	case AD7768_FILTER_SINC3_REJ60:
> > +		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC3_REJ60);
> > +		break;
> > +	case AD7768_FILTER_WIDEBAND:
> > +		/* Skip decimations 8 and 16, not supported by the wideband filter */
> > +		dec_rate_idx = find_closest(dec_rate, &ad7768_dec_rate_values[2],
> > +					    ARRAY_SIZE(ad7768_dec_rate_values) - 2);
> > +		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_WIDEBAND) |
> > +				    AD7768_DIG_FIL_DEC_RATE(dec_rate_idx);
> > +		/* Correct the index offset */
> > +		dec_rate_idx += 2;
> > +		break;
> > +	case AD7768_FILTER_SINC5:
> > +		dec_rate_idx = find_closest(dec_rate, ad7768_dec_rate_values,
> > +					    ARRAY_SIZE(ad7768_dec_rate_values));
> > +
> > +		/*
> > +		 * Decimations 8 (idx 0) and 16 (idx 1) are set in the
> > +		 * FILTER[6:4] field. The other decimations are set in the
> > +		 * DEC_RATE[2:0] field, and the idx need to be offsetted by two.
> > +		 */
> > +		if (dec_rate_idx == 0)
> > +			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5_X8);
> > +		else if (dec_rate_idx == 1)
> > +			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5_X16);
> > +		else
> > +			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5) |
> > +					    AD7768_DIG_FIL_DEC_RATE(dec_rate_idx - 2);
> > +		break;
> > +	}
> > +
> > +	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, dig_filter_regval);
> > +	if (ret)
> >  		return ret;
> >  
> > -	/* A sync-in pulse is required every time the filter dec rate changes */
> > +	st->filter_type = filter_type;
> > +	/*
> > +	 * The decimation for SINC3 filters are configured in different
> > +	 * registers
> > +	 */
> > +	if (filter_type == AD7768_FILTER_SINC3 ||
> > +	    filter_type == AD7768_FILTER_SINC3_REJ60) {
> > +		ret = ad7768_set_sinc3_dec_rate(st, dec_rate);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		st->oversampling_ratio =  ad7768_dec_rate_values[dec_rate_idx];
> 
> Looks like an extra space after =
> 

Sorry about that

> > +	}
> > +
> > +	ad7768_fill_samp_freq_tbl(st);
> 
> This is opens a potentially complex race condition if we have the an
> in kernel consumer reading the data in this array as it is being updated
> (currently we can't stop that happening though solutions to that problem
> have been much discussed). 
> 
> There aren't that many oversampling ratios so perhaps it is better
> to precalculate all the potential available values as an array indexed

As I said above, unfortunately there are many OSR options.

> by oversampling ratio.  That way all the data is const, it's just possible
> to get stale pointer to the wrong entry which can always happen anyway
> if the read vs update happen in different entities.
> 
> > +
> > +	/* A sync-in pulse is required after every configuration change */
> >  	return ad7768_send_sync_pulse(st);
> >  }
> 
> >  
> > +static int ad7768_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long info)
> > +{
> > +	int ret;
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> 
> update to use if (!iio_device_claim_direct())
> 

OK!

> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = __ad7768_write_raw(indio_dev, chan, val, val2, info);
> > +	iio_device_release_direct_mode(indio_dev);
> > +
> > +	return ret;
> > +}
> 

