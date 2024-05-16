Return-Path: <linux-iio+bounces-5065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040278C7762
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9FB281E15
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714BF146D76;
	Thu, 16 May 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2kug9SF1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A51465A4
	for <linux-iio@vger.kernel.org>; Thu, 16 May 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865483; cv=none; b=q9jd9MWwdqqnopUAmnij8NHFLMC/W6VcNa6QbD4+0Mx8FG73ZWmFqonfLw4i+cSF4vQOEYu2lLoqkbpRG3ZH4yz4TWFoKQQHLwapdM4fxqnweDlPP4PbXtQd3F+rwWDeMEw7paiXcu7mf6O8ZDFp+J23v9dsbg7SgY1rr62wkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865483; c=relaxed/simple;
	bh=eWIwOv9Zvvo6YEpALZ/ZPdwbeGaIZJVB3BlqIwm1sn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jESfDQiHr5W+sMI0QDMyQUJmxtV8luMDwk5yl3iZMBvWjSuynnrREpUwp9+5ngwDycBdsQ0RTZRM3SkxCOImaBn2/p1x7B/SNSgg1xzCcGYLXkbaaVjIO5roWQnqQPXnmupofyzMQFMZp3/I7m2Y0WrcTMOvEQbujJ94f7sb+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2kug9SF1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6a0b68733f5so53326766d6.1
        for <linux-iio@vger.kernel.org>; Thu, 16 May 2024 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715865479; x=1716470279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3ryDiibw2FEZDxAgyeJcOHx0hxqbPorlVehc70NqQc=;
        b=2kug9SF1l0uiFvM1Q4XoD3ppYBRvefSEWzClos+oi+yBwP8A9DLyJSHiyOgxQ7gmWH
         mpaJdWUhyLtwrllzxU/OCr9X4q2zrx+dJKm1B2OD2fByA5PMLvQvQnlKYCd4vfkMZDOf
         6/N77N+/lZRWvGPqZdyFBiWIDS0H5/iXcosafMTvPuDv164gjZXbrJwv6zZWhMh6I9Mw
         ztF5E+amsNkCSIkZxmFOu9RhJwbmqWwZEfDpWiU7oJPqGj6evZgyarjhY45SN3gnlOYZ
         UCVjFXMlBH4laopFV3cECtg2zOFHfxQHpoWO7cG1KmmrtGM5kX16oVYRZG/RsWhohUoZ
         Zu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865479; x=1716470279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3ryDiibw2FEZDxAgyeJcOHx0hxqbPorlVehc70NqQc=;
        b=ZsPonykqOkDLcMM3kOMKVuAw2ZlTBnabBsQD1933ffRFE91LYQkHa8MhLZ0dIfNFpo
         pRhyfI/staOapQ87xF5AIXFySofuvfjk59B2Rb3Qto7b2LH+XZouHpc2VI7cNSCMP3jM
         zFyoh5NSB4Pq7ETjuyKqwvmYnsXSt2CQ/vw7tscMYljmmfIwzM7dX2mGo5cZLkFnGONa
         Yfde3so1i6UkQbkha6fbMtMnBtWludNSucXZKGUAgRQT8Wr/8qm1YIll0qTfu84QT+i7
         idgOmk9u7afKh2tIXqyRdyIp3r8TjKDi2nMjg1ipB74AKHl5nJCxGhPqesyoFnW787BW
         xjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVixhB5u5LqMpEVgXqEX4RGxuzhuoSJJFNJ4i3tTjnrJGHagA1+fsGMqtiZV8odZWraN/J+dTWRR5qRYHR9UwUqOHcz8MHYzydY
X-Gm-Message-State: AOJu0YwwyOuXPGXjgHU74rK9vrPgthikqV9jEyINTbqkN3HtQGQ7fhUn
	GAfclMXrV/Nvu+qfePEbeHsiZHKhrfncIfdqbdz39MniYcvcdncek8lP91kqE4E7rT3wugeHK5s
	O3wg=
X-Google-Smtp-Source: AGHT+IEujLLB/2OVCOaeopynbDG1eVKKcIAgIkn7Cc16JQ9OK5R5FdeAk2/xUtVCzZYR2ptdOJ8EbA==
X-Received: by 2002:a05:6214:2b96:b0:6a0:984d:7ff7 with SMTP id 6a1803df08f44-6a1681792e4mr226857446d6.4.1715865479521;
        Thu, 16 May 2024 06:17:59 -0700 (PDT)
Received: from [192.168.0.2] (host-79-16-6-145.retail.telecomitalia.it. [79.16.6.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a35969bcd5sm16517186d6.53.2024.05.16.06.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 06:17:58 -0700 (PDT)
Message-ID: <2943205c-e7dc-4ca1-a174-15df2244c77b@baylibre.com>
Date: Thu, 16 May 2024 15:17:17 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: dac: ad3552r: add support for ad3541r and
 ad3551r
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240510141836.1624009-1-adureghello@baylibre.org>
 <20240510141836.1624009-2-adureghello@baylibre.org>
 <CAMknhBFrOdzvo+aEFjMSf_3FGmbhVp42Oymt_DEF2L-CdWiSmQ@mail.gmail.com>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <CAMknhBFrOdzvo+aEFjMSf_3FGmbhVp42Oymt_DEF2L-CdWiSmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 10/05/24 5:42 PM, David Lechner wrote:
> On Fri, May 10, 2024 at 9:19 AM Angelo Dureghello
> <adureghello@baylibre.com> wrote:
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Add support for single-output dac variants.
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
>>   drivers/iio/dac/ad3552r.c | 39 +++++++++++++++++++++++++++++----------
>>   1 file changed, 29 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
>> index a492e8f2fc0f..0dd6f995c3e2 100644
>> --- a/drivers/iio/dac/ad3552r.c
>> +++ b/drivers/iio/dac/ad3552r.c
>> @@ -140,7 +140,9 @@ enum ad3552r_ch_vref_select {
>>   };
>>
>>   enum ad3542r_id {
>> +       AD3541R_ID = 0x400b,
>>          AD3542R_ID = 0x4009,
>> +       AD3551R_ID = 0x400a,
>>          AD3552R_ID = 0x4008,
>>   };
>>
>> @@ -745,7 +747,8 @@ static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
>>          } else {
>>                  /* Normal range */
>>                  idx = dac->ch_data[ch].range;
>> -               if (dac->chip_id == AD3542R_ID) {
>> +               if (dac->chip_id == AD3541R_ID ||
>> +                   dac->chip_id == AD3542R_ID) {
>>                          v_min = ad3542r_ch_ranges[idx][0];
>>                          v_max = ad3542r_ch_ranges[idx][1];
>>                  } else {
>> @@ -780,7 +783,7 @@ static int ad3552r_find_range(u16 id, s32 *vals)
>>          int i, len;
>>          const s32 (*ranges)[2];
>>
>> -       if (id == AD3542R_ID) {
>> +       if (id == AD3541R_ID || id == AD3542R_ID) {
>>                  len = ARRAY_SIZE(ad3542r_ch_ranges);
>>                  ranges = ad3542r_ch_ranges;
>>          } else {
>> @@ -955,9 +958,10 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
>>                          dev_err(dev, "mandatory reg property missing\n");
>>                          goto put_child;
>>                  }
>> -               if (ch >= AD3552R_NUM_CH) {
>> -                       dev_err(dev, "reg must be less than %d\n",
>> -                               AD3552R_NUM_CH);
>> +               if (ch >= AD3552R_NUM_CH ||
>> +                       (dac->chip_id == AD3541R_ID && ch) ||
>> +                       (dac->chip_id == AD3551R_ID && ch)) {
>> +                       dev_err(dev, "channel %d is not supported\n", ch);
>>                          err = -EINVAL;
>>                          goto put_child;
>>                  }
>> @@ -987,9 +991,10 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
>>                                  goto put_child;
>>
>>                          dac->ch_data[ch].range = val;
>> -               } else if (dac->chip_id == AD3542R_ID) {
>> +               } else if (dac->chip_id == AD3541R_ID ||
>> +                          dac->chip_id == AD3542R_ID) {
>>                          dev_err(dev,
>> -                               "adi,output-range-microvolt is required for ad3542r\n");
>> +                               "adi,output-range-microvolt is required for ad354xr\n");
>>                          err = -EINVAL;
>>                          goto put_child;
>>                  } else {
>> @@ -1088,10 +1093,20 @@ static int ad3552r_probe(struct spi_device *spi)
>>                  return err;
>>
>>          /* Config triggered buffer device */
>> -       if (dac->chip_id == AD3552R_ID)
>> -               indio_dev->name = "ad3552r";
>> -       else
>> +       switch (dac->chip_id) {
>> +       case AD3541R_ID:
>> +               indio_dev->name = "ad3541r";
>> +               break;
>> +       case AD3542R_ID:
>>                  indio_dev->name = "ad3542r";
>> +               break;
>> +       case AD3551R_ID:
>> +               indio_dev->name = "ad3551r";
>> +               break;
>> +       case AD3552R_ID:
>> +               indio_dev->name = "ad3552r";
>> +               break;
>> +       }
>>          indio_dev->dev.parent = &spi->dev;
>>          indio_dev->info = &ad3552r_iio_info;
>>          indio_dev->num_channels = dac->num_ch;
>> @@ -1110,14 +1125,18 @@ static int ad3552r_probe(struct spi_device *spi)
>>   }
>>
>>   static const struct spi_device_id ad3552r_id[] = {
>> +       { "ad3541r", AD3541R_ID },
>>          { "ad3542r", AD3542R_ID },
>> +       { "ad3551r", AD3551R_ID },
>>          { "ad3552r", AD3552R_ID },
>>          { }
>>   };
>>   MODULE_DEVICE_TABLE(spi, ad3552r_id);
>>
>>   static const struct of_device_id ad3552r_of_match[] = {
>> +       { .compatible = "adi,ad3541r"},
>>          { .compatible = "adi,ad3542r"},
>> +       { .compatible = "adi,ad3551r"},
>>          { .compatible = "adi,ad3552r"},
>>          { }
>>   };
>> --
>> 2.45.0.rc1
>>
>>
> It looks like it is time for a chip_info struct here instead of the if
> and switch statements to get chip-specific data. Most other IIO
> drivers have this already and it is the preferred way to look up this
> kind of information in the IIO subsystem. I prefer the drivers that
> don't put all of the info structs in an array (that way the code is
> less verbose). So I would suggest looking at e.g. adc/aspeed_adc,
> starting with aspeed_adc_matches, to see what I mean and how to
> implement it. (So one patch to add the info structs and a second patch
> to add the single channel chips)

Ack, will change in that way.


Regards,
angelo



