Return-Path: <linux-iio+bounces-21806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B4B0C016
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228EB3A75CD
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A6528B41A;
	Mon, 21 Jul 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HskNqwkz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145E288C8D;
	Mon, 21 Jul 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089705; cv=none; b=FaE4REic6If5PiMUN4y8lqsDkGcUwit4Z1nE8Ec6o2odIt89OT/nYnS0rZImzaSDTwxN6aYive2P9VnlSFp2/qmh96P7u3EDXRwL8gEmCw0M6ay6VciIQA3N+N+R4h6Q8FQe1Zg3Ho1V6Cbq3mTlwfdvQhZ7fwgb0Eup97KZRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089705; c=relaxed/simple;
	bh=+/TElpPdYao+9Rd4FXtjzf7rWIlQdx/KEToLN7xS7hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ric+3FPXP8UEXFpZLiO8wubnbp1nmNuVhY+hnh1njb5eATnjE1Lhjgyl90DBPiHwJ+4zPZxaOxEjJmbimlsAm++C0cuavF5U+ROZPDd+GP3avwswl2wF1xl/zfLYfSbODIlaQbyt9jiQ69zb4HfDqOr5+XHzKEQZSSUl1mHgojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HskNqwkz; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30194d82366so1427187fac.3;
        Mon, 21 Jul 2025 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753089701; x=1753694501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NRLauZhbNLVf4xFZoSDTUJ1/uYBhYsUp8SR1mJmEK3U=;
        b=HskNqwkzxg6T+l71RiB9KT4CLz3InNI1WSLczS2/Oe52p4TvCNuvDqPUb0O88GPvLG
         aApPu5Qom7+K5CvUmqKmT4XyZQL9Z7DTUk2lrRXW0OeVh9OHxl39vrPuyRyDFn8u5dcV
         KsOa0+krwRDzUzIUzGUkqrd+/erumMjUccfuwzgpHrxh/SnycnV1p3OJ+Lac07Rpksq1
         Ri68fR2tdxuQlnsF+tLA1aGvTzPAWGYu8TQwrOCdVpQB5hlhX27WUkyEoB15iPJls8G3
         gdjaPR+CvCNpYkoSHW1+472kovoW4ZHXg6Suo17AWLb0dJQz0S0pRmDGYVvPz0hPlmxZ
         Tw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753089701; x=1753694501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRLauZhbNLVf4xFZoSDTUJ1/uYBhYsUp8SR1mJmEK3U=;
        b=KwKPLSyEL9F5DAys/4mPxWAK9Hs3jIVj0wAiy+QlN2C61lUn+Q8z7Gm5HeLSa90xV9
         lVpPZhJL/gqVHmdJz1IWhYvaw2WMPGjdsAK5TPz6rvU/E2paD1vNKlJn2bqtgacZNHm0
         KAMcjHerCrGwqA24xWnilLJ8bNhisoiQUok/3U2InYQ/sWu5YVnNGK0MvHCfy8P0Vf9s
         e9TG57IUK7773UOoVRnZBvJIkag1cQk5688LugiMz46DGkKhEV76W5I1CjsNU2lOAJKI
         rMmsbu3n3Pe8eMAUbJKZ4szOY9jH8Uoao0+IV0KLr+FCZGDCLlgK3/Bnl1B7hY7omosf
         nibA==
X-Forwarded-Encrypted: i=1; AJvYcCXE4Kn58NxcOoo6GzXEspKgsZRHbqBxcR3Va+C7g082KiymXrQ2g2mZXmx5IB0nJ5OuG5/ZHQnsFjqajJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZVMcF9WPt3IIE6qrbM9Rnw42Ryy5gWrGKvxlaRLf8HGPnGHP
	KcSRxrQyiGb9wzSI24wktW7p9fZ8/T/WabsftB8BQ1wAojTmCYSd3XV8
X-Gm-Gg: ASbGnctjF5ujRvjG4LeOvPA3Ny6nOpAZy1uSJ4zBHyS55/Di5UWQpM5CFw5FXxUHCL9
	XqmBQMYXBkbwUTXgB1GQNi80P7gl5brcCZuVOd1dGyvUNjtFYLP2yJRadiDvb0WOzkl9yP7beap
	x3fS8jBsN3ZXviLWJ70DCc5iv7EaR6p3zPIe2qvwz+OR+AgrFwJnUL0M3C8k4iLKuQjS13j4mDq
	MuPoY8mFyrB6zb7tPr3qJKe1BcXC1IGKrbzz3Q+MjxZrKIX0vm/5JW3D9uMQXhuDByZcAawxGTf
	OhxnmHuyWsyps0HOsZiM9v2FBfe5y/4nQU0Cdg8OmNSYSrGOUZ+FU9A2kdBSZN527ejulcGfg8n
	J0LYrSP2PGPGU
X-Google-Smtp-Source: AGHT+IEGapepDDnCdlBR92F/d8VFfGrS+O6XmCr8qCYQJdXD8+j545fTeV+grwPm6Q2lnpRgIwdoNA==
X-Received: by 2002:a05:6870:8a1e:b0:2c1:ac88:4a8d with SMTP id 586e51a60fabf-2ffb246eec1mr14424447fac.30.1753089701580;
        Mon, 21 Jul 2025 02:21:41 -0700 (PDT)
Received: from nsa ([83.136.182.32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30103d23cdcsm3365279fac.21.2025.07.21.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 02:21:41 -0700 (PDT)
Date: Mon, 21 Jul 2025 10:21:51 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, dan.carpenter@linaro.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	Markus.Elfring@web.de, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/1] iio: adc: ad4170-4: Correctly update filter_fs
 after filter type change
Message-ID: <3rl5w6ydn4pzrflaakx5njft7ojx2anf2c4jpha7zkm2oltuec@4jbc7gis7awr>
References: <1c354ff9f41ff964a66ece44b0d356e0bda3d210.1753024756.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c354ff9f41ff964a66ece44b0d356e0bda3d210.1753024756.git.marcelo.schmitt@analog.com>

On Sun, Jul 20, 2025 at 12:37:24PM -0300, Marcelo Schmitt wrote:
> Previously, the driver was directly using the filter type value to update
> the filter frequency (filter_fs) configuration. That caused the driver to
> switch to the lowest filter_fs configuration (highest sampling frequency)
> on every update to the filter type. Correct the filter_fs collateral update
> by clamping it to the range of supported values instead of mistakenly
> using the filter type to update the filter_fs.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-iio/c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain/
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Fixes: 8ab7434734cd ("iio: adc: ad4170-4: Add digital filter and sample frequency config support")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Hi, this is the same fix as the fix provided in implied v1 patch but with the
> difference of doing it the way Markus suggested in reply to v1.
> I have a slight preference for v1 since that one keeps code contained within
> 80 columns. Though, totally fine with whatever version of the fix gets picked up.
> 
> Change log v1 (implied) -> v2
> - Replaces if by use of ternary operator as suggested by Markus in reply to v1.
> - Fixed commit log typo: colateral -> collateral
> - Fixed commit log typo: clampling -> clamping
> 
> Thanks,
> Marcelo
> 
>  drivers/iio/adc/ad4170-4.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
> index 6cd84d6fb08b..2e61f9a9a1ef 100644
> --- a/drivers/iio/adc/ad4170-4.c
> +++ b/drivers/iio/adc/ad4170-4.c
> @@ -879,12 +879,11 @@ static int ad4170_set_filter_type(struct iio_dev *indio_dev,
>  		if (!iio_device_claim_direct(indio_dev))
>  			return -EBUSY;
>  
> -		if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
> -			setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,
> -						 AD4170_SINC3_MAX_FS);
> -		else
> -			setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
> -						 AD4170_SINC5_MAX_FS);
> +		setup->filter_fs = (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
> +				    ? clamp(setup->filter_fs,
> +					    AD4170_SINC3_MIN_FS, AD4170_SINC3_MAX_FS)
> +				    : clamp(setup->filter_fs,
> +					    AD4170_SINC5_MIN_FS, AD4170_SINC5_MAX_FS);

I very much prefer the approach in v1. To me, this code is just harder
to read...

Reminder to why is a good idea to wait a bit and don't rush into
spinning new versions. Also, Markus has a very proven record of not
being helpful at all in reviews (just look in lore :))

With that:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

- Nuno Sá

>  
>  		setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
>  		setup->filter |= FIELD_PREP(AD4170_FILTER_FILTER_TYPE_MSK,
> 
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> -- 
> 2.47.2
> 

