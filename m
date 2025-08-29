Return-Path: <linux-iio+bounces-23384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3E8B3C000
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B84517692F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D744832A3CE;
	Fri, 29 Aug 2025 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bnJl5F14"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50C319878
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482757; cv=none; b=SknOQR75TpIxlmPoH8IPGgEQLiR29B4B3+SNBPTRfZ9BVIMlIzb1q1QcZLJM7aaXrut8seIZWCbHEnWYBRt5YAzNOjOGL/vOMMnsSQWFmKCyXENz9fGCaM6Z4Td0K3h6jRCCxpZG9SIEnsVmzo2YBpuNc2PPeWOPIxkmgAYVSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482757; c=relaxed/simple;
	bh=5Ym/jwTYuBac6qN/bi6EC8idQbMmFWSlyiT3FprCvsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnHWqrgctQlYIJGCGNKv8sygyrmrHoC2ozap36ogUMgjxPwtRqZ+L9F+1McrvdQtRxRO1Rtq7B2Et1e11c0Ym9+eBADz0Pq5CbPhgWgqtzL5paL2zKZ/LwHwWKei4f62HtA+JLHFeSmrc7QAmykOLorQgo/mm6tKKeMBpypOjKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bnJl5F14; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30cceb07f45so2192116fac.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756482755; x=1757087555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+23BJPCKtGorADDC890VMTVjWSuA//k7zazsu5ZdqXU=;
        b=bnJl5F14HpVRdVjNzcgeaOWTEPn3joHTxD4OBFMS+NtSkqpX0mNowq2qQ23e+D6PKF
         xK4BU4OOzUbIYf+sXLQ14p3/9rIvd7E7Nv65CT/yJ3+3MAWbwRyf5cbUJdO1SeCS5wOq
         y9jcafCdq7kpcOCXVsfFXsNocNcTNMDA6OalA/pC2QfSmvJWCV3jaW27wSqZvi/JmPib
         0Z7TknDHnkWjLLukCWIhavuLBz4f6HYPk7n+UdLC00wFmgFMiRqQWnGm7I3DZ+8VAkVX
         1W8hCKWtGGnzPOi7IoEZfZGIStiRIE/oRyHXjjXyN9XCGdNKXKl7ZiXg/dKBdBzd0+L4
         UpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482755; x=1757087555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+23BJPCKtGorADDC890VMTVjWSuA//k7zazsu5ZdqXU=;
        b=dwpeOdkKVa6jMW6ZLh5CamSPLag47NJK7yeMfqwOJluHCnsqdBoSG4aFbA3Nw64xY0
         VyN0rIM1YLDybmCofKBPqdbvzh/ok58V3EvmSf+QLqPl4uPSiedl/s2DnvATsm1JWD3t
         x/z2+tMqvmpWYV26MzBbxSsqvpWSA/F9gf82brsLkNIAGSDZS8PNFXHGUCbyxqKteMFw
         Akn1b6PH7Ttr5UdswU8eLhGj7+qbPllJ6LiiMVESkzMMm4H/BEy/FYNRPMPzbWErsWBf
         N2E8hlwnq3dcxqUcAXp3wZL448yYNLyM6Ze63jYiT6LXa1yo3/G4tqncew0QaovfZ8Pf
         l3ig==
X-Forwarded-Encrypted: i=1; AJvYcCUKeTqD1pZc/+5lypCiDDS0VTUmxoSoNsmwTf71yeY7qLVLIsoc8FPfxA6gysTQh7Y8az2yKeJP2Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRvQiMZmvb7vuXCkIowMuG4TssafwaDD35L4/sQiTSn8TcYFMW
	KKsilb8K+jXWLFE64yjn6uXtVFy3SQUm5OVyzfiVbPAfbJh1xjhyPddknWXnWp6Y5fI=
X-Gm-Gg: ASbGncsB36BT9M4CqFmPU0RKvt5YNmPL4TetjuAt+WkmZYIOAEdUUjamyig+c7SBzBc
	tr6ZIfJXXynWTuhSJpZKNHxV25qf4TF8pRkX0LUKOB+QPyVw09BlOCfF81RZ6lmUpKMK3XUkqoU
	TmOLgizvymbeaVb4P2PT7+U+Bnk8k0d5QnwEiPw95MgDyg/gpMqolEoDN79Ndsh8Ztv74HkItHm
	w3GWSAH/Fj6vzT7vZu+R41+tTDlYNHLG/sNuOSPh3mOm5XT3HFdBEXSa2IxV+qIToR9+DB9ne9O
	1s+T8pcX355QD6gKgfYqFxq3IM4gZzkGIZOcpRIAMywUUAnxxZsnTR0vmZogtUTVDcTKWyiqhGk
	z6C9JkeS9qHMGk8exQ9EgMo1AcF0DkEvkuOO+Mk5EWTZfDvTXP5peOWlen6SLnbySn3uTiUQNBI
	b/JJO0y7IFlFR8Ul0HnVj9
X-Google-Smtp-Source: AGHT+IEXWYEKh1DA738p/y0oOalJucxmoKHVU9lI6MvOI7wGYxwoLUOBIB8PEz52I2MRTw1eKDB1JA==
X-Received: by 2002:a05:6808:81d3:b0:437:aedd:f87 with SMTP id 5614622812f47-437aedd13admr7644840b6e.41.1756482754716;
        Fri, 29 Aug 2025 08:52:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437f41765fasm21636b6e.8.2025.08.29.08.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 08:52:33 -0700 (PDT)
Message-ID: <960b23ff-827f-4ac6-a951-c61a0fec0c11@baylibre.com>
Date: Fri, 29 Aug 2025 10:52:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>,
 David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
 <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com>
 <2250556.Mh6RI2rZIc@radijator>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2250556.Mh6RI2rZIc@radijator>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/25 10:20 AM, Duje Mihanović wrote:
> On Friday, 29 August 2025 01:40:56 Central European Summer Time David Lechner wrote:

...

>>> +		*val = raw;
>>> +		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
>>> +		ret = IIO_VAL_INT;
>>> +		break;
>>> +	case IIO_CHAN_INFO_PROCESSED: {
>>
>> Unusual to have both raw and processed. What is the motivation?
> 
> I was following what ab8500-gpadc does, no particular motivation.
> Considering the above, to me it makes the most sense to limit it to
> processed.
> 

In IIO, we generally prefer do the least amount of processing on
the value from the hardware, so IIO_CHAN_INFO_RAW is mostly used
and processed is only used in cases where there isn't linear scaling
or some other unusually thing going on.

So in this driver, processed probably makes sense for the resistance
channels since we have to do some calculation anyway, but for the
voltage channels, raw would be preferred.

