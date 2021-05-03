Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2233720AD
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 21:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECToU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 15:44:20 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:44926 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECToT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 15:44:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 70AA7123F7A;
        Mon,  3 May 2021 21:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1620071004;
        bh=W4pSnJmrTdMmaZVCxMuLWZblyVXvDee6tR3+LqjgMf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzkscEMuE59PYkZ+ozqndYTFkAWRWNzZmA5nSScJn/gCYZx8CqfP/kkeExz4/Qbn9
         HYcjCYAUc25tqFeGhEYML8RcsA5DZNEIH8UOLVllUK2yS6B3I+P0MYDn4sCJcdPM5s
         eVT0QovnisMDQkVvwn9qXEn/Vg5e7MV0Hku2ARIz/XNbxpy36eA1MnpjrvBoqw1a3V
         6Ahmw5tId7PCwpDzXJdUKJRw6daWgEanNfVmXrL9K3vboJ1qVjeTJiccmGGZdz+66j
         uRc2R2DJHa+2mWskzTIlsjAKiMhjMpy/PlQ0bPgksPhrWz+c1sePGtd4Fb99nKI12m
         eJCXG2xfTdq0A==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fzefVMeEZzt0; Mon,  3 May 2021 21:42:44 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id E63DB123F6B;
        Mon,  3 May 2021 21:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1620070963;
        bh=W4pSnJmrTdMmaZVCxMuLWZblyVXvDee6tR3+LqjgMf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAg8BrIIES3iZ5XC17vKL0OrVUvG9iwSrFF/uz/O71ZEappqGCDrNd8JCyKQ1/FMF
         LOcoaJz2ieGN0S4pnxpZh9sdut45LgIf7jkN22t06kmvXXwCGARyhjFH5SPcL8KeIA
         be7+HqMEle+IbhEm1UoDapLxdkUZoPbV5N63AUu1lXaDIpsw9IAE2d8johVrg37lwP
         qPse/fcJAyPzPgpSLaA4CUZQCCTGYB5dYz7Dq7sFLw8bzqt/gfDsAfCwpExzXgVHgu
         fOSfm1Asr6unpLgT/jEUJWD0vJvR0EbyoEl9LLDmnS2iu2qz1/fZmnTvwesWwy7iC2
         z4J6Z/M0GfrwA==
Date:   Mon, 3 May 2021 19:42:41 +0000
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
Message-ID: <20210503194241.GB1714@dev>
References: <bffbc2b24a869dc42307adf8e3fc71f08fcff6dd.1619892171.git.info@ministro.hu>
 <69205d4de46dd21c82b31ca1c35cbf12fbce629b.1619892171.git.info@ministro.hu>
 <20210502182255.6bed8afa@jic23-huawei>
 <20210502211020.GB32610@dev>
 <20210503113008.751560b1@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503113008.751560b1@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 03, 2021 at 11:30:08AM +0100, Jonathan Cameron wrote:

Hi Jonathan,

> On Sun, 2 May 2021 21:10:20 +0000
> József Horváth <info@ministro.hu> wrote:
> 
> Hi József,
> 
> > >   
> > > > +
> > > > +  "#address-cells":
> > > > +    const: 1
> > > > +
> > > > +  "#size-cells":
> > > > +    const: 0
> > > > +
> > > > +  "#io-channel-cells":
> > > > +    const: 1
> > > > +
> > > > +  ti,osc-sel:
> > > > +    description: |
> > > > +      If present, the driver selects the high speed oscillator.
> > > > +      See chapter 7.3.5 Oscillator and Timing Control in datasheet.
> > > > +    type: boolean  
> > > 
> > > This looks connected to the possible sampling frequencies when in various autonomous modes.
> > > Should it be controlled by userspace?  
> > 
> > The sampling frequency is controlled with the osc-sel and n-clk.
> > I'll remove n-clk from sysfs.
> 
> Not sure I follow that.  I think we should only have these controlled via
> sysfs.  It will be a bit complex as two related controls, but that is a common situation
> and there is usually a sensible combination of options that makes sense.
> 
> For example, if we can meet the sampling frequency requested with the lower
> power oscillator we go for that.
> 

Ok, I'll do that.

> > 
> > >   
> > > > +
> > > > +  ti,n-clk:
> > > > +    description: |
> > > > +      nCLK is number of clocks in one conversion cycle.
> > > > +      See chapter 7.3.5 Oscillator and Timing Control in datasheet.  
> > > 
> > > Sounds like a policy decision for userspace.
> > >   
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    maximum: 255
> > > > +    minimum: 0
> > > > +
> > > > +  ti,monitoring-mode:
> > > > +    description: |
> > > > +      If present, the driver selects the autonomous monitoring mode with pre alert data.
> > > > +      See chapter 7.4 Device Functional Modes in datasheet.  
> > > 
> > > As mentioned in the driver review, this looks like something we should control from userspace
> > > not dt to me.
> > >   
> > 
> > I would keep this here, but it will be an enum.
> 
> Sorry, but no.  As mentioned in the driver thread, this doesn't sound like
> a characteristic of the hardware (board etc) so it doesn't belong in DT.
> It may be challenging to implement an interface that makes sense, but
> that doesn't mean we can avoid doing it.

Ok, I'll bring it to sysfs.

> 
> > 
> > > > +    type: boolean
> > > > +
> > > > +patternProperties:
> > > > +  "^channel@[0-1]$":
> > > > +    $ref: "adc.yaml"
> > > > +    type: object
> > > > +    description: |
> > > > +      Represents the external channels which are connected to the ADC.
> > > > +    properties:
> > > > +      reg:
> > > > +        description: |
> > > > +          The channel number.
> > > > +        items:
> > > > +          minimum: 0
> > > > +          maximum: 1
> > > > +      "ti,threshold-falling":
> > > > +        description: The low threshold for channel  
> > > 
> > > For these, we need a strong argument presented in this doc for why they are not
> > > a question of policy (and hence why they should be in dt at all).  
> > 
> > I'll remove all threshold and hysteresys from dt.
> > 
> > >   
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        maximum: 4095
> > > > +        minimum: 0
> > > > +      "ti,threshold-rising":
> > > > +        description: The high threshold for channel
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        maximum: 4095
> > > > +        minimum: 0
> > > > +      "ti,hysteresis":
> > > > +        description: The hysteresis for both comparators for channel
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        maximum: 63
> > > > +        minimum: 0
> > > > +
> > > > +    required:
> > > > +      - reg
> > > > +
> > > > +    additionalProperties: false
> > > > +
> > > > +allOf:
> > > > +  - if:
> > > > +      required:
> > > > +        - ti,monitoring-mode
> > > > +    then:
> > > > +      required:
> > > > +        - interrupts
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - "#io-channel-cells"
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    i2c {
> > > > +      #address-cells = <1>;
> > > > +      #size-cells = <0>;
> > > > +      adc@18 {  
> > > 
> > > I would not bother having two examples.  The second one covers more things afterall
> > > and the binding makes it clear what is required.
> > >   
> > 
> > I do this because of the conditional requirement of interrupts.
> 
> Understood, but that is clearly expressed by the 'required' above.
> It's easy enough to understand how to not have parts that aren't
> required without an example.

I'll bring the monitoring mode to sysfs, and in that case, the conditional requirement
 will be pointless, and interrupt property will be optional, so you are right, one example
 will be enough.

> 
> > 
> > > > +        compatible = "ti,ads7142";
> > > > +        reg = <0x18>;
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +        #io-channel-cells = <1>;
> > > > +
> > > > +        vref-supply = <&vdd_3v3_reg>;
> > > > +        power-supply = <&vdd_1v8_reg>;
> > > > +
> > > > +        channel@0 {
> > > > +          reg = <0>;
> > > > +        };
> > > > +
> > > > +        channel@1 {
> > > > +          reg = <1>;
> > > > +        };
> > > > +      };
> > > > +    };
> > > > +  - |
> > > > +    i2c {
> > > > +      #address-cells = <1>;
> > > > +      #size-cells = <0>;
> > > > +      adc@1f {
> > > > +        compatible = "ti,ads7142";
> > > > +        reg = <0x1f>;
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +
> > > > +        #io-channel-cells = <1>;
> > > > +
> > > > +        vref-supply = <&vdd_3v3_reg>;
> > > > +        power-supply = <&vdd_1v8_reg>;
> > > > +
> > > > +        interrupt-parent = <&gpio>;
> > > > +        interrupts = <7 2>;
> > > > +
> > > > +        ti,monitoring-mode;
> > > > +
> > > > +        channel@0 {
> > > > +          reg = <0>;
> > > > +          ti,threshold-falling = <1000>;
> > > > +          ti,threshold-rising = <2000>;
> > > > +          ti,hysteresis = <20>;
> > > > +        };
> > > > +
> > > > +        channel@1 {
> > > > +          reg = <1>;
> > > > +          ti,threshold-falling = <100>;
> > > > +          ti,threshold-rising = <2500>;
> > > > +          ti,hysteresis = <0>;
> > > > +        };
> > > > +      };
> > > > +    };
> > > > +...
> > > > +  
> > >   
> 

Best regards
Jozsef
