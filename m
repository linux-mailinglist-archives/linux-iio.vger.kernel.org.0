Return-Path: <linux-iio+bounces-27091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19719CBF13A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 885843031E73
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967A338F5B;
	Mon, 15 Dec 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2Wx+rL7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A8338F20
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817393; cv=none; b=e1uK6s5c1nymuOR5GkMoOpPx7SRBw4vF8ZeLNuFOtMNj5esA1Yu0TEK+GD+ZhJl4cUQFJ+l+cxmqd+q1URkPtQqN/ZqtgNcFmi1rUk/U8JIWLRZ3BgO074v6bsR9Qxgmai5aMVrZKVHIsTmGoKlLvsRliP4ondML5EpSMMjLPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817393; c=relaxed/simple;
	bh=OnaSvsbrFawYoJrmCuPvnY92dkVLdEtB2GpkvjducHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9ZS3uZzoxzjZsnkLrI0Fu5YNndDFpk42DZWQjjOCKRAMKHIo1h1gYS9UOIf++gq7g1864QBXJePIQxL9+rclzwbtu2cZSptdSh12hhiDP9jCaady2aVX8MsE0rrPkX2IG5i5wFqREyhkpXaI7d3HAmePQKI2k+kmbddnAAmToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2Wx+rL7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c21417781so2746927a91.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 08:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765817391; x=1766422191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRxCZc0RERtp6MwAUFiJy+nvlEetcpGB/5LKifbnMZg=;
        b=A2Wx+rL78dbfnRDyupF6x1Mv0sk/ZMrJcnVuQqSvN9w/QMe52PT2+GnLwtEQdu6GIk
         y+tyhr4PJR6wZ55p4TS2GOBk/Rfv/7QzU9qbDowm7szLSTKPcuW8zDb5ixUqHS0Z7ar7
         D8wxwAy2UfxUbEmbrqpmb+t6DzMnGCLiDQxQRgTbLuxDMhyFgBdMvAmNvHVsRjsHjfOk
         DzxKBoVl2wsQxTSmzd72RkYaeH5qyhPmtpSfpf3upiiIDg0nbpMOvDwjbiC0SHvdNsvv
         /5eqhZS0ciFbHKej2vCQlq9gPLfUYAH6jBrwAVU2jOCc9nq77ox1YevsKqCdxiN57FzJ
         +RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765817391; x=1766422191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRxCZc0RERtp6MwAUFiJy+nvlEetcpGB/5LKifbnMZg=;
        b=Zwdj3uXrDMSpBxCcHZMmngFt6nwcffKInOJR4kLzdnZyB94e8DS/FzxRfyJ3NsB+tt
         BylSwtk4HFcRypII5WkpnVlhj0UD4BwHP1+n+uYeSDxb4Pi0qpteWiFYksTyTT0VUHtt
         TEA6FhfnFKMuiceZCOrQI6xqGVAsyMjWscbarVwjkCsLjcwfiAuDOY3Mh6WhIjrY1Usk
         9hiuxVzCFRRijF366ZByA2tfaBdhuaIjl2FfUuhPH30WGz/s68L1VZmmeSoY8OyWRNka
         nSaFLFCDORy/9Dzf47hkiVFyTDxOVwkLw8+ZQOqfedfe+BV5Z34UE6TzDWIC4crCfion
         PSVw==
X-Forwarded-Encrypted: i=1; AJvYcCX1iMiI4uWtNfVTaH1/pJFGii5wZQlc3ToPKJuxvhYL/445xtFDxcCX+WzRlMKuJicQCcjHoEE6jXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnPvALPw0z8D1NqzaTOYx2KMHZtAnXrohJaatdWzPJjtkGc05
	CGgkpaXtidkQZpv7MH8p84Zpo0r6Q8IOty/37luFSm22d+yP88LrO+IM
X-Gm-Gg: AY/fxX7FGQMcMekY96pWzbywLimcGfCwtZHDaPxhK5+1P4h3I9ElHAsrnPUPQmChLrJ
	19gYO1TUML7k/tG36dSwXacOg6E90smdOCUygZj54qEgayYQ78K0g8RQHHG3rfQCZUajJ/AoNYu
	poC0CydaKTey4EKnDAcOMiGZrHf+uk5bxskH9nt8BP8qwKtInVlVAqvQkSoWOqy54NKlpeq1PTT
	wvLyBtzB654WOMkG1CjyWLOgWUsR6BM4VRTIII8nPFEvVccs2PU/crCA4jRkPw/+linCPYghTKp
	SW/nFoTPcts1uOL5rXaGJtWfI0S85TDVoXeXweipGMN4S+jDFt1f8b8QyFuuWFlqhQfmRG27fQU
	61IT5IJ5KA0vY57Bv7QfDotVXrTEJ5wLDBy/NJnnr/n3E+uq0XU1s7tp5REJgOp9ml5E2MZQD6T
	XfxOyou0rLBJA5QE95XbN3NvUuN3f52+zZQy1u7337E72dmjWnEYVny5LQJvRv82o=
X-Google-Smtp-Source: AGHT+IH9dTy3bU8XxsBecCtz3enUq/W5wgMv2jek5vWbdOPlbYE52lk3Dvv5oVlerX1L3hBKP6KAsA==
X-Received: by 2002:a17:90b:510b:b0:349:8116:a2d8 with SMTP id 98e67ed59e1d1-34abd6c03eamr10683090a91.7.1765817391167;
        Mon, 15 Dec 2025 08:49:51 -0800 (PST)
Received: from ?IPV6:2402:e280:21d3:2:50bc:8636:2ee8:5158? ([2402:e280:21d3:2:50bc:8636:2ee8:5158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe129a87sm9537784a91.0.2025.12.15.08.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 08:49:50 -0800 (PST)
Message-ID: <15106906-3bcc-4187-87d9-c838fe99b583@gmail.com>
Date: Mon, 15 Dec 2025 22:19:44 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-3-ajithanandhan0406@gmail.com>
 <5f15284b-159b-4860-b58b-35c624e2539f@baylibre.com>
 <8e2c73ca-3746-4b2a-9d85-c12b51a69059@gmail.com>
 <8ad18de5-53cd-49ba-8e84-1e8c7e5bd627@baylibre.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <8ad18de5-53cd-49ba-8e84-1e8c7e5bd627@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/25 10:06 PM, David Lechner wrote:
> On 12/15/25 10:13 AM, Ajith Anandhan wrote:
>> On 11/18/25 7:34 PM, David Lechner wrote:
>>> On 11/9/25 8:11 AM, Ajith Anandhan wrote:
>>>> Add driver for the Texas Instruments ADS1120, a precision 16-bit
>>>> analog-to-digital converter with an SPI interface.
>>>>
>>> ...
>>>
>>>> +#define ADS1120_CFG0_GAIN_MASK        GENMASK(3, 1)
>>>> +#define ADS1120_CFG0_GAIN_1        0
>>>> +#define ADS1120_CFG0_GAIN_2        1
>>>> +#define ADS1120_CFG0_GAIN_4        2
>>>> +#define ADS1120_CFG0_GAIN_8        3
>>>> +#define ADS1120_CFG0_GAIN_16        4
>>>> +#define ADS1120_CFG0_GAIN_32        5
>>>> +#define ADS1120_CFG0_GAIN_64        6
>>>> +#define ADS1120_CFG0_GAIN_128        7
>>> We could avoid these macros by just doing ilog2(gain).
>>
>> I understand your concern about unused macros. I've kept them for documentation purposes as they map directly to the datasheet register definitions, which makes it easier to verify correctness against hardware specs also I'd prefer to keep it like this since it give more readability Shall i keep this as it is for this initial version?
> I would argue that if they aren't being used then omitting them would
> save us the time of having to verify the correctness in the first place.
>
I understand your concern about unused macros. This was suggested by 
Jonathan earlier.

I’m fine with removing the unused macros if that is preferred. Please 
let me know how you’d like me to proceed.

>>>> +static int ads1120_set_gain(struct ads1120_state *st, int gain_val)
>>>> +{
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i < ARRAY_SIZE(ads1120_gain_values); i++) {
>>>> +        if (ads1120_gain_values[i] == gain_val)
>>>> +            break;
>>>> +    }
>>>> +
>>>> +    if (i == ARRAY_SIZE(ads1120_gain_values))
>>>> +        return -EINVAL;
>>> Since there is only one gain register, we should store this in a
>>> per-channel variable, then set the gain in the register in
>>> ads1120_set_mux() instead (and it would make sense to rename
>>> that function as well to something like ads1120_configure_channel()).
>>
>> I've implemented a global gain that applies to all channels for simplicity. I planed to add
>>
>>   per-channel gain storage in the later patches.
>>
> OK. Just mention this in the commit message.
>
>
>>>> +/* Regmap write function for ADS1120 */
>>>> +static int ads1120_regmap_write(void *context, const void *data, size_t count)
>>>> +{
>>>> +    struct ads1120_state *st = context;
>>>> +    const u8 *buf = data;
>>>> +
>>>> +    if (count != 2)
>>>> +        return -EINVAL;
>>>> +
>>>> +    /* WREG command: 0100rr00 where rr is register address */
>>>> +    st->data[0] = ADS1120_CMD_WREG | (buf[0] << 2);
>>>> +    st->data[1] = buf[1];
>>>> +
>>>> +    return spi_write(st->spi, st->data, 2);
>>>> +}
>>> I don't see anyting unusal about these read/write functions. We should
>>> be able to use the existing spi_regmap with the proper configuration
>>> instead of making a custom regmap_bus.
>>
>>     The ADS1120 needs register address shifted by 2 bits
>>     in command byte (reg << 2). I couldn't find a way to do this with standard
>>     SPI regmap. If there's a configuration I'm missing, please point me to it and I'll gladly simplify.
>>
>>
> I think you are looking for reg_shift in struct regmap_config.




Thanks for the pointer.

I did look at reg_shift, but it doesn’t fit this device. With .reg_shift 
= 2, regmap would send only (reg << 2) (e.g. 0x0c for reg 3).

The ADS1120 requires the command byte to be CMD | (reg << 2) (e.g. 0x20 
| 0x0c = 0x2c for an RREG of reg 3).

Similarly,

  .read_flag_mask would produce reg | mask (e.g. 0x03 | 0x20 = 0x23), 
which is also not the required format.

Unless I’m missing a regmap configuration that can generate (reg << 2) | 
CMD as a single byte,

a custom regmap bus seems necessary here. Please let me know if there is 
a way to express this with standard regmap-spi.




