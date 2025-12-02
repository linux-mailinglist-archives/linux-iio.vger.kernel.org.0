Return-Path: <linux-iio+bounces-26639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C390C9BF10
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2B994E373E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158E25EFBE;
	Tue,  2 Dec 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GAD7m/BS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B132571C5
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689293; cv=none; b=kbdotiFHiz8G74Qn5A76rcKXtF5q0Cst8ymUQFW32uyrNzunDJ5prrU3H+mTTi8Gahn8VA3q2V/uNEe6zmR5gD6YiXcjl8F32MxsZDpLSJkpwJLWnwDNYJR2qVN+xdWOdCCGkrYSIpLKWXIg2ICJFcTfkXJtpblQqnD7Gw6bwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689293; c=relaxed/simple;
	bh=kmK8IXka++Woo6EuxqS0W1td/ojOZN8PXH2MFsle03E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s393Vg+IgBnBKTeYWMTBsM6Ak+gG/WIQkk3Fc7Q/EpkWr22qMC7BVEzBaQ3y1bjVnaAZsTE6/z7/sz9PQTfQ6uYexguuVe0Uo4OvZE0qGf5+BkLfsBpuyTboD0ZvoFFzZKk4OcT4tnU5ATvaPvuwxpphnxcjqIlpPjN3ylJDQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GAD7m/BS; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3e80c483a13so2498551fac.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764689288; x=1765294088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxaljqfDlevKYOFRmhhVtp6SuKsOmRMPKv6uIFomRCM=;
        b=GAD7m/BS1KYFPCfhAlmsBXYYbWe8gcn4+MALba4lbvzn0gSBN2pVY3jQVcPIQV1s2L
         fxWsiC0x7Hwuy+l9839NWMdJHpXbOZukVYt/dryuDOOXlFDoqA0WsgMxnUQJRqwQpCq3
         nIf3YQXJxjEulweZ4TRiMpBqAZPyu8QAlqELl815QJsak9ezWJxtCgqU6X4HVxMfj7Db
         DExFNuM3BKUb18ZIIXMaqWdJ3HVBhzDoZYKG/T0x1oweRhsrP7Q3+TjOe4+c3HQQ0YBn
         hOcEbTsB1LJ1dmYFZwxUS2B85ytz/E46WPFVNhkJ1NICaB0L9Jw2vOAiMQs0sKbtXUS1
         Xtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689288; x=1765294088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxaljqfDlevKYOFRmhhVtp6SuKsOmRMPKv6uIFomRCM=;
        b=R5qIBXs+BPVJ2CIXDsT73j8BsrfiXeDihPk8wrvGOkMumOB6C7usM94V2qQvnkgmpp
         kM7BVvvoA/dqBW7uj/Q1DlMXHW11c2TSBLp0RPhxohiOhKuUD+i0H8C6XDUTfchE2stA
         /hdOcYC/ghJDUIVRku3YF00YfVnIk2JnTLYYd4zitzxTa8oTvxptBA1OAkyCTfxEx6kH
         +eFBJ3m5lYRwc4/aiOVfrCsYbD143aL10S+fqFFgztxK6/YHKRRJhVPrcOfwAe0H0KkZ
         bjvfj6ywl852EwW4EBLQYoGqnbIsYEvEYKuTAGyEHxx5BzazyPMd5x8SHhhS89O8XNNS
         gpsw==
X-Forwarded-Encrypted: i=1; AJvYcCVCp7grcw9PizDjwYrNobgIxGurPkaWssqR5hAo1RHAd09Y3dH8SLG4XmFA2igS+bxc8cvDD3o2ySw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlRcgIBtO1BQPzt3K+PD8u3MZaIBRqdx9QVRTI0tR1HmYSRfx
	Xqq11LrQFssUZX64+xzFZV6qKMfaUHaaShqKh77jIIyAQaifMtM3XuPSBiShrqzSuiw=
X-Gm-Gg: ASbGncsLUrmQB+19yyDfvbxZtOJ40sEJvVC6ErZ2ZA0jZhuSedLYHa+HKeDPT4F3trt
	5wlc44BmAKwLUiHwCz/APPmaB74cbdtkUSjhAtmi2UcPWfk6ys+OuDeoknT8LUcgngNonCWVii8
	SlsaXHI5soehOhetxmhwK0aBqjMGYGSvCCLiG6+cnUVxgCAkQZsxC2uEdIISj+eTho3nCFSBa3V
	AR/YY6SklBCbd/zulKm9zdfTkEAOkmDOx9uZKulsri8DeYC1EF+s6q6eSMDuiRHhWu3mlCbZXKY
	uFrqNsRAcLB9MTqg7jYLjjUJ9J1KjSBM2QYWLiqNYWmnFLBUWejzKmMOiQ7LfsRE/6NBMjLtbJK
	N+/N+82NsY5H/3KNchV/iYRiCfNg0SZ6ANFq+28vPJW1UKz+6kcLEaIn/NyyviljJSxa9M0Sxkn
	qWmoh13ZywRYDEcHCl6Auwnf7r1zJvsWtMVQEc7OFA3rE5yvdK+oREae8s921p
X-Google-Smtp-Source: AGHT+IFarSgDBAChAWtpWJ8VS3uXvq7r5vMy/w8dFdyeVdiiEfXnWxryliLUIlZ2ckeUXhj+eG4xKw==
X-Received: by 2002:a05:6870:709d:b0:3ec:3ee9:3aa with SMTP id 586e51a60fabf-3ecbe326836mr19327017fac.20.1764689288526;
        Tue, 02 Dec 2025 07:28:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8f05:e265:a988:1b22? ([2600:8803:e7e4:500:8f05:e265:a988:1b22])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca3ad8asm7841250fac.6.2025.12.02.07.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 07:28:08 -0800 (PST)
Message-ID: <3edc68e2-e46a-4315-b2db-a221fee94b9e@baylibre.com>
Date: Tue, 2 Dec 2025 09:28:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
 <5d343af235c499382bd2eac987357e857865b457.camel@gmail.com>
 <8edcbe15-b3cf-4259-9d07-87c07f1f400e@vaisala.com>
 <a6194f8f0b8506283d2941a869961fd4f284634d.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a6194f8f0b8506283d2941a869961fd4f284634d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/2/25 9:05 AM, Nuno Sá wrote:
> On Tue, 2025-12-02 at 16:52 +0200, Tomas Melin wrote:
>> Hi,
>>
>> On 02/12/2025 15:47, Nuno Sá wrote:
>>> On Tue, 2025-12-02 at 12:53 +0000, Tomas Melin wrote:
>>
>>>>  static const struct iio_chan_spec ad9434_channels[] = {
>>>> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
>>>> +	{
>>>> +		.type = IIO_VOLTAGE,
>>>> +		.indexed = 1,
>>>> +		.channel = 0,
>>>> +		.info_mask_shared_by_type =
>>>> +		BIT(IIO_CHAN_INFO_SCALE) |
>>>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
>>>> +		.info_mask_shared_by_type_available =
>>>> +		BIT(IIO_CHAN_INFO_SCALE) |
>>>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
>>>
>>> Odd style for info_mask_shared_by_type_available and info_mask_shared_by_type. Seems we have
>>> more line breaks than needed.
>>>
>> Looking at existing code, there seems to many different ways to indent
>> these kind of lines. Can you please provide your preferred style?
>>
> 
> Looking at the same driver I would expect something like:
> 
> https://elixir.bootlin.com/linux/v6.18/source/drivers/iio/adc/ad9467.c#L289
> 
> So, just break the line when the col limit is reached.
> 
>>
>>>
>>>> +		.scan_index = 0,
>>>> +		.scan_type = {
>>>> +			.sign = 's',
>>>> +			.realbits = 12,
>>>> +			.storagebits = 16,
>>>> +		},
>>>> +	},
>>>>  };
>>>>  
>>>>  static const struct iio_chan_spec ad9467_channels[] = {
>>>> @@ -367,6 +389,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
>>>>  	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
>>>>  	.vref_mask = AD9434_REG_VREF_MASK,
>>>>  	.num_lanes = 6,
>>>> +	.offset_range = ad9434_offset_range,
>>>>  };
>>>>  
>>>>  static const struct ad9467_chip_info ad9265_chip_tbl = {
>>>> @@ -499,6 +522,33 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
>>>>  	return -EINVAL;
>>>>  }
>>>>  
>>>> +static int ad9467_get_offset(struct ad9467_state *st, int *val)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	*val = ret;
>>>> +
>>>> +	return IIO_VAL_INT;
>>>> +}
>>>> +
>>>> +static int ad9467_set_offset(struct ad9467_state *st, int val)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	/* Sync registers */
>>>
>>> I think this is not what David meant by adding a comment. IMHO, the comment as-is does not
>>> bring any added value.
>> The sync operation is needed in several places and is not commented in
>> other locations either. Do you prefer no comment or even more elaborate
>> comment for this particular sync operation?
>>
> 
> I know. I'm just stating the comment, as is, does not bring much value. But I was not the one asking
> for it so I guess you should ask David :)
> 
> - Nuno Sá

I did not look at the rest of the driver before. I guess the
fact that it does the sync after every register write makes it
clear enough that this is just a thing you have to do. So I'm
OK with leaving out the comment.

What I was asking for though is _why_ do we need to do that?

