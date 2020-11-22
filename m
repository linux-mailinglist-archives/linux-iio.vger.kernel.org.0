Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A014A2BC77F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 18:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgKVR37 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 12:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgKVR37 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 12:29:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08E32075A;
        Sun, 22 Nov 2020 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606066198;
        bh=KHiYr26d4KIqwMBlSeWuMmyGDnreKmnwL9CYuDf2WRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=imIA5Gl+beOtobtTkg7DL5g++m8Zl1uLZNg5Bh92VWzNmuZI6vytKpf+mY1XhElN/
         +LuTem5fQMcPm6H3W358OMKoKMiFMhe9gCTaT0rGfyeODCacOMRaOkKe+t+3AM1nFk
         FyTKDeZY+EkFBggFhptcz3d1PVXI6HTyZlvmv/rE=
Date:   Sun, 22 Nov 2020 17:29:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH 10/46] dt-bindings:iio:health:maxim,max30102: txt to
 yaml conversion
Message-ID: <20201122172954.7ce312c2@archlinux>
In-Reply-To: <CAJCx=gk124hX7X2fWSySGfj=WL=f33XsdWiHwxs7Eq3aADoiwg@mail.gmail.com>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-11-jic23@kernel.org>
        <CAJCx=gk124hX7X2fWSySGfj=WL=f33XsdWiHwxs7Eq3aADoiwg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 14:38:29 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sat, Oct 31, 2020 at 11:51 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Straight forward binding.  Title was a bit of a challenge to keep short
> > as this binding covers sensors for two entirely different purposes.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <mranostay@gmail.com>
> > ---
> >  .../bindings/iio/health/max30102.txt          | 33 --------
> >  .../bindings/iio/health/maxim,max30102.yaml   | 75 +++++++++++++++++++
> >  2 files changed, 75 insertions(+), 33 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/health/max30102.txt b/Documentation/devicetree/bindings/iio/health/max30102.txt
> > deleted file mode 100644
> > index 7ef7ae40ae4f..000000000000
> > --- a/Documentation/devicetree/bindings/iio/health/max30102.txt
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -Maxim MAX30102 heart rate and pulse oximeter sensor
> > -Maxim MAX30105 optical particle-sensing module
> > -
> > -* https://datasheets.maximintegrated.com/en/ds/MAX30102.pdf
> > -* https://datasheets.maximintegrated.com/en/ds/MAX30105.pdf
> > -
> > -Required properties:
> > -  - compatible: must be "maxim,max30102" or "maxim,max30105"
> > -  - reg: the I2C address of the sensor
> > -  - interrupts: the sole interrupt generated by the device
> > -
> > -  Refer to interrupt-controller/interrupts.txt for generic
> > -  interrupt client node bindings.
> > -
> > -Optional properties:
> > -  - maxim,red-led-current-microamp: configuration for red LED current
> > -  - maxim,ir-led-current-microamp: configuration for IR LED current
> > -  - maxim,green-led-current-microamp: configuration for green LED current
> > -    (max30105 only)
> > -
> > -    Note that each step is approximately 200 microamps, ranging from 0 uA to
> > -    50800 uA.
> > -
> > -Example:
> > -
> > -max30102@57 {
> > -       compatible = "maxim,max30102";
> > -       reg = <0x57>;
> > -       maxim,red-led-current-microamp = <7000>;
> > -       maxim,ir-led-current-microamp = <7000>;
> > -       interrupt-parent = <&gpio1>;
> > -       interrupts = <16 2>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> > new file mode 100644
> > index 000000000000..67d40f4a91a7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/health/maxim,max30102.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX30102 heart rate and pulse oximeter and MAX30105 particle-sensor
> > +
> > +maintainers:
> > +  - Matt Ranostay <mranostay@gmail.com>  
> 
> Change to my Konsulko email please, otherwise LGTM
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Done and this time I can drop the refs as per Rob's suggestion
as there isn't any interaction with minItems / maxItems.

Jonathan

> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max30102
> > +      - maxim,max30105
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Connected to ADC_RDY pin.
> > +
> > +  maxim,red-led-current-microamp:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: RED LED current. Each step is approximately 200 microamps.
> > +    minimum: 0
> > +    maximum: 50800
> > +
> > +  maxim,ir-led-current-microamp:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: IR LED current. Each step is approximately 200 microamps.
> > +    minimum: 0
> > +    maximum: 50800
> > +
> > +  maxim,green-led-current-microamp:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Green LED current. Each step is approximately 200 microamps.
> > +    minimum: 0
> > +    maximum: 50800
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: maxim,max30100
> > +    then:
> > +      properties:
> > +        maxim,green-led-current-microamp: false
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        heart-rate@57 {
> > +            compatible = "maxim,max30102";
> > +            reg = <0x57>;
> > +            maxim,red-led-current-microamp = <7000>;
> > +            maxim,ir-led-current-microamp = <7000>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <16 2>;
> > +        };
> > +    };
> > +...
> > --
> > 2.28.0
> >  

