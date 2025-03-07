Return-Path: <linux-iio+bounces-16536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A729A56B7B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 16:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637F03A7AFE
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06F221544;
	Fri,  7 Mar 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciNWFTMf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D221CC54;
	Fri,  7 Mar 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360293; cv=none; b=LOgVQ32THdTdiJW/X4VGaMC5d4eIDIQeqVMZT1Ia2DKuZu8SdHbGELnQcvxguQ59iQXu/eXk5y6d85cg542vdlikPCnH1vqNqylxn/BgC87ETtWuxjtJJe5VF4OnTu2sVo9DKtw+uik4nzZlSYC3BbaDdQVRJZDIkXcnN59Al0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360293; c=relaxed/simple;
	bh=68PYA1EofC70Yl9+ZYYWiPFB1L+1AgWZwF/BIm3DqIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMBNZdcvACGz2G4QCj9iaRDdP6LHQdCCifI7hrSJ9BvIf063Eqsm8A5XJ3B0K0snXeFL7/8NxGenHCe0G/HiuBRbpII+MPadfSo2FsmddjzkvxJyTFgxnrzlOJxhpbPZvMswXGtMXZ2sTWSEMy7xrmCUedySl1C5xUumE+NeIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciNWFTMf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fb0f619dso40036225ad.1;
        Fri, 07 Mar 2025 07:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741360291; x=1741965091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z0smMQNuibFTABZ6w1NkSzGMBPcRi3Tk4bDjmrxiWek=;
        b=ciNWFTMfK2AKyH+0KifL7CKVCX0AOjNUra7V5iruX44CeXaqGlUPq3fkJAVnSyOA8m
         I+NgdZEw0E46Bc9fPDpwzUPoWIXXlrRY4KmrDM10uUGEu9WnChZ5BfpDPzdQwTwsrcLC
         k/NdbAyciEF8dZtxC8r1txZyy3b2OvqxukNdYcwhstgfYHO4iEbOmz6FTL+l+17dwzZq
         dQJDwBrcEmE8tOSxmp0GWbuha3RjdfhrqcGHqj7KocALAPr8PtCFUrNKHIgrIC0A4rfA
         twTnXR3ZP23GrlXs6tGULCLNUOGq5Aks/rFaWcuymNdlahsB9a90q/2A3hZT9SX1amZW
         d1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360291; x=1741965091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0smMQNuibFTABZ6w1NkSzGMBPcRi3Tk4bDjmrxiWek=;
        b=Xb6hffvZ1QyA+qKTAc2qOLRF7JLC5WKPzKUNdtysi2ZX5iZf5CX1m/kh7kgEoEqQFU
         i1LHRjlMhMny60uiwwERqgTV8Pt3Cm3TkIRQHaml2rmHkzduqCH9IhdkvzI8qS1F9Dcn
         vvbFyGKY3AUiX8csyh3EadxUkxNyzsfJ31ZumiGYcht4ma0V60XzLPYf8ZcCnVd6E04g
         q279iJM52CUqhlL92++JnbgDG1xPuyUkYPtGk2yUd72jxVYPLS6qw74xyQ5asydIJkjS
         kMuWyn/kTvR7aj25IPUxtv5gJGWC3pmUV/FTrE49bOVjOuUGjSsKWT1ng/5qcD4svVzb
         huZw==
X-Forwarded-Encrypted: i=1; AJvYcCVmlcUEPD/ZMEk83fNT7FGZN7P6XnF7uqRI2tNNkuvfnroBgSKXQ7NXwhrnU7X4lEwleNJTBGkh7Aj1@vger.kernel.org, AJvYcCVnxH9bTPmYVyohiNUwzt952JA9uDGOB19ccv/hSkV31Hbpgk4cXZtG4oa5xJjdB26NGm+ZG2DbCSV8hUXs@vger.kernel.org, AJvYcCWf0B7OyzIqFtST1Q9PP8HTj2T93smDfCNl5E1j9PDvf4T3BVEYdkXZs3w32OyvJpSYIdneq6nNg/9xpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KOJk4hJ3pAb5EGRsFqKRuj25lujdsEHqSsa6S+Q1XIgvEnad
	KR/feZpFwltS//BcHWuT/CISWTgo0oH4CSWdNXUE6BoM9DRzcxRz
X-Gm-Gg: ASbGncuusJ7qpIvKdwAtkehJ9Aeq+an1euwAZn5eDNzHr2ynpXbnoH6oKkCWhJP17iK
	d00NbLp1qN7ToZ1yXSkLjDznXGdL2UaS1P5Z+Vcx1w31kW/8iBuVGwuJSRVSxqvwN/gQEnntpI/
	2LGtRVQcB2FzTMJLGJhCzpdHqn4HP6A9H0gPTHhcM/STWKzVyprBniC4ZYRWtN+KwZeeLDNgP+n
	qtAlwTakpHeeHFTa3ycLCwvzwQiGR9qkTT1hUjUuz7a+Uv8+PYOj8J8HS0sCqB8eNy1NLDxHmju
	oBR5tr1ipT/Tx/DVQTYmDoCTArmZo+tvdUZzp6O4QnSeZPlcF9KA3g==
X-Google-Smtp-Source: AGHT+IHrwpXL0L5f6em3IgAisRt8eToY4WUgHZ+JzvFiYSU/OoqGtox7zmG/M0KzUZdedDUwYqS0Jw==
X-Received: by 2002:a17:903:32ce:b0:224:1074:63af with SMTP id d9443c01a7336-22428bdb76amr63670315ad.34.1741360290644;
        Fri, 07 Mar 2025 07:11:30 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a907adsm31000575ad.160.2025.03.07.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:11:29 -0800 (PST)
Date: Fri, 7 Mar 2025 12:12:22 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
	dlechner@baylibre.com, jonath4nns@gmail.com
Subject: Re: [PATCH v4 17/17] iio: adc: ad7768-1: add low pass -3dB cutoff
 attribute
Message-ID: <Z8sM1uW7pxJVmVN6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <2aa347a97e7ea974951609b0bdf81cad0b21b993.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aa347a97e7ea974951609b0bdf81cad0b21b993.1741268122.git.Jonathan.Santos@analog.com>

Looks good. Minor comment inline.

On 03/06, Jonathan Santos wrote:
> Ad7768-1 has a different -3db frequency multiplier depending on
> the filter type configured. The cutoff frequency also varies according
> to the current ODR.
> 
> Add a readonly low pass -3dB frequency cutoff attribute to clarify to
> the user which bandwidth is being allowed depending on the filter
> configurations.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> v4 Changes:
> * None
> 
> v3 Changes:
> * None
> 
> v2 Changes:
> * New patch in v2.
> ---
>  drivers/iio/adc/ad7768-1.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 664d0b535340..9ba00e9089bd 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -150,6 +150,17 @@ enum ad7768_scan_type {
>  	AD7768_SCAN_TYPE_HIGH_SPEED,
>  };
>  
> +/*
> + * -3dB cutoff frequency multipliers (relative to ODR) for
> + * each filter type. Values are multiplied by 1000.
> + */
> +static const int ad7768_filter_3db_odr_multiplier[] = {
> +	[AD7768_FILTER_SINC5] = 204,
> +	[AD7768_FILTER_SINC3] = 261,
> +	[AD7768_FILTER_SINC3_REJ60] = 261,

Are these constants from ADAQ7768-1 datasheet?
There it says "the sinc3 filter has a −3 dB bandwidth of 0.2617 × ODR."
If so, maybe use 262 as SINC3 multiplier?

> +	[AD7768_FILTER_WIDEBAND] = 433,
> +};
> +
>  static const int ad7768_mclk_div_rates[4] = {
>  	16, 8, 4, 2,
>  };
> @@ -228,7 +239,8 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  		.type = IIO_VOLTAGE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> -					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> @@ -762,7 +774,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  	const struct iio_scan_type *scan_type;
> -	int scale_uv, ret;
> +	int scale_uv, ret, temp;
>  
>  	scan_type = iio_get_current_scan_type(indio_dev, chan);
>  	if (IS_ERR(scan_type))
> @@ -802,6 +814,12 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = st->oversampling_ratio;
>  
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		temp = st->samp_freq * ad7768_filter_3db_odr_multiplier[st->filter_type];
> +		*val = DIV_ROUND_CLOSEST(temp, 1000);
> +
>  		return IIO_VAL_INT;
>  	}
>  
> -- 
> 2.34.1
> 

