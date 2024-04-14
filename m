Return-Path: <linux-iio+bounces-4276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FAD8A4505
	for <lists+linux-iio@lfdr.de>; Sun, 14 Apr 2024 22:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E7CB20C98
	for <lists+linux-iio@lfdr.de>; Sun, 14 Apr 2024 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736EE136982;
	Sun, 14 Apr 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dUCVKUBA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF4135A59
	for <linux-iio@vger.kernel.org>; Sun, 14 Apr 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713126064; cv=none; b=EH2gdDElscZgvZh02ViUv77P9G0gpG50oWWUt3Y8BqVQDIJNTEJCjsJkIV76Nz1vGUpZ+S0rmdr1Kx2VNOUwwMPwIrFlwDOI9VAHfnxdga/HDMY5GZmN0Bv8bpz0S0soQZWuEcR4dKnx2C9S1fK6V713WENPI2f242YsHojshgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713126064; c=relaxed/simple;
	bh=pccfd4aCf73rzGa64v46jpRn5G8JUnnvFWF69b1Ys5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjvrxbtBKaIWThziXvRzeDuumJGuS9b12ZPGjDt9dkwDgYNKbCe84bV+cPnouLNxQcEF0reG6d3lNojBMNMSBzzTPD4XjU6gj3HLSueXYepPBLFjuHEjT2dltnHgh+afdE40ORQnmq2D4iMd7hLkqKwkS51Zr6amirea0qR9WVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dUCVKUBA; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6eb77e56b20so718069a34.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Apr 2024 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713126060; x=1713730860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WFsBERXce7Fsz35acZjndQC2yQGU84N+dal9ykpXRE=;
        b=dUCVKUBApIQXh7EhyhSsFTYkxwWN5jtx1fe/x6eLItD1haGtV/xrUakt7taxMs1Ehp
         F1AeROVBmIElWy/VfuWPIgna1yMexT5skIVEXNgnj+mF+NRHHvnf4HNTTgKkPos5nG/c
         nvM88xxBYV13STFwwlmRtdi12XEKbwAjnCed8bOfG/ycP6y7Z4K0vleStbdHl5SM3Ux3
         e7uoviMw8/ak19sWoqvq5ibTMCh8MjWloUwFpJOGTI0ePMM5qPvd4qNF6PzdfA+jRQXy
         d1oZWRBgwBiTbDnKRAk72pki6dOoeSeE6EZl6n9FuTMYYc+bNvzFFVkkqGm/TjI2uRbK
         +Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713126060; x=1713730860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WFsBERXce7Fsz35acZjndQC2yQGU84N+dal9ykpXRE=;
        b=eRS6nWAay/3CN71Xa6mgFIDraf8xfnOGyGoJbWswdxfbg+8gob1n+3xyTPkKepm+sM
         8eXsZfRF4JeS5V/r/BpGyu0/JwC3Pun1Z2p0+kX2jUGZ/3PzePPv5StDW70jeOE4qYh+
         4RcRjau2sdYnPdT4Cy9szW04atrL+aLIbg8VMboIgS7VaybBeq/phOaasbTPEuoYcScI
         eWTdigzIKQHQAIT/+Wk+cGg9v9mPYdB87nC5VWKnnRvLzMucBplwRL3ZF4csXeNP2SH7
         pujKy45qvHOmicjNrvYkhvTZlTF2Tkn4gw81NSA5x8eMFrhZusvLdmiOfIoBy5JhkySh
         rQvw==
X-Forwarded-Encrypted: i=1; AJvYcCWfODXbhkL7uRIfo9mSUAKN4MiR84v4yt7c0Tq/eLElKkLSqK1c7b8PaL5av4QEB91V0NZKSTGcIPeliQRqwaaMIuYvfb8De6Tw
X-Gm-Message-State: AOJu0YxFHCoQMPKUvsaATaxCl4mQIHgzECkiTNkCRXZtzl1xp4evIVKx
	9H7fw3uCWYPN35dUhc01G82g4pPVdHbQFR14r31UhSQ6/yAnq4Y28apZsI0ZQ0A=
X-Google-Smtp-Source: AGHT+IHnPiQiA44NWwv6yMFq7FL05gYBLcc5hgPtuXJ98SI2K6IjMN8gBtPQP/9Fb3kZvhY2rWze1Q==
X-Received: by 2002:a05:6830:1109:b0:6ea:193c:d55c with SMTP id w9-20020a056830110900b006ea193cd55cmr10103697otq.6.1713126060261;
        Sun, 14 Apr 2024 13:21:00 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id p5-20020a9d6945000000b006eb7d7dc9e2sm229895oto.28.2024.04.14.13.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 13:20:59 -0700 (PDT)
Message-ID: <99724bd6-6b1d-413b-a884-4b5b00d6bc0b@baylibre.com>
Date: Sun, 14 Apr 2024 15:20:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] iio: adc: ad7192: Add aincom supply
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
References: <20240413151152.165682-1-alisa.roman@analog.com>
 <20240413151152.165682-4-alisa.roman@analog.com>
 <CAMknhBFk9e=VDYFVUhKmabHKwhJKbVVA4tRz758QszjHLGUEpg@mail.gmail.com>
 <34b08785-86f9-4c28-8d03-928866dbdc10@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <34b08785-86f9-4c28-8d03-928866dbdc10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/14/24 8:58 AM, Alisa-Dariana Roman wrote:
> On 13.04.2024 22:10, David Lechner wrote:
>> On Sat, Apr 13, 2024 at 10:12 AM Alisa-Dariana Roman
>> <alisadariana@gmail.com> wrote:
>>>
>>> AINCOM should actually be a supply. If present and it has a non-zero
>>> voltage, the pseudo-differential channels are configured as single-ended
>>> with an offset. Otherwise, they are configured as differential channels
>>> between AINx and AINCOM pins.
>>>
>>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>>> ---
>>>   drivers/iio/adc/ad7192.c | 53 +++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 49 insertions(+), 4 deletions(-)
> 
> ...
> 
>>> @@ -745,6 +746,9 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>>>                  /* Kelvin to Celsius */
>>
>> Not related to this patch, but I'm not a fan of the way the
>> temperature case writes over *val (maybe clean that up using a switch
>> statement instead in another patch while we are working on this?).
>> Adding the else if to this makes it even harder to follow.
>>
>>>                  if (chan->type == IIO_TEMP)
>>>                          *val -= 273 * ad7192_get_temp_scale(unipolar);
>>> +               else if (st->aincom_mv && chan->channel2 == -1)
>>
>> I think the logic should be !chan->differential instead of
>> chan->channel2 = -1 (more explanation on this below).
>>
>>> +                       *val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * 1000000000,
>>> +                                                     st->scale_avail[gain][1]);
>>>                  return IIO_VAL_INT;
> 
> Hi David,
> 
> I am very grateful for your suggestions!
> 
>     case IIO_CHAN_INFO_OFFSET:
>         if (!unipolar)
>             *val = -(1 << (chan->scan_type.realbits - 1));
>         else
>             *val = 0;
>         switch(chan->type) {
>         case IIO_VOLTAGE:
>             if (st->aincom_mv && !chan->differential)
>                 *val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * 1000000000,
>                                   st->scale_avail[gain][1]);
>             return IIO_VAL_INT;
>         /* Kelvin to Celsius */
>         case IIO_TEMP:
>             *val -= 273 * ad7192_get_temp_scale(unipolar);
>             return IIO_VAL_INT;
>         default:
>             return -EINVAL;
>         }
> 
> I added a switch because it looks neater indeed. But I would keep the if else for the unipolar in order not to have duplicate code. Is this alright?
> 


I didn't notice before that the temperature channel could also be
unipolor or bipolar, so yes this seems fine.


