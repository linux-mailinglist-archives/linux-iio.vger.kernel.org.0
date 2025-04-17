Return-Path: <linux-iio+bounces-18233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28141A92C63
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 22:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741108E048D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A520299D;
	Thu, 17 Apr 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pkg1uAzM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE735948
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744922931; cv=none; b=K2ipiBLshEalvHpgnMP5K+rr25cOlXn60tRC6qvYmPbUFoIkevC0cMBV/k+jPWiqB2XmOYYig5uEG5rtMPDwQNrGgcKwTv8gits6IUF7cn+m1dfHNuN/3KX6uQbJwSUsuUIcBH1eDdmpEUeh4STNTgjUiJEnlxUA2JSgBe1ie7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744922931; c=relaxed/simple;
	bh=SE6VYeO161Lchp9XqCW7wK4j3SfrihWV7uyQWpBrpwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXSOECSNtRaPSUXUgdBuYhOCK7xxUMsD883icubPCRm+pmWjoKEORIP4a0tqgjzulV4BOr8vOycoW2f6744Fh/fd1juPYpKz/vpxXybBpAR7/jsqtwSl6LkfHTdPrANG9UvLgV34sSd1UAoiKmlwAGeP/aiY4G10zaFP4yMm/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pkg1uAzM; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f9832f798aso731833b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744922928; x=1745527728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkhkFAogJf6rcZdrKyxj+n2pOOqU53PozCIK3xijJrY=;
        b=Pkg1uAzMvJIiRigpxIR5+/iH0jxoJHiCRKnxVlTNrsLTR3l/cnNbSm3dVLv3Jl9GoX
         4rx3/ExsooVw0ep2BgKNVScaeywkg/i0moalZFcFpQf6ZkMYVLnJjn5xKHiPPP0sQBV9
         vtehn65imb0MwkxzVlG86BVhTRhJrDFTwVxS9bZ8T6/rmKcAzVgIP7FcHK8JGWE8J5g+
         bgNbqgh8PHsgO/FKK83srAGoBKvVD+E3G5CbbFtUdJ6MsIB0G37EDlPbgrAhkWUBdWd3
         ZymCn1dneBSYG//dBzeWQekmv7+p+dKFdy8lOWN7Yf/6PkEO9J0eC6w5OZZqV2FUXkrM
         4hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744922928; x=1745527728;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkhkFAogJf6rcZdrKyxj+n2pOOqU53PozCIK3xijJrY=;
        b=SIrJfzQfU2ENe/q54ksu1dt3+fbZ+AAIs5xlJQ/2CuuCD1HT0n9ZWXDokYj1zFjSRS
         nd/2tISTmfhUFMb5RukWw4qKakYogq5gJ9R9+yx2R3Vhup9+/qTug8TrO6eywSo/1XVu
         vk0r14r/q4lqiv9yYHbugYe+5s+Rke4/dHsf/lMEVoXwRcU4tiy+INFGrOFxRcc6xVkq
         Kk8M75F8qdMeE3JSiXHB8wWOpHFA+9wJSjSf78IS1gFkywQiNfjW4tHF4L3OykfTvSqM
         Dk7lEf7/21W51k/H+GfWFAAPpulhmLog83xUiptgdBw7L6JS+qtzt0P0TKGUM9ZFGFJh
         aWEA==
X-Forwarded-Encrypted: i=1; AJvYcCVacNw7TmiAlrXlj9PMV1lmJnao9REkezYj6lS2NVbHq0i+l9dGocvwR/43vdLBqRLSyuwOOsudNas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTCxre4yFoPoTP561hahav6d6OHyIfUdalhqStvRYBP55eS5W
	1OPIfyRwK9KiwAFq8RLx0OHE6D9zmSTZ7hHVoYfFV8BTAZa2S0F4sr+Lq2XvG00=
X-Gm-Gg: ASbGncsugu5qV7iLn6JJtEoVQmWGcit/baZfRagDrRpBLbi+dSGLJuxknsqU+8W6WQp
	0Jdgy3C8cJ6+x6en6Dww5oCqg/Y78/k2zHQHM+70SoDlgu+MiS6hODVo0frHFnFhXRFs4CmbJO4
	7p/8h8O8+1BiSDn8I7BF4E4vR2Lbci+t00uk4B8mN3AQO1cdjmIMEaWk7CRNMB/M6v8gC78bY9z
	twyY10gSD1PHR5WDNrVHlh2eWVL2MjeYDFd8/KNxyLC6GxLO6v53ahyyPq4pCrpQnHc13ojYj/R
	WA8OQoApl8hgs56sYInFaHld90BTgedAM7DKcb2z/S5IKXhsSMRqb+yTWprQrNT3DozW7uNPidd
	pF3ER2K9WB6bGPwBPaA==
X-Google-Smtp-Source: AGHT+IF7ZjPtLD+LrakaPKE8P6Ie7Z9AHBDyOGjvviQeXkjr+Jv27cdNwkf/cTlSFR3UJfutg615hw==
X-Received: by 2002:a05:6808:4a84:b0:401:2e2d:cb54 with SMTP id 5614622812f47-401c0c3f94bmr111311b6e.29.1744922928611;
        Thu, 17 Apr 2025 13:48:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee? ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d52135b8b4sm115918fac.17.2025.04.17.13.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 13:48:47 -0700 (PDT)
Message-ID: <651b1f91-fd5e-4d59-b78b-fdd7f89247e4@baylibre.com>
Date: Thu, 17 Apr 2025 15:48:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] iio: imu: adis16550: align buffers for timestamp
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Andreas Klinger <ak@it-klinger.de>, Petre Rodan
 <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
 <20250417-iio-more-timestamp-alignment-v1-6-eafac1e22318@baylibre.com>
 <aAEzeY_p6a8Pr-zn@smile.fi.intel.com>
 <f4db1a95-106f-4fa4-9318-3ee172e29cdb@baylibre.com>
 <20250417184429.00002403@huawei.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250417184429.00002403@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 12:44 PM, Jonathan Cameron wrote:
> On Thu, 17 Apr 2025 12:07:37 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 4/17/25 11:59 AM, Andy Shevchenko wrote:
>>> On Thu, Apr 17, 2025 at 11:52:38AM -0500, David Lechner wrote:  
>>>> Align the buffers used with iio_push_to_buffers_with_timestamp() to
>>>> ensure the s64 timestamp is aligned to 8 bytes.
>>>>
>>>>  drivers/iio/accel/bmc150-accel.h | 2 +-
>>>>  drivers/iio/imu/adis16550.c      | 2 +-  
>>>
>>> Looks like a stray squash of the two independent commits.  
>>
>> Oops, sure enough.
>>
>>>
>>> ...
>>>   
>>>>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>>>>  	struct mutex mutex;
>>>>  	u8 fifo_mode, watermark;
>>>> -	s16 buffer[8];
>>>> +	s16 buffer[8] __aligned(8);  
>>>
>>> As for the code, would it be possible to convert to actually use a sturcture
>>> rather than an array?  
>>
>> I do personally prefer the struct pattern, but there are very many other drivers
>> using this buffer pattern that I was not tempted to try to start converting them.
> 
> For drivers like this one where there is no room for the timestamp
> to sit earlier for minimal channels I think it is worth that conversion
> if we are touching them anyway. 
> 
> Jonathan
> 
There is actually a lot more wrong in this driver, so will save that for a
separate series.


