Return-Path: <linux-iio+bounces-6879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A4916175
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03353B24450
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3591487F7;
	Tue, 25 Jun 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEjjU/Ft"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D218E1F;
	Tue, 25 Jun 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304674; cv=none; b=ib6KLIPgO16a2Id5uAa8UIf/ypiyBVwG1ZVZHpiX3BMuYZ1TKUDF/RGIVFRjuxTW+eaCUliLiNLC6QCCjgq0fChHHZJj2//5L2EUTOLcdGXExto/6NFiaaspu14gKLg7lKZRx0lHuqKkawy/Lvpv3OVtwckgpwqvgQtq96ueCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304674; c=relaxed/simple;
	bh=aqe5UuDktWE8cVCx+ZXLizURsrkeHlz4k8KCFjKPz8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdpuXzE4nGG7FHcEGeFKPH9cAXlP8rVJX47vW6K1R8snuEDmoChELgK4A+1kxkv8wmQ/igSVL9ZRzXCjAkrSwrOVU5VxlRDp8prJ9KlU3EkDFad00Y+X+VG0PPSWOsJuvwcVmPTC2UIkxguLAlmbmtnTCg546gtf19RlT49z2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEjjU/Ft; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70685ab8fb1so1489325b3a.2;
        Tue, 25 Jun 2024 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719304672; x=1719909472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqe5UuDktWE8cVCx+ZXLizURsrkeHlz4k8KCFjKPz8A=;
        b=nEjjU/FttUqMt6fB9CBAPqHQAUsMbsDPhcB//COadLr7fY2hpagaZcN/feDIcyw2yy
         s/0WAAMYUBO5qcZcb18n/Zaf54G96qJXiqVQoy5go/wM1kmrqwQehBCMMMstSRJFO/VS
         3zgyIgW88TXLijoQZywoBBd0Cmu98jUkjCavQ9pqAZ5aLY46tAmvAUd3ZQ0TYozWrFAW
         s5Mgz+6wiE4iclQVOniWiykaMqBTEVBT5yCnos1sRCdrRNMYnBV2+K13CeKsAkIyM1nz
         l8xx6PwDdyRb0p48DF9inykfZY33tkiYYWkdzzHKYJT4Ho1fYFuKOCZG1irz6A2Ei/1e
         NZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304672; x=1719909472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqe5UuDktWE8cVCx+ZXLizURsrkeHlz4k8KCFjKPz8A=;
        b=fEcD1Wvf7kU5wkz4zj3aQys8s8w+55z0jnWUoXieTXEnOTDL2/0YmFyqTZrrOGLwAm
         URSVPn9fg4NxpT3KeJKB6eaFS64FP/2kkYB85vfot21AG/6E63q7BXYG5pvwNKcsQTRq
         RqXVVRHdYClslGIvRzTtrZWr+sAiLoy+27B/CdvKzpLxm62tvRaBSFNd7lPHUI/IW579
         1NKZ7JOL3PulFivTaXWneeg3TYEd1rre2OftEiczBvj5eTVjNdgpYgkxWnhsC7gIxAt6
         oNUJEPYmJUi5O8k4UyxQyim90bt2cX85XMCYoZkBdpdeZo/S3qn3JwnTS0pwYND9VUqP
         X5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVGkJsIWyoLzEaBiRHAJ1FmADOFcdfhxPUWPDXRClTJmzQ/YSdxiuCQShkaOIhqb7BKqKsKd82xepeNITyQiR5iAvvd2fngzDSXoD9Gyr6FEF7SMJot2xiNY0YPfRHZW2elGX1P1O4c
X-Gm-Message-State: AOJu0YwGyWMVwutBvEU9D1NIWc7LEI1G+R8g/zatGhilfxsr0G/INGCD
	17CdlYNzJv0gurxzKRJBD5H6VrBOooqXAG+q3lM8R3tniFebLC1S
X-Google-Smtp-Source: AGHT+IHxK34+4RmFCf0yNPduRafMt1Gs10g9dDrYbCiVjpbNUZTalur5wjXKnJdnV2n+p+pu+B+Axg==
X-Received: by 2002:a05:6a00:2f0a:b0:706:5b64:f1fb with SMTP id d2e1a72fcca58-706745d43b4mr6433396b3a.17.1719304672349;
        Tue, 25 Jun 2024 01:37:52 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651299ca9sm7551624b3a.155.2024.06.25.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:37:51 -0700 (PDT)
Message-ID: <d0e006c2-4c27-4bf0-aa88-720e42baa66e@gmail.com>
Date: Tue, 25 Jun 2024 16:37:40 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Alexandru Ardelean <aardelean@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-3-b1d65b221811@gmail.com>
 <12457a9b-dd84-4033-bd9a-bd69e2e6cbf2@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <12457a9b-dd84-4033-bd9a-bd69e2e6cbf2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/6/25 13:49, Krzysztof Kozlowski wrote:
> On 25/06/2024 04:15, Yasin Lee wrote:
>> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>>
>> The device has the following entry points:
>>
>> Usual frequency:
>> - sampling_frequency
>>
>> Instant reading of current values for different sensors:
>> - in_proximity0_raw
>> - in_proximity1_raw
>> - in_proximity2_raw
>> - in_proximity3_raw
>> - in_proximity4_raw
>> and associated events in events/
>>
>> Acked-by: Alexandru Ardelean <aardelean@baylibre.com>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Drop fake tags.
>
>> Reported-by： Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/r/202405170824.uhEslLI0-lkp@intel.com/
>> Closes: https://lore.kernel.org/r/202406142001.swm6CU40-lkp@intel.com/
>> Reported-by： kernel test robot <lkp@intel.com>
> Drop fake tags.
>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202406171946.qe83Tde0-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202406081148.j9y5W5Ru-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202405310327.5dCrF4gX-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202405310010.dSPEpCuu-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202405300812.jv99FywV-lkp@intel.com/
> Drop fake bug reports.
>
>
>
> Best regards,
> Krzysztof


Got it. I will drop them all



