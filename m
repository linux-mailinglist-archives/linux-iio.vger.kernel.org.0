Return-Path: <linux-iio+bounces-5445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3ED8D3895
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A811F2298F
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422DA1C6A1;
	Wed, 29 May 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxNOqsOR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2012B95;
	Wed, 29 May 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991414; cv=none; b=C2bdksmd61A7hSbiMIfOm8KLNngSzg5qsOknt8qq4WnzRSRXidXcx4L5DurvyV41cL6KqXfG02B6vV1rnYC49k7DZr5/QSOBEm8vp5zf4+mnQ2qf+J74iZBj9bYA0LxgCvUuZSsbQjlcYcsKDBhXc8a5bRdwgVrgx3+nvJ8lj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991414; c=relaxed/simple;
	bh=WjdW1FP762sEgNbUJdyYCjRIv0VEhWJXADENEQ+EJdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnCbXCveLNRTvbSDgOcysVjhIoY8zMgIknlk2JdIGxlQVxYPmiKm+CbLZz24CR8vHoIq42ufg0nCkHbAWTCXylzvaXG29B2cWRUujXm/H0C0j5Gv/P8TTonObp04oBuk/QQUPv/0EsX5Yt2NMIHVlb31hImBO2LYqcPyBzFcras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxNOqsOR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5785c1e7448so2121717a12.2;
        Wed, 29 May 2024 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991410; x=1717596210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1ujdDEYUIIkAJTFHWvU9CFPTnOkFnbvdnN/RkQMKsY=;
        b=VxNOqsOR2+Wv2aPaUyuqALu/rEiZG0u8IlrrZMZGJ3DouUVUE0AKugwiMNhtRwLq3d
         1EbB6CP4riSiOZ7Ynvd/t/IAHEQYHrOiCO3cHnd3BpjfprgeziDHZVLvQTzhPskfCjPY
         ZItaqq5OIPkSYvoAqp6/R303W1C7i3TzW0VGWivH+TiK96pJbHAahfV4+u5mjAsAfs7E
         NRKhxthsQGkaz3CLkCQjWhe0IgE00ktWg2Qrb6MhhRSU4CntP9X9MvdZEm0EXvBoEyK5
         4LUoAE6fLVDxPVdu4nWJawuBjo6n/o9m2rAruguLWukP15TCNOP8Zq0/FOoaW91gYba8
         lfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991410; x=1717596210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1ujdDEYUIIkAJTFHWvU9CFPTnOkFnbvdnN/RkQMKsY=;
        b=kFzeu3R3Vyjtd8xFovHRS7i+IVHxVX3To0VmO7PWVVpgDsD9q89XC0LegMOrQYlytg
         JlzxjWrBnmOHYRGucJcGexyz7pKKZurWv/NefwNM9o5dYc41tIz4RUh80UK+fGX+fQIm
         ljluXI1s7s4g6Xgv3Rks2FYSKU354q3p6+1N83IZQGEh/Cn1NyHOYwKb+WXDEM2txHhZ
         P4Ucu+EWMdrZc5Gpfc2JXBnRpLn673MQ2TedTubT4FGHIMouE1ZggS+v8TAGnziCPi+1
         WykS2HfNJzu3SdmEdI75KcsMmw60YgEwkJsIz/vE5adyQrcf6/aE43F5jd4V9Gr0K4aS
         HlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVwxyzngXBcajkaJaCixg/IM+9FKTgvyKZ9ftvJvRgUoPyeLQRW6Njh2M/072KMiT5NfhxMBfk979q9tv2JxZhxV+qYy6SUnS6ZPQ7er1FgF3HW9po9hQt9nWew957j8NA9VWkX+zdl8K+Hy2hLkw5VdOqlq4yCPy9UiXczvPb2wdywQ==
X-Gm-Message-State: AOJu0YyVpofDRxmj4Gq2wgwlsDKCiuOKZrwK4R7q0cgS1n46m7U0O7Xo
	iL6JCK+TAS2bNsMbvLHr2Cxi6I5xt/oOToH3qapPqJAD6Op6IZO8
X-Google-Smtp-Source: AGHT+IECePkYinauu8AtBL+pjHmC4fTu+y/z0FujBAwpBmBYBYATXLR/JUybGKJN+92ubFWQWLGFjw==
X-Received: by 2002:a50:c359:0:b0:578:5ee4:921f with SMTP id 4fb4d7f45d1cf-5785ee495f6mr9808278a12.13.1716991409673;
        Wed, 29 May 2024 07:03:29 -0700 (PDT)
Received: from [192.168.0.137] ([188.24.75.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785234a7efsm8555915a12.4.2024.05.29.07.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 07:03:29 -0700 (PDT)
Message-ID: <917bc1d9-fbdc-4ca2-a156-813b57c8201e@gmail.com>
Date: Wed, 29 May 2024 17:03:27 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] iio: adc: ad7173: Add support for AD411x devices
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-5-7e9eddbbd3eb@analog.com>
 <6f18184de4a37993baedc15b44ecf0a6834a24d1.camel@gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <6f18184de4a37993baedc15b44ecf0a6834a24d1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/05/2024 15:46, Nuno Sá wrote:
> On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>

...

>>  static const struct ad7173_device_info ad7173_device_info[] = {
>> +	[ID_AD4111] = {
>> +		.name = "ad4111",
>> +		.id = AD7173_AD4111_AD4112_AD4114_ID,
>> +		.num_voltage_inputs_with_divider = 8,
>> +		.num_channels = 16,
>> +		.num_configs = 8,
>> +		.num_voltage_inputs = 8,
>> +		.num_gpios = 2,
>> +		.higher_gpio_bits = true,
>> +		.has_temp = true,
>> +		.has_vcom_input = true,
>> +		.has_input_buf = true,
>> +		.has_current_inputs = true,
>> +		.has_int_ref = true,
>> +		.clock = 2 * HZ_PER_MHZ,
>> +		.sinc5_data_rates = ad7173_sinc5_data_rates,
>> +		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>> +	},
> 
> At some point it would be nice to drop the ad7173_device_info array...
> 
What are good alternatives to this?
...

>> +		ret = fwnode_property_match_property_string(child,
>> +							    "adi,channel-type",
>> +							    ad7173_channel_types,
>> +							   
>> ARRAY_SIZE(ad7173_channel_types));
>> +		chan->differential = (ret < 0 || ret == AD7173_CHAN_DIFFERENTIAL)
>> +					? 1 : 0;
> 
> I don't think we should treat 'ret < 0' has a differential channel. Any reason for
> it? For me, it's just an invalid property value given by the user...
> 
Yes, as that would be the default value if it's missing or invalid

> - Nuno Sá
> 


