Return-Path: <linux-iio+bounces-22425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4671B1E1F5
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5619E62237A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 06:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8D21D3F2;
	Fri,  8 Aug 2025 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzNoizwk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741191F8908;
	Fri,  8 Aug 2025 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633470; cv=none; b=LKs4gBr7adCbp1WC9St5/RbWdpYkJxCHqdxfJylVIuNvM4Z7MIQU3TtEIhhEgbSJmJkChXj/uQ4xnWx/D+sEkQAn9gMavbqbSIO9e8Dky2e2UTYO44+EytT/w89PxJLleeg6Fw5mnoORIaPI9y2Vj2I/h3gtwH/Jly5oA/Yc5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633470; c=relaxed/simple;
	bh=Ab77HTqcALI54MDN6rj+vaLnX99tbos8SQwuP2WLFs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqN8zPN4aORpkpI1zT+W4hbtqqly8HnzYJiC8YNXtG6ZCp81+120dH8CZyg1O76L6t55cQwCo5E3557KqVm26zzbsel0QNrrVMnpFOjnBncnkUR3L2wemEYwvfUsg4PVw+x8zTI943b4H6VFzS+Tbz8iWFZxELDeCrW1E8WnjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzNoizwk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ba26abd62so1957562e87.1;
        Thu, 07 Aug 2025 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754633466; x=1755238266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxiEdoru1HjCtStvAVG/fj+XiwM+8XAZdJUIgdaPXpM=;
        b=JzNoizwkN43lUNJJwAnObmSlp9VjUGXfKKfbAWn26GHxs5gnDU2272k50mkVjPAkYo
         hfL0oMrvB7VbU0XLrfoadsgyjUHhNHA7f/q08YOupvywHg+TbZCgrkSBQXPBspwsp14p
         1DvzwNjmqwlSFPjy8pbvo8AbaiA0eKtTMAxSa8qa1u1sCLJWaH8y059Fx8iWJPvEW2ZY
         nRF/OT3bC9tRfsxZCPEAf19oQcy4DLdHGRfF+7z8bH2GYtihPVpTtYDBHN77ivhI9Qrr
         /aG2PYZ4FRf13iROUAQp23/7IuUrFgA+1G8VZpy0OLOVdl7M73ot1KpJG4T9+CZk4NAk
         CbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754633466; x=1755238266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxiEdoru1HjCtStvAVG/fj+XiwM+8XAZdJUIgdaPXpM=;
        b=Gb1JCy/Jb05KX4cMWEhl2TO7C97it08OwnWgitHco8dDm1SdaSwKscH1qXEdjNij+G
         i2C/hr1kdc/5J8qjYKtaifdnp400+j4GQbCuXZO4Th9d/dCAfAs3HQyxIIwNLieqsaYz
         6J9OXarW0Fc0oZKDjyUvoDmmo809dyHtj0AcK91eELKFgJhX24sUKrDQLjb0iPyMrcjk
         LU2mHSTdy124KD8oI8uncY/JH0/NeFCvzfVddfC+1HZ/UQrDEg+bul4F2M5UgBHXD8b2
         fWgwAd36KHI0xx9XrUZSEBWNxz1ibev3usxLFdX3c+Eah7+SOnQPmKHGvN38dx/fCxec
         lCug==
X-Forwarded-Encrypted: i=1; AJvYcCV13x8FcwYCg/tmZMu7Kki+tBe0J3drOygmtHS4NzwIBmrrGr94EgvmkLCoJS2JcJl9OpTeGGnbzsmh@vger.kernel.org, AJvYcCXThAV3f1e4UpXtWwmIedbx5kIGY4/VH6KoUBHN3ip4wnBYOHCC6oSDMmA3VvvHmm6VKC0fUxymH9edPf8U@vger.kernel.org, AJvYcCXUabFJZEN1F2F3LBPa5jh7b9s0c3BqAY/19gaHm1CEg26ZrXZ0lpHyDyB/LHSMrAsbJe8+r64+V9hJ@vger.kernel.org
X-Gm-Message-State: AOJu0YykbIkTAhCblp/Ib7g9Hny+uplH4UVmAE41y7qCv5xbJsrby60c
	WY/J5ObSnoaxcD7dzNp9kdDc1CBy6TovmPHe+yJMbfkHl0BoyXeV16gs
X-Gm-Gg: ASbGncsbqfDJNbU+1FmTmhIj0nMurQf0HVE7X4MXSh9kO625UjpKqiYbJB0YRLuCWWl
	zTCP4pwB5lx/MpZHQDOzzTkNYvo7ZoHBQLHBqnlKaNU5l2QrO4PZL5bCjfGW+SOC3ow4X8qJTJG
	AZodoDnx7DKtZfIl/ZFO4Cjd2yelS88bfaiUaepy2z8A9Q725Eaa4P0Wo2wmNb7qTcM7zIo95R4
	IMXbB6NskjHuhhnIIu1RygjW3udY67EMeDli6AlBZEz74hePBi2L6bpm1FNTK5tEFPCMvKxoEr3
	xYdN5bbKTKgzcLfFTdE+oHHpr/KDVOSEUGtGHHSFltHWguCbiBBCzg2BRixPi3SeWEOXAD7H/2O
	I/O3gj4BlqR41l9IDrxAnA9YOsZA5T3YKDxlXYdWIUeHmuLHtCWCMrnW0CJsN4iK0wRX7ef7Iot
	ejZE8=
X-Google-Smtp-Source: AGHT+IGsgttwooCMRiErnDkm1eaQJwELnVKAuoFnK4djApArA+BRXKzGGkNWmDlEchy+PW+2Pz2M/Q==
X-Received: by 2002:a05:6512:1193:b0:55b:959e:e3c4 with SMTP id 2adb3069b0e04-55cc00e8ec9mr336599e87.25.1754633466197;
        Thu, 07 Aug 2025 23:11:06 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99384sm2909971e87.110.2025.08.07.23.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 23:11:04 -0700 (PDT)
Message-ID: <2a678156-8e0b-4fa9-a940-f368cfac8f7a@gmail.com>
Date: Fri, 8 Aug 2025 09:11:03 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] iio: adc: ad7476: Support ROHM BD79105
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>
 <stmpyitqnjst2l26xdlkfqdedczpnxhoydges7xumtl5e46pof@cyidmsvdtdnj>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <stmpyitqnjst2l26xdlkfqdedczpnxhoydges7xumtl5e46pof@cyidmsvdtdnj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/08/2025 16:01, Nuno Sá wrote:
> On Thu, Aug 07, 2025 at 12:35:25PM +0300, Matti Vaittinen wrote:
>> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
>>
>> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
>> conversion. Unlike with the ad7091 and ad7091r which also have a
>> CONVSTART pin, the BD79105 requires that the pin must remain high also
>> for the duration of the SPI access.
>>
>> (*) Couple of words about the SPI. The BD79105 has pins named as
>> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
>> ISO.
>>
>> DIN is a signal which can be used as a chip-select. When DIN is pulled
>> low, the ADC will output the completed measurement via DOUT as SCLK is
>> clocked. According to the data-sheet, the DIN can also be used for
>> daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
>> 'data-ready' -IRQ. These modes aren't supported by this driver.
>>
>> Support reading ADC scale and data from the BD79105 using SPI, when DIN
>> is used as a chip-select.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>>   v1 => v2:
>>   - Fix the conversion delay for the BD79105
>>   - Drop unnecessary GPIO check from the convstart disable
>>   - Drop unintended whitespace change
>>   - Fix spelling
>> ---
> 
> IIUC, for this chip the CONV GPIO is actually mandatory no?

Yes. You're right.

> If so, we
> should likely fail probe in case there's no GPIO. And we could also change> the dt bindings accordingly.

I did change the dt-binding (patch 8/10):
+  # Devices with a convstart GPIO where it is not optional
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rohm,bd79105
+    then:
+      required:
+        - adi,conversion-start-gpios
+

I didn't want to complicate the probe with extra checks for the GPIO 
based on the IC-type. But I am having second thoughts - maybe it is the 
right thing to do as you say :) Thanks!

> Some more comments inline...
>>   drivers/iio/adc/ad7476.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
>> index 8914861802be..aa8a522633eb 100644
>> --- a/drivers/iio/adc/ad7476.c
>> +++ b/drivers/iio/adc/ad7476.c
>> @@ -31,6 +31,7 @@ struct ad7476_chip_info {
>>   	struct iio_chan_spec		channel[2];
>>   	void (*reset)(struct ad7476_state *);
>>   	void (*conversion_pre_op)(struct ad7476_state *st);
>> +	void (*conversion_post_op)(struct ad7476_state *st);
>>   	bool				has_vref;
>>   	bool				has_vdrive;
>>   };
>> @@ -39,6 +40,7 @@ struct ad7476_state {
>>   	struct spi_device		*spi;
>>   	struct gpio_desc		*convst_gpio;
>>   	void (*conversion_pre_op)(struct ad7476_state *st);
>> +	void (*conversion_post_op)(struct ad7476_state *st);
> 
> Pointer duplication again :)
> 
>>   	struct spi_transfer		xfer;
>>   	struct spi_message		msg;
>>   	struct iio_chan_spec		channel[2];
>> @@ -63,6 +65,21 @@ static void ad7091_convst(struct ad7476_state *st)
>>   	udelay(1); /* Conversion time: 650 ns max */
>>   }
>>   
>> +static void bd79105_convst_disable(struct ad7476_state *st)
>> +{
>> +	gpiod_set_value(st->convst_gpio, 0);
>> +}
>> +
>> +static void bd79105_convst_enable(struct ad7476_state *st)
>> +{
>> +	if (!st->convst_gpio)
>> +		return;
> 
> I think the pattern for optional GPIOs is to just call
> gpiod_set_value_*() and the lib handles NULL pointers. Also the above is
> not coeherent with bd79105_convst_disable().

I definitely don't want to do *delay() if there is no reason. Haven't 
checked the code lately, but I suppose the ndelay() is a busy-wait, 
blocking _everything_ on the core it is executed.

I dropped the check from the _disable() variant since it doesn't call 
the delay().

But now that you (and Andy) have commented on these checks...

(even though I don't really think these checks are THAT bad. It's almost 
as if there were some reviewer's "unconditionally comment this"-list 
where NULL check for the GPIO API's was written ;) These check's are 
quick and very clear, and they avoid a blocking busy-wait)

...I see two other options. One is adding the check in probe as you 
suggest. This check will however be substantially more complicated code 
than this NULL check here, because it needs to be performed only for the 
ICs which _require_ the convstart. Good thing is that it will error-out 
early and clearly, whereas current solution will just lead bogus values 
to be read if convstart is not correctly populated.

Other option would be making the conversion_*_op to return an error. I 
would still keep the NULL check but the bd79105_convst_enable() could 
error out. Delay would be avoided, user would get the error notification 
and bd79105_convst_disable() wouldn't get called.

TLDR; I will see how the "check in probe" you suggested plays out. Then 
I can omit these checks here :)

> 
>> +
>> +	gpiod_set_value(st->convst_gpio, 1);
> 
> gpiod_set_value_cansleep()? I do see the driver is calling the same API
> in other places but I do not see a reason for it... So, precursor patch?

Ah. Great catch. *kicking himself*. I should've noticed...

Thanks!

Yours,
	-- Matti

