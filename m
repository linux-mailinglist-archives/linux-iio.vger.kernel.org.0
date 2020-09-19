Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA3270E71
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgISOPA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 10:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOPA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:15:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518F42085B;
        Sat, 19 Sep 2020 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524899;
        bh=L43UCMnV3PrpyRchPp32e0yjDIK44P5/CO8iCbNV51o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vA+KSthNv2UBTaQYDhA570c9bUsCrbn9awyjuoqcoJFyV/k+g5pnjS9lECDXkDrvB
         gzUJSs116/UtKKDB7v6XFKfWT3lN3ZUnFlW2RY6pChLWkP9ZFS10gDSp7cBZEsWtGf
         CDHoqyNWT4xIqMNkQkJPw7YKkMvO7OsYG7JR69L0=
Date:   Sat, 19 Sep 2020 15:14:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        <devicetree@vger.kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 19/20] dt-bindings:iio:adc:fsl,imx7d-adc yaml
 conversion
Message-ID: <20200919151455.25568afb@archlinux>
In-Reply-To: <20200916112721.00003803@Huawei.com>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-20-jic23@kernel.org>
        <20200916112721.00003803@Huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 11:27:21 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 9 Sep 2020 18:59:45 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > A nice simple binding.  Only real different from txt is that I dropped
> > some descriptions where the naming of the parameter was self explanatory
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Haibo Chen <haibo.chen@freescale.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>  
> Update Haibo Chen's email address. I'll also fix it whilst applying the
> patch if this version goes in!
Applied with that updated address for Haibo Chen.

thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  .../bindings/iio/adc/fsl,imx7d-adc.yaml       | 62 +++++++++++++++++++
> >  .../devicetree/bindings/iio/adc/imx7d-adc.txt | 24 -------
> >  2 files changed, 62 insertions(+), 24 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
> > new file mode 100644
> > index 000000000000..dc5eacb38046
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/fsl,imx7d-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale ADC found on the imx7d SoC
> > +
> > +maintainers:
> > +  - Haibo Chen <haibo.chen@freescale.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx7d-adc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: adc
> > +
> > +  vref-supply: true
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
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/imx7d-clock.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    soc {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        adc@30610000 {
> > +            compatible = "fsl,imx7d-adc";
> > +            reg = <0x30610000 0x10000>;
> > +            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> > +            clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> > +            clock-names = "adc";
> > +            vref-supply = <&reg_vcc_3v3_mcu>;
> > +            #io-channel-cells = <1>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> > deleted file mode 100644
> > index f1f3a552459b..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -Freescale imx7d ADC bindings
> > -
> > -The devicetree bindings are for the ADC driver written for
> > -imx7d SoC.
> > -
> > -Required properties:
> > -- compatible: Should be "fsl,imx7d-adc"
> > -- reg: Offset and length of the register set for the ADC device
> > -- interrupts: The interrupt number for the ADC device
> > -- clocks: The root clock of the ADC controller
> > -- clock-names: Must contain "adc", matching entry in the clocks property
> > -- vref-supply: The regulator supply ADC reference voltage
> > -- #io-channel-cells: Must be 1 as per ../iio-bindings.txt
> > -
> > -Example:
> > -adc1: adc@30610000 {
> > -	compatible = "fsl,imx7d-adc";
> > -	reg = <0x30610000 0x10000>;
> > -	interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> > -	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
> > -	clock-names = "adc";
> > -	vref-supply = <&reg_vcc_3v3_mcu>;
> > -	#io-channel-cells = <1>;
> > -};  
> 
> 

