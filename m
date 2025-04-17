Return-Path: <linux-iio+bounces-18195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0CEA920D6
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C65C19E2BF8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4323252901;
	Thu, 17 Apr 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k72PNw5+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C92512E1
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902475; cv=none; b=DbO5alwQS+6xPOyft1iuBZ6XcyA0CCwGRftIOV2I6/Z3BwfeYVDEQoQ2IKlcHRfaxPrrM3JMx7TPBxdn6QOlU+79a7FO3uHLdI/dyOfRHPx21aUdQtCb9jToI5dPA8ynRsgNmWYWiLFuGa3HB/NNXaCVaN3xhcSCRHV0P4g4II4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902475; c=relaxed/simple;
	bh=Y7sBMJl9huCoJbTO8M1vR4VKFo+G40GzBvX0w6rClRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hn6aYFj/Z47XhorTMzdS8b7V8S5Uus98MR865x4igaMUULZgwx/Xd5wjR9ZksbEawazWErCnl4ZeeM+lNKknmfCxZIpmeNO6+/fymEzVl04nwR6E7l88NfXke4LPP+tBjovZlUon5vMmcPvXtY151mtDYtfCuYDJ48ymno140AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k72PNw5+; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c47631b4cso521326a34.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744902472; x=1745507272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fO4PGom8r+nn+/7wCMZh1CHX3FkJE/YgsW+Sw+QFjaI=;
        b=k72PNw5+q0fYh1Ii9h+u2kScdyU9nAN+fbiTPZeQrCDmJOO5I2917xkd6mM0KZt+M2
         dyBFDCUW/svxMQadEE+GPC0cEZpee+UrHvWKei8KB3liNZ102VsOn0uaKhtjl7PYWuoO
         cjWsycULv95/gdurn8e1IyyCybDohAAo6q16CDvgZlMubFe8hlY1K33/1eONMZmSAzU6
         AKV0zO4nakjyeWilMsf1j6qeEQLL4b/cQPNzD3KXE0NUOJe5z0WlzOJQPvUBukF95wI9
         ZPbkRCPh0B4chRR8nUUZOPhBXv3eMQPgy2ahElv4Z5zOrG8Mihfdl5kmcOP1kLDW6Nvs
         AKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744902472; x=1745507272;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fO4PGom8r+nn+/7wCMZh1CHX3FkJE/YgsW+Sw+QFjaI=;
        b=Cfrj/Yd/l092o42X3eUjSDODjAsylWZ04QWScG4LvC5jt0g9SyrwNuJNFQj6Kl4oWH
         R19/dL3azsXV/dLXwJu6u5taFS8zWLRXayVqU41gCUm0XpMo/cUF17k9kNhtl64f509t
         wKM85l9PFKg7Zl8L8d/0Cei3LE981r1I/VmDkpbsHmV9brDT1FqOdGXcJv4SZDyo3Mdf
         MK9jMViSoFIED1p1HXlxZ91JdqpHbndeT7V0E3JWocGHbJJ/YTZxoG5lw+TTZErgaCTL
         hkRPzeU9dDVq+3fWKUbFLPLWo/b1Y9oNFbh15cK6EHA73+/YuEseMnnBJxzN59dDTf5X
         6Rkg==
X-Forwarded-Encrypted: i=1; AJvYcCUN47/2qYpqqimTobbqFkuQLOPCX0yIpP1JTNU3PfTXAzM1vlJDNxx554/fdSWePQtUfdOvHRNxUVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7osbh0u7BL5EAgmljty979HVWjcEL3cB8oosiiHX4zRdSJiCC
	RkcGFtzAzHqfsTTJS4Ca2H0LcVdI2NXMGCVlCIyGM5VIjlkoUBtAd9JImo5nXHU=
X-Gm-Gg: ASbGncuPaNzmzCtAEQtLKgfL/weT3MK7KoRF2oZ6FoRARfKtJLYXJC+7/M5q4gZSFQn
	xTt950H4eUxd07QQBs3ee+c05bfn7MvgMurIxNBD53CvYWlAc6GxAw5OusE2vvgcDbRG8wv/Taq
	ui7Pg59Or4d2K6t1RZD6RTM9Un8Z38qKF5pgFJJm8dnK12HDgIrGcwbvxanDmL7uO0DqxyjRxbP
	cb2wKB1RbTH1lAekVnytt7tdUND542RikDb0Ssc1gu+frokPoXIaoHlnMv328W8TW9hIaX8o3dC
	o/BvI9R/Q4QAxVTMRbKiBE9k3e2fKl2bvgUyuGG0ctYR4GUXt73WX5BXafjvpj/9tnek5TuvVb1
	+yJXjiG+2I12OYOjdqw==
X-Google-Smtp-Source: AGHT+IEYK1dnPkBo/RCRsPA4Fw4LOSVoCMCliXwjzRUw7NtO1yHMkAzC2RAg+ysD2YBbHrA5uY1uvg==
X-Received: by 2002:a05:6808:800e:b0:401:bcaa:c52f with SMTP id 5614622812f47-401bcaad927mr147985b6e.38.1744902472319;
        Thu, 17 Apr 2025 08:07:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee? ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-400763bab7bsm3121606b6e.45.2025.04.17.08.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 08:07:51 -0700 (PDT)
Message-ID: <d6a636c7-36df-4648-92a1-2db1ff4754e6@baylibre.com>
Date: Thu, 17 Apr 2025 10:07:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/14] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
To: 3027a9b0-cf4a-4e55-80a7-7f0dd2a008e4@baylibre.com
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
 <35481552e9ce39a24a0257ab001c0bcfea1a23be.1744325346.git.Jonathan.Santos@analog.com>
 <3027a9b0-cf4a-4e55-80a7-7f0dd2a008e4@baylibre.com>
 <aABJ4UuFWDsJX6vT@JSANTO12-L01.ad.analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aABJ4UuFWDsJX6vT@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 7:22 PM, Jonathan Santos wrote:
> On 04/11, David Lechner wrote:
>> On 4/11/25 10:56 AM, Jonathan Santos wrote:
>>> In addition to GPIO synchronization, The AD7768-1 also supports
>>> synchronization over SPI, which use is recommended when the GPIO
>>> cannot provide a pulse synchronous with the base MCLK signal. It
>>> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
>>> a command via SPI to trigger the synchronization.
>>>
>>> Introduce the 'trigger-sources' property to support SPI-based
>>> synchronization, along with additional optional entries for the SPI
>>> offload trigger and the START signal via GPIO3.
>>>
>>> While at it, add description to the interrupts property.
>>>
>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>> ---
>>
>> ...
>>
>>> @@ -57,6 +80,15 @@ properties:
>>>    "#io-channel-cells":
>>>      const: 1
>>>  
>>> +  "#trigger-source-cells":
>>> +    description: |
>>> +      Indicates the trigger source type for each entry:
>>> +      0 = Synchronization GPIO-based trigger
>>> +      1 = Synchronization device trigger (e.g., another ad7768-1)
>>> +      2 = GPIO3 pin acting as START signal
>>> +      3 = DRDY pin acting as SPI offload trigger
>>> +    const: 1
>>> +
>>
>> 0 and 1 don't sound like trigger outputs that this ADC is providing, so don't
>> seem appropriate here. But the SYNC_OUT pin is missing from this list.
>>
>> Also, outputs could be used to trigger anything, not just SPI offload, so don't
>> need to mention that.
> 
> You mean like this:
> 
> ...
>   "#trigger-source-cells":
>     description: |
>       Cell indicates the trigger output signal: 0 = SYNC_OUT, 1 = GPIO3,
>       2 = DRDY.
> 
>     const: 1
> ...
> 
> It would be like interfacing those output pins for a generic trigger
> usage?
> 
>>

Yes this looks correct now.

I don't think this is the case, but in general, if GPIO3 could be programmed
to have different trigger signals, then we would need a 2nd cell. But IIRC,
it can only be the START signal, so 1 cell should be sufficient in this case.

