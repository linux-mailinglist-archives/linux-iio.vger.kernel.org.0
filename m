Return-Path: <linux-iio+bounces-59-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB327EB3FD
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A095B20B06
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B24176B;
	Tue, 14 Nov 2023 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFoDsbZE"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28B4174D;
	Tue, 14 Nov 2023 15:43:38 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B00418F;
	Tue, 14 Nov 2023 07:43:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso867956666b.0;
        Tue, 14 Nov 2023 07:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976615; x=1700581415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+ep0eXvunZX8/Xp7/xoRsA2kj2nPwPABneaP0qplrM=;
        b=MFoDsbZEg4wQYnmTZ7WaVyDX5K6bN6Be+agTVlf/+RRWaA0DMeNySyqgVx2s/1O3jy
         rFaeIw78PIl25Iz7YT5pUINY/p/G8tbUPD/wQ18usF47Uib6YVf+bzwUhQ0kQIRrITe/
         3iTjekecoiDjzQ+ncJZWWuVa/Hgnc/tHgPBd2jBG+3JzJOHVdW1cLjW9stkHQOkxol6c
         CExrEp1i6ydGNshrbjUtfwXE4Gd9cqRFNXcTOwvjcArd8TYxli06d0lAhnd4sDrsEFHI
         02LqRnumPNJbLaxBI3uL1po/YaqefWXXkaC0L2fGLRofZhG2XPADlQvVxB2SCYJWsg0h
         /eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976615; x=1700581415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+ep0eXvunZX8/Xp7/xoRsA2kj2nPwPABneaP0qplrM=;
        b=DSRUCE2//VKqpMKLfnvQTbKQbR2Yr4Yq/vTNzhl51f9bXaXscSNmKUNbAHZXAoeoZ7
         eHatumrRQ23l1vJuKEAB0f7plKMAPacLTBTzomSVhkr0FBQK2GsuF/POQEjG+H97Mb1J
         4XoJ3Cx7l8khMpaDTfaM+COGDQCEctrDwlFzAqpjBOkI/kafORNokJgSpQVTStUOGS+x
         SpDNuZx1JJGWZ4tBLdQHkDbZWdPfJVWz6FkfVuoFJtXmwx1W/KFHBcEN5NUzMzOAw5J0
         XKvVnjq+RIyXfFAn610xWy6Zr4VW/2rUudG9SnYKpCGPw2snjINHlOFrlBra9SHtJkdw
         yvkw==
X-Gm-Message-State: AOJu0YzjzI8qTNJs57qA/nIXIYF/jNdbuHEip4+aGS1gZIuIhEool0FG
	ZsKtW+P4TxhAbzhcvrusLng=
X-Google-Smtp-Source: AGHT+IFuAQiyP4aiAIIbl5vdG5bXIDlqHJcpzLh0Fo1uJiVM8wv7FZAVy3iyYajFOt6lW7xLYYBcPQ==
X-Received: by 2002:a17:906:3395:b0:9e6:1661:92fa with SMTP id v21-20020a170906339500b009e6166192famr7415602eja.45.1699976614503;
        Tue, 14 Nov 2023 07:43:34 -0800 (PST)
Received: from [10.76.84.181] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ga23-20020a170906b85700b009ae587ce128sm5670899ejb.216.2023.11.14.07.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 07:43:34 -0800 (PST)
Message-ID: <e4cd1c34-0127-4574-8c62-80ec25afc420@gmail.com>
Date: Tue, 14 Nov 2023 17:43:32 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: adc: ad7192: Use device api
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Cosmin Tanislav <demonsingur@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Liam Beguin <liambeguin@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Ibrahim Tilki <Ibrahim.Tilki@analog.com>, ChiaEn Wu <chiaen_wu@richtek.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231105193132.47009-1-alisadariana@gmail.com>
 <20231105193132.47009-2-alisadariana@gmail.com>
 <8fae735c-c227-4f60-8ba8-8cb13dfb2626@linaro.org>
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <8fae735c-c227-4f60-8ba8-8cb13dfb2626@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.11.2023 11:24, Krzysztof Kozlowski wrote:
> On 05/11/2023 20:31, alisadariana@gmail.com wrote:
>> From: Alisa-Dariana Roman <alisa.roman@analog.com>
>>
>> Replace of.h and corresponding functions with preferred device specific
>> functions.
>>
>> Also replace of_device_get_match_data function with
>> spi_get_device_match_data.
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>> ---
>>   drivers/iio/adc/ad7192.c | 32 +++++++++++++++-----------------
>>   1 file changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
>> index adc3cbe92d6e..48e0357564af 100644
>> --- a/drivers/iio/adc/ad7192.c
>> +++ b/drivers/iio/adc/ad7192.c
>> @@ -17,7 +17,6 @@
>>   #include <linux/err.h>
>>   #include <linux/sched.h>
>>   #include <linux/delay.h>
>> -#include <linux/of.h>
>>   
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/sysfs.h>
>> @@ -364,19 +363,19 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
>>   		freq <= AD7192_EXT_FREQ_MHZ_MAX);
>>   }
>>   
>> -static int ad7192_of_clock_select(struct ad7192_state *st)
>> +static int ad7192_device_clock_select(struct ad7192_state *st)
>>   {
>> -	struct device_node *np = st->sd.spi->dev.of_node;
>> +	struct device *dev = &st->sd.spi->dev;
>>   	unsigned int clock_sel;
>>   
>>   	clock_sel = AD7192_CLK_INT;
>>   
>>   	/* use internal clock */
>>   	if (!st->mclk) {
>> -		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
>> +		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
>>   			clock_sel = AD7192_CLK_INT_CO;
>>   	} else {
>> -		if (of_property_read_bool(np, "adi,clock-xtal"))
>> +		if (device_property_read_bool(dev, "adi,clock-xtal"))
>>   			clock_sel = AD7192_CLK_EXT_MCLK1_2;
>>   		else
>>   			clock_sel = AD7192_CLK_EXT_MCLK2;
>> @@ -385,9 +384,10 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
>>   	return clock_sel;
>>   }
>>   
>> -static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>> +static int ad7192_setup(struct iio_dev *indio_dev)
>>   {
>>   	struct ad7192_state *st = iio_priv(indio_dev);
>> +	struct device *dev = &st->sd.spi->dev;
>>   	bool rej60_en, refin2_en;
>>   	bool buf_en, bipolar, burnout_curr_en;
>>   	unsigned long long scale_uv;
>> @@ -416,26 +416,26 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>>   
>>   	st->conf = FIELD_PREP(AD7192_CONF_GAIN_MASK, 0);
>>   
>> -	rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
>> +	rej60_en = device_property_read_bool(dev, "adi,rejection-60-Hz-enable");
> 
> Not strictly related to your patch, but where are these properties
> documented?
> 
> 
> Best regards,
> Krzysztof
> 
Thank you for the feedback! The properties are documented in
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml. But the
properties related to the clock configuration are indeed missing. I will
add them.

Kind regards,
Alisa-Dariana Roman

