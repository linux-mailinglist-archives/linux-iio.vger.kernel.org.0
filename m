Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD867946E
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jan 2023 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjAXJnt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Jan 2023 04:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjAXJns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2023 04:43:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED324ECF;
        Tue, 24 Jan 2023 01:43:46 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1MQj3899z67QJq;
        Tue, 24 Jan 2023 17:40:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 09:43:44 +0000
Date:   Tue, 24 Jan 2023 09:43:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Barry Song" <baohua@kernel.org>
Subject: Re: [PATCH 12/12] dt-bindings: iio: accel: Add ADIS16203
 Inclinometer
Message-ID: <20230124094344.00003e67@Huawei.com>
In-Reply-To: <6abc3265-75a2-1fa6-803e-6066a81b8ec5@linaro.org>
References: <20230123211758.563383-1-jic23@kernel.org>
        <20230123211758.563383-13-jic23@kernel.org>
        <6abc3265-75a2-1fa6-803e-6066a81b8ec5@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Jan 2023 09:39:10 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 23/01/2023 22:17, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > There has been a driver in staging for quite a while.
> > Given we are now moving it to the main tree, time to make sure it
> > has binding documentation.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  .../bindings/iio/accel/adi,adis16203.yaml     | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> > new file mode 100644
> > index 000000000000..05c095247e10
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ADIS16203 Programmable 360 degree inclinometer
> > +
> > +maintainers:
> > +  - Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,adis16203
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 2
> > +
> > +  interrupt-names:  
> 
> maxItems (and probably minItems
> 
> > +    description:
> > +      Device has two configurable outputs, both of which may be used
> > +      as interrupt sources.
> > +    enum:  
> 
> This won't work. It's an list. You need:
> items:
>   enum:
>      .....

Gah. I'm still rubbish at writing these things. I guess I just
don't do them often enough.

> 
> > +      - dio0
> > +      - dio1
> > +
> > +  reset-gpios: true  
> 
> maxItems: 1
> 
> 
> > +
> > +  vdd-supply: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        accelerometer@0 {
> > +            compatible = "adi,adis16201";
> > +            reg = <0>;
> > +            spi-max-frequency = <2500000>;
> > +            interrupt-parent = <&gpio0>;
> > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "dio0";  
> 
> You require here two items, according to interrupts. Don't you miss
> minItems?

Indeed.

> 
> Also... if you tested the binding it would complain here.

I thought I had tested it (and fixed a few issues that showed up).
I guess something went wrong with with the final test.  Will investigate.

Thanks and sorry for the waste of time with the silly errors!

Jonathan


> 
> > +        };
> > +    };
> > +...
> > +  
> 
> Best regards,
> Krzysztof
> 

