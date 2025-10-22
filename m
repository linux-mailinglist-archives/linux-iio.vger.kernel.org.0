Return-Path: <linux-iio+bounces-25353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC78BFD7DC
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5173AC3B8
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7DA1C4A24;
	Wed, 22 Oct 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mJP9SujQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D035B156
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152401; cv=none; b=rQTTaV3MTf2PknWfEVbg/LqYF0n1dbwaZuzgNks+3bdGGSDPdCslakX8t/b7asZUQn6DfzcBjztEsimp83qOPplA5tAQ3wvZasFMlJDNSKizCYRkRkSZsQnv6tC4SNMYynLSDwyO6yFKUe0S4K2aJYB16Rp1WkQriom1dJ+DpVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152401; c=relaxed/simple;
	bh=tg3+sV6cIbsxOjpGV0ypP+7yV6rtvMxzpP/xjjXMSBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g13D/jhY0zP/z3R8fjnM6E4i8pRAg0DTRPK+N9P9WVFphCyMNviTcd+0+s/W0Uws7bfuBge7oyB2hmiYWbXE9MFZ+TPvUaPDY0NCpNluD6poKfB/ufCblylEs7/qnrJWuXhd8pKGeGvTqnUkYSft2U1lhESBf3YmdGpjZ+lAj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mJP9SujQ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-35ba7c71bfdso2410288fac.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761152398; x=1761757198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MocBUHP0H4U2F0hQ0me7gqNWaKXOLx5jISmorrxl84=;
        b=mJP9SujQCiVRtLuLwAGnfVpxeSS4XvyL3IoBKqyd54ovtWsmOoKnLrQ8RWl3FFvV2G
         VHW28TtvO1KsCIdvrhpHDhVbJmimYlCgSCoEKJyBz7p1mPq1+sL7i67m/AzYyYCcl+Px
         F0Hrdzd3DsmlOOTS6+a5UgUpb9ssV/2N+xAKYNhyZIC3J9j8EuxnoRY+gl8Zm1wEL+7V
         cd8QdhIxCo3uqfXuWn+D2LklXfapnnywghD3asWrgEiRxxYZAl7/BJCghws/KenqDK0v
         0t1jCv7v4nX2vFWjlMsfa+dQyv2mGCAv4R8gXIYY7j6klmpiAmPL0bjzPJsQDSVwuQmM
         ZaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152398; x=1761757198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MocBUHP0H4U2F0hQ0me7gqNWaKXOLx5jISmorrxl84=;
        b=o79fTlS2hSTZdWkSFMsHTOqrT+pnXMHKVDUQCAwbx1Ep3ZFDMXCJCVhtB0DmQB0cG4
         nbwtVBu3bHtC/oWAhCKpVUlVf5Lz7yTrvcyHnn1rewW8cDY3gS/AtdM8rDmshxOegMOj
         pQkWOeTSbugSCFKK6SFNbDSf61I1SFE2r47s0ht5PRyRVbZWT1hLIAyOsPBu2x13xiNd
         dmW48KGL309ccA/cNLYMMv4PItZS3hAdoixk2mYWRGoszw/HeCR2tKtj8Q3WSwFsC+Yj
         MVrO5yUdsl5i0dC9l9GdTv2alZfVoIN/SO3gS6Zy4F/WOz4hGINP/UZ4SLYIHsVSM1+7
         Yddg==
X-Forwarded-Encrypted: i=1; AJvYcCXX9OVV9Mf5qyQTuKK8/Ji1hKFVD6JzfPqRkI6Kbqi2dlMZVxZsKEGRcFgZmQ0eO9nPFj4mBPIRWLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VZhCC3UnqtUkzNv+wbJX6i0SZiZYG1wPEXgWXnbGUkaKrYmj
	AnAcGwtaNKgxKWyZ2mdJG6bTiDDeZQM4JBVvLGKjD8NmFY9YWpIpJRl73BkwJF1LOSM=
X-Gm-Gg: ASbGncu+f8O0p94Wv2jqHltoTDvvGtdQH0gjIlr3BSeI5+TGw8HmB1xznHj1de67ZX8
	591g/m85Vrz7euhK6ockPVeD5m3felpJZv42Jm5rqHeBHe5BenK7jpILlXjhK2qyCK/UX+quY9I
	zLWpySFfOzLvFbvnqciJli8z+xg2kvI3E/IwytW5gADOt2yP/ujzk50b/aobKaz4xEtRl9W6i8k
	FlRSwDnrlWHvsWsv0GdBclOcdj9esn35q2DWA3E5vw3Y1PaDZSFW3Lprs7YadY/tBuur3kg6kxM
	XAb2dUlDsIapDbEeQbDLoeWFrvSlZUDAaFViMWgL5JmjVNILpIbcxqmRlhv9n2LkZENTKApv8ix
	gmOTpc4N/xvVTaHa/GksC2ZJWULIXcAz4T9tPQT/mA0kNHDoSz2us/DHRuFN2glw09P2SPFYT6S
	tSoYFEqXPkF1z2EaMrqd3jA6JB1T0WlBJ/oSAl8G7cJ1faIXvSaLnrho8BCpDA
X-Google-Smtp-Source: AGHT+IGmTiETk7edY0S6+L/36Kx1QoipR/q7VPDogbPAbXmnaia/pRjTlN+ehPvAAFfh3ISTfN6iCw==
X-Received: by 2002:a05:6870:24c:b0:349:de3c:bfbe with SMTP id 586e51a60fabf-3c98cf43518mr9335490fac.1.1761152398097;
        Wed, 22 Oct 2025 09:59:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4176:6994:bd72:1296? ([2600:8803:e7e4:500:4176:6994:bd72:1296])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c9af01b3b3sm4184066fac.11.2025.10.22.09.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:59:57 -0700 (PDT)
Message-ID: <49c09806-0f58-4d1d-aa0c-4351fc3e7089@baylibre.com>
Date: Wed, 22 Oct 2025 11:59:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: fix possible OOB array access
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
 <aPkMLUhm_UAVzRSA@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aPkMLUhm_UAVzRSA@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 11:54 AM, Marcelo Schmitt wrote:
> Hi David,
> 
> One minor question inline.
> Nevertheless, the fix looks good to me.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> On 10/22, David Lechner wrote:
>> Reorder the channel bounds check before using it to index into the
>> channels array in ad7124_release_config_slot(). This prevents reading
>> past the end of the array.
>>
>> The value read from invalid memory was not used, so this was mostly
> What is considered using the value in this context? (see other comment below)
> 
>> harmless, but we still should not be reading out of bounds in the first
>> place.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/linux-iio/aPi6V-hcaKReSNWK@stanley.mountain/
>> Fixes: 9065197e0d41 ("iio: adc: ad7124: change setup reg allocation strategy")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/iio/adc/ad7124.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
>> index 9d58ced7371d0af7004a81153888714e9795d4f4..ed828a82acb71342fb2eae27abfbbd86861cba53 100644
>> --- a/drivers/iio/adc/ad7124.c
>> +++ b/drivers/iio/adc/ad7124.c
>> @@ -586,13 +586,18 @@ static int ad7124_request_config_slot(struct ad7124_state *st, u8 channel)
>>  
>>  static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
>>  {
>> -	unsigned int slot = st->channels[channel].cfg.cfg_slot;
>> +	unsigned int slot;
>>  
>>  	/*
>> -	 * All of these conditions can happen at probe when all channels are
>> -	 * disabled. Otherwise, they should not happen normally.
>> +	 * All of these early return conditions can happen at probe when all
>> +	 * channels are disabled. Otherwise, they should not happen normally.
>>  	 */
>> -	if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
>> +	if (channel >= st->num_channels)
>> +		return;
>> +
>> +	slot = st->channels[channel].cfg.cfg_slot;
>> +
>> +	if (slot == AD7124_CFG_SLOT_UNASSIGNED ||
>>  	    st->cfg_slot_use_count[slot] == 0)
> Wasn't the value potentially read from invalid memory used above?
> It's fixed now, so I guess there's no point in nitpicking on that.

This code was unreachable with an undefined slot even before
this change because of the check to channel >= st->num_channels
before it.

> 
>>  		return;
> 
> Best regards,
> Marcelo


