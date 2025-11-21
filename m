Return-Path: <linux-iio+bounces-26375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDFAC7BE32
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71F604E15BD
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1325F7BF;
	Fri, 21 Nov 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l9m7Jqtj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A62F60B2
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763764858; cv=none; b=MTn/0UL4AxlfAUOUUzl77DGU+RuhvR4eFMcZLvbMCK3Zq59TbVWeL+pFws2dakGUoO0ZOE3jjnrS35XPfl3GzMF2Dzm0B22V9ATzKL8cGvKejizWel411rqvc1qmuXg9ynAIrYyyqK14oCsPF+fMoGIXd+sxlUB+MqhSoHPRwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763764858; c=relaxed/simple;
	bh=Xtbd/tDrpDJ+fRqhe/V8DDd/AxQSdS2P9J8yChwZUWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mF/G0c/nfiU+wXjfe8c1L1vcw/LPPIn35UwKhjZi9WxIXojGRWc2z/xyuL1fWSagTNRpzykM1zJNWu6Aecqaw2g170a9JxB3esvQAgIQusDsE9H5xXCM0ZGtR6OHGi08j7HQ30vbPuLaip6zhaKM4z6AiC7s+PL3GxufHP363zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l9m7Jqtj; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3e898ba2a03so1665612fac.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 14:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763764853; x=1764369653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9HltdgSop5FEcwGaXa8vPayworSeD5MYQywbM3e3j8=;
        b=l9m7Jqtj9YGxZgnBP8/4bFwRgTHupwDqB2B72BQLrUV67PPZPIvg+i3quzscwAKhLm
         mxDYxHpxhsHZPTHOp0GJL1L3CCQ56LYJ6YtrLZvp5ILFFXSvugcSG/22vJe3j6Fmyqv3
         6DNAMfHGwkV91jrqLz2w9czmTNkr5/W+gsNMNYzR9Pdd/Y1AFN6TUoer96nXRW5lc+d6
         oh+O970OVzzbC5PQu881PaO75gYrB6s/G5TCdKc7aEAzQ5OJFnVYKh74ARC9PxX2ChFy
         mWPr9i2WIyhzKc8VVOj0vMQFPIOLSOzXOFLmU+UlH6lOJ6WYJtMgdaqH4HG/6GkHLh8F
         rHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763764854; x=1764369654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9HltdgSop5FEcwGaXa8vPayworSeD5MYQywbM3e3j8=;
        b=XkQKsSQJ1reyiCww6B5Y169e7DlQL+vfE/DSsE7ghFiElRob6EvXi0SUHNdwVyFGkI
         tTYQORjmWeyC16Pbt/3AAXF6yKQzMYkQp1XZVpTjNp7m4naU7U6fSuW0jV/r5EWbZTY5
         tzJNPVBLqWzZxboEACgnj6R3Zo0jSCdNqZ/0qTZlstMLjIbavsnaZTMYllAZ3ou7/97W
         w0RKQJ55ZKVUQkxDK5TZyTOk1JqhRA8gfOSaP5Xe7LPV/YzDU7+kP81jAcpacHp+QlCF
         /RMTlISru4788+pEwTxSVot/s12QsVX+d/vQhww+0Vl/D2Hk3gB69aH09OdJKqmjomKz
         LYYg==
X-Forwarded-Encrypted: i=1; AJvYcCVG3xtenMqZEZ7aJaEN11GmAE1z3XmoAdXQvkYySD7Z80EEmK7qIcWrsdZPUsO/2cER+ga6eYaFjls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrLJ8V+fPVI5DQf3/jTaU59BbcJEdnWEpHKx3WRZC1dEXpShA4
	F6JXshGzmgSbMsGnWn3Qw6tHvPZWJ035b3G6LUJvqrIEzwn77237/oTriF3Waii1maM=
X-Gm-Gg: ASbGncsW67kZgSSSqrkwEUQ0wAsefJ8dmoi1hCczFCdr8f2dCaFXSdl4CSTmQvWyTtd
	a6odapGwFiK1+xXJKcf0GPZfcv3gHMiAgT0O/BEzpWJo0LBO2BQqStfvLU6PM/FIQ3KT1rkPiaa
	zZd5rp35MKaCb6KPRbBHkMYBNV6wUuT9sFgzHrYMdaEMpnT7Zmvf67mTXeX6ITljw57DCPHXotL
	SK0eg7gfdAh9z+lMwpAWVj2yGfOGif38Mk+jq/6XEccbJW40E2P49LgV2jVHt/BlKm2tTSMcqJh
	bpNwH9MSoue/Q6ATmzDbHgFJIj5+2t4xksPTQq0km/yS/WEfwYn9gO9V+2JAxfXM2al47sL81Jg
	9PlloAmh54VTVr2nVzcLpz7Zznv1WoPDJzCqFssTApQPtY3Czc7srMC0qfM+zTdvHVPL8IktjtH
	TfG9rl60Yjw0lS7KgP+NIDkop2ViWv0Viz9hmlD5U0y377G5fBqBZurTu9XeNV
X-Google-Smtp-Source: AGHT+IH/slIetdPjT1yIwsdNKVVzy5MESsn9ZF/43EcVZTNE94DWi1oupV08GRdpE1jhr3gqCvmzvQ==
X-Received: by 2002:a05:6808:4fcb:b0:450:390e:61da with SMTP id 5614622812f47-4511294f265mr1829497b6e.5.1763764853687;
        Fri, 21 Nov 2025 14:40:53 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e782:93d8:7c2f:f9df? ([2600:8803:e7e4:500:e782:93d8:7c2f:f9df])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fffbd109sm2075774b6e.17.2025.11.21.14.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 14:40:52 -0800 (PST)
Message-ID: <2676d37e-fe3c-4504-8990-fbee0ce8407a@baylibre.com>
Date: Fri, 21 Nov 2025 16:40:50 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
To: Kurt Borja <kuurtb@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tobias Sperling <tobias.sperling@softing.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
 <32e76bff-f535-40ce-88e2-7bbf7da87620@kernel.org>
 <DEEO8SSA15XY.1SDBZEILR5AHM@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DEEO8SSA15XY.1SDBZEILR5AHM@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 2:56 PM, Kurt Borja wrote:
> Hi Krzysztof,
> 
> On Fri Nov 21, 2025 at 2:10 PM -05, Krzysztof Kozlowski wrote:
>> On 21/11/2025 18:16, Kurt Borja wrote:
>>> Add documentation for Texas Instruments ADS1018 and ADS1118
>>> analog-to-digital converters.
>>>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>
>> You did not test it before sending, so no full review but few nits to
>> save you one round of reviews:
> 
> My bad! I will fix the errors. Thanks!
> 

...

>>> +  interrupts:
>>> +    description: DOUT/DRDY (Data Out/Data Ready) line.
>>> +    maxitems: 1
>>> +
>>> +  drdy-gpios:
>>> +    description:
>>> +      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). This allows
>>> +      distinguishing between latched and real DRDY IRQs.
>>
>> I have feeling that you miss proper handling of IRQs (e.g. active level)
>> on your board.
> 
> Can you elaborate? Should I specify active level here?
> 
>>
The problem is not about the levels. It is rather that the behavior of the
interrupt when disabled/masked is different on different interrupt controllers.

On some controllers, if an event happens while disabled/masked, it "remembers"
that and will trigger the interrupt as soon as it is enabled even if the
condition doesn't exist anymore. Not a great hardware design IMHO, but there
is real hardware that does this.

I think a better wording would be to leave out "latched" and say that
it is needed to be able to distinguish between an interrupt triggered
by the DRDY signal vs. an interrupt triggered by SPI data.

