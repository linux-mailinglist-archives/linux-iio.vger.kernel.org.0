Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3880A2E723B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 17:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgL2QUY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 11:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgL2QUY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 11:20:24 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99A3207CF;
        Tue, 29 Dec 2020 16:19:42 +0000 (UTC)
Date:   Tue, 29 Dec 2020 16:19:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20201229161939.7860f1b1@archlinux>
In-Reply-To: <20201221184434.GA331914@robh.at.kernel.org>
References: <20201218171231.58794-1-cristian.pop@analog.com>
        <20201221184434.GA331914@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Dec 2020 11:44:34 -0700
Rob Herring <robh@kernel.org> wrote:

> On Fri, Dec 18, 2020 at 07:12:29PM +0200, Cristian Pop wrote:
> > This adds device tree bindings for the AD5766 DAC.
> > 
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> >  Changelog v4:
> > 	- Add range selection
> > 	- Reset is GPIO_ACTIVE_LOW
> > 	
> >  .../bindings/iio/dac/adi,ad5766.yaml          | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> > new file mode 100644
> > index 000000000000..846b5ee50761
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2020 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5766.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5766 DAC device driver
> > +
> > +maintainers:
> > +  - Cristian Pop <cristian.pop@analog.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices AD5766 current DAC device. Datasheet can be
> > +  found here:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad5766-5767.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad5766
> > +      - adi,ad5767
> > +
> > +  output-range:
> > +    description: Select converter output range.  
> 
> Something standard for DACs? If not needs a vendor prefix and type. 

Hmm. It's a common enough thing that we could think about standardizing
it but it would need units in the naming.

output-range-volts

and promoting to a higher level in the DT bindings docs than the individual
driver.

We almost certainly have a bunch of preexisting bindings using manufacturer
specific equivalents.  I've not be completely consistent on this so have
encouraged separate max / min attributes but with hind sight I two value
version like this probably makes more sense in a DT binding (not so much
if userspace is controlling it).


> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 1000000
> > +
> > +  spi-cpol: true
> > +
> > +  reset-gpios:
> > +    description: GPIO spec for the RESET pin. If specified, it will be asserted
> > +      during driver probe. As the line is active low, it should be marked
> > +      GPIO_ACTIVE_LOW.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - output-range
> > +  - reg
> > +  - spi-max-frequency
> > +  - spi-cpol
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +          
> > +          ad5766@0 {
> > +              compatible = "adi,ad5766";
> > +              output-range = <(-5) 5>;
> > +              reg = <0>;
> > +              spi-cpol;
> > +              spi-max-frequency = <1000000>;
> > +              reset-gpios = <&gpio 22 0>;
> > +            };
> > +      };
> > -- 
> > 2.17.1
> >   

