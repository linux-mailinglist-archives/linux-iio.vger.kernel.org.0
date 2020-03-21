Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A465818E3F7
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 20:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCUTbF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 15:31:05 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:56841 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCUTbF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 15:31:05 -0400
Date:   Sat, 21 Mar 2020 21:35:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584819063;
        bh=MvmU5kwlpWyx5E7JUzXu7SxsG7U8nfCpmoM8LcX9xoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0Flj+1QhVQMEFdpJ7SCNjCLElcpftQ0lCjV0EecP2Gb20Rw5HtkywpaNZaNqbq0M
         Sxwv5k3bD5SlD8tuEZM+nDhzkKfYxeE1559b2FjyiBBGSGdQCUULVUcXXs25OyjmIQ
         vEqNWEBW9GXKq/IlwGqDZ4BlApxX4glj/jpBvz38k/rVjH2iUzoNDNgKYjOskmhq76
         fI9HlKBORmKzArJ/WNuAd/UX3QRMMeXkkANQ87b0mM/vwy8R+joouYf2bnDFlobsRQ
         h6kyIwasJg4Td/aX3qUNl01sszpIasREOV8fCBWAqK7KCkKzED2Pey66DqT8UBoIs1
         TQrPiklu4LAfA==
From:   Alexandru Lazar <alazar@startmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Message-ID: <20200321193541.GA16892@leena.republic>
References: <20200320150114.9297-1-alazar@startmail.com>
 <20200320150114.9297-2-alazar@startmail.com>
 <20200321173412.52548ef1@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321173412.52548ef1@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

> Please consider also adding the vdd-supply.
> It's not really required, but if you don't add it from the start
> chances are high that at some point someone else will need to
> add it.

Sorry if I'm missing something obvious here -- what vdd-supply is
that? Are you thinking of the regulator used for the ADC's reference
voltage? That's already there (vref-supply).

Or did you mean I should add a definition for the regulator output used
for the device's Vdd input (i.e. the positive supply voltage)? Needless
to say, I'm happy to add it if you think it's a good idea. It's just I
don't think I've seen it in other drivers (except maybe ad7192?) -- so I
figured I'd ask before sending a botched v5.

Best regards,
Alex

> 
> One trivial thing inline.  Otherwise looks good to me.
> 
> > ---
> >  .../bindings/iio/adc/maxim,max1241.yaml       | 61 +++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> > new file mode 100644
> > index 000000000000..de41d422ce3b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright 2020 Ioan-Alexandru Lazar
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/maxim,max1241.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX1241 12-bit, single-channel analog to digital converter
> > +
> > +maintainers:
> > +  - Ioan-Alexandru Lazar <alazar@startmail.com>
> > +
> > +description: |
> > +  Bindings for the max1241 12-bit, single-channel ADC device. This
> > +  driver supports voltage reading and can optionally be configured for
> 
> Driver shouldn't be mentioned in the binding. It's a description of the
> hardware only.
> 
> > +  power-down mode operation. The datasheet can be found at:
> > +    https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max1241
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description:
> > +      Device tree identifier of the regulator that provides the external
> > +      reference voltage.
> > +    maxItems: 1
> > +
> > +  shdn-gpios:
> > +    description:
> > +      GPIO spec for the GPIO pin connected to the ADC's /SHDN pin. If
> > +      specified, the /SHDN pin will be asserted between conversions,
> > +      thus enabling power-down mode.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi0 {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            compatible = "maxim,max1241";
> > +            reg = <0>;
> > +            vref-supply = <&vdd_3v3_reg>;
> > +            spi-max-frequency = <1000000>;
> > +            shdn-gpios = <&gpio 26 1>;
> > +        };
> > +    };
> > +
> > +
> 
