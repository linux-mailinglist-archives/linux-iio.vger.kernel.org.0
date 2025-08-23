Return-Path: <linux-iio+bounces-23168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544EB32A85
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD0F3AD222
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8322E9ED0;
	Sat, 23 Aug 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jGNB+A2F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC591E7C08
	for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965368; cv=none; b=UG4PWmNnVfKDNHN/EJXyBYln2eT6goiBQfS0C9EY0ROtlRpOBmAV3+YZgV+ErZyqlD+1Ai0KytXV0EX1u7V56RBV2udcZWXYQiQ/vbF+pGfWnUvAiuC/Lns3Gf8KE+f70gqkI2KfPX/d/rSjCyOajy1hmsI+1QgfjRae2XSWin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965368; c=relaxed/simple;
	bh=FUwG/gxyGRQKB+JXXx4gl4iOhP78u/f5e7nmclaCeBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JdqR0NjXJMWzJdbdZbYjkEjx523T0nKjV4hAylxbCW3jIRt/va8DYNEDJaBIJc2ik/B8ZljYyAlB7o7xNRns4ib8zCafls7sl9SZt4KV2DXZ4RnR97mGY/2P9MyawyVcD6VeevtRhQrVC2fqhVVQZhu1dob9mixuLXRt9Y8LykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jGNB+A2F; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cce534a91so1369700fac.0
        for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755965365; x=1756570165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5ldSROTTtv9X2BePkbpO0dlILqeRBO/FfySSS6QlUo=;
        b=jGNB+A2FuEYuDCudvAgrB3t2VSxPLsK17VqiRczwe2ZJMgRNW3ZO6OKRhlTHMUhXXe
         gldsn8a5JNQGeD1FfC0QLm8lttxHBEcpvKPpXBzFEx2uS44/S5pCI8Pl7Iddv6uKANg8
         eHZQECacCWqK9GoDDHGpw1oTCcZy83kkzrlvzjYKIQwDtbSWAqDsMrOXHhskafRE6lVx
         ZKQGCDLJTF7f4Wfp6aM0CfXQQoQT4BXZW6XBSzh/EJdToavrYUzTsWl1QF4X0hE0uNM7
         8bYxgSxgjKUpNIX5OSK/Ll1WPxp9d1a6tUJWF+tvRvjQuhNhKVAa4RzFzevZbzZFnd0R
         tK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755965365; x=1756570165;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5ldSROTTtv9X2BePkbpO0dlILqeRBO/FfySSS6QlUo=;
        b=QuokPe0LjcvqgwiSNli0DD9co9GfoI3tfe9hWXaSADqsxGmSa3RQY+RJEpNrPd3nZo
         UVwB+sUgfS8V9IN7x5mxY3EUKT2TrIvQ5OhISbeALIrOH6jZSI3XD+BR5abiLzdqSzlE
         hk654Hzi/jJcQor33H8xcZLeR8hPOgBDdMWJfRxKh3xsN8zUyYJgOMsJv0ROSBMalims
         GhwpFjEvY7AOhblAwyXlOLvH9bcnSRgCoRXa6SRu1PtCeqLbDAEzq6n97cEiijDatTZE
         op7f1q/o7eg9N8EtMp3AwJ9fuqocBAj5A5WlkP0a9kKWZ04hs6NQAn+RsHGQ9K5/lv1q
         arGA==
X-Gm-Message-State: AOJu0YyHrU/o9sO9xjPP+6hZYjDbWYhMVySc0ga+EyNar8WpN9O3kn0D
	8LZ1ULVEKm6aQ4kVl+5OXRkdTFkvwpX0UfQoKyEFospsi7M9WmSWxp4dK3HcMXds798=
X-Gm-Gg: ASbGncv8pr/sgiBKbvvzdEUV87X83sijoahUZo9Btu/+xKw8SR6fKZqlIg6rsqnvcaq
	KLnhe0kUI8r5QMxG/DHabwZG434kl829dR1b9Zyx64MmkuJBkGLMrYt6lVs1xpezXm0lLaYAr2Q
	V/RUMXbcFd/p5LpPUuzbU/PdUMaY/ZNnFNEJ+o5ZuxECRUNs61oEM4N3d1IMZDUPazoTwrVYG5x
	nQyDX9Q04zzUhIxC1h5EYFYpCksTnK89HPHTEs9a2oRcE36EnzYiRFjU015BlqD59ozUUPRKsNs
	6ziP9FaG4ZgS98k/9NfzxJpaPrpWwI1FMjtjlhuYGjovBj7jqOT3SEsJcSWNprFSSW4uw5y4Txy
	qb+sFO9Uo/wEaqbCgzS9F0bljII0WuNLYLE76Fu616H0FrH6r9eyqXxJuV+Ddi59Fotbo2T/W
X-Google-Smtp-Source: AGHT+IE42Tt8rVMHMtIJU30KzWNte5aFQHwjUAqkCrWOHeQEzzuOgeRcfaGPnVLy2HOMvBY9suiAcQ==
X-Received: by 2002:a05:6808:50a5:b0:437:761b:9621 with SMTP id 5614622812f47-4378537acd5mr3108210b6e.48.1755965365195;
        Sat, 23 Aug 2025 09:09:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437967da01asm388629b6e.12.2025.08.23.09.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:09:24 -0700 (PDT)
Message-ID: <04436186-254c-4e02-8536-5c9fd9c005c4@baylibre.com>
Date: Sat, 23 Aug 2025 11:09:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
From: David Lechner <dlechner@baylibre.com>
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
 <20250822-upstream-changes-v8-2-40bb1739e3e2@watter.com>
 <f7089447-f164-406b-8e59-3bd3e8f94d59@baylibre.com>
Content-Language: en-US
In-Reply-To: <f7089447-f164-406b-8e59-3bd3e8f94d59@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/25 11:06 AM, David Lechner wrote:
> On 8/22/25 8:23 AM, Ben Collins wrote:

...

>> +  - |
>> +    #include <dt-bindings/iio/temperature/thermocouple.h>
> 
> This header isn't used in this example.
> 
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        temperature-sensor@62 {
>> +            compatible = "microchip,mcp9601", "microchip,mcp9600";
>> +            reg = <0x62>;
>> +            interrupt-parent = <&gpio>;
>> +            interrupts = <22 IRQ_TYPE_EDGE_RISING>, <23 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "open-circuit", "short-circuit";
>> +            vdd-supply = <&vdd>;
>> +            microchip,vsense;
>> +        };
>> +    };
>>
> 
> With that fixed:
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

BTW, sometimes Jonathan is nice and fixes a one-line change like this
when applying patches, so don't rush off and send a v9 just quite yet
unless there are other bigger changes that need to be done anyway.

