Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0D44FF38
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 08:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhKOHdV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 02:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKOHdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 02:33:17 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BADC061746;
        Sun, 14 Nov 2021 23:30:22 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id n6so16339716uak.1;
        Sun, 14 Nov 2021 23:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1su6iA46WyFetS4ZI0bp7XINkatMdXDdw1i0/lyrVEA=;
        b=Jrk3hcsrX/me/i9TrETBvNnGZMwYE6E4CJ/izt7Aae1ZJmbkJwaei5JcgdCvd/IdE6
         KGagX3F7XJW/s7yLDfxJJoxWCrXIiapGUOvHt9K/9Rw3nUXjrSVlpTajHYhd3kXLyS6N
         zA0i1a9Y6wP6LCvQVYwkLv38l5MMM1ZiNd3W0JCmHYXvV5H39+GzXb9SX0cMMN6v5FqM
         OjlNbhmh1zzDLHJfqurCbQGcTqttc+kcaERd86THc/0gFCs5G64MxSZSX3r97ClFotF2
         ixTxf+fifQELPj167e4p1VE8rpGxTvvfnkmjQlWGRjyFdraJej7qwBmutyGp70vUqL74
         x1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1su6iA46WyFetS4ZI0bp7XINkatMdXDdw1i0/lyrVEA=;
        b=cVO+WqcV3m+Y8u4yYXMh+TLVBDHYwC6Lo3+j85ijYbwUm0uhOmo/EVHJ3rHJZvCh4p
         x6OPqjNMoK+iFivrWrUbdZnL7FNxDR8aDCIoPC1oC+Gkwus60PzXACOfPGxj9dx+nFaw
         XR95cwCjLG/n3GqC5MhjbhVPvfohD46K3MZNxTF7oXA8aUuGj5IsMoBdcWZT9VVVKJSc
         6FGqBfky/93bXK4y71L1DdS1rrvm87l8J3/nelJUj3qJ8+XDQg7pMhHIRCRxkhlKynMN
         IkcTz9yLhPgbpCvLvVY1EixTMokLRig/5XYM5B2lPfnxATKG4bnGCue+33t1quLy5USC
         X3gA==
X-Gm-Message-State: AOAM533PLLCelxMM9qXohtfQNs4RaFpdOCIlHtteDvOo4g9W44a6tiJW
        51w1iOYXjIK6X8Y6qMA10Um2yvlCh+hbnCgKol/h3Aj3
X-Google-Smtp-Source: ABdhPJxOtSWE6ZPFl63nFH1tnx7de41xfmZibd3YbdZs22eZAKxu+9/Cju8vcCai9OgIoXwMV0Vtl3nUUIMypWV+quw=
X-Received: by 2002:a67:df07:: with SMTP id s7mr39994709vsk.42.1636961421166;
 Sun, 14 Nov 2021 23:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20211114132335.47651-1-gilles.talis@gmail.com>
 <20211114132335.47651-2-gilles.talis@gmail.com> <b86bd1eb-8c05-2c54-4e05-e5d72ba3a890@metafoo.de>
 <CAKcgs2x7FCf8xBj-PQ62UQNgkxBjFfQznEVCysNO547Yr5Ct3w@mail.gmail.com> <20211114164942.32b60952@jic23-huawei>
In-Reply-To: <20211114164942.32b60952@jic23-huawei>
From:   Gilles Talis <gilles.talis@gmail.com>
Date:   Mon, 15 Nov 2021 08:29:57 +0100
Message-ID: <CAKcgs2xw8B9gkoihMtGAWWf8aj33vR68DrZvUv1rbQn091NyoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: humidity: Add support for Sensirion SHTC3 sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, pmeerw@pmeerw.net,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le dim. 14 nov. 2021 =C3=A0 17:44, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
>
> On Sun, 14 Nov 2021 15:58:15 +0100
> Gilles Talis <gilles.talis@gmail.com> wrote:
>
> > Hi Lars,
> >
> > Le dim. 14 nov. 2021 =C3=A0 14:47, Lars-Peter Clausen <lars@metafoo.de>=
 a =C3=A9crit :
> >
> > > On 11/14/21 2:23 PM, Gilles Talis wrote:
> > > > The SHTC3 is a digital humidity and temperature sensor.
> > > > It covers humidity measurement range from 0 to 100% relative humidi=
ty
> > > > and temperature measurement range from -45 to 125 deg C.
> > > >
> > > > Datasheet: https://www.sensirion.com/file/datasheet_shtc3
> > > >
> > > > Signed-off-by: Gilles Talis <gilles.talis@gmail.com>
> > >
> > > Hi,
> > >
> > > Thanks for the path. This looks really good, very well written driver=
.
> > >
> > > But we already have support for the shtc3 in the Linux kernel as part=
 of
> > > the hwmon framework, see drivers/hwmon/shtc1.c.
> > >
> > > - Lars
> > >
> > Thanks for the review. Oops, I should have been more careful. Next time=
, I
> > will try to be.
> > Sorry for the spamming.
>
> The fun question of whether humidity drivers should be in IIO or HWMON wa=
s my
> fault many years ago.  Pre IIO being anywhere near ready for mainline (an=
d mostly
> a concept rather than code) I wanted to get at least one of the drivers I=
 was
> working with upstream and the characteristics of humidity drivers were ra=
ther
> different from ADCs and Accelerometers etc so I asked if Humidty counted =
as
> hardware monitoring and got something like "sure it could be" as a reply =
so
> upstreamed one driver in hwmon (sht15).
>
> Ever since it's been a bit random on where humidity drivers end up based =
on
> who is submitting them and their usecase + most similar drivers already u=
pstream.
>
> Sorry you fell into this historical quirk!
No problem. Thanks for taking the time to explain the history. Next
time, I will make sure I also look in other subsystems before
submitting such a driver.

>
> I took a quick look and agree with Lars: nice clean driver, but as you ca=
n guess
> we don't really want 2 drivers and there isn't a strong reason to propose
> moving this one between subsystems.
This obviously makes no sense having 2 drivers for this device. Thanks
for the review and the kind words.

>
> Thanks,
>
> Jonathan
Thanks,

Gilles.

>
> >
> > Thanks!
> > Gilles.
> >
> >
> >
> > >
> > > > ---
> > > >   drivers/iio/humidity/Kconfig  |  11 ++
> > > >   drivers/iio/humidity/Makefile |   1 +
> > > >   drivers/iio/humidity/shtc3.c  | 286 +++++++++++++++++++++++++++++=
+++++
> > > >   3 files changed, 298 insertions(+)
> > > >   create mode 100644 drivers/iio/humidity/shtc3.c
> > > >
> > > > diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kc=
onfig
> > > > index 2de5494e7c22..7aab6141c64b 100644
> > > > --- a/drivers/iio/humidity/Kconfig
> > > > +++ b/drivers/iio/humidity/Kconfig
> > > > @@ -98,6 +98,17 @@ config HTU21
> > > >         This driver can also be built as a module. If so, the modul=
e will
> > > >         be called htu21.
> > > >
> > > > +config SHTC3
> > > > +     tristate "Sensirion SHTC3 humidity and temperature sensor"
> > > > +     depends on I2C
> > > > +     select CRC8
> > > > +     help
> > > > +       Say yes here to build support for the Sensirion SHTC3
> > > > +       humidity and temperature sensor.
> > > > +
> > > > +       To compile this driver as a module, choose M here: the modu=
le
> > > > +       will be called shtc3.
> > > > +
> > > >   config SI7005
> > > >       tristate "SI7005 relative humidity and temperature sensor"
> > > >       depends on I2C
> > > > diff --git a/drivers/iio/humidity/Makefile
> > > b/drivers/iio/humidity/Makefile
> > > > index f19ff3de97c5..13020dfad1b3 100644
> > > > --- a/drivers/iio/humidity/Makefile
> > > > +++ b/drivers/iio/humidity/Makefile
> > > > @@ -16,6 +16,7 @@ obj-$(CONFIG_HTS221_I2C) +=3D hts221_i2c.o
> > > >   obj-$(CONFIG_HTS221_SPI) +=3D hts221_spi.o
> > > >
> > > >   obj-$(CONFIG_HTU21) +=3D htu21.o
> > > > +obj-$(CONFIG_SHTC3) +=3D shtc3.o
> > > >   obj-$(CONFIG_SI7005) +=3D si7005.o
> > > >   obj-$(CONFIG_SI7020) +=3D si7020.o
> > > >
> > > > diff --git a/drivers/iio/humidity/shtc3.c b/drivers/iio/humidity/sh=
tc3.c
> > > > new file mode 100644
> > > > index 000000000000..ec3d7215e378
> > > > --- /dev/null
> > > > +++ b/drivers/iio/humidity/shtc3.c
> > > > @@ -0,0 +1,286 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Sensirion SHTC3 Humidity and Temperature Sensor
> > > > + *
> > > > + * Copyright (c) 2021 Gilles Talis <gilles.talis@gmail.com>
> > > > + *
> > > > + * Datasheet: https://www.sensirion.com/file/datasheet_shtc3
> > > > + *
> > > > + * I2C slave address: 0x70
> > > > + */
> > > > +
> > > > +#include <linux/crc8.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +
> > > > +#include <linux/iio/iio.h>
> > > > +
> > > > +#define SHTC3_CMD(cmd_word)          cpu_to_be16(cmd_word)
> > > > +#define SHTC3_CMD_LEN                        2
> > > > +
> > > > +#define SHTC3_ID_MASK                        0x083F
> > > > +#define SHTC3_ID                     0x0807
> > > > +
> > > > +#define SHTC3_CRC8_POLYNOMIAL                0x31
> > > > +
> > > > +enum shtc3_cmd {
> > > > +     SHTC3_CMD_GET_ID                =3D SHTC3_CMD(0xEFC8),
> > > > +     SHTC3_CMD_SOFT_RESET            =3D SHTC3_CMD(0x805D),
> > > > +     SHTC3_CMD_SLEEP                 =3D SHTC3_CMD(0xB098),
> > > > +     SHTC3_CMD_WAKEUP                =3D SHTC3_CMD(0x3517),
> > > > +     /*
> > > > +      * Run measurement, low-power mode, clock stretching
> > > > +      * temperature first
> > > > +      */
> > > > +     SHTC3_CMD_TEMP_MEAS_LP_CS       =3D SHTC3_CMD(0x6458),
> > > > +     /*
> > > > +      * Run measurement, low-power mode, clock stretching
> > > > +      * relative humidity first
> > > > +      */
> > > > +     SHTC3_CMD_RH_MEAS_LP_CS         =3D SHTC3_CMD(0x44DE),
> > > > +};
> > > > +
> > > > +DECLARE_CRC8_TABLE(shtc3_crc8_tbl);
> > > > +
> > > > +struct shtc3_rx_data {
> > > > +     __be16  data;
> > > > +     u8      crc;
> > > > +} __packed;
> > > > +
> > > > +static int shtc3_send_cmd(struct i2c_client *client, u16 cmd, u16 =
*data)
> > > > +{
> > > > +     int ret;
> > > > +     struct shtc3_rx_data rx_data;
> > > > +     u8 crc;
> > > > +
> > > > +     ret =3D i2c_master_send(client, (const char *)&cmd, SHTC3_CMD=
_LEN);
> > > > +     if (ret !=3D SHTC3_CMD_LEN)
>
> That might eat another error, so convention is to check ret < 0 first and=
 then
> check the length. That way you can return a more informative error if the=
re
> is one.   I see you do that on the recv below.
>
> > > > +             return -EIO;
> > > > +
> > > > +     /*
> > > > +      * This is used to read temperature and humidity measurements
> > > > +      * as well as the sensor ID.
> > > > +      * Sensor sends 2 bytes of data followed by one byte of CRC
> > > > +      */
> > > > +     if (data) {
> > > > +             ret =3D i2c_master_recv(client, (u8 *) &rx_data,
> > > > +                                     sizeof(struct shtc3_rx_data))=
;
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +             if (ret !=3D sizeof(struct shtc3_rx_data))
> > > > +                     return -EIO;
> > > > +
> > > > +             crc =3D crc8(shtc3_crc8_tbl, (u8 *)&rx_data.data,
> > > > +                         2, CRC8_INIT_VALUE);
> > > > +             if (crc !=3D rx_data.crc)
> > > > +                     return -EIO;
> > > > +
> > > > +             *data =3D be16_to_cpu(rx_data.data);
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int shtc3_sleep(struct i2c_client *client)
> > > > +{
> > > > +     return shtc3_send_cmd(client, SHTC3_CMD_SLEEP, 0);
> > > > +}
> > > > +
> > > > +static int shtc3_wakeup(struct i2c_client *client)
> > > > +{
> > > > +     if (shtc3_send_cmd(client, SHTC3_CMD_WAKEUP, 0) < 0)
> > > > +             return -EIO;
> > > > +
> > > > +     /* Wait for device to wake up */
> > > > +     usleep_range(180, 240);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int shtc3_read_channel(struct i2c_client *client, bool temp=
)
> > > > +{
> > > > +     int ret;
> > > > +     u16 cmd;
> > > > +     u16 meas;
> > > > +
> > > > +     ret =3D shtc3_wakeup(client);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     /*
> > > > +      * Sensor sends back measurement results after measurement co=
mmand
> > > > +      * has been issued by the host.
> > > > +      * Sensor sends 3 bytes (2 bytes of data + 1 byte of CRC) for=
 each
> > > > +      * channel sequentially
> > > > +      * The command issued by the host determines the channel for =
which
> > > > +      * the sensor will first send the data.
> > > > +      * We select the channel for which we need the results
> > > > +      * then only read back the 2 bytes corresponding to this chan=
nel.
> > > > +      */
> > > > +     cmd =3D temp ? SHTC3_CMD_TEMP_MEAS_LP_CS : SHTC3_CMD_RH_MEAS_=
LP_CS;
> > > > +     ret =3D shtc3_send_cmd(client, cmd, &meas);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     /* Go back to sleep */
> > > > +     shtc3_sleep(client);
> > > > +
> > > > +     return meas;
> > > > +}
> > > > +
> > > > +static int shtc3_read_raw(struct iio_dev *indio_dev,
> > > > +                        struct iio_chan_spec const *chan, int *val=
,
> > > > +                        int *val2, long mask)
> > > > +{
> > > > +     struct i2c_client **client =3D iio_priv(indio_dev);
> > > > +     int ret;
> > > > +
> > > > +     switch (mask) {
> > > > +     case IIO_CHAN_INFO_RAW:
> > > > +             ret =3D shtc3_read_channel(*client, (chan->type =3D=
=3D
> > > IIO_TEMP));
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +             *val =3D ret;
> > > > +             return IIO_VAL_INT;
> > > > +     case IIO_CHAN_INFO_SCALE:
> > > > +             if (chan->type =3D=3D IIO_TEMP) {
> > > > +                     *val =3D 2;
> > > > +                     *val2 =3D 670000;
> > > > +             } else {
> > > > +                     *val =3D 0;
> > > > +                     *val2 =3D 1525;
> > > > +             }
> > > > +             return IIO_VAL_INT_PLUS_MICRO;
> > > > +     case IIO_CHAN_INFO_OFFSET:
> > > > +             *val =3D -16852;
> > > > +             return IIO_VAL_INT;
> > > > +     default:
> > > > +             break;
> > > > +     }
> > > > +
> > > > +     return -EINVAL;
>
> I'd move this into the default: statement as saves a few lines and makes =
it
> slightly easier to read.
>
> > > > +}
> > > > +
> > > > +static const struct iio_chan_spec shtc3_channels[] =3D {
> > > > +     {
> > > > +             .type =3D IIO_HUMIDITYRELATIVE,
> > > > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > > +                     BIT(IIO_CHAN_INFO_SCALE),
> > > > +     },
> > > > +     {
> > > > +             .type =3D IIO_TEMP,
> > > > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > > +                     BIT(IIO_CHAN_INFO_SCALE) |
> > > BIT(IIO_CHAN_INFO_OFFSET),
> > > > +     }
> > > > +};
> > > > +
> > > > +static const struct iio_info shtc3_info =3D {
> > > > +     .read_raw =3D shtc3_read_raw,
> > > > +};
> > > > +
> > > > +static int shtc3_verify_id(struct i2c_client *client)
> > > > +{
> > > > +     int ret;
> > > > +     u16 device_id;
> > > > +     u16 reg_val;
> > > > +
> > > > +     ret =3D shtc3_send_cmd(client, SHTC3_CMD_GET_ID, &reg_val);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     device_id =3D reg_val & SHTC3_ID_MASK;
> > > > +     if (device_id !=3D SHTC3_ID)
> > > > +             return -ENODEV;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int shtc3_reset(struct i2c_client *client)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     ret =3D shtc3_send_cmd(client, SHTC3_CMD_SOFT_RESET, 0);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     /* Wait for device to enter idle state */
> > > > +     usleep_range(180, 240);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int shtc3_setup(struct i2c_client *client)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     ret =3D shtc3_verify_id(client);
> > > > +     if (ret < 0) {
> > > > +             dev_err(&client->dev, "SHTC3 not found\n");
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     ret =3D shtc3_reset(client);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     return shtc3_sleep(client);
> > > > +}
> > > > +
> > > > +static int shtc3_probe(struct i2c_client *client,
> > > > +                     const struct i2c_device_id *id)
> > > > +{
> > > > +     struct iio_dev *indio_dev;
> > > > +     struct i2c_client **data;
> > > > +     int ret;
> > > > +
> > > > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*dat=
a));
> > > > +     if (!indio_dev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     data =3D iio_priv(indio_dev);
> > > > +     *data =3D client;
>
> It's normally better to put a structure in there because the chances
> of a later change requiring more data is rather high...
>
> Obviously for now it will only have one element so will end up
> compiling to pretty much the same you have here.
>
> > > > +
> > > > +     indio_dev->name =3D dev_name(&client->dev);
> > > > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > +     indio_dev->info =3D &shtc3_info;
> > > > +     indio_dev->channels =3D shtc3_channels;
> > > > +     indio_dev->num_channels =3D ARRAY_SIZE(shtc3_channels);
> > > > +
> > > > +     crc8_populate_msb(shtc3_crc8_tbl, SHTC3_CRC8_POLYNOMIAL);
> > > > +
> > > > +     ret =3D shtc3_setup(client);
> > > > +     if (ret < 0) {
> > > > +             dev_err(&client->dev, "SHTC3 setup failed\n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     return devm_iio_device_register(&client->dev, indio_dev);
> > > > +}
> > > > +
> > > > +static const struct i2c_device_id shtc3_id[] =3D {
> > > > +     { "shtc3", 0 },
> > > > +     { }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, shtc3_id);
> > > > +
> > > > +static const struct of_device_id shtc3_dt_ids[] =3D {
> > > > +     { .compatible =3D "sensirion,shtc3" },
> > > > +     { }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, shtc3_dt_ids);
> > > > +
> > > > +static struct i2c_driver shtc3_driver =3D {
> > > > +     .driver =3D {
> > > > +             .name =3D "shtc3",
> > > > +             .of_match_table =3D shtc3_dt_ids,
> > > > +     },
> > > > +     .probe          =3D shtc3_probe,
> > > > +     .id_table       =3D shtc3_id,
> > > > +};
> > > > +
> > > > +module_i2c_driver(shtc3_driver);
> > > > +MODULE_DESCRIPTION("Sensirion SHTC3 Humidity and Temperature Senso=
r");
> > > > +MODULE_AUTHOR("Gilles Talis <gilles.talis@gmail.com>");
> > > > +MODULE_LICENSE("GPL");
> > >
> > >
> > >
>
