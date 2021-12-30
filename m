Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F78481DC0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 16:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhL3Pi2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 30 Dec 2021 10:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhL3Pi2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 10:38:28 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DD2C061574;
        Thu, 30 Dec 2021 07:38:28 -0800 (PST)
Received: from [81.101.6.87] (port=45442 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n2xVV-0000iE-Fc; Thu, 30 Dec 2021 15:38:26 +0000
Date:   Thu, 30 Dec 2021 15:43:54 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: Add ltc2688 documentation
Message-ID: <20211230154354.06a54b7c@jic23-huawei>
In-Reply-To: <PH0PR03MB67866ABB9AE677429560125599789@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
        <20211214165608.7903-4-nuno.sa@analog.com>
        <YbpefZY2lqtgLpUV@robh.at.kernel.org>
        <20211216133225.6bdb14fe@jic23-huawei>
        <PH0PR03MB67866ABB9AE677429560125599789@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Dec 2021 09:09:30 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> > Sent: Thursday, December 16, 2021 2:33 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: Sa, Nuno <Nuno.Sa@analog.com>; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH 3/3] dt-bindings: iio: Add ltc2688 documentation
> > 
> > 
> > On Wed, 15 Dec 2021 15:30:37 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >   
> > > On Tue, Dec 14, 2021 at 05:56:08PM +0100, Nuno Sá wrote:  
> > > > Document the LTC2688 devicetree properties.
> > > >
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > >  .../bindings/iio/dac/adi,ltc2688.yaml         | 146  
> > ++++++++++++++++++  
> > > >  MAINTAINERS                                   |   1 +
> > > >  2 files changed, 147 insertions(+)
> > > >  create mode 100644  
> > Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml  
> > > >
> > > > diff --git  
> > a/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> > b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml  
> > > > new file mode 100644
> > > > index 000000000000..7919cd8ec7c9
> > > > --- /dev/null
> > > > +++  
> > b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml  
> > > > @@ -0,0 +1,146 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:  
> > https://urldefense.com/v3/__http://devicetree.org/schemas/iio/dac/
> > adi,ltc2688.yaml*__;Iw!!A3Ni8CS0y2Y!rHThZYvGYZfm2zOTRFsr1xH61Bf
> > mq371ojtDKEdpTSeC7lCU_dS7CnRBJvPcEQ$  
> > > > +$schema:  
> > https://urldefense.com/v3/__http://devicetree.org/meta-
> > schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!rHThZYvGYZfm2zOTRFsr1xH
> > 61Bfmq371ojtDKEdpTSeC7lCU_dS7CnSFhKxW0w$  
> > > > +
> > > > +title: Analog Devices LTC2688 DAC
> > > > +
> > > > +maintainers:
> > > > +  - Nuno Sá <nuno.sa@analog.com>
> > > > +
> > > > +description: |
> > > > +  Analog Devices LTC2688 16 channel, 16 bit, +-15V DAC
> > > > +  https://www.analog.com/media/en/technical-  
> > documentation/data-sheets/ltc2688.pdf  
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,ltc2688
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  vcc-supply:
> > > > +    description: Analog Supply Voltage Input.
> > > > +
> > > > +  iovcc-supply:
> > > > +    description: Digital Input/Output Supply Voltage.
> > > > +
> > > > +  vref-supply:
> > > > +    description:
> > > > +      Reference Input/Output. The voltage at the REF pin sets the  
> > full-scale  
> > > > +      range of all channels. By default, the internal reference is  
> > routed to  
> > > > +      this pin.
> > > > +
> > > > +  reset-gpios:
> > > > +    description:
> > > > +      If specified, it will be asserted during driver probe. As the line is
> > > > +      active low, it should be marked GPIO_ACTIVE_LOW.
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > > > +
> > > > +  clock-names:
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > > > +    items:
> > > > +      enum: [TGP1, TGP2, TGP3]  
> > >
> > > pattern: '^TGP[1-3]$'
> > >  
> > > > +
> > > > +  '#address-cells':
> > > > +    const: 1
> > > > +
> > > > +  '#size-cells':
> > > > +    const: 0
> > > > +
> > > > +patternProperties:
> > > > +  "^channel@([0-9]|1[0-5])$":
> > > > +    type: object
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        description: The channel number representing the DAC  
> > output channel.  
> > > > +        maximum: 15
> > > > +
> > > > +      adi,toggle-mode:
> > > > +        description:
> > > > +          Set the channel as a toggle enabled channel. Toggle  
> > operation enables  
> > > > +          fast switching of a DAC output between two different DAC  
> > codes without  
> > > > +          any SPI transaction. It will result in a different ABI for the
> > > > +          channel.
> > > > +        type: boolean
> > > > +
> > > > +      adi,output-range-millivolt:  
> > >
> > > Not one of the defined units. Use '-microvolt'  
> >   
> > > > +        description:
> > > > +          Specify the channel output full scale range. Allowed values  
> > are  
> > > > +            <0 5000>
> > > > +            <0 10000>
> > > > +            <-5000 5000>
> > > > +            <-10000 10000>
> > > > +            <-15000 15000>  
> > >
> > > Looks like constraints.
> > >
> > > items:
> > >   - enum: [ -15000, -10000, -5000, 0 ]
> > >   - enum: [ 5000, 10000, 15000 ]
> > >
> > > though that will need to all be x1000.  
> > 
> > also should be constrained to allowed combinations which probably
> > means a oneOf construct.
> >   
> 
> Exactly. AFICT, with Rob's suggestion things like <-15000 5000> would
> be validated but not really possible and the driver does not allow it. I did
> tried some stuff before sending this simplified form (constrains in description):
> 
> ...
> oneOf:
>   - items:
>       - const: 0
>       - enum: [5000, 10000]
>   - items:
>       - const: -5000
>       - const: 5000
> ...
> 
> Whiles things worked for <0 5000> and <0 10000>, they failed for <(-5000) 5000>:
> 
> "
> next/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.example.dt.y
> aml: ltc2688@0: channel@1:adi,output-range-millivolt: 'oneOf'
> conditional failed, one must be fixed:
> 	0 was expected
> 	-5000 was expected
> 	From schema: /home/nsa/work/linux-adi-
> next/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yam"
> 
> Trying this combination <0 (-5000)> led to:
> 
> "
> next/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.example.dt.y
> aml: ltc2688@0: channel@1:adi,output-range-microvolt: 'oneOf'
> conditional failed, one must be fixed:
> 	-5000 was expected
> 	4294962296 is not one of [5000, 10000]
> 	From schema: /home/nsa/work/linux-adi-
> next/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> "
> 
> it makes me feel that something is going on with signed/unsigned
> comparisons. But I might be completely off with this approach :)

I'll go with huh...

Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml

and other places have pretty much the same construct though examples
don't actually use it.

I have some vague recollection of a previous discussion about negatives
and that Rob had some plan to make them work long term. In the meantime
we just avoid them in the examples.

Rob, is my memory deceiving me?

Thanks,

Jonathan
 
> 
> - Nuno Sá
> 

