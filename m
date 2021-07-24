Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126943D484B
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 17:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhGXOkK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 10:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXOkJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 10:40:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 690A260E96;
        Sat, 24 Jul 2021 15:20:37 +0000 (UTC)
Date:   Sat, 24 Jul 2021 16:23:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>, lars@metafoo.de,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Subject: Re: [PATCH V2 5/5] dt-bindings: iio/adc: ingenic: add the JZ4760(B)
 socs to the sadc Documentation
Message-ID: <20210724162309.70334ae8@jic23-huawei>
In-Reply-To: <CAFsFa84mJpAk90W6rSYwZ9m-RCbu959_8HJ+1Dr3ScP2k9SbKw@mail.gmail.com>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
        <20210723085813.1523934-1-cbranchereau@gmail.com>
        <20210723085813.1523934-6-cbranchereau@gmail.com>
        <20210723171657.00003d7f@Huawei.com>
        <CAFsFa84mJpAk90W6rSYwZ9m-RCbu959_8HJ+1Dr3ScP2k9SbKw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Jul 2021 09:33:46 +0200
Christophe Branchereau <cbranchereau@gmail.com> wrote:

> Hello Johnathan, am I allowed to declare the property within the if
> block like this?

Test it...

Short answer is no you aren't.  As someone explained it to me the other
day, each layer of the yaml is checked independently so if you declare
a property in the if block and not the outer layer the additionalProperties
check will fail should it be present.

So declare it outside, then set it false for the cases where it's not valid.

Jonathan

> 
> # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> # Copyright 2019-2020 Artur Rojek
> %YAML 1.2
> ---
> $id: "http://devicetree.org/schemas/iio/adc/ingenic,adc.yaml#"
> $schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> title: Ingenic JZ47xx ADC controller IIO bindings
> 
> maintainers:
>   - Artur Rojek <contact@artur-rojek.eu>
> 
> description: >
>   Industrial I/O subsystem bindings for ADC controller found in
>   Ingenic JZ47xx SoCs.
> 
>   ADC clients must use the format described in
>   https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml,
>   giving a phandle and IIO specifier pair ("io-channels") to the ADC controller.
> 
> properties:
>   compatible:
>     enum:
>       - ingenic,jz4725b-adc
>       - ingenic,jz4740-adc
>       - ingenic,jz4760-adc
>       - ingenic,jz4760b-adc
>       - ingenic,jz4770-adc
> 
>   '#io-channel-cells':
>     const: 1
>     description:
>       Must be set to <1> to indicate channels are selected by index.
> 
>   reg:
>     maxItems: 1
> 
>   clocks:
>     maxItems: 1
> 
>   clock-names:
>     items:
>       - const: adc
> 
>   interrupts:
>     maxItems: 1
> 
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - ingenic,jz4760b-adc
> then:
>   properties:
>     ingenic,use-internal-divider:
>       description:
>         If present, battery voltage is read from the VBAT_IR pin, which has an
>         internal 1/4 divider. If absent, it is read through the VBAT_ER pin,
>         which does not have such a divider.
>       type: boolean
> 
> required:
>   - compatible
>   - '#io-channel-cells'
>   - reg
>   - clocks
>   - clock-names
>   - interrupts
> 
> additionalProperties: false
> 
> examples:
>   - |
>     #include <dt-bindings/clock/jz4740-cgu.h>
>     #include <dt-bindings/iio/adc/ingenic,adc.h>
> 
>     adc@10070000 {
>             compatible = "ingenic,jz4740-adc";
>             #io-channel-cells = <1>;
> 
>             reg = <0x10070000 0x30>;
> 
>             clocks = <&cgu JZ4740_CLK_ADC>;
>             clock-names = "adc";
> 
>             interrupt-parent = <&intc>;
>             interrupts = <18>;
>     };
> 
> On Fri, Jul 23, 2021 at 6:17 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 23 Jul 2021 10:58:13 +0200
> > Christophe Branchereau <cbranchereau@gmail.com> wrote:
> >  
> > > The jz4760b variant differs slightly from the jz4760, add a property to
> > > let users sample the internal divider if needed and document it.
> > >
> > > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/ingenic,adc.yaml         | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > > index 433a3fb55a2e..0dc42959a64f 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > > @@ -23,6 +23,8 @@ properties:
> > >      enum:
> > >        - ingenic,jz4725b-adc
> > >        - ingenic,jz4740-adc
> > > +      - ingenic,jz4760-adc
> > > +      - ingenic,jz4760b-adc
> > >        - ingenic,jz4770-adc
> > >
> > >    '#io-channel-cells':
> > > @@ -43,6 +45,13 @@ properties:
> > >    interrupts:
> > >      maxItems: 1
> > >
> > > +  ingenic,use-internal-divider:
> > > +    description:
> > > +      This property can be used to set VBAT_SEL in the JZ4760B CFG register
> > > +      to sample the battery voltage from the internal divider. If absent, it
> > > +      will sample the external divider.
> > > +    type: boolean
> > > +  
> > See reply to the v1 patch for hint on how to 'enforce' that this
> > only exists for the jz4760b
> >
> > Thanks,
> >
> > Jonathan
> >  
> > >  required:
> > >    - compatible
> > >    - '#io-channel-cells'  
> >  

