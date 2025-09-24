Return-Path: <linux-iio+bounces-24407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B1B99FFA
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 15:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E3B2A0204
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5732E11A6;
	Wed, 24 Sep 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xF6sm1Vj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136DC20110B
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719848; cv=none; b=CUUO+5kof2HXg6FlZGLYylw2gaLGKetx1B9mGZVqakqbo34qosugXC2lNUIq8nQWV3RbYMB5JCZWNtIlJg/dfDGB/Oxl15FQWagor4qO/wN6jSHZ79Kge7PvH6WkZCPn1BVnMODTozbar5Ol7+v0v/xUqF/Q2kHudzPph9rk3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719848; c=relaxed/simple;
	bh=nNlhZ3ky71IFd+n9wOyeaZgybeewKfw/SvYwsc4rOOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTsYU7YSa6DPaaaPbotid8gYIaycLP3NhJx9FAiLzMyedxPpliqJ/x9atFygPPd+6JkKmNreKN3ngXPyp1CSIhEqtDuuvKM+Y8OA1Jw1/XDveIKm7qveXXrbk6mOKfZJ4suuRTLeJVpqhlWnQlhY8qntsSPmSmigziCCw3US9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xF6sm1Vj; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-63136d0958bso752040eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758719844; x=1759324644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfzpwQgTHBHYqzRqbLUeQn97RlK5vix1IohjUgnZb8Q=;
        b=xF6sm1VjFVBtynlSmllYUAtJqUECS0e+rseikvsdgU2AgGLBUqlyjYn09J432Iwo5Y
         7fKfZguYR9lJ44G5TP9pew8fHVtORer6osKsKz0BXC6uUWb4O4EqNxnc4Se1tQRwxPJ/
         ClY9aK3PNYcLeg3sQqX+65jdkeSho+d/oAUp9ISRTxOo0UZxeckFym7dCcNTGCycZqdC
         qkqzp2j9xihzqbDgqPANdDJ28Kisa2UPJ1MXL3p0mxPGp0RF2OgIhyNakqRYpkiwUlRq
         B1//4aTTq3B3afAGyvCG1tmLTTqKs0RUpJtomFBWHH5l4pcaAT5kmxwUsNoEE690l55R
         mISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719844; x=1759324644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfzpwQgTHBHYqzRqbLUeQn97RlK5vix1IohjUgnZb8Q=;
        b=o5jxtOjmh8yc7JekVuaiDvoyDr0BOGqeHxEjkcYqiVFSVnmpjJqUaE72U6dvLHXiUM
         G4hm6BKUjaeceHf0JFrPfn8QGEs2KcYim8aOG1+1dD0AQp+K+1YHiitfPhRXdYZGkUU6
         FCTEVcUAdUrTKxFxTm8F1reEMXXVR61xyRbb8XX8ZeT9TWNq9JOq/EmRhAikHLtst1xG
         fCnFPh9rQLSoV7XeUs3N2llTBG7q3XRUsF9UK9aCVlYMeT8DmVkpw4jGo+5po7OG6K6J
         hqbMa06Sko8UVF8zpK8H34nMalR5waSpezLfosZ/mF/1ShCjniIVWLdhA6k0pBQTlnAg
         CdiA==
X-Forwarded-Encrypted: i=1; AJvYcCWpMSuiRDuepeIPhLKqD/xBkrxo3Ra9xGdqqkBWV+mrW72ijH9jCnjCZaT7xNKZzvy8PxfKJuJktzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxptax88CCp+MNf1TExQAGYnl+69GQikHpic63hma8p023N8GqC
	P8B/x9AmRH8IB3OSE8a+beYrADgzoluhgRlt4siljV7xj+IaVlMooHfpdyXRyPKepoA=
X-Gm-Gg: ASbGncsMle0dZVMHAhPXELLX6evzKDA2dReJp6Lcy8bFQKtUdePLWnnPN7WfStGP1DA
	qyXzdTjKsMy6b3Wt41J9dO4DarX077G4sAiWRn6QJlnhKfLOVuDtKXI216MT1XbPgc0f2wDGOBR
	h84NamwAeUuLhk0f8bAq2pifk5VwwKR+ewK5FWwK94N486D4vgMa1pzMlBSiaJ1gvH/pLMY9Q4Q
	hQmwCJlbCJO2LB3xPpVy/IBn81DvfQtmc4l8AmFQLPEkotWIXtoFmO880Of1A1SuSZTz9DOgUxF
	uA/B7LCU9iufv1tyjob/XSqLt9xXJQPh+8+PWv469ViFIINPdgbJqqDGI+QcJyJn0jnY7OgbY5X
	JtiSJA8KTiVskr7+MGhHssqOtatpAeL34YhLypIrTPT1mLq+6ce+pPNv6rJ9r5wHClf6Ho/r5
X-Google-Smtp-Source: AGHT+IHOZBg2Ew5oG8YZerk3MsMqJ2CIE1Jt5C4KrJR+KD/B3ZokyeWrlgJ+mwKYC9r19TWwcYEPcg==
X-Received: by 2002:a05:6808:444c:b0:43f:163b:88d with SMTP id 5614622812f47-43f2d2dbd80mr3060029b6e.18.1758719844018;
        Wed, 24 Sep 2025 06:17:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5b03:6cc2:9ec:21f2? ([2600:8803:e7e4:1d00:5b03:6cc2:9ec:21f2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-344ccf031c7sm3446523fac.24.2025.09.24.06.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:17:23 -0700 (PDT)
Message-ID: <9e20ce95-a401-46ca-94aa-bd4488b45025@baylibre.com>
Date: Wed, 24 Sep 2025 08:17:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
 <h2rof27omrhv4l6pjisdsnvkpb35ovy7e6m4soeltfun5rafk5@oriv7e3egh3p>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <h2rof27omrhv4l6pjisdsnvkpb35ovy7e6m4soeltfun5rafk5@oriv7e3egh3p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/24/25 6:03 AM, Uwe Kleine-König wrote:
> Hello David,
> 
> On Tue, Sep 23, 2025 at 03:18:02PM -0500, David Lechner wrote:
>> Fix temperature channel not working due to gain and offset not being
>> initialized. This was causing the raw temperature readings to be always
>> 8388608 (0x800000).
>>
>> To fix it, we just make sure the gain and offset values are set to the
>> default values and still return early without doing an internal
>> calibration.
>>
>> While here, add a comment explaining why we don't bother calibrating
>> the temperature channel.
>>
>> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/iio/adc/ad7124.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
>> index 374e39736584f55c1290db3e257dff2c60f884d2..94d90a63987c0f9886586db0c4bc1690855be2c1 100644
>> --- a/drivers/iio/adc/ad7124.c
>> +++ b/drivers/iio/adc/ad7124.c
>> @@ -1518,10 +1518,6 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
>>  	int ret, i;
>>  
>>  	for (i = 0; i < st->num_channels; i++) {
>> -
>> -		if (indio_dev->channels[i].type != IIO_VOLTAGE)
>> -			continue;
>> -
>>  		/*
>>  		 * For calibration the OFFSET register should hold its reset default
>>  		 * value. For the GAIN register there is no such requirement but
>> @@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
>>  		st->channels[i].cfg.calibration_offset = 0x800000;
>>  		st->channels[i].cfg.calibration_gain = st->gain_default;
>>  
>> +		/*
>> +		 * Only the main voltage input channels are important enough
>> +		 * to be automatically calibrated here.
>> +		 */
>> +		if (indio_dev->channels[i].type != IIO_VOLTAGE)
>> +			continue;
>> +
> 
> I don't understand a detail of the problem. The commit log suggests that
> there is a general problem, but looking at the patch I suspect there is
> only a problem if at probe time the OFFSET and GAIN register for the
> temperature channel are different from their reset default setting.

What I failed to mention is that st->channels[i].cfg.calibration_offset
and st->channels[i].cfg.calibration_gain are zero-initialized. And that
these values are later programmed into the ADC. Programming these to
zero is what caused reading the raw value value to always return a fixed
value because the real value got multiplied by 0 in the ADC.

Is that enough to clear it up?

> 
> I think the patch is fine, but if my understanding is right the commit
> log is more dramatic than the issue really is, as it needs some fiddling
> with the ADC's registers between poweron and driver loading to trigger.
> 
> Best regards
> Uwe


