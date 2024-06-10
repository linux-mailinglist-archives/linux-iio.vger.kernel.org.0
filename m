Return-Path: <linux-iio+bounces-6166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C69024C7
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199261F23791
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98613136E01;
	Mon, 10 Jun 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZN6VBXg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C52134402
	for <linux-iio@vger.kernel.org>; Mon, 10 Jun 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031507; cv=none; b=os3hhCINAteXjsbbuFfvaDcAMkCiKJLjDlcBXXD3fzwgNyWs7HSAvFAlr5Ksbde6cRvy851kMUg4oNScUeIuqgRDOnw6F+K9lDWZElHJW6qVaLcUG2PQ5ctTpkOL9aF5L7piU1J1YJOH5FObZIscBFcw4pYiW86HTtK1M0uxkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031507; c=relaxed/simple;
	bh=/rFiPiui5xo91cfen1ZKOTLUC/gwQuIUFjSjhxS+xP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg9SwhViGKL2GM0ISqyfAQyKge6wZS7rHbg3B5NKaOFWlWIL0/Pu2qvTRwdGK3qqvXj/bXvQpfN+V3KDkJiNidI+IXKqjvvaOD+bmPvGGvwaMYWd1iXhEpAGNbn9eJd2y7pGix9QacBMAVFMqbk3/vRflsL2LUOMnoIa7iW8kXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZN6VBXg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so51657541fa.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Jun 2024 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718031504; x=1718636304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WTNVAtPq8Wiju79U9wF0E7Uh3c2Y74GejBDhFhsm/oA=;
        b=OZN6VBXg6NWTp0nRsTo4Y53nFLHFa7oI1UMfY27NjyDgiAwTTflkFUJWtXab+YG/+1
         asyiOPLNpA9jmk/dS5ZzItyEPjE9aLuGa11D7ZEWmf1SMxNuds2rkt5PhP0EPbqGtTCb
         LFLGG1ix0olnGMj8Anid2ivGl0ZVOviFE5ywIi/cKxKwrOaRwKmHe0uGiulGKwEM2YUX
         rSLtEfHINIMrm8cYSW1dorQf7Agdc1VnAQBix09RDakP/P21Z24cv4unS69hrFzcY28j
         bWTj3VXgsaX2+5CeIznRND6csOBt41OGJyYCrxPlobaP6Kcr2ijUzyzwNZiRtz1cpXLX
         UJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718031504; x=1718636304;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTNVAtPq8Wiju79U9wF0E7Uh3c2Y74GejBDhFhsm/oA=;
        b=X+tJFf5qF1ws9cpokNt8EcFNcS9K60+7u1j70K6gY6oWaJ5V37ss/qVHiQrdsbDrrF
         Irp/MYAiU5drGWQ9a2OIzNTiJ26KNZYErLPo04nHoy+OMT6FltJ2zewGs9qcg9AtL81s
         hZQ7BH3KnYt3HYBTYFzb3fPztzQl8px2whJbz7AiVkCQ0L+jh1KmnmUEPWA+I+KTCTJt
         Qaf7MLEltzuVGvFGkPLV6SyjLIlfGQpPag9ssdvrK5BAIOlMSSOU86d5iPdJCxXaeXZ8
         8ul6uZFZ2hfuEEoAag+GPxny3bIWI6BTG5XDzUdA0Mpe/pG/AS0DMdXigkwmuj0Dk/W2
         5gjQ==
X-Gm-Message-State: AOJu0YxYT/5OI0XaCjLkU4UOMptsaNZLaXwbmwc6oDvYmroOtY2SOL8C
	sV2dW0OoUAi30Qwl4mxWM2Lgs55HGydR3XoorG0euMS8wfxVkyJ1rqk/jQvDJ2M=
X-Google-Smtp-Source: AGHT+IFviEXi4tfz0YwerHwnZsIqKdNFd5xa53pVj8I49cG4hFmskJxGt5vPhLUEI3RbN1nfv8c3tA==
X-Received: by 2002:a2e:9c09:0:b0:2eb:dced:71a7 with SMTP id 38308e7fff4ca-2ebdced7261mr27185451fa.13.1718031503940;
        Mon, 10 Jun 2024 07:58:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c82a5e0f9sm1794446a12.12.2024.06.10.07.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:58:23 -0700 (PDT)
Message-ID: <5ad5cf7a-c5c6-449e-9ed9-3d9f74959a19@linaro.org>
Date: Mon, 10 Jun 2024 16:58:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
To: Judith Mendez <jm@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 Nishanth Menon <nm@ti.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 David Lechner <david@lechnology.com>
References: <20240610144637.477954-1-jm@ti.com>
 <20240610144637.477954-2-jm@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240610144637.477954-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2024 16:46, Judith Mendez wrote:
> Add new compatible ti,am62-eqep for TI K3 devices. If a device
> uses this compatible, require power-domains property.
> 
> Since there is only one functional and interface clock for eqep,
> clock-names is not really required, so removed from required
> section, make it optional for ti,am3352-eqep compatible, and
> update the example.
> 

...


>          interrupts = <79>;
>      };
>  
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        eqep1: counter@23210000 {

No need for label

> +          compatible = "ti,am62-eqep";
> +          reg = <0x00 0x23210000 0x00 0x100>;
> +          power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
> +          clocks = <&k3_clks 60 0>;
> +          interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
> +          status = "disabled";

Drop... which also points to another comment - since this was no-op and
example is basically the same, then just don't add it. No point.

> +        };
> +    };
>  ...

Best regards,
Krzysztof


