Return-Path: <linux-iio+bounces-5471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0438D3FA8
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 22:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2446A1F232A5
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 20:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB401C8FC4;
	Wed, 29 May 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aKerZ++t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B17F15B991
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014777; cv=none; b=G4hBcow/6qYa85T2Ly2FpjG4GG1TFAHZIo1+E2WQsz+JmJZzggk5uUVjdiq+3EyZpXEKjMIBlZviPE7iR8CinmwM8L6mSHr936k8vdIto8vMGzNbLQb7dN9paEpxvjPg43V3OwSBcoc6psYkLTw5rLY4jJ9AsIidXjvwdzvEg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014777; c=relaxed/simple;
	bh=15xHBuURqdSRwsX1azBzIX0iqJGwDQgITAweyu6Q/Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usrfO2A9Uy3NF3u0EYX2q3YJswoNS+aqC9rhnsrt/UTZBfu0XqeQN4hH8h+/sZOzI9SJA/t7tyoIc5DEHvRoEd2vPMCx/IGS/BSsUgrD2AM6CA18tNLefcyPLDvtTAC4vIv57n04FbA/Jcb2pwKzjCI4DLH66Ym/s0VCKYjR4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aKerZ++t; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24fe57350d6so79668fac.3
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717014773; x=1717619573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJrn7LcIZsw+UO69OvNelbef7yB4N2to/TC1avaTfqU=;
        b=aKerZ++tMG9KHZrxLismPu9ND4lvUtR67i/Vw2sOCP9hOGLlQrQmG4AeIvFsQrKlE+
         fzm3FUL92MkFnVykUEQ1ycaaRL3JYccD9o3OmY8q2ZXyow6YaNcK3wsblMSo5Er71Zf4
         TLe89k1VGXbrgpKE3VUSKSmS3szbl61vUKa7vuYxOX170jJURK+24Oku3d3LU7yoQuTH
         8dkTYXzVbBryhF4rHNURCyWE+07PuXUgfSUemmsNDlmkmf8u+M+1l0v8FQ/uBVhpGHnp
         fixxSLce2To+XQWKo84WE+F9RWeLC22D0THx9AFEXSMOx0mVkiAZK0XqyV55XlSGzfZZ
         ClLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717014773; x=1717619573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJrn7LcIZsw+UO69OvNelbef7yB4N2to/TC1avaTfqU=;
        b=t4onH/ehLzC7iaKyBQV9lRFOptLBi2+WktIHGgmDcfPyqKqHK4Z9vrE2HZ5BIsTQEL
         PE9Qd/fOTRLE1dKhkxEwmjRF0V3DdeCDuADaA7j2RyjYsfJDVnf796aQXu3CJ8zfavka
         9JUJ6mouIiQ5Z0Mi3SyQRLq4yRE/K8c118F4K0DFsvyeW66lX9SrHsGf1TqGyovvPLsn
         /TZmMBKzkVmOx/K/OwvYhNIEZkiijQevG1e5Ub8bKqSS4ve+I4swBoUQcRDWYeRlgHPt
         XDhcgb4dFwAegsgQBdH4gi9rC3W2RF20uQpWiu8MtefOQ0LnTtlkAAQdWIBWuYRZItAh
         Wvsg==
X-Forwarded-Encrypted: i=1; AJvYcCUXx4VlZ6qFaf1+ERxTicQWGJzXtE6reSRNjGXP1PAa4h/ufg1lKOQvz08ypiC/bOG9uQ+vaSZBQPfcrgtUMSF9u29Wqq9wps0r
X-Gm-Message-State: AOJu0YwjxduawUtM7snJ77C1rDEZovmfW5pQ421GCHacN7HLJg/KQwr1
	L3cAePVJmILAE3Q/sAdiq1xy5fTibQPBRT80xOZXyn8u9orRFWU3tGestdArZC8=
X-Google-Smtp-Source: AGHT+IE5NrArO+Z9P37YYWccFEpP/QWBisJ3tCe2lH+0qm+o09xZjPivAHqJ2CRqKo67tYN9YnmH5A==
X-Received: by 2002:a05:6870:1609:b0:24f:c31a:5c29 with SMTP id 586e51a60fabf-25060d3357dmr371166fac.43.1717014773410;
        Wed, 29 May 2024 13:32:53 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2502a1a8747sm928176fac.21.2024.05.29.13.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 13:32:52 -0700 (PDT)
Message-ID: <ec2ac6fb-0f08-4e8c-8907-83bd8f0976c8@baylibre.com>
Date: Wed, 29 May 2024 15:32:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: ad7173: Reduce device info struct size
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dumitru Ceclan <mitrutzceclan@gmail.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-6-7e9eddbbd3eb@analog.com>
 <2f26b72970be841279ca00c1b5eb91dcfffabdea.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2f26b72970be841279ca00c1b5eb91dcfffabdea.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/24 7:23 AM, Nuno Sá wrote:
> On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Reduce the size used by the device info struct by packing the bool
>>  fields within the same byte. This reduces the struct size from 52 bytes
>>  to 44 bytes.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  drivers/iio/adc/ad7173.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index 328685ce25e0..e8357a21d513 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -179,15 +179,15 @@ struct ad7173_device_info {
>>  	unsigned int clock;
>>  	unsigned int id;
>>  	char *name;
>> -	bool has_current_inputs;
>> -	bool has_vcom_input;
>> -	bool has_temp;
>> +	bool has_current_inputs		:1;
>> +	bool has_vcom_input		:1;
>> +	bool has_temp			:1;
>>  	/* ((AVDD1 − AVSS)/5) */
>> -	bool has_common_input;
>> -	bool has_input_buf;
>> -	bool has_int_ref;
>> -	bool has_ref2;
>> -	bool higher_gpio_bits;
>> +	bool has_common_input		:1;
>> +	bool has_input_buf		:1;
>> +	bool has_int_ref		:1;
>> +	bool has_ref2			:1;
>> +	bool higher_gpio_bits		:1;
>>  	u8 num_gpios;
>>  };
>>  
>>
> 
> This is really a very micro optimization... I would drop it tbh but no strong
> feelings about it.
> 
> - Nuno Sá

This only considers RAM size and not code size too. At least on ARM arch
every time we read or write to one of these fields, the code is now
implicitly `((field & 0x1) >> bits)` so two extra assembly instructions
for each read and write. This could be bigger than the size saved in
the structs.



