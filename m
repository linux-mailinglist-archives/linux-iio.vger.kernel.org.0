Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2204326C509
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIPQTu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 12:19:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbgIPQTG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 12:19:06 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1227132E3641F3C2C336;
        Wed, 16 Sep 2020 15:19:29 +0100 (IST)
Received: from localhost (10.52.126.84) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 16 Sep
 2020 15:19:28 +0100
Date:   Wed, 16 Sep 2020 15:17:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Rick Altherr" <raltherr@google.com>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH v2 04/20] dt-bindings:iio:adc: aspeed,ast2400 yaml
 conversion
Message-ID: <20200916151751.00001947@Huawei.com>
In-Reply-To: <CACPK8Xdb2um+DN9q9P7o2AppYHenYoZ607r-s36BvZET=QCwiw@mail.gmail.com>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-5-jic23@kernel.org>
        <CACPK8Xc+GpVVLvBdz5zHTndBeP0bd7SKLDZq7H6rDUDsd0kMdA@mail.gmail.com>
        <20200916113625.0000641e@Huawei.com>
        <CACPK8Xdb2um+DN9q9P7o2AppYHenYoZ607r-s36BvZET=QCwiw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.84]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 12:39:36 +0000
Joel Stanley <joel@jms.id.au> wrote:

> On Wed, 16 Sep 2020 at 10:38, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 10 Sep 2020 02:32:19 +0000
> > Joel Stanley <joel@jms.id.au> wrote:
> >  
> > > On Wed, 9 Sep 2020 at 18:02, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > Simple txt to yaml conversion. Part of a general move to convert
> > > > all the IIO bindings over to yaml.
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Rick Altherr <raltherr@google.com>
> > > > Cc: Joel Stanley <joel@jms.id.au>
> > > > Cc: Andrew Jeffery <andrew@aj.id.au>  
> > >
> > > Acked-by: Joel Stanley <joel@jms.id.au>
> > >
> > >  
> > > > ---
> > > >  .../bindings/iio/adc/aspeed,ast2400-adc.yaml  | 54 +++++++++++++++++++
> > > >  .../bindings/iio/adc/aspeed_adc.txt           | 22 --------
> > > >  2 files changed, 54 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
> > > > new file mode 100644
> > > > index 000000000000..09018487d690
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml  
> > >
> > > This naming doesn't make sense, as the bindings are for the ast2500
> > > too (and they also apply for the ast2600).  
> >
> > Convention is to name after a supported device and not use
> > wild cards or generic names because the chances of it going
> > wrong in future is far too high. Will every aspeed adc look the same?
> > Seems impossible to predict so best we can do safely is to pick a
> > part number.  
> 
> It already supports three different generations of SoC, which I was
> bringing to your attention. Therefore having the name '2400' is
> already incorrect.

I'm happy to change it to a specific part number of your choice but you
have to chose one.  The file name is not a list of all the parts supported.

There are bindings that attach to hundreds of different part numbers but the
file is named after a specific one.  Normally the first part supported
is the one chosen (because the binding is normally written at that time).

Jonathan

> 
> >
> > There are enormous numbers of examples of this in dt bindings and
> > for that matter driver naming.
> >
> > Thanks,
> >
> > Jonathan
> >
> >  
> > >  
> > > > @@ -0,0 +1,54 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2400-adc.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: ADC that forms part of an ASPEED server management processor.
> > > > +
> > > > +maintainers:
> > > > +  - Rick Altherr <raltherr@google.com>
> > > > +
> > > > +description:
> > > > +  This device is a 10-bit converter for 16 voltage channels.  All inputs are
> > > > +  single ended.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - aspeed,ast2400-adc
> > > > +      - aspeed,ast2500-adc
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    description:
> > > > +      Input clock used to derive the sample clock. Expected to be the
> > > > +      SoC's APB clock.
> > > > +
> > > > +  resets: true
> > > > +
> > > > +  "#io-channel-cells":
> > > > +    const: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - clocks
> > > > +  - resets
> > > > +  - "#io-channel-cells"
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > > +    adc@1e6e9000 {
> > > > +        compatible = "aspeed,ast2400-adc";
> > > > +        reg = <0x1e6e9000 0xb0>;
> > > > +        clocks = <&syscon ASPEED_CLK_APB>;
> > > > +        resets = <&syscon ASPEED_RESET_ADC>;
> > > > +        #io-channel-cells = <1>;
> > > > +    };
> > > > +...
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> > > > deleted file mode 100644
> > > > index 034fc2ba100e..000000000000
> > > > --- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> > > > +++ /dev/null
> > > > @@ -1,22 +0,0 @@
> > > > -Aspeed ADC
> > > > -
> > > > -This device is a 10-bit converter for 16 voltage channels.  All inputs are
> > > > -single ended.
> > > > -
> > > > -Required properties:
> > > > -- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
> > > > -- reg: memory window mapping address and length
> > > > -- clocks: Input clock used to derive the sample clock. Expected to be the
> > > > -          SoC's APB clock.
> > > > -- resets: Reset controller phandle
> > > > -- #io-channel-cells: Must be set to <1> to indicate channels are selected
> > > > -                     by index.
> > > > -
> > > > -Example:
> > > > -       adc@1e6e9000 {
> > > > -               compatible = "aspeed,ast2400-adc";
> > > > -               reg = <0x1e6e9000 0xb0>;
> > > > -               clocks = <&syscon ASPEED_CLK_APB>;
> > > > -               resets = <&syscon ASPEED_RESET_ADC>;
> > > > -               #io-channel-cells = <1>;
> > > > -       };
> > > > --
> > > > 2.28.0
> > > >  
> >
> >  


