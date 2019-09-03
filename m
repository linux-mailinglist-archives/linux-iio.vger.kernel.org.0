Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95003A6336
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfICH6g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 03:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfICH6g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 03:58:36 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D827321881;
        Tue,  3 Sep 2019 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567497515;
        bh=UXh12NkSwZ12hWkXETNI+YE3LiuTShuDOHt89Jbh128=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=am7+Xbi2YfzdQSUw6p4YYdjuXFciTPcfw96UlPxdv1inY3pLUnYIUWWTTdp7gOu6j
         mbOKZWr7h3x4jVZ7l5VuM603tR4gC52GePWzV1gNGQzP/qU2s4yOLmczxTPXfsHYeP
         bsIivXjLkyEM2heVUy+enefLtMFc34vgtmnSlwbY=
Received: by mail-lf1-f52.google.com with SMTP id u29so12081415lfk.7;
        Tue, 03 Sep 2019 00:58:34 -0700 (PDT)
X-Gm-Message-State: APjAAAV73T5Ovkcgc1rE1XJcip6UUKUltD1FDhRq3L4+IJAmd2gUe7md
        LN2c3MfXKplbpkNgqz/eWw5MQmh3KOYphcZrHak=
X-Google-Smtp-Source: APXvYqzrJeKyNEvczFZsfe2tgLAYBl9BS475I7A9xOTHksgZrFCcJ43dEFvCe2Ya4ROGp9gR8nfJe7d+AYReOk1iVIQ=
X-Received: by 2002:a19:c649:: with SMTP id w70mr20083717lff.33.1567497513112;
 Tue, 03 Sep 2019 00:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190823145356.6341-1-krzk@kernel.org> <20190823145356.6341-5-krzk@kernel.org>
 <CAL_JsqJybT41cEqiTriLMywUQj1BtAG_9muJ4=84OkF23y53CA@mail.gmail.com>
In-Reply-To: <CAL_JsqJybT41cEqiTriLMywUQj1BtAG_9muJ4=84OkF23y53CA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Sep 2019 09:58:21 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc0SY_8BHMsWLN=1M3VQh41+bdBiH21L4KQPA+iLPYy+A@mail.gmail.com>
Message-ID: <CAJKOXPc0SY_8BHMsWLN=1M3VQh41+bdBiH21L4KQPA+iLPYy+A@mail.gmail.com>
Subject: Re: [RFC 5/9] dt-bindings: arm: samsung: Convert Exynos PMU bindings
 to json-schema
To:     Rob Herring <robh+dt@kernel.org>
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

On Mon, 26 Aug 2019 at 13:54, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Aug 23, 2019 at 9:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Convert Samsung Exynos Power Management Unit (PMU) bindings to DT schema
> > format using json-schema.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/samsung/pmu.txt   | 72 --------------
> >  .../devicetree/bindings/arm/samsung/pmu.yaml  | 93 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 72 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.yaml
>
>
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > new file mode 100644
> > index 000000000000..818c6f3488ef
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/samsung/pmu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung Exynos SoC series Power Management Unit (PMU)
> > +
> > +maintainers:
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - samsung,exynos3250-pmu
> > +          - samsung,exynos4210-pmu
> > +          - samsung,exynos4412-pmu
> > +          - samsung,exynos5250-pmu
> > +          - samsung,exynos5260-pmu
> > +          - samsung,exynos5410-pmu
> > +          - samsung,exynos5420-pmu
> > +          - samsung,exynos5433-pmu
> > +          - samsung,exynos7-pmu
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  clock-names:
> > +    description:
> > +      list of clock names for particular CLKOUT mux inputs
> > +    # TODO: what is the maximum number of elements (mux inputs)?
> > +    minItems: 1
> > +    maxItems: 32
> > +    items:
> > +      - enum:
>
> This isn't correct as you are only defining possible names for the
> first item. Drop the '-' (making items a schema instead of a list) and
> then it applies to all. However, doing that will cause a meta-schema
> error which I need to fix to allow. Or if there's a small set of
> possibilities of number of inputs, you can list them under a 'oneOf'
> list.

Mhmm, I cannot test it or I have an error in the schema. if I
understand correctly, this would be:

  clock-names:
    description:
      List of clock names for particular CLKOUT mux inputs
    minItems: 1
    maxItems: 16
    items:
      clkout0
      clkout1
      clkout2
      clkout3
      clkout4
      clkout5
      clkout6
      clkout7
      clkout8
      clkout9
      clkout10
      clkout11
      clkout12
      clkout13
      clkout14
      clkout15
      clkout16

Now it produces the error "ignoring, error in schema 'items'" but
maybe it is expected with current meta-schema?

Best regards,
Krzysztof
