Return-Path: <linux-iio+bounces-5765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA42E8FB4D2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 16:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CE41F22697
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE46182D2;
	Tue,  4 Jun 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qKmlxSDG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7E1758E
	for <linux-iio@vger.kernel.org>; Tue,  4 Jun 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510240; cv=none; b=RmDbMyiUgm+khT2BU4R9rK/4dbjA8BNNAipPJQO+Wt1r2cmhLRSStAuHc265CbVVlqSVbb3UCiEbd8i24TBd5meNS01cabwfyeGudAJR13+kC2wUihHdpaX7gpl+lwfESJ5JbGfeiF0qLrCN+S5qpfWDkh4UAxP0huZIFEZ3w+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510240; c=relaxed/simple;
	bh=0fDAC32JTnWS7VNV7AYXzJ2KhmthVvzKWI0FktW7Xtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN9XNjvmb7Mbi0fD2+HREtdSqtzw+/Sh9YQaCwdUctzpUKakiFlfh0ly1beN4mBqeZWa3sF6PEVA6MrpnY/SMYtGq/MRzKUdQ8/eZkNm/Rr05l2+Qat2TzaV7um4QDjq6ggjIcajCOAYUsmKsR/MN7V8xHOFv0t+SJBdCO2teYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qKmlxSDG; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d1fd550871so448426b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Jun 2024 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717510237; x=1718115037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/v1MqtKQHf3pa46iC2lt0ohI5LlCi2RQDwys5lOoY4=;
        b=qKmlxSDGI8jdV0pTDsVeJ2F0bZ0cIInVe9gW82OaECThbpqh5Y7qVZJurp36VjpYLi
         Ybydbd7lMasEeu2KrDYqLKlVlaXKyYR9/VF3b6iYKo/6NEXBSuuGmylCoH/h9RbqRvNh
         xdoUYmb8yH1CMp9T6iHKGTqEyANhGjsE6uEK4euvfF+sI3Utd4hr8iJIo37J5rr94F3V
         sSMRF/UiE2DMfHVQ7VtHEowV8S+sJeIShiAUfLKZf7x56W4LkA6Eq8bpfAEQkq/Wd+BN
         9Ot5i/p3nZuwFBxmELMdKHzSxkBveXGHnRysT33MkfvZ4iDnStx36IlAc3Oyo3KPxJm4
         QyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510237; x=1718115037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/v1MqtKQHf3pa46iC2lt0ohI5LlCi2RQDwys5lOoY4=;
        b=c6JNj2NGqpxS362dVklRh6XRnX0KiPi437wzRBRvlkYg6yeoZoyYZZ0aX/RbrRjaBY
         5e35IKhQQJJ+J0Pkb+Za4LP0dvqVy53FxZ7FjjdZDj634NoXGPHPx2TZXC9zFDZvlPRH
         +kT468PZie75OPtw81yDb3q2uFlTcO5g5LiqDEYlzv9sQc5uTuB4QIHL2YU7zwvRr5O5
         yhUhK3tFNGcD2lQVHcby9x76vvhEtN4Ref/P5Elb8evk5aRvV802WdkLV5E9TycHVKEk
         zzI4Ye7IoZ944F9pbs9qRl6VoLq7HdpzPr+NK9dmSOHZArqdjjk8DtWq9sffOCKsnfZn
         vUsA==
X-Forwarded-Encrypted: i=1; AJvYcCVeQmUq68NekdBNii/5fcS/FC7lBTU2qowsyX39/V5UH5nXIr9H0D2rIJjEcjYTRmzy5iCVZGuljgLT4gNqA/PcwsRyfuiXL4PW
X-Gm-Message-State: AOJu0YzvZqIIcinO2jEcnoXtqOY+O8f6+TGBegr+VA7ZiDU54Ok8l0nQ
	zI73AashPUNv2zEdssk4PJ0pqN7NhMCnxP7OiawnQX8U+H0QBRxRt7zyasr3rSA=
X-Google-Smtp-Source: AGHT+IF228PCVcISt2bMu4wXxL7vIoCVBdRwg9z8BK4DSLHQ7SsFxi31K20G+OKEMiqc3x2bEABL9g==
X-Received: by 2002:a05:6808:d4b:b0:3c9:6bbe:53a8 with SMTP id 5614622812f47-3d1e35ad0bdmr15729802b6e.27.1717510237183;
        Tue, 04 Jun 2024 07:10:37 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1e19da633sm1827029b6e.12.2024.06.04.07.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:10:36 -0700 (PDT)
Message-ID: <57a60f5c-a989-4187-ab4f-1f6a15578578@baylibre.com>
Date: Tue, 4 Jun 2024 09:10:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iio: adc: ad7266: use
 devm_regulator_get_enable_read_voltage
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
 <20240531-iio-adc-ref-supply-refactor-v1-2-4b313c0615ad@baylibre.com>
 <edb66fe8c2722e600179b1f9a0d81242d84582a0.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <edb66fe8c2722e600179b1f9a0d81242d84582a0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/24 6:19 AM, Nuno Sá wrote:
> On Fri, 2024-05-31 at 16:19 -0500, David Lechner wrote:
>> This makes use of the new devm_regulator_get_enable_read_voltage()
>> function to reduce boilerplate code.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/iio/adc/ad7266.c | 37 ++++++++++---------------------------
>>  1 file changed, 10 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
>> index 353a97f9c086..026db1bedc0a 100644
>> --- a/drivers/iio/adc/ad7266.c
>> +++ b/drivers/iio/adc/ad7266.c
>> @@ -25,7 +25,6 @@
>>  
>>  struct ad7266_state {
>>  	struct spi_device	*spi;
>> -	struct regulator	*reg;
>>  	unsigned long		vref_mv;
>>  
>>  	struct spi_transfer	single_xfer[3];
>> @@ -377,11 +376,6 @@ static const char * const ad7266_gpio_labels[] = {
>>  	"ad0", "ad1", "ad2",
>>  };
>>  
>> -static void ad7266_reg_disable(void *reg)
>> -{
>> -	regulator_disable(reg);
>> -}
>> -
>>  static int ad7266_probe(struct spi_device *spi)
>>  {
>>  	struct ad7266_platform_data *pdata = spi->dev.platform_data;
>> @@ -396,28 +390,17 @@ static int ad7266_probe(struct spi_device *spi)
>>  
>>  	st = iio_priv(indio_dev);
>>  
>> -	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
>> -	if (!IS_ERR(st->reg)) {
>> -		ret = regulator_enable(st->reg);
>> -		if (ret)
>> -			return ret;
>> -
>> -		ret = devm_add_action_or_reset(&spi->dev, ad7266_reg_disable, st-
>>> reg);
>> -		if (ret)
>> -			return ret;
>> -
>> -		ret = regulator_get_voltage(st->reg);
>> -		if (ret < 0)
>> -			return ret;
>> -
>> -		st->vref_mv = ret / 1000;
>> -	} else {
>> -		/* Any other error indicates that the regulator does exist */
>> -		if (PTR_ERR(st->reg) != -ENODEV)
>> -			return PTR_ERR(st->reg);
>> -		/* Use internal reference */
>> +	/*
>> +	 * Use external reference from vref if present, otherwise use 2.5V
>> +	 * internal reference.
>> +	 */
> 
> Not sure the comment brings any added value. The code is fairly self explanatory
> IMO...

Well, you do this every day. :-)

For someone who never wrote an IIO driver, it could be helpful.

> 
>> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
>> +	if (ret == -ENODEV)
>>  		st->vref_mv = 2500;
>> -	}
>> +	else if (ret < 0)
>> +		return ret;
>> +	else
> 
> I think it would be better (as that is the typical pattern) to first check for
> errors. Also the 'return' in the middle of the else if () is a bit weird to me...
> Maybe something like this?
> 
> if (ret < 0 && ret != -ENODEV)
> 	return ret;
> if (ret == -ENODEV)
> 	st->vref_mv = 2500;
> else
> 	st->vref_mv = ret / 1000;
> 
> or even replacing the if() else by
> st->vref_mv = ret == -ENODEV ? 2500 : ret / 1000;
> 
> - Nuno Sá
> 

I think I like that better too.



