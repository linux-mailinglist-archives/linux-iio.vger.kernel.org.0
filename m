Return-Path: <linux-iio+bounces-5987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A91BE8FFFC4
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114D3B22621
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7715B552;
	Fri,  7 Jun 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDd3z6yk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3F746E;
	Fri,  7 Jun 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753308; cv=none; b=k51hDmGFng+6ZfklI4z/kKMfBqvhcsuDwZGya56G31PAbjbg9CYP66XdhE0SeTbwDB3HiK7kDGfbA9Ssn6fz6+lAFBZrRteOMgIbeMk5Fr72HhYE5FmIipMXKPr42S+ogpVcKjXqNJJUR7VHv4FFyNEGkxt/dGjuhRK6LBQdK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753308; c=relaxed/simple;
	bh=ynvlvVbo/tWkOIken/yYFOvDfSVzxKWB8fQuH4Z+Q54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsC1OjDh4ZV2U6vHZS54FDamQGqljpIOeKlsSb7URrEVTPA7kGS7Z4fX58QKNzsyk943Ka4Ve08QHRYSiYfdeiO128BBbsyKPdwMxgSKXcNR7n+uG1BPDWb9r8llYZQajge0k6TEqNOKFqzMlYchMAM3PsEOWHXSjgNbDoHxYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDd3z6yk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a626919d19dso551960666b.0;
        Fri, 07 Jun 2024 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717753305; x=1718358105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHthyJxfQWG9RW2oiS/t6zGoou7lw4UFn78RRn4Kbbo=;
        b=hDd3z6ykQ7ewoMES4zYloy15EVnXfP3OsvSYJYESsk2cfn4u+TJBYVR0/FISWp77lA
         +q6ouGRDEJCAe3xFjCGipilVMVPSPtTQO23++aNuNhOUh4qI10Roi7LqDcVjj9T3pfz9
         sSgi0caqBxz+yeVCDoMXmAi1kHuR2jvR0JqeF4V3ovFokszJV2n1ZrsLqr9z+NwSgDES
         bw0+ky6HaOMLgXZgyepArkZlyu4NxTH13WBH49gkeSeMXDq8d6iubEInaluKXwMPNbFe
         k2GzkJe4LvTre0Pfg8V4dhtTLSl76//R/1Z+7yz07CVtZMxbLfDzIiPHwb/EVWbsVST1
         3XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717753305; x=1718358105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHthyJxfQWG9RW2oiS/t6zGoou7lw4UFn78RRn4Kbbo=;
        b=oC2NbdUbIfvSohsqe+LRkyq/oMd0P2TLNnBUZ8fcikMetBGrX9Sd+Wl7j0uD3OozH0
         6Mwnz39/szG+pvKeqeqe320cBUERWCp+OqIMZnxIrodMHeaB7zFCuUt0b2Pz5lCVBdLJ
         2w9Zek5GtdHGE1prM3aosHYKgvgNYlSxspzahibdQz4zBQE8AKbffzdFSSxezi3XTGLS
         tVSrwfJ5aMEm49lHwKpCM602/W7m4xC+eYR8PErmLVbCp+65yGrsQ5ZJSFBedZGXiYbE
         vQCIkrOfMTgCqskMC15bmGJL6sOQ5zDiQbUFi6BDmNeudwqZSpZ8JoQg1zgq7a3SZQiK
         Dl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbTs7zq+pr1w/V0DZC1scWxEhbo1R2+hjQVM+SH+QdAC6EYAWhvRNSGZzoZU/2j/8kcsbpUCTZEg9rlwTlQVmtDie8dCAvdMhlhjArXbEkkNgbdXC3WFD/Q8wY2ITUP77VwGxvduxGYz6Ti3iOtFZpjGKQeJvj4cjtabajaTC+ROPQXA==
X-Gm-Message-State: AOJu0YyIo5sN2E6ULwx91REJo7BnVdyY2CNvpTUm8u9ES1+Facne262U
	mbg8vMnszD1dkx6KwUrOTx2Ggu0q23tS8wKw2bHFPyJJDXPm/Ung
X-Google-Smtp-Source: AGHT+IF3iq8j3f7Ft+xnRNqD2FMzh7+5wrp83qD5WemFIuZYfqTXJxrAZ5OB7zdPhvJmFFEuZnHiAQ==
X-Received: by 2002:a17:906:e56:b0:a6e:372f:5783 with SMTP id a640c23a62f3a-a6e372f5b4dmr59107566b.4.1717753304658;
        Fri, 07 Jun 2024 02:41:44 -0700 (PDT)
Received: from [192.168.0.220] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80727e1esm218698066b.190.2024.06.07.02.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:41:44 -0700 (PDT)
Message-ID: <1c6d409b-ba9e-4a19-a6cb-e06209a24154@gmail.com>
Date: Fri, 7 Jun 2024 12:41:42 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] iio: adc: ad7173: Add support for AD411x devices
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
 <20240606-ad4111-v6-9-573981fb3e2e@analog.com>
 <389546877ae11b18928b432e86710acf83974f67.camel@gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <389546877ae11b18928b432e86710acf83974f67.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/06/2024 12:20, Nuno Sá wrote:
> On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
>>
>> The AD411X family encompasses a series of low power, low noise, 24-bit,
>> sigma-delta analog-to-digital converters that offer a versatile range of
>> specifications.
>>
>> This family of ADCs integrates an analog front end suitable for processing
>> both fully differential and single-ended, bipolar voltage inputs
>> addressing a wide array of industrial and instrumentation requirements.
>>
>> - All ADCs have inputs with a precision voltage divider with a division
>>   ratio of 10.
>> - AD4116 has 5 low level inputs without a voltage divider.
>> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>>   shunt resistor.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  drivers/iio/adc/ad7173.c | 317 ++++++++++++++++++++++++++++++++++++++++++----
>> -
>>  1 file changed, 285 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index 58da5717fd36..cfcd12447e24 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>>
> ...
> 
>>  static const struct ad7173_device_info ad7172_2_device_info = {
>>  	.name = "ad7172-2",
>>  	.id = AD7172_2_ID,
>> -	.num_inputs = 5,
>> +	.num_voltage_in = 5,
>>  	.num_channels = 4,
>>  	.num_configs = 4,
>>  	.num_gpios = 2,
>> +	.higher_gpio_bits = false,
> 
> No need to explicitly set to 'false'. Ditto for the other places...
> 
> ...
> 
>>
>>  static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>>  					      unsigned int ain0, unsigned int
>> ain1)
>>  {
>> @@ -946,15 +1145,30 @@ static int ad7173_validate_voltage_ain_inputs(struct
>> ad7173_state *st,
>>  	    st->info->has_pow_supply_monitoring)
>>  		return 0;
>>  
>> -	special_input0 = AD7173_IS_REF_INPUT(ain0);
>> -	special_input1 = AD7173_IS_REF_INPUT(ain1);
>> +	special_input0 = AD7173_IS_REF_INPUT(ain0) ||
>> +			 (ain0 == AD4111_VINCOM_INPUT && st->info-
>>> has_vincom_input);
>> +	special_input1 = AD7173_IS_REF_INPUT(ain1) ||
>> +			 (ain1 == AD4111_VINCOM_INPUT && st->info-
>>> has_vincom_input);
>> +
> 
> Wondering... can ain1 (or ain0) be AD4111_VINCOM_INPUT and !st->info-
>> has_vincom_input? Would that actually be acceptable? It would assume it's not
> so we should check that right? Or am I missing something?
> 
> - Nuno Sá
> 

It will fail when we check for the number of voltage inputs:
(ain0 >= st->info->num_voltage_in && !special_input0) 
as special_input will not be true if has_vincom_input is false

Indeed this check is a bit hidden, should it be more explicit?


