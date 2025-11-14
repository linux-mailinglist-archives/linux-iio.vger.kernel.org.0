Return-Path: <linux-iio+bounces-26226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE55C5E52F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 17:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEBD54FEBB0
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE833469F;
	Fri, 14 Nov 2025 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bvUthont"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD73335069
	for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138044; cv=none; b=RT+cgFowrUFp0T1fu5Djzuew2QIZ0PLiq3EahvIdu62JYm74YkmY1uLYzOpBN0RTVkudEUlQtuDQDzvmOvJDQJpSa9QIK/U1S6c0mqiUthDH/NcoVri5IQReRfbGJ70RgZtd33dX4EFXFa1fuAcS7izHPSANi6exCwpkCY3MgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138044; c=relaxed/simple;
	bh=oxh3YhoYIEaRIxjaDBRpdM9oBRVhQNhueXgTg63TZzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuvvwZGWC1QQS3niSJbW9tNqJ7TzwDtv0xtwUUUnTLLEMWK+yhbiP3z8X2cZwdbz/VJpqyV+PVqJo3mhXNgFv1MRNKMMvXDEH0E6jESbzg+mGbcLHXBQWwF/rkdNmy6Fclmh4Md5AHhmlWJ7g6680A8Agi5i2olEjzqyzmAWKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bvUthont; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45038ffac4fso996672b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763138041; x=1763742841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0zENIizSbsPE8jKfF4DXIWFz//T1Rw3ce5Z4/4op8w=;
        b=bvUthontk/JYSiBLXXA1j7sRVpmrEHfrAzKzpN6lOsUoSUCxLZXH1z94YpnuNiw4Vv
         WYflolEfpgp2cSTBWSs7Lszcd5HKtYowglJEFOlobzeGa6yc7aMuMjuw1M6N2wb/+Ebv
         9IFh+Gj37jpdYIdeJNV1HL/4kIAAztICTwvpdE8LNTwUl22UlIsrYURVDtkjcsH8nmJ/
         NH4wTaKliD92wZe+2p8mHWMcD3mfAd/Rve9DDPLBq1DxEyXI9n0pn+1GbjLIxBc+09sS
         VO4kt/5cAKjTkX9xyOAg+FWImBBQvyP47CJLGIzdP0Us5U4lBKAi8OU+9dQIvxiXIv+g
         703A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763138041; x=1763742841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0zENIizSbsPE8jKfF4DXIWFz//T1Rw3ce5Z4/4op8w=;
        b=uzeN79gBWrRRm6C39P5/baea5NBjehbU4Vfc1vHdohJgz0LbJiuZZImlVvfTjayaWH
         X6A5Hoj9Urfdhl3FsUaU5Wj9fviZjtvVlafhhoqV1D9qwiCG3pYO0PAC7YG0Kv7WCyCj
         TVKF7r0VJf/BgQinMH4RT6WM/aya4Pop1UlvDmDlvAPgZFOGZFaam6NM6MhcdZYuLXfY
         B3i2zkcxYwln9hZhrNG+H2WGplfncjufhfs3fkaovtmJcwjzZmtRMIi2uCci6FGZL0aq
         VqG/Tzr1lxsdEKGj0DLJO5aVBsjj3OFlaKwrbdCc7YaHNG7CQ77EL4LI+sQ5kMxGI5D2
         8+pg==
X-Forwarded-Encrypted: i=1; AJvYcCXzzN1DRkXOte+rCiMhz883oUkywaZJfo0FI7RBarqJW3W3aF1iYowptV2LWos0Xkp4DxxQAdiAcJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYEcX9ijVLolh115k05H0O5saqtRFQ5/gIYSbx0MYSzIFuUuK
	Dv55rWTOapZ1aq6ZhqeC308nJXXwo5BvO7qOs/NB/pTG4hPSMSxYux+LQ9qBlnec1+c=
X-Gm-Gg: ASbGncspCxA1WZwo2+Uo2G7Hfjr0hy1iXzgvKcI3cQhlGZlnIAe7MXqTIrYZLouDAT0
	bLeZTIAxesu61V+Ly2HGxK4cLlgzB+IqFhIgLD33z092Ibqw/P4I7MrXjGXdnGP6FTX6YTc2Q7v
	EEbvof9OgG2CEKZj0fBW2P5moFN/f3qX6sAlI3NC0reRuAwy34PijNAiseb+fxB1Xua+rs6IKY/
	drQ1MM1Wfw9h10saGqiHGf/9HY0agVn51CBdVqxdtWl9sDmNLdDQQJH2KoDhvEFChzlQ1djz4y6
	AgZA6gW+HEN1Nm5kIMgnFK6qngOOJ49hVpbFmHl4AtFjJIU8/sgwxexo8SIvtPU6Bq807ykFqX5
	+0YT+vHLxFAq6mUWngm/db3idnbNKx2MjmUt6hDmhZhdQrKSQO78YTUgn+fZkvUsYsp9NjkH6tS
	HzT1qSZnEkan8XA4oR8xI8Blel+InwQCqoTR4JKnOJBdZgwTQ=
X-Google-Smtp-Source: AGHT+IGmhIqEMavL0YX2nY1Vq2fABZht6YbPouUJM/5kcUFllpX0N/1OqFLI/iyV9QuRieoYVcXbrQ==
X-Received: by 2002:a05:6808:d49:b0:44f:f612:43e9 with SMTP id 5614622812f47-450974b27c5mr1664553b6e.44.1763138040803;
        Fri, 14 Nov 2025 08:34:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8a43:8337:f820:b43? ([2600:8803:e7e4:500:8a43:8337:f820:b43])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65724cfa332sm2157866eaf.7.2025.11.14.08.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 08:34:00 -0800 (PST)
Message-ID: <ce727652-c00b-4779-97ea-0b9e4fc3477d@baylibre.com>
Date: Fri, 14 Nov 2025 10:33:59 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] bindings: iio: adc: Add bindings for TI ADS131M0x
 ADCs
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20251114092000.4058978-1-o.rempel@pengutronix.de>
 <20251114092000.4058978-2-o.rempel@pengutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251114092000.4058978-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 3:19 AM, Oleksij Rempel wrote:
> Add device tree bindings documentation for the Texas Instruments
> ADS131M0x analog-to-digital converters. This family includes the ADS131M02,
> ADS131M03, ADS131M04, ADS131M06, and ADS131M08 variants.
> 
> These variants differ primarily in the number of supported channels
> (2, 3, 4, 6, and 8, respectively), which requires separate compatible
> strings to validate the channel nodes.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> changes v3:
> - Make channel@ regex patterns consistent
> changes v2:
> - Rename file to ti,ads131m02.yaml and update $id.
> - Add supplies (avdd, dvdd, refin), interrupts, reset-gpios, and clock-names.
> - Make avdd-supply, dvdd-supply, and clock-names required.
> - Tighten channel validation logic for each device variant.
> - Simplify channel description and reorder datasheet list.
> - Update commit message to clarify device difference
> ---


...

> +  - if:
> +      # 32-pin devices: M06, M08
> +      # These support both XTAL/CLKIN and optional REFIN.
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,ads131m06
> +            - ti,ads131m08
> +    then:
> +      properties:
> +        clock-names:
> +          description:
> +            Indicates if a crystal oscillator (XTAL) or CMOS signal is connected
> +            (CLKIN).
> +          enum: [xtal, clkin]


Usually, we want all possible properties declared at the top level and then
only limit them by the conditional statements.

This makes it easier to see what all of the possibilities are. At first I
thought clock-names had not been added.


> +        refin-supply:
> +          description: Optional external reference supply (REFIN).

refin-supply should be at the top level as well.

> +      required:
> +        - clock-names
> +

