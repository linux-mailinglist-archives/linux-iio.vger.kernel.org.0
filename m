Return-Path: <linux-iio+bounces-5068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B96888C79FE
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA50B20F64
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC714D6FF;
	Thu, 16 May 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyGTErEQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8F14D2AE;
	Thu, 16 May 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875395; cv=none; b=MTeCdTfaxCFkxGV6XzP7gBovj81T+pwGgdCqxCdCo6S2iwv6ZzJFHqSRPqv/FbxYCxV4owY7K5CWIcr8BppxgLXrFjCEtBAF8TTMfor4lmQyIKCvX0fRmNvPuV8AYpIFSceop8DlpC5Y+N01tACDoDxPBjvwFzz98+b0e5NSjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875395; c=relaxed/simple;
	bh=XfbK26HHwTXb9D6hf85Wv5JSchZA7ZbGTeN/kOh0rRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGULdCkYYkWKO3bRe3v7Vs1XhB80f9tTp00REYe5D9nDB7LtArgPjeWHBD7obd3DkhIl/dxONJ/hiAJXlVfcBG6wgMJ5giDc3w8RwwcjGjY7RB1F3ZPYCZBqLpZz4cV5AKEvQzjC9HMB4KphSU5KCr6PIApQ+00ngO8MLOJTACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyGTErEQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43df44ef3e3so33174691cf.2;
        Thu, 16 May 2024 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715875392; x=1716480192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quQEENvi+8m2W7cBE5Cl749lOV0EoC/dR++hJ/4pzdI=;
        b=hyGTErEQFmXvFTZKsDMCaA5I3ANYEZweCWknpV9mi5taZz0bkBwO+f8Tlf3pKpP8AT
         xYr7pTCAKJOcJM3w05M/je0jq7ffozvkXNr8jB+5MFUJNMcz1FWdrOM4HCbF/4iyWinz
         Gqt3YVyPSijQtraH3ZmNqxZI9pKQeQAVlZNu910S6eTIoVp87xPeOq9/uY0CuDWWv/7u
         9h433goprZqKl2d93BGOJpgSMaoUAeOdtjt0HjoXemMwW05fl4kIOGx/ZNiJSU75xIqv
         9woM0/W0XooQ6i6F9mzJUamuZgw8t6NT6/ZPntVR9cm/8NdfMbBPQpnd7aIeicyXO3UV
         2H8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875392; x=1716480192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quQEENvi+8m2W7cBE5Cl749lOV0EoC/dR++hJ/4pzdI=;
        b=wSvjOSO2LM0/WMrgu8LaHgmapz9+i5x0n67GAm2LzhHIzsfS58IoyiarWmdMOu3oHZ
         fkbQnTwbm4rH1LPDBhLjx5L23LcrYEWksgF+CbfKaw1QB1B9cOGBt9TW4SyAy6vgh6UH
         QVAv3YqJu4Zqc4+NpY9LAEAas4PNB527L5VVV7xvggIxXrIwZ1L98Hq+3rqAxAsjJx1D
         1UFLtZmuuVS85YAo+Y+GLV+WZ0umR3pkBHqo3FEGk0B9AHonWpMgLtHh9kX6G9c7xrWa
         WiCDXdXCamWWli2op8LRyoZl+gMaUtgCAsCvZs8gYszErzR6WqydBgRJDGCEqGVqukn/
         1MHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmyfZ6A8xgVz4N99qjR/A8dDYhOtp1bmaVOFMkDvlT/uNA27FkY2NzXi4Wtlh8fgdJM0+C9dec70LTVeVXMVhIsXnCdEA04wZXdifS3Xi4p5zp7hhixHEnFtAygzHAuepVWiA8s3cnOMYkn/LBbRewLH1IUYlAV1okky2/shyfKQA/rg==
X-Gm-Message-State: AOJu0Yzz3REoeEpRzAgGKkjWMYRl/vN1QVyche4T37TqfofAPHNWpShW
	TrNo8R+YM7+gfdcedgLjNcSoagq+hyDxrzxxsaax1YOFWij2ZawT
X-Google-Smtp-Source: AGHT+IHUQiwlM/E+TmpEM0zYayXuGOsA78RdCCnlxaFfplbOFlUmqLjP2bBU4RWTImAmH4BW4JkH8w==
X-Received: by 2002:ac8:5a8c:0:b0:439:f51a:2c1 with SMTP id d75a77b69052e-43dfda9664bmr233981201cf.1.1715875392075;
        Thu, 16 May 2024 09:03:12 -0700 (PDT)
Received: from [192.168.0.137] ([188.24.105.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54f216esm99899601cf.31.2024.05.16.09.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 09:03:11 -0700 (PDT)
Message-ID: <9c58e5d3-d31c-4dd2-b89d-3acf744b3a28@gmail.com>
Date: Thu, 16 May 2024 19:03:07 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] iio: adc: ad7173: add support for special inputs
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
 <20240514-ad4111-v2-5-29be6a55efb5@analog.com>
 <CAMknhBF8D3YCro4duKrBoEkdc-SiCGwvHTg4SFb17ympUsG1nA@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBF8D3YCro4duKrBoEkdc-SiCGwvHTg4SFb17ympUsG1nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/05/2024 02:27, David Lechner wrote:
> On Tue, May 14, 2024 at 2:23 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>>  Add support for selecting REF+ and REF- inputs on all models.
>>  Add support for selecting ((AVDD1 − AVSS)/5) inputs
>>   on supported models.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  drivers/iio/adc/ad7173.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index fb33534d63a9..1e9ba3070770 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -65,6 +65,10 @@
>>          FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
>>  #define AD7173_AIN_TEMP_POS    17
>>  #define AD7173_AIN_TEMP_NEG    18
>> +#define AD7173_AIN_COM_IN_POS  19
>> +#define AD7173_AIN_COM_IN_NEG  20
>> +#define AD7173_AIN_REF_POS     21
>> +#define AD7173_AIN_REF_NEG     22
>>
>>  #define AD7172_2_ID                    0x00d0
>>  #define AD7175_ID                      0x0cd0
>> @@ -145,6 +149,8 @@ struct ad7173_device_info {
>>         unsigned int id;
>>         char *name;
>>         bool has_temp;
>> +       /* ((AVDD1 − AVSS)/5) */
>> +       bool has_common_input;
>>         bool has_input_buf;
>>         bool has_int_ref;
>>         bool has_ref2;
>> @@ -215,6 +221,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .has_temp = true,
>>                 .has_input_buf = true,
>>                 .has_int_ref = true,
>> +               .has_common_input = true,
>>                 .clock = 2 * HZ_PER_MHZ,
>>                 .sinc5_data_rates = ad7173_sinc5_data_rates,
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>> @@ -228,6 +235,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .has_temp = false,
>>                 .has_input_buf = true,
>>                 .has_ref2 = true,
>> +               .has_common_input = true,
>>                 .clock = 2 * HZ_PER_MHZ,
>>                 .sinc5_data_rates = ad7173_sinc5_data_rates,
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>> @@ -243,6 +251,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .has_input_buf = true,
>>                 .has_int_ref = true,
>>                 .has_ref2 = true,
>> +               .has_common_input = false,
>>                 .clock = 2 * HZ_PER_MHZ,
>>                 .sinc5_data_rates = ad7173_sinc5_data_rates,
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>> @@ -257,6 +266,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .has_temp = true,
>>                 .has_input_buf = true,
>>                 .has_int_ref = true,
>> +               .has_common_input = true,
>>                 .clock = 16 * HZ_PER_MHZ,
>>                 .sinc5_data_rates = ad7175_sinc5_data_rates,
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
>> @@ -271,6 +281,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .has_input_buf = true,
>>                 .has_int_ref = true,
>>                 .has_ref2 = true,
>> +               .has_common_input = true,
>>                 .clock = 16 * HZ_PER_MHZ,
>>                 .sinc5_data_rates = ad7175_sinc5_data_rates,
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
>> @@ -285,6 +296,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .has_temp = false,
>>                 .has_input_buf = false,
>>                 .has_int_ref = true,
>> +               .has_common_input = false,
>>                 .clock = 16 * HZ_PER_MHZ,
>>                 .sinc5_data_rates = ad7175_sinc5_data_rates,
>>                 .num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
>> @@ -298,6 +310,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>>                 .has_temp = true,
>>                 .has_input_buf = true,
>>                 .has_int_ref = true,
>> +               .has_common_input = true,
>>                 .clock = 16 * HZ_PER_MHZ,
>>                 .odr_start_value = AD7177_ODR_START_VALUE,
>>                 .sinc5_data_rates = ad7175_sinc5_data_rates,
>> @@ -920,6 +933,14 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>>                 if (ain[i] < st->info->num_inputs)
>>                         continue;
>>
>> +               if (ain[i] == AD7173_AIN_REF_POS || ain[i] == AD7173_AIN_REF_NEG)
>> +                       continue;
>> +
>> +               if ((ain[i] == AD7173_AIN_COM_IN_POS ||
>> +                    ain[i] == AD7173_AIN_COM_IN_NEG) &&
>> +                   st->info->has_common_input)
>> +                       continue;
>> +
> 
> If there is only one valid combination, it seems like these should be
> fixed channels like the temperature input rather than something coming
> from the device tree.
> 
As I've said, I do not agree with forcing one channel slot to be used.
I could add a property that spawns this channel. Although as I see under,
I think I'll permit these inputs to be mixed and matched.

> It looks like on AD411x, it is the case that there is only one valid
> option for the reference input in the channel configuration. But in
> the case of AD717x since both REF+ and REF- are listed as possible
> inputs for both AINPOS0 and AINNEG0, it seems like they could be mixed
> and matched with other channels. The datasheet doesn't seem very clear
> on this though.
> 
This is imposed artificially, AD411x has the same cross-point mux that
can mix and match all the inputs.

> If it is valid to combine, say AIN0 with REF+ though, then the
> validation would need to be relaxed. But I'm guessing that is not
> actually the case?
>

I think it is the case.

>>                 return dev_err_probe(dev, -EINVAL,
>>                         "Input pin number out of range for pair (%d %d).\n",
>>                         ain[0], ain[1]);
>>
>> --
>> 2.43.0
>>
>>


