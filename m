Return-Path: <linux-iio+bounces-24654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8161BB3DEE
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 14:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83397AB108
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA230FF24;
	Thu,  2 Oct 2025 12:22:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15830F94E
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407746; cv=none; b=LjTsSkKMdbEzLdWidgLb1IH2cyK6c1M+I9Kz9fF3IhYNKj274pdBblpW4oRVH8t4aCT97jbpiuLuHIgRe/soUPtV6T3SjtbAtnvej03eN8bt79/hXAAxUF1MF2QmAKAf4tBk/kB/Sw2Ff26QVPxNHhUSu+L7XZg75rPy9h0yVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407746; c=relaxed/simple;
	bh=ZCLWknI3Oohh8zMZTDOwt7rdXpb2pywh5AbVWLK0g3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IL0ls1WxWcbpfIklsNiNW31i6BHe2oHUtFMrXSzQmdNCvVsvG3OKCf9t8hbwVXD2lEj8AY+HwI2pOe4vP1LXd/JXIBNHUyhE29PvovItyDvE3fogTJNclMf+Zx7+6ZqpENjuUkWQJaE6I8RGK2z9qiro3H03OwVEwm5tUY4IhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so1907536a12.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759407739; x=1760012539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pY10gBxAlncLft1B4e8e0H+E3DPfeVQijK8Ci3Ekn1c=;
        b=gv2HvGRWUMzcH38jcRf/A3L+JWptSJhYFEV/ayUjeUG32eaVvyqj5DEKHS4BHwV4tw
         +B/seAajtx8kK+ZXUGELyLZu5Cf3hbe45XZoCAjzSgl4vYrWZORDTVx26GpEvoFBF9ec
         3T00iIu8QP+Kd8AxNvB0ZiihuIP7VePMTZcPKptzUMubXID3Db0XjUQsjn9tI9Vh7iAr
         zcbp0GAjMVvqazgnwG3x29KuhS56RDGBh/tUyjsCwjvvEF7dadTnFVBEa8kosEVj+5aq
         25kBa/zXmS17p1QVpmN+EGUwmRBfECNhIdovK0/qHYGO3UfACs3dnH/paEm2Ke7ViHy1
         I7ow==
X-Forwarded-Encrypted: i=1; AJvYcCVUQr4L98n1mZtP5ULmQuT/COv9oH5oJAEqjUR6OsP5Jtba3MM2LtNUU8f3M/XmDSVquFmFRhlhkH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPA3INnB+8hN5QBVCXNMKn6OafZoVh85KoMBT1y8H15MOgoKn
	kqLtGnmxhzAd+mR5hgKLGmMmiQgKpZuMZteFEMNxE1hlSM06auCpxYo6orzcjGiHhcs=
X-Gm-Gg: ASbGnctzeJfD8CSKKj2L3/I/L8GZNCOhZ5kxehj7FgOfVfNsBcUn8ocLhhIQ2+Xu2tu
	52NUckGrOYknWFCjdv6ARe8VoY43O5qnhMU7Z6EsZ1HOEkeiw0UZPpL9L64AdkfB+Nht/Mv2uFC
	SgafaRE5geNBoX1bzXJ1va1xzjjSun/SgadqLKjdt4c5kOancq8p9G85HGG7tUncO8AVZu2pXLU
	cG2hXovFaqDMm6OjDmM7FcKpU3DB/lqxiNXj42DvdN2AU8iT1NAwowYLjuyS17UBAeEiclv2vSM
	tbh8uCYeSu7d6Lue+hTo4170f/Nq7ppHZy55Sw8QUW7PD8UZy5sDCSRAj94E8YWTeLN0jW+0kIU
	8SvwhI2S7VXcqvm835XA8Bt1eUIr2Tg7bqfdAV128iSE1Kdx2U7WfU4zD/7/PwibCZscv0TpV4B
	T6o59TNxEkwLzmRNJWM9d2ywGNYASBqw==
X-Google-Smtp-Source: AGHT+IFJ25m09v9tF0k4vNFaxIeQpRfTZHj5Qc1nJjO0tOq0TJjv4at9ILYXxZuv22Vw0zbCbkk1YQ==
X-Received: by 2002:a17:907:869f:b0:b3e:e244:1d8 with SMTP id a640c23a62f3a-b46e60367ddmr852094866b.34.1759407738510;
        Thu, 02 Oct 2025 05:22:18 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865c81e3esm198741266b.33.2025.10.02.05.22.15
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:22:15 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so1907294a12.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:22:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIobwFKufnh55SJItfYNtMDKAzQXDldKQFwmDDbWgiemgQHdQMpaJpyaKipk2bdOmRphUqSVmArY0=@vger.kernel.org
X-Received: by 2002:a05:6402:2748:b0:634:a32f:abbc with SMTP id
 4fb4d7f45d1cf-63678c7876cmr7743508a12.25.1759407734935; Thu, 02 Oct 2025
 05:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:22:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOWMvyGLz8HGEvosrGY070e2Xtm+dFTcd0EDTq+55nmg@mail.gmail.com>
X-Gm-Features: AS18NWABtGa2D2TwMrIq8k3cqO5ssX-ZOaNtMz3MgD0zeopDW4rX6Xc3PgPqoFQ
Message-ID: <CAMuHMdWOWMvyGLz8HGEvosrGY070e2Xtm+dFTcd0EDTq+55nmg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Document the A/D 12-Bit successive approximation converters found in the
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> @@ -0,0 +1,160 @@
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
> +  with a 12-bit accuracy. Up to 16 analog input channels can be selected.
> +  Conversions can be performed in single or continuous mode. Result of the ADC
> +  is stored in a 16-bit data register corresponding to each channel.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,r9a09g077-adc # RZ/T2H
> +      - renesas,r9a09g087-adc # RZ/N2H

Given the number of channels is now handled completely through the
number of subnodes, I wonder if this should be changed to:

    oneOf:
      - items:
          - const: renesas,r9a09g087-adc # RZ/N2H
          - const: renesas,r9a09g077-adc # RZ/T2H
      - items:
          - const: renesas,r9a09g077-adc # RZ/T2H

...

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g077-adc
> +    then:
> +      patternProperties:
> +        "^channel@[6-9a-f]$": false
> +        "^channel@[0-5]$":
> +          properties:
> +            reg:
> +              maximum: 5
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g087-adc
> +    then:
> +      patternProperties:
> +        "^channel@[f]$": false
> +        "^channel@[0-9a-e]$":
> +          properties:
> +            reg:
> +              maximum: 14

... and the SoC-specific restrictions above dropped?
The number of channels is instance-specific anyway.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

