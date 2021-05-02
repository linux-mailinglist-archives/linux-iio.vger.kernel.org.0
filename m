Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20F0370F38
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 23:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhEBVLv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 17:11:51 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:60494 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhEBVLu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 May 2021 17:11:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id E80CB123F6F;
        Sun,  2 May 2021 23:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1619989856;
        bh=kKyz5e1CNkGIkLc7lJTV/XgrN2vgXfR3O0w+DXoMzkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=8QdzN3u3l2xJWjbYmoCcaEwgqtx2nuPWAVQGKSL3BUvPTrnvqdfAoGK4AHgRDpe8e
         IcX4XsHQFibIjnQVkHYzrOVMKYZDDHNHALDPIYrXxce03z1ORrthHnj/eDY0O/yBLp
         wpTHrM/ubZu4cfrDbBvGFMfOsLmctx/uBH/FZVkEWInpK+OWj8izWF1huXLZpaGFqs
         /rI224XJMH394TtXWe+8M2eyqVO80OzzQMNipClToMgwFekrlPCRnyNvjhZNrXixzK
         3xSR1rJgk1QB9XqGfFfVn7rmvo7CSkFXGz/DW15hNSqoN8DZ0DA7VidcPxtvgXroiZ
         u7EAhutpKQNqQ==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r15Hr8ypwtay; Sun,  2 May 2021 23:10:23 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 4D2D7123F6B;
        Sun,  2 May 2021 23:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1619989823;
        bh=kKyz5e1CNkGIkLc7lJTV/XgrN2vgXfR3O0w+DXoMzkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emvvU/sOxUmnEUd9ieEl7EKLrT/XbXs4Z/Kcd+ATuiDRhtTcrNtlsjsU8g1sUiMoD
         0YJGLmZXtkY7msuSnl9VtAvsFohhkl0kxHSoPRrg+d2JlA6+/6qRIYf6n4Fvq2jcEt
         CwGtIk3F+Sv0Tj21QycLOqB9jZIgVxtZAK+5MZFG/k0LrFOIrVAEZ0+ri9tn0iIvhm
         DFPxT5hC8Er66Kq93Dqb4tF10t4o45lStvZPrfK1+wfguaCwK//CDCtFxv4tINEAw0
         r2IgQzBDEAiP56dsvfj73juLVFdpkIlKlkWAAy9nqemdOCktOAmrBA1BQeNu5Rg+MR
         V0Ir0ZCLLP9zg==
Date:   Sun, 2 May 2021 21:10:20 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: devicetree bindings for texas
 instruments ads7142 iio driver
Message-ID: <20210502211020.GB32610@dev>
References: <bffbc2b24a869dc42307adf8e3fc71f08fcff6dd.1619892171.git.info@ministro.hu>
 <69205d4de46dd21c82b31ca1c35cbf12fbce629b.1619892171.git.info@ministro.hu>
 <20210502182255.6bed8afa@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210502182255.6bed8afa@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 02, 2021 at 06:22:55PM +0100, Jonathan Cameron wrote:
> On Sat, 1 May 2021 18:25:18 +0000
> Jozsef Horvath <info@ministro.hu> wrote:
> 
> > This is a device tree schema for iio driver for
> >  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
> > 
> > Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > 
> > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> > ---
> > ---
> >  .../bindings/iio/adc/ti,ads7142.yaml          | 198 ++++++++++++++++++
> >  1 file changed, 198 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> > new file mode 100644
> > index 000000000000..b4e752160156
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> > @@ -0,0 +1,198 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/iio/adc/ti,ads7142.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Texas Instruments ADS7142 adc driver device tree bindings
> > +
> > +maintainers:
> > +  - J�zsef Horv�th <info@ministro.hu>
> > +
> > +description: |
> > +  This document is for describing the required device tree parameters
> > +   for ads7142 adc driver.
> 
> Document describes hardware, not a particular driver.  So just refer
> to the device here.  There may well be other drives in future using
> the same binding (e.g. in an RTOS).
> 
> > +  The required parameters for proper operation are described below.
> > +
> > +  Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > +
> > +  Operation modes supportedby the driver:
> > +    When the 'ti,monitoring-mode' property is not present
> > +      in the devicetree node definition, the driver initiates a single
> > +      conversion in the device for each read request
> > +      (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).
> > +      This is a one-shot conversion, and it is called
> > +      "Manual Mode" in the datasheet.
> > +
> > +    When the 'ti,monitoring-mode' property is present
> > +      in the devicetree node definition, the driver configures
> > +      the device's digital window comparator and sets the device's
> > +      data buffer operation mode to pre alert data mode.
> > +      The driver reads the conversion result when the BUSY/RDY interrupt
> > +      fires, and keeps the value until the next BUSY/RDY interrupt
> > +      or the first read request
> > +      (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).
> > +      The digital window comparator and hysteresis parameters
> > +      can be controlled by:
> > +        - the devicetree definition of channel node
> > +        - iio sysfs interfaces
> > +      This is event driven conversion, and is called
> > +      "Autonomous Mode with Pre Alert Data" in the datasheet.
> > +      This mode can be used to wake up the system with the ALERT pin,
> > +      in case when the monitored voltage level is out of the configured range.
> 
> I talked about these in the driver review so look there for comments.
> Short summary is this is something userspace should have control off (assuming irq
> is wired up) not dt.
> 
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
> > +      The BUSY/PDY pin is used as interrupt line in autonomous monitoring mode.
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description: Regulator for the reference voltage
> > +
> > +  power-supply: true
> 
> These don't match the naming on the pin diagram.

I'll cange it to dvdd, and vref to avdd.

> 
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
> > +  ti,osc-sel:
> > +    description: |
> > +      If present, the driver selects the high speed oscillator.
> > +      See chapter 7.3.5 Oscillator and Timing Control in datasheet.
> > +    type: boolean
> 
> This looks connected to the possible sampling frequencies when in various autonomous modes.
> Should it be controlled by userspace?

The sampling frequency is controlled with the osc-sel and n-clk.
I'll remove n-clk from sysfs.

> 
> > +
> > +  ti,n-clk:
> > +    description: |
> > +      nCLK is number of clocks in one conversion cycle.
> > +      See chapter 7.3.5 Oscillator and Timing Control in datasheet.
> 
> Sounds like a policy decision for userspace.
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    maximum: 255
> > +    minimum: 0
> > +
> > +  ti,monitoring-mode:
> > +    description: |
> > +      If present, the driver selects the autonomous monitoring mode with pre alert data.
> > +      See chapter 7.4 Device Functional Modes in datasheet.
> 
> As mentioned in the driver review, this looks like something we should control from userspace
> not dt to me.
> 

I would keep this here, but it will be an enum.

> > +    type: boolean
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
> > +      "ti,threshold-falling":
> > +        description: The low threshold for channel
> 
> For these, we need a strong argument presented in this doc for why they are not
> a question of policy (and hence why they should be in dt at all).

I'll remove all threshold and hysteresys from dt.

> 
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        maximum: 4095
> > +        minimum: 0
> > +      "ti,threshold-rising":
> > +        description: The high threshold for channel
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        maximum: 4095
> > +        minimum: 0
> > +      "ti,hysteresis":
> > +        description: The hysteresis for both comparators for channel
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        maximum: 63
> > +        minimum: 0
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +allOf:
> > +  - if:
> > +      required:
> > +        - ti,monitoring-mode
> > +    then:
> > +      required:
> > +        - interrupts
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
> > +      adc@18 {
> 
> I would not bother having two examples.  The second one covers more things afterall
> and the binding makes it clear what is required.
> 

I do this because of the conditional requirement of interrupts.

> > +        compatible = "ti,ads7142";
> > +        reg = <0x18>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        #io-channel-cells = <1>;
> > +
> > +        vref-supply = <&vdd_3v3_reg>;
> > +        power-supply = <&vdd_1v8_reg>;
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
> > +        vref-supply = <&vdd_3v3_reg>;
> > +        power-supply = <&vdd_1v8_reg>;
> > +
> > +        interrupt-parent = <&gpio>;
> > +        interrupts = <7 2>;
> > +
> > +        ti,monitoring-mode;
> > +
> > +        channel@0 {
> > +          reg = <0>;
> > +          ti,threshold-falling = <1000>;
> > +          ti,threshold-rising = <2000>;
> > +          ti,hysteresis = <20>;
> > +        };
> > +
> > +        channel@1 {
> > +          reg = <1>;
> > +          ti,threshold-falling = <100>;
> > +          ti,threshold-rising = <2500>;
> > +          ti,hysteresis = <0>;
> > +        };
> > +      };
> > +    };
> > +...
> > +
> 
