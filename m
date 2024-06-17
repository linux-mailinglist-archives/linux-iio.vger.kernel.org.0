Return-Path: <linux-iio+bounces-6351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCCA90B214
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4174F288FD2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B0F19B5A4;
	Mon, 17 Jun 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTcXDrEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928A198A2F
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632100; cv=none; b=DdDZPMc1+lp6Pf+F1yhDDp2Ppc3uhOGmfIBNrUTXCvYQ28esz5c7sxl27mM66nj9i6niYejl+Aw61Qn3WHQudub0yutf5oUOBDUggl4vbYfYo3S1KFOXB8nH6YBraDeADUGxufqJF8bMnujLqKNCMRk8Xb+7RDjorFbNnBkh4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632100; c=relaxed/simple;
	bh=XlBC8XmxY4t1dy9Te3CUtaaCes8aSp154MhAUu+Mo4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMqUCl4e1YLOojviTf+SBY8BU0Xzi7znvOObjlRTQV0iiCo8qP7WDek4RExqg06GP2SEZhYJH7xsOMw3uIqPF8Td9u4em3PD/Q2w4T/A51GYSM8Rsrtbz6OpEYwiNsvn6g883lUK18ZPWsI0qxRS+EJSizx+DX+LfjU3j1oI+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dTcXDrEx; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f9923df5dbso2521257a34.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632096; x=1719236896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWLganjcvsKmuzSLhK4Gg+9DQYYQdBiUVwwZvrufBCA=;
        b=dTcXDrExjyvqmV2QI/TydR2WXHUxqi7UabJWWXWNCXRSqqB88GF0/tP36OJme23hNF
         kYfdegZs3fTmPO55u/gullSvpeha19K0DizXA27oaz8BVg1Svheyua/ePjIvtslIKa4u
         QWpIvLXGG/rflgFAj7fl5wKPvRRes052Con0p//m+of02FcdhxMt05Ao/b27OoXK6cQk
         mxCF/QSmrY+/b3Xmv4vPFKcShRW+Fm/V4+6Ib1dpxw1UIxyXVGcDfObyE5MONOp2DbmM
         iFL4rWeOQQfZCd7yzNCPUXV1NT6OZq74UZQl+mPzZ/JVef9aHO4+GmdP0JjgBEUisrx3
         qZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632096; x=1719236896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWLganjcvsKmuzSLhK4Gg+9DQYYQdBiUVwwZvrufBCA=;
        b=jF6mfkd3n7vG3ia8jAIYDJXs7vUZtGslS/ik4a7r2NLHsmQIMfMtRsAFz1tXndJca8
         wmz/qYlhzN8u3QtEOqQ19cEp0VqHaVZjeiU/YUDve6VUpj1C2Af5Quy9TfzNcuBmaUF2
         EPCfIG6sm52xktQMgYVS9cLFkmlzxwAYC3qugvPuxbyUe0qdS0quv+u/c7RecVAISBE1
         FDcbPWtiOxSo5dnJaEpNHJoDSQOsvmShWaOBWCEtV0gYsWu5JVa3Od2MwaD5uI7+Yml7
         naNaIevxbJIVHn3VzXVyqFoJvHNfKaru2/x117pqKls3PPgHy0D9zGLKaRguJMipp2+D
         qIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqVmq8FvlMuVrrIzxxbYCOKcW0y7MWqgryyYUzpg6wGPLTht3zNFKmcsZw85Y06Il+UYt5MpwifvOsW9XLt/oawfMoproXQ2n1
X-Gm-Message-State: AOJu0YynERYGPbiqeYacgt/hxDZCQJTWwEcdloTV8kNp9IF7BP8uzPxx
	/CkoK3u8MKV8pUpOhEjd5EgUuEdN6hfes9X36yobJmOWXbb3OEHL3scKQJGATXc=
X-Google-Smtp-Source: AGHT+IHkRtJd/vDpa8HnxwEUUUh80/TzTJPmRFYKwvof3Nxq9J0ov+M7AjFrMMTnUlOZiatmClt/nQ==
X-Received: by 2002:a05:6830:1202:b0:6f9:90de:c67f with SMTP id 46e09a7af769-6fb937665b7mr11817267a34.10.1718632096492;
        Mon, 17 Jun 2024 06:48:16 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0bd9sm1528611a34.27.2024.06.17.06.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 06:48:15 -0700 (PDT)
Message-ID: <8dd5f4b9-809f-43d8-ba5c-5f7be23107a4@baylibre.com>
Date: Mon, 17 Jun 2024 08:48:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: Alisa-Dariana Roman <alisadariana@gmail.com>
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2d47aeef-5ee0-4e6f-a408-ba5d737d2c5a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/17/24 8:38 AM, Alisa-Dariana Roman wrote:
> On 17.06.2024 16:22, David Lechner wrote:
>> On Mon, Jun 17, 2024 at 4:35 AM Alisa-Dariana Roman
>> <alisadariana@gmail.com> wrote:
>>>
>>> On 15.06.2024 15:08, Jonathan Cameron wrote:
>>>> On Wed, 12 Jun 2024 16:03:05 -0500
>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>
>>>>> This makes use of the new devm_regulator_get_enable_read_voltage()
>>>>> function to reduce boilerplate code.
>>>>>
>>>>> Error messages have changed slightly since there are now fewer places
>>>>> where we print an error. The rest of the logic of selecting which
>>>>> supply to use as the reference voltage remains the same.
>>>>>
>>>>> Also 1000 is replaced by MILLI in a few places for consistency.
>>>>>
>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>
>>>> Complicated bit of code, but seems correct.
>>>> However, it crossed with Alisa-Dariana switching adding a
>>>> struct device *dev = &spi->dev to probe() that I picked up earlier
>>>> today.
>>>>
>>>> I could unwind that but given Alisa-Dariana has a number of
>>>> other patches on this driver in flight, I'd like the two of you
>>>> to work out the best resolution between you.  Maybe easiest option
>>>> is that Alisa-Dariana sends this a first patch of the next
>>>> series I should pick up.
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>> I will add this patch to my series and send it shortly.
>>>
>>> Kind regards,
>>> Alisa-Dariana Roman.
>>
>> Great, thanks!
> 
> Just one quick question:
> 
> I am getting two such warnings when running the checkpatch script:
> 
> WARNING: else is not generally useful after a break or return
> #1335: FILE: ./drivers/iio/adc/ad7192.c:1335:
> +        return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
> +    } else {
> 
> Should I switch the last two branches to get rid of the warnings or just ignore them?
> 

In the other patches, I was able to reorder things to avoid this
warning, but since this one was more complicated, I just ignored
this warning.

We can't just remove the else in this case because the return
is inside of an `else if`.

