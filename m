Return-Path: <linux-iio+bounces-6216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE79058E3
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483E41C21705
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD4181330;
	Wed, 12 Jun 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y4km6yrm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361016E882
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210178; cv=none; b=GYq2n4QO3os77ymNZt+joMG9sG95co9dzBkr4h0jb37adKCdKSvu9DNJ/+B6JNqS+Q7ywIR5GrVR/pjUl07MVhLUmYcZGIF73HBy7FuEdINCeNGVjPS4sPL8TPjlvmfauWauCxluUTR8rzb2xEEBiGn5X/fS0HBZTyEA+Oa+cZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210178; c=relaxed/simple;
	bh=7vprfaAy+/aNUKk+kDbOiywSxFojlqtspogVZkl4nTQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eF0WNcaRs/Fwhndr0AZpEg4KhC7AJMlqbM3+dlxKOUgW6OWUGWSR1+veDzvcWKDyTi3NorYvMz0n9Tl6nbTgK6OuSp9QfLwhO5N9OYeLCPxnpEKcKc/nR2J4QitE8A7hGZUetrfZ36wWuWxjQCdVEMjYu+7xIv8kAHBCN1GRObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y4km6yrm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebed33cbaeso26335021fa.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718210174; x=1718814974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bKTobHHeGnkatIF6+SqsXuu/2VlIYkxSM06piFfY/sw=;
        b=Y4km6yrmH/MOurMmg3go4xS8PXGyFim7If77UWqmv+aFiusPGxRCkifzgL/147CHMC
         7KdSX262IniwTscqpqc2pTC7K+XgxGAlfvxAi99HQwyW8Z6vfPy74IbtYwvKf//aGYVd
         C7ygq5Jnqntsoacjr+EQGfCBDC/BYyMXhIB31X3ylMJTYL5vql0ZTX7lAMV6WnMczljk
         dwS+ZQ4hLNL3n8DYj7JJIQcuS08EN0W77kmqHPVuuitLqBjxOEO/H7vwDmHzaUpKrJyq
         Ort45qLZqoJ/pqUeL2/PzncC5gQGCburC4dlbxcNlURgmF6MhO6hbyxqljsZeUb0fwSZ
         Qr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210174; x=1718814974;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKTobHHeGnkatIF6+SqsXuu/2VlIYkxSM06piFfY/sw=;
        b=RMQS+EyHrELI8eCIsDC28K6uMICA/6fnZvo1BDiP343nQtEbu44zaqBS70jluibqk8
         HvkBaBU/vShUkUx/NsWQROwueW1RQrOiycLF1fcYd4po0bhudU/DjdjBtD87hpsQRSw2
         g96KZ53Q8vDZHm1182LJchm7N778o1Y8waGjvTC9pFy27+ZV+4Je+omJVJxHeHpB1VLf
         ea1lLpYMJUybisyNWIuPqILFYXxxAaAa19Zj13zW58J0Uuw4GeGHmmfMTlNFH1KredCr
         iqiaBQx27FC421V0B6OQ83CEdx/HVK4v2tLyKXU9uEauCOrr+yKuydwaN/R0GEwTMSB9
         MkVA==
X-Forwarded-Encrypted: i=1; AJvYcCXkkLHJexqWavRGcK+VW5CzLX7m8UiDHokeL3zY1xVCoIbP45if1y/6FkbIzd0B1zv7b0DZ1z6wDz+JVKn4c0tjVcnzD40UUR3k
X-Gm-Message-State: AOJu0YyjTJghCpp/BxG1v9myB/zN+WNg/5V33RxnCX5UQKjCZpTaHZxt
	pjGubTBfwpllgQ2dsGqAmYdXr4JIDW72TZWqIOtRGqzjKU/2RbEkgtY+TTD8D+w=
X-Google-Smtp-Source: AGHT+IFY910HY6EtcZZHlDUUywnpSePswjY4naCvy8H+e+Wer3wMJAZi0qBD5yz5ZV+/y/ANvtFMKQ==
X-Received: by 2002:a2e:87c5:0:b0:2e9:881b:5f02 with SMTP id 38308e7fff4ca-2ebfca6145fmr13444141fa.53.1718210173634;
        Wed, 12 Jun 2024 09:36:13 -0700 (PDT)
Received: from [192.168.0.2] (host-79-40-233-231.business.telecomitalia.it. [79.40.233.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eefa07sm32159465e9.8.2024.06.12.09.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:36:13 -0700 (PDT)
Message-ID: <9e21de1f-d0b1-4a00-a73d-9f35d8cedf1b@baylibre.com>
Date: Wed, 12 Jun 2024 18:35:32 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] minor fixes and improvements
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522150141.1776196-1-adureghello@baylibre.org>
 <751faef385f81f8a2dd0dcc2acd2d4519bebebe5.camel@gmail.com>
 <20240525180631.13446abc@jic23-huawei>
 <826c3185-74ca-423c-96f2-4fd4cf2481cb@baylibre.com>
Content-Language: en-US
In-Reply-To: <826c3185-74ca-423c-96f2-4fd4cf2481cb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan, Nuno,

just to be sure, is there something else needed from my side
for this patch-set ?


Thanks,
regards,
angelo

On 28/05/24 9:16 PM, Angelo Dureghello wrote:
> Hi Jonathan,
>
> On 25/05/24 7:06 PM, Jonathan Cameron wrote:
>> On Thu, 23 May 2024 14:45:01 +0200
>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>
>>> On Wed, 2024-05-22 at 17:01 +0200, Angelo Dureghello wrote:
>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>
>>>> After testing this driver, add some minor fixes and improvements,
>>>> as adding single channel variants support (ad3541r, ad3551r), also 
>>>> as a
>>>> preparatory step to bigger future improvements related to fast-rate 
>>>> mode
>>>> for this DAC family.
>>>>
>>>> Previous patches (v1, 3/3)
>>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-1-adureghello@baylibre.org 
>>>>
>>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-2-adureghello@baylibre.org/ 
>>>>
>>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-3-adureghello@baylibre.org/ 
>>>>
>>>>
>>>> Angelo Dureghello (6):
>>>>    dt-bindings: iio: dac: fix ad3552r gain parameter names
>>>>    dt-bindings: iio: dac: add ad35xxr single output variants
>>>>    iio: dac: ad3552r: add model data structure
>>>>    iio: dac: ad3552r: add support for ad3541r and ad3551r
>>>>    iio: dac: ad3552r: change AD3552R_NUM_CH define name
>>>>    iio: dac: ad3552r: uniform structure names
>>>>
>>>>   .../bindings/iio/dac/adi,ad3552r.yaml         |  43 ++++--
>>>>   drivers/iio/dac/ad3552r.c                     | 140 
>>>> ++++++++++++------
>>>>   2 files changed, 128 insertions(+), 55 deletions(-)
>>> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>>>
>> This series crossed with a series using
>> device_for_each_child_node_scoped()
>>
>> I've rebased on top of that. Was moderately straightforwards but
>> given last week I messed a similar change up completely please
>> check the testing branch of iio.git!
>>
>> The mess was all it the patch adding model_data
>
> i tested the driver from the iio testing beranch,
> it works as expected.
>
>> Thanks,
>>
>> Jonathan
>
> Thanks,
>
> Regards,
> angelo
>
>
-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


