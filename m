Return-Path: <linux-iio+bounces-17659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C49A7CD99
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 12:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB00188BD9A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13631A5B8C;
	Sun,  6 Apr 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciAvouRs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5512AE66;
	Sun,  6 Apr 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743936551; cv=none; b=b8JQZzkKY47/nPaZgF0iV5r0rxtyRwlQ+Qm5CDZsEU6O3giuw/yiGpIeBo4TvU4ordAI52fXQT/UrTTGUs2KvZK/uHA3RhRqS2Q8yfsScRLCxB7rwp5SB5xUqb49+r89yRmc+7gEr5ABV9FXsXvlAi+Q2JZ1Uckqd2M8fVwi9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743936551; c=relaxed/simple;
	bh=494c0ISnHCeFKQx/wB17nPBOe6V1ke7jMKsUxQ+P/gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U87k91M2sXAr1wubE9tq1dHuAhDNEU3EMeds9xlVCET+dP6f0X/R6UuviOlt+ln7vnP/pPJotUL/gika3Vue4Vv4QAzC0rWf0E1znNZR0UTvnsWj8gXNwPaNMSFfyRFAOFsCYUkX07sv+Bw52YDFhh5Lm/S+nRKDAARb+9K3Boc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciAvouRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78306C4CEE3;
	Sun,  6 Apr 2025 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743936550;
	bh=494c0ISnHCeFKQx/wB17nPBOe6V1ke7jMKsUxQ+P/gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ciAvouRs2+BcILKzdeZpnj8Za1Hdcnlo7D0Kr593zBiu6fGA5J59cVTeVWlGlJrcn
	 9Q8fU6IkVXqJMf37K2yA9arnDsQao9lfcn+WUOanR39fzGcI5TktgxyRSdZGSArdZ9
	 QO0CrJlxAUsbolSf1Q37HH7b73tmw/Johe/1YOB686T128cPuU6qhGJhKFEnS6JfXF
	 iAxBPRc/8lwV9LWNkp15L+nN0UTwFdxh8fOv9eNOYzURltrkkwj5cn3bCpMZ9hOdXX
	 T+/D8b0FUv4rEbPVIIdiMC/hklrdzkiwh0Q+mcT3X2kdUDMFQ2+5o09HvU+WPsAABY
	 93cipIMCs9wnA==
Date: Sun, 6 Apr 2025 11:49:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 20250308135620.3c95b951@jic23-huawei.smtp.subspace.kernel.org,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com, Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v4 16/17] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <20250406114901.0e3c885d@jic23-huawei>
In-Reply-To: <Z+swyCusIwl8zixt@JSANTO12-L01.ad.analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<3586a75e3b7bf09c271a44390b2fed9f1ffc8565.1741268122.git.Jonathan.Santos@analog.com>
	<20250308135620.3c95b951@jic23-huawei>
	<Z+swyCusIwl8zixt@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 21:18:16 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 03/08, Jonathan Cameron wrote:
> > On Thu, 6 Mar 2025 18:04:24 -0300
> > Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> >   
> > > Separate filter type and decimation rate from the sampling frequency
> > > attribute. The new filter type attribute enables sinc3, sinc3+rej60
> > > and wideband filters, which were previously unavailable.
> > > 
> > > Previously, combining decimation and MCLK divider in the sampling
> > > frequency obscured performance trade-offs. Lower MCLK divider
> > > settings increase power usage, while lower decimation rates reduce
> > > precision by decreasing averaging. By creating an oversampling
> > > attribute, which controls the decimation, users gain finer control
> F> > over performance.
> > > 
> > > The addition of those attributes allows a wider range of sampling
> > > frequencies and more access to the device features. Sampling frequency
> > > table is updated after every digital filter paramerter change.
> > > 
> > > Co-developed-by: Pop Paul <paul.pop@analog.com>
> > > Signed-off-by: Pop Paul <paul.pop@analog.com>
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > > v4 Changes:
> > > * Sampling frequency table is dinamically updated after every  
> > 
> > Good to spell check. Dynamically
> >   
> > >   filter configuration.  
> > 
> > Currently this runs into the potential race conditions we get with
> > read_avail callbacks.  If we update the avail values in parallel
> > with consumer code in a kernel driver reading them we can get tearing.
> > So better if possible to do it all before those interfaces are exposed
> > and just pick from a set of static arrays.
> >   
> I understand the problem, but the number of possible sampling
> frequencies is quite large because of the decimation/OSR:
> 
> -> For wideband there are 6 decimations available.
> -> For Sinc5 there are 8 decimations.
> -> For sinc3 (here's the problem) we have up to 5119 decimation options.  
> From x32 to x163,840 (mclk_div = 2) with a 32 step.
> 
> BTW, that's why we use ranges for `oversampling_ratio_available`
> attribute.

Ah, understood now.  Another case where I guess we need to fix up in the long
term.  Short term not a problem as I don't think any consumers yet read the filter
parameters anyway.

> 
> To reflect all sampling frequencies combinations (fref/(mclk_div *
> OSR)), we would need a considerably large array. We did not have this
> problem before because we were not supporting the sinc3 filter.
> 
> > > +static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
> > > +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
> > > +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
> > > +	{ },  
> > 
> > No trailing comma on a terminating entry as we don't want it to be easy
> > to accidentally add stuff after this.
> >   
> > > +};  
> > 
> >   
> > > +static int ad7768_configure_dig_fil(struct iio_dev *dev,
> > > +				    enum ad7768_filter_type filter_type,
> > > +				    unsigned int dec_rate)
> > > +{
> > > +	struct ad7768_state *st = iio_priv(dev);
> > > +	unsigned int dec_rate_idx, dig_filter_regval;
> > > +	int ret;
> > > +
> > > +	switch (filter_type) {
> > > +	case AD7768_FILTER_SINC3:
> > > +		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC3);
> > > +		break;
> > > +	case AD7768_FILTER_SINC3_REJ60:
> > > +		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC3_REJ60);
> > > +		break;
> > > +	case AD7768_FILTER_WIDEBAND:
> > > +		/* Skip decimations 8 and 16, not supported by the wideband filter */
> > > +		dec_rate_idx = find_closest(dec_rate, &ad7768_dec_rate_values[2],
> > > +					    ARRAY_SIZE(ad7768_dec_rate_values) - 2);
> > > +		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_WIDEBAND) |
> > > +				    AD7768_DIG_FIL_DEC_RATE(dec_rate_idx);
> > > +		/* Correct the index offset */
> > > +		dec_rate_idx += 2;
> > > +		break;
> > > +	case AD7768_FILTER_SINC5:
> > > +		dec_rate_idx = find_closest(dec_rate, ad7768_dec_rate_values,
> > > +					    ARRAY_SIZE(ad7768_dec_rate_values));
> > > +
> > > +		/*
> > > +		 * Decimations 8 (idx 0) and 16 (idx 1) are set in the
> > > +		 * FILTER[6:4] field. The other decimations are set in the
> > > +		 * DEC_RATE[2:0] field, and the idx need to be offsetted by two.
> > > +		 */
> > > +		if (dec_rate_idx == 0)
> > > +			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5_X8);
> > > +		else if (dec_rate_idx == 1)
> > > +			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5_X16);
> > > +		else
> > > +			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5) |
> > > +					    AD7768_DIG_FIL_DEC_RATE(dec_rate_idx - 2);
> > > +		break;
> > > +	}
> > > +
> > > +	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, dig_filter_regval);
> > > +	if (ret)
> > >  		return ret;
> > >  
> > > -	/* A sync-in pulse is required every time the filter dec rate changes */
> > > +	st->filter_type = filter_type;
> > > +	/*
> > > +	 * The decimation for SINC3 filters are configured in different
> > > +	 * registers
> > > +	 */
> > > +	if (filter_type == AD7768_FILTER_SINC3 ||
> > > +	    filter_type == AD7768_FILTER_SINC3_REJ60) {
> > > +		ret = ad7768_set_sinc3_dec_rate(st, dec_rate);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else {
> > > +		st->oversampling_ratio =  ad7768_dec_rate_values[dec_rate_idx];  
> > 
> > Looks like an extra space after =
> >   
> 
> Sorry about that
> 
> > > +	}
> > > +
> > > +	ad7768_fill_samp_freq_tbl(st);  
> > 
> > This is opens a potentially complex race condition if we have the an
> > in kernel consumer reading the data in this array as it is being updated
> > (currently we can't stop that happening though solutions to that problem
> > have been much discussed). 
> > 
> > There aren't that many oversampling ratios so perhaps it is better
> > to precalculate all the potential available values as an array indexed  
> 
> As I said above, unfortunately there are many OSR options.
> 
> > by oversampling ratio.  That way all the data is const, it's just possible
> > to get stale pointer to the wrong entry which can always happen anyway
> > if the read vs update happen in different entities.
> >   
> > > +
> > > +	/* A sync-in pulse is required after every configuration change */
> > >  	return ad7768_send_sync_pulse(st);
> > >  }  
> >   
> > >  
> > > +static int ad7768_write_raw(struct iio_dev *indio_dev,
> > > +			    struct iio_chan_spec const *chan,
> > > +			    int val, int val2, long info)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = iio_device_claim_direct_mode(indio_dev);  
> > 
> > update to use if (!iio_device_claim_direct())
> >   
> 
> OK!
> 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = __ad7768_write_raw(indio_dev, chan, val, val2, info);
> > > +	iio_device_release_direct_mode(indio_dev);
> > > +
> > > +	return ret;
> > > +}  
> >   


