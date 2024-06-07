Return-Path: <linux-iio+bounces-5985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE28FFF9D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7141C22C1F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1A315B96C;
	Fri,  7 Jun 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey149o9j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785815AACA;
	Fri,  7 Jun 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752852; cv=none; b=qGoM43cQKucXu1ED7eqhwWOLC60L42bOXdp+xUH1unW6ZbudWfm/7qd4d1Q1OZLrA6PdfQy9eFHs2Z8rGNGI0Dgh2oMeONKhGp5lNkKK0ZjQrV47mksvgYTXuNADZ/FB5AM2Ruo24kBeniQRBSbfzQAtmp6k8wwfznUKInbQH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752852; c=relaxed/simple;
	bh=KrThBVSstishmPXTlu9MOCAX708+VNDkBP9yf6xiwdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGcg2qURj4sz7jP4Y7CGrku9qya2s7blSrkXQwv754qLYq/Il83Kk0S+chGjvLcJp4LoX9WLpJo71B5o30+k7d5PPtRy5pH6PpWqEmmoSlJkC+CeYvPxHutWHc4ak+kUTZAyNCrZTMGp1JgM0gTPckzO3vzwraEZdmCr9dOJivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey149o9j; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6ef46d25efso10247666b.0;
        Fri, 07 Jun 2024 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717752848; x=1718357648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nB/+fCK3GeBMDtioeB6krXVE/3ZywEfuJ+7MqX7PUjE=;
        b=Ey149o9j1sszBnWARxcrgS7w93oXXtw0yqG1QLPdGFAeY9sJivhOGnIS4AfCu0u8vJ
         69Tjj6hEYaYSmQ14+CBTWAO5ONQdavMw8gomuF12CIEWxfc46WhZTRXnLXaOe96ti0WY
         mtvsDVUG5i5hwT29fD2cbk7Iu+xW9UY2KYPsnlR7Vpm6Aeyto638YNOiYs3DokoiwNje
         2+pf6aOVGV97jKxFQLTK/ehwX3nhwAgxttjjeBSb3O3JFa2dM1CW0AkzOmMmpguPNaMO
         ROtXiH9yi12UvI9D+TihJb9UOwwwrpjTzEPf+72reKzKiRKal8+b54REOwa2ZdEu3MNZ
         6TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752848; x=1718357648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nB/+fCK3GeBMDtioeB6krXVE/3ZywEfuJ+7MqX7PUjE=;
        b=uIHVJxRL41IL5UegrlA1TF8fDuTL0u3blOMBtIzS9VUDrZlTPmF3Kl2TtvmrPTEr/Q
         bIwhZjlupy4gGzGZvsAa9EyY/zhgLXuclLMEc7sR460ZqQu88ZR5Ikt/3EUk9Xg1ffxS
         l4h3rn3iNBMa4w3TFg7ayEIeisGcGBUPSLXeVj+AN6Fum76xp0yUhgdp2qRrFcAygg0L
         60sR43rIGf9FtVD18fW2rgXoxiDLpCtwSEFdPP3zrxaVp9iJQ60L/ihfx9Rmv+6cyY/U
         eV2pNeCLqM7RDux8/tm1EssAOXTNfWlCk46dgcfTzCSX/XhCkcCqY6KrCmB03LVpsYSC
         xEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh/KrdfGCxdxaBTEGe8ilA/MdEN0tZOr9ymiBo5I+T9yBDz24fKDILXhX3dlrdUkmg2dSSqcB6pHimEespnwZXMGu5Qxyqa/lcKiskibFDhajS0/SOcqJGpxT4XPAWblLPVxD5nbARilByKH13upAs8VbHm9JNNFyjzxm/uYQuf/rxTQ==
X-Gm-Message-State: AOJu0YwaIrSnQa5SzPHg69E98zNrbf/5dHBztr7+fXhAL8Edgx3K6w79
	ID/Awfat5FSqCV+8eRHzS19Z+5sYgI8ff2Ac1A55sjigNyhUWEIA
X-Google-Smtp-Source: AGHT+IFRn/Vv1dGiRwhXlnwhgLXWAV0bc33jk6SXMN4pT1B1PbwWH9mTqWQhWWFFSXs+S+xwpZtoMg==
X-Received: by 2002:a17:906:f802:b0:a61:c462:c612 with SMTP id a640c23a62f3a-a6cdaa0f583mr122676966b.53.1717752848019;
        Fri, 07 Jun 2024 02:34:08 -0700 (PDT)
Received: from [192.168.0.220] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e39bsm214992766b.162.2024.06.07.02.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:34:07 -0700 (PDT)
Message-ID: <849357a8-848e-4b9f-9683-1db2eeda39af@gmail.com>
Date: Fri, 7 Jun 2024 12:34:06 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] iio: adc: ad7173: add support for special inputs
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
 <20240606-ad4111-v6-6-573981fb3e2e@analog.com>
 <822eec36a530f659e4924886ad8d2bf272accd59.camel@gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <822eec36a530f659e4924886ad8d2bf272accd59.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/06/2024 12:06, Nuno Sá wrote:
> On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>>  Add support for selecting REF+ and REF- inputs on all models.
>>  Add support for selecting ((AVDD1 − AVSS)/5) inputs
>>   on supported models.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  drivers/iio/adc/ad7173.c | 29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index 4040edbd1c32..d16fa081a285 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -66,6 +66,13 @@
>>  	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
>>  #define AD7173_AIN_TEMP_POS	17
>>  #define AD7173_AIN_TEMP_NEG	18
>> +#define AD7173_AIN_POW_MON_POS	19
>> +#define AD7173_AIN_POW_MON_NEG	20
>> +#define AD7173_AIN_REF_POS	21
>> +#define AD7173_AIN_REF_NEG	22
>> +
>> +#define AD7173_IS_REF_INPUT(x)		((x) == AD7173_AIN_REF_POS || \
>> +					(x) == AD7173_AIN_REF_NEG)
>>  
>>  #define AD7172_2_ID			0x00d0
>>  #define AD7175_ID			0x0cd0
>> @@ -146,6 +153,8 @@ struct ad7173_device_info {
>>  	unsigned int id;
>>  	char *name;
>>  	bool has_temp;
>> +	/* ((AVDD1 − AVSS)/5) */
>> +	bool has_pow_supply_monitoring;
>>  	bool has_input_buf;
>>  	bool has_int_ref;
>>  	bool has_ref2;
>> @@ -216,6 +225,7 @@ static const struct ad7173_device_info
>> ad7173_device_info[] = {
>>  		.has_temp = true,
>>  		.has_input_buf = true,
>>  		.has_int_ref = true,
>> +		.has_pow_supply_monitoring = true,
>>  		.clock = 2 * HZ_PER_MHZ,
>>  		.sinc5_data_rates = ad7173_sinc5_data_rates,
>>  		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>> @@ -230,6 +240,7 @@ static const struct ad7173_device_info
>> ad7173_device_info[] = {
>>  		.has_temp = false,
>>  		.has_input_buf = true,
>>  		.has_ref2 = true,
>> +		.has_pow_supply_monitoring = true,
>>  		.clock = 2 * HZ_PER_MHZ,
>>  		.sinc5_data_rates = ad7173_sinc5_data_rates,
>>  		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>> @@ -245,6 +256,7 @@ static const struct ad7173_device_info
>> ad7173_device_info[] = {
>>  		.has_input_buf = true,
>>  		.has_int_ref = true,
>>  		.has_ref2 = true,
>> +		.has_pow_supply_monitoring = false,
> 
> No need to set the 'false' cases...
> 
> 
> - Nuno Sá

This was suggested by David Lechner to ensure consistency with has_temp
regarding another field, I considered that it would apply here as well.
https://lore.kernel.org/all/CAMknhBGaJxXvsQ8cZkgDsKLVjOY5y2pzox-99hdOCrUaoZdsxg@mail.gmail.com/

This would also increase visibility towards what features does a specific
model support as it is clearly stated with "= false" rather than looking
for what fields are not set within the struct.

