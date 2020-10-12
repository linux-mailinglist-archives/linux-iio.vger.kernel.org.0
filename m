Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6428AF89
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 10:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgJLIAw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgJLIAw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2020 04:00:52 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E7EC0613CE
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 01:00:52 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q202so7423364iod.9
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ikx3FlZPTI9hp2Yy9U2oEySVP8usR03HIZi8HfRNmxE=;
        b=OpoAxPyy1FjR9Q0UCn3poAUWhT1pM534iPNVpGItS2YOuVauGlVNd8HgEhgQfVu+Pp
         UaD+K6AUDOvPClKbJgtr8bNicSZ0VHU9D6OM64dcpTtaKlS65JJvdzroGZIXs+Y6yfMD
         U+xTfOI3oW43Y+dgw1xn4QHVrQH5ycT9rkMWWStHUWELbqteTkznlaNxS02Om9BoCXTm
         EoKTdVVb08mrBiEe8yvbxFdGOyJchwnf0e/GDVeJ8/6fNdkejliTdfKRHdW/+RNXEK0x
         QlN9PUyV+V5Rs11e4qx2T3iDGob29wZSVEzU7CL6ucx7FIUDvMv7NECQkDPyy0PD6koc
         ahsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ikx3FlZPTI9hp2Yy9U2oEySVP8usR03HIZi8HfRNmxE=;
        b=lSjZOQreGjhki27/K4qyU+Qhn2Pt3ynJ61hwosBAbV4pRxSxwZTzyMC2mW+o8T5ZIb
         PyAjoAh1xNE2GLlMm4JPQxqRd+3PUoZk8OTsf7K70gkdcKV33RUMH1z/HGQluKFd5yuU
         tnaS83Djyo6HH7CkVzZLWha6jH67iloSKH7z64V2arQ0qB7E5mxqm0PLL6JTOsapmpSy
         h3QQWMg/eFGYVjWDWjkEo5UMcYp73bYqOHi2qLEkVwo2CXAYfIBpzgvI09GP9NmJFzPj
         0h4bCobrX3u4vE4hxPfNgke/zl+fXrod0aSJ1HTHFI7+ELG/Fn1pgOfmWBBLjfl2oye/
         j39w==
X-Gm-Message-State: AOAM531+HnKXAwdAqvDNTInXlwy5TvtgQZWJ10s1Hu6Jl5yhazuA83hH
        47UR13ZNDPzMXBuml/QBMWqVE0EqHUgGXOgBK0sFdQ==
X-Google-Smtp-Source: ABdhPJwqBgiF2HoWsgH/sZKAAs2ggSvsFCVu5EIO1tyJeU+HwiTBtfJ4hEAti2Dbxt6cZ9kWqGJxcLTvO0ucIRwZ9wM=
X-Received: by 2002:a05:6638:622:: with SMTP id h2mr18915614jar.86.1602489651352;
 Mon, 12 Oct 2020 01:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org> <20201011170749.243680-25-jic23@kernel.org>
 <CAKv63utWrhUTb+QUgy_nHniYEMuvK5UuZzD6-iRLGZaAtVHNHA@mail.gmail.com>
In-Reply-To: <CAKv63utWrhUTb+QUgy_nHniYEMuvK5UuZzD6-iRLGZaAtVHNHA@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 12 Oct 2020 10:00:15 +0200
Message-ID: <CAKv63us7JjEqNdK7Q6uOvRsTxYrS0Ovo-Zcx0pQQOwHmS4Eucg@mail.gmail.com>
Subject: Re: [PATCH 24/29] dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linux Iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
I got mail bounce (account doesn't exist) from Vianney le Cl=C3=A9ment de
Saint-Marcq <vianney.leclement@essensium.com>, so I would assume he is
not working there anymore. I think we can remove him from the
maintainers list?

Best regards,
Crt

On Sun, 11 Oct 2020 at 23:00, Crt Mori <cmo@melexis.com> wrote:
>
> Thanks for the conversion. No idea which tag to put, so:
> Acked-by: Crt Mori <cmo@melexis.com>
>
> On Sun, 11 Oct 2020 at 19:10, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Simple conversion from txt to yaml.
> > I've listed all 3 authors of the driver as maintainers.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: Vianney le Cl=C3=A9ment de Saint-Marcq <vianney.leclement@essensium=
.com>
> > Cc: Crt Mori <cmo@melexis.com>
> > ---
> >  .../iio/temperature/melexis,mlx90614.yaml     | 51 +++++++++++++++++++
> >  .../bindings/iio/temperature/mlx90614.txt     | 24 ---------
> >  2 files changed, 51 insertions(+), 24 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,=
mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,m=
lx90614.yaml
> > new file mode 100644
> > index 000000000000..dcda203b2ba5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx9061=
4.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Melexis MLX90614 contactless IR temperature sensor
> > +
> > +maintainers:
> > +  - Peter Meerwald <pmeerw@pmeerw.net>
> > +  - Vianney le Cl=C3=A9ment de Saint-Marcq <vianney.leclement@essensiu=
m.com>
> > +  - Crt Mori <cmo@melexis.com>
> > +
> > +description: |
> > +  http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer=
-Sensors/MLX90614-615.aspx
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
> > +      GPIO connected to the SDA line to hold low in order to wake up t=
he
> > +      device.  In normal operation, the GPIO is set as input and will
> > +      not interfere in I2C communication.  There is no need for a GPIO
> > +      driving the SCL line.  If no GPIO is given, power management is =
disabled.
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
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        temp-sensor@5a {
> > +            compatible =3D "melexis,mlx90614";
> > +            reg =3D <0x5a>;
> > +            wakeup-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614=
.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> > deleted file mode 100644
> > index 9be57b036092..000000000000
> > --- a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -* Melexis MLX90614 contactless IR temperature sensor
> > -
> > -http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-S=
ensors/MLX90614-615.aspx
> > -
> > -Required properties:
> > -
> > -  - compatible: should be "melexis,mlx90614"
> > -  - reg: the I2C address of the sensor
> > -
> > -Optional properties:
> > -
> > -  - wakeup-gpios: device tree identifier of the GPIO connected to the =
SDA line
> > -      to hold low in order to wake up the device.  In normal operation=
, the
> > -      GPIO is set as input and will not interfere in I2C communication=
.  There
> > -      is no need for a GPIO driving the SCL line.  If no GPIO is given=
, power
> > -      management is disabled.
> > -
> > -Example:
> > -
> > -mlx90614@5a {
> > -       compatible =3D "melexis,mlx90614";
> > -       reg =3D <0x5a>;
> > -       wakeup-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>;
> > -};
> > --
> > 2.28.0
> >
