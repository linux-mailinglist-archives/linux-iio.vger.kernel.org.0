Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70FC1BEA1C
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgD2Vm7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 17:42:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42421 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2Vm6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 17:42:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id i13so3256801oie.9;
        Wed, 29 Apr 2020 14:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZN/QRY3OxMls9AHONLpA7W00pKe4yt6lczGLbOe3TCs=;
        b=OHP5FA4ujpCRCDbhz0uB+PWV436h924hAc+l/c/RFiPSSn/cjAzioveog6bgAmdLLx
         IHDLNRAnUbrNC2i7cs4nQbvbK+7sOsfgbPxeCoijUtqNo92Xed8yVNl1DDQ+3wsoLo54
         02HzvovPYfSvExkoAvSG/MaroUr7mlckLDtoSNqR/HtLWXIJXY87jEyuRbnFYHnNHLmm
         YGCpmrT4XR4fAGASTXUN3MSDOjpB+l2geNfAvRsAYQgjg9psAxdFFj1H2KYq6Vfi6c1Z
         FUzB6QGx1ckBJ8Tm1LPftWcHQpctpLbzspqrhODLr3K58ckttT1PnYTwAT93eFV6jc1f
         f6Aw==
X-Gm-Message-State: AGi0Pub/C7SwQXyyCQUL1OL5l0T+izsX5gjIezwa6PJR+0luz6A9J2Wo
        jafNZ3UwMywJRdzXZnzSqg==
X-Google-Smtp-Source: APiQypKCxdqv61B1T1NpBM6xwpLAjHJI0zpy60RiRUAzF2x8pqxnzmCc+fmPja7HqOoybilLjjX3bQ==
X-Received: by 2002:aca:4c13:: with SMTP id z19mr258695oia.79.1588196576073;
        Wed, 29 Apr 2020 14:42:56 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j42sm766426ooi.5.2020.04.29.14.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:42:55 -0700 (PDT)
Received: (nullmailer pid 17398 invoked by uid 1000);
        Wed, 29 Apr 2020 21:42:54 -0000
Date:   Wed, 29 Apr 2020 16:42:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        saravanan sekar <sravanhome@gmail.com>,
        andy.shevchenko@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 1/6] dt-bindings: mfd: add document bindings for
 mp2629
Message-ID: <20200429214254.GA9175@bogus>
References: <20200417085003.6124-1-sravanhome@gmail.com>
 <20200417085003.6124-2-sravanhome@gmail.com>
 <20200418155308.681df38f@archlinux>
 <50ffb42e-4080-415e-dd3d-e38f7b0a6071@gmail.com>
 <20200418170619.155222fa@archlinux>
 <20200420071910.GH3737@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420071910.GH3737@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 20, 2020 at 08:19:10AM +0100, Lee Jones wrote:
> On Sat, 18 Apr 2020, Jonathan Cameron wrote:
> 
> > On Sat, 18 Apr 2020 17:01:17 +0200
> > saravanan sekar <sravanhome@gmail.com> wrote:
> > 
> > > Hi Jonathan,
> > > 
> > > On 18/04/20 4:53 pm, Jonathan Cameron wrote:
> > > > On Fri, 17 Apr 2020 10:49:58 +0200
> > > > Saravanan Sekar <sravanhome@gmail.com> wrote:
> > > >  
> > > >> Add device tree binding information for mp2629 mfd driver.
> > > >>
> > > >> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > >> ---
> > > >>   .../devicetree/bindings/mfd/mps,mp2629.yaml   | 61 +++++++++++++++++++
> > > >>   1 file changed, 61 insertions(+)
> > > >>   create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > >> new file mode 100644
> > > >> index 000000000000..b25b29259d67
> > > >> --- /dev/null
> > > >> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > >> @@ -0,0 +1,61 @@
> > > >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > >> +%YAML 1.2
> > > >> +---
> > > >> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
> > > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >> +
> > > >> +title: MP2629 Battery Charger PMIC from Monolithic Power System.
> > > >> +
> > > >> +maintainers:
> > > >> +  - Saravanan Sekar <sravanhome@gmail.com>
> > > >> +
> > > >> +description: |
> > > >> +  MP2629 is a PMIC providing battery charging and power supply for smartphones,
> > > >> +  wireless camera and portable devices. Chip is controlled over I2C.
> > > >> +
> > > >> +  The battery charge management device handles battery charger controller and
> > > >> +  ADC IIO device for battery, system voltage
> > > >> +
> > > >> +properties:
> > > >> +  compatible:
> > > >> +    const: mps,mp2629
> > > >> +
> > > >> +  reg:
> > > >> +    maxItems: 1
> > > >> +
> > > >> +  interrupts:
> > > >> +    maxItems: 1
> > > >> +
> > > >> +  interrupt-controller: true
> > > >> +
> > > >> +  "#interrupt-cells":
> > > >> +    const: 2
> > > >> +    description:
> > > >> +      The first cell is the IRQ number, the second cell is the trigger type.
> > > >> +
> > > >> +required:
> > > >> +  - compatible
> > > >> +  - reg
> > > >> +  - interrupts
> > > >> +  - interrupt-controller
> > > >> +  - "#interrupt-cells"
> > > >> +
> > > >> +examples:
> > > >> +  - |
> > > >> +    #include <dt-bindings/interrupt-controller/irq.h>
> > > >> +    #include <dt-bindings/input/linux-event-codes.h>
> > > >> +    i2c@7e205000 {  
> > > > I thought the general trend for i2c devices was to leave the i2c
> > > > part 'vague'.
> > > >
> > > >      i2c {
> > > >            #address-cells = <1>;
> > > >            #size-cells = <0>;
> > > >           
> > > >            pmic@4b.. etc  
> > > I agree with you and initial patch was as like above, but Lee was 
> > > somehow unhappy and not satisfied with

Jonathan is correct.

> > > 
> > > my explanations. Please find more info on v4.
> > 
> > Ah. Curious.  Oh well - over to Rob for a definitive answer!
> 
> I haven't seen this spoken about before.  The comments were based
> solely on my own views of, the example should provide a solid, valid,
> potentially working block for people to use as a reference.

I agree that the part matching this schema should be. The rest is just 
boilerplate.

> Would an I2C node missing an address be a valid DTS/DTSI entry?

i2c-gpio?

Rob



