Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8844F922
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 17:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhKNQrx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 14 Nov 2021 11:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhKNQrw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 11:47:52 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A44610FE;
        Sun, 14 Nov 2021 16:44:55 +0000 (UTC)
Date:   Sun, 14 Nov 2021 16:49:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gilles Talis <gilles.talis@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, pmeerw@pmeerw.net,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: humidity: Add support for Sensirion SHTC3
 sensor
Message-ID: <20211114164942.32b60952@jic23-huawei>
In-Reply-To: <CAKcgs2x7FCf8xBj-PQ62UQNgkxBjFfQznEVCysNO547Yr5Ct3w@mail.gmail.com>
References: <20211114132335.47651-1-gilles.talis@gmail.com>
        <20211114132335.47651-2-gilles.talis@gmail.com>
        <b86bd1eb-8c05-2c54-4e05-e5d72ba3a890@metafoo.de>
        <CAKcgs2x7FCf8xBj-PQ62UQNgkxBjFfQznEVCysNO547Yr5Ct3w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Nov 2021 15:58:15 +0100
Gilles Talis <gilles.talis@gmail.com> wrote:

> Hi Lars,
> 
> Le dim. 14 nov. 2021 à 14:47, Lars-Peter Clausen <lars@metafoo.de> a écrit :
> 
> > On 11/14/21 2:23 PM, Gilles Talis wrote:  
> > > The SHTC3 is a digital humidity and temperature sensor.
> > > It covers humidity measurement range from 0 to 100% relative humidity
> > > and temperature measurement range from -45 to 125 deg C.
> > >
> > > Datasheet: https://www.sensirion.com/file/datasheet_shtc3
> > >
> > > Signed-off-by: Gilles Talis <gilles.talis@gmail.com>  
> >
> > Hi,
> >
> > Thanks for the path. This looks really good, very well written driver.
> >
> > But we already have support for the shtc3 in the Linux kernel as part of
> > the hwmon framework, see drivers/hwmon/shtc1.c.
> >
> > - Lars
> >  
> Thanks for the review. Oops, I should have been more careful. Next time, I
> will try to be.
> Sorry for the spamming.

The fun question of whether humidity drivers should be in IIO or HWMON was my
fault many years ago.  Pre IIO being anywhere near ready for mainline (and mostly
a concept rather than code) I wanted to get at least one of the drivers I was
working with upstream and the characteristics of humidity drivers were rather
different from ADCs and Accelerometers etc so I asked if Humidty counted as
hardware monitoring and got something like "sure it could be" as a reply so
upstreamed one driver in hwmon (sht15).

Ever since it's been a bit random on where humidity drivers end up based on
who is submitting them and their usecase + most similar drivers already upstream.

Sorry you fell into this historical quirk!

I took a quick look and agree with Lars: nice clean driver, but as you can guess
we don't really want 2 drivers and there isn't a strong reason to propose
moving this one between subsystems.

Thanks,

Jonathan

> 
> Thanks!
> Gilles.
> 
> 
> 
> >  
> > > ---
> > >   drivers/iio/humidity/Kconfig  |  11 ++
> > >   drivers/iio/humidity/Makefile |   1 +
> > >   drivers/iio/humidity/shtc3.c  | 286 ++++++++++++++++++++++++++++++++++
> > >   3 files changed, 298 insertions(+)
> > >   create mode 100644 drivers/iio/humidity/shtc3.c
> > >
> > > diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> > > index 2de5494e7c22..7aab6141c64b 100644
> > > --- a/drivers/iio/humidity/Kconfig
> > > +++ b/drivers/iio/humidity/Kconfig
> > > @@ -98,6 +98,17 @@ config HTU21
> > >         This driver can also be built as a module. If so, the module will
> > >         be called htu21.
> > >
> > > +config SHTC3
> > > +     tristate "Sensirion SHTC3 humidity and temperature sensor"
> > > +     depends on I2C
> > > +     select CRC8
> > > +     help
> > > +       Say yes here to build support for the Sensirion SHTC3
> > > +       humidity and temperature sensor.
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called shtc3.
> > > +
> > >   config SI7005
> > >       tristate "SI7005 relative humidity and temperature sensor"
> > >       depends on I2C
> > > diff --git a/drivers/iio/humidity/Makefile  
> > b/drivers/iio/humidity/Makefile  
> > > index f19ff3de97c5..13020dfad1b3 100644
> > > --- a/drivers/iio/humidity/Makefile
> > > +++ b/drivers/iio/humidity/Makefile
> > > @@ -16,6 +16,7 @@ obj-$(CONFIG_HTS221_I2C) += hts221_i2c.o
> > >   obj-$(CONFIG_HTS221_SPI) += hts221_spi.o
> > >
> > >   obj-$(CONFIG_HTU21) += htu21.o
> > > +obj-$(CONFIG_SHTC3) += shtc3.o
> > >   obj-$(CONFIG_SI7005) += si7005.o
> > >   obj-$(CONFIG_SI7020) += si7020.o
> > >
> > > diff --git a/drivers/iio/humidity/shtc3.c b/drivers/iio/humidity/shtc3.c
> > > new file mode 100644
> > > index 000000000000..ec3d7215e378
> > > --- /dev/null
> > > +++ b/drivers/iio/humidity/shtc3.c
> > > @@ -0,0 +1,286 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Sensirion SHTC3 Humidity and Temperature Sensor
> > > + *
> > > + * Copyright (c) 2021 Gilles Talis <gilles.talis@gmail.com>
> > > + *
> > > + * Datasheet: https://www.sensirion.com/file/datasheet_shtc3
> > > + *
> > > + * I2C slave address: 0x70
> > > + */
> > > +
> > > +#include <linux/crc8.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mod_devicetable.h>
> > > +
> > > +#include <linux/iio/iio.h>
> > > +
> > > +#define SHTC3_CMD(cmd_word)          cpu_to_be16(cmd_word)
> > > +#define SHTC3_CMD_LEN                        2
> > > +
> > > +#define SHTC3_ID_MASK                        0x083F
> > > +#define SHTC3_ID                     0x0807
> > > +
> > > +#define SHTC3_CRC8_POLYNOMIAL                0x31
> > > +
> > > +enum shtc3_cmd {
> > > +     SHTC3_CMD_GET_ID                = SHTC3_CMD(0xEFC8),
> > > +     SHTC3_CMD_SOFT_RESET            = SHTC3_CMD(0x805D),
> > > +     SHTC3_CMD_SLEEP                 = SHTC3_CMD(0xB098),
> > > +     SHTC3_CMD_WAKEUP                = SHTC3_CMD(0x3517),
> > > +     /*
> > > +      * Run measurement, low-power mode, clock stretching
> > > +      * temperature first
> > > +      */
> > > +     SHTC3_CMD_TEMP_MEAS_LP_CS       = SHTC3_CMD(0x6458),
> > > +     /*
> > > +      * Run measurement, low-power mode, clock stretching
> > > +      * relative humidity first
> > > +      */
> > > +     SHTC3_CMD_RH_MEAS_LP_CS         = SHTC3_CMD(0x44DE),
> > > +};
> > > +
> > > +DECLARE_CRC8_TABLE(shtc3_crc8_tbl);
> > > +
> > > +struct shtc3_rx_data {
> > > +     __be16  data;
> > > +     u8      crc;
> > > +} __packed;
> > > +
> > > +static int shtc3_send_cmd(struct i2c_client *client, u16 cmd, u16 *data)
> > > +{
> > > +     int ret;
> > > +     struct shtc3_rx_data rx_data;
> > > +     u8 crc;
> > > +
> > > +     ret = i2c_master_send(client, (const char *)&cmd, SHTC3_CMD_LEN);
> > > +     if (ret != SHTC3_CMD_LEN)

That might eat another error, so convention is to check ret < 0 first and then
check the length. That way you can return a more informative error if there
is one.   I see you do that on the recv below.

> > > +             return -EIO;
> > > +
> > > +     /*
> > > +      * This is used to read temperature and humidity measurements
> > > +      * as well as the sensor ID.
> > > +      * Sensor sends 2 bytes of data followed by one byte of CRC
> > > +      */
> > > +     if (data) {
> > > +             ret = i2c_master_recv(client, (u8 *) &rx_data,
> > > +                                     sizeof(struct shtc3_rx_data));
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +             if (ret != sizeof(struct shtc3_rx_data))
> > > +                     return -EIO;
> > > +
> > > +             crc = crc8(shtc3_crc8_tbl, (u8 *)&rx_data.data,
> > > +                         2, CRC8_INIT_VALUE);
> > > +             if (crc != rx_data.crc)
> > > +                     return -EIO;
> > > +
> > > +             *data = be16_to_cpu(rx_data.data);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int shtc3_sleep(struct i2c_client *client)
> > > +{
> > > +     return shtc3_send_cmd(client, SHTC3_CMD_SLEEP, 0);
> > > +}
> > > +
> > > +static int shtc3_wakeup(struct i2c_client *client)
> > > +{
> > > +     if (shtc3_send_cmd(client, SHTC3_CMD_WAKEUP, 0) < 0)
> > > +             return -EIO;
> > > +
> > > +     /* Wait for device to wake up */
> > > +     usleep_range(180, 240);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int shtc3_read_channel(struct i2c_client *client, bool temp)
> > > +{
> > > +     int ret;
> > > +     u16 cmd;
> > > +     u16 meas;
> > > +
> > > +     ret = shtc3_wakeup(client);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /*
> > > +      * Sensor sends back measurement results after measurement command
> > > +      * has been issued by the host.
> > > +      * Sensor sends 3 bytes (2 bytes of data + 1 byte of CRC) for each
> > > +      * channel sequentially
> > > +      * The command issued by the host determines the channel for which
> > > +      * the sensor will first send the data.
> > > +      * We select the channel for which we need the results
> > > +      * then only read back the 2 bytes corresponding to this channel.
> > > +      */
> > > +     cmd = temp ? SHTC3_CMD_TEMP_MEAS_LP_CS : SHTC3_CMD_RH_MEAS_LP_CS;
> > > +     ret = shtc3_send_cmd(client, cmd, &meas);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* Go back to sleep */
> > > +     shtc3_sleep(client);
> > > +
> > > +     return meas;
> > > +}
> > > +
> > > +static int shtc3_read_raw(struct iio_dev *indio_dev,
> > > +                        struct iio_chan_spec const *chan, int *val,
> > > +                        int *val2, long mask)
> > > +{
> > > +     struct i2c_client **client = iio_priv(indio_dev);
> > > +     int ret;
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_RAW:
> > > +             ret = shtc3_read_channel(*client, (chan->type ==  
> > IIO_TEMP));  
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +             *val = ret;
> > > +             return IIO_VAL_INT;
> > > +     case IIO_CHAN_INFO_SCALE:
> > > +             if (chan->type == IIO_TEMP) {
> > > +                     *val = 2;
> > > +                     *val2 = 670000;
> > > +             } else {
> > > +                     *val = 0;
> > > +                     *val2 = 1525;
> > > +             }
> > > +             return IIO_VAL_INT_PLUS_MICRO;
> > > +     case IIO_CHAN_INFO_OFFSET:
> > > +             *val = -16852;
> > > +             return IIO_VAL_INT;
> > > +     default:
> > > +             break;
> > > +     }
> > > +
> > > +     return -EINVAL;

I'd move this into the default: statement as saves a few lines and makes it
slightly easier to read.

> > > +}
> > > +
> > > +static const struct iio_chan_spec shtc3_channels[] = {
> > > +     {
> > > +             .type = IIO_HUMIDITYRELATIVE,
> > > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > +                     BIT(IIO_CHAN_INFO_SCALE),
> > > +     },
> > > +     {
> > > +             .type = IIO_TEMP,
> > > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > +                     BIT(IIO_CHAN_INFO_SCALE) |  
> > BIT(IIO_CHAN_INFO_OFFSET),  
> > > +     }
> > > +};
> > > +
> > > +static const struct iio_info shtc3_info = {
> > > +     .read_raw = shtc3_read_raw,
> > > +};
> > > +
> > > +static int shtc3_verify_id(struct i2c_client *client)
> > > +{
> > > +     int ret;
> > > +     u16 device_id;
> > > +     u16 reg_val;
> > > +
> > > +     ret = shtc3_send_cmd(client, SHTC3_CMD_GET_ID, &reg_val);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     device_id = reg_val & SHTC3_ID_MASK;
> > > +     if (device_id != SHTC3_ID)
> > > +             return -ENODEV;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int shtc3_reset(struct i2c_client *client)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret = shtc3_send_cmd(client, SHTC3_CMD_SOFT_RESET, 0);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* Wait for device to enter idle state */
> > > +     usleep_range(180, 240);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int shtc3_setup(struct i2c_client *client)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret = shtc3_verify_id(client);
> > > +     if (ret < 0) {
> > > +             dev_err(&client->dev, "SHTC3 not found\n");
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     ret = shtc3_reset(client);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     return shtc3_sleep(client);
> > > +}
> > > +
> > > +static int shtc3_probe(struct i2c_client *client,
> > > +                     const struct i2c_device_id *id)
> > > +{
> > > +     struct iio_dev *indio_dev;
> > > +     struct i2c_client **data;
> > > +     int ret;
> > > +
> > > +     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     data = iio_priv(indio_dev);
> > > +     *data = client;

It's normally better to put a structure in there because the chances
of a later change requiring more data is rather high...

Obviously for now it will only have one element so will end up
compiling to pretty much the same you have here.

> > > +
> > > +     indio_dev->name = dev_name(&client->dev);
> > > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > > +     indio_dev->info = &shtc3_info;
> > > +     indio_dev->channels = shtc3_channels;
> > > +     indio_dev->num_channels = ARRAY_SIZE(shtc3_channels);
> > > +
> > > +     crc8_populate_msb(shtc3_crc8_tbl, SHTC3_CRC8_POLYNOMIAL);
> > > +
> > > +     ret = shtc3_setup(client);
> > > +     if (ret < 0) {
> > > +             dev_err(&client->dev, "SHTC3 setup failed\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     return devm_iio_device_register(&client->dev, indio_dev);
> > > +}
> > > +
> > > +static const struct i2c_device_id shtc3_id[] = {
> > > +     { "shtc3", 0 },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, shtc3_id);
> > > +
> > > +static const struct of_device_id shtc3_dt_ids[] = {
> > > +     { .compatible = "sensirion,shtc3" },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, shtc3_dt_ids);
> > > +
> > > +static struct i2c_driver shtc3_driver = {
> > > +     .driver = {
> > > +             .name = "shtc3",
> > > +             .of_match_table = shtc3_dt_ids,
> > > +     },
> > > +     .probe          = shtc3_probe,
> > > +     .id_table       = shtc3_id,
> > > +};
> > > +
> > > +module_i2c_driver(shtc3_driver);
> > > +MODULE_DESCRIPTION("Sensirion SHTC3 Humidity and Temperature Sensor");
> > > +MODULE_AUTHOR("Gilles Talis <gilles.talis@gmail.com>");
> > > +MODULE_LICENSE("GPL");  
> >
> >
> >  

