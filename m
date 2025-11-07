Return-Path: <linux-iio+bounces-26024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8559C40D5A
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC68188846C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5726A09B;
	Fri,  7 Nov 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DVgU43yO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6E258CE7
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532325; cv=none; b=qv9vzfBoEo2/75f3EPkKOM/YXk1nl7C5cBw2JrXE/v0/nivnPzmzrHCi/L3y/O0xexjVxt75ahi7pQoTe9Piuba3XLgCPknaAqOt8HLkLd0MzFxAPnmscRKVvJ2jkeZANMQFJXhN4TVmvXSvhM6xCOVeSB4U6Dx7Eog7F41dQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532325; c=relaxed/simple;
	bh=MFFadW4AJeEGGVRTkSO2f2472oOyet6bJ32MOkismQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukioqFo2OGMFElzrB92Btt8B9L7b/TxNnLuiGlf5JGvX+DmbgSAt+1E2GdHI38Lae0CzvqaHjbFITDDFqHdn3XZvajvilzJnWtGdk6D0w0xk8gRm4tHyJ1nEtR4MfTisDyvV8TIxT2KzPGaAdce3toiQobAE4YtP/A4oEU7Mx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DVgU43yO; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65363319bacso391199eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762532323; x=1763137123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKxzSH4u8vYUIO96ehvgaJl4xECRM9a2L3UtEyYYLt0=;
        b=DVgU43yOEFrCihnj8pHxL1vfuce44aeZPsvS+cyySmIejZhiQvljERQgeblGp9IEoI
         VIxdCMpxE3Yp5kTx0WdrzCCurkLI86X+4fpNbXO2VvrvBDidTlkgtyCtfbKGm/yWysIA
         FQz9hCFzDkM1dhvdrhCC/wdmNmdSTk3vR7h+zIj74znkmuvc5IcJM1xczehVIW/F8tbn
         VqxMg8VRNPGisLyJeaA6oXg3bNGi8xCITQLQPXdyOP5GiP1pDQBs5jZo89MMrzkJ8oBG
         V57DM3L74T27D7JhDOjQLFeV/+ukhFaSYsObrB2f1DnfQGjUXi5zdyRpPKY1M9MpZKNk
         HH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532323; x=1763137123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKxzSH4u8vYUIO96ehvgaJl4xECRM9a2L3UtEyYYLt0=;
        b=A73MlOaq9Ijhus37Lno7BZNpCS9rKU1yfDJljkISNDSmgrlUOwsa4J5Ut5avGo2LDE
         9pgqK/UnTH2YNYbxv+DnW5yt0NcvkJbJ6XfFizQ4Uem6K6KvecgdTluQoaKbyjKwYDEl
         gX961GcE/RhPaoNxRVwL5oUXzLIbTVztukNInF6Abw3o8B2YZiG5R/LagIQbv8m09fdF
         4tkZ2t9AyKGcWNl14/WvDLUifzTGH5U5c6dIMa1U5zNq17mMNZ04ctUlYASwBKrKanp/
         ZaHXp7axD30XtSiOCrqC3ASOaxmPH81BGTrLRu5bqWLi/6wiZ16lZftuCCcI2yJc+UVc
         4iUw==
X-Forwarded-Encrypted: i=1; AJvYcCWhQSYM5dB9Ojroo/OSjov2pWy383QdQdBvckLT9Ami84rTOMklg9Kdo74GqoJCxbaFew4VqayTlRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6D1n220qmMxcuVwNV9qyH4fiCTAIbL7s2FDAQj/OVKqH/G7kh
	8PTdE8Imv/oa68LteYBiwr1kipFzoZcy9b0/Ke4A/w63NCZxP9/7bDfJWhMnnaesO+M=
X-Gm-Gg: ASbGncsZAoDH4lt0aX7Jpwgmq3M9tIHVSnrrW+7+4VYs2HHqJnwvtPXaH96uohHFnaf
	GJs3Ll4kwsvD0Ythk95P6VesB0dK2ed6dfUAmBtZ9HE0bkpXjbQL0Z3GKVfoHWBu/maGVkwolMs
	GekyTkoFJeop4DVojFFEmtccy59oCq3bGEawm7aodGakapp/ZlKbxBwfVzOodmUNL5VjwCKvZDY
	UKdrKJ56vQLLeZY85uGmAglNSD8JQJ7uF1nE098yU3ExzmXpZf15frjkuNvPlM22K9gInoyw63z
	5kQ6KU7X2bm7cRYmyhzS1yvyWRM/M9qcPEYW9naDA+N+BlSkibJW94z+ysMfftPq/ObcON97OAb
	GpvtfsCVXHWBSC5Ym7+Al5z0XAUwXPBU+mbl4Q2hIG5CWltDtGV6FctRS4S2ZvsqXPI0cC8+u1s
	SsEsizRqu+z+M4TepnZFzxXv4k4SDXg4v+fDnKTJDH1+gfI0pqJtnkWgONPA3Q
X-Google-Smtp-Source: AGHT+IE2+yDv7v36BhseMR5mBBfzrZuo9RFPzh74b5U7OD0iR5I9ldD4Wg4txKPbQueeWlJzRoQklQ==
X-Received: by 2002:a05:6808:2226:b0:450:d0c:50d9 with SMTP id 5614622812f47-45015ecf630mr1798144b6e.40.1762532322867;
        Fri, 07 Nov 2025 08:18:42 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7bb8:950b:327d:4ba4? ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57d63adsm2528160eaf.14.2025.11.07.08.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:18:42 -0800 (PST)
Message-ID: <de424e9d-95cd-4a42-8f1a-97ad04f5f9ef@baylibre.com>
Date: Fri, 7 Nov 2025 10:18:41 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] iio: adc: Add support for TI ADS1120
To: Ajith Anandhan <ajithanandhan0406@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <20251030163411.236672-3-ajithanandhan0406@gmail.com>
 <fd432bbf-f6c8-441a-882f-f8e52aaca0e9@baylibre.com>
 <a7532aa1-2acb-4064-b10c-b1f7022d589b@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a7532aa1-2acb-4064-b10c-b1f7022d589b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/25 9:50 AM, Ajith Anandhan wrote:
> On 10/31/25 2:43 AM, David Lechner wrote:
>> On 10/30/25 11:34 AM, Ajith Anandhan wrote:
>>> Add driver for the Texas Instruments ADS1120, a precision 16-bit
>>> analog-to-digital converter with an SPI interface.
>>>

One note about the review process. Any suggestions you agree with, you
don't need to reply to specifically. You can trim out those parts in
your reply. It saves time for those reading the replies.

>>> +struct ads1120_state {
>>> +    struct spi_device    *spi;
>>> +    struct mutex        lock;
>>> +    /*
>>> +     * Used to correctly align data.
>>> +     * Ensure natural alignment for potential future timestamp support.
>>> +     */
>>> +    u8 data[4] __aligned(IIO_DMA_MINALIGN);
>>> +
>>> +    u8 config[4];
>>> +    int current_channel;
>>> +    int gain;
>> Since inputs are multiplexed, we can make this gain a per-channel value, no?
> 
> Yes we can, However i want  to keep the initial version simple so would it be
> 
> fine to support per-channel gain configurationin upcoming patches?

Absolutely. I really appreciate splitting things up like that as it makes
it much easier to review.

> 
>>
>> It also sounds like that certain mux input have to have the PGA bypassed
>> which means they are limited to only 3 gain values. So these would have
>> a different scale_available attribute.
> 
>  Since, I'm gonna enable all the 15 channels. I believe we have to have all
> 
> gains(for differential channels). Correct me if i'm wrong.

Yes, that is how I understood the datasheet. Differential channels have all
gains. Single-ended channels and diagnostic channels only get the low gains
(1, 2, 4).


>>> +static int ads1120_write_reg(struct ads1120_state *st, u8 reg, u8 value)
>>> +{
>>> +    u8 buf[2];
>>> +
>>> +    if (reg > ADS1120_REG_CONFIG3)
>>> +        return -EINVAL;
>>> +
>>> +    buf[0] = ADS1120_CMD_WREG | (reg << 2);
>>> +    buf[1] = value;
>>> +
>>> +    return spi_write(st->spi, buf, 2);
>>> +}
>> Can we use the regmap framework instead of writing our own?
> 
> I’d like to keep the first version simple so i will add the regmap support in the
> 
> later patch since the single ended has less spi transaction to handle.

It would be less churn to implement the regmap right away. Typically
we try to avoid churn if we can help it. So this would be an exception
to the general suggestion that splitting things up is better.

