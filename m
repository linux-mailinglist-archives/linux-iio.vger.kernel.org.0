Return-Path: <linux-iio+bounces-14467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F3A15E3E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9313A5DE4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4492F19FA8D;
	Sat, 18 Jan 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yLGe/uX/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319319ADB0
	for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220158; cv=none; b=RB+SJFh7sAYhPKGxKMhn+rCaxIr3r0s6cmp5Zp83uVsT5crMYVtBmwgJukN4opz1RgFhTrVYEMTcRrLQzk4mvBlS1+dnbrMBV8KJw7Qb9KShAd1giuU5Ib0t9YKSWEJ6W9Xxt7nOIGWxJm69LseFohhGskidCno5czs/zwdaKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220158; c=relaxed/simple;
	bh=kZrCpn6iY8XtGJTKSSIuBQiF03IUSPNKK/CSIsfxi+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud9DGdXRnN2TbfhyqR0D+Q8qZcOKEBiijurRpss+QIXeiFgJRMGt0DOoVgDF3qsYEdZVlam9MZgwzukZvBw6QXToa28djypyrztq6453YpPSVp8O2M7/YyndKQTln2VgYTms/9Xj2s9FEPo+kb1BeEEsPNB9aJG1xh9JWRorcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yLGe/uX/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e3284f963so1788186a34.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 09:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737220155; x=1737824955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBzJX3Q/fcfCDTYZ+q6Yetl/p7poSDSwPoWKQfNelcU=;
        b=yLGe/uX/ABgCFPU8DAbUvToy2Y/qgHGH6VB5pk+eOarvVH+8DbYV2fpDtq8qisqATF
         XUpKoVnjjsg/fKARVzO11PcvM56uxoJ7si2zTqlXCsebG2qBQam4HDmh1AvC/YosneZa
         Vw7g/PE+uhn8KTpeWQPHM+ZnMi3fyjPuM1wCDHShUJOuXBVvhBO9ZnqfabuqYsOGcfvs
         daC4y0BhVew7F3eAhDqRyBpFAlW3zd8n37jaCY8Q1XYBgVUkIuLFR1HdB/Ik4DvH6gbd
         +blyP0mVJrP18VIIVfRoYP2sTwxLOqojhzpkL8udL3tPa6Z0Y/UVgllHbHZFxh7SwTsR
         M/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737220155; x=1737824955;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBzJX3Q/fcfCDTYZ+q6Yetl/p7poSDSwPoWKQfNelcU=;
        b=tE5GvrN1juU/2Gep0anVc6MvHf09uQO1l68X8lkey449V9ChkURUy7MUWac9cKKMwY
         ZnF2mbfZTv3lgYSWgMUIgf7QQPhne3lBdZkfhFiwF+p7EwGBzfHSwHdOHTBKgZsPvB3v
         hQNz4iab3JnV9Ah9Ru5jj97LIutjNtZUizdTJ9+kfyHuXWB2llPttnWsQYKkY1DfKpXl
         IxRcDQh3urIA9c6dPfl9qctXMGoD8OrF/zZibu8ahHkQE+2WSY5xmyUr2XsutMnaUoxL
         jWlPjQAv2UqObPvVHCfit2it4ypnrGAtjukffC6ficEM17Km38nAggZh1y3/ty0HK2gT
         ZiYA==
X-Forwarded-Encrypted: i=1; AJvYcCXYPmcZU4dDYrVKlLzbFu4Jn9DfhXsOK9QiwjeZomvOpjE5LjNXV5waJz36yj2GXD0kHhcvR9Y8JWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+4gN5dNzB+oI2dqhyNdV/kSCUMi/a1rC2tP80rakgjEIOetb
	N6uZKR6FtHlLzPNq5/2ANvtB6huQHdYXO9rFozGvVfc0QZXuwCt0byMXJ7w3RZB6oY9oj41OtW7
	Z
X-Gm-Gg: ASbGncuXlN1SJybuwSQeHVwjnq6ERNWnNBTNjkgQXiGYh+0jIa+VOvAdjFLJjQ497fX
	Uhm9MRHQVaqeCK2zokKtd3ElIMM6Bl6Pn2pRRtvSJLSQ4BVwz33b2YcsCRYvtL8llIWVsdP5wgu
	DTnmVM5zjy8FoMeGXDbLBHuexQBW/gmu0caa4zQAgoBSPLZ3Kfspdu2BDmNO54BRGHxqnsTxp/p
	1AYm+Fr00VYF2eeLOEniuy971C3KlKeLqQI4v2lchapTrOhzeNBVGpYWhdSAyw22KeVz4AM0wvT
	IOWvQdUFTHGGy5NQda9Uo8tgk7TL30M=
X-Google-Smtp-Source: AGHT+IGodFluwpk4HXpxuTQ4CaYwnD6yRgyO51ig2CiRhLaGAjJBxBcCjfP1Uw9hFIL9zJCC5XXkUA==
X-Received: by 2002:a05:6871:8112:b0:29e:69d9:8847 with SMTP id 586e51a60fabf-2b1c05b3854mr3348215fac.0.1737220155396;
        Sat, 18 Jan 2025 09:09:15 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b903c5f0sm1818089fac.49.2025.01.18.09.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 09:09:14 -0800 (PST)
Message-ID: <134bd7b9-f659-4010-9c78-48eee1dc901a@baylibre.com>
Date: Sat, 18 Jan 2025 11:09:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
 <20250117130702.22588-9-antoniu.miclaus@analog.com>
 <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
 <20250118165751.334fe37b@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250118165751.334fe37b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/25 10:57 AM, Jonathan Cameron wrote:
> On Fri, 17 Jan 2025 15:45:35 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 1/17/25 7:07 AM, Antoniu Miclaus wrote:

...

>>> +		if (fwnode_property_present(child, "diff-channels")) {
>>> +			*channels = ad4851_chan_diff;
>>> +			channels->scan_index = index++;
>>> +			channels->channel = reg;
>>> +			channels->channel2 = reg;  
>>
>> Typically we don't set channel == channel2 for differential channels.
> So i guess this is tripping up on these being dedicated pairs labelled
> +IN1,-IN1 on the datasheet.  The binding documents those as matching
> the diff-channels - hence both channels and reg are the same.
> So maybe best bet is to enforce that in the driver by checking it is
> true.

Are you saying that in_voltage0-voltage0_raw in userspace is OK?

> 
> It is a slightly weird description but only alternative would be to
> invent some more channel numbers for the negative sides which is
> less than ideal.  We could go that way though.
> 
> Some comments alongside a sanity check is probably the best way to
> handle this and no surprise us in the future.
> 

