Return-Path: <linux-iio+bounces-27099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF402CBF47C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 18:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F58D3012DC7
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA27328B61;
	Mon, 15 Dec 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u8D+ZdW8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4B163
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820539; cv=none; b=gC3jNMjQFQW4T6cZBlTzWXVBwOzRAS3vS+reuBaXwGfSD80uWoXku902BNO2LkSbcAcqyXl1XZJyeUHeZ7wDutiJqDLCtI3SEaMr5D3BxsRYSHeUBlihl7Zb+tvIoXW2X3qO6OFXnWHARbsvYDYBFX9RN/am+wqskQbvzNjFT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820539; c=relaxed/simple;
	bh=JCbw/Tkfl7qcStJ/t/KoL7tabiMhXYBLCGI4xWIdDl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ckr2xZYquTIpuWQTKoGk1s95j91Dl30FlfHrlQppecgXHI8PW8c0KUiShvPQrjnn/950PltYhuHv0NNo/8AirhgIsZ9giMUuY4R1bhmg8vEpepguKH63U0393KWTEtdHOkjb+UtKKkx8yzzmr2WSLKqaOefKDkUJil+/B1yNfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u8D+ZdW8; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3e8819eda8bso1234088fac.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 09:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765820537; x=1766425337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlSnlLmCn+QNW2/CaTtJGlhnE1xXNcqwO0s1EpmEebg=;
        b=u8D+ZdW8zNqFdGjl1gaD4cPQGqrRl5xearAu8LX8VqSxYHNTm6zYOnrwwXQV7R+MGg
         R3QSwU992QCbe+/A51F5mC6gR1FIqfEOmltzGTaIyv8TnX292c5JT80QaZlSKxCoonlg
         Ar9d+ZHYU9GCGbXUn5G8L/Nh7DC8DcFz3JQQSoknE2AvrNEGl3vRHkxkP9UcHulzUXny
         GUtWSPt50FRFlONIXwiO7/e3vzGr6nMYD6SEjak3yCqjh7EtL2Ukt9r86RqlC+V82pYt
         1+kBlNzjJ5ZHWJEcqXLKKtuZhoX8TDmimCzr012tz47xYM5prUuC+P3YC7AOLtqrUd/e
         IoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765820537; x=1766425337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlSnlLmCn+QNW2/CaTtJGlhnE1xXNcqwO0s1EpmEebg=;
        b=T8ZsrLm3ypFwpCxELTrlFXyUehwuz9s9HVsN8ldJbV98On8Bjn6N9GuPObNnE2VWI5
         3DerWYdsFp2Q6muvIkrY3+mzK9bJkzXNun8ns6fKIjDXgQD+qepWiTCz83W/QlBlCCFr
         vO4+lhZCjHyG4HKrgxN5+cHeavY72LmeDklJF3bttlx7sIjFBsQPUKQ3EZgV/ESXnBnE
         JtpP0i6/yvP/0yi7/OjZ3Nglxu9asovpBo5uBPMwoKA9QACFVqH1bgX1PY71m88mTJOn
         m5bOqqyDp3EjPMgNG8+YSPGy94fIoBPC5kookNDHfSOc2lpFgUkF2umZBlrpPma2ZQ8r
         amyg==
X-Forwarded-Encrypted: i=1; AJvYcCXPrnPU7J319fV/5t6yOzke3jyKwmicOtD3lgMlVTXpyV3KRbAXwdKawM0xeiNKO74ahFBFne5Nf20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUy4BEe2+sY+LloPflNiGIof1hplGRs9Nnita96T1OrifmgEnI
	4RXkKlT5zylBiXuwsRhFUIplRN9BQH9ZNxFfSsUsTNSMYGVlN+Lkly9lNurSP4ZIaKw=
X-Gm-Gg: AY/fxX6+TuvvbZaFKf/uLTMJF3ogVIAio5q/45851SIGcxayP1icTWwQmd5eqY2NyZ3
	HQlpgzT2pjkinKusuHUjsAoF5PdpFNyZCFFgLJr26+J2gby0Mr8HlOHReLeHzmI5d8ASqjGpGcn
	Vukys8KKM2FUbZ4cshCthINsLNS6nRGNM4kG/IPAJclWERileOQXAdyWQVZf8Dtc9JQVORRbbHb
	h+AkF0ZVWlEcR4hU00f0EfH+5V/6sQn2ZkLJR+IwKo9YIwj3mq5GuCud++5lsvm7bEkzaM4yFuw
	GVwfiN0aKS7eLwKmZoXpslz7tLyUBx5bGq6wg2F7iyW2rRbJzVmJ1DyUD75nkSZNwsdhL2kBCR9
	nUY9DjkXtwrN4d9sYU8oEhXzTq25l1LmMclAcZ2HAWipxl7HeJnd2+kMHBnZ4xSb1c0IKJBNp8n
	oO4n20EnuViLldJFD0+7sjslB2cKVU1/3Y6BUKFgRBAoUlJKQq1X95YOGtSd32Rvl8z+KvgP0=
X-Google-Smtp-Source: AGHT+IGuB01bc3hrG6FQiQnnv0dYgwD1dfK5LrfV7pzOIuWcBx0XmqTUnDO8pJby08UqR/zVI5Laeg==
X-Received: by 2002:a05:6871:b07:b0:3ec:41eb:6e48 with SMTP id 586e51a60fabf-3f5f890fb0fmr5685338fac.40.1765820536604;
        Mon, 15 Dec 2025 09:42:16 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758? ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ea526bsm5010675fac.22.2025.12.15.09.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 09:42:16 -0800 (PST)
Message-ID: <5926ca19-c204-4abc-9e59-86a797b63b5c@baylibre.com>
Date: Mon, 15 Dec 2025 11:42:15 -0600
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
 <8ad18de5-53cd-49ba-8e84-1e8c7e5bd627@baylibre.com>
 <15106906-3bcc-4187-87d9-c838fe99b583@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <15106906-3bcc-4187-87d9-c838fe99b583@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/25 10:49 AM, Ajith Anandhan wrote:
> On 12/15/25 10:06 PM, David Lechner wrote:
>> On 12/15/25 10:13 AM, Ajith Anandhan wrote:
>>> On 11/18/25 7:34 PM, David Lechner wrote:
>>>> On 11/9/25 8:11 AM, Ajith Anandhan wrote:
>>>>> Add driver for the Texas Instruments ADS1120, a precision 16-bit
>>>>> analog-to-digital converter with an SPI interface.
>>>>>
>>>> ...
>>>>
>>>>> +#define ADS1120_CFG0_GAIN_MASK        GENMASK(3, 1)
>>>>> +#define ADS1120_CFG0_GAIN_1        0
>>>>> +#define ADS1120_CFG0_GAIN_2        1
>>>>> +#define ADS1120_CFG0_GAIN_4        2
>>>>> +#define ADS1120_CFG0_GAIN_8        3
>>>>> +#define ADS1120_CFG0_GAIN_16        4
>>>>> +#define ADS1120_CFG0_GAIN_32        5
>>>>> +#define ADS1120_CFG0_GAIN_64        6
>>>>> +#define ADS1120_CFG0_GAIN_128        7
>>>> We could avoid these macros by just doing ilog2(gain).
>>>
>>> I understand your concern about unused macros. I've kept them for documentation purposes as they map directly to the datasheet register definitions, which makes it easier to verify correctness against hardware specs also I'd prefer to keep it like this since it give more readability Shall i keep this as it is for this initial version?
>> I would argue that if they aren't being used then omitting them would
>> save us the time of having to verify the correctness in the first place.
>>
> I understand your concern about unused macros. This was suggested by Jonathan earlier.

Jonathan is the maintainer, so if he is fine with it, he has the final say. :-)

> 
> I’m fine with removing the unused macros if that is preferred. Please let me know how you’d like me to proceed.
> 
>>>>> +static int ads1120_set_gain(struct ads1120_state *st, int gain_val)
>>>>> +{
>>>>> +    int i;
>>>>> +
>>>>> +    for (i = 0; i < ARRAY_SIZE(ads1120_gain_values); i++) {
>>>>> +        if (ads1120_gain_values[i] == gain_val)
>>>>> +            break;
>>>>> +    }
>>>>> +
>>>>> +    if (i == ARRAY_SIZE(ads1120_gain_values))
>>>>> +        return -EINVAL;
>>>> Since there is only one gain register, we should store this in a
>>>> per-channel variable, then set the gain in the register in
>>>> ads1120_set_mux() instead (and it would make sense to rename
>>>> that function as well to something like ads1120_configure_channel()).
>>>
>>> I've implemented a global gain that applies to all channels for simplicity. I planed to add
>>>
>>>   per-channel gain storage in the later patches.
>>>
>> OK. Just mention this in the commit message.
>>
>>
>>>>> +/* Regmap write function for ADS1120 */
>>>>> +static int ads1120_regmap_write(void *context, const void *data, size_t count)
>>>>> +{
>>>>> +    struct ads1120_state *st = context;
>>>>> +    const u8 *buf = data;
>>>>> +
>>>>> +    if (count != 2)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    /* WREG command: 0100rr00 where rr is register address */
>>>>> +    st->data[0] = ADS1120_CMD_WREG | (buf[0] << 2);
>>>>> +    st->data[1] = buf[1];
>>>>> +
>>>>> +    return spi_write(st->spi, st->data, 2);
>>>>> +}
>>>> I don't see anyting unusal about these read/write functions. We should
>>>> be able to use the existing spi_regmap with the proper configuration
>>>> instead of making a custom regmap_bus.
>>>
>>>     The ADS1120 needs register address shifted by 2 bits
>>>     in command byte (reg << 2). I couldn't find a way to do this with standard
>>>     SPI regmap. If there's a configuration I'm missing, please point me to it and I'll gladly simplify.
>>>
>>>
>> I think you are looking for reg_shift in struct regmap_config.
> 
> 
> 
> 
> Thanks for the pointer.
> 
> I did look at reg_shift, but it doesn’t fit this device. With .reg_shift = 2, regmap would send only (reg << 2) (e.g. 0x0c for reg 3).
> 
> The ADS1120 requires the command byte to be CMD | (reg << 2) (e.g. 0x20 | 0x0c = 0x2c for an RREG of reg 3).
> 
> Similarly,
> 
>  .read_flag_mask would produce reg | mask (e.g. 0x03 | 0x20 = 0x23), which is also not the required format.
> 
> Unless I’m missing a regmap configuration that can generate (reg << 2) | CMD as a single byte,
> 
> a custom regmap bus seems necessary here. Please let me know if there is a way to express this with standard regmap-spi.
> 
> 
> 

Sorry, I didn't read carefully enough. Wouldn't this work though?

	.reg_bits = 2,
	.reg_shift = 2,
	.read_flag_mask = 0x20,
	.write_flag_mask = 0x40,


Then a read should be 0x20 | ((reg & 0x3) << 2) and a write should be 0x40 | ((reg & 0x3) << 2).

