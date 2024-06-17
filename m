Return-Path: <linux-iio+bounces-6401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AED90B5B0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037F9285730
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04E14A09;
	Mon, 17 Jun 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuQ8UDAC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905B6FDC;
	Mon, 17 Jun 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640090; cv=none; b=VkoAdeSyntsjxX04vSW/ju12tQoGsxNtUnedQX1GKKBd81INmG7F52qNergx7oRbgJPmTauJPvP3XGQpCnIZUpY3HAyYSIrdDfYjPVI05DqFRvUakH+vHQ5/d5yokmlCvZxFZS7O3idbQ/f51uWll7x3HBOXKjPlF5gSnhjA6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640090; c=relaxed/simple;
	bh=u6lCC0FMi8rEvDdwKGwBtaMyItIW3VVu+/3OO594yEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QO9BzDng2wyJVrvl+qN91xc6j7Ew6ZxWAc4JN3cg0I8mn2/cOsPZ3bhuXisVbHUmMImGbbrogQr60JcXMiJ3Mh9h6yhZWheKjrezZIzTSRCerBWJRxaDbEGhnHFy2m52Vp/46dhJ5Y+4rHVzJ0F/fT2QHcBCntNTQ9guJGMn4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuQ8UDAC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f1da33826so625263066b.0;
        Mon, 17 Jun 2024 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718640087; x=1719244887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVUk9wA0RxZg2M8UQ0OYA0L8MdQA1uyTPEgVuaW3yaQ=;
        b=XuQ8UDACaHxmoiNLuWT3AJc7t+YiBTNpi0D9yQHPDuaM9446AAVfbPjH4b4zPgVQCO
         QrM4M15Lrg0l+wN8hWkB726nwsS7YOtyPpCTHiNE5HRG19xx06njSAiN/kK4YxZdh9e9
         3qNhXD64cCZMsFANdbz9N33avDFWdgREsKQPr059LX8OdlZZ7pXf1W/CqFhUtO2LL8tN
         SROrRdjfCRpskJA+HkPsM+VL2X5m1KH3JP7yS1N7OJakbYmFSVMs4Ntr5tujCOBXi0fH
         0PclhC03OhvuEnrOC+Ht+icIDRhWc6sn7tTgYmDB+ICbmBs882d3Mwkb9ZjKH9AAkJ/R
         WHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718640087; x=1719244887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVUk9wA0RxZg2M8UQ0OYA0L8MdQA1uyTPEgVuaW3yaQ=;
        b=jJWD2nPNqFohy3kmWFrn+K1wDt1zXwSJrEMQiwLTXGp3VIfBNQzHeRG8QeuOj3B8HS
         ZhjVBn6eYjuXTW2+SqOmePsVzLdwqSHZIY29YpCm2Tn37mOlNwz192qMJl8/1bWvMpqX
         fhu+U0NrjgqSxNEywSD2/3LAlgxtUmOveJB5RljxnR9dyuhw3R/c4lasZJqse1bHCL4b
         H4hxNrXkpYnSzuRmKRWhYA73clF3H4JIBdAFhEbXEIFwaAp+RxkIHCKRiEIwD75UO+Bg
         W75ZxuAmiRlmfDaA64KwaiXmV5KtOBOSxfKPu6VC+nH0uc7OHIewidWhXpIWhWFn+twt
         JdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw1XLdR1JRcXXRSlXgukqWTS8ZEyeK854OT0xIP/uysXg9FVkFwd99tvzTfa3rYXhjJK6pPK9oaOG0B3KP3pnTeTZrE0dO3JC3LfuMDIUGd111E8bg6HCXz7nHUOnBMXepHpGLeV5K
X-Gm-Message-State: AOJu0YyKWKRFWH3OxkIlhoMVzp4b6C+CNMlhgBSmL7K2Y9fVlr7kfgcT
	TtJoaXPCBVNdTbSjX61T2dKhYG8cY2NSj3Yy1gJYYALQbHHhf17mp3UHlQ==
X-Google-Smtp-Source: AGHT+IErnLWYXPDmTXIWUGBUGOu7bX0bZbAIATutBzZYSHBadoRR7sRAwqHsNHpwge0ec8VsjkVkGA==
X-Received: by 2002:a17:907:9689:b0:a68:fcc9:6c1c with SMTP id a640c23a62f3a-a6f60bdc4d3mr1009559866b.0.1718640086658;
        Mon, 17 Jun 2024 09:01:26 -0700 (PDT)
Received: from [10.76.84.188] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da336fsm522935666b.41.2024.06.17.09.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 09:01:25 -0700 (PDT)
Message-ID: <bbc2f159-d673-4652-a6b9-a528f905b67c@gmail.com>
Date: Mon, 17 Jun 2024 19:01:24 +0300
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
 <15a0c2d8-9df4-4a26-bdf4-01f9c3f76ca7@gmail.com>
 <CAMknhBE=fEDdYPe1VeZwWWuvqf5TcUdM_LQGOugHCxGhSGP8-w@mail.gmail.com>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <CAMknhBE=fEDdYPe1VeZwWWuvqf5TcUdM_LQGOugHCxGhSGP8-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.06.2024 18:28, David Lechner wrote:
> On Mon, Jun 17, 2024 at 9:10 AM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
>>
>> On 17.06.2024 16:48, David Lechner wrote:
>>> On 6/17/24 8:38 AM, Alisa-Dariana Roman wrote:
>>>> On 17.06.2024 16:22, David Lechner wrote:
>>>>> On Mon, Jun 17, 2024 at 4:35 AM Alisa-Dariana Roman
>>>>> <alisadariana@gmail.com> wrote:
>>>>>>
>>>>>> On 15.06.2024 15:08, Jonathan Cameron wrote:
>>>>>>> On Wed, 12 Jun 2024 16:03:05 -0500
>>>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>>>
>>>>>>>> This makes use of the new devm_regulator_get_enable_read_voltage()
>>>>>>>> function to reduce boilerplate code.
>>>>>>>>
>>>>>>>> Error messages have changed slightly since there are now fewer places
>>>>>>>> where we print an error. The rest of the logic of selecting which
>>>>>>>> supply to use as the reference voltage remains the same.
>>>>>>>>
>>>>>>>> Also 1000 is replaced by MILLI in a few places for consistency.
>>>>>>>>
>>>>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>>>>
>>>>>>> Complicated bit of code, but seems correct.
>>>>>>> However, it crossed with Alisa-Dariana switching adding a
>>>>>>> struct device *dev = &spi->dev to probe() that I picked up earlier
>>>>>>> today.
>>>>>>>
>>>>>>> I could unwind that but given Alisa-Dariana has a number of
>>>>>>> other patches on this driver in flight, I'd like the two of you
>>>>>>> to work out the best resolution between you.  Maybe easiest option
>>>>>>> is that Alisa-Dariana sends this a first patch of the next
>>>>>>> series I should pick up.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Jonathan
>>>>>> I will add this patch to my series and send it shortly.
>>>>>>
>>>>>> Kind regards,
>>>>>> Alisa-Dariana Roman.
>>>>>
>>>>> Great, thanks!
>>>>
>>>> Just one quick question:
>>>>
>>>> I am getting two such warnings when running the checkpatch script:
>>>>
>>>> WARNING: else is not generally useful after a break or return
>>>> #1335: FILE: ./drivers/iio/adc/ad7192.c:1335:
>>>> +        return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
>>>> +    } else {
>>>>
>>>> Should I switch the last two branches to get rid of the warnings or just ignore them?
>>>>
>>>
>>> In the other patches, I was able to reorder things to avoid this
>>> warning, but since this one was more complicated, I just ignored
>>> this warning.
>>>
>>> We can't just remove the else in this case because the return
>>> is inside of an `else if`.
>>
>>          /* AVDD can optionally be used as reference voltage */
>>          ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
>>          if (ret == -ENODEV || ret == -EINVAL) {
>>                  /*
>>                   * We get -EINVAL if avdd is a supply with unknown voltage. We
>>                   * still need to enable it since it is also a power supply.
>>                   */
>>                  ret = devm_regulator_get_enable(dev, "avdd");
>>                  if (ret)
>>                          return dev_err_probe(dev, ret,
>>                                               "Failed to enable AVDD supply\n");
>>
>>                  avdd_mv = 0;
>>          } else if (ret >= 0) {
>>                  avdd_mv = ret / MILLI;
>>          } else {
>>                  return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
>>          }
>>
>> Would switching the last two branches, in order to get rid of the
>> warnings, make the code harder to understand?
>>
> 
> I did it in the other order because usually we like to handle the
> error case first.
> 
> To make it more like the other patches, we could do something like
> this. The only thing i don't like about it is that `ret` on the very
> last line could come from two different places. But it is logically
> sound in the current form.
> 
>      /* AVDD can optionally be used as reference voltage */
>      ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
>      if (ret == -ENODEV || ret == -EINVAL) {
>          /*
>           * We get -EINVAL if avdd is a supply with unknown voltage. We
>           * still need to enable it since it is also a power supply.
>           */
>          ret = devm_regulator_get_enable(dev, "avdd");
>          if (ret)
>              return dev_err_probe(dev, ret,
>                           "Failed to enable AVDD supply\n");
>      } else if (ret < 0) {
>          return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
>      }
> 
>      avdd_mv = ret <= 0 ? 0 : ret / MILLI;

Maybe this would make it a bit clearer, but yes, the ret == 0 could 
still come from two different places :(.

avdd_mv = ret == 0 ? 0 : ret / MILLI;


