Return-Path: <linux-iio+bounces-24389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C38B98B57
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 09:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE223B550D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4F327E060;
	Wed, 24 Sep 2025 07:57:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FD16132A
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700646; cv=none; b=H7Jx9lf7hn0e8KjAq5JCL8NzewJn3bQOuB+nKg/NUtwWbOj4Y7ETkG51B2omfli37EZknUaxfoZi793xKWLGUlYUxq6ybc5yBpxJr1MUdEn8mMFWWa5rRRkLgV0PynMjNXb+BMpPB/piEUcy+U+X3489xONqzNsjRMCU3rsaEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700646; c=relaxed/simple;
	bh=aWLfvJIhJGUp5ivux4F05IzZUz29wUscuHa27oPNgME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeN3HhjwjqlRfgY5XBrsJ+Dffxv2JI7E0H96FYGmBnPw5GDi/vriqt7ngBGDS/78N2hnJ4SBl/yHDpS1rbTaaxgGYowPqxo+GIck6B0ihEhEHJtL56N6epnoy2Rv9CHdsisUNSVHObGC+DoBTxwX6v1z8dRL97c+v9auZuvQpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-746d3b0f7e5so6073737a34.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 00:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700644; x=1759305444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh+Khf6unZqbzxNHEU+Ts8bq4BIxlEWA7Rzthe6aDww=;
        b=MR2ViCko2gl1rzsiteX2PdsfLw5kkUZq7Q0tvhg32xrUbFNH8mxYwkqLxOddjPVMY3
         6+4KAze8RtbC8jjKpGOdLyAyheJpZPjvOZQk76bM0QQVc67yn2dYUPbMyWfjP/MA2/MW
         ZdfDsvm1sn+IxzNz+LM0K4Accthml+D4kjzDCpJ1hh3vRKp9kLCcb8cdLX/38zeILclD
         C30JCkaVw+DDarO+xKI4VjMRtvs7/8YY0Hycca9ZRRqbRGVtW+ypbF1PvqdpW7zDkRtk
         1AroRCSNfX4GlNC7vw7FXznCNLpFW65TCijPWbn4U5iamazp51wiQO2qXer0wwwEul5u
         wUnw==
X-Forwarded-Encrypted: i=1; AJvYcCWxWtf4ohc///bdJ8ud5nzw9XePZiZZ+c/2h//vjkHg7Nlq3ZQV/WjbjwuDmNbsIVcBEWHjBSltbpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR97Skdl+/eDIue/odFlOkkptfUvjHibS0ea7DFuIswuuUVzLj
	fa2Bm6Ky+6YoQEjYEt9IXTHexqOwH7luOIWp+OdcECPZR0P72Mv195NpvJJBgrbi
X-Gm-Gg: ASbGncuDun1DCcr7f6A5coIXfjjMd+k0vTSR53KRgHNqZxIasqmlU+j8jGat5NNFy81
	PSmMiZvgbmORXwsXl2/PcX11iYV5+k69DrIarTpiEy+L/E64HtnhGk4RmouUVE6m3BAcwrGKfLa
	nz1QGNt/PrMhuzOTW7Mopyeul4EmkskA6S2z2kvfWLSnhh5vrE5dFxiitkz88FAlE9UxHPQ/WPn
	EqE8HINGZfzjAE/SVBgiT0GeWJ4lqNaOgfW7KQJRzxYgrZQC8PFgJ/SrNuH/nHMlV4jnnUY6LSC
	f4ifHWwTO+9gcwEFWrvQdcjhJ5pvSn+tTPy/zPmzEBUaLe5NG+7XCkcYJtTs0YxxBq7oOGDYDV8
	k1H9LDq/S49nb2Y4YiL0wnCCaM1avMpTpQH5NqhBB0q8tqFimJ4ecZBgY2KMe
X-Google-Smtp-Source: AGHT+IFc+QnWNZmucv7Z4g3d3e97svNV5aof7GpX9rVyRi1PhAyIlN/L8BEo+k1N/kZZVL7XBLWvhw==
X-Received: by 2002:a05:6808:190e:b0:43d:1eec:aea7 with SMTP id 5614622812f47-43f2d4c73a1mr3820392b6e.45.1758700643692;
        Wed, 24 Sep 2025 00:57:23 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c67a1b1sm6492304b6e.6.2025.09.24.00.57.23
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:57:23 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-35ba7c71bfdso66258fac.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 00:57:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9ECM6Dq2tzrmUFDEuhw62ZT22V+MCU/u/HyMDMqzcP51Or8HG3HraGv0vgmET0Is7TujSD+MaM6w=@vger.kernel.org
X-Received: by 2002:a05:6102:6884:b0:569:93c9:b572 with SMTP id
 ada2fe7eead31-5a57695d27dmr1659602137.9.1758700290135; Wed, 24 Sep 2025
 00:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com> <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 09:51:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEDJZ6wdGZs_CDs=jLPV1u382o6=cZ1HfKQOffGf7jGw@mail.gmail.com>
X-Gm-Features: AS18NWCUnOtI9sni6QIPbp0MqkmfhYYAKBnwNUuJbeyYXQXVL2FCMeoJiSjFxRk
Message-ID: <CAMuHMdVEDJZ6wdGZs_CDs=jLPV1u382o6=cZ1HfKQOffGf7jGw@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Tue, 23 Sept 2025 at 18:06, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Document the A/D 12-Bit successive approximation converters found in the
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/T2H / RZ/N2H ADC12
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> +
> +description: |
> +  A/D Converter block is a successive approximation analog-to-digital converter
> +  with a 12-bit accuracy. Up to 15 analog input channels can be selected.

The documentation for several registers talks about bitmasks for ch0-ch15,
so the actual hardware block supports up to 16 channels.

> +  Conversions can be performed in single or continuous mode. Result of the ADC
> +  is stored in a 16-bit data register corresponding to each channel.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,r9a09g077-adc # RZ/T2H
> +      - renesas,r9a09g087-adc # RZ/N2H
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: A/D scan end interrupt
> +      - description: A/D scan end interrupt for Group B
> +      - description: A/D scan end interrupt for Group C
> +      - description: Window A compare match
> +      - description: Window B compare match
> +      - description: Compare match
> +      - description: Compare mismatch
> +
> +  interrupt-names:
> +    items:
> +      - const: adi
> +      - const: gbadi
> +      - const: gcadi
> +      - const: cmpai
> +      - const: cmpbi
> +      - const: wcmpm
> +      - const: wcmpum
> +
> +  clocks:
> +    items:
> +      - description: converter clock

Converter

> +      - description: peripheral clock

Peripheral

> +
> +  clock-names:
> +    items:
> +      - const: adclk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  renesas,max-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Maximum number of channels supported by the ADC.
> +      RZ/T2H has two ADCs with 4 channels and one with 6 channels.
> +      RZ/N2H has two ADCs with 4 channels and one with 15 channels.

According to the documentation, both SoCs have three instances?

I agree with Connor that this should be dropped: the same information
is available from the channel@N subnodes, and future SoCs could have
gaps in the numbering.

FTR, from a quick glance, it looks like this module is very similar
to the ADC on RZ/A2M, so I hope we can reuse the driver for that SoC.

> +patternProperties:
> +  "^channel@[0-9a-e]$":

0-9a-f

> +    $ref: adc.yaml
> +    type: object
> +    description: The external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        maximum: 14

15
But I don't think it is needed, as the dtc check for non-matching unit
addresses and reg properties should already enforce this.

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g077-adc
> +    then:
> +      properties:
> +        renesas,max-channels:
> +          enum: [4, 6]
> +
> +      patternProperties:
> +        "^channel@[6-9a-e]$": false

6-9a-f

> +        "^channel@[0-5]$":
> +          properties:
> +            reg:
> +              maximum: 5

Not needed as per above.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

