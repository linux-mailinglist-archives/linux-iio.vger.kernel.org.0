Return-Path: <linux-iio+bounces-8370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6279B94D259
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 16:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE821B22321
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0E197545;
	Fri,  9 Aug 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyuITf38"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D6193090;
	Fri,  9 Aug 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214450; cv=none; b=EEQsG29uy1AjjMDbzg5QgxMd8YorNGwLwN1S3tjIBcdyzwG3DBqN0No62iKRUbu8Ze/dS1hXBnY0Va/5KW3huggrQhXHbrrc+e/7bX0UbpXWeOzK5CIgsmHSQHTnSMj7gen+u051TkkkEA63GtMMjIQYztkXDXPtyrM6UXMhrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214450; c=relaxed/simple;
	bh=G+m2bqPCB8ujCDWrF6jpqwQcNEOclbrBMDxFlf2/sfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvjY48cD/+AmVVp3Py4ddTORNsh65D6upNPOlfDI0edvQjc1sIHSXZeoE0EIa50GWiciltecwwDyJdamgY1j5UD2jyj6H37sTfzFHwNgUp0fvWTZ+1njJ4UksepX3QfxEL1i+FvLPRynA10xyq/lfYDLhIFRlSG7h5tNrv3vba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyuITf38; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d0dc869bso129216385a.2;
        Fri, 09 Aug 2024 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723214448; x=1723819248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHjiVQuYfgWbGsVCPXBC3WBTw9YCJU6IrbvqLsBt5vE=;
        b=OyuITf38uYfMWgC3pN6EVVJbaGE/xUov50HzMfEFARyho9MqHxSxHkYQXJaSUiU0WO
         KkOMhe6ogytR3Q8lnNkquyRd4DlzJJEVD0aR0OI6j2t6n4eq3xSEcNRg/0/djST70Km/
         xFZ8eqnO6mS+JycFU4tBypq//wJXdkt3goQsAfElo+oHyGGWOV7RV9CpwtQN5UP9ZzIY
         5ejNbJ0STfoik1EbqVj4lS8z/nln9QnEhSThOlOIlcVmWBdj8S+h1sSY+knmcw2sH0Sk
         KAe5t268zrYom9Ni2FaCTjdfduwci2tSUEsytHBmFBIq2OSmpIEbYhgD0QynXMvCGO8c
         C6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723214448; x=1723819248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHjiVQuYfgWbGsVCPXBC3WBTw9YCJU6IrbvqLsBt5vE=;
        b=iFZeWDJEQFWzIfjTjygX/vldDqUf9egacsfMmx0B+v6DauE4hFAdFbEIJmBXTW04hx
         18HyjHngJ+OpeGBW8dhuLKrC+ag1Tf+KYfBLm3zh1YnYmM+gvHdmUfa7euWvfix5r1T4
         FxKhNaIn1lhPitZsJm23GKXpRpn32s2X02BYDnTxD+IwfAW/AHaPQ90ReypotAnK+9JC
         jLF1B7AC1y7Wq7wsrd+QIWRft305HYCt8XPlAbT7dsIkAgfQ74Z1XM3HzfOt7UYS/ins
         3BVJWPR4SSVNftbgm5sYBiEvkj2vPV8fm9xB7LgaQaetQUoQDz6e0Yjf4li8jHvgVttA
         AOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUto6VJ/vrxhmV4P+i5sAA1L4Wo6ke/uMmAByQon3sTev2yCYZ/8mrk+nbqF3DtTf3RxRrhj4pFk3/tTEewwJErzC5UEOuz5err7wQytIaw2Vr99vHOPjisgHLnD4TD1oH1aw2nStA0+FNL6WUkPY7kBzE/v2mpAjXrSGMhgVQ0EvxReQ==
X-Gm-Message-State: AOJu0YyEnJvNXftDeD7K/h4sfHwX7Bme8difrws1Txsug2qNHXDg/RlL
	4NUpuG6YSPTIaQqAHQaYMVDZ1tmrK7sLgFCg+RyJQAYmOafI/Dej
X-Google-Smtp-Source: AGHT+IEywtLzOaTDz89Q6pwDNWHnnCVF3LlQKIrvaF1Z2oiNS7RIbF7IxdMFkle1HzNO2GCgNZKoog==
X-Received: by 2002:a05:620a:31a3:b0:79d:7ae3:4560 with SMTP id af79cd13be357-7a4c182f7b4mr192433085a.55.1723214447683;
        Fri, 09 Aug 2024 07:40:47 -0700 (PDT)
Received: from [192.168.0.220] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d3cedsm268424885a.15.2024.08.09.07.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 07:40:47 -0700 (PDT)
Message-ID: <93d79fbd-8d1c-4a80-bf65-d4e597247573@gmail.com>
Date: Fri, 9 Aug 2024 17:40:44 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for ad4113
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 devnull+dumitru.ceclan.analog.com@kernel.org
Cc: Michael.Hennerich@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dumitru.ceclan@analog.com, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
 <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
 <37357b8a-1995-473d-a6fb-168fc38e0641@wanadoo.fr>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <37357b8a-1995-473d-a6fb-168fc38e0641@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/08/2024 17:30, Christophe JAILLET wrote:
> Le 09/08/2024 à 12:33, Dumitru Ceclan via B4 Relay a écrit :
>> From: Dumitru Ceclan <dumitru.ceclan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> This commit adds support for the AD4113 ADC.
>> The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
>> converter (ADC) that integrates an analog front end (AFE) for four
>> fully differential or eight single-ended inputs.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/iio/adc/ad7173.c | 36 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index a854f2d30174..3ac09d326472 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -3,7 +3,7 @@
>>    * AD717x and AD411x family SPI ADC driver
>>    *
>>    * Supported devices:
>> - *  AD4111/AD4112/AD4114/AD4115/AD4116
>> + *  AD4111/AD4112/AD4113/AD4114/AD4115/AD4116
>>    *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
>>    *  AD7175-8/AD7176-2/AD7177-2
>>    *
>> @@ -84,6 +84,7 @@
>>   #define AD4111_ID            AD7173_ID
>>   #define AD4112_ID            AD7173_ID
>>   #define AD4114_ID            AD7173_ID
>> +#define AD4113_ID            0x31D0
> 
> Nitpick: others are in lowercase --> 0x31d0
> 
>>   #define AD4116_ID            0x34d0
>>   #define AD4115_ID            0x38d0
>>   #define AD7175_8_ID            0x3cd0
> 
> Other than that, is there any reason to have this "random" order for these defines?
> 
> CJ
> 

It's not random, it was requested to order these defines by the ID value:
https://lore.kernel.org/all/CAHp75VcjcgnLkQWim1AVnyeRGFwwKpaWSCvrmqdv41Lx87hMKw@mail.gmail.com/

