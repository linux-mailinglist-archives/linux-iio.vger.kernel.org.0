Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BAA3FD4A8
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhIAHnu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 1 Sep 2021 03:43:50 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:65279 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbhIAHnq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 03:43:46 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3A45240005;
        Wed,  1 Sep 2021 07:42:45 +0000 (UTC)
Date:   Wed, 1 Sep 2021 09:42:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 03/40] dt-bindings: touchscreen: ti,am3359-tsc: New yaml
 description
Message-ID: <20210901094244.1788ca19@xps13>
In-Reply-To: <YS6E769e/dVxrMyN@robh.at.kernel.org>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-4-miquel.raynal@bootlin.com>
        <YS6E769e/dVxrMyN@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>  
> 
> I prefer that MFDs have just 1 complete example in the MFD schema. 

Just to be on the same line, you ask me to drop the all the lines from

	tscadc:

up to

	dma-names = ...;

and keep only the tsc node, right?

I guess I should do the same in the ADC binding then.

> 
> > +
> > +    tscadc: tscadc@0 {  
> 
> Drop unused labels.
> 
> > +        compatible = "ti,am3359-tscadc";
> > +        reg = <0x0 0x1000>;
> > +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&adc_tsc_fck>;
> > +        clock-names = "fck";
> > +        status = "disabled";  
> 
> status, again.
> 
> > +        dmas = <&edma 53 0>, <&edma 57 0>;
> > +        dma-names = "fifo0", "fifo1";
> > +
> > +        tsc {
> > +            compatible = "ti,am3359-tsc";
> > +            ti,wires = <4>;
> > +            ti,x-plate-resistance = <200>;
> > +            ti,coordinate-readouts = <5>;
> > +            ti,wire-config = <0x00 0x11 0x22 0x33>;
> > +            ti,charge-delay = <0x400>;
> > +        };
> > +    };
> > -- 
> > 2.27.0
> > 
> >   

Thanks,
Miquèl
