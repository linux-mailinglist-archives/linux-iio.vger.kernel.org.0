Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52134321C
	for <lists+linux-iio@lfdr.de>; Sun, 21 Mar 2021 12:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCUL15 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 07:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhCUL1W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Mar 2021 07:27:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BA4C061574;
        Sun, 21 Mar 2021 04:27:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7058846pjb.3;
        Sun, 21 Mar 2021 04:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9m0fyib6qpUnY8e/QUpbxxvvckLkuOGjT0nPn1ziJk=;
        b=F1JRf4Ze286ON9GF+Ng5plkzP06nqplKxzlao/yeZYVF8D5siwdr559omgHtqd1IVo
         4MmaYO/PNVbBGOH0EUgspFKnFmO+erEvYPYwNnegXuKBEJuCitBOPlEBHuT7cGLX3ZUL
         ccS8LYrOJa+zypgWkJra9ZvMTe1jNi2AO5j3IHfycB5O+00ZT0VfxNbJHWZEqljXWxL8
         7THNcJm3EQ2LDkYXfso+9cWuN0aE9vxGShxLBn1XYuwkAZnSfp+TjCV8a6XfYZ8rjRg9
         EAUwT4ykKWbjhjqLCge5nlsaXhNYMNRZUTKCk+easJyjYMkLyH72ClBuMlQDeKv2H3If
         hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9m0fyib6qpUnY8e/QUpbxxvvckLkuOGjT0nPn1ziJk=;
        b=hW2nxZcO3fv36puXJ17rrZ4e8pEO9VzPAP6tV0XQlSoXg3Dy2UCV+nEob0ZhxSUiMc
         ATpGB+AwbD/oGLL8584PszDdFQzvLs34PRXmO9q6QyGERG9sanEgSMOUt/kdz4vItDyn
         1RlL9Lwed1s9gI+0ALDh4okEeg70H8WUBh6YQV3Se9cGKGsk+EHyfUDE9t3ZEPQarK1/
         WWZasfMQU4kGXd0LI0SG2nB4rn77ki89Dtx4mdLuOFBRAmaZio0AgpSYq+U5NFkwRyJn
         nM6BEv+O5iQB0gV9+VtZmAdYIx1RfrldMCjgLpf4IOQwslKEVZ0fnjeJbP30W15/erDS
         Zdzg==
X-Gm-Message-State: AOAM530WPsbz4BeU/MSNtEyF3d0tdCd/2WTrjErYzhJx9ZjFQkG3L5m2
        +PLF+51ja8orOFpZghphWFMR1UA1fiQLOwmlxD0=
X-Google-Smtp-Source: ABdhPJyItLqI3M7Wuy5C8RWqIMi8AhBalcelGpJXWII+kFLxD54RPRyehO0mDUCi8eqGE73c/Tl3DTUMSMeYG9W6+Xo=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr8113952pjb.129.1616326041879;
 Sun, 21 Mar 2021 04:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210320064509.119878-1-puranjay12@gmail.com> <20210320064509.119878-3-puranjay12@gmail.com>
 <CAHp75VdYU1VPGEHWii77wXnwp55aUd8FZ54yhO31fs_qzmTBSQ@mail.gmail.com>
In-Reply-To: <CAHp75VdYU1VPGEHWii77wXnwp55aUd8FZ54yhO31fs_qzmTBSQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 21 Mar 2021 13:27:05 +0200
Message-ID: <CAHp75VduaEDzmsPeGTHf6+3fx_RkDU9t_c4rM2Zt67VbO7ctqw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: temperature: add driver support for ti tmp117
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

(Seems it didn't make mailing list)

On Sat, Mar 20, 2021 at 10:55 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Saturday, March 20, 2021, Puranjay Mohan <puranjay12@gmail.com> wrote:
>>
>> TMP117 is a Digital temperature sensor with integrated NV memory.
>>
>> Add support for tmp117 driver in iio subsystem.
>>
>> Datasheet:-https://www.ti.com/lit/gpn/tmp117
>>
>
> No blank line is needed here
>
>
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>  drivers/iio/temperature/Kconfig  |  10 ++
>>  drivers/iio/temperature/Makefile |   1 +
>>  drivers/iio/temperature/tmp117.c | 182 +++++++++++++++++++++++++++++++
>>  3 files changed, 193 insertions(+)
>>  create mode 100644 drivers/iio/temperature/tmp117.c
>>
>> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/K=
config
>> index f1f2a1499..c5482983f 100644
>> --- a/drivers/iio/temperature/Kconfig
>> +++ b/drivers/iio/temperature/Kconfig
>> @@ -97,6 +97,16 @@ config TMP007
>>           This driver can also be built as a module. If so, the module w=
ill
>>           be called tmp007.
>>
>> +config TMP117
>> +       tristate "TMP117 Digital temperature sensor with integrated NV m=
emory"
>> +       depends on I2C
>> +       help
>> +         If you say yes here you get support for the Texas Instruments
>> +         TMP117 Digital temperature sensor with integrated NV memory.
>> +
>> +         This driver can also be built as a module. If so, the module w=
ill
>> +         be called tmp117.
>> +
>>  config TSYS01
>>         tristate "Measurement Specialties TSYS01 temperature sensor usin=
g I2C bus connection"
>>         depends on I2C
>> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/=
Makefile
>> index 90c113115..e3392c4b2 100644
>> --- a/drivers/iio/temperature/Makefile
>> +++ b/drivers/iio/temperature/Makefile
>> @@ -12,5 +12,6 @@ obj-$(CONFIG_MLX90614) +=3D mlx90614.o
>>  obj-$(CONFIG_MLX90632) +=3D mlx90632.o
>>  obj-$(CONFIG_TMP006) +=3D tmp006.o
>>  obj-$(CONFIG_TMP007) +=3D tmp007.o
>> +obj-$(CONFIG_TMP117) +=3D tmp117.o
>>  obj-$(CONFIG_TSYS01) +=3D tsys01.o
>>  obj-$(CONFIG_TSYS02D) +=3D tsys02d.o
>> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/=
tmp117.c
>> new file mode 100644
>> index 000000000..194820700
>> --- /dev/null
>> +++ b/drivers/iio/temperature/tmp117.c
>> @@ -0,0 +1,182 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * tmp117.c - Digital temperature sensor with integrated NV memory
>
>
> File name inside the file is redundant, remove it
>
>>
>> + *
>> + * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
>> + *
>> + * Driver for the Texas Instruments TMP117 Temperature Sensor
>> + *
>> + * (7-bit I2C slave address (0x48 - 0x4B), changeable via ADD pins)
>> + *
>> + * Note: This driver assumes that the sensor has been calibrated before=
hand.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/pm.h>
>
>
>>
>> +#include <linux/of.h>
>
>
> You should use mod_devicetable.h rather than of.h.
>
>>
>> +#include <linux/irq.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/events.h>
>
>
> Can you consider to use constants and /or formulas from units.h?
>
>>
>> +#define TMP117_REG_TEMP                        0x0
>> +#define TMP117_REG_CFGR                        0x1
>> +#define TMP117_REG_HIGH_LIM            0x2
>> +#define TMP117_REG_LOW_LIM             0x3
>> +#define TMP117_REG_EEPROM_UL           0x4
>> +#define TMP117_REG_EEPROM1             0x5
>> +#define TMP117_REG_EEPROM2             0x6
>> +#define TMP117_REG_TEMP_OFFSET         0x7
>> +#define TMP117_REG_EEPROM3             0x8
>> +#define TMP117_REG_DEVICE_ID           0xF
>> +
>> +#define TMP117_SCALE                   7812500       /* in uCelsius*/
>> +#define TMP117_RESOLUTION              78125
>> +#define TMP117_DEVICE_ID               0x0117
>> +
>> +struct tmp117_data {
>> +       struct i2c_client *client;
>> +       struct mutex lock;
>> +};
>> +
>> +static int tmp117_read_reg(struct tmp117_data *data, u8 reg)
>> +{
>> +       return i2c_smbus_read_word_swapped(data->client, reg);
>> +}
>> +
>> +static int tmp117_write_reg(struct tmp117_data *data, u8 reg, int val)
>> +{
>> +       return i2c_smbus_write_word_swapped(data->client, reg, val);
>> +}
>> +
>> +static int tmp117_read_raw(struct iio_dev *indio_dev,
>> +               struct iio_chan_spec const *channel, int *val,
>> +               int *val2, long mask)
>> +{
>> +       struct tmp117_data *data =3D iio_priv(indio_dev);
>> +       u16 tmp, off;
>> +
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               tmp =3D tmp117_read_reg(data, TMP117_REG_TEMP);
>> +               *val =3D tmp;
>> +               return IIO_VAL_INT;
>> +
>> +       case IIO_CHAN_INFO_CALIBBIAS:
>> +               off =3D tmp117_read_reg(data, TMP117_REG_TEMP_OFFSET);
>> +               *val =3D ((int16_t)off * (int32_t)TMP117_RESOLUTION) / 1=
0000000;
>> +               *val2 =3D ((int16_t)off * (int32_t)TMP117_RESOLUTION) % =
10000000;
>
>
> Often when you do explicit casting it means something was not well though=
t through. Consider to justify why you do explicit casting in each case and=
 drop where it=E2=80=99s not necessarily needed.
>
>>
>> +               return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +       case IIO_CHAN_INFO_SCALE:
>> +               *val =3D 0;
>> +               *val2 =3D TMP117_SCALE;
>> +               return IIO_VAL_INT_PLUS_NANO;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>> +static int tmp117_write_raw(struct iio_dev *indio_dev,
>> +               struct iio_chan_spec const *channel, int val,
>> +               int val2, long mask)
>> +{
>> +       struct tmp117_data *data =3D iio_priv(indio_dev);
>> +       u16 off;
>> +
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_CALIBBIAS:
>> +               off =3D ((val * 10000000) + (val2 * 10))
>> +                                               / (int32_t)TMP117_RESOLU=
TION;
>> +               return tmp117_write_reg(data, TMP117_REG_TEMP_OFFSET, of=
f);
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>> +static const struct iio_chan_spec tmp117_channels[] =3D {
>> +       {
>> +               .type =3D IIO_TEMP,
>> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>> +                       BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO=
_SCALE),
>> +       },
>> +};
>> +
>> +static const struct iio_info tmp117_info =3D {
>> +       .read_raw =3D tmp117_read_raw,
>> +       .write_raw =3D tmp117_write_raw,
>> +};
>> +
>> +static bool tmp117_identify(struct i2c_client *client)
>> +{
>> +       int dev_id;
>> +
>> +       dev_id =3D i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE=
_ID);
>> +       if (dev_id < 0)
>> +               return false;
>> +
>> +       return (dev_id =3D=3D TMP117_DEVICE_ID);
>> +}
>> +
>> +static int tmp117_probe(struct i2c_client *client,
>> +                       const struct i2c_device_id *tmp117_id)
>> +{
>> +       struct tmp117_data *data;
>> +       struct iio_dev *indio_dev;
>> +
>> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WOR=
D_DATA))
>> +               return -EOPNOTSUPP;
>> +
>> +       if (!tmp117_identify(client)) {
>> +               dev_err(&client->dev, "TMP117 not found\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data))=
;
>> +       if (!indio_dev)
>> +               return -ENOMEM;
>> +
>> +       data =3D iio_priv(indio_dev);
>> +       data->client =3D client;
>> +       mutex_init(&data->lock);
>> +
>> +       indio_dev->name =3D "tmp117";
>> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +       indio_dev->info =3D &tmp117_info;
>> +
>> +       indio_dev->channels =3D tmp117_channels;
>> +       indio_dev->num_channels =3D ARRAY_SIZE(tmp117_channels);
>> +
>> +       return devm_iio_device_register(&client->dev, indio_dev);
>> +}
>> +
>> +static const struct of_device_id tmp117_of_match[] =3D {
>> +       { .compatible =3D "ti,tmp117", },
>
>
>>
>> +       { },
>
>
> No comma for terminator line
>
>>
>> +};
>> +MODULE_DEVICE_TABLE(of, tmp117_of_match);
>> +
>> +static const struct i2c_device_id tmp117_id[] =3D {
>> +       { "tmp117", 0 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, tmp117_id);
>> +
>> +static struct i2c_driver tmp117_driver =3D {
>> +       .driver =3D {
>> +               .name   =3D "tmp117",
>> +               .of_match_table =3D of_match_ptr(tmp117_of_match),
>> +       },
>> +       .probe          =3D tmp117_probe,
>> +       .id_table       =3D tmp117_id,
>> +};
>> +module_i2c_driver(tmp117_driver);
>> +
>> +MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
>> +MODULE_DESCRIPTION("TI TMP117 Temperature sensor driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.30.1
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
With Best Regards,
Andy Shevchenko
