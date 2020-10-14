Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C44128DC29
	for <lists+linux-iio@lfdr.de>; Wed, 14 Oct 2020 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgJNI57 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Oct 2020 04:57:59 -0400
Received: from hosting.pavoucek.net ([46.28.107.168]:43665 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJNI57 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2020 04:57:59 -0400
Received: from tomas.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id E1A2B103CB9;
        Wed, 14 Oct 2020 10:57:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net E1A2B103CB9
Date:   Wed, 14 Oct 2020 10:57:56 +0200
From:   Tomas Novotny <tomas@novotny.cz>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH 20/29] dt-bindings:iio:dac:microchip,mcp4725 yaml
 conversion
Message-ID: <20201014105756.04cc4ae1@tomas.local.tbs-biometrics.cz>
In-Reply-To: <20201012143923.000023d8@Huawei.com>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-21-jic23@kernel.org>
        <20201012160230.7a0c5eb8@tomas.local.tbs-biometrics.cz>
        <20201012143923.000023d8@Huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Mon, 12 Oct 2020 15:39:23 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 12 Oct 2020 16:02:30 +0200
> Tomas Novotny <tomas@novotny.cz> wrote:
> 
> > Hi Jonathan,
> > 
> > On Sun, 11 Oct 2020 18:07:40 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > I'm not sure vdd-supply absolutely has to be provided if vref-supply
> > > is, but as the previous binding docs stated it was required it seems
> > > reasonable to leave it as such.    
> > 
> > Good catch. Vdd is useless on MCP4726 if Vref is specified. The driver
> > requires Vdd...  
> 
> The driver will get the regulator but as it's not via an optional
> call it the regulator core will provide a stub regulator.
> If the ref regulator is present, all that will happen with vdd is
> a regulator_enable() call which is fine with a stub regulator (it's
> a noop).   So we should be good to update the binding to specify
> the requirement.   Perhaps it's one to do as a follow up patch?
> Given any existing DT must be providing that regulator, there is
> no rush for us to fix it :)

ok, I see, I will handle with a follow up patch when this will be merged.
Thanks,

Tomas

> > How to proceed there?
> > 
> > Thanks,
> > 
> > Tomas
> >   
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc:  Tomas Novotny <tomas@novotny.cz>
> > > ---
> > >  .../devicetree/bindings/iio/dac/mcp4725.txt   | 35 ---------
> > >  .../bindings/iio/dac/microchip,mcp4725.yaml   | 71 +++++++++++++++++++
> > >  2 files changed, 71 insertions(+), 35 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/mcp4725.txt b/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
> > > deleted file mode 100644
> > > index 1bc6c093fbfe..000000000000
> > > --- a/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
> > > +++ /dev/null
> > > @@ -1,35 +0,0 @@
> > > -Microchip mcp4725 and mcp4726 DAC device driver
> > > -
> > > -Required properties:
> > > -	- compatible: Must be "microchip,mcp4725" or "microchip,mcp4726"
> > > -	- reg: Should contain the DAC I2C address
> > > -	- vdd-supply: Phandle to the Vdd power supply. This supply is used as a
> > > -	  voltage reference on mcp4725. It is used as a voltage reference on
> > > -	  mcp4726 if there is no vref-supply specified.
> > > -
> > > -Optional properties (valid only for mcp4726):
> > > -	- vref-supply: Optional phandle to the Vref power supply. Vref pin is
> > > -	  used as a voltage reference when this supply is specified.
> > > -	- microchip,vref-buffered: Boolean to enable buffering of the external
> > > -	  Vref pin. This boolean is not valid without the vref-supply. Quoting
> > > -	  the datasheet: This is offered in cases where the reference voltage
> > > -	  does not have the current capability not to drop its voltage when
> > > -	  connected to the internal resistor ladder circuit.
> > > -
> > > -Examples:
> > > -
> > > -	/* simple mcp4725 */
> > > -	mcp4725@60 {
> > > -		compatible = "microchip,mcp4725";
> > > -		reg = <0x60>;
> > > -		vdd-supply = <&vdac_vdd>;
> > > -	};
> > > -
> > > -	/* mcp4726 with the buffered external reference voltage */
> > > -	mcp4726@60 {
> > > -		compatible = "microchip,mcp4726";
> > > -		reg = <0x60>;
> > > -		vdd-supply = <&vdac_vdd>;
> > > -		vref-supply = <&vdac_vref>;
> > > -		microchip,vref-buffered;
> > > -	};
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
> > > new file mode 100644
> > > index 000000000000..271998610ceb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
> > > @@ -0,0 +1,71 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4725.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Microchip mcp4725 and mcp4726 DAC
> > > +
> > > +maintainers:
> > > +  - Tomas Novotny <tomas@novotny.cz>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - microchip,mcp4725
> > > +      - microchip,mcp4726
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  vdd-supply:
> > > +    description: |
> > > +      Provides both power and acts as the reference supply on the mcp4725.
> > > +      For the mcp4726 it will be used as the reference voltage if vref-supply
> > > +      is not provided.
> > > +
> > > +  vref-supply:
> > > +    description:
> > > +      Vref pin is used as a voltage reference when this supply is specified.
> > > +
> > > +  microchip,vref-buffered:
> > > +    type: boolean
> > > +    description: |
> > > +      Enable buffering of the external Vref pin. This boolean is not valid
> > > +      without the vref-supply. Quoting the datasheet: This is offered in
> > > +      cases where the reference voltage does not have the current
> > > +      capability not to drop its voltage when connected to the internal
> > > +      resistor ladder circuit.
> > > +
> > > +allOf:
> > > +  - if:
> > > +      not:
> > > +        properties:
> > > +          compatible:
> > > +            contains:
> > > +              const: microchip,mcp4726
> > > +    then:
> > > +      properties:
> > > +        vref-supply: false
> > > +        microchip,vref-buffered: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - vdd-supply
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        mcp4725@60 {
> > > +            compatible = "microchip,mcp4725";
> > > +            reg = <0x60>;
> > > +            vdd-supply = <&vdac_vdd>;
> > > +        };
> > > +    };
> > > +...    
> 
> 
