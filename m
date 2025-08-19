Return-Path: <linux-iio+bounces-22985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87335B2C6C6
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 16:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC595629B1
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78169243374;
	Tue, 19 Aug 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BiFzRXsl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461E2356BA
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612784; cv=none; b=ljEOkXPq03c46QWAQfdYfI5+qEPu7fJLAcvpt6sY/l77Lu0KPPEqXHi1TzfyDImGb6/oAPUJ0y+Vi+6DJfJtddLA6QdiW4yl/lO+lX+KfgnCsmFv2IEPIUPMKheMG2MJRx+9/E/1afPx9C8iGPwpxZAL92X6mODVlx6KgN8dvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612784; c=relaxed/simple;
	bh=tcvLkDZhSYdC1JNpLYire5yRg2GM/bnYtQffZEEQXGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M9eXsW6oqxC58dytJIyDiLRfSJC3HrW/r++esDQsHJoO5QWX4qPWE/UOtpIIEPbONnhFG8jr/Mog65a/o17Cst1UO0wmae+YHBrIKEiesIUSbxLAoERxuhyzQLZvp0LfW/2doTSbC1qziV8DYu770fshWXjefaPORqnDw8lhgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BiFzRXsl; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381dd4c61so2600473a34.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755612781; x=1756217581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sC03Vtb6Z+xfVGAeKON3EIuIsQUVP+6HYJOuJwwhIu4=;
        b=BiFzRXslk+oMevMPklgoSW2wLsL701J0bKGiYZSBzLwnq3xWA5RLN1utN07NVrURVC
         dP2+9qW/o7fhtgBLKBLlTJXXxRhtRfzahGxDwwiHF1k5xeIJxVNWKX/ztz61R1kSFxbJ
         mBp1HwofUuMQtwSDtTx/iMlmTrIuRfoHONBKRu/dFQ4X9AlekdzFy0i4o3ngvAC0l2d0
         qsb6jmspKoZ674tZ14ki+U9lCbjc9lp0CwWbJTDIjJiPhOtbMI11a6Hj+AarhUHsaLke
         jgqbCnwis83tR6giwQF7ILcX+/yfQ1XIBj+g8f8oVn+DxPZMdyb5DAFlUHI+ziub33gg
         zoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612781; x=1756217581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sC03Vtb6Z+xfVGAeKON3EIuIsQUVP+6HYJOuJwwhIu4=;
        b=k2Zk1ELlNdEwGyTF7BDSularRjT9kPflOkOf/hCn1CfHOfMOZOi6UM3w6AkpThiMAw
         p8qrfCiiS9B8rXsGTSL1vnvciVifXnR15uFIhEKHJLetawMDsdWrdGtuEdDGBiFV2DzU
         PSGWcETHZFwV4XeFRcGbRLuK+MLVcq0P8O/iP79GdJweN33NkQoJ3VvS6josXKXXNODl
         TcD7ypH3HVwuc9k0wsqTctVC30w2pJqVaF6jSKnI4Ub/jLZbJ9hF0FR6Mk41pL69mBvk
         JcUnVHlJWx99LKxeU9jJWBdiepj12Najkh6L71WG5qa7CriDb46tuvIRd+gOgwShGcpW
         WffA==
X-Forwarded-Encrypted: i=1; AJvYcCUZdPoxS0jlY8YYuU1hlcymWPHRo1dQS38UNFWFgXIjxoYf3TJDFvk36mAkmVGX2735TZjfBpIknkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvNPO40XqesWp8k+wZl8xZAwA4RYIxm7xoTurNtchlNbOqvy4
	N18ezS6uWfQHf2RN3llV0asCOYrUQ/6x+OVYry8h+z7Ygn9eWG8jq4wQdWr7RdQ2RXw=
X-Gm-Gg: ASbGnctSkHn/vEDXdAAT6JpLXjxkVNRDOsujCExplGRkhcVTp3aMbwurREYUXrkTaRU
	Ssv62NENWc3agfVs9PAix1PvEw6kmtS3b6PIDmHo+XbEevX5d4owjmWZdgzKnRv1v2ZVwHmF6wn
	8mYf42yT8Zd8q6Hg7GGD3HIxofHRWIDyBhFsHR7Bel/NQhNf03iPy/B+KDZA+1+xtmg14uqblDV
	+3Gn+Zlp5aRjyJyzQF33r1O4NN5KadK4Q5DfoP2OtWwUK04kCCfymN24S2K1fbHB8zqfItpIYhZ
	qIo8tlxfD8a4nthu+X/TCaCkivaRRgy3+AlEljwpLSPC0LVWUEuoOwIe5oJxhzucefAjApGZge+
	YVIX8QZLY5a0mj4oyUe8ae4oBg3uww29Y5Z04I+wcSsM1vvkS0R+wE94dJQicUE4vsvxsnDF/rM
	Q=
X-Google-Smtp-Source: AGHT+IE/mtp9q8E9onSsRDxS37DeKqaFV5tEDirGChhOYgu4v9D31FyRKTaNPgh6rP0QWQ29DpP8GA==
X-Received: by 2002:a05:6870:1f07:b0:2f3:e087:678d with SMTP id 586e51a60fabf-3110c0629c2mr1810405fac.11.1755612780668;
        Tue, 19 Aug 2025 07:13:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203bd13sm2416648a34.24.2025.08.19.07.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:13:00 -0700 (PDT)
Message-ID: <6b915b3a-8e6d-485a-9050-474bce154fec@baylibre.com>
Date: Tue, 19 Aug 2025 09:12:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: iio: adc: ad7816: Use spi_set_drvdata() for
 clarity
To: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <aKRigf3TtH-x-i1C@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aKRigf3TtH-x-i1C@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 6:39 AM, Salah Triki wrote:
> Replace the use of `dev_set_drvdata()` with the `spi_set_drvdata()`
> helper. This is functionally identical, but improves readability.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 4774df778de9..599f75103cb0 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -360,7 +360,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		return -ENOMEM;
>  	chip = iio_priv(indio_dev);
>  	/* this is only used for device removal purposes */

This comment is no longer true. The driver does not have a .remove
callback. So we can just remove the comment and the dev_set_drvdata().

> -	dev_set_drvdata(&spi_dev->dev, indio_dev);
> +	spi_set_drvdata(spi_dev, indio_dev);
>  
>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)


