Return-Path: <linux-iio+bounces-24921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34645BCE255
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 19:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6CE3AE6F5
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02977223702;
	Fri, 10 Oct 2025 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ssqrLHYn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB1221578
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118575; cv=none; b=bw2pMaAiHzkWo6Nuw5wKdgLC36eUSQM6OqQVEPH9toZxwUuC2QbEBzAgNNQVzvx9NAVftA7FdFKOaYyj+Ttxkc5EEx7w0kVoCS98ixCoqUJJQRQXDL1BKzZMqwD4hRp82sUSz/RtQFw5lIokMxyT4Q9H2xYYr7hmS3o/mS3WvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118575; c=relaxed/simple;
	bh=SydbU5kjGr/3xovWC/nOqIpKErTuWjsdiYfkq7oCez4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWgI9EBQrgb34Gg/fNA+k8iEHvw0rIwk5LRxGJgvbFTTiksbS0T4jaikCytJwxBCv3KFJIuPAofruE9G+m+xPNIyx5MpyUQClV+Qs6/QtdLZhAHUAXg+CuHFbAK+HHZ0qMjsnPD0WAYVr7EcGrlCnpmt8i94wUWXZ1wZIyz+qhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ssqrLHYn; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7bd8909c682so1497613a34.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760118573; x=1760723373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMaVmGxlRalQkaTOQI033Tgz8Btw2Xvfuv/0peF4wpw=;
        b=ssqrLHYnuuvLGSpgWS86+c6ov4l3etjXuVOpyUd8Siq5HHJH+dx3t6uN2GWIoB71VB
         esh+r7GNzRl76ObTVGR4ZO0jBzb+dYTt2Y42d0gSKVQ7owCRWlYucFLxgSR1JT7fSWKI
         fAv7/OPwL478PVke5I9k0vHyMRcR0ErZkPT8LSk8uXKqXGdUiZtyY/dHfjw2RHv6be9Q
         CHhiQJqj7PBsdJxXUNBTVli/trPM4ErA1vOHPNBlOlRRqQiHVYGOTPgluieByzDR814L
         lp+LudV9LqfESbP/eCK4OOYe/FPD2FqGptaSkp2jRlArJFbAnx+aC61D6HYJoygYE3Mh
         8WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118573; x=1760723373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMaVmGxlRalQkaTOQI033Tgz8Btw2Xvfuv/0peF4wpw=;
        b=RtiUbNMdTKUk9Gfuj+TBTMWjnVvCCqQ6TIykAcTKaOcmac8a9Y2TeXhuCE//KPYjic
         l91rh3YfgwLIMv/CHzIFCu8Yryp0KDa2fVmG+mGrfJUgY6/4meFY7PNvW5WMGwOE5eJK
         7hIeV6BU8rrVkKxDDm+nWOiUUQUvPBOtIyJrcDHu/CSNgqYKX4lyDRZKJalnERWrmM/f
         6Qf5kmbw/xZm7zZSv/afEnKdCgnaxF7ur5UPc719cXqA8Mbv9tgK+hbTuo1ZTOQ/XNIm
         4GpoLYf8Tla2fEDnisHcMIqpId20Gmcd5cUjcX+Y0BzoGcuQb2CDdopOHPz7uW3jFzOn
         YilA==
X-Forwarded-Encrypted: i=1; AJvYcCUMFfb+TNDCY75cZRm5Z2OgavmgXZJGimhmv3mizamOoiqpNhRe9g7KLbk4k7Q9zdjSKKM29v66Mng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDAZZbD8lmrfojcWJ9ITbICSyWqoLQEoYcf1r3prTFw8fbaCL
	uSr9DP+73vWIBqesZ1HxaJayaF7m671DSkn4603i0dj40Jnivvd/igZwsmrTFrRyLY4=
X-Gm-Gg: ASbGncvDR5I1keQx/iXqslo3RcKyRnIjamtENkGXknhmdH1W2sRyKQLsxDCcvZeYAP2
	mwrksT5mOJIJ3o7gBsp+1IaSQTxvAUDkSSF/o0Hvq7wqOTHsKVZSinQUYI/k/C16Ubdkt5Mrqsq
	INeWng+4grbPalH9iOjwtHY9HHA+ZZHgp6nq4E6xGywVS6OokiTNj+a7YnejIDvbw07NZ1qxMS2
	LxfBZWPML4MfdbfIOtWUi3+mimwCyCfd8Am3cQ6C6uH80N4qbhWUOkhV9R37QB/s2+FZC24HGj6
	8Q9oZu4kgDLMkjEUOkkq3fy8yipuklkr4tlkdiRoiU+9SnCl1y4vZz2lKYJeZtkkmWaF4621MUM
	34TVfqHL+ABfwWhS7ZKut/wx0nzxILFKchLxilb88jhaUUS8I9Ue/wu+vTZek7JJSN2vasZli5h
	ROsbmYQX84SWYFUO4=
X-Google-Smtp-Source: AGHT+IGFvMx8K8r1w2LJGI0aj1BdaxgMV07DhEGKjg2wLJeOFKBXNf333S18rFWDt7E0konUyv4QMg==
X-Received: by 2002:a05:6830:620d:b0:79e:f086:3aca with SMTP id 46e09a7af769-7c0df62378fmr7546589a34.10.1760118572753;
        Fri, 10 Oct 2025 10:49:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f9067887sm1027295a34.9.2025.10.10.10.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:49:32 -0700 (PDT)
Message-ID: <fce1c905-1c64-47b5-91b1-0017809ec12c@baylibre.com>
Date: Fri, 10 Oct 2025 12:49:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width
 property
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251008031737.7321-2-raskar.shree97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 10:17 PM, Shrikant Raskar wrote:
> The appropriate LED pulse width for the MAX30100 depends on
> board-specific optical and mechanical design (lens, enclosure,
> LED-to-sensor distance) and the trade-off between measurement
> resolution and power consumption. Encoding it in Device Tree
> documents these platform choices and ensures consistent behavior.
> 
> Tested on: Raspberry Pi 3B + MAX30100 breakout board.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> 
> Changes since v1:
> Add unit suffix.
> Drop redundant description.
> 
> Link to v1:
> https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.com/
> ---
>  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> index 967778fb0ce8..5c651a0151cc 100644
> --- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> @@ -27,6 +27,11 @@ properties:
>        LED current whilst the engine is running. First indexed value is
>        the configuration for the RED LED, and second value is for the IR LED.
>  
> +  maxim,pulse-width-us:
> +    maxItems: 1
> +    description: Pulse width in microseconds

Would be nice to add to the description which pulse width this is referring to.

> +    enum: [200, 400, 800, 1600]

Properties with standard unit suffixes are u32 arrays, so I think this
would fix the error and also make maxItems not necessary.

       items:
         - enum: [200, 400, 800, 1600]

And we want to know what the default is if this property is omitted.

        default: 1600

> +
>  additionalProperties: false
>  
>  required:
> @@ -44,6 +49,7 @@ examples:
>              compatible = "maxim,max30100";
>              reg = <0x57>;
>              maxim,led-current-microamp = <24000 50000>;
> +            maxim,pulse-width-us = <1600>;
>              interrupt-parent = <&gpio1>;
>              interrupts = <16 2>;
>          };


