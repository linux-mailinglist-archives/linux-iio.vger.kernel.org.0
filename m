Return-Path: <linux-iio+bounces-6394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E490B330
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4718A1C218DC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865913BC26;
	Mon, 17 Jun 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXugy9SS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3D13BC04;
	Mon, 17 Jun 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633428; cv=none; b=mjSm3ipDYyYhav0H1xhVjKGr7i8MVbaggV4P3PO0djHdgICXwV99ZBw5MWKuPr0fPaySct1j/eufYG7EyVgMLsqAeSMztcRSdKiL72WUSvo5MVL6zFa0+gfuCC0PuA5cJlo2VTNGnwSkfftdY4tf2wwxAmKsDGD5QKguZPkQb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633428; c=relaxed/simple;
	bh=4fQyS4lZ8DrSzuPs5H+zW7kbdRv/e2FpirJuM8+9mUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toWv5L2I3jKkurmoFukOxE2kPnSM+bnzGtigtLv8nIbCM4c4K0IDqsPba4RKzXCQP752W03oV8ZJOUDHWjfgQIqaUvtGsNWUYIEuBP3iwMIvuxVATqHDRS35NkAwFN0gErj/n7N8cZC+J6Hwu8jZhGhhfoRyct4Qr/OjMypPvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXugy9SS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421d32fda86so45931855e9.0;
        Mon, 17 Jun 2024 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718633425; x=1719238225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZ4Atedj+cTeQnJYOqBBYMI3xokxWG67aA35FLl+1p0=;
        b=GXugy9SS7SwTu8H2vEqr+YqzYBehEo91n+am/zGpBlp8Qv7YdtAJKX1a2J0vZSD9tm
         kcKhqtQKnl70GPWrGFBzkTklTFVv5FxVDrtObZNuuuloLCFGnY3dIXxPMUlUesxsXey2
         FqbeGU1Uz/SMTJ9DXyb++iBS3qCvi6jiGesxmYxzzVnk4k5GTlHNPyBmi/0GHxHCHzzF
         M0JcYQFl9RH2zXsdeCSCTmoiOqN5Kp8jSmKfbbdUPfKlz4NoNpckyT2FmVfqgwKT4J5M
         KszyAC+QFshA1sMpq2Y8V2g6D+caCR9ZxTukpVQGLjGnxnCjCHxkPCMh21aS+LetGoV/
         9KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633425; x=1719238225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZ4Atedj+cTeQnJYOqBBYMI3xokxWG67aA35FLl+1p0=;
        b=NXGhpOJ3x5abcaaJ0zbSd35n059UVc3frQo9/nRjNhK/U/y5q9cUj+SKRipvi91qUR
         thhE/4pLi1OgsNgDQHxmjaZt0qqqT9+pJGv18UnnLV+Ikgnx5p+loetuqZsgHi8+KhKt
         F5pbHIllhSVAj5LCC5+JFMcIukdgoqHrOEUBuxPnrCk7LSHosHWubbw6lFaGBpb6pIYj
         FJ8U/3m4046cXEHPQmec6vng9he56aRNYLv96ItY1gfP/V2f6oj7ReZxoOvhnGONYB0R
         h2PmFduTfn1sOrBh38drO56fAUMGpSNtUBR+tyzd+Be2T30zuLc+ZBmreIGvHaMWDKAP
         j0+w==
X-Forwarded-Encrypted: i=1; AJvYcCW6NLb6vN5QB377eKVlb4mszU4j1Rj/Lno4jIqcapkEK9kHW7dqdqMvTKOyY94BbCoRc2ZG6jgNK6xHLJZboKFj8FgYTMlv7lPPCAfe9egw9bgtl/KrV4Fu/Jvi0VzThIYmSVkgmUL/
X-Gm-Message-State: AOJu0YxWBLgsg8hqS04wbYStB8YLO34l5KC351kjDspjMrjm6RZjXL6o
	fed7AkHsywgENeEX7pRbv3xTiZzDdrYlIOKWd60LZJLVtWM4b4Hg
X-Google-Smtp-Source: AGHT+IGRF51tkLp3WZnsxj/vyKBToVe5B2F0UmfE4Z7BUH6zmOOagiJuz6+rd7LSnzPjQz03A0UK2A==
X-Received: by 2002:a05:600c:4c23:b0:421:756f:b2e8 with SMTP id 5b1f17b1804b1-42304820d66mr96428045e9.11.1718633425375;
        Mon, 17 Jun 2024 07:10:25 -0700 (PDT)
Received: from [10.76.84.188] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127c1esm159464465e9.23.2024.06.17.07.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 07:10:25 -0700 (PDT)
Message-ID: <15a0c2d8-9df4-4a26-bdf4-01f9c3f76ca7@gmail.com>
Date: Mon, 17 Jun 2024 17:10:23 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
 <20240615130858.22043725@jic23-huawei>
 <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
 <CAMknhBFJ01Xu69Arvd3S=dbADGFmzaYKm2XBtw_CtnjtYwnnew@mail.gmail.com>
 <2d47aeef-5ee0-4e6f-a408-ba5d737d2c5a@gmail.com>
 <8dd5f4b9-809f-43d8-ba5c-5f7be23107a4@baylibre.com>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <8dd5f4b9-809f-43d8-ba5c-5f7be23107a4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.06.2024 16:48, David Lechner wrote:
> On 6/17/24 8:38 AM, Alisa-Dariana Roman wrote:
>> On 17.06.2024 16:22, David Lechner wrote:
>>> On Mon, Jun 17, 2024 at 4:35 AM Alisa-Dariana Roman
>>> <alisadariana@gmail.com> wrote:
>>>>
>>>> On 15.06.2024 15:08, Jonathan Cameron wrote:
>>>>> On Wed, 12 Jun 2024 16:03:05 -0500
>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>
>>>>>> This makes use of the new devm_regulator_get_enable_read_voltage()
>>>>>> function to reduce boilerplate code.
>>>>>>
>>>>>> Error messages have changed slightly since there are now fewer places
>>>>>> where we print an error. The rest of the logic of selecting which
>>>>>> supply to use as the reference voltage remains the same.
>>>>>>
>>>>>> Also 1000 is replaced by MILLI in a few places for consistency.
>>>>>>
>>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>>
>>>>> Complicated bit of code, but seems correct.
>>>>> However, it crossed with Alisa-Dariana switching adding a
>>>>> struct device *dev = &spi->dev to probe() that I picked up earlier
>>>>> today.
>>>>>
>>>>> I could unwind that but given Alisa-Dariana has a number of
>>>>> other patches on this driver in flight, I'd like the two of you
>>>>> to work out the best resolution between you.  Maybe easiest option
>>>>> is that Alisa-Dariana sends this a first patch of the next
>>>>> series I should pick up.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Jonathan
>>>> I will add this patch to my series and send it shortly.
>>>>
>>>> Kind regards,
>>>> Alisa-Dariana Roman.
>>>
>>> Great, thanks!
>>
>> Just one quick question:
>>
>> I am getting two such warnings when running the checkpatch script:
>>
>> WARNING: else is not generally useful after a break or return
>> #1335: FILE: ./drivers/iio/adc/ad7192.c:1335:
>> +        return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
>> +    } else {
>>
>> Should I switch the last two branches to get rid of the warnings or just ignore them?
>>
> 
> In the other patches, I was able to reorder things to avoid this
> warning, but since this one was more complicated, I just ignored
> this warning.
> 
> We can't just remove the else in this case because the return
> is inside of an `else if`.

	/* AVDD can optionally be used as reference voltage */
	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
	if (ret == -ENODEV || ret == -EINVAL) {
		/*
		 * We get -EINVAL if avdd is a supply with unknown voltage. We
		 * still need to enable it since it is also a power supply.
		 */
		ret = devm_regulator_get_enable(dev, "avdd");
		if (ret)
			return dev_err_probe(dev, ret,
					     "Failed to enable AVDD supply\n");

		avdd_mv = 0;
	} else if (ret >= 0) {
		avdd_mv = ret / MILLI;
	} else {
		return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
	}

Would switching the last two branches, in order to get rid of the 
warnings, make the code harder to understand?


