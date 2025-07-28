Return-Path: <linux-iio+bounces-22083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F08B134E3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 08:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CF91761BD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 06:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E121FF50;
	Mon, 28 Jul 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUDHRm5Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15782E36E6;
	Mon, 28 Jul 2025 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753684212; cv=none; b=Fwy0rKMZTiiBTRu3f1ue6xc6s7sY3IiJm2YKkTBcCoZA3ChrBsjncGmgbihKHqUFFuyZhu4tu/NB7kbgRnixfqShX6b0YZH6xB4f62fraaM3g9Ugk3aDtxqLv2rsRhSD5Zk4P611/bK6xVkxLSFY8RyEQql8wM03ujnNHJmvJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753684212; c=relaxed/simple;
	bh=PZhix2m4fVFQ5HsQVXTs4d5E58RzN1jb5QILt948gYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lIi4m3+vttihVp5Gb5+usOsW3ozSqPdA9mdppi02P4VePAIYrHEK1uaeMhX2uyQQFAut6LzuQzf/weHeH89coVSSiuBOBqR3/w8/DDXigmWhozWt4HmqzXBiUaNZiF/yUDvAXHmjK0DDU5Gs3Mh7q4lsUk3Kh6+0133e0IjLJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUDHRm5Y; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55628eaec6cso3688359e87.0;
        Sun, 27 Jul 2025 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753684209; x=1754289009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=316U4DOI1oCGsif5IWGCXTFbVQzmX1KKv1+uFfG3g+Y=;
        b=hUDHRm5YYqGW/hAT2Q0q6OhHbhqp/+mso65WojXhQiFb4XswcEldnAJdKhvtwjhuIp
         9SKXshuWai7Dn2rQqa3ix9fdHwz95VCL9HA/iyGxrIF7qAFCkEcc950KlTSCcJPaz1Ed
         osU3z9Lbq64aq+GAKKFumqTs0tDrsaKoUBY4KG2+df9gBPYoBw5a4d6tyo0GDR5uOJOQ
         iCgtFEtsKtaSiajEImdkOSya0Y/QBplsT/po9hetwE+qnJ79JhvIR0kR1GmJcPwvHRTw
         8ptYs5LNicHXUCdj+mfwNg0SFtkT5jZU8viFDuIZd3g6nQ0J5WgTDbQgmVA1unUs2qNy
         g0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753684209; x=1754289009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=316U4DOI1oCGsif5IWGCXTFbVQzmX1KKv1+uFfG3g+Y=;
        b=c3ou6N6FqGy0kDf9XJ3HXGvYA72OqFFB/uD011f8eE3moV7Cb8v1bV/vXimXYqIQ6F
         PH4lf0TnrfyJrgV4WAo7mbljJ2X2l5LvYtJkDMzfyu1AhQxvjpjPOWTZ9Fpm5zsc0BiU
         lepx8V8RhhYajO+3W7zli2swSqhOcOXwIhnYRQia/z/El86VcECQDOXdfYpVvJplbkZD
         /22RykoCdHEN0gege+HqYXu41MoxwmXSM7vgMVU6SvgxkKqR0QnMWvxmIXyyZFAU6Tvp
         r0spXCZz2g8/5pBNp2u76yG9zbG5n6cygjGxb5w0twueZoss+Ay54gmaG1Gv/uUYZFi9
         FnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4S7Su63Hb5eHAbvqoYJVH53B2LaDgXEOtSuYe6VTDEO3Ib9SoHuULdzfdg76wVDSW8UUKkA0XUQLvdp1U@vger.kernel.org, AJvYcCUKhU0mZtLbqXexT1NmpuINiEeZqJn3hVU+IkYS5IwLSvWagBOhLojhKBa+OxHl8eNNUsHYynVzD/Kf@vger.kernel.org, AJvYcCV6z0iJo4izk7AC0xwoEfMtxSW7/bxockZBj6nxxXLghRCZDNB7tFJUK2EBRydK5+7tPJz2uSaNrOeO@vger.kernel.org, AJvYcCVXgLssVKZ54tt6KoJOPi7Ae48wuboTW6+3pePvI/bDVDV47LENAMWAgMkB2TDlmEd2Baj6C+50d/4Vf2FFfT9SaL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGvrssB/5vRAuzS3xCpzRd+U6ykclb4vU0uN5Z+VUFEeY4jhYX
	VFir2vXJKOqr8jxMcyapcFfkFPSLYZsRSaYqvBJY+b6SNqz8IF6UXgzN
X-Gm-Gg: ASbGnctVaWKnIHY4y3ntnDjyxxM3dvyCRErcTNblFITverFoCfr7HkRSAMbAUOn7JA1
	9Oy5XFHLi9KMbnSI7iNYwfR8uwJqJ+9kzV5PbML+u31wNtMY/HhIgZgGHWh8qyiqwcHwmiUf4LC
	+Kv55MKr4rz3sCfuEHvsspsQe8N9hISorWzHWgAPhHgolOxp2I64U3dtlG62Wme4XOzWQ0t06UW
	9qOSncLaAoZmLJjt6v/K1tMPrLKQiFEIwwPawT/uthvkczrfu4EGpeiZs8i7K+DqxWkt43mtvLn
	00W3BmyKX9yFwUNZMC/kZGQfcH5ihl+vwt+rukCxjeu4kKKDdAx5ux5+b9LBg9Uh7OK2SRRBu8R
	vi+aSF0+BTWQNFGP65CdrywlkzJQQC2N02tdKNLvdG4l+
X-Google-Smtp-Source: AGHT+IEM7K5rZYU4BO59YG8z3ImKAWgJLk3LWr8tkHB+uKAbk+/BZbc8cNCzT1IHuQMGlPVOFj+NoQ==
X-Received: by 2002:a05:6512:1323:b0:553:3770:c912 with SMTP id 2adb3069b0e04-55b5f4b9fbamr2207518e87.47.1753684208304;
        Sun, 27 Jul 2025 23:30:08 -0700 (PDT)
Received: from [172.16.183.77] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316d9a5sm1124184e87.21.2025.07.27.23.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 23:30:07 -0700 (PDT)
Message-ID: <3be5c56c-f2cf-4ade-a77c-ace556119f96@gmail.com>
Date: Mon, 28 Jul 2025 09:30:05 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Replace hard-coded GPIO/IRQ
 flag with a define
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stankus <lucas.p.stankus@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Dan Robertson <dan@dlrobertson.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Stefan Popa <stefan.popa@analog.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Alexandru Lazar <alazar@startmail.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, David Heidelberg <david@ixit.cz>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
 <20250724111345.47889-6-krzysztof.kozlowski@linaro.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250724111345.47889-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 14:13, Krzysztof Kozlowski wrote:
> For readability use known defines instead of hard-coding GPIO or
> interrupt flag.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

FWIW:
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

> ---
>   Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml | 2 +-
>   Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> index ef8d51e74c08..592854766583 100644
> --- a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> @@ -63,6 +63,6 @@ examples:
>               vdd-supply = <&adc_vdd>;
>               vref-supply = <&adc_vref>;
>               spi-max-frequency = <1000000>;
> -            shutdown-gpios = <&gpio 26 1>;
> +            shutdown-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
>           };
>       };
> diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml b/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
> index 503285823376..4a8f127de7e3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
> @@ -81,7 +81,7 @@ examples:
>               reg = <0x10>;
>   
>               interrupt-parent = <&gpio1>;
> -            interrupts = <29 8>;
> +            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
>   
>               vdd-supply = <&dummyreg>;
>               iovdd-supply = <&dummyreg>;


