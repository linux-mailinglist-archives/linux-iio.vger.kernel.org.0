Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F69CEA8
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2019 13:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfHZLyU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 07:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfHZLyU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Aug 2019 07:54:20 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3088A2189D;
        Mon, 26 Aug 2019 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566820459;
        bh=6d8Pf2giZ8gFsCA6Mlwav/1B6nTN9Sah3mq5E5Nvjo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QvJBQ55ojSqqsTPUhO00j6OJJz5EaQoXkuS9MHOOzMa5fzOJNWIYViaNorEhp/Sut
         GoRpe9hoMwItkuwDeb0tTTdr5Ap5zStj9QwOOTRxEHy74nIkVG4gnYcqC4sAIs0t+p
         +8LglhXXFueLMBm+Hf7Fbae0bnj4hvQ9tRJJui9I=
Received: by mail-qk1-f173.google.com with SMTP id p13so13719907qkg.13;
        Mon, 26 Aug 2019 04:54:19 -0700 (PDT)
X-Gm-Message-State: APjAAAUieU+hYjjymLJ4H5Bcrw4JjnbsHehd83RFAsE8fVgmWc17mJsD
        UuS2Vhf/XtxNJFXmCaG2Z7KjOL0mLn845TGsxA==
X-Google-Smtp-Source: APXvYqwefTr2/bNUCQOk9axEdQjco6LCiAhg6K2odj3PCAzUTZW7osr4FjP132HUalSUByM7PTRXcJ6wplhPQhlnSiQ=
X-Received: by 2002:a37:a010:: with SMTP id j16mr16163354qke.152.1566820458257;
 Mon, 26 Aug 2019 04:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190823145356.6341-1-krzk@kernel.org> <20190823145356.6341-5-krzk@kernel.org>
In-Reply-To: <20190823145356.6341-5-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Aug 2019 06:54:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJybT41cEqiTriLMywUQj1BtAG_9muJ4=84OkF23y53CA@mail.gmail.com>
Message-ID: <CAL_JsqJybT41cEqiTriLMywUQj1BtAG_9muJ4=84OkF23y53CA@mail.gmail.com>
Subject: Re: [RFC 5/9] dt-bindings: arm: samsung: Convert Exynos PMU bindings
 to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, notify@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 23, 2019 at 9:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Convert Samsung Exynos Power Management Unit (PMU) bindings to DT schema
> format using json-schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/samsung/pmu.txt   | 72 --------------
>  .../devicetree/bindings/arm/samsung/pmu.yaml  | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.yaml


> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> new file mode 100644
> index 000000000000..818c6f3488ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/samsung/pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC series Power Management Unit (PMU)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - samsung,exynos3250-pmu
> +          - samsung,exynos4210-pmu
> +          - samsung,exynos4412-pmu
> +          - samsung,exynos5250-pmu
> +          - samsung,exynos5260-pmu
> +          - samsung,exynos5410-pmu
> +          - samsung,exynos5420-pmu
> +          - samsung,exynos5433-pmu
> +          - samsung,exynos7-pmu
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clock-names:
> +    description:
> +      list of clock names for particular CLKOUT mux inputs
> +    # TODO: what is the maximum number of elements (mux inputs)?
> +    minItems: 1
> +    maxItems: 32
> +    items:
> +      - enum:

This isn't correct as you are only defining possible names for the
first item. Drop the '-' (making items a schema instead of a list) and
then it applies to all. However, doing that will cause a meta-schema
error which I need to fix to allow. Or if there's a small set of
possibilities of number of inputs, you can list them under a 'oneOf'
list.

> +          - clkout0
> +          - clkout1
> +          - clkout2
> +          - clkout3
> +          - clkout4
> +          - clkout5
> +          - clkout6
> +          - clkout7
> +          - clkout8
> +          - clkout9
> +          - clkout10
> +          - clkout11
> +          - clkout12
> +          - clkout13
> +          - clkout14
> +          - clkout15
> +          - clkout16
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 32
> +
> +  interrupt-controller:
> +    description:
> +      Some PMUs are capable of behaving as an interrupt controller (mostly
> +      to wake up a suspended PMU).
> +
> +  '#interrupt-cells':
> +    # TODO: must be identical to the that of the parent interrupt controller.

There's not really a way to express that. Just state that in the
description if you want.

> +    const: 3
> +
> +  # TODO: Mark interrupt-controller and #interrupt-cells as required, if one is present

No need, the core schemas handle that dependency. It would be good to
define for which compatibles the properties are required. You can do
this with if/then schema. There's several examples in the tree.

> +  # TODO: nodes defining the restart and poweroff syscon children
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - clock-names
> +  - clocks
> +
> +examples:
> +  - |
> +    pmu_system_controller: system-controller@10040000 {
> +      compatible = "samsung,exynos5250-pmu", "syscon";
> +      reg = <0x10040000 0x5000>;
> +      interrupt-controller;
> +      #interrupt-cells = <3>;
> +       interrupt-parent = <&gic>;
> +      #clock-cells = <1>;
> +      clock-names = "clkout16";
> +      clocks = <&clock 0>; // CLK_FIN_PLL
> +    };
> --
> 2.17.1
>
