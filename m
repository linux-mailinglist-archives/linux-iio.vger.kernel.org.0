Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB41AF22B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDRQGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 12:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgDRQGZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 12:06:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9495F21D6C;
        Sat, 18 Apr 2020 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587225984;
        bh=JuSdKC3YfFU3O7yh70vuZwZDMcNI49p545l1iBO/+1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IU1dZ7BUfk8rsp7Qcv+f27KNZZMavfEOVxkvjXFRtX3/LnnGI/oQZMNjr8Xl5pSAL
         HFMveFCU1fp/8ZrA7VY/9eWr+TmYcE/aMsZrXghVu+Ck9nczWPSN2R4gLaxquwjSE9
         vvKX/Ywcc1wSupgLOi1u7VsJaT6DUWdsPZPGNpFE=
Date:   Sat, 18 Apr 2020 17:06:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 1/6] dt-bindings: mfd: add document bindings for
 mp2629
Message-ID: <20200418170619.155222fa@archlinux>
In-Reply-To: <50ffb42e-4080-415e-dd3d-e38f7b0a6071@gmail.com>
References: <20200417085003.6124-1-sravanhome@gmail.com>
        <20200417085003.6124-2-sravanhome@gmail.com>
        <20200418155308.681df38f@archlinux>
        <50ffb42e-4080-415e-dd3d-e38f7b0a6071@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Apr 2020 17:01:17 +0200
saravanan sekar <sravanhome@gmail.com> wrote:

> Hi Jonathan,
> 
> On 18/04/20 4:53 pm, Jonathan Cameron wrote:
> > On Fri, 17 Apr 2020 10:49:58 +0200
> > Saravanan Sekar <sravanhome@gmail.com> wrote:
> >  
> >> Add device tree binding information for mp2629 mfd driver.
> >>
> >> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> ---
> >>   .../devicetree/bindings/mfd/mps,mp2629.yaml   | 61 +++++++++++++++++++
> >>   1 file changed, 61 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> >> new file mode 100644
> >> index 000000000000..b25b29259d67
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> >> @@ -0,0 +1,61 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: MP2629 Battery Charger PMIC from Monolithic Power System.
> >> +
> >> +maintainers:
> >> +  - Saravanan Sekar <sravanhome@gmail.com>
> >> +
> >> +description: |
> >> +  MP2629 is a PMIC providing battery charging and power supply for smartphones,
> >> +  wireless camera and portable devices. Chip is controlled over I2C.
> >> +
> >> +  The battery charge management device handles battery charger controller and
> >> +  ADC IIO device for battery, system voltage
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: mps,mp2629
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  interrupt-controller: true
> >> +
> >> +  "#interrupt-cells":
> >> +    const: 2
> >> +    description:
> >> +      The first cell is the IRQ number, the second cell is the trigger type.
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts
> >> +  - interrupt-controller
> >> +  - "#interrupt-cells"
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/interrupt-controller/irq.h>
> >> +    #include <dt-bindings/input/linux-event-codes.h>
> >> +    i2c@7e205000 {  
> > I thought the general trend for i2c devices was to leave the i2c
> > part 'vague'.
> >
> >      i2c {
> >            #address-cells = <1>;
> >            #size-cells = <0>;
> >           
> >            pmic@4b.. etc  
> I agree with you and initial patch was as like above, but Lee was 
> somehow unhappy and not satisfied with
> 
> my explanations. Please find more info on v4.

Ah. Curious.  Oh well - over to Rob for a definitive answer!

> 
> > Guess it doesn't matter if example contains too much information. Rob?
> >
> > Otherwise looks good to me.
> >
> > Thanks,
> >
> > Jonathan
> >     
> >> +        #address-cells = <1>;
> >> +        #size-cells = <0>;
> >> +        reg = <0x7e205000 0x200>;
> >> +
> >> +        pmic@4b {
> >> +            compatible = "mps,mp2629";
> >> +            reg = <0x4b>;
> >> +
> >> +            interrupt-controller;
> >> +            interrupt-parent = <&gpio2>;
> >> +            #interrupt-cells = <2>;
> >> +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> >> +        };
> >> +    };  

