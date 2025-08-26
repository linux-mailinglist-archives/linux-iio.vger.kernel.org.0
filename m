Return-Path: <linux-iio+bounces-23307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB972B370BF
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5DC1BA0E49
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E922D47FA;
	Tue, 26 Aug 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B8CqnLlo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF52D3A72
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227120; cv=none; b=hTb/n86NRmQCJX2MfMXGS8Vp8ScsaXulthL85qIikfnZR3k8uhoD5+0nrClsaO5Bx6vrTtLxblFILBZhDzTHYk/k9p3c6pjaV939oNyovz86belMxT6eMYpXePrilpM6kmrduykeFq9vA0yQlUigGHNuhk1/GaChWHBjPpav958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227120; c=relaxed/simple;
	bh=NUcZKV8df5rig7NX6M4s/xJBeet4lgy0T5VRXlEbfXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjnO3KHgE1WJonD75W1c1NBKPgtf0KvZrzngZg/cFF9BL+S/HCkdzP2kEFvE9dE7spkQrdxxA8krHQtPwsSdN62X1Xi40P8Q8aJj0DVnbM5ZsijhrwfOTgSfsygqsFhuKY9r3az/TkyWWQcMlp1LVCdZHB6kyXXKobBPb8ElYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B8CqnLlo; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381df387fso1550587a34.0
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756227117; x=1756831917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkmnRAVuaMi37w1JYDjop35pm7ZANUoykRDCIFcP0Zw=;
        b=B8CqnLlogYZHRFxpmA2vz3GIzwgR+KFVIIgCkIXvMo2ZBiEHl4ytjNljmI1TOf78gs
         KJp791oogBdSSSkW84wbRgVb4I2sEuZTFH2i1XnN8USAfs5b1rNv8rA7+8MNmcmXmrM6
         ybPLzhBxPSKEHa536EuDTBJvh4q7M7arAvBnkwtkuC3EdZYfsFhPanw3rvlx7tpvt9Wh
         +N2mNULHKjM5zlB0Qgp7Kscq0/ZCmmJ4iOntXD0ProGLIQOex4g9iKFm0B0Yz+1aHwfR
         A3c2t/xdJqh38APkVy5Mzk1Cs6mvwbxVXWsMpTj48EQMcFO1jZ6Hiw8TjBwprBIJmeYV
         YhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227117; x=1756831917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkmnRAVuaMi37w1JYDjop35pm7ZANUoykRDCIFcP0Zw=;
        b=qq4vBe5bFikg8PLq/8hVD9utsEn/RneGRjL6wlXIu/Kn5mNiskSEz2pbrFfrUn6oEk
         PCE8CJx/qKQHlLnDqsaPm2Lxf7LORDx0Qr1PJ9ViV5zubPnj8/zwW9i1r72F0tccQbaS
         L83FwcZIHLcKw8qKnEp8jc1pmOrMIuxNxfrMfEmIL1qNF6sIDl1OoBNg9xnhOTyhZYZv
         NSIejBPVZTILvcIHOibXp6STC9nkFoCAR3OimjrCW/SJclhLYKVfW/Al1rNLT//7NtIS
         Vus815kN2SLoKjjSMdVgTPC3m80q865jzudXlsf93M/ZYUVB+nDLRFDA+mJxIwWJPS7c
         yAig==
X-Gm-Message-State: AOJu0Yyz+dEks4OY5QBy6LJfPgUIQBiaZsQVld17ZXnwOg5KRblkTB2k
	+uzf9reR48/Ae98fpOI2FM66ZbZ5gzsj4GqAMXBXrCD0AT/mFlw9TtfS4In25C34kWg=
X-Gm-Gg: ASbGnctQNt6NY4mlCYWEA74K3en5BGAd0H+UaSRFMYXq0wRwRHq/tQrsRiC5V2Q1Isq
	VCpwr3RkS5qGsTTqPoC6Oo+FO1G7NwNIysTOYbTNJcg//YNzVyS9EGGGvDYh6yIH9hEmomVb5Q9
	LB7mwOBu2lSG4gJcN8+92ABbXwwkeixSEna/2NA/W7eQWEH3QVwo8OtF5P+PXsQpKNCC+S2qLod
	yA5xRjSjXm+/Zq3D/1r4eXRbZCYCeaGjoRZ4lP9qLewdU28lilyiehgUUqzPhZp35OMcvX9fJy7
	U+Ntc+3ESix0FVOTW3vT7f1bM4jyJdAWusvUprCPr5gfd9aHZogQlrfsAoJhpCOXdHpZK0l2YTW
	2drxlGhQ9El1zxTcVgCYUa6mCBCA5HiPdS+hMYGQxj0/O57GWEp32akmSazV5S+imKAoerAhekp
	0aQNchPmiwgw==
X-Google-Smtp-Source: AGHT+IHxBXhPEJybl7P4HEPGX9JTSlL5MLKukYLeM1w9n0qe26Izv4pejXieqDxLJKKZZHQT0HdNNA==
X-Received: by 2002:a05:6808:f16:b0:409:f8e:72a7 with SMTP id 5614622812f47-4378527a910mr6487426b6e.33.1756227117171;
        Tue, 26 Aug 2025 09:51:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7a2dbffsm2514682fac.13.2025.08.26.09.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:51:56 -0700 (PDT)
Message-ID: <0f515c35-b2ac-4d23-b8bb-77151ed2eb9f@baylibre.com>
Date: Tue, 26 Aug 2025 11:51:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] iio: ad4080: Rework filter_type "none" logic
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
 <20250825-mcp9600-iir-v7-5-2ba676a52589@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250825-mcp9600-iir-v7-5-2ba676a52589@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 7:10 PM, Ben Collins wrote:
> The filter_type logic for "none" needed to be reworked to be more
> general.
> 
> As documented, return IIO_VAL_EMPTY for sampling rates in "none" type
> and EINVAL when there's an attempt to write a rate for "none" type.

This patch breaks usespace, which is something we always must avoid.

> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> ---
>  drivers/iio/adc/ad4080.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 6e61787ed3213fe4332bd92b938a7a717dada99f..c7408b9703731ee5d4229a85ffa91ea64b233cd9 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -154,8 +154,6 @@ static const int ad4080_dec_rate_avail[] = {
>  	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
>  };
>  
> -static const int ad4080_dec_rate_none[] = { 1 };
> -
>  static const char * const ad4080_power_supplies[] = {
>  	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
>  };
> @@ -268,13 +266,13 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
>  			*val = st->clk_rate;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		if (st->filter_type == FILTER_NONE) {
> -			*val = 1;
> -		} else {
> -			*val = ad4080_get_dec_rate(indio_dev, chan);
> -			if (*val < 0)
> -				return *val;
> -		}
> +		if (st->filter_type == FILTER_NONE)
> +			return IIO_VAL_EMPTY;
> +
> +		*val = ad4080_get_dec_rate(indio_dev, chan);
> +		if (*val < 0)
> +			return *val;
> +
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -289,7 +287,7 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		if (st->filter_type == FILTER_NONE && val > 1)
> +		if (st->filter_type == FILTER_NONE)
>  			return -EINVAL;
>  
>  		return ad4080_set_dec_rate(indio_dev, chan, val);
> @@ -376,17 +374,16 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (st->filter_type) {
>  		case FILTER_NONE:
> -			*vals = ad4080_dec_rate_none;
> -			*length = ARRAY_SIZE(ad4080_dec_rate_none);
> +			*type = IIO_VAL_EMPTY;
>  			break;
>  		default:
>  			*vals = ad4080_dec_rate_avail;
>  			*length = st->filter_type >= SINC_5 ?
>  				  (ARRAY_SIZE(ad4080_dec_rate_avail) - 2) :
>  				  ARRAY_SIZE(ad4080_dec_rate_avail);
> +			*type = IIO_VAL_INT;
>  			break;
>  		}
> -		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
> 

Returning a value of 1 for the oversampling ratio when there is no
oversampling going on is perfectly reasonable and mathematically correct.
So I don't consider this change an improvement.

