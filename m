Return-Path: <linux-iio+bounces-12129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16C9C40CB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51504282BDB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649951A2645;
	Mon, 11 Nov 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AFHYuwSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1271A0737
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334911; cv=none; b=mEC8DnZoDr0LDOS8UyiVuxSwdllwUjYp2c+YZ14jU7VcXsTvNozk4R4MJPrzsiTLpgljFnYwPhsDVBcJF6jU70E+93XgkdihiOP6tTQVBFR1a5s3B+V5lRKhVnM0NKuwTJPMkSxZxe9j+zUU3RumxPTStFt2iNSpDwyqfsf6g3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334911; c=relaxed/simple;
	bh=sXs4BHvFeo0Y3ulkHWsHHmqqUYuxQyte2TAFTyzb7v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWOs3WgsnoJEEsNPt9qkmnoZiERCqZnCIawbUK2bkuoYOiilXdMHNph21Wz7BFIfswR8s3Q/pa8ks60KqgySb/vLLlCfIpYmCelX9GZU/0B5Ho7YmMwKLxMTDVKhorsGADv8N3M9rBNObkiUsFoEKphu4wXGl5SFxaPWRwUBFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AFHYuwSH; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7181a8af549so2832284a34.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731334908; x=1731939708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HctBMgT84vBY4hzxiEZh7IsHrKp0XhtLMHme3Byg9B4=;
        b=AFHYuwSHkLOjleYo12O6HpOQ1zq8ctfn8d3wHhdhlREz/FNOVTNRkIAPh8QUP1lTBc
         IvNTjwsr1bC4N3QamFxcRMzMPpblwO3rQgVSjcYYUyhY5vLylWbioSBAcAPFVtWeMgXG
         Ro+gyZ0iOAdMVQbdyhU7WG9bStj4Qlj/jBqdBzqcwzHBwLWF1Foiy1Qiyzl0fZMiUimD
         7kNSh/o3EdjD11iKKTi7S2dO8irH+dW/X9yWnGHpJLRfBlQmEptnytoqac9JM6fOwt6D
         pkT6dO0JideppueNRZ2fdd1bMLKjZIbeG9LcrmzxqGRxDWBeET9NIwe4EQ7+NkVFlXzT
         qRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731334908; x=1731939708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HctBMgT84vBY4hzxiEZh7IsHrKp0XhtLMHme3Byg9B4=;
        b=b+UtGT8rujzWqsx8xir4h1+UAVWy7j9+FapZD0mtbot6r0AfH7naP0f/n+8WDmBx2H
         EYEsMiRb3h2AGuNB6oSCANhMfxvJcRB0sDKkwf2pmN22SuDGmaLPQUx3HlGZ5k3axiHT
         Ymg+U7AP/1GQ+B9x4qTWXBvxCO7hBtMk4b955FgEVgP2iGSvnjQYMmW6lcMF/u1HyxSM
         HWGbbL/bmiyJWo+MXmyQ02ltU28dqSInwl3T9Dk536WwrRoHBf1Qosct6HUQOovec8uQ
         vXZrwZNGfoef7Zt7TSeTaVWtQtITLdYP/tDa084Ocgu8zOyo2XEsv+koS7NQHybYU62U
         9FIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Uy4tLO3MLR+GIUwFlkXXQbgifqi7nFScQUkr9wRl3R/N3tEVnEwxaGfKrQOr643//3anHCNn/O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQsEe0YHaIN6cgpcrPV3QRduK8cKbs4383QF7lnqmA5Gm82dr
	REDX1OnJp3wqTPnXPOuXmyroi9rSBsTd4D31DpIvROZfiFsxsy2F5SACF1eRCXGcYiD+j1Kxfnp
	G
X-Google-Smtp-Source: AGHT+IGVzdut7knNu4orGH/0e/98hy5mbsEg8EUQyO8+g5vXJP3AchBYsjwGGywSvzlxSF70zNgyPw==
X-Received: by 2002:a05:6830:2116:b0:718:e44:6da9 with SMTP id 46e09a7af769-71a1c1d2fa3mr11254324a34.11.1731334908011;
        Mon, 11 Nov 2024 06:21:48 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a107ebd43sm2266321a34.6.2024.11.11.06.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:21:47 -0800 (PST)
Message-ID: <8636a00f-81e6-4439-9778-abce6e0c931b@baylibre.com>
Date: Mon, 11 Nov 2024 08:21:45 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than the
 hardware is capable of
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
 <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
 <c94271b1-924b-4de6-b3bb-77e16265bb0d@baylibre.com>
 <c2mdg4pn5rgjdlwet2gmgqvmym36ttlyg5ag2u62a3qtkdwqce@p45gyz5ghgel>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c2mdg4pn5rgjdlwet2gmgqvmym36ttlyg5ag2u62a3qtkdwqce@p45gyz5ghgel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/24 6:08 AM, Uwe Kleine-König wrote:
> [dropped Mircea Caprioru from Cc: as their address bounces.]
> 
> Hello David,
> 
> On Fri, Nov 08, 2024 at 12:52:35PM -0600, David Lechner wrote:
>> On 11/8/24 12:18 PM, Uwe Kleine-König wrote:
>>> The ad7124-4 and ad7124-8 both support 16 channel registers. Don't
>>> accept more (logical) channels from dt than that.
>>
>> Why should the devicetree be limited by the number of channel
>> registers? Channel registers are a resource than can be
>> dynamically assigned, so it doesn't seem like the devicetree
>> should be specifying that assignment.
> 
> Note the device tree isn't limited as I didn't adapt the binding. It's
> just that the driver doesn't bind if too many channels are specified.
> And while your statement about the channels being a dynamic resource is
> right, currently the driver doesn't cope and allocates resources
> statically, and happily assumes there is a CHANNEL_16 register if the
> device tree specifies 17 (or more) logical channels and writes to
> CONFIG_0 then which very likely results in strange effects.
> 
> So as long as the driver doesn't implement this (possible) dynamic
> mapping to the CHANNEL registers, it's IMHO right to refuse to bind (or
> alternatively only use the 16 first logical channels).
> 
> Best regards
> Uwe

Understood. It would be nice to implement such dynamic allocation
in the future but as a fix to backport to stable kernels, this makes
sense.

