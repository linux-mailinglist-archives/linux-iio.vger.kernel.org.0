Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E51E477317
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 14:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhLPN10 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 08:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhLPN10 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 08:27:26 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD99C061574;
        Thu, 16 Dec 2021 05:27:26 -0800 (PST)
Received: from [81.101.6.87] (port=48026 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxqn2-0002Bd-DT; Thu, 16 Dec 2021 13:27:24 +0000
Date:   Thu, 16 Dec 2021 13:32:37 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Rob Herring <robh@kernel.org>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: Add ltc2688 documentation
Message-ID: <20211216133225.6bdb14fe@jic23-huawei>
In-Reply-To: <YbpefZY2lqtgLpUV@robh.at.kernel.org>
References: <20211214165608.7903-1-nuno.sa@analog.com>
        <20211214165608.7903-4-nuno.sa@analog.com>
        <YbpefZY2lqtgLpUV@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Dec 2021 15:30:37 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Dec 14, 2021 at 05:56:08PM +0100, Nuno Sá wrote:
> > Document the LTC2688 devicetree properties.
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  .../bindings/iio/dac/adi,ltc2688.yaml         | 146 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 147 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> > new file mode 100644
> > index 000000000000..7919cd8ec7c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> > @@ -0,0 +1,146 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2688.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices LTC2688 DAC
> > +
> > +maintainers:
> > +  - Nuno Sá <nuno.sa@analog.com>
> > +
> > +description: |
> > +  Analog Devices LTC2688 16 channel, 16 bit, +-15V DAC
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2688.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ltc2688
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vcc-supply:
> > +    description: Analog Supply Voltage Input.
> > +
> > +  iovcc-supply:
> > +    description: Digital Input/Output Supply Voltage.
> > +
> > +  vref-supply:
> > +    description:
> > +      Reference Input/Output. The voltage at the REF pin sets the full-scale
> > +      range of all channels. By default, the internal reference is routed to
> > +      this pin.
> > +
> > +  reset-gpios:
> > +    description:
> > +      If specified, it will be asserted during driver probe. As the line is
> > +      active low, it should be marked GPIO_ACTIVE_LOW.
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      enum: [TGP1, TGP2, TGP3]  
> 
> pattern: '^TGP[1-3]$'
> 
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^channel@([0-9]|1[0-5])$":
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number representing the DAC output channel.
> > +        maximum: 15
> > +
> > +      adi,toggle-mode:
> > +        description:
> > +          Set the channel as a toggle enabled channel. Toggle operation enables
> > +          fast switching of a DAC output between two different DAC codes without
> > +          any SPI transaction. It will result in a different ABI for the
> > +          channel.
> > +        type: boolean
> > +
> > +      adi,output-range-millivolt:  
> 
> Not one of the defined units. Use '-microvolt'

> > +        description:
> > +          Specify the channel output full scale range. Allowed values are
> > +            <0 5000>
> > +            <0 10000>
> > +            <-5000 5000>
> > +            <-10000 10000>
> > +            <-15000 15000>  
> 
> Looks like constraints.
> 
> items:
>   - enum: [ -15000, -10000, -5000, 0 ]
>   - enum: [ 5000, 10000, 15000 ]
> 
> though that will need to all be x1000.

also should be constrained to allowed combinations which probably
means a oneOf construct.

> 
> > +        $ref: /schemas/types.yaml#/definitions/int32-array  
> 
> And drop the type.
> 
> > +
> > +      adi,overrange:
> > +        description: Enable 5% overrange over the selected full scale range.
> > +        type: boolean
> > +
> > +      adi,toggle-dither-input:
> > +        description:
> > +          Selects the TGPx pin to be associated with this channel. This setting
> > +          only makes sense for toggle or dither enabled channels. If
> > +          @adi,toggle-mode is not set and this property is given, the channel is
> > +          assumed to be a dither capable channel. Note that multiple channels
> > +          can be mapped to the same pin. If this setting is given, the
> > +          respective @clock must also be provided. Mappings between this and
> > +          clocks
> > +            0 - TGP1
> > +            1 - TGP2
> > +            2 - TGP3
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2]
> > +
> > +    required:
> > +      - reg
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> > +    spi {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +          ltc2688: ltc2688@0 {
> > +                  compatible = "adi,ltc2688";
> > +                  reg = <0>;
> > +
> > +                  vcc-supply = <&vcc>;
> > +                  iovcc-supply = <&vcc>;
> > +                  vref-supply = <&vref>;
> > +
> > +                  clocks = <&clock_tgp2>;
> > +                  clock-names = "TGP2";
> > +
> > +                  #address-cells = <1>;
> > +                  #size-cells = <0>;
> > +                  channel@0 {
> > +                          reg = <0>;
> > +                          adi,toggle-mode;
> > +                          adi,overrange;
> > +                  };
> > +
> > +                  channel@1 {
> > +                          reg = <1>;
> > +                          adi,output-range-millivolt = <(-10000) 10000>;
> > +                          adi,toggle-dither-input = <2>;
> > +                  };
> > +          };
> > +    };
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 61b1eaad4611..4ee2a1b6bf62 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11168,6 +11168,7 @@ L:	linux-iio@vger.kernel.org
> >  S:	Supported
> >  W:	http://ez.analog.com/community/linux-device-drivers
> >  F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
> > +F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> >  F:	drivers/iio/dac/ltc2688.c
> >  
> >  LTC2947 HARDWARE MONITOR DRIVER
> > -- 
> > 2.17.1
> > 
> >   

