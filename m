Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5CF260E77
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgIHJOM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 05:14:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2781 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727995AbgIHJOJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Sep 2020 05:14:09 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 01F214A568CFD93DD399;
        Tue,  8 Sep 2020 10:14:08 +0100 (IST)
Received: from localhost (10.52.124.38) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 8 Sep 2020
 10:14:07 +0100
Date:   Tue, 8 Sep 2020 10:12:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Orson Zhai <orsonzhai@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Baolin Wang" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 06/20] dt-bindings:iio:adc:sprd,sc2720-adc yaml
 conversion.
Message-ID: <20200908101232.000032c5@Huawei.com>
In-Reply-To: <CA+H2tpE2-f7Sugi04hFwx4QrczufnE2gNHPzAoHWMwARgyOyLw@mail.gmail.com>
References: <20200905173004.216081-1-jic23@kernel.org>
        <20200905173004.216081-7-jic23@kernel.org>
        <CA+H2tpE2-f7Sugi04hFwx4QrczufnE2gNHPzAoHWMwARgyOyLw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.38]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Sep 2020 01:46:40 +0800
Orson Zhai <orsonzhai@gmail.com> wrote:

> Hi Jonathan,
> 
> On Sun, Sep 6, 2020 at 1:32 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I changed the name to reflect a specific part in line with normal
> > naming conventions. If there is a particularly strong reason to
> > keep the wild cards let me know.  
> 
> Why do we have to change the file name of 27xx ?

We don't have to, but generally we try to avoid using wild
card naming.   It is far too common for companies marketing departments
or similar to decide to group incompatible parts.  Basically picking
a part number and saying 'and compatible' is much less likely to cause
confusion than a wild card!

If you feel strongly about it and can do a check of whether there
are any incompatible parts or not covered by that wild card range, then
I'm happy to change it back again whilst applying.

Feel free to give a conditional Ack btw!

Jonathan

> 
> >
> > Otherwise this was a fairly simple conversion as part of converting
> > all the IIO bindings to yaml.  
> 
> Thanks for doing this for us.
> 
> -Orson
> 
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > ---
> >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 72 +++++++++++++++++++
> >  .../bindings/iio/adc/sprd,sc27xx-adc.txt      | 40 -----------
> >  2 files changed, 72 insertions(+), 40 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > new file mode 100644
> > index 000000000000..57df6439dd9d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/sprd,sc2720-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Spreadtrum SC27XX series PMICs ADC binding
> > +
> > +maintainers:
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +
> > +description:
> > +  Supports the ADC found on these PMICs.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sprd,sc2720-adc
> > +      - sprd,sc2721-adc
> > +      - sprd,sc2723-adc
> > +      - sprd,sc2730-adc
> > +      - sprd,sc2731-adc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +  hwlocks:
> > +    maxItems: 1
> > +
> > +  nvmem-cells:
> > +    maxItems: 2
> > +
> > +  nvmem-cell-names:
> > +    items:
> > +      - const: big_scale_calib
> > +      - const: small_scale_calib
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#io-channel-cells"
> > +  - hwlocks
> > +  - nvmem-cells
> > +  - nvmem-cell-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    pmic {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        adc@480 {
> > +            compatible = "sprd,sc2731-adc";
> > +            reg = <0x480>;
> > +            interrupt-parent = <&sc2731_pmic>;
> > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +            #io-channel-cells = <1>;
> > +            hwlocks = <&hwlock 4>;
> > +            nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
> > +            nvmem-cell-names = "big_scale_calib", "small_scale_calib";
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> > deleted file mode 100644
> > index b4daa15dcf15..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> > +++ /dev/null
> > @@ -1,40 +0,0 @@
> > -Spreadtrum SC27XX series PMICs ADC binding
> > -
> > -Required properties:
> > -- compatible: Should be one of the following.
> > -       "sprd,sc2720-adc"
> > -       "sprd,sc2721-adc"
> > -       "sprd,sc2723-adc"
> > -       "sprd,sc2730-adc"
> > -       "sprd,sc2731-adc"
> > -- reg: The address offset of ADC controller.
> > -- interrupt-parent: The interrupt controller.
> > -- interrupts: The interrupt number for the ADC device.
> > -- #io-channel-cells: Number of cells in an IIO specifier.
> > -- hwlocks: Reference to a phandle of a hwlock provider node.
> > -- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
> > -- nvmem-cell-names: Should be "big_scale_calib", "small_scale_calib".
> > -
> > -Example:
> > -
> > -       sc2731_pmic: pmic@0 {
> > -               compatible = "sprd,sc2731";
> > -               reg = <0>;
> > -               spi-max-frequency = <26000000>;
> > -               interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> > -               interrupt-controller;
> > -               #interrupt-cells = <2>;
> > -               #address-cells = <1>;
> > -               #size-cells = <0>;
> > -
> > -               pmic_adc: adc@480 {
> > -                       compatible = "sprd,sc2731-adc";
> > -                       reg = <0x480>;
> > -                       interrupt-parent = <&sc2731_pmic>;
> > -                       interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > -                       #io-channel-cells = <1>;
> > -                       hwlocks = <&hwlock 4>;
> > -                       nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
> > -                       nvmem-cell-names = "big_scale_calib", "small_scale_calib";
> > -               };
> > -       };
> > --
> > 2.28.0
> >  


