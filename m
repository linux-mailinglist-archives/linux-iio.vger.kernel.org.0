Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1F3CD01D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhGSI2F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:28:05 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41633 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbhGSI2F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:28:05 -0400
Received: by mail-oi1-f179.google.com with SMTP id t143so19974252oie.8;
        Mon, 19 Jul 2021 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=17mSjGJ9fsRSswzgwTitDY8y/XvKmjWDgDcVGv33dcM=;
        b=BRky+81ddgvnKIrxX630Oda5Ci7yXLdzKcFeXIcpPYWHmZvBT0SyRoBCevIbbEaxS/
         DH6RNBWmWOPnAuz4WXs3hMVwDn+0xps8Mynt45Mml6xm87OxGnCkfO2SKN/5mxnkA4kp
         wDjPuS64kzZaBxgSV9ShNi4KtTecgm2YIBfg0Qnd6x0Ou/n7t2ZbtVkKra77EZaORFwc
         ujCVa+OOVO5P6OlpcLs+aazaLKpDL23Hv91M9wCTd2BWHOA0ypjTo3oyr1t4gGjqWWPF
         XrfEhqmLN0lPv5bVoEBtm8fot9PSeOAqvnU2fnVVcmIhdUUXc/kGmRHgSaf0tFjIiqig
         V42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=17mSjGJ9fsRSswzgwTitDY8y/XvKmjWDgDcVGv33dcM=;
        b=jIvkm5sEhNGh7kxbFCChJLIWcZWOAIryAD603kZrZPMR0a5ezYbZX5YKRKiLykwnvX
         HSWfs+0c/z7RXLyn1U7hLvTUDK3BAq7f3r8dglRrQGr+OyrKIPGOTcgaDIOBdKWhIb4w
         i6sfLzx1JWFRkmQY2vk4KHeuUiOck7iXNclNYkG+ZT/vXNZAfOR2n3KPZpBQSkNXnOtM
         qBAEwMj5KbVKB7kAesXeGO4KqjmFQtR/GKdC+d3tp+BJVqJcVuYpQxK16yG1gaByCE44
         jYwaxiFz3gWudBeU03ZmFKw2bYDTyDdqqV188D/qAWdsW/CpEYq1tnEvGtPzzB6uXDXD
         aZGA==
X-Gm-Message-State: AOAM531Er2ngXpzLF6SuPE2iBoqOVn+NHwjrOhfK9YE70U1aHK2wTkgJ
        phoXEZgjPmH+DtgMN8cj0RBxqlkjT+xGh41BH+gjpvwkKDR/eF5Q
X-Google-Smtp-Source: ABdhPJyn4NWLSTBhnzfiO9C3NPMQAxsiG0vu2kflF/idfeLZuemMfpJtbyIEIuxsjoPNV9aiXm8TxLX9kyKgki2gLJU=
X-Received: by 2002:a17:90a:7e16:: with SMTP id i22mr29885373pjl.12.1626684268331;
 Mon, 19 Jul 2021 01:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-4-andrea.merello@gmail.com> <20210717163900.657ec48b@jic23-huawei>
In-Reply-To: <20210717163900.657ec48b@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 19 Jul 2021 10:44:17 +0200
Message-ID: <CAN8YU5M3zSQzRarG=jz8dATsncL2Z-dZRpb9Zc2nHZdLqdQc-g@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: iio: imu: add bosch BNO055 serdev driver bindings
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vlad.dogaru@intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno sab 17 lug 2021 alle ore 17:36 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Thu, 15 Jul 2021 16:17:41 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > Introduce new documentation file for the BNO055 serdev driver that will
> dt bindings are for the device not the driver (so don't mention driver
> in the binding or the patch description).

Ah, right

> > be included in next patches of this same series
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > Cc: Andrea Merello <andrea.merello@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  .../bindings/iio/imu/bosch,bno055-serial.yaml | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml
> > new file mode 100644
> > index 000000000000..743c784ebc94
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml
>
> Better to have just one doc covering this interface and i2c if that gets added.

OK

> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/bosch,bno055-serial.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Serial-attached Bosch BNO055
> > +
> > +maintainers:
> > +  - Jonathan Cameron <jic23@kernel.org>
>
> That's just mean!  I have plenty of these to look after already! Joking
> aside, you'd be a better maintainer for this than me as more likely
> to pay attention.

Ok. I was really embarrassed about this: didn't want to proclaim me as
a maintainer, neither I wanted me to decide something about you :)


> > +
> > +description: |
> > +  Inertial Measurement Unit with Accelerometer, Gyroscope, Magnetometer and
> > +  internal MCU for sensor fusion
> > +  https://www.bosch-sensortec.com/products/smart-sensors/bno055/
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +     - bosch,bno055-serial
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > + - |
> > +   #include <dt-bindings/gpio/gpio.h>
> > +   bno055 {
>
> name needs to be the one for the device type found in the device tree spec or
> if it's not there, something in same 'spirit'.  Probably imu here

OK

> > +      compatible = "bosch,bno055-serial";
> Don't need the -serial. It will bind based on the bus this is under.
> Speaking of which, it's normal to provide that bus info as part of the example.
> See for example chemical/sensiron,scd30.yaml

OK

> > +      reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
> > +      clocks = <&imu_clk>;
> > +   };
>
