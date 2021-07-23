Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0AF3D3D3A
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhGWPaP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 23 Jul 2021 11:30:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3473 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGWPaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 11:30:13 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWYwR4490z6H6lC;
        Sat, 24 Jul 2021 00:01:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 18:10:41 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 17:10:40 +0100
Date:   Fri, 23 Jul 2021 17:10:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     citral23 <cbranchereau@gmail.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-mips@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux@roeck-us.net>, <contact@artur-rojek.eu>
Subject: Re: [PATCH 6/6] dt-bindings: iio/adc: ingenic: add the JZ4760(B)
 socs to the sadc Documentation
Message-ID: <20210723171015.00001b44@Huawei.com>
In-Reply-To: <L90MWQ.K24XQ4Q0L9XN@crapouillou.net>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
        <20210721105317.36742-7-cbranchereau@gmail.com>
        <L90MWQ.K24XQ4Q0L9XN@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Jul 2021 20:17:45 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Christophe,
> 
> Please always add a short description in your patches, even if all you 
> do is repeat the patch title.
> 
> 
> Le mer., juil. 21 2021 at 12:53:17 +0200, citral23 
> <cbranchereau@gmail.com> a écrit :
> > Signed-off-by: citral23 <cbranchereau@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ingenic,adc.yaml         | 9 
> > +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git 
> > a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml 
> > b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > index 433a3fb55a2e..1b423adba61d 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> > @@ -23,6 +23,8 @@ properties:
> >      enum:
> >        - ingenic,jz4725b-adc
> >        - ingenic,jz4740-adc
> > +      - ingenic,jz4760-adc
> > +      - ingenic,jz4760b-adc
> >        - ingenic,jz4770-adc
> > 
> >    '#io-channel-cells':
> > @@ -43,6 +45,12 @@ properties:
> >    interrupts:
> >      maxItems: 1
> > 
> > +  ingenic,use-internal-divider:
> > +    description:
> > +      This property can be used to set VBAT_SEL in the JZ4760B CFG 
> > register
> > +      to sample the battery voltage from the internal divider. If 
> > absent, it
> > +      will sample the external divider.  
> 
> Please remove trailing spaces. And you don't need to describe internal 
> behaviour; you only need to explain the functionality in a user-facing 
> perspective. Something like:
> 
> "If present, battery voltage is read from the VBAT_IR pin, which has an 
> internal /4 divider. If absent, it is read through the VBAT_ER pin, 
> which does not have such divider."
> 
> You also don't specify the type of the property, please add "type: 
> boolean" before the description.
> 
> There should also be a way to make sure that this property can only be 
> used with the JZ4760B SoC. So a dependency for this vendor property on 
> the "ingenic,jz4760b-adc" compatible string. But I'm honestly not sure 
> how to express that... Maybe Rob can help.

Lots of examples in tree.
e.g.
https://elixir.bootlin.com/linux/v5.14-rc2/source/Documentation/devicetree/bindings/iio/st,st-sensors.yaml#L153

Basically you have an if block matching the compatible and for non matches
set it to false.  That combined with additionaProperties: false enforces
the property can't exist for those other devices.

> 
> > +
> >  required:
> >    - compatible
> >    - '#io-channel-cells'
> > @@ -53,6 +61,7 @@ required:
> > 
> >  additionalProperties: false
> > 
> > +  
> 
> Remove the extra newline.
> 
> Cheers,
> -Paul
> 
> >  examples:
> >    - |
> >      #include <dt-bindings/clock/jz4740-cgu.h>
> > --
> > 2.30.2
> >   
> 
> 

