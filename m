Return-Path: <linux-iio+bounces-23777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35119B4589B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963797C4BEE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101083451AE;
	Fri,  5 Sep 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xxBeQ60l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3961D90C8
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078323; cv=none; b=RG7EDuwkHLmNGPp9sA2HxBS6D0jXhn5IwpDzAN26EPGVklQRywsp5mIU2dKxp3fj4gbretncuUtDC3QJIVYTEMgYbydofHq504LRG23BztoIJERUjGqmEzS8A6cy0DSuWUKrSUxRlnZSHsBy22Xpnps6BVuqA3I6GMoLNz2MVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078323; c=relaxed/simple;
	bh=PIam7/m1K9PLm4L0jcQY+prj0AzYeP/tg8hGBiPIGRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieiaBIV9F0SVC8HMEKhsJmUz+fiAIg/7uwEOKuKpB2G6MYzNoIVLaVcUfhJ9xAW82hIGF/f/jIpBf6x4mYpXaJCh3Nd0mchrRMbxGaOhYUmSu1APMiz7YJFPrCLKr9JHPenGauwJdzlN9yqKJOaGEClmmNBLx3LNExape8/hmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xxBeQ60l; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce5be7d0so1104960fac.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757078320; x=1757683120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9TLIpS6DZeFRvn5V0GqnS35zXXGwC7qVEOe9mwxEto=;
        b=xxBeQ60lCSeI2HNOz6YxaTwWZlRmvmXvidMvvZ/FBt+ryvwxGxaWw+zfnVyBBdnK4o
         nFBdFTqzVAbCENK3jJvmuZv7DQyhMUh5o08SzUHPGotT4dEVp+aY0LtIW8kaILeh7O/2
         gWhTZoqq0Sfsyb1GolAjjpYIcrEd/tWHwCj6kWRkgDeQsfsX3FDCUF8LEplnEKCoWJ2u
         sfgPEAuTStMIPfjptT7Gz8uIrwVLDatkjhZU/4Tvo28fazqfEPaSLfnoUBX5r1mc1Icp
         FRkPruWLey4fgdQ23iMTWG5840m3qNOqB1BEUVKuXCesCP0f+9lZS5ThIb9rVLIdLQm+
         bOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078320; x=1757683120;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9TLIpS6DZeFRvn5V0GqnS35zXXGwC7qVEOe9mwxEto=;
        b=Qy/cDbWZXshm3yzTJKJvddGQA5BknYG7Zz5urPIkh+L+kgbKM2Bbdwz0BuVcCHdD2t
         OGZ6qyemB+lvxNsCAR96oK3OvsGgAVCbocrgUwxUcYiuqpT1Ic8BcCvNXnUkdAXgx1QL
         4R03sqTafNykwA+CFbTk0h60UzpuM+VM2pnYJbDFDUNe8fc+7YE24RNehsOCYcsKUN82
         jixj/iNMcRDbe8CA6sOshoVfMcRwu8Ukr7YD8k40tyJxuVB2GnU3BnOrlwYs5vF5hnqd
         KxPk76eYIc2YTOh4bufuktI4gn0Y2CL3cYkIPJZ6LWRsKdqMNk4+UM4UBA8AcRQf03wo
         CEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVfFxNTtDtQXsOMoSyTNs0yVs+dTxzXBlbDoCAj70Ci63z/qK2FvvKFFXfhY1AtdkNnXzxhoJWQAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmykztJPKvjwMQwQ1qYh0pI/ktsu18+IvfJBMUT+2g94PPeio7
	a3G6VTDxUfDhQm/QEPKE3wshDxvhaet7u/2whX6yjG9HSvIzc2Vuwtl4TXHp1646Kj0=
X-Gm-Gg: ASbGnctCSQoBJSe43+ZpCzmDiBw4MOi7bzYCDpCelueT27QgmCfIWHZEHWGqd0eCiX6
	XUFiXNz+Qh7VPeBVBOfm5LumugRAnf57GtdFwd/DOqopHtloZu/h/9Yi+1uAt749xpiEon9LH7V
	lyO190QqHyfueNZnHWpovt6zMfUPCDaaBOdxxY2GeNpkG0ZdSlSmO2awZbnfDRX0mMTstTTl+aZ
	eeZ/SsZmRhjD1eMne2cNezi34nlBYXNtm5YMaFlq62oTArnnhult/OX3nXpuXzwfANgx4fhDsOz
	gkGs2d6HWFNkT5Bst1QgfXjaDIqwFC0NQjjL2xv7KQ5OV+MPNrO6HjItOY0KGoEAeyxFUKkb4LV
	d0Jwkgaf1S2AljZckKnJv0Dj1JZVETURXgahavK7V3UswPzPmrQWY0emKoRNvZPPqyaqJEhEq
X-Google-Smtp-Source: AGHT+IHyoxG6K9p+b3Shk6yuqM1oSIsNJ35yj9FZbQDKHKWiZhaNJK5mV8FUrwQzu5hPKQ4b6+5Ivg==
X-Received: by 2002:a05:6870:cb99:b0:315:c171:a0ae with SMTP id 586e51a60fabf-31963194753mr10066349fac.20.1757078320292;
        Fri, 05 Sep 2025 06:18:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d63f159fdsm2922413fac.14.2025.09.05.06.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:18:38 -0700 (PDT)
Message-ID: <d9aa680f-0664-4caf-b885-92c3fce6c7a4@baylibre.com>
Date: Fri, 5 Sep 2025 08:18:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Pop Ioan Daniel <pop.ioan-daniel@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756988028.git.mazziesaccount@gmail.com>
 <facc8b9255a754f767807b7e5c79c0eb20c680e4.1756988028.git.mazziesaccount@gmail.com>
 <aLmVzDB4bk-z5d16@smile.fi.intel.com>
 <796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/25 12:41 AM, Matti Vaittinen wrote:
> Hi dee Ho Andy!
> 
> Thanks again. I really appreciate the effort you put in these reviews! :)
> 
> On 04/09/2025 16:36, Andy Shevchenko wrote:
>> On Thu, Sep 04, 2025 at 03:36:46PM +0300, Matti Vaittinen wrote:
>>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>>
>>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>>
>>> The IC does also support CRC but it is not implemented in the driver.
>>
>> ...
>>
>>> +/*
>>> + * The data-sheet explains register I/O communication as follows:
>>> + *
>>> + * Read, two 16-bit sequences separated by CSB:
>>> + * MOSI:
>>> + * SCK:    | 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
>>> + * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
>>> + *
>>> + * MISO:
>>> + * SCK:    | 1 .. 8 | 9 .. 16 |
>>> + * data:| 8'b0   | data    |
>>> + *
>>> + * Note, CSB is shown to be released between writing the address (MOSI) and
>>> + * reading the register data (MISO).
>>> + *
>>> + * Write, single 16-bit sequence:
>>> + * MOSI:
>>> + * SCK:    | 1 | 2 | 3   | 4     | 5 .. 8 |
>>> + * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
>>> + *
>>> + * MISO:
>>> + * SCK:    | 1 .. 8 |
>>> + * data:| data   |
>>> + */
>>
>> I don't know how to read this comment. In the monospace font the whole block
>> looks like a mess.
> 
> What do you mean by a mess? Don't you have the '|' -characters aligned? That's very odd because they are aligned for me. Or, is this otherwise unclear?

I find these diagrams very hard to read as well. I would just drop this part
and let people look it up in the datasheet. I don't think it adds anything
essential to understanding how the driver works.


