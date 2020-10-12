Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1355628BAE5
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgJLOdH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 10:33:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbgJLOdG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 10:33:06 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D5FB646C1FD25211B814;
        Mon, 12 Oct 2020 15:33:05 +0100 (IST)
Received: from localhost (10.52.126.145) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 12 Oct
 2020 15:33:05 +0100
Date:   Mon, 12 Oct 2020 15:31:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/29] dt-bindings:iio:pressure:hoperf,hp03 yaml
 conversion
Message-ID: <20201012143118.000040f5@Huawei.com>
In-Reply-To: <CAL_JsqKT7G-E7Ao7AbRwm_J_MRRRqcChpn5xkJZrftTjJLUZtQ@mail.gmail.com>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-9-jic23@kernel.org>
        <CAL_JsqKT7G-E7Ao7AbRwm_J_MRRRqcChpn5xkJZrftTjJLUZtQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.145]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Oct 2020 08:06:46 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Sun, Oct 11, 2020 at 12:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One quirk in the txt file was that the xclr gpio was specified as
> > gpio-xclr rather than gpios-xclr. I've fixed that in the  
> 
> xclr-gpios?, not gpios?-xclr

I clearly have a very short memory when writing patch descriptions.
Indeed, xclr-gpios is what this should say. 


> 
> > yaml version.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Marek Vasut <marex@denx.de>
> > ---
> >  .../bindings/iio/pressure/hoperf,hp03.yaml    | 47 +++++++++++++++++++
> >  .../devicetree/bindings/iio/pressure/hp03.txt | 17 -------
> >  2 files changed, 47 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml b/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml
> > new file mode 100644
> > index 000000000000..69a3759e23db
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/pressure/hoperf,hp03.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HopeRF HP03 digital pressure/temperature sensors
> > +
> > +maintainers:
> > +  - Marek Vasut <marex@denx.de>
> > +
> > +description: |
> > +  Digital pressure and temperature sensor with an I2C interface.
> > +
> > +properties:
> > +  compatible:
> > +    const: hoperf,hp03
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  xclr-gpios:
> > +    description:
> > +      The XCLR pin is a reset of the ADC in the chip, it must be pulled
> > +      HI before the conversion and readout of the value from the ADC
> > +      registers and pulled LO afterward.
> > +    maxItems: 1
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
> > +
> > +        pressure@77 {
> > +            compatible = "hoperf,hp03";
> > +            reg = <0x77>;
> > +            xclr-gpios = <&portc 0 0x0>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/hp03.txt b/Documentation/devicetree/bindings/iio/pressure/hp03.txt
> > deleted file mode 100644
> > index 831dbee7a5c3..000000000000
> > --- a/Documentation/devicetree/bindings/iio/pressure/hp03.txt
> > +++ /dev/null
> > @@ -1,17 +0,0 @@
> > -HopeRF HP03 digital pressure/temperature sensors
> > -
> > -Required properties:
> > -- compatible: must be "hoperf,hp03"
> > -- xclr-gpio: must be device tree identifier of the XCLR pin.
> > -             The XCLR pin is a reset of the ADC in the chip,
> > -             it must be pulled HI before the conversion and
> > -             readout of the value from the ADC registers and
> > -             pulled LO afterward.
> > -
> > -Example:
> > -
> > -hp03@77 {
> > -       compatible = "hoperf,hp03";
> > -       reg = <0x77>;
> > -       xclr-gpio = <&portc 0 0x0>;
> > -};
> > --
> > 2.28.0
> >  


