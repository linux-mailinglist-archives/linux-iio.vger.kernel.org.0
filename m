Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF8037139E
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhECKaN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 3 May 2021 06:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233370AbhECKaN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 06:30:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE5E611BD;
        Mon,  3 May 2021 10:29:15 +0000 (UTC)
Date:   Mon, 3 May 2021 11:30:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?SsOzenNlZiBIb3J2w6F0aA==?= <info@ministro.hu>
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
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: devicetree bindings for
 texas instruments ads7142 iio driver
Message-ID: <20210503113008.751560b1@jic23-huawei>
In-Reply-To: <20210502211020.GB32610@dev>
References: <bffbc2b24a869dc42307adf8e3fc71f08fcff6dd.1619892171.git.info@ministro.hu>
        <69205d4de46dd21c82b31ca1c35cbf12fbce629b.1619892171.git.info@ministro.hu>
        <20210502182255.6bed8afa@jic23-huawei>
        <20210502211020.GB32610@dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 May 2021 21:10:20 +0000
József Horváth <info@ministro.hu> wrote:

Hi József,

> >   
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +
> > > +  "#io-channel-cells":
> > > +    const: 1
> > > +
> > > +  ti,osc-sel:
> > > +    description: |
> > > +      If present, the driver selects the high speed oscillator.
> > > +      See chapter 7.3.5 Oscillator and Timing Control in datasheet.
> > > +    type: boolean  
> > 
> > This looks connected to the possible sampling frequencies when in various autonomous modes.
> > Should it be controlled by userspace?  
> 
> The sampling frequency is controlled with the osc-sel and n-clk.
> I'll remove n-clk from sysfs.

Not sure I follow that.  I think we should only have these controlled via
sysfs.  It will be a bit complex as two related controls, but that is a common situation
and there is usually a sensible combination of options that makes sense.

For example, if we can meet the sampling frequency requested with the lower
power oscillator we go for that.

> 
> >   
> > > +
> > > +  ti,n-clk:
> > > +    description: |
> > > +      nCLK is number of clocks in one conversion cycle.
> > > +      See chapter 7.3.5 Oscillator and Timing Control in datasheet.  
> > 
> > Sounds like a policy decision for userspace.
> >   
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    maximum: 255
> > > +    minimum: 0
> > > +
> > > +  ti,monitoring-mode:
> > > +    description: |
> > > +      If present, the driver selects the autonomous monitoring mode with pre alert data.
> > > +      See chapter 7.4 Device Functional Modes in datasheet.  
> > 
> > As mentioned in the driver review, this looks like something we should control from userspace
> > not dt to me.
> >   
> 
> I would keep this here, but it will be an enum.

Sorry, but no.  As mentioned in the driver thread, this doesn't sound like
a characteristic of the hardware (board etc) so it doesn't belong in DT.
It may be challenging to implement an interface that makes sense, but
that doesn't mean we can avoid doing it.

> 
> > > +    type: boolean
> > > +
> > > +patternProperties:
> > > +  "^channel@[0-1]$":
> > > +    $ref: "adc.yaml"
> > > +    type: object
> > > +    description: |
> > > +      Represents the external channels which are connected to the ADC.
> > > +    properties:
> > > +      reg:
> > > +        description: |
> > > +          The channel number.
> > > +        items:
> > > +          minimum: 0
> > > +          maximum: 1
> > > +      "ti,threshold-falling":
> > > +        description: The low threshold for channel  
> > 
> > For these, we need a strong argument presented in this doc for why they are not
> > a question of policy (and hence why they should be in dt at all).  
> 
> I'll remove all threshold and hysteresys from dt.
> 
> >   
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        maximum: 4095
> > > +        minimum: 0
> > > +      "ti,threshold-rising":
> > > +        description: The high threshold for channel
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        maximum: 4095
> > > +        minimum: 0
> > > +      "ti,hysteresis":
> > > +        description: The hysteresis for both comparators for channel
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        maximum: 63
> > > +        minimum: 0
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +    additionalProperties: false
> > > +
> > > +allOf:
> > > +  - if:
> > > +      required:
> > > +        - ti,monitoring-mode
> > > +    then:
> > > +      required:
> > > +        - interrupts
> > > +
> > > +required:
> > > +  - compatible
> > > +  - "#io-channel-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +      adc@18 {  
> > 
> > I would not bother having two examples.  The second one covers more things afterall
> > and the binding makes it clear what is required.
> >   
> 
> I do this because of the conditional requirement of interrupts.

Understood, but that is clearly expressed by the 'required' above.
It's easy enough to understand how to not have parts that aren't
required without an example.

> 
> > > +        compatible = "ti,ads7142";
> > > +        reg = <0x18>;
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +        #io-channel-cells = <1>;
> > > +
> > > +        vref-supply = <&vdd_3v3_reg>;
> > > +        power-supply = <&vdd_1v8_reg>;
> > > +
> > > +        channel@0 {
> > > +          reg = <0>;
> > > +        };
> > > +
> > > +        channel@1 {
> > > +          reg = <1>;
> > > +        };
> > > +      };
> > > +    };
> > > +  - |
> > > +    i2c {
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +      adc@1f {
> > > +        compatible = "ti,ads7142";
> > > +        reg = <0x1f>;
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        #io-channel-cells = <1>;
> > > +
> > > +        vref-supply = <&vdd_3v3_reg>;
> > > +        power-supply = <&vdd_1v8_reg>;
> > > +
> > > +        interrupt-parent = <&gpio>;
> > > +        interrupts = <7 2>;
> > > +
> > > +        ti,monitoring-mode;
> > > +
> > > +        channel@0 {
> > > +          reg = <0>;
> > > +          ti,threshold-falling = <1000>;
> > > +          ti,threshold-rising = <2000>;
> > > +          ti,hysteresis = <20>;
> > > +        };
> > > +
> > > +        channel@1 {
> > > +          reg = <1>;
> > > +          ti,threshold-falling = <100>;
> > > +          ti,threshold-rising = <2500>;
> > > +          ti,hysteresis = <0>;
> > > +        };
> > > +      };
> > > +    };
> > > +...
> > > +  
> >   

