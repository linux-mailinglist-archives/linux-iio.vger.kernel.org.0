Return-Path: <linux-iio+bounces-19916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA59AC39BC
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 08:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01AC3B2BCC
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 06:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3151D5CD9;
	Mon, 26 May 2025 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWEpUzTh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDC142E6F;
	Mon, 26 May 2025 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240280; cv=none; b=SgKUDFAMVHTfLCY049snq7jJNyNINit7/MQ6QdgJN1MP4oIDtD59PK1pCryF9nZuhkiHUbpwrPlENRtal0Z/vM68TUyB/2fVpjOTk9XePwGJhkAI4smisgWtLKc/t0vU2XuBlkDB6ErHtqQQYimfJuzt3PJRSseblGyu5qTurJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240280; c=relaxed/simple;
	bh=GC6lIo2tQhKk3CPHqsWn4fEcinuknTRzKv/9oZtIsSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koZClu5+uuXUF4q+r2xQERq0QrOJAiGYnpgpKfPMsweFo4V2l+Zh/Qv85+IXiUA9fI5Wm0yKZjOk11fJ+UUG/Gwf5/1IIbPf8c5zRvI36zsRsKoLBIV+klI2YO3H9dGiR/dLkkTYDXpUqyrffBp6oEg6ROCZ5KeNiMX5bA/b0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWEpUzTh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so17623831fa.2;
        Sun, 25 May 2025 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748240276; x=1748845076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vMeQ54o9TnB3VgIIlXDVjn611bWGGinsbZIDgo94OE=;
        b=XWEpUzThGWD1AEOSQFMHfKP0RI28ukxl/eGCfBak/o7PXZcBdtCS6V6SIakeV1JJB2
         uJh5P3cUVds2gW5O0oixGi55y3CkJZcUGwmyoBUi99ZHrrV8x15CKYXlp6G3Nhg1bOmX
         ZgYojUYgx1+EidvRQJg7W0n77NVOkz7nue89mmDBfSddMVWrobAaE3QBugkPLY/KkxQ1
         NXHP5C3edElqnwArDrek3Nz09onW7mcJEZo//X3ZV2oh7KR0ZWtnVNjHuowGym1Fe7mG
         ZgpKxYLoVJHTJJx4vtLwdMmmk9Iy9k3SVq+sRt7le9xQSHM3H66a87h3TfjlVcpP0Lwx
         z7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748240276; x=1748845076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vMeQ54o9TnB3VgIIlXDVjn611bWGGinsbZIDgo94OE=;
        b=mx5XI/o9DVlcOjHdzi/Z8wjnRMrL3gMZKPtuPI3ljcpAYqOfEYQGEAXv3T4PfCugtE
         xDlq2DJ7nzpgXrdIft4c/OKqTyCyVDHQjoQC4GgaFM+ASggUbrgaSGKByP7v6PcvfcVb
         NbSraE8Izl/ldlt6U3alSPrD1sPJrorbBnd1XLZBBrUWgyynb0m0ofiZW1K4jH1OpbdB
         +6e/jFUMzxwWWRxD4KrHOZBxKyBk3DcxZVsXog5bJZMps8iARWij3ItiXhFHby++yuyh
         OE3IuPlD1XwU4czLu/jARlhkdGb7ockC8CNCC75zNTdd4f/BaV2zh+hDsWQfwiVmKCxQ
         zYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdFnctvwzLI6/sxjkDdbDAMpNi7vO3R8rPC1AE34aDGkEufUPstCIlL1VjEbXQyQVK5Zf7GMDG0kOTOcaU@vger.kernel.org, AJvYcCWoVZuyerWbQbGt1AfS8COGYeCTNMS1C0kk4QPzvHUYgvkcxj3UKJXjfkXhm/fe9nWuPPpXvV/PUAMR@vger.kernel.org, AJvYcCXFVydJldGduvCmxOQSN/ha8GG8dDkcurjTNW2FfWOw/sH+Po9sN0wB2hAqOMWdQzZVyGCwL24Nd0TH@vger.kernel.org, AJvYcCXYLxu6pcIV1fp+SE/amocqFUXUZCIUS+B+r/hVI7yUzCjWzblCx0GteimlJnh2xzDIL912GaAfrhqr@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfJMdzDqDSrc+OGZQPeP2ELyEnEHrOCvvL8JgwdqbvfdNwZvJ
	Ok0lR/acuK8OJZwYanKi9kUvU7HR5IA2VSFJw3PT8isxCzM1tzI2ccXf
X-Gm-Gg: ASbGnctNenlsHUwTPvDxRhz9OeRaynTu9Ux9FRbK9X9qNnvmQR3WpX/glSaMQuWy6mv
	19JcFKcoke28g/V7WuFULTdyF/K8eb50OanNCHDTMTsMMtwnoGQRYg54QjrlmXb051anVF17Kc3
	mQCRu+75TkJP5I2gVasDV1iQFCKd4WCq+YC3LGUFIbGnvZITA+eZYcPfIHUyEwamzkG857vGs5C
	jnS7kpI1MV4EdGJoPm1ksYFY1ZEr2C54WBTdZfMOxEJyRI40uUuMEMcH+oXZ+NUkVhEtPpjn33B
	He1D6NOjDR440QsQGEzTVFvxQbe80evZTSsgjOgEAO49J1IewO6KKP1XyLfp+yt5PzfLVTgC3zU
	U2tnmuly/f6ge2vbF1xCFZffCfPeWuvH3
X-Google-Smtp-Source: AGHT+IGjVdurNWq5CjPhUAGuoNKU5WSMmCrsVboH28rCb4khRS2y2dqmi564deDuOim9wZTt8zJzag==
X-Received: by 2002:a2e:ad11:0:b0:32a:66f7:8a0d with SMTP id 38308e7fff4ca-32a66f78a65mr810181fa.32.1748240275832;
        Sun, 25 May 2025 23:17:55 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3280ca53e3asm43997001fa.97.2025.05.25.23.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:17:55 -0700 (PDT)
Message-ID: <f8ec547a-5924-4563-aa1d-dde8227844fa@gmail.com>
Date: Mon, 26 May 2025 09:17:54 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad7476: Support ROHM BU79100G
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <cover.1747123883.git.mazziesaccount@gmail.com>
 <a6d84a4c9cdd961fbda38182501983f26cceadc9.1747123883.git.mazziesaccount@gmail.com>
 <5f36c304-ed09-4a13-b22d-ceb5924c3739@gmail.com>
 <5ed56b89-8a9b-464f-9b87-f6553395a941@gmail.com>
 <20250515180616.23ca96fd@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250515180616.23ca96fd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/05/2025 20:06, Jonathan Cameron wrote:
> On Wed, 14 May 2025 12:21:30 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 14/05/2025 10:38, Matti Vaittinen wrote:
>>> On 13/05/2025 11:26, Matti Vaittinen wrote:
>>>> ROHM BU79100G is a 12-bit, single channel ADC. Support reading ADC
>>>> measurements using the ad7476.c
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> ---
>>>>    drivers/iio/adc/ad7476.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>
>>> For anyone who might hit this mail thread later:
>>>
>>> Conor made me realize that, for now, the BU79100G looks identical to the
>>> ads7866. Thus, these code-changes aren't needed at the moment, and this
>>> patch can be dropped. For those who wish to use BU79100G, please
>>> introduce it as
>>>
>>> compatible = "rohm,bu79100g", "ti,ads7866";
>>>    
>>
>> I was too hasty.
>>
>> It seems to me that the fallback won't work with the current driver
>> because the driver is not populating the of_match_table, but is relying
>> solely on the spi_device_id table.
>>
>> Judging a quick code reading, the spi_driver_id table entries are
>> matched to the modalias:
>> https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/spi/spi.c#L393
>>
>> Which is (as far as I understand), generated from the first compatible:
>> https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/of/base.c#L1170
>>
>> and not from the fallback one.
>>
>> I suppose this means that we would need to add the of_match_table entry
>> for the ti,ads7866 to make the fallback entry to match the driver.
>>
>> But...
>>
>> The __spi_register_driver() has following comment:
>> 	/*
>> 	 * For Really Good Reasons we use spi: modaliases not of:
>> 	 * modaliases for DT so module autoloading won't work if we
>> 	 * don't have a spi_device_id as well as a compatible string.
>> 	 */
>> https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/spi/spi.c#L487
>>
>> So, having the of_match_table for would not be sufficient for the
>> autoloading, which would still require the bu79100g to be in the
>> spi_device_id table.
>>
>> Am I missing something? I don't see how the Linux SPI drivers benefit
>> from the fallback entries in the dt? (Not saying fallbacks wouldn't be
>> The Right Thing To Do. Ideally DTs aren't for Linux only, maybe some
>> other systems can utilize them). To me it seems I still need to add the
>> spi_device_id entry for the BU79100G, and of_match_table has no
>> additional benefit? If this is right, then this patch is still relevant,
>> even though the binding should be done as in v2.
> +CC Mark Brown and linux-spi.

A quick test with device-tree having SPI device adc0:

adc: adc@0 {
	compatible = "rohm,bu79100g", "ti,ads7866";
};

yields:
root@arm:/home/debian# cat 
/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/48030000.target-module/48030000.spi/spi_master/spi0/spi0.0/modalias
spi:bu79100g

AFAICS, this means the module must have an ID for the 'bu79100g' - 
relying on the 'ti,ads7866' do not work.

Just for a comparison, (platform device) serial node:

uart0: serial@44e09000 {
	compatible = "ti,am3352-uart", "ti,omap3-uart";
};

yields:
root@arm:/home/debian# cat 
/sys/devices/platform/ocp/44c00000.interconnect/44c00000.interconnect:segment@200000/44e09050.target-module/44e09000.serial/modalias
of:NserialT(null)Cti,am3352-uartCti,omap3-uart

- which I suppose means the userland can match also modules which only 
have the 'ti,omap3-uart' fallback without the 'ti,am3352-uart'

I spent some quality time reading:

https://lore.kernel.org/all/564B2DD5.2060502@osg.samsung.com/
https://lkml.org/lkml/2014/9/19/179
https://lkml.org/lkml/2015/8/20/109

What I picked from it is that we have ... intersting history.

If I understood it right (please, correct me if I didn't):

- For historical reasons, the SPI core always sends spi:<foo> modalias, 
instead of device-tree variant of:vendor,<foo>
- The of-variant (from other subsystems) seems to be containing modalias 
matching all the compatibles, including potential fallback compatibles.
- The spi-variant seems to only contain a single modalias, matching the 
first compatible and not the fallback(s).
- The user-space uses the SPI one, or the OF one, not both. Eg, sending 
both wouldn't help unless user-space was changed.
- The SPI variant, for historical reasons, does not include vendor prefix.

=> Changing from SPI one to OF one has not been the way to go.

What I don't know is if the spi:<foo> modalias list could be expanded to 
also include the fallbacks from the device-tree, or if the user-space 
loading implementation(s) would work with multiple spi-modaliases.

Anyhow, it seems to me we don't currently have a de-facto way to utilize 
the device-tree fallback information in the SPI device drivers(?), but 
we need to populate all the IDs in the driver's ID list(s).

So, in order to (reliably) support the BU79100G (with currently existing 
user-space module loading), we need to add the ID for it in the driver 
(as was done in the v1)?

Any better opinions? :)

Yours,
	-- Matti


