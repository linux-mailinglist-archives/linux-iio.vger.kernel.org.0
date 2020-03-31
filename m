Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64C1199DE1
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 20:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgCaSPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 14:15:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41856 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCaSPn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 14:15:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id a24so3861727pfc.8;
        Tue, 31 Mar 2020 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xxaK7TWnzQ3tsJFSRYiRdAA4AhJRuyYhC9yptejiW3Q=;
        b=Rp0zWmZ1VxDLmz4cYM+ZmN+MW3QgdVcW9y9omZc2kwDU41vRmMgCtMZEmPLEIMnVEN
         PPQP8dd+ygROEZ36SowO53zBbatTQj/L0wpWfjKFSx8IDrPH1M4ZvcycAjbPZqc57EsS
         h1ZJkUs3i2hezck+bYf9jvZEyqHX7H2WCPrF5a8HJaGvmRlv3nIR1tbZJ8XmNAU6HV+f
         STVWHIMzwZgnwJGHyhoT+Ul8XBraxYhXzjhZKglwKwrz7lH0/hPTD94ubV8ARwOCYTBt
         yrD5sf6MLb3yxL/pQ97pe9c3vkocpS8wawXnbvz0/a3qVrgcv8ayk51tg34kiqWjfT9b
         Iomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xxaK7TWnzQ3tsJFSRYiRdAA4AhJRuyYhC9yptejiW3Q=;
        b=VXq0NtinnQEWKQIRKjU91Ha3+cwE95lAsgp9RpSa/gMyeEwo6+Y5dSuUanwrBK3Q2t
         1OSRJ4q1NIwNkAY+k3tEyMKmHCcfjjnLHxEXipV5eQIPne9ez5zV7gf+vXYe0yk/Zhya
         0nAlEFiiRZXZRep2qzIbUaqo+LkwhGyGP+HGNhWuVKAGnRDhC4mOjAi+apxINyHg2eqB
         cfACsrn4eJiHeofVGKbvkg3LxZnIzM1XLYECRLcUs1DntnaBD7gPW9/ML8hbXFi4rlSA
         Gf8DPo5UukgkDcyzXWJfAVKjPJ3uTDIxQ2hrzev5u7YkFZRlm6ZNVeJfmsev9k0ZFcgb
         zDtw==
X-Gm-Message-State: AGi0PuYkouTZ2k4TtGARrXQcQZCN52WBoWimfMWSgnDFoqMgsPo3zV6i
        s08DiQyuzP7hDvVlRytqWsnYo5VbeS0fC/Y3XcA=
X-Google-Smtp-Source: APiQypLsvD+zTDMxwjtoPObW3tRx6qqtIe/5lQ9pcwg4XtPXaOyGLSX1pOq2/xQm5HMouV0jZnDA6ghb3lUFCsLSAeI=
X-Received: by 2002:a63:7b1d:: with SMTP id w29mr5250305pgc.4.1585678542436;
 Tue, 31 Mar 2020 11:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114811.7978-1-nuno.sa@analog.com> <20200331114811.7978-6-nuno.sa@analog.com>
In-Reply-To: <20200331114811.7978-6-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 21:15:35 +0300
Message-ID: <CAHp75Vdxtn1gXi=xCJfGOkBYiWB2qsYQLTJyaEGiiFqHvELaHQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 31, 2020 at 2:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Support ADIS16475 and similar IMU devices. These devices are
> a precision, miniature MEMS inertial measurement unit (IMU) that
> includes a triaxial gyroscope and a triaxial accelerometer. Each
> inertial sensor combines with signal conditioning that optimizes
> dynamic performance.
>
> The driver adds support for the following devices:
>  * adis16470, adis16475, adis16477, adis16465, adis16467, adis16500,
>    adis16505, adis16507.

...

> +ANALOG DEVICES INC ADIS16475 DRIVER
> +M:     Nuno Sa <nuno.sa@analog.com>
> +L:     linux-iio@vger.kernel.org
> +W:     http://ez.analog.com/community/linux-device-drivers
> +S:     Supported
> +F:     drivers/iio/imu/adis16475.c
> +F:     Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475

Run parse-maintainers.pl to fix this.

...

> +#include <asm/unaligned.h>

Usually it goes after linux/*

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>

> +#include <linux/kernel.h>

What this is for?

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/imu/adis.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>

> +#include <linux/of_device.h>

Do you really need this? Perhaps mod_devicetable.h is what you are looking =
for.

> +#include <linux/spi/spi.h>

...

> +#ifdef CONFIG_DEBUG_FS

> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_serial_number_fops,
> +                       adis16475_show_serial_number, NULL, "0x%.4llx\n")=
;

DEBUGFS ATTRIBUTE?

> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_product_id_fops,
> +                       adis16475_show_product_id, NULL, "%llu\n");

> +DEFINE_SIMPLE_ATTRIBUTE(adis16475_flash_count_fops,
> +                       adis16475_show_flash_count, NULL, "%lld\n");

Ditto.

> +#else
> +static int adis16475_debugfs_init(struct iio_dev *indio_dev)
> +{
> +       return 0;
> +}
> +#endif

...

> +       /*
> +        * If decimation is used, then gyro and accel data will have mean=
ingful
> +        * bits on the LSB registers. This info is used on the trigger ha=
ndler.
> +        */
> +       if (!dec)
> +               clear_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag);
> +       else
> +               set_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag);

assign_bit()

Also to the rest of same

...

> +       for (i =3D ARRAY_SIZE(adis16475_3db_freqs) - 2; i >=3D 1; i--) {

Why those margins? size-2 and 1 ?

> +               if (adis16475_3db_freqs[i] >=3D filter)
> +                       break;
> +       }

...

> +#define ADIS16475_GYRO_CHANNEL(_mod) \
> +       ADIS16475_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
> +       ADIS16475_REG_ ## _mod ## _GYRO_L, ADIS16475_SCAN_GYRO_ ## _mod, =
32, \
> +       32)

It's not obvious that this is macro inside macro. Can you indent better?
Ditto for the rest similar ones.

...

> +static int adis16475_enable_irq(struct adis *adis, bool enable)
> +{
> +       /*
> +        * There is no way to gate the data-ready signal internally insid=
e the
> +        * ADIS16475. We can only control it's polarity...
> +        */
> +       if (enable)
> +               enable_irq(adis->spi->irq);
> +       else
> +               disable_irq(adis->spi->irq);
> +
> +       return 0;
> +}

It's seems this function is bigger than in-place calls for enable or
disable IRQ.

...

> +       return (crc =3D=3D 0);

Too many parentheses.

...

> +               ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_C=
TRL,
> +                                        ADIS16500_BURST32_MASK, en);
> +               if (ret < 0)

ret > 0 has any meaning? Maybe drop all these ' < 0' parts from the
code (where it's appropriate)?

> +                       return;

...

> +       buffer =3D (u16 *)adis->buffer;

Why the casting is needed?

> +       crc =3D get_unaligned_be16(&buffer[offset + 2]);

If your buffer is aligned in the structure, you may simple use be16_to_cpu(=
).
Same for the rest of get_unaligned*() calls.
Or do you have unaligned data there?

> +       valid =3D adis16475_validate_crc((u8 *)adis->buffer, crc, st->bur=
st32);

Why casting?

> +       if (!valid) {
> +               dev_err(&adis->spi->dev, "Invalid crc\n");
> +               goto check_burst32;
> +       }

...

> +                                       /* keep sparse happy */

Perhaps buffer should be declared as __be16.

> +                                       data[i++] =3D (__force u16)__val;

...


> +       desc =3D irq_get_irq_data(spi->irq);

> +       if (!desc) {
> +               dev_err(&spi->dev, "Could not find IRQ %d\n", spi->irq);
> +               return -EINVAL;
> +       }

Is this even possible?

...

> +       { .compatible =3D "adi,adis16507-3",
> +               .data =3D &adis16475_chip_info[ADIS16507_3] },
> +       { },

Comma is not needed.

...

> +       st->info =3D of_device_get_match_data(&spi->dev);

device_get_match_data()

> +       if (!st->info)
> +               return -EINVAL;

--=20
With Best Regards,
Andy Shevchenko
