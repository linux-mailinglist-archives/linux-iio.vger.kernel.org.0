Return-Path: <linux-iio+bounces-27089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D764DCBEF57
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F003011A4D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9092C283FF5;
	Mon, 15 Dec 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ScCy18MP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482CB2BE7AB
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816572; cv=none; b=NqfpeSGhy5twjGUIfOJ8HTEdvw1jCAtNiBqaMsPot7CJ4YbFjyJOpZLm8ldGTrJW98q2iHO7HJ9JnsqetGkjnHGOV+WxGaO5x4Qb+I0oiV0arY0VMcpCwOFv1E4UWUpXAaJ8HFBz7tmvNYC8lHm6Wc80ulDvZDtwa4LuI64Abw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816572; c=relaxed/simple;
	bh=sAowoesxLtXeIRYWyEMZGEA6UywLMgIjNJO+lhOHOZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h96VVglikkqh4462s0/Jkr4IXKcq6y2eH3y7SW7XqMM+bcmOmfjjXCwB8RJtx/9erpB9BA79+CtTa2PkCdIXCpU8M3B+N8b+6NNxTkcbEs0AA7HavYqJGnm0omHX9g3F8DZlJbn1m22I700ZPusO4KTvC5I5HdhAYelpA9/EsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ScCy18MP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c75dd36b1bso3041011a34.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765816569; x=1766421369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7oZrvL1xspTN4J2u08OoYNZ7S8v1d6FkgPVyI9tW5w=;
        b=ScCy18MP6AppOl1y4Q55IVY7pkNQnn/omya+zqQhvHZOkivRSx6pdya9TAWnuE014v
         +6qkradwXvAQZN9ixvPqio6njiffKjJ2rjS9sP+7grLLWTFJNX4UFRnpIQFxzTvPlMxl
         cm/JFHOM9/Pmk9kf4007kTAtsH0WKaT+gY71BhEgQEwWYK3vtM/HRCXWgDhsydpD6S7N
         WU6U1QQ24QD3TPmwlcNwCsRnWLne06q7dQTBjJ23VGGcOH6Iqhve/qrVl3RHtiNXBRlv
         kcrAjsUzsgHiZ4A31WPu5Ca/SCttKtCeDa80YJqkPERpYcYc6pERavOg1P/vwjsDzsxP
         zE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816569; x=1766421369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7oZrvL1xspTN4J2u08OoYNZ7S8v1d6FkgPVyI9tW5w=;
        b=fN2HKucagB+GjIPsGQ+TFCu/VVfiHnA9rACUWZgf16GR3Yv/pHy4ORPmH/E9Ihr0mN
         sgclhqnGfwvhOVHG3OlUSTJRskFEMCj2wWmtnBA8I7vgbECEswKkzW+78ZOGvahopqV+
         zmlUFDgw+eYUhlP4lFj540XThBi5pfie+CB3fLXFUTgxIu324yUnOwCoOHHCY5HHiIwD
         S/ZJvN466RT70XX0OZDK3IOJP/jYv4roGbEy6b8Dbw2xaQwph2yUac42QXj0+AIQrUe3
         6HpifpQjhcBrb9FQ/QOc+RmYPWNv+yB65xDZXETclSeiveYRY+7UsaRbac5PXruQzGoG
         aqGw==
X-Forwarded-Encrypted: i=1; AJvYcCUqU55QltWCRs1MUO81yk2QWVLR/VwlRN09p7HLJ9ZtScA2eR8iGsOwP/oylRcAdxeIVoXzSzMWiLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJoeMycVByEzJBrtKG1hR4pmAKM3oRAaHw6B5tYlt5YBANGzX
	4L/KdC0LqPL3Fu4EIf+x7MYub7kto04SJsw7WImJZf7goHZpFt9RvBCop8eGuHzfESc=
X-Gm-Gg: AY/fxX5fInZctai5a/NN7erhEWcOrMtsDz9iIi0G/R2XxCsDMcE7GfHAv0Tj7dk2d/I
	gjGOznMOQyxqJ7kiGKfMHL3U0mwMJy3lJXOZOTTiTN3l/9e0fClnXoN++AgxgFYYQAJeUq5IAvT
	grf5AsyPCc57A9YB9/wmrgC5xUhJ7FHFysxArVDdaDVb6IqV6lRsLdRv/R9UKWjXBGHAiySRZOx
	15kkC6N7w2eSWIZs9iDA59r4HEIZi2Lu1rJwI29XhVcfNzVtyUimZgrUgYVB4mXMO8iJUv3g3MQ
	DsqOs5oYedjvpJ+LGfE117LrjOQU3dWdiuV8vlHTgvvMAGcIXNTIve0YG0dbwDaN+Eq55Mo8BTj
	XPBbhp9xx6BEMDrvbbFph4KFUppLXQf6O2+cm/PuPhdtJuUk+LgFNFRlw20BFz9q9QKBKbTcqoZ
	u7IXILXyQ98CVEWpyYun18Bcr3C1IgeI6tHAsRxOoxoJR9Hun1sSk89hn12i/o
X-Google-Smtp-Source: AGHT+IGUf60DyjJnn1BWuFoWIWGsMe8lsQdmvZaZUG6uFOtKAGFnWTuMobQaOP8tgZlvZ+sWh2O1Ew==
X-Received: by 2002:a05:6830:914:b0:7c7:6752:2d8 with SMTP id 46e09a7af769-7cae838199fmr7424977a34.32.1765816569392;
        Mon, 15 Dec 2025 08:36:09 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758? ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1ff3dasm136070a34.11.2025.12.15.08.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 08:36:08 -0800 (PST)
Message-ID: <8ad18de5-53cd-49ba-8e84-1e8c7e5bd627@baylibre.com>
Date: Mon, 15 Dec 2025 10:36:08 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
To: Ajith Anandhan <ajithanandhan0406@gmail.com>, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-3-ajithanandhan0406@gmail.com>
 <5f15284b-159b-4860-b58b-35c624e2539f@baylibre.com>
 <8e2c73ca-3746-4b2a-9d85-c12b51a69059@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <8e2c73ca-3746-4b2a-9d85-c12b51a69059@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/25 10:13 AM, Ajith Anandhan wrote:
> On 11/18/25 7:34 PM, David Lechner wrote:
>> On 11/9/25 8:11 AM, Ajith Anandhan wrote:
>>> Add driver for the Texas Instruments ADS1120, a precision 16-bit
>>> analog-to-digital converter with an SPI interface.
>>>
>> ...
>>
>>> +#define ADS1120_CFG0_GAIN_MASK        GENMASK(3, 1)
>>> +#define ADS1120_CFG0_GAIN_1        0
>>> +#define ADS1120_CFG0_GAIN_2        1
>>> +#define ADS1120_CFG0_GAIN_4        2
>>> +#define ADS1120_CFG0_GAIN_8        3
>>> +#define ADS1120_CFG0_GAIN_16        4
>>> +#define ADS1120_CFG0_GAIN_32        5
>>> +#define ADS1120_CFG0_GAIN_64        6
>>> +#define ADS1120_CFG0_GAIN_128        7
>> We could avoid these macros by just doing ilog2(gain).
> 
> 
> I understand your concern about unused macros. I've kept them for documentation purposes as they map directly to the datasheet register definitions, which makes it easier to verify correctness against hardware specs also I'd prefer to keep it like this since it give more readability Shall i keep this as it is for this initial version?

I would argue that if they aren't being used then omitting them would
save us the time of having to verify the correctness in the first place.


>>> +static int ads1120_set_gain(struct ads1120_state *st, int gain_val)
>>> +{
>>> +    int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(ads1120_gain_values); i++) {
>>> +        if (ads1120_gain_values[i] == gain_val)
>>> +            break;
>>> +    }
>>> +
>>> +    if (i == ARRAY_SIZE(ads1120_gain_values))
>>> +        return -EINVAL;
>> Since there is only one gain register, we should store this in a
>> per-channel variable, then set the gain in the register in
>> ads1120_set_mux() instead (and it would make sense to rename
>> that function as well to something like ads1120_configure_channel()).
> 
> 
> I've implemented a global gain that applies to all channels for simplicity. I planed to add
> 
>  per-channel gain storage in the later patches.
> 

OK. Just mention this in the commit message.


>>> +/* Regmap write function for ADS1120 */
>>> +static int ads1120_regmap_write(void *context, const void *data, size_t count)
>>> +{
>>> +    struct ads1120_state *st = context;
>>> +    const u8 *buf = data;
>>> +
>>> +    if (count != 2)
>>> +        return -EINVAL;
>>> +
>>> +    /* WREG command: 0100rr00 where rr is register address */
>>> +    st->data[0] = ADS1120_CMD_WREG | (buf[0] << 2);
>>> +    st->data[1] = buf[1];
>>> +
>>> +    return spi_write(st->spi, st->data, 2);
>>> +}
>> I don't see anyting unusal about these read/write functions. We should
>> be able to use the existing spi_regmap with the proper configuration
>> instead of making a custom regmap_bus.
> 
> 
>    The ADS1120 needs register address shifted by 2 bits
>    in command byte (reg << 2). I couldn't find a way to do this with standard
>    SPI regmap. If there's a configuration I'm missing, please point me to it and I'll gladly simplify.
> 
> 

I think you are looking for reg_shift in struct regmap_config.


