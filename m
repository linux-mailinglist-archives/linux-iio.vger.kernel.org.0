Return-Path: <linux-iio+bounces-15883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1145DA3E2C7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 18:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C475A3BBB15
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5F2135BB;
	Thu, 20 Feb 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nbJmFXiM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16B1EBA05
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072737; cv=none; b=aQSGAZd8eYO3XgnFqrlVQjEWIlvMVInEjx6Ea1wjiYSXIKVGSM+deS/0Fumjt62NBdXk1KvMQSz9kQ4WfT9cl8yzYerwH09X9C3xCDMT+xxZ0A6tvzqXFVfEcYJygJLQ0d0UcIar1Was97WXqLsJ9fYlFQHM/oqHZAVDwJbyFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072737; c=relaxed/simple;
	bh=3sYO6hLTbz1Yx4jhh2H9VLVNmtvcj0Yg/VTm0rvs6nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2w3hij9Lt9BSY5e8Fh3t9JpNfSJAWTGJLuri14zsjrvyUODetQ10N+bvjgYIuhJPbafcdQXxq6Z41QlX6GL06ksLskh6TOuh0h0xGJDroLXgAPrMQMjY6IUjYG5XlxZKCaQzme1KVA7u2t+jOpZ/ANFJ5G6SP6SVh8qsv9pezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nbJmFXiM; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fce03395d4so1037914eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 09:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740072733; x=1740677533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIc+j8TxBrdPej0mz926UOoeIMB5TisIsEjQp/BF3M8=;
        b=nbJmFXiMhYuFOf79oDrqVL0kUcFacWOkUYIIIVtNWcAouw843PQE6H6udff9h7i+gU
         K4eFJbkxtrv33IsMJtypin5N4rSk0sdRI+ttHI/mxSDO4A0KnN4PzZ/P3HpBfceM97AN
         ZSFW8VtWZMDA1DKxgTQ0KjPIWp5/P1usyYosKLxCjuVu4/4KU9tdMgYQyt7hqqGP2/JS
         XniHexCZveNbWFfTk4e5SAcDRtuwuZtXbx1TAY8A889gGMqIMoOECdNpUlX6+oR1TmrQ
         ncy6dQ1Cxw4daDyqeZsTLbhTWMqIFz3GX9XN+ELoQoHLWvGmr2inL/N9EN9OVTsJ+xkM
         tzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072733; x=1740677533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIc+j8TxBrdPej0mz926UOoeIMB5TisIsEjQp/BF3M8=;
        b=UydnZSkl8l6CTZrAJK5tXANtWrcAWqyQMmY8gXioRG141YvJX7by4rVZMzSX7WjmHy
         2JVhxvtTnORQD8xWRfhszo4Cnxj8LaS0JuNrY3nQvPhrRevhKLZg+xeuC6teaiXtzDAi
         c3Q8pH/kLNDiaAQCFGRvNgTwDTTT4zV0hULx/GLXGpUb4iWhb9OeoU9qrdIeLyhhChHW
         ZgKc8/UKcUTmOi3Xo5kJALv+5GAVBtef4y3z/VKTyKN5ihT7WiRNcwaAU8a57P+hMrXZ
         wLXQfIcolFuJmYpzYTgVbC8ig+5HtfLYOYzIl0TZY9x14LRK1iERTjDHZR/3+AJyklI/
         kjGg==
X-Forwarded-Encrypted: i=1; AJvYcCVMM3Eh+UL1nbIslNaZHeVeHx1YlXBt7aOoinaRb3sInNQEfEinBR+HMQlrh3Ebzvuy8PUUi0ikzGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6z3gycwbZXFfjW5UubmR7cFflWBEhDm4o7qvfTIAL2Q6dxkyq
	c1SWiKFzvpk8CSyxblxUOQ1UsUR2g2SFZDtSjFylxEceTUhpqctZlELXw/AFVXw=
X-Gm-Gg: ASbGncukkjdvzMffD2xZA7O1+Q7LhENf9b4QPeR2hBDjL1Ct6gm1oQ1NgPRJ76/yix7
	8CKT71xYWx/BrgB4FVqU4is40+jV5jGb2oFox2MApwg5iNx+Hv5PEgMCoJWigMTvminPBWwghwX
	+gL69j4O36RBWuhNJvBp0vbDisuA0jNPFEgsrLH2DVJjGyNKcxCIH+F/b3oqhYo3e1KZvTQZaVG
	Mv2kbaDx+J+fOhXxfDD3/ZBx3W7qCHoAvYxc4DrEpAyzuneertJmhKQsMbzyivCoucM1dMH/g8d
	Q9uIWPq8SWHdxXUhUyjo9mI25iMnks/dGQLFUC1LSv6XTvoA9pvx
X-Google-Smtp-Source: AGHT+IHr8T5reKexqMOxlmPqVf7GUavXfHMshpa/XldJ83QUP4dtM6xNCp5f26J8xaA/wL6S5nPJuQ==
X-Received: by 2002:a05:6820:260d:b0:5fc:92b3:2b03 with SMTP id 006d021491bc7-5fd1949807fmr168082eaf.1.1740072733243;
        Thu, 20 Feb 2025 09:32:13 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7271f7c5ba8sm2752929a34.32.2025.02.20.09.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:32:12 -0800 (PST)
Message-ID: <0084eef7-3831-4e62-acf1-6c2dc0e15dd1@baylibre.com>
Date: Thu, 20 Feb 2025 11:32:10 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] bus: ts-nbus: use bitmap_get_value8()
To: Simon Horman <horms@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-sound@vger.kernel.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <20250210-gpio-set-array-helper-v3-5-d6a673674da8@baylibre.com>
 <20250220101742.GR1615191@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250220101742.GR1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/20/25 4:17 AM, Simon Horman wrote:
> On Mon, Feb 10, 2025 at 04:33:31PM -0600, David Lechner wrote:
>> Use bitmap_get_value8() instead of accessing the bitmap directly.
>>
>> Accessing the bitmap directly is not considered good practice. We now
>> have a helper function that can be used instead, so let's use it.
>>
>> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> u> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/bus/ts-nbus.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
>> index b4c9308caf0647a3261071d9527fffce77784af2..beac67f3b820377f8bb1fc4f4ee77e15ee240834 100644
>> --- a/drivers/bus/ts-nbus.c
>> +++ b/drivers/bus/ts-nbus.c
>> @@ -10,6 +10,7 @@
>>   * TS-4600 SoM.
>>   */
>>  
>> +#include <linux/bitmap.h>
>>  #include <linux/bitops.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/kernel.h>
>> @@ -107,7 +108,7 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
>>  {
>>  	DECLARE_BITMAP(values, 8);
>>  
>> -	values[0] = 0;
>> +	bitmap_set_value8(values, byte, 0);
> 
> Hi David,
> 
> byte doesn't appear to exist in the scope of this function.
> 
> I tried this:
> 
> 	bitmap_set_value8(values, 0, 8);
> 
> But when compiling with GCC 14.2.0 I see warnings that values
> is used uninitialised - bitmap_set_value8() appears to rely on
> it being so.

Ah yes, I see the problem (I don't think this driver compiles with
allmodconfig so the compiler didn't catch it for me).

> 
>   CC      drivers/bus/ts-nbus.o
> In file included from drivers/bus/ts-nbus.c:13:
> In function ‘bitmap_write’,
>     inlined from ‘ts_nbus_reset_bus’ at drivers/bus/ts-nbus.c:111:2:
> ./include/linux/bitmap.h:818:12: error: ‘values’ is used uninitialized [-Werror=uninitialized]
>   818 |         map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
>       |         ~~~^~~~~~~
> In file included from ./include/linux/kasan-checks.h:5,
>                  from ./include/asm-generic/rwonce.h:26,
>                  from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from ./include/linux/compiler.h:344,
>                  from ./include/linux/build_bug.h:5,
>                  from ./include/linux/bits.h:22,
>                  from ./include/linux/bitops.h:6,
>                  from ./include/linux/bitmap.h:8:
> drivers/bus/ts-nbus.c: In function ‘ts_nbus_reset_bus’:
> drivers/bus/ts-nbus.c:109:24: note: ‘values’ declared here
>   109 |         DECLARE_BITMAP(values, 8);
>       |                        ^~~~~~
> ./include/linux/types.h:11:23: note: in definition of macro ‘DECLARE_BITMAP’
>    11 |         unsigned long name[BITS_TO_LONGS(bits)]
>       |                       ^~~~
> 
> 
>>  
>>  	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
>>  	gpiod_set_value_cansleep(ts_nbus->csn, 0);
>> @@ -151,7 +152,7 @@ static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
>>  {
>>  	DECLARE_BITMAP(values, 8);

We can fix by zero-initialing the bitmap.

	DECLARE_BITMAP(values, 8) = { };

Would you like me to send a new version of the patch?

>>  
>> -	values[0] = byte;
>> +	bitmap_set_value8(values, byte, 8);
>>  
>>  	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
>>  }
>>
>> -- 
>> 2.43.0
>>


