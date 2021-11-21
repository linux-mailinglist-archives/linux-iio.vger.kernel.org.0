Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9E2458345
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 13:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbhKUMXG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 21 Nov 2021 07:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238114AbhKUMXF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 07:23:05 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6010160E54;
        Sun, 21 Nov 2021 12:19:58 +0000 (UTC)
Date:   Sun, 21 Nov 2021 12:24:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
Message-ID: <20211121122451.569e41f5@jic23-huawei>
In-Reply-To: <CY4PR03MB339956D5EAA5D20C9D6579419B999@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
        <20211109123127.96399-4-antoniu.miclaus@analog.com>
        <20211112174601.3c1f6b4b@jic23-huawei>
        <CY4PR03MB339956D5EAA5D20C9D6579419B999@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Nov 2021 14:43:14 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> Hello Jonathan,
> 
> --
> Antoniu Miclăuş
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Friday, November 12, 2021 7:46 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: robh+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
> > 
> > [External]
> > 
> > On Tue, 9 Nov 2021 14:31:26 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >   
> > > Add device tree bindings for the ADMV8818 Filter.
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > >  .../bindings/iio/filter/adi,admv8818.yaml     | 78 +++++++++++++++++++
> > >  1 file changed, 78 insertions(+)
> > >  create mode 100644  
> > Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml  
> > >
> > > diff --git  
> > a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml  
> > > new file mode 100644
> > > index 000000000000..d581e236dbdc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > > @@ -0,0 +1,78 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:  
> > https://urldefense.com/v3/__http://devicetree.org/schemas/iio/filter/adi,a
> > dmv8818.yaml*__;Iw!!A3Ni8CS0y2Y!qkKokhmcgS0YEIy3uC6OfOOF7Bq3yE_r
> > Ny91yIkDRTXFe54x-cHq_BtsyzDOedLohB5D$  
> > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-  
> > schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!qkKokhmcgS0YEIy3uC6OfOOF7Bq3
> > yE_rNy91yIkDRTXFe54x-cHq_BtsyzDOeYdHtx0a$  
> > > +
> > > +title: ADMV8818 Digitally Tunable, High-Pass and Low-Pass Filter
> > > +
> > > +maintainers:
> > > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > +
> > > +description: |
> > > +    Fully monolithic microwave integrated circuit (MMIC) that
> > > +    features a digitally selectable frequency of operation.
> > > +    The device features four independently controlled high-pass
> > > +    filters (HPFs) and four independently controlled low-pass filters
> > > +    (LPFs) that span the 2 GHz to 18 GHz frequency range.
> > > +
> > > +    https://www.analog.com/en/products/admv8818.html
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,admv8818
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 10000000
> > > +
> > > +  clocks:
> > > +    description:
> > > +      Definition of the external clock.
> > > +    minItems: 1
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: "rf_in"  
> > 
> > Is this what we'd normally think of as a clock signal?  I'd not expect
> > a nice squarewave on that pin for example so this seems an odd way to
> > define it.
> >   
> The only actual use of this part, until now, was to filter the output of the following part:
> https://www.analog.com/en/products/adf5610.html
> This is the reason of using the clock framework in the driver. Moreover, the clock input is
> optional inside the driver.

OK, so in theory that part is generating a sinusoid. I guess the clk framework works for
handling such devices, even if it's not typically what people expect from a clk.

> > > +
> > > +  clock-output-names:
> > > +    maxItems: 1
> > > +
> > > +  adi,bw-hz:
> > > +    description:
> > > +      Allows the user to increase the Bandpass Filter (BPF) bandwidth
> > > +      in Hz. Normally when invoked by the clk notifier, the driver
> > > +      sets the HPF cutoff close below the frequency and the LPF cutoff
> > > +      close above the frequency, and thus creating a BPF.  
> > 
> > I don't understand this item at all.  Why do we need a control to
> > basically change how the other filter parameters are expressed?
> >   
> 
> Indeed, this property was requested by the users of the application in which this part was involved.
> Same goes for the filter modes and the bandwidth in the ABI documentation.
> 
> If you think these attributes/properties are way too custom, I can drop them.

It's interesting.  I guess the point here is people want a nice autonomous system to
keep the filter set appropriately for cleaning up a generated sine wave.

It could be argued that is a hardware related thing so makes sense in DT.

We are sort of 'emulating' a bandpass filter in the driver if we use this, but
I guess if that's the main use case then this is perhaps a reasonable decision.
> 
> Let me know your thoughts.
> > > +    $ref: /schemas/types.yaml#/definitions/uint64
> > > +
> > > +  '#clock-cells':
> > > +    const: 0
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    spi {
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +      admv8818@0 {
> > > +        compatible = "adi,admv8818";
> > > +        reg = <0>;
> > > +        spi-max-frequency = <10000000>;
> > > +        clocks = <&admv8818_rfin>;
> > > +        clock-names = "rf_in";
> > > +        adi,bw-hz = /bits/ 64 <600000000>;
> > > +      };
> > > +    };
> > > +...
> > > +  
> 

