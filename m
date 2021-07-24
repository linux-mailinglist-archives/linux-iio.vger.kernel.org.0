Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCC3D45F7
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 09:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhGXGx2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 02:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhGXGx2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 02:53:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B20BC061575;
        Sat, 24 Jul 2021 00:33:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w12so4618962wro.13;
        Sat, 24 Jul 2021 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I99OKEyOyDu2QZ9o92w6nHM+PeQzOx9KbxGs8smmzwM=;
        b=OTPkJG0ThpLSfE36PgXqezSsIzfWyH4WlE0UyzPVJyNe13MQKXfbC1ekZl5kWUHo2i
         ZoywdLGFHcV9y+WcFt/lB66WgS2EsNAH13CcDzJjX93J+TdN+FJp3S0dn6Ee/gcQ3dQT
         hTjEboZh4+3FBGdTnNQi3fthkz+i5w3HFPMgreggbReosUED9R9QhiQUii7Ijamu1v3E
         v0+7EUPDVYn41XY7OoygRrA7pfjeK/0HF/U8Yz5k/yS9RsNjM5I4y5bSZ5IXrrLwrNeo
         Yt2M3KIymc+hZZ9i7DfCrWOQVIFIuemb9FUWDh9K55+CuzK58cO7SUCISKgnm3XIWGbG
         tAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I99OKEyOyDu2QZ9o92w6nHM+PeQzOx9KbxGs8smmzwM=;
        b=l9GBX8+jIZNQDI35Q+NDUyLEQkRKIL1FZ3GMzBtQCsmIe3ZmBlgDH851nvaPvHgSy+
         wP8WGj+xUctmiAkcLryfm+fhVTe23IkXs3lx6M0C8To8FUZjJz55qGd/kIPQgRuRxyeN
         0lrpDnObKjQTlu72Ei7ofufcuYnK+gl4Pcl6qpOfCAPISfCqm7dDlsDmkFOrt63SaLV2
         OwI1o81V1klJ1rlyUKiWniNndzfQzfr6oE7tFUYoU2h6NzrvMJijwNVnzl1JJe8BwgQ+
         l+fDicJ50fgHs7+a6fmGVt8SepJ70DfQJ2mZwOW1mxR68tbMW/O61awJocaXor9EO76h
         3ZbQ==
X-Gm-Message-State: AOAM530hrsm8fdv4JML3dRKN+AQKF19uOaQ1mRSBdJS6W9FV2lQrKxul
        UDcogUEvtQjDr5wDXppzww1FOaSHeblkJnUMiSt31Hwx2kReQ7/y
X-Google-Smtp-Source: ABdhPJz4L7ngjDfI9huIL4szQJm/bxjfpDXTzfLi4mHdBnxRgDbDGmUNAyVr7zh/2VvIgbJUAUgJx/mR6dsVJWWlwsQ=
X-Received: by 2002:adf:f512:: with SMTP id q18mr35736wro.305.1627112037765;
 Sat, 24 Jul 2021 00:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
 <20210723085813.1523934-1-cbranchereau@gmail.com> <20210723085813.1523934-6-cbranchereau@gmail.com>
 <20210723171657.00003d7f@Huawei.com>
In-Reply-To: <20210723171657.00003d7f@Huawei.com>
From:   Christophe Branchereau <cbranchereau@gmail.com>
Date:   Sat, 24 Jul 2021 09:33:46 +0200
Message-ID: <CAFsFa84mJpAk90W6rSYwZ9m-RCbu959_8HJ+1Dr3ScP2k9SbKw@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] dt-bindings: iio/adc: ingenic: add the JZ4760(B)
 socs to the sadc Documentation
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, jic23@kernel.org,
        lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Johnathan, am I allowed to declare the property within the if
block like this?

# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
# Copyright 2019-2020 Artur Rojek
%YAML 1.2
---
$id: "http://devicetree.org/schemas/iio/adc/ingenic,adc.yaml#"
$schema: "http://devicetree.org/meta-schemas/core.yaml#"

title: Ingenic JZ47xx ADC controller IIO bindings

maintainers:
  - Artur Rojek <contact@artur-rojek.eu>

description: >
  Industrial I/O subsystem bindings for ADC controller found in
  Ingenic JZ47xx SoCs.

  ADC clients must use the format described in
  https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml,
  giving a phandle and IIO specifier pair ("io-channels") to the ADC controller.

properties:
  compatible:
    enum:
      - ingenic,jz4725b-adc
      - ingenic,jz4740-adc
      - ingenic,jz4760-adc
      - ingenic,jz4760b-adc
      - ingenic,jz4770-adc

  '#io-channel-cells':
    const: 1
    description:
      Must be set to <1> to indicate channels are selected by index.

  reg:
    maxItems: 1

  clocks:
    maxItems: 1

  clock-names:
    items:
      - const: adc

  interrupts:
    maxItems: 1

allOf:
  - if:
      properties:
        compatible:
          contains:
            enum:
              - ingenic,jz4760b-adc
then:
  properties:
    ingenic,use-internal-divider:
      description:
        If present, battery voltage is read from the VBAT_IR pin, which has an
        internal 1/4 divider. If absent, it is read through the VBAT_ER pin,
        which does not have such a divider.
      type: boolean

required:
  - compatible
  - '#io-channel-cells'
  - reg
  - clocks
  - clock-names
  - interrupts

additionalProperties: false

examples:
  - |
    #include <dt-bindings/clock/jz4740-cgu.h>
    #include <dt-bindings/iio/adc/ingenic,adc.h>

    adc@10070000 {
            compatible = "ingenic,jz4740-adc";
            #io-channel-cells = <1>;

            reg = <0x10070000 0x30>;

            clocks = <&cgu JZ4740_CLK_ADC>;
            clock-names = "adc";

            interrupt-parent = <&intc>;
            interrupts = <18>;
    };

On Fri, Jul 23, 2021 at 6:17 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 23 Jul 2021 10:58:13 +0200
> Christophe Branchereau <cbranchereau@gmail.com> wrote:
>
> > The jz4760b variant differs slightly from the jz4760, add a property to
> > let users sample the internal divider if needed and document it.
> >
> > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ingenic,adc.yaml         | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > index 433a3fb55a2e..0dc42959a64f 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > @@ -23,6 +23,8 @@ properties:
> >      enum:
> >        - ingenic,jz4725b-adc
> >        - ingenic,jz4740-adc
> > +      - ingenic,jz4760-adc
> > +      - ingenic,jz4760b-adc
> >        - ingenic,jz4770-adc
> >
> >    '#io-channel-cells':
> > @@ -43,6 +45,13 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  ingenic,use-internal-divider:
> > +    description:
> > +      This property can be used to set VBAT_SEL in the JZ4760B CFG register
> > +      to sample the battery voltage from the internal divider. If absent, it
> > +      will sample the external divider.
> > +    type: boolean
> > +
> See reply to the v1 patch for hint on how to 'enforce' that this
> only exists for the jz4760b
>
> Thanks,
>
> Jonathan
>
> >  required:
> >    - compatible
> >    - '#io-channel-cells'
>
