Return-Path: <linux-iio+bounces-4277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8A8A450E
	for <lists+linux-iio@lfdr.de>; Sun, 14 Apr 2024 22:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C021F211A8
	for <lists+linux-iio@lfdr.de>; Sun, 14 Apr 2024 20:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27D13698A;
	Sun, 14 Apr 2024 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ajuK0QBy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F06136663
	for <linux-iio@vger.kernel.org>; Sun, 14 Apr 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713126269; cv=none; b=QNowTOsmGHfZGLhy6j44Q11VPjVSYYqdY1/pRgAAvdC6VGRuhl8P6DrK5TWWYl5rAmkMK2ExqaNaHmsL6kOSjHrh/ADzja33AsMXUUSc8Y2bDBPoJkRncfyJMgDmaWJpLB6zExGAMUruKW0BShlmIWtdtpl4/OQYccS9F0bpRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713126269; c=relaxed/simple;
	bh=hpG76AXQMNJSTW6q8p9oAbDZCw5GU7vZBrY397xUNAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwV1PkgUXMMjk0UrLcVJJy4aI4Yh4DFIpku9h83+sKmzj7ksuAOfiM/eTXRuPdT+WTZEeVCVaT94SKA43GS+wcqZYMB7U02TdlH0rtgORUtQ96ajWDIjzvrr+qbbAr1hhFJCYneGkw6Helf9x8TqJDJAFMlqWkW8DKCfMYr1Y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ajuK0QBy; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb7ac9e726so397464a34.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Apr 2024 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713126267; x=1713731067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdgK/xtc7abW4FhKh59TEUuplN1RfRrEnq28gtTaSyU=;
        b=ajuK0QBylswuYiriDpobjmId/LzKT6rY/synfzLq6uRCru3qPlPPxVYD5uTBGLEBp8
         TcZm4zc0ZjXl0k8lUSS+m85oBI6yAZAcwRKe0GWTZ7RhIyiU+Peegp2LzPKCwWXVuzTV
         KbwpiK2shx0bwq1Nw6nowYW86UtNLBW2RO4+PJQhgU/xkjSiKnA6HHID033xfJQwLdJZ
         jvjpZmYyEiNL5nh506ym6Ac4e71SdOVNrb2KOHfLiM0CY8p2dyYkYDcWvEFn/lqIwaIG
         B0VbZMr9FW9v+u990AkjjLqa2wtX16ZGxGn9PssSCfLb7mipwYahfD1YfN5B1fTbexg7
         wLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713126267; x=1713731067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdgK/xtc7abW4FhKh59TEUuplN1RfRrEnq28gtTaSyU=;
        b=Rp272KXtb/U6wYkUyezpAZcI0cZIn8AIef30yutDJ+8i48KtkUkphrAj+s+o4MsGLg
         A4AY3H5QbnITVEjXPpWfXgE4oxM4IVsPUwge4m7SJBEPFksQy+hG5IEr46tBFxpP39fv
         yXrsIdCEt4iddYpmrBvtNaDTcCuQBjPkVgqi0gocVqMR6k2pYsvyLOQtjAujShEiCy0F
         KXl2eZ8Lkl5cKJiFQJi/rKdJFisz0m8qUWHcQT4T3xGyY4ZGt+/EjyPVbJWWkDGkuakR
         SHlITZ3ouaBjgLGieXmtTeF1BxVgtcGPMyvV+kNKRKG8OhUcoqJ1mexEqzH27OhXF4bv
         y0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjYvfwit65GlcqlMURlvrcwkeWVkRaLSj2v+lsRsADczfjoz3gVzzcoH62CvEF4tn8tZCs5z7+1N+tOBkG6HlqmFUJPK2559Aw
X-Gm-Message-State: AOJu0YzwrjJEdlELFjo84ZCDqzgWjbed63LmfxwXbGPIVoagdZjnEzPp
	HPsFuZOSqERTF57FzsIVdSZAYmJXGSWs8S/jp+vvEgPIk6+gdlILH+W4p5rCTgU=
X-Google-Smtp-Source: AGHT+IGSQ9n8Spb2DdgblHtgvUMvEgGhpKI45I0vDjzH7W8brusklAhPJt2w/vyyYYOPEKFb42bkUg==
X-Received: by 2002:a05:6870:ac1f:b0:22e:be3e:b32 with SMTP id kw31-20020a056870ac1f00b0022ebe3e0b32mr10150823oab.37.1713126266900;
        Sun, 14 Apr 2024 13:24:26 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id wz2-20020a0568707ec200b0022e9ffdb5a5sm1924841oab.24.2024.04.14.13.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 13:24:26 -0700 (PDT)
Message-ID: <2c6b6383-dbf5-4b80-ae97-79a1725b2cb5@baylibre.com>
Date: Sun, 14 Apr 2024 15:24:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iio: adc: ad7192: Add AD7194 support
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
 <20240413151152.165682-6-alisa.roman@analog.com>
 <CAMknhBFzUeW5+rs_GgCZCiit=eW04VHyCnt-__jXLnO3Z29ksA@mail.gmail.com>
 <dfa86da4-7d2d-4d7e-ac50-86d3713f44d9@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <dfa86da4-7d2d-4d7e-ac50-86d3713f44d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/14/24 3:14 PM, Alisa-Dariana Roman wrote:
> On 13.04.2024 23:05, David Lechner wrote:
>> On Sat, Apr 13, 2024 at 10:13 AM Alisa-Dariana Roman
>> <alisadariana@gmail.com> wrote:
>>>
>>> Unlike the other AD719Xs, AD7194 has configurable differential
>>> channels. The user can dynamically configure them in the devicetree.
>>>
>>> Also modify config AD7192 description for better scaling.
>>>
>>> Moved ad7192_chip_info struct definition to allow use of callback
>>> function parse_channels().
>>
>> It looks like this no longer needs to be moved in this revision.
>>
>>>
>>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>>> ---
>>>   drivers/iio/adc/Kconfig  |  11 ++-
>>>   drivers/iio/adc/ad7192.c | 140 ++++++++++++++++++++++++++++++++++++---
>>>   2 files changed, 138 insertions(+), 13 deletions(-)
> 
> ...
> 
>>
>>> +       if (!ad7194_channels)
>>> +               return -ENOMEM;
>>> +
>>> +       indio_dev->channels = ad7194_channels;
>>> +       indio_dev->num_channels = num_channels;
>>> +
>>> +       device_for_each_child_node(dev, child) {
>>> +               *ad7194_channels = ad7194_chan_diff;
>>> +               ad7194_channels->scan_index = index++;
>>> +               ret = ad7192_parse_channel(child, ad7194_channels);
>>> +               if (ret) {
>>> +                       fwnode_handle_put(child);
>>> +                       return ret;
>>> +               }
>>> +               ad7194_channels++;
>>> +       }
>>> +
>>> +       *ad7194_channels = ad7194_chan_temp;
>>> +       ad7194_channels->scan_index = index++;
>>> +       ad7194_channels->address = AD7194_CH_TEMP;
>>> +       ad7194_channels++;
>>
>> nit: It would seem more natural to have all voltage channels
>> altogether rather than having the temperature channel in between.
> 
> I wrote the channels like this to match the other chips:
> 
> static const struct iio_chan_spec ad7193_channels[] = {
>     AD7193_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M),
>     AD7193_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M),
>     AD7193_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
>     AD7193_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
>     AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
>     AD7193_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
>     AD7193_CHANNEL(6, 1, AD7193_CH_AIN1),
>     AD7193_CHANNEL(7, 2, AD7193_CH_AIN2),
>     AD7193_CHANNEL(8, 3, AD7193_CH_AIN3),
>     AD7193_CHANNEL(9, 4, AD7193_CH_AIN4),
>     AD7193_CHANNEL(10, 5, AD7193_CH_AIN5),
>     AD7193_CHANNEL(11, 6, AD7193_CH_AIN6),
>     AD7193_CHANNEL(12, 7, AD7193_CH_AIN7),
>     AD7193_CHANNEL(13, 8, AD7193_CH_AIN8),
>     IIO_CHAN_SOFT_TIMESTAMP(14),
> };
> 
> Kind regards,
> Alisa-Dariana Roman
> 

Consistency is good too. ;-)



