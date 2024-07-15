Return-Path: <linux-iio+bounces-7623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53556931913
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 19:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837B9B222B2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160554595D;
	Mon, 15 Jul 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbeV1cf9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1D1CAB8;
	Mon, 15 Jul 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063863; cv=none; b=KL+t/zQTByrxoaDUY7RU95NSZp4+3JLJ7beBJgzOte5UAe0UZH4uambYwVHLV1vbR/EeQtc0baI0gQpnzYmZuatjvAVv1ZxD5cLXpmJ4FeN96RqOzodnNCt1K9qXoxymrV2hXWakKWnuF9KFke4fgS5NErpFbXAFsX0TiKMNXQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063863; c=relaxed/simple;
	bh=CP6B4FU5BGjNfFAyX0bA+ci8+6cdVqSIN9JoOei1234=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gffu+fYqGhIFbrsBt9fq4On5YtHaSD0nCqX/zJ2nCiAzpwmrTUpRXkbAASXqn1eE9MoDGygHTGOJgp5FXglBaEKtjXdU5jywnTB6bgsuDDvb6gUh14OM0nrCG2ERo4jmm1DKkImXU2YMiIMud1aeAcz7N9DyAnMiYLPDSMFyt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbeV1cf9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-426717a2d12so27319395e9.0;
        Mon, 15 Jul 2024 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721063860; x=1721668660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjxPI2IrTb4z07FeQySRDzHxyzHoRNB1TeL6fAKGl10=;
        b=VbeV1cf9gAavSn8Hw3+D5gStKa9lZRF2NO+fQtfAkQ9DWbj8RmTaMEQXqTLu0Tj2hW
         RCf+MOLm4rJDHtYjKC0NY0cP7joKsqeueYvtsWOlU5RfofoQ3eivwznmVWTHebZfI/ex
         A7ngFf0Kryuo9ibPWrwLT160bU27ZiBuiQP92ZFoi19n64+OauSo7Yo/8VkR6Y17UlBz
         Nt7R+UcYy9trMooeDqdjDsRcR5TxOldSzqRfhUyLHVhHP8M8ZIoqtW5qeXTmFAxSoXtr
         5MQE/2bjNkuVw5CcTLdev9wireuSwol+50E4dmwncgOd1gfJ8roKZUTFo2eDyIOMAVl8
         O9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063860; x=1721668660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjxPI2IrTb4z07FeQySRDzHxyzHoRNB1TeL6fAKGl10=;
        b=aJwc8NJQFXjreu4f6FJ+GFSQTPIMOJeX1aT6XmZaue33IBZ8MzZqdp10wYZs0hYg2z
         3zK3a/Dz6n7TjsvPvuN4T4wD1sCJtf1inTO0YOHhzZXx4iiF1RznddesyG0Tg6nl6roW
         nWJhV/kPjHImqcHy6SqP9W/FGXcisNhusrvB4bL/nWidTBqBX9t18WyLoMdVD+BaT5Cc
         RdykACXSWUbQkU1bN3HRsU81WggtCciYwB1gr6VjM4DGu92aa99t8GZ87cTtGKk65A/6
         7qY9GxbeK3SHaEwJgbsrmglOGyeCFJ9RwYecnk/w9oOvXFsMphV5NDjWaARELPvYdmk3
         NJig==
X-Forwarded-Encrypted: i=1; AJvYcCW6MZDB9plyQiRnWZ4XWdRE9ABgrIS9OI6pYMtIkqnPLAU+Zr4Y/rbcDCbdGCdSFb++cmy9d/n7cPCY+UsKtN+1JSV00wxtpMCMdg57Io00rc1wkNIJWyrIgAXv0fJ7O4z0Oa2Dz2D/n/IEpZXO64RYEbS8px87xA46JVC2qOWUmv5qfw==
X-Gm-Message-State: AOJu0Yy2NjVly1krxyGgfuEzl2Pjycm0XyowfHzU7GMf5fLMxSQL8aD9
	tzzZ7iPWtSI0NDqYs2Ji+hC1ZJIrOa9fE3hKpcOcbKRg1N1MwM6i
X-Google-Smtp-Source: AGHT+IFqEW/LLAqwLYOFV74GlOVCXhMKMLkfWBKyKAWoVPNP3SV07U+FqTRK+n4nkLwdD9DzGgf5+Q==
X-Received: by 2002:a05:600c:4f93:b0:426:5fa7:b495 with SMTP id 5b1f17b1804b1-427b8681f44mr5676885e9.15.1721063860347;
        Mon, 15 Jul 2024 10:17:40 -0700 (PDT)
Received: from [10.100.30.87] ([37.110.219.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427b6133e73sm23604075e9.48.2024.07.15.10.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 10:17:40 -0700 (PDT)
Message-ID: <68a25946-247d-4351-b847-35605220b16f@gmail.com>
Date: Mon, 15 Jul 2024 18:17:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iio: adc: ad7173: Add support for AD411x devices
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
 <20240607-ad4111-v7-9-97e3855900a0@analog.com>
 <e48b2dee-11d2-4dbc-868d-10870e3c07dd@linaro.org>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <e48b2dee-11d2-4dbc-868d-10870e3c07dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/07/2024 11:12, Krzysztof Kozlowski wrote:
> On 07/06/2024 16:53, Dumitru Ceclan via B4 Relay wrote:
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
>>   ratio of 10.
>> - AD4116 has 5 low level inputs without a voltage divider.
>> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>>   shunt resistor.
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.
> 
> Best regards,
> Krzysztof
> 

I do not get any warnings, only checks

If you meant the checks:
- for the alignment check, i would only argue for struct_group(config_props that looks good
- for unnecessary parentheses the compiler warning appears without the parentheses:
      warning: suggest parentheses around comparison in operand of ‘!=’ [-Wparentheses]

