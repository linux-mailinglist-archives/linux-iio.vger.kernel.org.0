Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2652918AE
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 19:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgJRRoA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 13:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRRn7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 13:43:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF492080D;
        Sun, 18 Oct 2020 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603043039;
        bh=oxlJDyFOgmEee1yZzOJe7KdnKZ7+LB7NYjpTWhxehE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mwKQbhM8QWlkbl2gwmpubIXF4MK2KvsKbQsMzBFCBr2sRA/3m4CEPA2hibYeovKUj
         W8sE4pToSyEuZhF90SZcfIl6N5rYUgqBquDLIg9P6Yq41pmkSNmSTrgJuT+HhFKVzO
         2AAU6nrA26qIvntRvwA/aywYmwSkXBvsoG7Gldhc=
Date:   Sun, 18 Oct 2020 18:43:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 17/29] dt-bindings:iio:dac:adi,ad7303 yaml conversion
Message-ID: <20201018184355.29f710b6@archlinux>
In-Reply-To: <04fb4d49-1a7f-e8d7-09a8-bb57630b6a16@metafoo.de>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-18-jic23@kernel.org>
        <04fb4d49-1a7f-e8d7-09a8-bb57630b6a16@metafoo.de>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Oct 2020 19:13:32 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/11/20 7:07 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Converted to maintain the requirement for Vdd-supply as per original file.
> > It is possible we could relax this requirement to make it at least one
> > of Vdd-supply and REF-supply.  We need to establish the scaling of the
> > output channel and if REF-supply is provided that is used instead of
> > Vdd-supply, hence I cannot see why a dummy regulator cannot be used for
> > Vdd-supply if this happens.
> >
> > For now, let us keep it simple.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >   .../devicetree/bindings/iio/dac/ad7303.txt    | 23 ---------
> >   .../bindings/iio/dac/adi,ad7303.yaml          | 51 +++++++++++++++++++
> >   2 files changed, 51 insertions(+), 23 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ad7303.txt b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
> > deleted file mode 100644
> > index 914610f0556e..000000000000
> > --- a/Documentation/devicetree/bindings/iio/dac/ad7303.txt
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -Analog Devices AD7303 DAC device driver
> > -
> > -Required properties:
> > -	- compatible: Must be "adi,ad7303"
> > -	- reg: SPI chip select number for the device
> > -	- spi-max-frequency: Max SPI frequency to use (< 30000000)
> > -	- Vdd-supply: Phandle to the Vdd power supply
> > -
> > -Optional properties:
> > -	- REF-supply: Phandle to the external reference voltage supply. This should
> > -	  only be set if there is an external reference voltage connected to the REF
> > -	  pin. If the property is not set Vdd/2 is used as the reference voltage.
> > -
> > -Example:
> > -
> > -		ad7303@4 {
> > -			compatible = "adi,ad7303";
> > -			reg = <4>;
> > -			spi-max-frequency = <10000000>;
> > -			Vdd-supply = <&vdd_supply>;
> > -			adi,use-external-reference;
> > -			REF-supply = <&vref_supply>;
> > -		};
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml
> > new file mode 100644
> > index 000000000000..f76c31bf6ee3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad7303.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7303 DAC
> > +
> > +maintainers:
> > +  - Lars-Peter Clausen <lars@metafoo.de>
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,ad7303
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  Vdd-supply:
> > +    description:
> > +      Used to calculate output channel scalling if REF-supply not specified.
> > +  REF-supply:
> > +    description:
> > +      If not provided, Vdd/2 is used as the reference voltage.
> > +
> > +  spi-max-frequency:
> > +    maximum: 30000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - Vdd-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dac@4 {
> > +            compatible = "adi,ad7303";
> > +            reg = <4>;
> > +            spi-max-frequency = <10000000>;
> > +            Vdd-supply = <&vdd_supply>;
> > +            adi,use-external-reference;  
> This is a bug in the original example. But might as well take this as 
> chance to remove the 'adi,use-external-reference' here, since that 
> property does not exist.
Good point. Will fix in v2.

Thanks,

Jonathan

> > +            REF-supply = <&vref_supply>;
> > +        };
> > +    };
> > +...  
> 
> 

