Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AFF28B57D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgJLNHB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 09:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgJLNHB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 09:07:01 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E07BE208B8
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602508020;
        bh=EyhjaDYJibc4JWYj6KDnOpF8EPEBrmpWv4zxabOgYD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eNlhLSQHF4BtkrtEb7mkm82JliNOjB92iFqyfzb46lgwwyHoDLB9mwhe8QXV/Zv4y
         BWr3SbU6P61XRjRzwdZlpeNJlHK3QUlxtzLbEoPXdehyryLDAHpg35MmijMJ5OQ4QX
         IQ+OyzSAVI+QbDmCM4olEdK+p/sGRGi5V6yeT7Zs=
Received: by mail-oi1-f171.google.com with SMTP id 16so18615605oix.9
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 06:06:59 -0700 (PDT)
X-Gm-Message-State: AOAM531H8zLlN/0m3bgEufew/GsRCEqFOOAqPc7ibpTuw0Bb5LgoBrje
        dganblGZ62ZNpBZm9ALg1PeyumPesfPiZp3f0A==
X-Google-Smtp-Source: ABdhPJxHboqRcejDLJOqsTdeqbdXHZ/p5oEH6G+XHQ/N1wqr4w9r1msBk7eFdq9Ryfp6lJ2v2qfRSBy79squ/6Ln888=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr11089064oie.152.1602508019039;
 Mon, 12 Oct 2020 06:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org> <20201011170749.243680-9-jic23@kernel.org>
In-Reply-To: <20201011170749.243680-9-jic23@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Oct 2020 08:06:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKT7G-E7Ao7AbRwm_J_MRRRqcChpn5xkJZrftTjJLUZtQ@mail.gmail.com>
Message-ID: <CAL_JsqKT7G-E7Ao7AbRwm_J_MRRRqcChpn5xkJZrftTjJLUZtQ@mail.gmail.com>
Subject: Re: [PATCH 08/29] dt-bindings:iio:pressure:hoperf,hp03 yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 11, 2020 at 12:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One quirk in the txt file was that the xclr gpio was specified as
> gpio-xclr rather than gpios-xclr. I've fixed that in the

xclr-gpios?, not gpios?-xclr

> yaml version.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
>  .../bindings/iio/pressure/hoperf,hp03.yaml    | 47 +++++++++++++++++++
>  .../devicetree/bindings/iio/pressure/hp03.txt | 17 -------
>  2 files changed, 47 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml b/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml
> new file mode 100644
> index 000000000000..69a3759e23db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/hoperf,hp03.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HopeRF HP03 digital pressure/temperature sensors
> +
> +maintainers:
> +  - Marek Vasut <marex@denx.de>
> +
> +description: |
> +  Digital pressure and temperature sensor with an I2C interface.
> +
> +properties:
> +  compatible:
> +    const: hoperf,hp03
> +
> +  reg:
> +    maxItems: 1
> +
> +  xclr-gpios:
> +    description:
> +      The XCLR pin is a reset of the ADC in the chip, it must be pulled
> +      HI before the conversion and readout of the value from the ADC
> +      registers and pulled LO afterward.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pressure@77 {
> +            compatible = "hoperf,hp03";
> +            reg = <0x77>;
> +            xclr-gpios = <&portc 0 0x0>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/pressure/hp03.txt b/Documentation/devicetree/bindings/iio/pressure/hp03.txt
> deleted file mode 100644
> index 831dbee7a5c3..000000000000
> --- a/Documentation/devicetree/bindings/iio/pressure/hp03.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -HopeRF HP03 digital pressure/temperature sensors
> -
> -Required properties:
> -- compatible: must be "hoperf,hp03"
> -- xclr-gpio: must be device tree identifier of the XCLR pin.
> -             The XCLR pin is a reset of the ADC in the chip,
> -             it must be pulled HI before the conversion and
> -             readout of the value from the ADC registers and
> -             pulled LO afterward.
> -
> -Example:
> -
> -hp03@77 {
> -       compatible = "hoperf,hp03";
> -       reg = <0x77>;
> -       xclr-gpio = <&portc 0 0x0>;
> -};
> --
> 2.28.0
>
