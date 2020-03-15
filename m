Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A19185D61
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 15:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgCOOKP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 15 Mar 2020 10:10:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40674 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgCOOKO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 10:10:14 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jDTxm-0005ZQ-HP; Sun, 15 Mar 2020 15:09:58 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: convert rockchip saradc bindings to yaml
Date:   Sun, 15 Mar 2020 15:09:56 +0100
Message-ID: <1892398.6xOoJH07Ba@diego>
In-Reply-To: <20200315112223.07dd863b@archlinux>
References: <20200313132926.10543-1-jbx6244@gmail.com> <20200315112223.07dd863b@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Am Sonntag, 15. März 2020, 12:22:23 CET schrieb Jonathan Cameron:
> On Fri, 13 Mar 2020 14:29:24 +0100
> Johan Jonker <jbx6244@gmail.com> wrote:
> 
> > Current dts files with 'saradc' nodes are manually verified.
> > In order to automate this process rockchip-saradc.txt
> > has to be converted to yaml.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> Hi Johan,
> 
> A question inline which may just be my lack of yaml knowledge
> showing itself!
> 
> Jonathan
> 
> > ---
> >  .../bindings/iio/adc/rockchip-saradc.txt           | 37 ----------
> >  .../bindings/iio/adc/rockchip-saradc.yaml          | 79 ++++++++++++++++++++++
> >  2 files changed, 79 insertions(+), 37 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> > deleted file mode 100644
> > index c2c50b598..000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> > +++ /dev/null
> > @@ -1,37 +0,0 @@
> > -Rockchip Successive Approximation Register (SAR) A/D Converter bindings
> > -
> > -Required properties:
> > -- compatible: should be "rockchip,<name>-saradc" or "rockchip,rk3066-tsadc"
> > -   - "rockchip,saradc": for rk3188, rk3288
> > -   - "rockchip,rk3066-tsadc": for rk3036
> > -   - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328
> > -   - "rockchip,rk3399-saradc": for rk3399
> > -   - "rockchip,rv1108-saradc", "rockchip,rk3399-saradc": for rv1108
> > -
> > -- reg: physical base address of the controller and length of memory mapped
> > -       region.
> > -- interrupts: The interrupt number to the cpu. The interrupt specifier format
> > -              depends on the interrupt controller.
> > -- clocks: Must contain an entry for each entry in clock-names.
> > -- clock-names: Shall be "saradc" for the converter-clock, and "apb_pclk" for
> > -               the peripheral clock.
> > -- vref-supply: The regulator supply ADC reference voltage.
> > -- #io-channel-cells: Should be 1, see ../iio-bindings.txt
> > -
> > -Optional properties:
> > -- resets: Must contain an entry for each entry in reset-names if need support
> > -	  this option. See ../reset/reset.txt for details.
> > -- reset-names: Must include the name "saradc-apb".
> > -
> > -Example:
> > -	saradc: saradc@2006c000 {
> > -		compatible = "rockchip,saradc";
> > -		reg = <0x2006c000 0x100>;
> > -		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > -		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> > -		clock-names = "saradc", "apb_pclk";
> > -		resets = <&cru SRST_SARADC>;
> > -		reset-names = "saradc-apb";
> > -		#io-channel-cells = <1>;
> > -		vref-supply = <&vcc18>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> > new file mode 100644
> > index 000000000..2908788b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/rockchip-saradc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip Successive Approximation Register (SAR) A/D Converter
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: rockchip,saradc
> > +      - const: rockchip,rk3066-tsadc
> > +      - const: rockchip,rk3399-saradc
> > +      - items:
> > +          - enum:
> > +            - rockchip,rk3328-saradc
> > +            - rockchip,rv1108-saradc
> > +          - const: rockchip,rk3399-saradc
> 
> My yaml knowledge isn't great.  Why do we have this nested
> structure rather than a straight forward list?

That should be the
- one of rk3328-saradc / rv1108-saradc
- plus always rk3399-saradc

i.e. both rk3328 and rv1108 are compatible with the rk3399-saradc variant
(at least if no flaws get found at some point) so have the double compatible

compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc"
compatible = "rockchip,rv1108-saradc", "rockchip,rk3399-saradc"


Heiko


> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: converter clock
> > +      - description: peripheral clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: saradc
> > +      - const: apb_pclk
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    const: saradc-apb
> > +
> > +  vref-supply:
> > +    description:
> > +      The regulator supply for the ADC reference voltage.
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - vref-supply
> > +  - "#io-channel-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/rk3288-cru.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    saradc: saradc@2006c000 {
> > +      compatible = "rockchip,saradc";
> > +      reg = <0x2006c000 0x100>;
> > +      interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +      clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> > +      clock-names = "saradc", "apb_pclk";
> > +      resets = <&cru SRST_SARADC>;
> > +      reset-names = "saradc-apb";
> > +      vref-supply = <&vcc18>;
> > +      #io-channel-cells = <1>;
> > +    };
> 
> 




