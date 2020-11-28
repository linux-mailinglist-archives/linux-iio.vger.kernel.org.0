Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2032C7078
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 19:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgK1R7h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 12:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbgK1R5f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 12:57:35 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E5F22456;
        Sat, 28 Nov 2020 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606586214;
        bh=Y4tpYinA5TUHjdPSkcxV5jWTVfrgtBiS6vtywGzjwvQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BsZ6molRogIjNMNsThGL64BjZlb2ZUQESnqKijdNZgOemTvkiVP8nm9O2n88ZVoJU
         kqEgitpggcKiyeS2lJNGj+tcOYgc7c4rJYO4hSHFi9RPNzndV++jWeCfrkfFPg3gHd
         rfeioP2X/plLZxHdO8nAn/0dbqtzoM7nrQQDBsk8=
Date:   Sat, 28 Nov 2020 17:56:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 10/10] dt-bindings:iio:potentiostat:ti,lmp91000: txt to
 yaml conversion.
Message-ID: <20201128175650.1e8d2a5e@archlinux>
In-Reply-To: <CAJCx=gmWRa4Q_zZZG=f37ZeuifCjmJZ5gnuuc1ZBFGa6bdmGrQ@mail.gmail.com>
References: <20201031181242.742301-1-jic23@kernel.org>
        <20201031181242.742301-11-jic23@kernel.org>
        <CAJCx=gmWRa4Q_zZZG=f37ZeuifCjmJZ5gnuuc1ZBFGa6bdmGrQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 14:41:10 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sat, Oct 31, 2020 at 11:15 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > There were a few parts of the example that did not conform to the
> > binding description and would not have worked with the Linux driver
> > as a result.  Fixed them whilst doing this conversion.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Note I couldn't drop the type markings for the resistance properties here
because the dt-schema uses ohms and these are ohm.

An unfortunate bit of legacy we'll need to maintain I guess.

Jonathan

> 
> > ---
> >  .../bindings/iio/potentiostat/lmp91000.txt    | 33 ---------
> >  .../iio/potentiostat/ti,lmp91000.yaml         | 68 +++++++++++++++++++
> >  2 files changed, 68 insertions(+), 33 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
> > deleted file mode 100644
> > index f3ab02b0dd41..000000000000
> > --- a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -* Texas Instruments LMP91000 series of potentiostats
> > -
> > -LMP91000: https://www.ti.com/lit/ds/symlink/lmp91000.pdf
> > -LMP91002: https://www.ti.com/lit/ds/symlink/lmp91002.pdf
> > -
> > -Required properties:
> > -
> > -  - compatible: should be one of the following:
> > -                 "ti,lmp91000"
> > -                 "ti,lmp91002"
> > -  - reg: the I2C address of the device
> > -  - io-channels: the phandle of the iio provider
> > -
> > -  - ti,external-tia-resistor: if the property ti,tia-gain-ohm is not defined this
> > -    needs to be set to signal that an external resistor value is being used.
> > -
> > -Optional properties:
> > -
> > -  - ti,tia-gain-ohm: ohm value of the internal resistor for the transimpedance
> > -    amplifier. Must be 2750, 3500, 7000, 14000, 35000, 120000, or 350000 ohms.
> > -
> > -  - ti,rload-ohm: ohm value of the internal resistor load applied to the gas
> > -    sensor. Must be 10, 33, 50, or 100 (default) ohms.
> > -
> > -Example:
> > -
> > -lmp91000@48 {
> > -       compatible = "ti,lmp91000";
> > -       reg = <0x48>;
> > -       ti,tia-gain-ohm = <7500>;
> > -       ti,rload = <100>;
> > -       io-channels = <&adc>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/potentiostat/ti,lmp91000.yaml b/Documentation/devicetree/bindings/iio/potentiostat/ti,lmp91000.yaml
> > new file mode 100644
> > index 000000000000..e4b5d890e8d5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/potentiostat/ti,lmp91000.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/potentiostat/ti,lmp91000.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments LMP91000 series of potentiostats with I2C control
> > +
> > +maintainers:
> > +  - Matt Ranostay <matt.ranostay@konsulko.com>
> > +
> > +description: |
> > +  Typically used as a signal conditioner for chemical sensors.
> > +  LMP91000: https://www.ti.com/lit/ds/symlink/lmp91000.pdf
> > +  LMP91002: https://www.ti.com/lit/ds/symlink/lmp91002.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,lmp91000
> > +      - ti,lmp91002
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  io-channels:
> > +    maxItems: 1
> > +
> > +  ti,external-tia-resistor:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      If the property ti,tia-gain-ohm is not defined this needs to be set to
> > +      signal that an external resistor value is being used.
> > +
> > +  ti,tia-gain-ohm:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [2750, 3500, 7000, 14000, 35000, 120000, 350000]
> > +    description:
> > +      Internal resistor for the transimpedance amplifier.
> > +
> > +  ti,rload-ohm:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [10, 33, 50, 100]
> > +    description:
> > +      Internal resistor load applied to the gas sensor.
> > +      Default 100 Ohms.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - io-channels
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        lmp91000@48 {
> > +            compatible = "ti,lmp91000";
> > +            reg = <0x48>;
> > +            ti,tia-gain-ohm = <7000>;
> > +            ti,rload-ohm = <100>;
> > +            io-channels = <&adc>;
> > +        };
> > +    };
> > +...
> > --
> > 2.28.0
> >  

