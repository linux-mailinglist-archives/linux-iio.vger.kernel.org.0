Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E91263F36
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 09:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgIJH7V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 03:59:21 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2801 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbgIJH7L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 03:59:11 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5FA05322755FC6988A57;
        Thu, 10 Sep 2020 08:59:08 +0100 (IST)
Received: from localhost (10.52.121.43) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 10 Sep
 2020 08:59:08 +0100
Date:   Thu, 10 Sep 2020 08:57:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Rob Herring" <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 07/20] dt-bindings:iio:adc:nuvoton,nau7802 yaml
 conversion
Message-ID: <20200910085733.00005b0a@Huawei.com>
In-Reply-To: <20200909191923.GV230586@piout.net>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-8-jic23@kernel.org>
        <20200909191923.GV230586@piout.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.43]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Sep 2020 21:19:23 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hi,
> 
> On 09/09/2020 18:59:33+0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > A simple conversion from txt file to yaml.  I added the #io-channel-cells
> > property as optional to allow the channels of this ADCs to be used
> > to provide services to other drivers, for example if an analog
> > accelerometer is connected.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../bindings/iio/adc/nuvoton,nau7802.yaml     | 50 +++++++++++++++++++
> >  .../bindings/iio/adc/nuvoton-nau7802.txt      | 18 -------
> >  2 files changed, 50 insertions(+), 18 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml
> > new file mode 100644
> > index 000000000000..bcd041ea28a8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nau7802.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NAU7802 I2c Analog to Digital Converter (ADC)
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > +  - Maxime Ripard <maxime.ripard@free-electrons.com>
> > +  
> 
> Sorry, I meant to reply earlier. Can you make that:
> 
>  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>  - Maxime Ripard <mripard@kernel.org>
> 
> Else, this seems good to me!

Will do. If I don't do a v3 for other reasons I'll change that
whilst applying.

Thanks,

Jonathan

> 
> > +properties:
> > +  compatible:
> > +    const: nuvoton,nau7802
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  nuvoton,vldo:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Internal reference voltage in millivolts to be configured.
> > +    minimum: 2400
> > +    maximum: 4500
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        nau7802@2a {
> > +            compatible = "nuvoton,nau7802";
> > +            reg = <0x2a>;
> > +            nuvoton,vldo = <3000>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
> > deleted file mode 100644
> > index e9582e6fe350..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
> > +++ /dev/null
> > @@ -1,18 +0,0 @@
> > -* Nuvoton NAU7802 Analog to Digital Converter (ADC)
> > -
> > -Required properties:
> > -  - compatible: Should be "nuvoton,nau7802"
> > -  - reg: Should contain the ADC I2C address
> > -
> > -Optional properties:
> > -  - nuvoton,vldo: Internal reference voltage in millivolts to be
> > -    configured valid values are between 2400 mV and 4500 mV.
> > -  - interrupts: IRQ line for the ADC. If not used the driver will use
> > -    polling.
> > -
> > -Example:
> > -adc2: nau7802@2a {
> > -	compatible = "nuvoton,nau7802";
> > -	reg = <0x2a>;
> > -	nuvoton,vldo = <3000>;
> > -};
> > -- 
> > 2.28.0
> >   
> 


