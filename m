Return-Path: <linux-iio+bounces-5680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C78D8425
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAFC1C21AF8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CC12DD91;
	Mon,  3 Jun 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MFdnv7I5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A315C3
	for <linux-iio@vger.kernel.org>; Mon,  3 Jun 2024 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421919; cv=none; b=gfXmAzSUnibgm0ktm3RgC6BwGM0JPP4tXGuFYXLG5xvOexqGuxMsw1rycr/c7E8C61sUlqnjFXY5cWThLS1noGmXiZH6HV+S3lgCnLhlUelFYUXtc6p8wndBlehxmDrZ4DUc9TX9V9nHF5wTmta5kejiRYy77XExqctHIZ61vi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421919; c=relaxed/simple;
	bh=vtWc8iVFqsvABRv79bFQ/v9WSZIoE8OBawLvKAFSD5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/7yR17Pz2W2dC1Z+KipCmAAfflNje+NIgZo5e3zfuvVpaUeRVa8RuRvwGrfCf6i/02cv0XvH6/jIc/zTV2l623cDl4mBFDfvAsta3v+YUhMiERR5LFbSTR4ZdfxIZ93uqQ4fYPrH29VQ2FyDVQM4IsmNjZKpR1XsRRVw5ryz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MFdnv7I5; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c9f628e71so2234954fac.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2024 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717421915; x=1718026715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yi0mazzB+1gBreHBUe8h9eRnw4We/Z3jQeykzO1tsNI=;
        b=MFdnv7I591E91zbrvgkEbtOuEZp29WCU2YITuUqJzNNR5eTknblW/5S1n0whmj1tae
         eY92BcGPZhLCQwd3o5zchL+jD4bGBhTBrmvVhe9vArPthJm+KsHVeLLj77M1/AT+RLxc
         gcyyDQs4N97py134bA+4qhqTeO4Eh60CxbIMsXHtALs1giq7lewlzXdrkvTIbRo1fIPf
         Uh8CjchNgLUhhimLug4goz6HE/AbqIkT8etLSVGkqU6gKJTFZzZLG8c7meppUL9OyCoS
         DN+OURhlhFwiWhn5GPfjUpS8RGhHjccs/CpuyxdDJAr3saRBJgl7kxagq3CMwfl/fcFp
         fTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421915; x=1718026715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yi0mazzB+1gBreHBUe8h9eRnw4We/Z3jQeykzO1tsNI=;
        b=K9QOLbyycO4NuX8Mb9NBlo/5kjD+eK1Hg/6hZIPgGbjtKA0NvnyXK0wuirGndQ0eRQ
         +ROgYpZfQlqKMBebRqz+PDO2pziSIS/kGVhMo77vs6r/JBR17avcdJV1tJMyf/9fNp0s
         0I6oRVc6spAGlYk0KP/6t49H/tIOKgjZjw6aKQ9DlrY9xePsRsFZ0k2iirPRDxcH0Qad
         wjmnHe1rPo/2uclMOgsCK/CFgNUM6YDQ+cqFByvz3kjHGUMSUhtUxFX9nL3tXIb7A7tl
         sNhFfjH6I0NcT4eUBAGmQYtIpi/HdHnVpypdLJlg0Eat9hVApeebXpU11HdkKvwT36ng
         XP8A==
X-Forwarded-Encrypted: i=1; AJvYcCUXmgYXzQqDfKOoAREWu+qCgcc0sC8Oa6BUHM72tw8xL2LvrZCHfBjaeWVzilfspWwG06TKryVo5h6WfLGhJBvxhiYZ8xsATP2P
X-Gm-Message-State: AOJu0YxxlmFOPI1YQSWTGgw2PmUv6N1//1BelW4ZiTSo5+bnA3NjTb5+
	c3jf2z64QPrkYR5vxrFjEyi4qa0cxss+LPUqiyopj4/vBEq816xO8hHVz1z/Ifk=
X-Google-Smtp-Source: AGHT+IGobSbMwH2za+FkJIH5iveN+S3Y3iLQ2Xhg/S0TlsXdCGh2UJY3hlJJprZpjPOIYzixp+Gpxw==
X-Received: by 2002:a05:6871:54c:b0:24f:e09d:3c82 with SMTP id 586e51a60fabf-2508b7de2ecmr10411175fac.12.1717421915552;
        Mon, 03 Jun 2024 06:38:35 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-250852c97a8sm2442529fac.50.2024.06.03.06.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 06:38:35 -0700 (PDT)
Message-ID: <f2e7a1f4-0362-4851-885e-3f7dfe3ab457@baylibre.com>
Date: Mon, 3 Jun 2024 08:38:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iio: adc: ad7944: use
 devm_regulator_get_enable_read_voltage
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
 <20240531-iio-adc-ref-supply-refactor-v1-5-4b313c0615ad@baylibre.com>
 <20240601140139.3166dcaf@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240601140139.3166dcaf@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/24 8:01 AM, Jonathan Cameron wrote:
> On Fri, 31 May 2024 16:19:36 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> This makes use of the new devm_regulator_get_enable_read_voltage()
>> function to reduce boilerplate code.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> A possible corner case inline.
> 
> Patches 2-4 lgtm.
>> ---
>>  drivers/iio/adc/ad7944.c | 62 +++++++++++++++---------------------------------
>>  1 file changed, 19 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
>> index e2cb64cef476..42bbcb904778 100644
>> --- a/drivers/iio/adc/ad7944.c
>> +++ b/drivers/iio/adc/ad7944.c
>> @@ -464,23 +464,16 @@ static const char * const ad7944_power_supplies[] = {
>>  	"avdd",	"dvdd",	"bvdd", "vio"
>>  };
>>  
>> -static void ad7944_ref_disable(void *ref)
>> -{
>> -	regulator_disable(ref);
>> -}
>> -
>>  static int ad7944_probe(struct spi_device *spi)
>>  {
>>  	const struct ad7944_chip_info *chip_info;
>>  	struct device *dev = &spi->dev;
>>  	struct iio_dev *indio_dev;
>>  	struct ad7944_adc *adc;
>> -	bool have_refin = false;
>> -	struct regulator *ref;
>>  	struct iio_chan_spec *chain_chan;
>>  	unsigned long *chain_scan_masks;
>>  	u32 n_chain_dev;
>> -	int ret;
>> +	int ret, ref_mv, refin_mv;
>>  
>>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>>  	if (!indio_dev)
>> @@ -531,47 +524,30 @@ static int ad7944_probe(struct spi_device *spi)
>>  	 * - external reference: REF is connected, REFIN is not connected
>>  	 */
>>  
>> -	ref = devm_regulator_get_optional(dev, "ref");
>> -	if (IS_ERR(ref)) {
>> -		if (PTR_ERR(ref) != -ENODEV)
>> -			return dev_err_probe(dev, PTR_ERR(ref),
>> -					     "failed to get REF supply\n");
>> -
>> -		ref = NULL;
>> -	}
>> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
>> +	if (ret == -ENODEV)
>> +		ref_mv = 0;
>> +	else if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
>> +	else
>> +		ref_mv = ret / 1000;
>>  
>> -	ret = devm_regulator_get_enable_optional(dev, "refin");
>> -	if (ret == 0)
>> -		have_refin = true;
>> -	else if (ret != -ENODEV)
>> -		return dev_err_probe(dev, ret,
>> -				     "failed to get and enable REFIN supply\n");
>> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
>> +	if (ret == -ENODEV)
>> +		refin_mv = 0;
>> +	else if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
>> +	else
>> +		refin_mv = ret / 1000;
> How does refin_mv get used?  Previously we never queried it's voltage (I assume
> because it supplies an internal reference?
> 
> Are there any regulators that are real enough to enable but for which a voltage
> can't be queried?  I think fixed regulators with gpio control are in this
> category...
> 

Hmm... don't remember why I did it that way (was a while ago). I will bring
back the have_refin flag instead.



