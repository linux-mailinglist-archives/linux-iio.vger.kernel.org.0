Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E260F311E7E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBFPvr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 10:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhBFPvq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 10:51:46 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF3F64E9C;
        Sat,  6 Feb 2021 15:51:03 +0000 (UTC)
Date:   Sat, 6 Feb 2021 15:50:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: dac: Fix AD5686 references
Message-ID: <20210206155059.2473c149@archlinux>
In-Reply-To: <755532c1-2c28-3796-367a-baec09f2dada@metafoo.de>
References: <20210202215503.114113-1-robh@kernel.org>
        <755532c1-2c28-3796-367a-baec09f2dada@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Feb 2021 22:56:21 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 2/2/21 10:55 PM, Rob Herring wrote:
> > The example and filename use 'adi,ad5686', but the schema doesn't
> > document it. The AD5686 is also a SPI interface variant while all the
> > documented variants have an I2C interface. So let's update all the
> > references to AD5686 to AD5696.
> >
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Michael Auchter <michael.auchter@ni.com>
> > Cc: linux-iio@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>  
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Thanks Rob.
> 
Hi Rob,

So what seems to have happened here is only the i2c parts
of a dual bus driver got documented.  That happened as part
of a series adding a new part to the driver a while back.
(it's an old driver so probably only picked up dt support by accident)

An alternative would be to add the docs for the rest of the
parts supported by the driver - so have a unified doc for
the i2c and SPI parts.

Meh, it's probably simpler to just put that in as a separate
doc though rather than merge it with this one.  So we'll probably
have an adi,ad5686.yaml file again doing that once I get
round to writing one.

I'm assuming you'll pick this up?

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> > ---
> > v2:
> > - Rename instead of adding AD5686
> >
> >   .../iio/dac/{adi,ad5686.yaml => adi,ad5696.yaml}       | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >   rename Documentation/devicetree/bindings/iio/dac/{adi,ad5686.yaml => adi,ad5696.yaml} (77%)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > similarity index 77%
> > rename from Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> > rename to Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > index 8065228e5df8..56b0cda0f30a 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > @@ -1,16 +1,16 @@
> >   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >   %YAML 1.2
> >   ---
> > -$id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5696.yaml#
> >   $schema: http://devicetree.org/meta-schemas/core.yaml#
> >   
> > -title: Analog Devices AD5686 and similar multi-channel DACs
> > +title: Analog Devices AD5696 and similar multi-channel DACs
> >   
> >   maintainers:
> >     - Michael Auchter <michael.auchter@ni.com>
> >   
> >   description: |
> > -  Binding for Analog Devices AD5686 and similar multi-channel DACs
> > +  Binding for Analog Devices AD5696 and similar multi-channel DACs
> >   
> >   properties:
> >     compatible:
> > @@ -48,8 +48,8 @@ examples:
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >   
> > -      ad5686: dac@0 {
> > -        compatible = "adi,ad5686";
> > +      ad5696: dac@0 {
> > +        compatible = "adi,ad5696";
> >           reg = <0>;
> >           vcc-supply = <&dac_vref>;
> >         };  
> 
> 

