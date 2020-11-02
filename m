Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8EA2A31D1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 18:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgKBRmE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 12:42:04 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3019 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbgKBRmE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Nov 2020 12:42:04 -0500
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A7A854F9BCC3CA6926CC;
        Mon,  2 Nov 2020 17:42:02 +0000 (GMT)
Received: from localhost (10.52.120.98) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 2 Nov 2020
 17:42:02 +0000
Date:   Mon, 2 Nov 2020 17:39:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Crt Mori <cmo@melexis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Linux Iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 24/29] dt-bindings:iio:temperature:melexis,mlx90614
 yaml conversion
Message-ID: <20201102173959.00004127@Huawei.com>
In-Reply-To: <CAKv63uvm4WMk6U=CthTcVTD+cM-kb9FLBxn2Os8Yy2mHJYoJ5Q@mail.gmail.com>
References: <20201031134110.724233-1-jic23@kernel.org>
        <20201031134110.724233-25-jic23@kernel.org>
        <CAKv63uvm4WMk6U=CthTcVTD+cM-kb9FLBxn2Os8Yy2mHJYoJ5Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.98]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020 10:12:57 +0100
Crt Mori <cmo@melexis.com> wrote:

> Hi Jonathan,
> The commit message should change here as now you did not list all 3
> authors as maintainers, because one has a bouncy email address.
Good point.  I can clean that up whilst applying if we don't need
a v3.

Jonathan

> 
> Best regards,
> Crt
> 
> On Sat, 31 Oct 2020 at 14:44, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Simple conversion from txt to yaml.
> > I've listed all 3 authors of the driver as maintainers.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Crt Mori <cmo@melexis.com>
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > ---
> >  .../iio/temperature/melexis,mlx90614.yaml     | 50 +++++++++++++++++++
> >  .../bindings/iio/temperature/mlx90614.txt     | 24 ---------
> >  2 files changed, 50 insertions(+), 24 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> > new file mode 100644
> > index 000000000000..d6965a0c1cf3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Melexis MLX90614 contactless IR temperature sensor
> > +
> > +maintainers:
> > +  - Peter Meerwald <pmeerw@pmeerw.net>
> > +  - Crt Mori <cmo@melexis.com>
> > +
> > +description: |
> > +  http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
> > +
> > +properties:
> > +  compatible:
> > +    const: melexis,mlx90614
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  wakeup-gpios:
> > +    description:
> > +      GPIO connected to the SDA line to hold low in order to wake up the
> > +      device.  In normal operation, the GPIO is set as input and will
> > +      not interfere in I2C communication.  There is no need for a GPIO
> > +      driving the SCL line.  If no GPIO is given, power management is disabled.
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
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        temp-sensor@5a {
> > +            compatible = "melexis,mlx90614";
> > +            reg = <0x5a>;
> > +            wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> > deleted file mode 100644
> > index 9be57b036092..000000000000
> > --- a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -* Melexis MLX90614 contactless IR temperature sensor
> > -
> > -http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
> > -
> > -Required properties:
> > -
> > -  - compatible: should be "melexis,mlx90614"
> > -  - reg: the I2C address of the sensor
> > -
> > -Optional properties:
> > -
> > -  - wakeup-gpios: device tree identifier of the GPIO connected to the SDA line
> > -      to hold low in order to wake up the device.  In normal operation, the
> > -      GPIO is set as input and will not interfere in I2C communication.  There
> > -      is no need for a GPIO driving the SCL line.  If no GPIO is given, power
> > -      management is disabled.
> > -
> > -Example:
> > -
> > -mlx90614@5a {
> > -       compatible = "melexis,mlx90614";
> > -       reg = <0x5a>;
> > -       wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> > -};
> > --
> > 2.28.0
> >  

