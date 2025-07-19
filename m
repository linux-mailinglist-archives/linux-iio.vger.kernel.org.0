Return-Path: <linux-iio+bounces-21778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0AB0B0E0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2573B5FD1
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0041C8632B;
	Sat, 19 Jul 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3PWlfJS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2429801
	for <linux-iio@vger.kernel.org>; Sat, 19 Jul 2025 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752941840; cv=none; b=tKECo/mW0p7BN3/0enhn3W3iQ7m1De5aPdoD6yC9lG3LT8BXD6Jn/b5HfodnlahJh3pdG3u4YwMPdZ3S/MUyxxKDiCbenQ7CY3eFMNBsEGuKG15I6yzVwOzU+pKXSBR2fhhH4YAGuKjBQRAkhcI4MjHZ9zj6M1YmPv6+ZKqA82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752941840; c=relaxed/simple;
	bh=qKcvYEflXjGcl16neqw/K1Zlvjh4OjpKnG3NkUObSQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLCRTixvHPBvFe+mBkkmuKCemWdf0PdXG3pZQV37EsDnMSo1mPCdprbErac4NdjP99lQuMDySOqcpxGNwwwXLckX7H2Mo6SEcCp3vaLKJGFG9ezm1HleFSpChD4PbJ9fjOcYG9eKUlskAn4EpwDpShPPQ0Lxt21Gu+TvAAI2DA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3PWlfJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AE0C4CEE3;
	Sat, 19 Jul 2025 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752941838;
	bh=qKcvYEflXjGcl16neqw/K1Zlvjh4OjpKnG3NkUObSQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j3PWlfJSjqN60j913DC2/giZzyDB8ti2GuYpaocBmJPk7cO9Du/UPmUfrBGvxgkGz
	 e0QpFr9iDu9vzulgaL83DnfK7KbChTVbRzF6uXAgRVyEPw1yCTcNT9AwqbApY5+0My
	 FdbTn9ReN2BZNExIsj4S2a3D2fFLU9xZA7sdoLJt3jEQI1hf3jdGcU7BafB0otqTXt
	 NjA1thiQvxlySHRUJNb1cdglz8zUthNLYI1xn6R6uPopL6c/GrvLyfjzsEJFcNtlCV
	 37nP+4A9MdpxVHFoRtjn3TMGd3Zp/A6MAoundljWNxq4y7Ijf82Jh/V8/oVGxMRkhw
	 MeqgVOw0a3baw==
Message-ID: <68cac85c-d19e-4de8-b06b-1b82d30906fd@kernel.org>
Date: Sat, 19 Jul 2025 18:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20241219230028.55987-1-hdegoede@redhat.com>
 <20241220194249.434244e0@jic23-huawei>
 <a0d1bcf9-74e1-43cb-9f4f-1fb6f5b20724@kernel.org>
 <20250719120417.7bef0731@jic23-huawei>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250719120417.7bef0731@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 19-Jul-25 1:04 PM, Jonathan Cameron wrote:
>>>> +	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);
>>>> +	if (ret == 0) {
>>>> +		dev_err(info->dev, "Error sample timeout\n");
>>>> +		ret = -ETIMEDOUT;
>>>> +		goto disable_adc;
>>>> +	}
>>>> +
>>>> +	ret = regmap_read(info->regmap, chan->address, &msb);
>>>> +	if (ret)
>>>> +		goto disable_adc;
>>>> +
>>>> +	ret = regmap_read(info->regmap, chan->address + 1, &lsb);  
>>> bulk read and an endian conversion + mask?  
>>
>> This chip only supports reading 1 register at a time, I'll add
>> a comment about this.
> 
> Set regmap_config.use_single_read and bulk reads should be fine.

Interesting, I did not know about that flag.

But I'm afraid that I've already ending up spending more time
then planned on supporting this old PMIC. fixing all other remarks
from you and Linus W.

And I also hit an i2c-core regression which I've just finished
debugging...

So I'm going to keep the multiple reg-reads as is (it won't
matter for what happens on the I2C bus anyways) I hope this is ok.

I did also write an interesting iio-core patch to make
iio_read_channel_processed_scale() more precise :)

I plan to post a a new series including this tomorrow.

Regards,

Hans




