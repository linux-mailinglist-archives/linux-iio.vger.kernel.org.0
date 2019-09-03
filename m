Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB4EA66FB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfICLDb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 07:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfICLDb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 07:03:31 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3B323431;
        Tue,  3 Sep 2019 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567508609;
        bh=dSw60VTrT8ZizL2EKH0X+I5o/zpqz+2te5KeeEekHbI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uzTd6T4U+Tkd4n8KJZfUZ9olVCK+fqZXolNXxUwUJrBUsir3ogtElmBagVAL/4uYZ
         F+78m8TgdsRpaQrVlJ1p8t97yLZ/YqboZ6I8dOjTUL309wm6v7TlnTdmrWHoSTMQx5
         wHd/On3QCQvzFpIIPLu+hqpW/AQ6m0/EiPPoBwr8=
Received: by mail-lj1-f180.google.com with SMTP id e17so4563943ljf.13;
        Tue, 03 Sep 2019 04:03:29 -0700 (PDT)
X-Gm-Message-State: APjAAAWRikgdLAcFYwGBDCHgwZZ7AZyhxQKgZEcXFXv9afwOz2Iwl1HG
        7HcSu3//Y7W0odc5qzKJRGvrEjgU4blrxG7AgLI=
X-Google-Smtp-Source: APXvYqyxHRs9YFFhl8+XZLTud4OWgRTCDnadBxI1NInauI7nndzlvmqFXuAOtRIDnpazy3S3n5w09bq4y/zI/IQu5B8=
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr19855964lji.40.1567508607223;
 Tue, 03 Sep 2019 04:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190823145356.6341-1-krzk@kernel.org> <20190823145356.6341-5-krzk@kernel.org>
 <CAL_JsqJybT41cEqiTriLMywUQj1BtAG_9muJ4=84OkF23y53CA@mail.gmail.com>
 <CAJKOXPc0SY_8BHMsWLN=1M3VQh41+bdBiH21L4KQPA+iLPYy+A@mail.gmail.com> <CAL_JsqKdsABWK9Og_f38T9zf3SCFFdhU8WOJ4uJjREantoYvYQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKdsABWK9Og_f38T9zf3SCFFdhU8WOJ4uJjREantoYvYQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Sep 2019 13:03:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfnvu=c5f6AcOSiQ_9E-C2fMf9qbEpy1Tr3QvH8LgAtpQ@mail.gmail.com>
Message-ID: <CAJKOXPfnvu=c5f6AcOSiQ_9E-C2fMf9qbEpy1Tr3QvH8LgAtpQ@mail.gmail.com>
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

On Tue, 3 Sep 2019 at 10:25, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Sep 3, 2019 at 8:58 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Mon, 26 Aug 2019 at 13:54, Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Fri, Aug 23, 2019 at 9:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > Convert Samsung Exynos Power Management Unit (PMU) bindings to DT schema
> > > > format using json-schema.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/samsung/pmu.txt   | 72 --------------
> > > >  .../devicetree/bindings/arm/samsung/pmu.yaml  | 93 +++++++++++++++++++
> > > >  2 files changed, 93 insertions(+), 72 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > >
> > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > new file mode 100644
> > > > index 000000000000..818c6f3488ef
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > @@ -0,0 +1,93 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/arm/samsung/pmu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Samsung Exynos SoC series Power Management Unit (PMU)
> > > > +
> > > > +maintainers:
> > > > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - samsung,exynos3250-pmu
> > > > +          - samsung,exynos4210-pmu
> > > > +          - samsung,exynos4412-pmu
> > > > +          - samsung,exynos5250-pmu
> > > > +          - samsung,exynos5260-pmu
> > > > +          - samsung,exynos5410-pmu
> > > > +          - samsung,exynos5420-pmu
> > > > +          - samsung,exynos5433-pmu
> > > > +          - samsung,exynos7-pmu
> > > > +      - const: syscon
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  '#clock-cells':
> > > > +    const: 1
> > > > +
> > > > +  clock-names:
> > > > +    description:
> > > > +      list of clock names for particular CLKOUT mux inputs
> > > > +    # TODO: what is the maximum number of elements (mux inputs)?
> > > > +    minItems: 1
> > > > +    maxItems: 32
> > > > +    items:
> > > > +      - enum:
> > >
> > > This isn't correct as you are only defining possible names for the
> > > first item. Drop the '-' (making items a schema instead of a list) and
> > > then it applies to all. However, doing that will cause a meta-schema
> > > error which I need to fix to allow. Or if there's a small set of
> > > possibilities of number of inputs, you can list them under a 'oneOf'
> > > list.
> >
> > Mhmm, I cannot test it or I have an error in the schema. if I
> > understand correctly, this would be:
> >
> >   clock-names:
> >     description:
> >       List of clock names for particular CLKOUT mux inputs
> >     minItems: 1
> >     maxItems: 16
> >     items:
> >       clkout0
> >       clkout1
> >       clkout2
> >       clkout3
> >       clkout4
> >       clkout5
> >       clkout6
> >       clkout7
> >       clkout8
> >       clkout9
> >       clkout10
> >       clkout11
> >       clkout12
> >       clkout13
> >       clkout14
> >       clkout15
> >       clkout16
> >
> > Now it produces the error "ignoring, error in schema 'items'" but
> > maybe it is expected with current meta-schema?
>
> 'make dt_binding_check' will give more detailed errors.
>
> Are the inputs always contiguous 0-N? If so, you want:
>
> items:
>   - const: clkout0
>   - const: clkout1
>   - const: clkout2
>   ...
>
> If you want to express any number and order of strings is valid, then you need:
>
> items:
>   enum:
>     - clkout0
>     - clkout1
>     - clkout2
>
> Doing that is discouraged for bindings though. Currently, it will
> generate an error from the meta-schema, but we could change that.

It's the second case. The inputs are not contiguous. Examples:

system-controller {
    compatible = "samsung,exynos3250-pmu", "syscon";
    clock-names = "clkout8";
    clocks = <&cmu CLK_FIN_PLL>;
}

system-controller {
    compatible = "samsung,exynos4412-pmu", "syscon";
    clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
                  "clkout4", "clkout8", "clkout9";
    clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
             <&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
             <&clock CLK_OUT_CPU>, <&clock CLK_XXTI>, <&clock CLK_XUSBXTI>;
}

The bindings never required any specific ordering. Also the driver
just go through all indices and parses them.

Your second syntax fails:
Documentation/devicetree/bindings/arm/samsung/pmu.yaml:
properties:clock-names:items: {'enum': ['clkout0', 'clkout1',
'clkout2', 'clkout3', 'clkout4', 'clkout5', 'clkout6', 'clkout7',
'clkout8', 'clkout9', 'clkout10', 'clkout11', 'clkout12', 'clkout13',
'clkout14', 'clkout15', 'clkout16']} is not of type 'array'

Best regards,
Krzysztof
