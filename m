Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B328381EC3
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 14:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhEPMc0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 08:32:26 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:55224 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhEPMcX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 08:32:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 10E8A123FB1;
        Sun, 16 May 2021 14:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1621168264;
        bh=gItPiLbgsq5Pc2gLAyoyfRNvG8QZDPfhQdAxTT8wlAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUnvVREEelzZF3+WS625AK0Kvt6qnlFyIhifoZahs4DH1Z8Q7576UVPGy0CM4V1uB
         /vA6LDzDqLD19iMXejCu+OpcJhYOnOjq/ZTd0A4kAqq8AsXIb0kXQLvm1a9KBaGPjF
         nVtvcQs1PddCxo4S2krxt3q32K9UVI1kKFgmAhIo9KHK9GPUp3TX3K2qZJqR1Gm2sd
         lEwny7hYVTIrpxsSa/40d/CzpKphFut/3SUSSUyMJFCYTi4JeG8L1I4syyZmRaJyU8
         FmW7j/h7/ReNySjCI5QixDexa5d3E4tIKaYD1ZOjCxlQR38Lft+mS+V+rmsrlMtUEh
         jJYJBom01CRHQ==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tn3TxwOs_J-k; Sun, 16 May 2021 14:30:31 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 929B1123FA7;
        Sun, 16 May 2021 14:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1621168231;
        bh=gItPiLbgsq5Pc2gLAyoyfRNvG8QZDPfhQdAxTT8wlAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhyPaxNPEGcZArozbdNC7ixV+F/JWcNmU8GW/R/iwFudbyYWx0gbH1YvBmZWxvSZO
         uZ/t0ou1cVDHe38yAYPAJBGXuM9io6V6QtLbB1HMMbxb9SEtMtNMHjPhdc4pNaAchz
         LK/vlbe4E1EEHUDMOwYD+B2vJEhF9o/ao5AO8pi+Ok06+spsNBOSQW5VsS9NIrklde
         urQxwJuBj6JIRvwgBpEBy1w+KSuV8QDIJRUwPuNVDpeB9iOq5RCaZf49wvkegdw13O
         KUeCl7TTLGWx/scgNRdfRwzEo68UbxcbOBKQ6qMFCLsGUc0d6HGz0v1SCOw2YHZSEk
         eaTDpSt+GRaeQ==
Date:   Sun, 16 May 2021 12:30:28 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Gene Chen <gene_chen@richtek.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: devicetree bindings for
 texas instruments ads7142
Message-ID: <20210516123027.GA16211@dev>
References: <9f9c64ca70f80d8a024ea66e3963350e35f27c1d.1621105931.git.info@ministro.hu>
 <a8200f9ce6a4b3fdf5a9b1e61bbc7c4ced8361b6.1621105931.git.info@ministro.hu>
 <20210516105720.2b9cf46a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210516105720.2b9cf46a@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, May 16, 2021 at 10:57:20AM +0100, Jonathan Cameron wrote:
> On Sun, 16 May 2021 07:31:05 +0000
> Jozsef Horvath <info@ministro.hu> wrote:
> 
> > This is a device tree schema for iio driver for
> >  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
> > 
> > Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > 
> > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> 
> Hi József,
> 
> A few comments inline.
> 
> thanks,
> 
> Jonathan
> > ---
> > 
> > changes v1
> >   - Redundant parameters (ti,threshold-rising, etc.)
> >     are removed
> >   - Supply name changed(vref -> avdd)
> >   - Added dvdd supply
> >   - All the properties are removed with prefix "ti,"
> > changes v2
> >   - "ti,prealert-count" parameter added, just for completeness.
> > ---
> >  .../bindings/iio/adc/ti,ads7142.yaml          | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> > new file mode 100644
> > index 000000000000..6e52079c68f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/iio/adc/ti,ads7142.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Texas Instruments ADS7142 adc driver device tree bindings
> 
> ADC
> 
> > +
> > +maintainers:
> > +  - József Horváth <info@ministro.hu>
> > +
> > +description: |
> > +  This document is for describing the required device tree parameters
> > +   for ads7142 adc
> 
> ADC
> 
> > +  The required parameters for proper operation are described below.
> > +
> > +  Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,ads7142
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: |
> > +      The BUSY/PDY pin is used as interrupt line
> 
> RDY ?

I'll fix these typos in v3

> 
> > +       in autonomous monitoring mode.
> > +    maxItems: 1
> > +
> > +  avdd-supply:
> > +    description: Regulator for the reference voltage
> > +
> > +  dvdd-supply: true
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +  ti,prealert-count:
> > +    description: |
> > +      Sets the Pre-Alert Event Count for both,
> > +       high and low comparators, for both the channels.
> 
> Interesting.  Why is this a device tree property rather than something
> we want to configure from userspace?  Looks like it would map to _period
> after scaling by the sampling frequency.
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-iio#L1003
> 
> 

Ok, I'll try to bring it to sysfs as you suggested

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    maximum: 15
> > +    minimum: 0
> > +
> > +patternProperties:
> > +  "^channel@[0-1]$":
> > +    $ref: "adc.yaml"
> > +    type: object
> > +    description: |
> > +      Represents the external channels which are connected to the ADC.
> > +    properties:
> > +      reg:
> > +        description: |
> > +          The channel number.
> > +        items:
> > +          minimum: 0
> > +          maximum: 1
> 
> enum: [0 1]
> is a more compact way of putting this IIRC.
>  

I'll do that

> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - "#io-channel-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      adc@1f {
> > +        compatible = "ti,ads7142";
> > +        reg = <0x1f>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        #io-channel-cells = <1>;
> > +
> > +        avdd-supply = <&vdd_3v3_reg>;
> > +        dvdd-supply = <&vdd_1v8_reg>;
> > +
> > +        interrupt-parent = <&gpio>;
> > +        interrupts = <7 2>;
> > +
> > +        ti,prealert-count = <4>;
> > +
> > +        channel@0 {
> > +          reg = <0>;
> > +        };
> > +
> > +        channel@1 {
> > +          reg = <1>;
> > +        };
> > +      };
> > +    };
> > +...
> > +
> 

Thank you.

Best regards
József
