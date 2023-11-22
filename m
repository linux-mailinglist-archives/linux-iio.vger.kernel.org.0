Return-Path: <linux-iio+bounces-270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FFD7F4F53
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 19:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7661E281385
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2166C5D481;
	Wed, 22 Nov 2023 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOHv2qNJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE674D72
	for <linux-iio@vger.kernel.org>; Wed, 22 Nov 2023 10:21:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fd0059a967so227938966b.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Nov 2023 10:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700677310; x=1701282110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgNxnWCFK7LbDPgvqYM6EDl4TckuHYK/tKTpgqZXlII=;
        b=UOHv2qNJPdZg1dp0eiCTKpmQjMb9AeKf41kxBYDb1cFzSrJk7vNiQV7WVls0KFyMtS
         OoSs9fd5oPZd0ZX1PEl5zfCMoNJlmTVDN2Qk61XdsPovtlYDqaiSdBGWho45jBdyUX5l
         Y6uRA8/vvYnzO6CTLt+/XZc2wc7UDwb5TkVoYasm1I/zBy+6Ale1nm5LkFJEk6AFlezO
         xWpLFydifcF3GbdesMJwz1U4C4eX81QNkYrcaX50dfGjVA+om8WpFc6B4OEFnNoF2okO
         g8mtlUjqfLoP4o4sRflUpM+kBMPE1XTEv6jzOWvREzjWDk7ABXgq+vCl3jSzK5Q7s493
         tB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677310; x=1701282110;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgNxnWCFK7LbDPgvqYM6EDl4TckuHYK/tKTpgqZXlII=;
        b=Phwxria/7Tcp4eGuTwkUJI4FPcvHeZSmmIdNLlpIz9DEQS2zShQU+3hi3OaIUwxRvU
         BkT1KOy3L/H/II424kU4o3A3CDqJFm746wPmYKxYC6FGvPxXPTgSi37oB/9octfUtn+n
         b36KwoxrOdNo35Na9gC0fepJVP89ff9wQheZkVm1sS8lkvetGu0F62aNzOWq4V/uRDh4
         miHmX5SesSLYSytF4Iwy5Fvq+zc+UD/ZEVC9VmHpI8iUaONa5z0Cnj5DE8TOcEXTtEGl
         zvtSqkUYflYy+pl2BnHF7U0V8RaRb3jQl4rU+klMMVKxf28GBy13xI4ybvC/rO6+quw/
         R+sw==
X-Gm-Message-State: AOJu0YyBszz09/KpK2GJOOd0eSjRijIZNqzb8+4oHHXaw6GbMAgsqs96
	MwKbvZ/Ya7xmXcLS0WUiEBH42g==
X-Google-Smtp-Source: AGHT+IHwj4YeS2UkszT9f9ROk9RZwox26AcmC/4pSfte5XWMk3TqreyY/DG9kDsV3Wopnqo7zo61GQ==
X-Received: by 2002:a17:907:7e94:b0:a04:472b:4912 with SMTP id qb20-20020a1709077e9400b00a04472b4912mr292565ejc.25.1700677310342;
        Wed, 22 Nov 2023 10:21:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id j17-20020a1709064b5100b009fe3e9dee25sm57945ejv.61.2023.11.22.10.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 10:21:49 -0800 (PST)
Message-ID: <f66a3dc3-a0a5-457b-a68a-efd6577aa210@linaro.org>
Date: Wed, 22 Nov 2023 19:21:48 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: frequency: add admfm2000
Content-Language: en-US
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20231122105831.182570-1-kimseer.paller@analog.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231122105831.182570-1-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/2023 11:58, Kim Seer Paller wrote:
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311220624.J7Nqg5h1-lkp@intel.com/

Drop these two tags. They are not valid.

> ---
> V2 -> V3: Adjusted indentation to resolve wrong indentation warning. 
>           Changed node name to converter. Updated the descriptions to clarify
>           the properties.


> +title: ADMFM2000 Dual Microwave Down Converter
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description:
> +  Dual microwave down converter module with input RF and LO frequency ranges
> +  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
> +  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
> +  conversion path.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admfm2000
> +
> +  switch1-gpios:
> +    items:
> +      - description:
> +          Setting B15 GPIO to high and B16 GPIO to low will result in channel 1
> +          being in Direct IF mode.
> +      - description:
> +          Setting B15 GPIO to low and B16 GPIO to high will result in channel 1
> +          being in Mixer mode.

This still does not tell which one is B15 and which is B16. I am asking
this for third time.

items:
  - description: B15 GPIO, when high (and B16 low) channel 1 is in
Direct IF mode


Best regards,
Krzysztof


