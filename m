Return-Path: <linux-iio+bounces-5218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863558CD5BE
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 16:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005541F2243B
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4B14C5AF;
	Thu, 23 May 2024 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAU5Sw6H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632414B96C;
	Thu, 23 May 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474536; cv=none; b=bIQmZzqiIZw5lV6mbPzaMqo4jFb0eoZbYdfN6Dn0q2Jaranf/bA8Grq+jaistssM+iFcio2GkF4CePHyVCUuUeisFY+SbZOvPC+rP+aAkmNMNmlumpbg/rO2g4FK/NWyQ81VkokPNnXiEYLfOp7l7sJTUTn5NskwtpWpL5eEgT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474536; c=relaxed/simple;
	bh=80dyIVrwBkD6NbBwNftwmI4FAqkJmpk1vCq/v8Mv7t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lltRxOgLVWFJ1xH9usJEpyDRovjmMBzaQOcHZAAss1WZgU6hxAC8x2xZTsJ/XFn2JcedOqWkWHQy1qVNl7iOnpQpDWYewGRulSYHilQEhcDtab/SqZLJZiGl9sajZ2UFgIv4bFGKTsTc2I3yJ0Be/E+E+4YISFFlyaF1GsuzQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAU5Sw6H; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so1015727966b.0;
        Thu, 23 May 2024 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716474533; x=1717079333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ol6w17Fw5JOgOw8lGzbAlNWPnVf/zsYk2EuKivYdh18=;
        b=hAU5Sw6HsaTa3KqiX6qtazIbJZv7JoR4TXpiskSLZvdLvqhvjeQPzLrMKfBwIasMPb
         nRfJtOWw4nk3OwnFiO2/Oyvrp1B2vQaMWK4CHt+gJNjgd/v+iNY8sUP+qvGgPAchFO8S
         OzyjFlue5Iycu05ls/SxFyhuO85Z5Uz5iUvNpbAwkMBbfqtu2xmSDQuK7pX6S3bRsScR
         QByfvGNIdkQ8PQxwTNDQ641gYTssscPWssvtjrGMyxACtAp0IN0vjzkJH5H2eZvvL7Zg
         5u2oj+G87yg1RmR+mx3qqbYFtTvdwTvSV8eySIIpk744fG1i9VJqsqK6lrAOjL5ptXP5
         dhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716474533; x=1717079333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol6w17Fw5JOgOw8lGzbAlNWPnVf/zsYk2EuKivYdh18=;
        b=oHK3Ml989FCLnW+bmY9TX5hoR6mj9C3+04NDEMLSxJyfFhw0e8P5dRVS6qGmLuUlB4
         vp8xdOolWIADTG0ZXGjeKNAoYDiNrkFeSSb+zWxB+HNnQxrGmghKhMCjU/h7zb1H0SVL
         hVsbzraThjeS5eK7B/eaCKQBVGP1M0toFVt53Ey+F1fpWLQLwuwsENg8DRR6XyJSbOeo
         bWpUx78H9jgCxR4JYcCUYc4QckYqmDX/7lY7uaKx8/SBeXqVVae1NMPi5lErkiVc8ina
         x8bnvMTka8n9YruNWZkWicWipnOROgV95FTy0tD4Uj9IlhKuZx2Z3oLFpu9pbqU3wRBE
         M0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSQsPWmVN1gbvIsVZGOWdriOPKQjxCY9SocJWmIHvcSFfwmBmQOvD6tPPT062W54fiaJaZrzedJPTJ43nToTrHdonJ3iMF8dSlXXw1zZp7MS2Tp8mrPNf4JZPXVEfcg3cmVGcotqOX
X-Gm-Message-State: AOJu0YyOgX+eVk3SETFXmSiJd4LLLOZejh2pe6rnl8MJ9n045kRtlNut
	6tT3EYdfckx2JZirL7DKt0ZsdW7BrjBlFVjUIF5IyC8h6+X7iuYTGRv8Dw==
X-Google-Smtp-Source: AGHT+IEc0YjvAOHqsqBKAvD1XVCkZU5IV7IoVPSa5kXx1MTF68Bxegz4750OfF+TAJ8ye6fqvkNYpQ==
X-Received: by 2002:a17:906:b14f:b0:a5c:daf2:1cfb with SMTP id a640c23a62f3a-a6228206aa8mr458868766b.63.1716474532279;
        Thu, 23 May 2024 07:28:52 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7f27sm1940676366b.127.2024.05.23.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:28:51 -0700 (PDT)
Date: Thu, 23 May 2024 16:28:49 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: fix hysteresis representation
Message-ID: <20240523142849.GA558466@debian>
References: <20240523114336.532428-1-dima.fedrau@gmail.com>
 <cef810ee-bb2c-4588-baec-7edfc74daeea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cef810ee-bb2c-4588-baec-7edfc74daeea@gmail.com>

Am Thu, May 23, 2024 at 04:12:37PM +0200 schrieb Javier Carrasco:
> Hi Dimitri, a few comments inline.
> 
> On 23/05/2024 13:43, Dimitri Fedrau wrote:
> > According to the ABI docs hysteresis values are represented as offsets to
> > threshold values. Current implementation represents hysteresis values as
> > absolute values which is wrong. Nevertheless the device stores them as
> > absolute values and the datasheet refers to them as clear thresholds. Fix
> > the reading and writing of hysteresis values by including thresholds into
> > calculations.
> > 
> > Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> > 
> > Since absolute values are used on the device, the hysteresis values are
> > influenced by setting thresholds. Is this behavior in line with the ABI docs ?
> > It can be fixed by readjusting the threshold clear value whenever setting
> > thresholds to have the same hysteresis value as before. See some example below:
> > 
> > # echo 25 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> > # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> > 24.727626459
> > # echo 5 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> > # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> > 5.127031357
> > # echo 35 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> > # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> > 15.381094071
> > 
> > Below are some corner cases tested by setting threshold and hysteresis values.
> > To check that the threshold clear values are correct, registers are read out by
> > using i2ctransfer and the corresponding temperature and relative humidity
> > thresholds are calculated using the formulas in the datasheet.
> > 
> > # echo 125 > in_temp_thresh_rising_value
> > # cat in_temp_thresh_rising_value
> > 124.875638971
> > 
> > # echo 165 > in_temp_thresh_rising_hysteresis
> > # cat in_temp_thresh_rising_hysteresis
> > 164.748607614
> > 
> > # echo 100 > in_humidityrelative_thresh_rising_value
> > # cat in_humidityrelative_thresh_rising_value
> > 99.220263981
> > 
> > # echo 100 > in_humidityrelative_thresh_rising_hysteresis
> > # cat in_humidityrelative_thresh_rising_hysteresis
> > 99.220263981
> > 
> > threshold high, temperature = 124,875638972 C, humidity = 99.220263981
> > # i2ctransfer -f -y 4 w2@0x44 0xe1 0x1f r3
> > 0xff 0xf1 0xb3
> > 
> > threshold high clear, temperature = -39.872968643 C, humidity = 0
> > # i2ctransfer -f -y 4 w2@0x44 0xe1 0x14 r3
> > 0x00 0x0f 0xaf
> > 
> > 
> > # echo -40 > in_temp_thresh_falling_value
> > # cat in_temp_thresh_falling_value
> > -39.872968642
> > 
> > # echo 165 > in_temp_thresh_falling_hysteresis
> > # cat in_temp_thresh_falling_hysteresis
> > 164.406805523
> > 
> > # echo 0 > in_humidityrelative_thresh_falling_value 
> > # cat in_humidityrelative_thresh_falling_value
> > 0.000000000
> > 
> > # echo 100 > in_humidityrelative_thresh_falling_hysteresis 
> > # cat in_humidityrelative_thresh_falling_hysteresis
> > 99.220263981
> > 
> > threshold low, temperature = -39.872968643 C, humidity = 0
> > # i2ctransfer -f -y 4 w2@0x44 0xe1 0x02 r3
> > 0x00 0x0f 0xaf
> > 
> > threshold low clear, temperature = 124,533836881 C, humidity = 99,220263981
> > # i2ctransfer -f -y 4 w2@0x44 0xe1 0x09 r3
> > 0xff 0xf0 0x82
> > 
> > ---
> >  drivers/iio/humidity/hdc3020.c | 292 +++++++++++++++++++++++++--------
> >  1 file changed, 221 insertions(+), 71 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> > index cdc4789213ba..d41713ff1deb 100644
> > --- a/drivers/iio/humidity/hdc3020.c
> > +++ b/drivers/iio/humidity/hdc3020.c
> > @@ -19,6 +19,8 @@
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/math.h>
> Is math.h not included in math64.h?
>
It is. Will fix it.

> > +#include <linux/math64.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/pm.h>
> > @@ -66,8 +68,10 @@
> >  
> >  #define HDC3020_CRC8_POLYNOMIAL		0x31
> >  
> > -#define HDC3020_MIN_TEMP		-40
> > -#define HDC3020_MAX_TEMP		125
> > +#define HDC3020_MIN_TEMP_MICRO		-39872968
> > +#define HDC3020_MAX_TEMP_MICRO		124875639
> > +#define HDC3020_MAX_TEMP_HYST_MICRO	164748607
> > +#define HDC3020_MAX_HUM_MICRO		99220264
> >  
> >  struct hdc3020_data {
> >  	struct i2c_client *client;
> > @@ -368,6 +372,75 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> >  
> > +static int hdc3020_tresh_get_temp(u16 thresh)
> > +{
> > +	int temp;
> > +
> > +	/*
> > +	 * Get the temperature threshold from 9 LSBs, shift them to get
> > +	 * the truncated temperature threshold representation and
> > +	 * calculate the threshold according to the formula in the
> > +	 * datasheet. Result is degree celsius scaled by 65535.
> > +	 */
> > +	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
> > +	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> > +
> > +	return -2949075 + (175 * temp);
> > +}
> > +
> > +static int hdc3020_tresh_get_hum(u16 thresh)
> > +{
> > +	int hum;
> > +
> > +	/*
> > +	 * Get the humidity threshold from 7 MSBs, shift them to get the
> > +	 * truncated humidity threshold representation and calculate the
> > +	 * threshold according to the formula in the datasheet. Result is
> > +	 * percent scaled by 65535.
> > +	 */
> > +	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
> > +	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
> > +
> > +	return hum * 100;
> > +}
> > +
> > +static u16 hdc3020_thresh_set_temp(int s_temp, u16 curr_thresh)
> > +{
> > +	u64 temp;
> > +	u16 thresh;
> > +
> > +	/*
> > +	 * Calculate temperature threshold, shift it down to get the
> > +	 * truncated threshold representation in the 9LSBs while keeping
> > +	 * the current humidity threshold in the 7 MSBs.
> > +	 */
> > +	temp = (u64)(s_temp + 45000000) * 65535ULL;
> > +	temp = div_u64(temp, 1000000 * 175) >> HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> > +	thresh = FIELD_PREP(HDC3020_THRESH_TEMP_MASK, temp);
> > +	thresh |= (FIELD_GET(HDC3020_THRESH_HUM_MASK, curr_thresh) <<
> > +		  HDC3020_THRESH_HUM_TRUNC_SHIFT);
> > +
> > +	return thresh;
> > +}
> > +
> > +static u16 hdc3020_thresh_set_hum(int s_hum, u16 curr_thresh)
> > +{
> > +	u64 hum;
> > +	u16 thresh;
> > +
> > +	/*
> > +	 * Calculate humidity threshold, shift it down and up to get the
> > +	 * truncated threshold representation in the 7MSBs while keeping
> > +	 * the current temperature threshold in the 9 LSBs.
> > +	 */
> > +	hum = (u64)(s_hum) * 65535ULL;
> > +	hum = div_u64(hum, 1000000 * 100) >> HDC3020_THRESH_HUM_TRUNC_SHIFT;
> > +	thresh = FIELD_PREP(HDC3020_THRESH_HUM_MASK, hum);
> > +	thresh |= FIELD_GET(HDC3020_THRESH_TEMP_MASK, curr_thresh);
> > +
> > +	return thresh;
> > +}
> > +
> >  static int hdc3020_write_thresh(struct iio_dev *indio_dev,
> >  				const struct iio_chan_spec *chan,
> >  				enum iio_event_type type,
> > @@ -376,65 +449,130 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
> >  				int val, int val2)
> >  {
> >  	struct hdc3020_data *data = iio_priv(indio_dev);
> > +	u16 reg, reg_val, reg_thresh_rd, reg_clr_rd, reg_thresh_wr, reg_clr_wr;
> > +	s64 s_thresh, s_hyst, s_clr;
> > +	int s_val, ret;
> >  	u8 buf[5];
> > -	u64 tmp;
> > -	u16 reg;
> > -	int ret;
> > -
> > -	/* Supported temperature range is from –40 to 125 degree celsius */
> > -	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
> > -		return -EINVAL;
> >  
> > -	/* Select threshold register */
> > -	if (info == IIO_EV_INFO_VALUE) {
> > -		if (dir == IIO_EV_DIR_RISING)
> > -			reg = HDC3020_S_T_RH_THRESH_HIGH;
> > -		else
> > -			reg = HDC3020_S_T_RH_THRESH_LOW;
> > +	/* Select threshold registers */
> > +	if (dir == IIO_EV_DIR_RISING) {
> > +		reg_thresh_rd = HDC3020_R_T_RH_THRESH_HIGH;
> > +		reg_thresh_wr = HDC3020_S_T_RH_THRESH_HIGH;
> 
> Do we always need to set reg_clr_rd and reg_clr_wr? It seems that they
> are only required for the IIO_EV_INFO_HYSTERESIS case, where the EV_DIR
> is checked again Maybe we could even get rid of those auxiliary
> variables, or have a single check for EV_DIR with the sign for the
> operations.
>
Yes, you are right.

> > +		reg_clr_rd = HDC3020_R_T_RH_THRESH_HIGH_CLR;
> > +		reg_clr_wr = HDC3020_S_T_RH_THRESH_HIGH_CLR;
> >  	} else {
> > -		if (dir == IIO_EV_DIR_RISING)
> > -			reg = HDC3020_S_T_RH_THRESH_HIGH_CLR;
> > -		else
> > -			reg = HDC3020_S_T_RH_THRESH_LOW_CLR;
> > +		reg_thresh_rd = HDC3020_R_T_RH_THRESH_LOW;
> > +		reg_thresh_wr = HDC3020_S_T_RH_THRESH_LOW;> +		reg_clr_rd = HDC3020_R_T_RH_THRESH_LOW_CLR;
> > +		reg_clr_wr = HDC3020_S_T_RH_THRESH_LOW_CLR;
> >  	}
> >  
> >  	guard(mutex)(&data->lock);
> > -	ret = hdc3020_read_be16(data, reg);
> > +	ret = hdc3020_read_be16(data, reg_thresh_rd);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	/* Scale value to include decimal part into calculations */
> > +	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
> > +
> >  	switch (chan->type) {
> >  	case IIO_TEMP:
> > -		/*
> > -		 * Calculate temperature threshold, shift it down to get the
> > -		 * truncated threshold representation in the 9LSBs while keeping
> > -		 * the current humidity threshold in the 7 MSBs.
> > -		 */
> > -		tmp = ((u64)(((val + 45) * MICRO) + val2)) * 65535ULL;
> > -		tmp = div_u64(tmp, MICRO * 175);
> > -		val = tmp >> HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> > -		val = FIELD_PREP(HDC3020_THRESH_TEMP_MASK, val);
> > -		val |= (FIELD_GET(HDC3020_THRESH_HUM_MASK, ret) <<
> > -			HDC3020_THRESH_HUM_TRUNC_SHIFT);
> > +		switch (info) {
> > +		case IIO_EV_INFO_VALUE:
> 
> The comment could be dropped. The range is obvious from the constants
> and the values don't mach anymore now that you use MICRO.
>
Yes.
> > +			/* Range is from –40 to 125 degree celsius */
> > +			s_val = max(s_val, HDC3020_MIN_TEMP_MICRO);
> > +			s_val = min(s_val, HDC3020_MAX_TEMP_MICRO);
> > +
> > +			reg = reg_thresh_wr;
> > +			reg_val = hdc3020_thresh_set_temp(s_val, ret);
> > +			break;
> > +		case IIO_EV_INFO_HYSTERESIS:
> > +			/*
> > +			 * Function hdc3020_tresh_get_temp returns temperature
> > +			 * in degree celsius scaled by 65535. Scale by 1000000
> > +			 * to be able to subtract scaled hysteresis value.
> > +			 */
> > +			s_thresh = (s64)hdc3020_tresh_get_temp(ret) * 1000000;
> > +			/*
> > +			 * Units of s_val are in micro degree celsius, scale by
> > +			 * 65535 to get same units as s_thresh.
> > +			 */
> > +			s_val = min(abs(s_val), HDC3020_MAX_TEMP_HYST_MICRO);
> > +			s_hyst = (s64)s_val * 65535;
> > +			/*
> > +			 * Include directions when calculation the clear value,
> > +			 * since hysteresis is unsigned by definition and the
> > +			 * clear value is an absolute value which is signed.
> > +			 */
> > +			if (dir == IIO_EV_DIR_RISING)
> > +				s_clr = s_thresh - s_hyst;
> > +			else
> > +				s_clr = s_thresh + s_hyst;
> > +
> 
> Nit: "Divide". You can avoid such typos by using checkpactch.pl with the
> --codespell option.
> 
Thanks, didn't know that. Will use it for future patches.

> > +			/* Devide by 65535 to get units of micro degree celsius */
> > +			s_val = div_s64(s_clr, 65535);
> > +			ret = hdc3020_read_be16(data, reg_clr_rd);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			reg = reg_clr_wr;
> > +			reg_val = hdc3020_thresh_set_temp(s_val, ret);
> > +			break;
> > +		default:
> > +			return -EOPNOTSUPP;
> > +		}
> >  		break;
> >  	case IIO_HUMIDITYRELATIVE:
> > -		/*
> > -		 * Calculate humidity threshold, shift it down and up to get the
> > -		 * truncated threshold representation in the 7MSBs while keeping
> > -		 * the current temperature threshold in the 9 LSBs.
> > -		 */
> > -		tmp = ((u64)((val * MICRO) + val2)) * 65535ULL;
> > -		tmp = div_u64(tmp, MICRO * 100);
> > -		val = tmp >> HDC3020_THRESH_HUM_TRUNC_SHIFT;
> > -		val = FIELD_PREP(HDC3020_THRESH_HUM_MASK, val);
> > -		val |= FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
> > +		switch (info) {
> > +		case IIO_EV_INFO_VALUE:
> 
> The 100% value does not match the max val anymore. Could be dropped too.
> 
Ok.

> > +			/* Range is from 0 to 100 percent */
> > +			s_val = min(abs(s_val), HDC3020_MAX_HUM_MICRO);
> > +
> > +			reg = reg_thresh_wr;
> > +			reg_val = hdc3020_thresh_set_hum(s_val, ret);
> > +			break;
> > +		case IIO_EV_INFO_HYSTERESIS:
> > +			/*
> > +			 * Function hdc3020_tresh_get_hum returns relative
> > +			 * humidity in percent scaled by 65535. Scale by 1000000
> > +			 * to be able to subtract scaled hysteresis value.
> > +			 */
> > +			s_thresh = (s64)hdc3020_tresh_get_hum(ret) * 1000000;
> > +			/*
> > +			 * Units of s_val are in micro percent, scale by 65535
> > +			 * to get same units as s_thresh.
> > +			 */
> > +			s_val = min(abs(s_val), HDC3020_MAX_HUM_MICRO);
> > +			s_hyst = (s64)s_val * 65535;
> > +			/*
> > +			 * Include directions when calculation the clear value,
> > +			 * since hysteresis is unsigned by definition and the
> > +			 * clear value is an absolute value which is signed.
> > +			 */
> > +			if (dir == IIO_EV_DIR_RISING)
> > +				s_clr = s_thresh - s_hyst;
> > +			else
> > +				s_clr = s_thresh + s_hyst;
> > +
> 
> Nit: "Divide".
>
Ok.

> > +			/* Devide by 65535 to get units of micro degree percent */
> > +			s_val = div_s64(s_clr, 65535);
> > +			ret = hdc3020_read_be16(data, reg_clr_rd);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			reg = reg_clr_wr;
> > +			reg_val = hdc3020_thresh_set_hum(s_val, ret);
> > +			break;
> > +		default:
> > +			return -EOPNOTSUPP;
> > +		}
> >  		break;
> >  	default:
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> >  	put_unaligned_be16(reg, buf);
> > -	put_unaligned_be16(val, buf + 2);
> > +	put_unaligned_be16(reg_val, buf + 2);
> >  	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
> 
> Now that you are working on this function, maybe you could add the
> missing empty line before the return to keep format consistency.
>
Ok.
> >  	return hdc3020_write_bytes(data, buf, 5);
> >  }
> > @@ -447,48 +585,60 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> >  			       int *val, int *val2)
> >  {
> >  	struct hdc3020_data *data = iio_priv(indio_dev);
> > -	u16 reg;
> > -	int ret;
> > +	u16 reg_thresh, reg_clr;
> > +	int thresh, clr, ret;
> >  
> > -	/* Select threshold register */
> > -	if (info == IIO_EV_INFO_VALUE) {
> > -		if (dir == IIO_EV_DIR_RISING)
> > -			reg = HDC3020_R_T_RH_THRESH_HIGH;
> > -		else
> > -			reg = HDC3020_R_T_RH_THRESH_LOW;
> > +	/* Select threshold registers */
> > +	if (dir == IIO_EV_DIR_RISING) {
> > +		reg_thresh = HDC3020_R_T_RH_THRESH_HIGH;
> > +		reg_clr = HDC3020_R_T_RH_THRESH_HIGH_CLR;
> >  	} else {
> > -		if (dir == IIO_EV_DIR_RISING)
> > -			reg = HDC3020_R_T_RH_THRESH_HIGH_CLR;
> > -		else
> > -			reg = HDC3020_R_T_RH_THRESH_LOW_CLR;
> > +		reg_thresh = HDC3020_R_T_RH_THRESH_LOW;
> > +		reg_clr = HDC3020_R_T_RH_THRESH_LOW_CLR;
> >  	}
> >  
> >  	guard(mutex)(&data->lock);
> > -	ret = hdc3020_read_be16(data, reg);
> > +	ret = hdc3020_read_be16(data, reg_thresh);
> >  	if (ret < 0)
> >  		return ret;
> >  
> >  	switch (chan->type) {
> >  	case IIO_TEMP:
> > -		/*
> > -		 * Get the temperature threshold from 9 LSBs, shift them to get
> > -		 * the truncated temperature threshold representation and
> > -		 * calculate the threshold according to the formula in the
> > -		 * datasheet.
> > -		 */
> > -		*val = FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
> > -		*val = *val << HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> > -		*val = -2949075 + (175 * (*val));
> > +		thresh = hdc3020_tresh_get_temp(ret);
> > +		switch (info) {
> > +		case IIO_EV_INFO_VALUE:
> > +			*val = thresh;
> > +			break;
> > +		case IIO_EV_INFO_HYSTERESIS:
> > +			ret = hdc3020_read_be16(data, reg_clr);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			clr = hdc3020_tresh_get_temp(ret);
> > +			*val = abs(thresh - clr);
> > +			break;
> > +		default:
> > +			return -EOPNOTSUPP;
> > +		}
> >  		*val2 = 65535;
> >  		return IIO_VAL_FRACTIONAL;
> >  	case IIO_HUMIDITYRELATIVE:
> > -		/*
> > -		 * Get the humidity threshold from 7 MSBs, shift them to get the
> > -		 * truncated humidity threshold representation and calculate the
> > -		 * threshold according to the formula in the datasheet.
> > -		 */
> > -		*val = FIELD_GET(HDC3020_THRESH_HUM_MASK, ret);
> > -		*val = (*val << HDC3020_THRESH_HUM_TRUNC_SHIFT) * 100;
> > +		thresh = hdc3020_tresh_get_hum(ret);
> > +		switch (info) {
> > +		case IIO_EV_INFO_VALUE:
> > +			*val = thresh;
> > +			break;
> > +		case IIO_EV_INFO_HYSTERESIS:
> > +			ret = hdc3020_read_be16(data, reg_clr);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			clr = hdc3020_tresh_get_hum(ret);
> > +			*val = abs(thresh - clr);
> > +			break;
> > +		default:
> > +			return -EOPNOTSUPP;
> > +		}
> >  		*val2 = 65535;
> >  		return IIO_VAL_FRACTIONAL;
> >  	default:
> 
> 
> Thank you for your patch and best regards,
> Javier Carrasco

Hi Javier,

thanks for reviewing so quickly. Do you think I should correct the clear
threshold values once I changed the threshold. I have an example
provided where I set the threshold and hysteresis. After setting the
threshold again the hysteresis value also changes.

Dimitri

