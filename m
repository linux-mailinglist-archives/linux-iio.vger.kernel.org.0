Return-Path: <linux-iio+bounces-18900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF4AA4E5D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9614D5A5103
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F87DA93;
	Wed, 30 Apr 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mcdb7T1c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA4145A03
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022893; cv=none; b=UYRYrb9uvGrCxeltk1sCyoinWmjhiQZDOakvfQeEZc0NPZJNDK+0ZmUK0ZsY/sbgnhabmp8SrPTKUqcvNmIAobyDBVGnC3+Z2Js2Efi6a9cxEaYXSHrqrUewi+fTQiJEPCFKxkkVtjQSDfMS/mhjXpcPx6BWr7pTh2HNOIHvK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022893; c=relaxed/simple;
	bh=sQ3uGnHXH5pOVC81pZdY1hVXCJqW8kE2I+Llf8pVa9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5fjpCwtm/CH+y9IHPnN/DVgt0UTcpnXikWb7jkgliAuNgmuzk0TU2dKAb40kEvWAeJUxW01J1OHmyORElQNQ02toZvwnxmhjDjx8kPHdFLDpYiUMMRZtvS6mL0Ohos7YFENLN1d2fVNPsmyptJy7aRfV8X0YN7X0xGvJH4Cf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mcdb7T1c; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60638c07cabso4122751eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746022890; x=1746627690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1J21N20NQgiRAPGKjWxJGQE1CtsIaoc0bg+24VnTew=;
        b=Mcdb7T1cWn1syaEhX00J6XyY1jUP/9i2FcK2VsRDyh/LmWHlBEh66jQuRTcCIWbL9D
         eR0ZUgrweVHwnXPDrXOCGpnQfrufRqhx4N8fdOWHKFoz80qQkj22m7+YNVlYKG2nlf5p
         WyRAszw6eBhW7iHaNLbwbunl2fRBs+hB+lEV0ytBZB95ZUEV3ukAyHgGL5rKWwAuVqrj
         2zC+YHC9HSJwKqvjkKUN/izO+F9x8q0SUe3f8Mflhfrk/igMlVilOG7mo9vOy/fEHnGA
         t9FXYKDM2x8UNdCpD0iHglhn1v05Q1ea3C9KxSEUHBfXsFcyuRW2vZdbsopGqzHeIqCP
         fSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746022890; x=1746627690;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1J21N20NQgiRAPGKjWxJGQE1CtsIaoc0bg+24VnTew=;
        b=W2zeZv2Amet09pAxIMF9fV4ylqeCXFJOSjD5Dwmx6ArjMX+lk5GyJg3NF5A45P5eRy
         hhXjyH1GgG644NBBvQtgx2UthjJ4W7pzRTyhyQoPZMSmkmiIQ/ZgUTaj7UBxgTNZGTA1
         vFG2jgXDy4A8BUWbGSPtRhTOnrGMtH0Exe3icIK+21RfBIisGkm8pEvq9/iF76x54Qx9
         Pht/ZDoRMuyilZ3lrhiHTlhg+RXdY9msII4x5CHk3BOv0y2sdz0EGSndFfokKF/snFuH
         eViGpstqScHnM934zZ1ErK4QivUjR85SrrRsttN7G7j1sM93Ww2k+1ut8XYeA8tpE/Ja
         2/GA==
X-Gm-Message-State: AOJu0YzUDiV9wgoloMu0+jpiymATFmlw5/8y9NheaYVel/HxAPdiWcIE
	3Tl2oZ2yL1e9dLNgZm4Qq4WzvD+HCUwTyiSagxJxPLgzloWoR7uRxL+3in9NxY6i4AehG09q+Ob
	W
X-Gm-Gg: ASbGncuJz0lURRy5cadDHRFqAkz0Vzg+VagIgQEq177YoiCQB8et++Dxjn7e8zo/y9I
	5GFYnYwgLaQwQLa0Z6eMhwiyGaB09EzHh8Re2z5C+/AKVnRENdGZHzlq3UJaBN/jq82PcaKkQOI
	lXjaqG5/Qv017HeY8e9MgrZQoJvt6ayyfo/qyi+RcEJJ99c16Jeq4OWS4YNfQ7zXwiRE0ujDTAI
	uwgWJXf0pfx+PAZVr4jhQNg8f4hnaS0JDbqDft9lrJ3jQcu0QIWWpH6kOjmssGJqsrIpCDYuEI9
	d6l2ubABRJWsbeOZX7APCZo73Fp4xxTigyQkq1Qr6Ge0cLs5Hldb+GTRVSCuTsU1bvPVwL2djrU
	yurxZYeWFN0rnSGlhgb3QQb0AwA==
X-Google-Smtp-Source: AGHT+IHWCsLcDIxL6ytR5QTqeptmdFdVVO+xqRDcmlgk7+/1KWk02aStJmqcNR/mTszyOY6C7kGxXw==
X-Received: by 2002:a05:6820:8c9:b0:606:85ad:881 with SMTP id 006d021491bc7-607d40e2902mr1899866eaf.0.1746022890085;
        Wed, 30 Apr 2025 07:21:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607d8dbd96fsm232384eaf.35.2025.04.30.07.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 07:21:29 -0700 (PDT)
Message-ID: <070b269c-c536-49c5-a11d-7e23653613f9@baylibre.com>
Date: Wed, 30 Apr 2025 09:21:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Documentation: ABI: IIO: add calibphase_delay
 documentation
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-1-eb4d4821b172@baylibre.com>
 <4645ae3e0c3bb1ada9d4cadce77b64fe5e651596.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <4645ae3e0c3bb1ada9d4cadce77b64fe5e651596.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/30/25 12:40 AM, Nuno Sá wrote:
> On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Add new IIO calibphase_delay documentation.
>>
>> The delay suffix is added to specify that the phase, generally in
>> radiants, is for this case (needed from ad7606) in nanoseconds.
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
>> b/Documentation/ABI/testing/sysfs-bus-iio
>> index
>> 33c09c4ac60a4feec82308461643134f5ba84b66..f233190d48a34882b7fed2d961141cc6bec3ddb2
>> 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -559,6 +559,26 @@ Description:
>>  		- a small discrete set of values like "0 2 4 6 8"
>>  		- a range specified as "[min step max]"
>>  
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibphase_delay
> 
> Not sure if I'm too convinced on the _delay suffix
> 
Phase is measured in radians, not seconds, so it seems wrong to use it here.

https://en.wikipedia.org/wiki/Phase_(waves)

And the delay here is with respect to individual samples in a simultaneous
conversion without regard for a sampling frequency, so I don't see how we could
convert the time to radians in any meaningful way.


