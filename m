Return-Path: <linux-iio+bounces-14950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFD6A263E0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 20:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FFC166211
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849F1EF099;
	Mon,  3 Feb 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="okSaF/aR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABA1482F2
	for <linux-iio@vger.kernel.org>; Mon,  3 Feb 2025 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611648; cv=none; b=DZepWs/5UDv5dLVG0bMKR4RfHK31FSeEukTz+yv2HvMg72I0jq5gNvOgKiOPLd2WbkkyMzAa7ANIlKxUcGkM6vOY73s9m3CNqi3YMrTmnsws2pAEiaR2pscDf0OHXErgPfi0rrBCono/Ahfz43txgaqzn3Hfg6bQitSsnVPe9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611648; c=relaxed/simple;
	bh=4w5hI182C7EhB0pdVM2nhPdeGiASHD7UyoPbGWvGjIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSL38oHaupUzZqXbCq7yK67oaLluf7Kao0QicJlNLBB0bDR5/szIYAqVHLP5DHMn4nDbffLgUInYdj0Z3XKzCY5RBXnXvoM7YMAbAg2VuroUnUUcaa8qB8vPHdf0fJBJt9Ur+To3M9lvLanYriPuHxUf6cV4GtMGvauc0uLlH1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=okSaF/aR; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ebb4aae80dso2147884b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Feb 2025 11:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738611644; x=1739216444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uBq3XbrrzPz0mKVXuQDtYlXTInCQgyur/dXytapL4E=;
        b=okSaF/aRa1wvAE2zHQCNGL7paMGYWuTveHAxfqOv+Du9H0Yg2kikMImGsGFPrav91t
         +NnhObqDIg7pj1lDx7zF+XPdN/qDz0kxp6Yn9/eTEfW6Tf8C6GfFwDWQ2V0RsQr8D2Ws
         2n9yoX/J3v5FgEEIHy0zs5nLK9yMDGmwTmqrdpl8jd4xEN9ZBo/Q9JS+hgoHh6QNDMcg
         hW+DStHzsXWjgwiNvui3ACKjFkArMGzxnwX0lMv6a+ILu7/5uK6+OYW0OHiNvalO6cOF
         PFxSkb65BJBfr7ZEtHzpzYS4Hjz2Rmwjc0HRFro895a+bEVYyuIdj7aELCXW5JIVZ5/E
         7E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611644; x=1739216444;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uBq3XbrrzPz0mKVXuQDtYlXTInCQgyur/dXytapL4E=;
        b=erPXwyBgcZAhmTexJ/ZVoggHBpS5t01jwPmj/DDAhxU/F9aO+UgAKwl0ijhAjLM4ze
         z2S3z6fpYCCRInVhhBZrHNRHTJxUVovTfNO33cnB6dZxjDmrsWL+NnTpLoiZoHTBwdf6
         ZAhx9yzQjwXjVsVOg9UQJDMajKm5aJ2PajQl2miUoJhaV5xlcJquMoDhB/oF42C7+VBn
         maHDSEM+iwaxE8Vo8DyYEXF/3NaZcrP0YmcbE1SpCDOHEsuJvOudxY02ZeH+Q+yRhia7
         dhaTYd/05lC1w7BhSm0euYDIvMIKlq/m3ikt0aTiPxD+tPYdpDJ8lAnMEqpuXgmHAZyb
         he0g==
X-Forwarded-Encrypted: i=1; AJvYcCXk4RKFTE4xMPhxjI9T3PGhPaiqFSiXr3feRQ2Cfzk+y7zYOrnMAy8JJtbzyjPe5TLadsdUnzNjfMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA0nhGCJ+aptdQ3q9KQ/8AF0ToByxU6bCNuzNVm4qMED1vVkqt
	8g6u0hzLaTc/cRGTUx4LEolAx1onHCCoJ7dEJV5vNSjkTaJ3t//wfDNOc0QGouE=
X-Gm-Gg: ASbGnctFiH8spOmFIN2aPEd9NUzgvZnSR9DyPv/+rLmqz8JlviP78Uji0RwiFfkYsTo
	aYVhpwL9fPnTozs0KNw0xTvWic0/PoRvAQE3DtNc7qErkZI7p6Tz6QVvb/tD6OFgZCRHmPbd+br
	Qb21Eguy/14XYVT+kAn/C/rkZ1v3TwNofZPUTleyP9dXFCgrLD457cjfSw1dftNT0c3fwTSesLx
	yLeBvCDJf5wtbsEF1yUBYW73PO12GaoU4ToA1tInSUtV8Zrwd+TbuoD0xC5791aV7uEr2sLgxpv
	VoBquSZRFwA6HShELQv/OAlPcHheU2G7XTGsxTE4t4xssn56wvFi
X-Google-Smtp-Source: AGHT+IFStWlddd/hN330V2jKOqC9rdF9kDVFIFEz3wnO/4AylHuxPEivSEkFzdJ/qetqDYyi/+6s+A==
X-Received: by 2002:a05:6808:1a06:b0:3ec:d30f:60e3 with SMTP id 5614622812f47-3f323b7318amr17300136b6e.39.1738611644653;
        Mon, 03 Feb 2025 11:40:44 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726618b9f7fsm2907374a34.43.2025.02.03.11.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 11:40:43 -0800 (PST)
Message-ID: <2f71bc82-c2c4-46d0-ae39-abfa4f2e8dc4@baylibre.com>
Date: Mon, 3 Feb 2025 13:40:41 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: ad4130: Add filter_type attributes
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: cosmin.tanislav@analog.com, jic23@kernel.org, lars@metafoo.de,
 granquet@baylibre.com, u.kleine-koenig@baylibre.com,
 marcelo.schmitt1@gmail.com
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
 <77e5eb540e5d425016ea77a641e16cd31a2a761a.1738608986.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <77e5eb540e5d425016ea77a641e16cd31a2a761a.1738608986.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 1:11 PM, Marcelo Schmitt wrote:
> Make filter control also available through filter_type attributes which are
> now standardized in main IIO ABI documentation.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Hi David, I forgot to ask if you wanted it, but I've added a suggested-by tag
> for your advice on v2.

OK with me. :-)

> 
> Thanks,
> Marcelo
> 
>  drivers/iio/adc/ad4130.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index de32cc9d18c5..66097ff65740 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -942,6 +942,9 @@ static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[] = {

I suggest to add a comment here to say that the duplication is intentional and
the filter_mode attributes are for backwards compatibility.

>  	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
>  	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
>  			   &ad4130_filter_mode_enum),
> +	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4130_filter_mode_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
> +			   &ad4130_filter_mode_enum),
>  	{ }
>  };
>  

With that...

Reviewed-by: David Lechner <dlechner@baylibre.com>

