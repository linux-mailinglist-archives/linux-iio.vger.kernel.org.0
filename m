Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0472A4CD1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 18:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgKCR2h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 12:28:37 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728206AbgKCR2h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Nov 2020 12:28:37 -0500
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D855261926E448CC03FC;
        Tue,  3 Nov 2020 17:28:35 +0000 (GMT)
Received: from localhost (10.52.125.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 3 Nov 2020
 17:28:35 +0000
Date:   Tue, 3 Nov 2020 17:28:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 02/46] dt-bindings:iio:potentiometer:adi,ad5272 yaml
 conversion
Message-ID: <20201103172834.00007040@Huawei.com>
In-Reply-To: <20201103161039.GA1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-3-jic23@kernel.org>
        <20201103161039.GA1754553@bogus>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.233]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Nov 2020 10:10:39 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Oct 31, 2020 at 06:48:10PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple direct conversion from txt to yaml as part of a general aim of
> > converting all IIO bindings to this machine readable format.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Phil Reid <preid@electromag.com.au>
> > ---
> >  .../bindings/iio/potentiometer/ad5272.txt     | 27 ----------
> >  .../iio/potentiometer/adi,ad5272.yaml         | 50 +++++++++++++++++++
> >  2 files changed, 50 insertions(+), 27 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> > deleted file mode 100644
> > index f9b2eef946aa..000000000000
> > --- a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> > +++ /dev/null
> > @@ -1,27 +0,0 @@
> > -* Analog Devices AD5272 digital potentiometer
> > -
> > -The node for this device must be a child node of a I2C controller, hence
> > -all mandatory properties for your controller must be specified. See directory:
> > -
> > -        Documentation/devicetree/bindings/i2c
> > -
> > -for more details.
> > -
> > -Required properties:
> > -	- compatible:  	Must be one of the following, depending on the model:
> > -			adi,ad5272-020
> > -			adi,ad5272-050
> > -			adi,ad5272-100
> > -			adi,ad5274-020
> > -			adi,ad5274-100
> > -
> > -Optional properties:
> > - - reset-gpios: GPIO specification for the RESET input. This is an
> > -		active low signal to the AD5272.
> > -
> > -Example:
> > -ad5272: potentiometer@2f {
> > -	reg = <0x2F>;
> > -	compatible = "adi,ad5272-020";
> > -	reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
> > new file mode 100644
> > index 000000000000..b9b7d383bff1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5272.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5272 digital potentiometer
> > +
> > +maintainers:
> > +  - Phil Reid <preid@electromag.com.au>
> > +
> > +description: |
> > +  Datasheet: https://www.analog.com/en/products/ad5272.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad5272-020
> > +      - adi,ad5272-050
> > +      - adi,ad5272-100
> > +      - adi,ad5274-020
> > +      - adi,ad5274-100
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      Active low signal to the AD5272 RESET input.  
> 
> Not a new problem, but active low or...
> 
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        potentiometer@2f {
> > +            compatible = "adi,ad5272-020";
> > +            reg = <0x2F>;
> > +            reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;  
> 
> active high?

Good spot!  @Phil.  Looks like the driver is setting the reset line to
0 and then to 1 to come out of reset.   So effectively inverting the logic.
I'm tempted to be cynical and suggest we just drop the comment above and leave
it vague but is there a better way we can clarify this?

> 
> > +        };
> > +    };
> > +...
> > -- 
> > 2.28.0
> >   

