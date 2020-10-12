Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1C28BAD0
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgJLO13 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 12 Oct 2020 10:27:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388792AbgJLO13 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 10:27:29 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8042F859A63360F285BE;
        Mon, 12 Oct 2020 15:27:27 +0100 (IST)
Received: from localhost (10.52.126.145) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 12 Oct
 2020 15:27:27 +0100
Date:   Mon, 12 Oct 2020 15:25:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Crt Mori <cmo@melexis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Linux Iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Peter Meerwald" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 24/29] dt-bindings:iio:temperature:melexis,mlx90614 yaml
 conversion
Message-ID: <20201012142540.0000317d@Huawei.com>
In-Reply-To: <CAKv63us7JjEqNdK7Q6uOvRsTxYrS0Ovo-Zcx0pQQOwHmS4Eucg@mail.gmail.com>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-25-jic23@kernel.org>
        <CAKv63utWrhUTb+QUgy_nHniYEMuvK5UuZzD6-iRLGZaAtVHNHA@mail.gmail.com>
        <CAKv63us7JjEqNdK7Q6uOvRsTxYrS0Ovo-Zcx0pQQOwHmS4Eucg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.126.145]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Oct 2020 10:00:15 +0200
Crt Mori <cmo@melexis.com> wrote:

> Hi Jonathan,
> I got mail bounce (account doesn't exist) from Vianney le Clément de
> Saint-Marcq <vianney.leclement@essensium.com>, so I would assume he is
> not working there anymore. I think we can remove him from the
> maintainers list?
yup.

I put it in the cover letter, but one of the side effects of sending
this series out is to identify who we no longer have contact details
for and switch / drop them as necessary.  Will drop Vianney unless
anyone has a working email address.

Thanks,

Jonathan

> 
> Best regards,
> Crt
> 
> On Sun, 11 Oct 2020 at 23:00, Crt Mori <cmo@melexis.com> wrote:
> >
> > Thanks for the conversion. No idea which tag to put, so:
> > Acked-by: Crt Mori <cmo@melexis.com>
> >
> > On Sun, 11 Oct 2020 at 19:10, Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Simple conversion from txt to yaml.
> > > I've listed all 3 authors of the driver as maintainers.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > > Cc: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> > > Cc: Crt Mori <cmo@melexis.com>
> > > ---
> > >  .../iio/temperature/melexis,mlx90614.yaml     | 51 +++++++++++++++++++
> > >  .../bindings/iio/temperature/mlx90614.txt     | 24 ---------
> > >  2 files changed, 51 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> > > new file mode 100644
> > > index 000000000000..dcda203b2ba5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> > > @@ -0,0 +1,51 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Melexis MLX90614 contactless IR temperature sensor
> > > +
> > > +maintainers:
> > > +  - Peter Meerwald <pmeerw@pmeerw.net>
> > > +  - Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> > > +  - Crt Mori <cmo@melexis.com>
> > > +
> > > +description: |
> > > +  http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: melexis,mlx90614
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  wakeup-gpios:
> > > +    description:
> > > +      GPIO connected to the SDA line to hold low in order to wake up the
> > > +      device.  In normal operation, the GPIO is set as input and will
> > > +      not interfere in I2C communication.  There is no need for a GPIO
> > > +      driving the SCL line.  If no GPIO is given, power management is disabled.
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    i2c {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        temp-sensor@5a {
> > > +            compatible = "melexis,mlx90614";
> > > +            reg = <0x5a>;
> > > +            wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> > > +        };
> > > +    };
> > > +...
> > > diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> > > deleted file mode 100644
> > > index 9be57b036092..000000000000
> > > --- a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> > > +++ /dev/null
> > > @@ -1,24 +0,0 @@
> > > -* Melexis MLX90614 contactless IR temperature sensor
> > > -
> > > -http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
> > > -
> > > -Required properties:
> > > -
> > > -  - compatible: should be "melexis,mlx90614"
> > > -  - reg: the I2C address of the sensor
> > > -
> > > -Optional properties:
> > > -
> > > -  - wakeup-gpios: device tree identifier of the GPIO connected to the SDA line
> > > -      to hold low in order to wake up the device.  In normal operation, the
> > > -      GPIO is set as input and will not interfere in I2C communication.  There
> > > -      is no need for a GPIO driving the SCL line.  If no GPIO is given, power
> > > -      management is disabled.
> > > -
> > > -Example:
> > > -
> > > -mlx90614@5a {
> > > -       compatible = "melexis,mlx90614";
> > > -       reg = <0x5a>;
> > > -       wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> > > -};
> > > --
> > > 2.28.0
> > >  


