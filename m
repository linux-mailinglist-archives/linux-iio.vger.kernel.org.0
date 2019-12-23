Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C67129893
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLWQHU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:07:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfLWQHU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:07:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1B720709;
        Mon, 23 Dec 2019 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577117238;
        bh=dclOm5X7tzyxFdFo5/QU7uQRdeh+d6aim3T0acYaJdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lir79hHoSwGIzPxe4h6+GqqVzwCnEiFd8ErHY3fYMJm2ChvmMN5KMlILPCPiy9UFc
         prl67wJxcfvNTdXrfUIRH2oBjSzm4UnFvkij1Mxa/d7ckNw5U+eMdHRWPvuCRLoIUl
         1efDyzhwE1i78u7RQ3oDKF5MjI3JD4ht4RTj/rNg=
Date:   Mon, 23 Dec 2019 16:07:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     ruantu <mtwget@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>, mike.looijmans@topic.nl,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: chemical: add support for Dynament Premier
 series single gas sensor
Message-ID: <20191223160712.1e1cfcde@archlinux>
In-Reply-To: <FA803BE2-2715-4F63-8F5B-3A57F700AB1B@konsulko.com>
References: <3a17c9e1-f916-0cde-3296-70066dccb2b3@gmail.com>
        <FA803BE2-2715-4F63-8F5B-3A57F700AB1B@konsulko.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 21:17:43 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> > On Dec 17, 2019, at 17:52, ruantu <mtwget@gmail.com> wrote:
> >=20
> > =EF=BB=BFOn Tue, Dec 17, 2019 at 2:24 AM YuDong Zhang <mtwget@gmail.com=
> wrote: =20
> >>> Add support for Dynament Premier series single gas sensor.
> >>>  =20
> >> Just looking the Dynament site and I assume this is for the OEM-1
> >> Development kit? If so you probably should
> >> note that in the documentation because the sensors themselves are
> >> likely to be used in other end products (and not
> >> always the dev kit)
> >>=20
> >> Also bit of silly question this is an UART device so why not do
> >> processing in userspace? :)
> >>=20
> >> - Matt =20

> > This is a driver implemented according to the <Dynamization Sensor
> > Communications protocol>. I think the protocol is standard. This is
> > the idea that emerged after the iio subsystem used serial_bus. =20
>=20
> Well egg on my face since only got recently back on this mailing
> list.... looks good over all but the floating point to fixed point
> stuff maybe has some comments. Also I am on holiday till the New Year
> but please CC on future changes!

The question about whether to allow serial bus drivers in IIO wasn't
entirely obvious so reasonable to raise it.  There is a long tradition
of doing serial bus drivers only in userspace.  However, there is
nothing fundamentally different about them from spi or i2c drivers.

Sometimes we have the addition of interrupts or gpio signals (not
true for this one though!).

Basically it's nicer to have all sensors use a common interface.
We could do that the next level up in a userspace library but I'm not
sure there is stronger reason to do that in this case than for simple i2c
/ spi devices.

So I saw no reason to block serdev devices in IIO.  Not many there
yet though!

Thanks,

Jonathan


>=20
> >>> Signed-off-by: YuDong Zhang <mtwget@gmail.com>
> >>> ---
> >>>  MAINTAINERS                    |   5 +
> >>>  drivers/iio/chemical/Kconfig   |  10 +
> >>>  drivers/iio/chemical/Makefile  |   1 +
> >>>  drivers/iio/chemical/premier.c | 366 +++++++++++++++++++++++++++++++=
++
> >>>  4 files changed, 382 insertions(+)
> >>>  create mode 100644 drivers/iio/chemical/premier.c
> >>>=20
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index a049abccaa26..ae228ac7adc9 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -5792,6 +5792,11 @@ S:       Maintained
> >>>  F:     drivers/media/usb/dvb-usb-v2/dvb_usb*
> >>>  F:     drivers/media/usb/dvb-usb-v2/usb_urb.c
> >>>=20
> >>> +DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
> >>> +M:     YuDong Zhang <mtwget@gmail.com>
> >>> +S:     Maintained
> >>> +F:     drivers/iio/chemical/premier.c
> >>> +
> >>>  DYNAMIC DEBUG
> >>>  M:     Jason Baron <jbaron@akamai.com>
> >>>  S:     Maintained
> >>> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kcon=
fig
> >>> index fa4586037bb8..93c0c108245b 100644
> >>> --- a/drivers/iio/chemical/Kconfig
> >>> +++ b/drivers/iio/chemical/Kconfig
> >>> @@ -62,6 +62,16 @@ config IAQCORE
> >>>           iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
> >>>           sensors
> >>>=20
> >>> +config PREMIER
> >>> +       tristate "Dynament Premier series sensor"
> >>> +       depends on SERIAL_DEV_BUS
> >>> +       help
> >>> +         Say Y here to build support for the Dynament Premier
> >>> +         series sensor.
> >>> +
> >>> +         To compile this driver as a module, choose M here: the modu=
le will
> >>> +         be called premier.
> >>> +
> >>>  config PMS7003
> >>>         tristate "Plantower PMS7003 particulate matter sensor"
> >>>         depends on SERIAL_DEV_BUS
> >>> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Mak=
efile
> >>> index f97270bc4034..c8e779d7cf4a 100644
> >>> --- a/drivers/iio/chemical/Makefile
> >>> +++ b/drivers/iio/chemical/Makefile
> >>> @@ -10,6 +10,7 @@ obj-$(CONFIG_BME680_I2C) +=3D bme680_i2c.o
> >>>  obj-$(CONFIG_BME680_SPI) +=3D bme680_spi.o
> >>>  obj-$(CONFIG_CCS811)           +=3D ccs811.o
> >>>  obj-$(CONFIG_IAQCORE)          +=3D ams-iaq-core.o
> >>> +obj-$(CONFIG_PREMIER)          +=3D premier.o
> >>>  obj-$(CONFIG_PMS7003) +=3D pms7003.o
> >>>  obj-$(CONFIG_SENSIRION_SGP30)  +=3D sgp30.o
> >>>  obj-$(CONFIG_SPS30) +=3D sps30.o
> >>> diff --git a/drivers/iio/chemical/premier.c b/drivers/iio/chemical/pr=
emier.c
> >>> new file mode 100644
> >>> index 000000000000..a226dd9d78cb
> >>> --- /dev/null
> >>> +++ b/drivers/iio/chemical/premier.c
> >>> @@ -0,0 +1,366 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Dynament Premier series single gas sensor driver
> >>> + *
> >>> + * Copyright (c) YuDong Zhang <mtwget@gmail.com>
> >>> + */
> >>> +
> >>> +#include <asm/unaligned.h>
> >>> +#include <linux/completion.h>
> >>> +#include <linux/device.h>
> >>> +#include <linux/errno.h>
> >>> +#include <linux/iio/iio.h>
> >>> +#include <linux/jiffies.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/mod_devicetable.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/mutex.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/regulator/consumer.h>
> >>> +#include <linux/serdev.h>
> >>> +
> >>> +#define PREMIER_DRIVER_NAME "dynament-premier"
> >>> +
> >>> +#define PREMIER_DLE (0x10)
> >>> +#define PREMIER_CMD_RD (0x13)
> >>> +#define PREMIER_CMD_NAK (0x19)
> >>> +#define PREMIER_CMD_DAT (0x1a)
> >>> +#define PREMIER_EOF (0x1f)
> >>> +
> >>> +#define PREMIER_TIMEOUT msecs_to_jiffies(6000)
> >>> +
> >>> +/*
> >>> + * commands have following format:
> >>> + *
> >>> + * +-----+-----+---------+-----+-----+-----------+-----------+
> >>> + * | DLE | CMD | PAYLOAD | DLE | EOF | CKSUM MSB | CKSUM LSB |
> >>> + * +-----+-----+---------+-----+-----+-----------+-----------+
> >>> + */
> >>> +static const u8 premier_cmd_read_live_data_simple[] =3D { 0x10, 0x13=
, 0x06, 0x10,
> >>> +                                                       0x1F, 0x00, 0=
x58 };
> >>> +
> >>> +struct premier_frame {
> >>> +       u8 state;
> >>> +       u8 is_dat;
> >>> +       u8 is_nak;
> >>> +       u8 data_len;
> >>> +       u8 vi, si, gi, gj;
> >>> +       u8 gas[4];
> >>> +       u8 byte_stuffing;
> >>> +       u8 checksum_received[2];
> >>> +       u16 checksum_calculated;
> >>> +};
> >>> +
> >>> +struct premier_data {
> >>> +       struct serdev_device *serdev;
> >>> +       struct premier_frame frame;
> >>> +       struct completion frame_ready;
> >>> +       struct mutex lock; /* must be held whenever state gets touche=
d */
> >>> +       struct regulator *vcc;
> >>> +};
> >>> +
> >>> +static int premier_do_cmd_read_live_data(struct premier_data *state)
> >>> +{
> >>> +       int ret;
> >>> +
> >>> +       ret =3D serdev_device_write(state->serdev,
> >>> +                                 premier_cmd_read_live_data_simple,
> >>> +                                 sizeof(premier_cmd_read_live_data_s=
imple),
> >>> +                                 PREMIER_TIMEOUT);
> >>> +       if (ret < sizeof(premier_cmd_read_live_data_simple))
> >>> +               return ret < 0 ? ret : -EIO;
> >>> +
> >>> +       ret =3D wait_for_completion_interruptible_timeout(&state->fra=
me_ready,
> >>> +                                                       PREMIER_TIMEO=
UT);
> >>> +
> >>> +       if (!ret)
> >>> +               ret =3D -ETIMEDOUT;
> >>> +
> >>> +       return ret < 0 ? ret : 0;
> >>> +}
> >>> +
> >>> +static s32 premier_float_to_int_clamped(const u8 *fp)
> >>> +{
> >>> +       int val =3D get_unaligned_le32(fp);
> >>> +       int mantissa =3D val & GENMASK(22, 0);
> >>> +       /* this is fine since passed float is always non-negative */
> >>> +       int exp =3D val >> 23;
> >>> +       int fraction, shift;
> >>> +
> >>> +       /* special case 0 */
> >>> +       if (!exp && !mantissa)
> >>> +               return 0;
> >>> +
> >>> +       exp -=3D 127;
> >>> +       if (exp < 0) {
> >>> +               /* return values ranging from 1 to 99 */
> >>> +               return ((((1 << 23) + mantissa) * 100) >> 23) >> (-ex=
p);
> >>> +       }
> >>> +
> >>> +       /* return values ranging from 100 to int_max */
> >>> +       shift =3D 23 - exp;
> >>> +       val =3D (1 << exp) + (mantissa >> shift);
> >>> +
> >>> +       fraction =3D mantissa & GENMASK(shift - 1, 0);
> >>> +
> >>> +       return val * 100 + ((fraction * 100) >> shift);
> >>> +}
> >>> +
> >>> +static int premier_read_raw(struct iio_dev *indio_dev,
> >>> +                           struct iio_chan_spec const *chan, int *va=
l,
> >>> +                           int *val2, long mask)
> >>> +{
> >>> +       struct premier_data *state =3D iio_priv(indio_dev);
> >>> +       struct premier_frame *frame =3D &state->frame;
> >>> +       int ret;
> >>> +       s32 val_tmp;
> >>> +
> >>> +       switch (mask) {
> >>> +       case IIO_CHAN_INFO_PROCESSED:
> >>> +
> >>> +               mutex_lock(&state->lock);
> >>> +               ret =3D premier_do_cmd_read_live_data(state);
> >>> +               if (ret) {
> >>> +                       mutex_unlock(&state->lock);
> >>> +                       return ret;
> >>> +               }
> >>> +               val_tmp =3D premier_float_to_int_clamped(frame->gas);
> >>> +               mutex_unlock(&state->lock);
> >>> +
> >>> +               *val =3D val_tmp / 100;
> >>> +               *val2 =3D (val_tmp % 100) * 10000;
> >>> +               return IIO_VAL_INT_PLUS_MICRO;
> >>> +       default:
> >>> +               return -EINVAL;
> >>> +       }
> >>> +
> >>> +       return -EINVAL;
> >>> +}
> >>> +
> >>> +static const struct iio_info premier_info =3D {
> >>> +       .read_raw =3D premier_read_raw,
> >>> +};
> >>> +
> >>> +static const struct iio_chan_spec premier_channels[] =3D {
> >>> +       {
> >>> +               .type =3D IIO_MASSCONCENTRATION,
> >>> +               .channel =3D 1,
> >>> +               .channel2 =3D IIO_MOD_CO2,
> >>> +               .scan_index =3D -1,
> >>> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> >>> +               .modified =3D 1,
> >>> +       },
> >>> +       IIO_CHAN_SOFT_TIMESTAMP(0),
> >>> +};
> >>> +
> >>> +static int premier_receive_buf(struct serdev_device *serdev,
> >>> +                              const unsigned char *buf, size_t size)
> >>> +{
> >>> +       struct iio_dev *indio_dev =3D serdev_device_get_drvdata(serde=
v);
> >>> +       struct premier_data *state =3D iio_priv(indio_dev);
> >>> +       struct premier_frame *frame =3D &state->frame;
> >>> +       int i;
> >>> +
> >>> +       for (i =3D 0; i < size; i++) {
> >>> +               if (frame->state > 0 && frame->state <=3D 7)
> >>> +                       frame->checksum_calculated +=3D buf[i];
> >>> +
> >>> +               switch (frame->state) {
> >>> +               case 0:
> >>> +                       if (buf[i] =3D=3D PREMIER_DLE) {
> >>> +                               frame->is_dat =3D 0;
> >>> +                               frame->is_nak =3D 0;
> >>> +                               frame->checksum_calculated =3D buf[i];
> >>> +                               /* We don't initialize checksum_calcu=
lated in
> >>> +                                * the last state in case we didn't go
> >>> +                                * there because of noise
> >>> +                                */
> >>> +                               frame->state++;
> >>> +                       }
> >>> +                       break;
> >>> +               case 1:
> >>> +                       /*
> >>> +                        * If noise corrupts a byte in the FSM sequen=
ce,
> >>> +                        * we loop between state 0 and 1,
> >>> +                        * until we have a valid sequence of DLE&DAT =
or DLE&NAK
> >>> +                        */
> >>> +                       if (buf[i] =3D=3D PREMIER_CMD_DAT) {
> >>> +                               frame->is_dat =3D 1;
> >>> +                               frame->state++;
> >>> +                       } else if (buf[i] =3D=3D PREMIER_CMD_NAK) {
> >>> +                               frame->is_nak =3D 1;
> >>> +                               frame->state++;
> >>> +                       } else
> >>> +                               frame->state =3D 0;
> >>> +                       break;
> >>> +               case 2:
> >>> +                       if (frame->is_nak)
> >>> +                               frame->state =3D 0;
> >>> +                       else if (frame->is_dat) {
> >>> +                               frame->data_len =3D buf[i] - 4;
> >>> +                               /* remove version and status bytes fr=
om count */
> >>> +                               if (frame->data_len < 4)
> >>> +                                       frame->state =3D 0;
> >>> +                               /* we check for the upper limit in st=
ate 5 */
> >>> +                               else
> >>> +                                       frame->state++;
> >>> +                       } else
> >>> +                               frame->state =3D 0;
> >>> +                       break;
> >>> +               case 3:
> >>> +                       /* Just do nothing for 2 rounds to bypass
> >>> +                        * the 2 version bytes
> >>> +                        */
> >>> +                       if (frame->vi < 2 - 1)
> >>> +                               frame->vi++;
> >>> +                       else {
> >>> +                               frame->vi =3D 0;
> >>> +                               frame->state++;
> >>> +                       }
> >>> +                       break;
> >>> +               case 4:
> >>> +                       if (frame->si < 2 - 1)
> >>> +                               frame->si++;
> >>> +                       else {
> >>> +                               frame->si =3D 0;
> >>> +                               frame->state++;
> >>> +                       }
> >>> +                       break;
> >>> +               case 5:
> >>> +                       if (frame->gi < frame->data_len - 1) {
> >>> +                               if (buf[i] !=3D PREMIER_DLE ||
> >>> +                                   frame->byte_stuffing) {
> >>> +                                       frame->gas[frame->gj] =3D buf=
[i];
> >>> +                                       frame->byte_stuffing =3D 0;
> >>> +                                       frame->gj++;
> >>> +                                       if (frame->gj >=3D 4)
> >>> +                                               frame->state =3D 0;
> >>> +                                       /* Don't violate array limits
> >>> +                                        * if data_len corrupt
> >>> +                                        */
> >>> +                               } else
> >>> +                                       frame->byte_stuffing =3D 1;
> >>> +                               frame->gi++;
> >>> +                       } else {
> >>> +                               frame->gas[frame->gj] =3D buf[i];
> >>> +                               frame->byte_stuffing =3D 0;
> >>> +                               frame->gi =3D 0;
> >>> +                               frame->gj =3D 0;
> >>> +                               frame->state++;
> >>> +                       }
> >>> +                       break;
> >>> +               case 6:
> >>> +                       if (buf[i] =3D=3D PREMIER_DLE)
> >>> +                               frame->state++;
> >>> +                       else
> >>> +                               frame->state =3D 0;
> >>> +                       break;
> >>> +               case 7:
> >>> +                       if (buf[i] =3D=3D PREMIER_EOF)
> >>> +                               frame->state++;
> >>> +                       else
> >>> +                               frame->state =3D 0;
> >>> +                       break;
> >>> +               case 8:
> >>> +                       frame->checksum_received[1] =3D buf[i];
> >>> +
> >>> +                       frame->state++;
> >>> +                       break;
> >>> +               case 9:
> >>> +                       frame->checksum_received[0] =3D buf[i];
> >>> +
> >>> +                       if (frame->checksum_calculated =3D=3D
> >>> +                           get_unaligned_le16(frame->checksum_receiv=
ed))
> >>> +                               complete(&state->frame_ready);
> >>> +
> >>> +                       frame->state =3D 0;
> >>> +                       break;
> >>> +               }
> >>> +       }
> >>> +
> >>> +       return size;
> >>> +}
> >>> +
> >>> +static const struct serdev_device_ops premier_serdev_ops =3D {
> >>> +       .receive_buf =3D premier_receive_buf,
> >>> +       .write_wakeup =3D serdev_device_write_wakeup,
> >>> +};
> >>> +
> >>> +static int premier_probe(struct serdev_device *serdev)
> >>> +{
> >>> +       struct premier_data *state;
> >>> +       struct iio_dev *indio_dev;
> >>> +       int ret;
> >>> +
> >>> +       indio_dev =3D devm_iio_device_alloc(&serdev->dev, sizeof(*sta=
te));
> >>> +       if (!indio_dev)
> >>> +               return -ENOMEM;
> >>> +
> >>> +       state =3D iio_priv(indio_dev);
> >>> +       serdev_device_set_drvdata(serdev, indio_dev);
> >>> +       state->serdev =3D serdev;
> >>> +       indio_dev->dev.parent =3D &serdev->dev;
> >>> +       indio_dev->info =3D &premier_info;
> >>> +       indio_dev->name =3D PREMIER_DRIVER_NAME;
> >>> +       indio_dev->channels =3D premier_channels;
> >>> +       indio_dev->num_channels =3D ARRAY_SIZE(premier_channels);
> >>> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> >>> +
> >>> +       mutex_init(&state->lock);
> >>> +       init_completion(&state->frame_ready);
> >>> +
> >>> +       state->vcc =3D devm_regulator_get(&serdev->dev, "vcc");
> >>> +       if (IS_ERR(state->vcc)) {
> >>> +               ret =3D PTR_ERR(state->vcc);
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       serdev_device_set_client_ops(serdev, &premier_serdev_ops);
> >>> +       ret =3D devm_serdev_device_open(&serdev->dev, serdev);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>> +       serdev_device_set_baudrate(serdev, 9600);
> >>> +       serdev_device_set_flow_control(serdev, false);
> >>> +
> >>> +       ret =3D serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>> +       if (state->vcc) {
> >>> +               ret =3D regulator_enable(state->vcc);
> >>> +               if (ret)
> >>> +                       return ret;
> >>> +       }
> >>> +
> >>> +       return devm_iio_device_register(&serdev->dev, indio_dev);
> >>> +}
> >>> +
> >>> +static void premier_remove(struct serdev_device *serdev)
> >>> +{
> >>> +       struct iio_dev *indio_dev =3D serdev_device_get_drvdata(serde=
v);
> >>> +       struct premier_data *state =3D iio_priv(indio_dev);
> >>> +
> >>> +       if (state->vcc)
> >>> +               regulator_disable(state->vcc);
> >>> +}
> >>> +
> >>> +static const struct of_device_id premier_of_match[] =3D {
> >>> +       { .compatible =3D "dynament,premier" },
> >>> +       {}
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, premier_of_match);
> >>> +
> >>> +static struct serdev_device_driver premier_driver =3D {
> >>> +       .driver =3D {
> >>> +               .name =3D PREMIER_DRIVER_NAME,
> >>> +               .of_match_table =3D premier_of_match,
> >>> +       },
> >>> +       .probe =3D premier_probe,
> >>> +       .remove =3D premier_remove,
> >>> +};
> >>> +module_serdev_device_driver(premier_driver);
> >>> +
> >>> +MODULE_AUTHOR("YuDong Zhang <mtwget@gmail.com>");
> >>> +MODULE_DESCRIPTION("Dynament Premier series single gas sensor driver=
");
> >>> +MODULE_LICENSE("GPL v2");
> >>> --
> >>> 2.24.1
> >>>  =20

