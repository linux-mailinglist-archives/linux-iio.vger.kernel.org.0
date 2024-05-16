Return-Path: <linux-iio+bounces-5069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C968C7A1A
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 18:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDFFB23128
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12ED14D71B;
	Thu, 16 May 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRICpor3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E65614D439;
	Thu, 16 May 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875777; cv=none; b=GhF6jZNpQlJnWZxt8I/91/PUMX3XtLQPUr2zmvVxgm+/kVUWCRl6YHDuSkfjzn36ixl43nK+m5ELrKbrL0wT/5OQlJgDAZKUVQp42jPnbUeov+a+DA+sWXHXDyseFWDGa5VW/i09CsZkn0nNmFiJNs7SvHofG0EBIeQVi/9Cq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875777; c=relaxed/simple;
	bh=+glydexQE7fiHXjBOHgMNecwr0JDs2Rg9OOMZ/GodlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VY8MfYQ7FyKBgmryzOQPg4ideLvoEGq9eDc9jA0nZF5IT6psB8KkzS2T60182Ett8/ThFQ3dif0hOsPCLXkdB41zNRRS+JIg/4Raec4gOnCayA58NLO/zHUGI2oNbMT0Qg1S/XxcNS0QO3vggZbYnGaJodKh4hc5MrdD6fKx9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRICpor3; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792b8bca915so794025985a.2;
        Thu, 16 May 2024 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715875775; x=1716480575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPp5T1JPGHPpYJQbls80ItD5pnxytYOAxOPDKu3Bv/c=;
        b=bRICpor3cpJ3FJj2D30/0Hf+22RgOKmYEvHntnigzy7jWedLPl0rqT/UePU/iXNNiA
         sZTQjOxBxDm0+QpFuhRUl4YJWGqov01ch4qwBpFmODTUjcnI+brcpfsqHig10XRvPvaf
         PDtETvdrdoaB2Re4bzPhv05Ze0rbXfTT3HJdh1J8gwwspFGDCaVlQtWi4NeeWlttYRAh
         SBjKL68URWx5gHSsPVrmZ1hApj/u7h4KDTzum54f5BvAm5ERk/hRMTMGDYEEt1Xo4wA6
         qGQARyXoDq1/thyN7qq0FnqS8lcaflvObtA8zOyUvq5fzeQFcOv3Nd2KRwjRAdzh6dcd
         QqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875775; x=1716480575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPp5T1JPGHPpYJQbls80ItD5pnxytYOAxOPDKu3Bv/c=;
        b=hMPFxdLXC3iJCIPvLUBF9G6cloiDU9z8G2nX79sk9/DC+gw1oUci9AZm+FVk3aS/34
         SK5Dn2F152G4aikbtH1qcEUyphQXuwdn240E2Hqvda/cdjliiBLowGQTixHuN20QfvAX
         yxe0tJy5R2i/WIDt0keG2zf6UKMrtfsNGaUSElenjtWxH3gZjhfjovXsZHbmisL8uwCu
         bPuOVG8ovAysi/3Oe0QVtaNH+z9NWm878btpNJjlvz7Y+UvliyrQ0r1Pz7YOXm5OdVQi
         EMMkEwxepAHCmODAUiHMYy5qIa+XhECWlJUNkXAO2MhAwYvoc443mIVmHEFmdvUAFpPA
         3upQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoCapotEBO20hgeMRv8zSgTq7/8Dlkov4yrFpWpw2t3kf2RpCFv++7jsLAH6QaolTZSAAJxOqfOu40OIk4VubpUVSOwo7kPuWm0j+Hf8STVSjaXtxPb3BAjNQuj4hzUiJdwFNVOaz01eunDkrVzQVvWec4MsCvY+smOb7DqvQLiX307A==
X-Gm-Message-State: AOJu0YyeQk0s17CFTY3SHlQLm7TCd/9Cn5feobnNdVOs+qrLYw73Fu4V
	mURAirdjJTgTqNjEZlI1fkSUarNOMY7ApK7P8asm6e9IGOYh2l5K
X-Google-Smtp-Source: AGHT+IGgKcdKMp71u40k4XXjlJzPQGfIbERyni6tEZCb7uOwRuVKpWL3S37lr0djuEPl1YQGDkEi5A==
X-Received: by 2002:a05:6214:5c42:b0:6a0:7cef:9883 with SMTP id 6a1803df08f44-6a168152c8emr231301216d6.14.1715875775019;
        Thu, 16 May 2024 09:09:35 -0700 (PDT)
Received: from [192.168.0.137] ([188.24.105.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a3e849f8e9sm1253326d6.33.2024.05.16.09.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 09:09:34 -0700 (PDT)
Message-ID: <167516cf-303b-48a5-ab84-173cea8e82f2@gmail.com>
Date: Thu, 16 May 2024 19:09:31 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] iio: adc: ad7173: Add ad7173_device_info names
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
 <20240514-ad4111-v2-6-29be6a55efb5@analog.com>
 <CAMknhBGrn+dSF=QJngUWaQ04tAwQf-9wmq0V2OgYS7sFKHroUA@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBGrn+dSF=QJngUWaQ04tAwQf-9wmq0V2OgYS7sFKHroUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/05/2024 02:32, David Lechner wrote:
> On Tue, May 14, 2024 at 2:23 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Add missing names from the device info struct for 3 models to ensure
>> consistency with the rest of the models.
>>
> 
> This affects userspace, right? So probably needs a Fixes: to make sure
> this gets into the 6.10 release?
> 
I don't think that it breaks userspace, just creates an additional file.

This creates the file "name" in the iio:deviceX directory that reads the
string. I do not consider the Fixes: tag a necessity. I consider that it
resolves inconsistencies in the _device_info struct. 
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  drivers/iio/adc/ad7173.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index 1e9ba3070770..d965b66d4d5a 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -227,6 +227,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>>         },
>>         [ID_AD7172_4] = {
>> +               .name = "ad7172-4",
>>                 .id = AD7172_4_ID,
>>                 .num_inputs = 9,
>>                 .num_channels = 8,
>> @@ -272,6 +273,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
>>         },
>>         [ID_AD7175_8] = {
>> +               .name = "ad7175-8",
>>                 .id = AD7175_8_ID,
>>                 .num_inputs = 17,
>>                 .num_channels = 16,
>> @@ -302,6 +304,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
>>         },
>>         [ID_AD7177_2] = {
>> +               .name = "ad7177-2",
>>                 .id = AD7177_ID,
>>                 .num_inputs = 5,
>>                 .num_channels = 4,
>>
>> --
>> 2.43.0
>>
>>


