Return-Path: <linux-iio+bounces-17256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAE3A6E2C8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 19:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1AC17A4F75
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2371266F16;
	Mon, 24 Mar 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JcsHAyC7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6B266F03
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842567; cv=none; b=JVYeRpluVRIbToW9VZDoWOmUFTQLPimiopvqOCku9tbVdYWOi1EuYb8eds0toZwhNk5LcgT3Xs8n0cPPk1qvJGEapytrwT2y/o7BKHnTWknIVPqhaq6tWQnhIU21wcy2WsXikZSYY427lN188Flr16Q7Xxgk2me9R3ido/yCxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842567; c=relaxed/simple;
	bh=a+tVV7dh7MzB4mshZc5wigf+spuaZL1s32GUcdilUP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sMBJ7CREeOI6PGlpkKllPVxY2bmpARHOrRHYLhn9JYaqpertCOk0LwJEA9WUjuL7T75CTSpCFXrGyNwcWDBilV8xWH1XGMjaYKfNUzjA3QjOzw6BNyAEQz662pRJvI+cPQwQcPzwhQCk8VARQYB4OK+iSDz+lxNw/cNQi/cw8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JcsHAyC7; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c787506611so827083fac.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742842565; x=1743447365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L04FanZwF3VAWkrzQjyImYypkCu6QrodmJxDltgNWqw=;
        b=JcsHAyC7/tqQh+xeDctz4orWmySjkoqUsY7JaxFWrPj5UkoQwy1PPwCj0gf5m9vJjP
         N5iGHCge5joCVBTPjxlS9SjrbBybUnutZNLRdp/XmjQApZJv95WAeR/NYHqK0aOVKdhv
         AcvZ6s+H/FtZ7fX/IM1sSz1NEbJibiV9a/JnIbP8JpXWurWPCPjzvOqNwRjn059R9y+c
         Crnh2KAMa9ghldyEud9vDPBkTSvmETtWza0HqCIHE6ylMtf2rPr4x4lh645REu1XoSgd
         NTurIAVQkXy9Sp/oJxDkI4ziWaVkp4CUbSDcDZuQmEVQL3nXnu3EaeRMaIXr0SgAxx9R
         yMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842565; x=1743447365;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L04FanZwF3VAWkrzQjyImYypkCu6QrodmJxDltgNWqw=;
        b=BjNwbzByGPCLAzv88swyAedkuLHLkGwvZpVUaxrgSdwh2jQbK/WUXNbeeQdBoM3hCf
         WPW+UItuNFBidZSAH0beHGeKeZGuHIa6Xl8DqsidnqVlEMuBRC+maxJzEZwbRxPIFj/N
         FsElzdPNk/x77VKriIKQrFI9FosXZSy2WKgKuR1vUToPFJaYNgFRCefldVfWiaTBq/3C
         YkwaBzR/Jj3nv75SpQqkafwhgUrWKs7txBHLGj02TmLQt7kRufkc2m0QRnRQL6JNAjI5
         SJpN0/87MsPQaKtGKIgaAtnFRlBvk+r37OLpqxz4dnREJjREek7aXuv/Z0+mtKQv600D
         P/pA==
X-Forwarded-Encrypted: i=1; AJvYcCXEqzwxRArAlccaDOFZAAtMexlexDz5n8owO2NNV2zKZjV0a2IdxwxqqS/kznN/Un9UcV1JUmAJG9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOmgTHRnBpE7cpPaPV7cSjjQ9FO4NRYdvjlMQgU+6WqGs/0Xn
	XvImK9W2Km85BblWrSFEeYIuaIHdJMQjYv9uqQlF+zsgZdfjswfS98rJP6hEMLA=
X-Gm-Gg: ASbGncvKItxbBz1aNMchEtX8Ot9jgInnBeRIJB2To4IlUnGoMwMXtG7PiOn8VF9GMT0
	k5hDHm3VA/wuVrWcgYLzIqCEG54fhzZYUVkB1Mg3wjoMeQR3RsfXtfFHiUqu0PMt+QPEfkMuwNg
	lSA55JWcFLvAaVTFLWyk45CjiniPpjtoOUywV01biYntoVx4X7gTmvokQo20jC4BiuRH9CYEzXh
	GzwfhCj2xdWWMss2az/CXs7mkg+/URdf+CL//oA+M+SNK9WntYvgBElteUvjQRzXtH80NIYemia
	SXVhz0JFvGNHbuuDNJoB9Y3eKRKlFFnEPJxGgnVGdOeAKn/WOi9hJOOPMMG8Bzj+t6niYn20Rpn
	InI0ihA==
X-Google-Smtp-Source: AGHT+IFlP9h2LLyUSePPLXV5Qn0BgNwLj23B9y13aLgXoybGdVzox15RFQbnsJ7cA5/FOHEmCfbWzw==
X-Received: by 2002:a05:6871:4386:b0:2a3:c5fe:29b9 with SMTP id 586e51a60fabf-2c7804ec0e4mr10475928fac.29.1742842564445;
        Mon, 24 Mar 2025 11:56:04 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77ec51be0sm2114044fac.16.2025.03.24.11.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:56:03 -0700 (PDT)
Message-ID: <39d48315-0d05-4992-b905-ebb5b9fe77c1@baylibre.com>
Date: Mon, 24 Mar 2025 13:56:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: iio: adc: add ad7405
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-5-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250324090813.2775011-5-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/24/25 4:07 AM, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7405.yaml          | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> new file mode 100644
> index 000000000000..e312fa0cdb05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7405.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7405 family
> +
> +maintainers:
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +
> +description: |
> +  Analog Devices AD7405 is a high performance isolated ADC, 1-channel,
> +  16-bit with a second-order Σ-Δ modulator that converts an analog input signal
> +  into a high speed, single-bit data stream.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7405.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7701.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7702.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADuM7703.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7405
> +      - adi,adum7701
> +      - adi,adum7702
> +      - adi,adum7703
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +

There are no child nodes, so we don't need #address-cells or #size-cells.


> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  clocks:
> +    maxitems: 1
> +
> +  io-backends:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vdd1-supply
> +  - vdd2-supply
> +  - clocks
> +  - io-backends
> +
> +unevaluatedProperties: false

Should be able to use additionalProperties: false here instead.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>

This include isn't used and can be removed.

> +    adc {
> +       #address-cells = <1>;
> +        #size-cells = <0>;

Not needed as above.

> +        compatible = "adi,ad7405";
> +        clocks = <&axi_clk_gen 0>;
> +        vdd1-supply = <&vdd1>;
> +        vdd2-supply = <&vdd2>;
> +        io-backends = <&iio_backend>;
> +    };
> +...
> \ No newline at end of file


