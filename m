Return-Path: <linux-iio+bounces-22850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44BB28FBD
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 19:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51541CC2810
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6C82EBBA9;
	Sat, 16 Aug 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OxE9E2du"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18C1A254E
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755364608; cv=none; b=MOGtPVjv/LeY54X1o/zBd03/PkTsMo2PaWDBYK7bpHTTJZvP//GkbaDbpSCGTelEHHvA0nXTABCUoL0ptj2PYwB578byryn5jzlbRmfMp8HTh6o4K+t1a6StaySlbIKYzYhx7bpoD32ac6pe7a9vjnv9nmrFmDw2i3GIxisQTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755364608; c=relaxed/simple;
	bh=pqJvivEBGZMEeBTDTBeEExbD0QlSLOI8C7nA1Oy3s1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRwHguJEHPIDn22Yqz1ALqcEDpT1v1Tjx89fIMzWdTJmPKHrTPsObLYq8mAaN04Z0ag56EyTIfiNgYbNnJ2m/yS0OcCe77SiRKS5E8Coeldif+SnIJUv7F0wSCcE0S/jk5lOmlEvzgH8CFc46KGmVz4sxVcoLMT6hLotKBGL/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OxE9E2du; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74381e0a227so2090630a34.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755364605; x=1755969405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBe1xo+4v3oElVFW7fcuATaVzg+DgTFn3nHmuEPeFsQ=;
        b=OxE9E2duTCWoTL3BPrR1DJhTS//xVr7PCCbFNO1QlptaH4TTGkXbrZ7pxQrRKD93Td
         ejwu72lLNzg34Eo/VE9zmuSV62eL4jrhGtBHYkNGC6+FSzHiblCBI6Rs942iTQaBrStZ
         vYuneqLf2LCFwnr6BAfuc+gxADgR37mYt8cK/BNaT/g9d//c5WDUg3SY86XEzuapFeNy
         RSw6Zz8sVquGmzov5V6zhrhnit84FqeT1HxtCRFhYCpZ4Bwmw+JtUyMY27CiCirUHstz
         ATNXU6gjVVJvSlg7y+GGrzbtZlVsUrVrkpOKb3SgGMB2z7ykb92nOxJzZPF4VNxdZ5Ct
         mogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755364605; x=1755969405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBe1xo+4v3oElVFW7fcuATaVzg+DgTFn3nHmuEPeFsQ=;
        b=TbyVxb+kCa0UwyBD62hkeGAC2izlyqMvU9O/QfdZntcU1zCSe8fzwuet27EdH2wjGw
         CCmWabQ5vcx4I+QZWDhsCDRF6x2vIhDguMR7JtzRylTd9lxnRSGtq+tFo41gLXZmwrTU
         Rq++XWxi9MKze5x9WYLZCvD6aQ6UrCysJy8ohhklYS9Og2578ccaL/DG+NX9uU79pvO7
         oG22NCepMa4ohwBrZ6aLJRLVMyKUv9iC2QsOY+in1jKJW7Kbg2wtFJArir14M9UmhjK6
         EjOjpwMg5Pj/4H3a2Qkz1W+TyZ7WaGBOEgmoRpxK+pfrE//RJ1UaRiStFWlkQxhm7kXD
         nwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRHe0Y8qRsF/dD6Gzf438WzX5MD/riJGBCYyHIBmJSKafg0C17wdInxe6W2+LPRRhbqQWJR5XUC0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHI20gQDaYO9kEYTrX9ikH6M9WNGqdLuJQ5TBWWyDo3zaHLIrL
	3efbaB9pmPVOnwCN6qoj+dbXSSMRSb0ccUjl1Te6H0E6ulbI5ykP/PULoSbn3Hq6cfo=
X-Gm-Gg: ASbGncsjOs8vTNIIjMRJvnuL8pky4IWnDTIa2NSvAWRBMPX7JSlvVQUf+VEojRro6a3
	qyNnOPOU0z7VRvn1KeHgUFE/fG7fjiasXMn83LM1qjj++y/4xpoCyt+EH51UpYUv+eRkAYZjnyB
	f6mwNe25DJV3uTROBj2uBzU4X+6gWQfeI2bIw/84ZpiAbBgHZaL7LYLijHHqrsMU0a/EeZ5/ozX
	P8Yfz4CzqVBzYSupbRZA3xzwF5nvRFSgJc1JI/WxVzFBB81ZDoqQi9bIGqGMqoA9z+OkT7/xn/6
	/UFpwSkpytPSQXV+URGeGoRPB6DPbGkFsA6gS4CyMPv5VcZnpwnERm2R8vbm1ygxHGTND2+9/JI
	rt16jPlf72vZsvKaZ1QRQ3/5WKZ2KIgEzQjSfWKXvbF4hPG7vzg7ENemYLT/OtTC0t0frSF6a
X-Google-Smtp-Source: AGHT+IGEvb5AhaiT6Zhq/oB29D3w1PwplAUO7hvX9zTUUE1MIRVwNQYM88GdZh4HcrXsSBIzgXsS0Q==
X-Received: by 2002:a05:6830:6b06:b0:742:fb8a:d2d8 with SMTP id 46e09a7af769-7439bad09e4mr2262744a34.21.1755364605125;
        Sat, 16 Aug 2025 10:16:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203b4fesm934109a34.30.2025.08.16.10.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 10:16:44 -0700 (PDT)
Message-ID: <82f53f02-15d3-43fa-9734-8091b360f4e0@baylibre.com>
Date: Sat, 16 Aug 2025 12:16:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
 <20250816105410.70e47dac@jic23-huawei>
 <DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
 <20250816160835.3b44a4cd@jic23-huawei>
 <59D7D612-D618-4FF0-A932-2EB0B57D321E@watter.com>
 <93E1A889-81AE-4DAB-9297-2A74C87E38B3@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <93E1A889-81AE-4DAB-9297-2A74C87E38B3@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/16/25 10:33 AM, Ben Collins wrote:
> 
>> On Aug 16, 2025, at 11:19 AM, Ben Collins <bcollins@watter.com> wrote:
>>
>>>
>>> On Aug 16, 2025, at 11:08 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>
>>> On Sat, 16 Aug 2025 09:12:37 -0400
>>> Ben Collins <bcollins@watter.com> wrote:
>>>
>>>>> On Aug 16, 2025, at 5:54 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>>>
>>>>> On Wed, 13 Aug 2025 17:52:04 -0500
>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>
>>>>>> On 8/13/25 10:15 AM, Ben Collins wrote:  
>>>>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>>>>>> to allow get/set of this value.
>>>>>>>
>>>>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>>>>>> ---
>>>>>>> drivers/iio/temperature/mcp9600.c | 43 +++++++++++++++++++++++++++++++
>>>>>>> 1 file changed, 43 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
>>>>>>> index 5ead565f1bd8c..5bed3a35ae65e 100644
>>>>>>> --- a/drivers/iio/temperature/mcp9600.c
>>>>>>> +++ b/drivers/iio/temperature/mcp9600.c
>>>>>>> @@ -31,6 +31,7 @@
>>>>>>> #define MCP9600_STATUS_ALERT(x) BIT(x)
>>>>>>> #define MCP9600_SENSOR_CFG 0x5
>>>>>>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
>>>>>>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
>>>>>>> #define MCP9600_ALERT_CFG1 0x8
>>>>>>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
>>>>>>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
>>>>>>> @@ -111,6 +112,7 @@ static const struct iio_event_spec mcp9600_events[] = {
>>>>>>> .address = MCP9600_HOT_JUNCTION,        \
>>>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |        \
>>>>>>>     BIT(IIO_CHAN_INFO_SCALE) |       \
>>>>>>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>>>>>>>     BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
>>>>>>> .event_spec = &mcp9600_events[hj_ev_spec_off],        \
>>>>>>> .num_event_specs = hj_num_ev,        \
>>>>>>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
>>>>>>> struct mcp9600_data {
>>>>>>> struct i2c_client *client;
>>>>>>> u32 thermocouple_type;
>>>>>>> + u32 filter_level;
>>>>>>> };
>>>>>>>
>>>>>>> static int mcp9600_read(struct mcp9600_data *data,
>>>>>>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>>>>>>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>>>>>>> *val = mcp9600_tc_types[data->thermocouple_type];
>>>>>>> return IIO_VAL_CHAR;
>>>>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>>>>>> + *val = data->filter_level;    
>>>>>>
>>>>>> We can't just pass the raw value through for this. The ABI is defined
>>>>>> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
>>>>>> is the frequency in Hz.
>>>>>>
>>>>>> So we need to do the math to convert from the register value to
>>>>>> the required value.
>>>>>>
>>>>>> I'm a bit rusty on my discrete time math, so I had chatgpt help me
>>>>>> do the transform of the function from the datasheet to a transfer
>>>>>> function and use that to find the frequency response.
>>>>>>
>>>>>> It seemed to match what my textbook was telling me, so hopefully
>>>>>> it got it right.
>>>>>>
>>>>>> Then it spit out the following program that can be used to make
>>>>>> a table of 3dB points for a given sampling frequency. If I read the
>>>>>> datasheet right, the sampling frequency depends on the number of
>>>>>> bits being read.
>>>>>>
>>>>>> For example, for 3 Hz sample rate (18-bit samples), I got:
>>>>>>
>>>>>> n  f_3dB (Hz)
>>>>>> 1  0.58774
>>>>>> 2  0.24939
>>>>>> 3  0.12063
>>>>>> 4  0.05984
>>>>>> 5  0.02986
>>>>>> 6  0.01492
>>>>>> 7  0.00746
>>>>>>
>>>>>> I had to skip n=0 though since that is undefined. Not sure how we
>>>>>> handle that since it means no filter. Maybe Jonathan can advise?  
>>>>>
>>>>> This is always a fun corner case.  Reality is there is always
>>>>> some filtering going on due to the analog side of things we
>>>>> just have no idea what it is if the nicely defined filter is
>>>>> turned off.  I can't remember what we have done in the past,
>>>>> but one option would be to just have anything bigger than 0.58774
>>>>> defined as being filter off and return a big number. Not elegant
>>>>> though.  Or just don't bother supporting it if we think no one
>>>>> will ever want to run with not filter at all.
>>>>>
>>>>> Hmm. or given this is a digital filter on a sampled signal, can we establish
>>>>> an effective frequency that could be detected without aliasing and
>>>>> use that?  Not sure - I'm way to rusty on filter theory (and was
>>>>> never that good at it!)  
>>>>
>>>> I’ve seen another driver use { U64_MAX, U64_MAX } for this case. It
>>>> didn’t seem very clean. I thought to use { 999999, 999999 } or even
>>>> { 1, 0 }, but anything other than “off” just felt odd.
>>> Ah.  Could we use filter_type? (additional attribute)
>>>
>>> That already has a 'none' option.  Nothing there yet that works for the 'on'
>>> option here.  These are always tricky to name unless they are a very
>>> well known class of filter.   The datasheet calls this one an Exponential
>>> Moving Average filter. Not a term I'd encountered before, but google did
>>> find me some references.  so maybe ema as a filter type?
>>
>> In the docs I have, it says:
>>
>> In addition, this device integrates a first order recursive
>> Infinite Impulse Response (IIR) filter, also known as
>> Exponential Moving Average (EMA).
>>
>> The EMA formula I’ve used for an adc-attached thermistor was the same
>> formula I’ve seen used in IIR, so I think they are generally the same.
> 
> Clarification: An EMA is a 1-pole IIR filter, while IIR filters can be
> many other types besides 1-pole.
> 

We already have a "sinc5+avg" filter, so I would call this one "avg".

I don't think we need to get too specific. The main point of the names
is that for chips with more than one filter, it is obvious which one
is which. For a chip with only "none" and "avg" is will be obvious
that "avg" turns the filter on.


