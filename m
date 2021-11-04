Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD344599A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 19:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhKDSYx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 4 Nov 2021 14:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234121AbhKDSYx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Nov 2021 14:24:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E97B7611EF;
        Thu,  4 Nov 2021 18:22:12 +0000 (UTC)
Date:   Thu, 4 Nov 2021 18:26:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
Message-ID: <20211104182647.29ae2bc4@jic23-huawei>
In-Reply-To: <CY4PR03MB3399682ABFC08090528FED2C9B8C9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
        <20211101100420.70304-2-antoniu.miclaus@analog.com>
        <YYF6cPSDroPz/wun@robh.at.kernel.org>
        <CY4PR03MB3399E5DC1D8A966C7CFC8C049B8C9@CY4PR03MB3399.namprd03.prod.outlook.com>
        <CY4PR03MB3399682ABFC08090528FED2C9B8C9@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Nov 2021 14:30:56 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> Example:
> In the setup that we tested the driver, we had a clock chip that was hardware-routed only to the positive side of the local oscillator input (LOP pin) from admv1013.
> 
> Therefore, I think keeping the property in the DT might be useful.

I think Rob's question was more general than that one property... See below.
> 
> Regards,
> --
> Antoniu Miclăuş
> 
> > -----Original Message-----
> > From: Miclaus, Antoniu
> > Sent: Wednesday, November 3, 2021 10:09 AM
> > To: Rob Herring <robh@kernel.org>
> > Cc: jic23@kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Sa, Nuno <Nuno.Sa@analog.com>
> > Subject: RE: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
> > 
> > Hello Rob,
> > 
> > These properties are fixed and available in the datasheet (binary format):
> > https://www.analog.com/media/en/technical-documentation/data-
> > sheets/ADMV1013.pdf
> > 
> > Please see Page 37 of 39, Table 15, QUAD_SE_MODE.
> > 
> > Regards,
> > --
> > Antoniu Miclăuş
> >   
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Tuesday, November 2, 2021 7:51 PM
> > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > > Cc: jic23@kernel.org; linux-iio@vger.kernel.org;  
> > devicetree@vger.kernel.org;  
> > > linux-kernel@vger.kernel.org; Sa, Nuno <Nuno.Sa@analog.com>
> > > Subject: Re: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
> > >
> > > [External]
> > >
> > > On Mon, Nov 01, 2021 at 12:04:20PM +0200, Antoniu Miclaus wrote:  
> > > > Add device tree bindings for the ADMV1013 Upconverter.
> > > >
> > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > ---
> > > >  .../bindings/iio/frequency/adi,admv1013.yaml  | 119  
> > > ++++++++++++++++++  
> > > >  1 file changed, 119 insertions(+)
> > > >  create mode 100644  
> > > Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml  
> > > >
> > > > diff --git  
> > > a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > > b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml  
> > > > new file mode 100644
> > > > index 000000000000..47993253a586
> > > > --- /dev/null
> > > > +++  
> > > b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml  
> > > > @@ -0,0 +1,119 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:  
> > >  
> > https://urldefense.com/v3/__http://devicetree.org/schemas/iio/frequency  
> > >  
> > /adi,admv1013.yaml*__;Iw!!A3Ni8CS0y2Y!uTDPalOgj6YS_vZ6bsDSbA_Qna6Q  
> > > OwMpoRxzo6nn06i5TNuGWZEk9PvtbC6SKQGXrugy$  
> > > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-  
> > >  
> > schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!uTDPalOgj6YS_vZ6bsDSbA_Qna6Q  
> > > OwMpoRxzo6nn06i5TNuGWZEk9PvtbC6SKYugV1fM$  
> > > > +
> > > > +title: ADMV1013 Microwave Upconverter
> > > > +
> > > > +maintainers:
> > > > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > +
> > > > +description: |
> > > > +   Wideband, microwave upconverter optimized for point to point  
> > > microwave  
> > > > +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> > > > +
> > > > +   https://www.analog.com/en/products/admv1013.html
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,admv1013
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  spi-max-frequency:
> > > > +    maximum: 1000000
> > > > +
> > > > +  clocks:
> > > > +    description:
> > > > +      Definition of the external clock.
> > > > +    minItems: 1
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: lo_in
> > > > +
> > > > +  clock-output-names:
> > > > +    maxItems: 1
> > > > +
> > > > +  vcm-supply:
> > > > +    description:
> > > > +      Analog voltage regulator.
> > > > +
> > > > +  adi,vga-powerdown:
> > > > +    description:
> > > > +      Power Down the Voltage Gain Amplifier Circuit available at
> > > > +      BG_RBIAS2 pin.
> > > > +    type: boolean

What wiring would make it sensible to always have this powered down?
If we can describe that rather than vga-powerdown then that is what should
be in the binding.  If there isn't any wiring based justification and this
is just turning off part of the device, then it should not be in the binding.

> > > > +
> > > > +  adi,mixer-powerdown:
> > > > +    description:
> > > > +      Power Down the Mixer Circuit. Enable to put the block in
> > > > +      a power down state.

Same for all these other power downs.

> > > > +    type: boolean
> > > > +
> > > > +  adi,quad-powerdown:
> > > > +    description:
> > > > +      Power Down the Quadrupler. Enable to put the block in
> > > > +      a power down state.
> > > > +    type: boolean
> > > > +
> > > > +  adi,bg-powerdown:
> > > > +    description:
> > > > +      Power Down the Transmitter Band Gap. Enable to put the part in
> > > > +      a power down state.
> > > > +    type: boolean
> > > > +
> > > > +  adi,mixer-if-enable:
> > > > +    description:
> > > > +      Enable the Intermediate Frequency Mode. Either IF Mode or I/Q  
> > Mode  
> > > > +      can be enabled at a time.
> > > > +    type: boolean
> > > > +
> > > > +  adi,detector-enable:
> > > > +    description:
> > > > +      Enable the Envelope Detector available at output pins VENV_P and
> > > > +      VENV_N. Disable to reduce power consumption.
> > > > +    type: boolean
> > > > +
> > > > +  adi,quad-se-mode:
> > > > +    description:
> > > > +      Switch the LO path from differential to single-ended operation.
> > > > +      Set value 6 for Single-Ended Mode, Negative Side Disabled.
> > > > +      Set value 9 for Single-Ended Mode, Positive Side Disabled.
> > > > +      Set value 12 for Differential Mode.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [6, 9, 12]  
> > >
> > > All these vendor properties are fixed based on the board design or
> > > something a user may want to change? The latter does not belong in DT.
> > >
> > > Rob  

