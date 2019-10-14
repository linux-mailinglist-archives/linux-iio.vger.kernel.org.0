Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270EDD697E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 20:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfJNSdk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 14:33:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37352 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfJNSdk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 14:33:40 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so40126713iob.4
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2019 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m5wywGxqRoVRCuvBOjpIl2z7WtvpsfKwKscNNxBu8eA=;
        b=am0k49oExfrJgS7JDRURasxS/JrdxRh5yhLUHt8ielsgQZI78MoY1liCGKQLq74IQH
         /zhzzGDAthIYFwNZ4QqaItz598hNobFuifR9Y2p5cWHZUaWlhYsmGZEVR0kCmkXi8gVA
         Z7u8n/wvLqZ1sjJo0ljPHz0RxLmileieFhrdbTfFsrXOEGTGOklyaeNTMUicbK2ZhQcA
         XKzosAb+qL1npcv3SC9lF2W2KzeWD0g2TItPPHeOMzuerHms0I6TaO1K9cLldPU1Rv/9
         PQdoMOD5pCh/v+tKdtd4TrURaPUYyu6gFThVzOEHt4akRDXK6jAWvSHb97TZwosciNJP
         3bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m5wywGxqRoVRCuvBOjpIl2z7WtvpsfKwKscNNxBu8eA=;
        b=Hdu+K+Zkezi9Ygui4eEmpxIOQtvq861k9yAk+SL4kS1tS3Be0R/jFi0QBknWkVHn0Z
         yk1G69JRJyx4SDSeVvTnVg/7GfQAlyxRWKUmOCM9Qw6kVx/z/7oyvCy9nMHp8a++tRrD
         cAToQRc4jNKEcb6GaqVQhqAT9j7bRzoEZ25+FoplkK/m3U5yWiLdP09b105HLXTcD3wi
         IuAb1+4ppdsR0iUuuAyuIRCLh33lKWT43nWXogYcPt0g8Dad9dzJAyNMHEyvqTEiGoqQ
         WSf3mM0wrLtMAb/Yv7T2vHdLEJ7ShgQEgmcctBYSE796RDxHUzW5fjY5Xt7BQuLG+BAX
         KeVg==
X-Gm-Message-State: APjAAAX6ADXZ1bN5hV9EzdOL+IB2ip9KYYJde1lW6FOBjBNZ/Hv81Oo/
        7oaReRt1g7xsbRSV/lF/bhWXkLRDKl3YYdhuuSjlXQ==
X-Google-Smtp-Source: APXvYqxJ1d+BFqF2F0Z/mhEiKBFmgeDQYQzBuDreqx5alF+8Ipftdl8PCsQLwniM3eS1oNczPxG45VzJsWxVWrUos8w=
X-Received: by 2002:a5d:9057:: with SMTP id v23mr7814666ioq.119.1571078017816;
 Mon, 14 Oct 2019 11:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191010012523.14426-1-rjones@gateworks.com> <20191010175648.10830-1-rjones@gateworks.com>
 <20191010175648.10830-3-rjones@gateworks.com> <20191012145343.42908211@archlinux>
In-Reply-To: <20191012145343.42908211@archlinux>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Mon, 14 Oct 2019 11:33:26 -0700
Message-ID: <CALAE=UAW8B6BT1EHwcKJNRJAL0QHrYi-wxHv_yH==0fNmNAiNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: imu: Add support for the FXOS8700 IMU
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 12, 2019 at 6:53 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 10 Oct 2019 10:56:48 -0700
> Robert Jones <rjones@gateworks.com> wrote:
>
> > FXOS8700CQ is a small, low-power, 3-axis linear accelerometer and 3-axi=
s
> > magnetometer combined into a single package. The device features a
> > selectable I2C or point-to-point SPI serial interface with 14-bit
> > accelerometer and 16-bit magnetometer ADC resolution along with
> > smart-embedded functions.
> >
> > FXOS8700CQ has dynamically selectable accelerationfull-scale ranges of
> > =C2=B12 g/=C2=B14 g/=C2=B18 g and a fixed magnetic measurement range of=
 =C2=B11200 =CE=BCT.
> > Output data rates (ODR) from 1.563 Hz to 800 Hz are selectable by the u=
ser
> > for each sensor. Interleaved magnetic and acceleration data is availabl=
e
> > at ODR rates of up to 400 Hz. FXOS8700CQ is available in a plastic QFN
> > package and it is guaranteed to operate over the extended temperature
> > range of =E2=80=9340 =C2=B0C to +85 =C2=B0C.
> >
> > TODO: Trigger and IRQ configuration support
> >
> > Datasheet:
> >   http://cache.freescale.com/files/sensors/doc/data_sheet/FXOS8700CQ.pd=
f
> >
> > Signed-off-by: Robert Jones <rjones@gateworks.com>
> Mostly looks good.  A few remaining bits inline.
>
> The endian types seems to have gotten very confused!
>
> Jonathan

I've addressed the miscellaneous and header file concerns. Went as far
as to move all #defines only used in the core file to the core file.
Response to the get_data function data conversion inline.

>
> > ---
> >  drivers/iio/imu/Kconfig         |  27 +++
> >  drivers/iio/imu/Makefile        |   5 +
> >  drivers/iio/imu/fxos8700.h      | 185 +++++++++++++++
> >  drivers/iio/imu/fxos8700_core.c | 499 ++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/iio/imu/fxos8700_i2c.c  |  71 ++++++
> >  drivers/iio/imu/fxos8700_spi.c  |  59 +++++
> >  6 files changed, 846 insertions(+)
> >  create mode 100644 drivers/iio/imu/fxos8700.h
> >  create mode 100644 drivers/iio/imu/fxos8700_core.c
> >  create mode 100644 drivers/iio/imu/fxos8700_i2c.c
> >  create mode 100644 drivers/iio/imu/fxos8700_spi.c
> >
> > diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> > index f3c7282..60bb102 100644
> > --- a/drivers/iio/imu/Kconfig
> > +++ b/drivers/iio/imu/Kconfig
> > @@ -40,6 +40,33 @@ config ADIS16480
> >
> >  source "drivers/iio/imu/bmi160/Kconfig"
> >
> > +config FXOS8700
> > +     tristate
> > +
> > +config FXOS8700_I2C
> > +     tristate "NXP FXOS8700 I2C driver"
> > +     depends on I2C
> > +     select FXOS8700
> > +     select REGMAP_I2C
> > +     help
> > +       Say yes here to build support for the NXP FXOS8700 m+g combo
> > +       sensor on I2C.
> > +
> > +       This driver can also be built as a module. If so, the module wi=
ll be
> > +       called fxos8700_i2c.
> > +
> > +config FXOS8700_SPI
> > +     tristate "NXP FXOS8700 SPI driver"
> > +     depends on SPI
> > +     select FXOS8700
> > +     select REGMAP_SPI
> > +     help
> > +       Say yes here to build support for the NXP FXOS8700 m+g combo
> > +       sensor on SPI.
> > +
> > +       This driver can also be built as a module. If so, the module wi=
ll be
> > +       called fxos8700_spi.
> > +
> >  config KMX61
> >       tristate "Kionix KMX61 6-axis accelerometer and magnetometer"
> >       depends on I2C
> > diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> > index 4a69588..5237fd4 100644
> > --- a/drivers/iio/imu/Makefile
> > +++ b/drivers/iio/imu/Makefile
> > @@ -14,6 +14,11 @@ adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) +=3D adis_buf=
fer.o
> >  obj-$(CONFIG_IIO_ADIS_LIB) +=3D adis_lib.o
> >
> >  obj-y +=3D bmi160/
> > +
> > +obj-$(CONFIG_FXOS8700) +=3D fxos8700_core.o
> > +obj-$(CONFIG_FXOS8700_I2C) +=3D fxos8700_i2c.o
> > +obj-$(CONFIG_FXOS8700_SPI) +=3D fxos8700_spi.o
> > +
> >  obj-y +=3D inv_mpu6050/
> >
> >  obj-$(CONFIG_KMX61) +=3D kmx61.o
> > diff --git a/drivers/iio/imu/fxos8700.h b/drivers/iio/imu/fxos8700.h
> > new file mode 100644
> > index 0000000..92499a2
> > --- /dev/null
> > +++ b/drivers/iio/imu/fxos8700.h
> > @@ -0,0 +1,185 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef FXOS8700_H_
> > +#define FXOS8700_H_
> > +
> > +extern const struct regmap_config fxos8700_regmap_config;
> > +
> > +int fxos8700_core_probe(struct device *dev, struct regmap *regmap,
> > +                     const char *name, bool use_spi);
> > +
> > +/* Register Definitions */
>
> If register definitions are only used in one c file, move them there
> rather than exposing the in the header.
>
> > +#define FXOS8700_STATUS             0x00
> > +#define FXOS8700_OUT_X_MSB          0x01
> > +#define FXOS8700_OUT_X_LSB          0x02
> > +#define FXOS8700_OUT_Y_MSB          0x03
> > +#define FXOS8700_OUT_Y_LSB          0x04
> > +#define FXOS8700_OUT_Z_MSB          0x05
> > +#define FXOS8700_OUT_Z_LSB          0x06
> > +#define FXOS8700_F_SETUP            0x09
> > +#define FXOS8700_TRIG_CFG           0x0a
> > +#define FXOS8700_SYSMOD             0x0b
> > +#define FXOS8700_INT_SOURCE         0x0c
> > +#define FXOS8700_WHO_AM_I           0x0d
> > +#define FXOS8700_XYZ_DATA_CFG       0x0e
> > +#define FXOS8700_HP_FILTER_CUTOFF   0x0f
> > +#define FXOS8700_PL_STATUS          0x10
> > +#define FXOS8700_PL_CFG             0x11
> > +#define FXOS8700_PL_COUNT           0x12
> > +#define FXOS8700_PL_BF_ZCOMP        0x13
> > +#define FXOS8700_PL_THS_REG         0x14
> > +#define FXOS8700_A_FFMT_CFG         0x15
> > +#define FXOS8700_A_FFMT_SRC         0x16
> > +#define FXOS8700_A_FFMT_THS         0x17
> > +#define FXOS8700_A_FFMT_COUNT       0x18
> > +#define FXOS8700_TRANSIENT_CFG      0x1d
> > +#define FXOS8700_TRANSIENT_SRC      0x1e
> > +#define FXOS8700_TRANSIENT_THS      0x1f
> > +#define FXOS8700_TRANSIENT_COUNT    0x20
> > +#define FXOS8700_PULSE_CFG          0x21
> > +#define FXOS8700_PULSE_SRC          0x22
> > +#define FXOS8700_PULSE_THSX         0x23
> > +#define FXOS8700_PULSE_THSY         0x24
> > +#define FXOS8700_PULSE_THSZ         0x25
> > +#define FXOS8700_PULSE_TMLT         0x26
> > +#define FXOS8700_PULSE_LTCY         0x27
> > +#define FXOS8700_PULSE_WIND         0x28
> > +#define FXOS8700_ASLP_COUNT         0x29
> > +#define FXOS8700_CTRL_REG1          0x2a
> > +#define FXOS8700_CTRL_REG2          0x2b
> > +#define FXOS8700_CTRL_REG3          0x2c
> > +#define FXOS8700_CTRL_REG4          0x2d
> > +#define FXOS8700_CTRL_REG5          0x2e
> > +#define FXOS8700_OFF_X              0x2f
> > +#define FXOS8700_OFF_Y              0x30
> > +#define FXOS8700_OFF_Z              0x31
> > +#define FXOS8700_M_DR_STATUS        0x32
> > +#define FXOS8700_M_OUT_X_MSB        0x33
> > +#define FXOS8700_M_OUT_X_LSB        0x34
> > +#define FXOS8700_M_OUT_Y_MSB        0x35
> > +#define FXOS8700_M_OUT_Y_LSB        0x36
> > +#define FXOS8700_M_OUT_Z_MSB        0x37
> > +#define FXOS8700_M_OUT_Z_LSB        0x38
> > +#define FXOS8700_CMP_X_MSB          0x39
> > +#define FXOS8700_CMP_X_LSB          0x3a
> > +#define FXOS8700_CMP_Y_MSB          0x3b
> > +#define FXOS8700_CMP_Y_LSB          0x3c
> > +#define FXOS8700_CMP_Z_MSB          0x3d
> > +#define FXOS8700_CMP_Z_LSB          0x3e
> > +#define FXOS8700_M_OFF_X_MSB        0x3f
> > +#define FXOS8700_M_OFF_X_LSB        0x40
> > +#define FXOS8700_M_OFF_Y_MSB        0x41
> > +#define FXOS8700_M_OFF_Y_LSB        0x42
> > +#define FXOS8700_M_OFF_Z_MSB        0x43
> > +#define FXOS8700_M_OFF_Z_LSB        0x44
> > +#define FXOS8700_MAX_X_MSB          0x45
> > +#define FXOS8700_MAX_X_LSB          0x46
> > +#define FXOS8700_MAX_Y_MSB          0x47
> > +#define FXOS8700_MAX_Y_LSB          0x48
> > +#define FXOS8700_MAX_Z_MSB          0x49
> > +#define FXOS8700_MAX_Z_LSB          0x4a
> > +#define FXOS8700_MIN_X_MSB          0x4b
> > +#define FXOS8700_MIN_X_LSB          0x4c
> > +#define FXOS8700_MIN_Y_MSB          0x4d
> > +#define FXOS8700_MIN_Y_LSB          0x4e
> > +#define FXOS8700_MIN_Z_MSB          0x4f
> > +#define FXOS8700_MIN_Z_LSB          0x50
> > +#define FXOS8700_TEMP               0x51
> > +#define FXOS8700_M_THS_CFG          0x52
> > +#define FXOS8700_M_THS_SRC          0x53
> > +#define FXOS8700_M_THS_X_MSB        0x54
> > +#define FXOS8700_M_THS_X_LSB        0x55
> > +#define FXOS8700_M_THS_Y_MSB        0x56
> > +#define FXOS8700_M_THS_Y_LSB        0x57
> > +#define FXOS8700_M_THS_Z_MSB        0x58
> > +#define FXOS8700_M_THS_Z_LSB        0x59
> > +#define FXOS8700_M_THS_COUNT        0x5a
> > +#define FXOS8700_M_CTRL_REG1        0x5b
> > +#define FXOS8700_M_CTRL_REG2        0x5c
> > +#define FXOS8700_M_CTRL_REG3        0x5d
> > +#define FXOS8700_M_INT_SRC          0x5e
> > +#define FXOS8700_A_VECM_CFG         0x5f
> > +#define FXOS8700_A_VECM_THS_MSB     0x60
> > +#define FXOS8700_A_VECM_THS_LSB     0x61
> > +#define FXOS8700_A_VECM_CNT         0x62
> > +#define FXOS8700_A_VECM_INITX_MSB   0x63
> > +#define FXOS8700_A_VECM_INITX_LSB   0x64
> > +#define FXOS8700_A_VECM_INITY_MSB   0x65
> > +#define FXOS8700_A_VECM_INITY_LSB   0x66
> > +#define FXOS8700_A_VECM_INITZ_MSB   0x67
> > +#define FXOS8700_A_VECM_INITZ_LSB   0x68
> > +#define FXOS8700_M_VECM_CFG         0x69
> > +#define FXOS8700_M_VECM_THS_MSB     0x6a
> > +#define FXOS8700_M_VECM_THS_LSB     0x6b
> > +#define FXOS8700_M_VECM_CNT         0x6c
> > +#define FXOS8700_M_VECM_INITX_MSB   0x6d
> > +#define FXOS8700_M_VECM_INITX_LSB   0x6e
> > +#define FXOS8700_M_VECM_INITY_MSB   0x6f
> > +#define FXOS8700_M_VECM_INITY_LSB   0x70
> > +#define FXOS8700_M_VECM_INITZ_MSB   0x71
> > +#define FXOS8700_M_VECM_INITZ_LSB   0x72
> > +#define FXOS8700_A_FFMT_THS_X_MSB   0x73
> > +#define FXOS8700_A_FFMT_THS_X_LSB   0x74
> > +#define FXOS8700_A_FFMT_THS_Y_MSB   0x75
> > +#define FXOS8700_A_FFMT_THS_Y_LSB   0x76
> > +#define FXOS8700_A_FFMT_THS_Z_MSB   0x77
> > +#define FXOS8700_A_FFMT_THS_Z_LSB   0x78
> > +#define FXOS8700_A_TRAN_INIT_MSB    0x79
> > +#define FXOS8700_A_TRAN_INIT_LSB_X  0x7a
> > +#define FXOS8700_A_TRAN_INIT_LSB_Y  0x7b
> > +#define FXOS8700_A_TRAN_INIT_LSB_Z  0x7d
> > +#define FXOS8700_TM_NVM_LOCK        0x7e
> > +#define FXOS8700_NVM_DATA0_35       0x80
> > +#define FXOS8700_NVM_DATA_BNK3      0xa4
> > +#define FXOS8700_NVM_DATA_BNK2      0xa5
> > +#define FXOS8700_NVM_DATA_BNK1      0xa6
> > +#define FXOS8700_NVM_DATA_BNK0      0xa7
> > +
> > +/* Bit definitions for FXOS8700_M_CTRL_REG1 */
> > +#define FXOS8700_HMS_MASK           GENMASK(1, 0)
> > +#define FXOS8700_OS_MASK            GENMASK(4, 2)
> > +
> > +/* Bit definitions for FXOS8700_M_CTRL_REG2 */
> > +#define FXOS8700_MAXMIN_RST         BIT(2)
> > +#define FXOS8700_MAXMIN_DIS_THS     BIT(3)
> > +#define FXOS8700_MAXMIN_DIS         BIT(4)
> > +
> > +#define SENSOR_IOCTL_BASE           'S'
> > +#define SENSOR_GET_MODEL_NAME       _IOR(SENSOR_IOCTL_BASE, 0, char *)
> > +#define SENSOR_GET_POWER_STATUS     _IOR(SENSOR_IOCTL_BASE, 2, int)
> > +#define SENSOR_SET_POWER_STATUS     _IOR(SENSOR_IOCTL_BASE, 3, int)
> > +#define SENSOR_GET_DELAY_TIME       _IOR(SENSOR_IOCTL_BASE, 4, int)
> > +#define SENSOR_SET_DELAY_TIME       _IOR(SENSOR_IOCTL_BASE, 5, int)
> > +#define SENSOR_GET_RAW_DATA         _IOR(SENSOR_IOCTL_BASE, 6, short[3=
])
>
> What are these doing here?
Remnants from the misc driver I referenced. Removed these as well as
other non-register #defines not being used.
>
> > +
> > +#define FXOS8700_I2C_ADDR           0x1E
> > +#define FXOS8700_DEVICE_ID          0xC7
> > +#define FXOS8700_PRE_DEVICE_ID      0xC4
> > +#define FXOS8700_DATA_BUF_SIZE      6
> > +#define FXOS8700_DELAY_DEFAULT      200 /* msecs */
> > +#define FXOS8700_POSITION_DEFAULT   1   /* msecs */
> > +
> > +#define FXOS8700_TYPE_ACC           0x00
> > +#define FXOS8700_TYPE_MAG           0x01
> > +#define FXOS8700_STANDBY            0x00
> > +#define FXOS8700_ACTIVE             0x01
> > +#define FXOS8700_ACTIVE_MIN_USLEEP  4000 /* from table 6 in datasheet =
*/
> > +
> > +#define ABS_STATUS                  ABS_WHEEL
> > +#define FXOS8700_DRIVER             "fxos8700"
> > +
> > +#define ABSMAX_ACC_VAL              0x01FF
> > +#define ABSMIN_ACC_VAL              -(ABSMAX_ACC_VAL)
> > +#define FXOS8700_POLL_INTERVAL      400
> > +#define FXOS8700_POLL_MAX           800
> > +#define FXOS8700_POLL_MIN           100
> > +#define FXOS8700_CTRL_ODR_MSK       0x38
> > +#define FXOS8700_CTRL_ODR_MAX       0x00
> > +#define FXOS8700_CTRL_ODR_MIN       (0x03 << 3)
> > +
> > +enum {
> > +     MODE_2G =3D 0,
> > +     MODE_4G,
> > +     MODE_8G,
> > +};
> > +
> > +#endif  /* FXOS8700_H_ */
> > diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700=
_core.c
> > new file mode 100644
> > index 0000000..ea2716b
> > --- /dev/null
> > +++ b/drivers/iio/imu/fxos8700_core.c
> > @@ -0,0 +1,499 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * FXOS8700 - NXP IMU (accelerometer plus magnetometer)
> > + *
> > + * IIO core driver for FXOS8700, with support for I2C/SPI busses
> > + *
> > + * TODO: Buffer, trigger, and IRQ support
> > + */
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/acpi.h>
> > +#include <linux/bitops.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#include "fxos8700.h"
> > +
> > +struct fxos8700_data {
> > +     struct regmap *regmap;
> > +     struct iio_trigger *trig;
> > +     u8 buf[FXOS8700_DATA_BUF_SIZE] ____cacheline_aligned;
> > +};
> > +
> > +/* Regmap info */
> > +static const struct regmap_range read_range[] =3D {
> > +     {
> > +             .range_min =3D FXOS8700_STATUS,
> > +             .range_max =3D FXOS8700_A_FFMT_COUNT,
> > +     }, {
> > +             .range_min =3D FXOS8700_TRANSIENT_CFG,
> > +             .range_max =3D FXOS8700_A_FFMT_THS_Z_LSB,
> > +     },
> > +};
> > +
> > +static const struct regmap_range write_range[] =3D {
> > +     {
> > +             .range_min =3D FXOS8700_F_SETUP,
> > +             .range_max =3D FXOS8700_TRIG_CFG,
> > +     }, {
> > +             .range_min =3D FXOS8700_XYZ_DATA_CFG,
> > +             .range_max =3D FXOS8700_HP_FILTER_CUTOFF,
> > +     }, {
> > +             .range_min =3D FXOS8700_PL_CFG,
> > +             .range_max =3D FXOS8700_A_FFMT_CFG,
> > +     }, {
> > +             .range_min =3D FXOS8700_A_FFMT_THS,
> > +             .range_max =3D FXOS8700_TRANSIENT_CFG,
> > +     }, {
> > +             .range_min =3D FXOS8700_TRANSIENT_THS,
> > +             .range_max =3D FXOS8700_PULSE_CFG,
> > +     }, {
> > +             .range_min =3D FXOS8700_PULSE_THSX,
> > +             .range_max =3D FXOS8700_OFF_Z,
> > +     }, {
> > +             .range_min =3D FXOS8700_M_OFF_X_MSB,
> > +             .range_max =3D FXOS8700_M_OFF_Z_LSB,
> > +     }, {
> > +             .range_min =3D FXOS8700_M_THS_CFG,
> > +             .range_max =3D FXOS8700_M_THS_CFG,
> > +     }, {
> > +             .range_min =3D FXOS8700_M_THS_X_MSB,
> > +             .range_max =3D FXOS8700_M_CTRL_REG3,
> > +     }, {
> > +             .range_min =3D FXOS8700_A_VECM_CFG,
> > +             .range_max =3D FXOS8700_A_FFMT_THS_Z_LSB,
> > +     },
> > +};
> > +
> > +static const struct regmap_access_table driver_read_table =3D {
> > +     .yes_ranges =3D   read_range,
> > +     .n_yes_ranges =3D ARRAY_SIZE(read_range),
> > +};
> > +
> > +static const struct regmap_access_table driver_write_table =3D {
> > +     .yes_ranges =3D   write_range,
> > +     .n_yes_ranges =3D ARRAY_SIZE(write_range),
> > +};
> > +
> > +const struct regmap_config fxos8700_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D FXOS8700_NVM_DATA_BNK0,
> > +     .rd_table =3D &driver_read_table,
> > +     .wr_table =3D &driver_write_table,
> > +};
> > +EXPORT_SYMBOL(fxos8700_regmap_config);
> > +
> > +#define FXOS8700_CHANNEL(_type, _axis) {                     \
> > +     .type =3D _type,                                          \
> > +     .modified =3D 1,                                          \
> > +     .channel2 =3D IIO_MOD_##_axis,                            \
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),           \
> > +     .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |  \
> > +             BIT(IIO_CHAN_INFO_SAMP_FREQ),                   \
> > +}
> > +
> > +/* scan indexes follow DATA register order */
> > +enum fxos8700_scan_axis {
> > +     FXOS8700_SCAN_ACCEL_X =3D 0,
> > +     FXOS8700_SCAN_ACCEL_Y,
> > +     FXOS8700_SCAN_ACCEL_Z,
> > +     FXOS8700_SCAN_MAGN_X,
> > +     FXOS8700_SCAN_MAGN_Y,
> > +     FXOS8700_SCAN_MAGN_Z,
> > +     FXOS8700_SCAN_RHALL,
> > +     FXOS8700_SCAN_TIMESTAMP,
> > +};
> > +
> > +enum fxos8700_sensor {
> > +     FXOS8700_ACCEL  =3D 0,
> > +     FXOS8700_MAGN,
> > +     FXOS8700_NUM_SENSORS /* must be last */
> > +};
> > +
> > +enum fxos8700_int_pin {
> > +     FXOS8700_PIN_INT1,
> > +     FXOS8700_PIN_INT2
> > +};
> > +
> > +struct fxos8700_scale {
> > +     u8 bits;
> > +     int uscale;
> > +};
> > +
> > +struct fxos8700_odr {
> > +     u8 bits;
> > +     int odr;
> > +     int uodr;
> > +};
> > +
> > +static const struct fxos8700_scale fxos8700_accel_scale[] =3D {
> > +     { MODE_2G, 244},
> > +     { MODE_4G, 488},
> > +     { MODE_8G, 976},
> > +};
> > +
> > +/*
> > + * Accellerometer and magnetometer have the same ODR options, set in t=
he
> > + * CTRL_REG1 register. ODR is halved when using both sensors at once i=
n
> > + * hybrid mode.
> > + */
> > +static const struct fxos8700_odr fxos8700_odr[] =3D {
> > +     {0x00, 800, 0},
> > +     {0x01, 400, 0},
> > +     {0x02, 200, 0},
> > +     {0x03, 100, 0},
> > +     {0x04, 50, 0},
> > +     {0x05, 12, 500000},
> > +     {0x06, 6, 250000},
> > +     {0x07, 1, 562500},
> > +};
> > +
> > +static const struct iio_chan_spec fxos8700_channels[] =3D {
> > +     FXOS8700_CHANNEL(IIO_ACCEL, X),
> > +     FXOS8700_CHANNEL(IIO_ACCEL, Y),
> > +     FXOS8700_CHANNEL(IIO_ACCEL, Z),
> > +     FXOS8700_CHANNEL(IIO_MAGN, X),
> > +     FXOS8700_CHANNEL(IIO_MAGN, Y),
> > +     FXOS8700_CHANNEL(IIO_MAGN, Z),
> > +     IIO_CHAN_SOFT_TIMESTAMP(FXOS8700_SCAN_TIMESTAMP),
> > +};
> > +
> > +static enum fxos8700_sensor fxos8700_to_sensor(enum iio_chan_type iio_=
type)
> > +{
> > +     switch (iio_type) {
> > +     case IIO_ACCEL:
> > +             return FXOS8700_ACCEL;
> > +     case IIO_ANGL_VEL:
> > +             return FXOS8700_MAGN;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int fxos8700_set_active_mode(struct fxos8700_data *data,
> > +                                 enum fxos8700_sensor t, bool mode)
> > +{
> > +     int ret;
> > +
> > +     ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1, mode);
> > +     if (ret)
> > +             return ret;
> > +
> > +     usleep_range(FXOS8700_ACTIVE_MIN_USLEEP,
> > +                  FXOS8700_ACTIVE_MIN_USLEEP + 1000);
> > +
> > +     return 0;
> > +}
> > +
> > +static int fxos8700_set_scale(struct fxos8700_data *data,
> > +                           enum fxos8700_sensor t, int uscale)
> > +{
> > +     int i;
> > +     static const int scale_num =3D ARRAY_SIZE(fxos8700_accel_scale);
> > +     struct device *dev =3D regmap_get_device(data->regmap);
> > +
> > +     if (t =3D=3D FXOS8700_MAGN) {
> > +             dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     for (i =3D 0; i < scale_num; i++)
> > +             if (fxos8700_accel_scale[i].uscale =3D=3D uscale)
> > +                     break;
> > +
> > +     if (i =3D=3D scale_num)
> > +             return -EINVAL;
> > +
> > +     return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> > +                         fxos8700_accel_scale[i].bits);
> > +}
> > +
> > +static int fxos8700_get_scale(struct fxos8700_data *data,
> > +                           enum fxos8700_sensor t, int *uscale)
> > +{
> > +     int i, ret, val;
> > +     static const int scale_num =3D ARRAY_SIZE(fxos8700_accel_scale);
> > +
> > +     if (t =3D=3D FXOS8700_MAGN) {
> > +             *uscale =3D 1200; /* Magnetometer is locked at 1200uT */
> > +             return 0;
> > +     }
> > +
> > +     ret =3D regmap_read(data->regmap, FXOS8700_XYZ_DATA_CFG, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i =3D 0; i < scale_num; i++)
> > +             if (fxos8700_accel_scale[i].bits =3D=3D (val & 0x3)) {
> > +                     *uscale =3D fxos8700_accel_scale[i].uscale;
> > +                     return 0;
> > +             }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int fxos8700_get_data(struct fxos8700_data *data, int chan_type=
,
> > +                          int axis, int *val)
> > +{
> > +     u8 base, reg;
> > +     int ret;
> > +     __le16 sample =3D 0;
> > +     enum fxos8700_sensor type =3D fxos8700_to_sensor(chan_type);
> > +
> > +     base =3D type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
> > +
> > +     /* Block read 6 bytes of device output registers to avoid data lo=
ss */
> > +     ret =3D regmap_bulk_read(data->regmap, base, data->buf,
> > +                            FXOS8700_DATA_BUF_SIZE);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Convert axis to buffer index */
> > +     reg =3D axis - IIO_MOD_X;
> > +
> > +     /* Composite individual axis MSB/LSB registers */
> > +     sample =3D ((u16 *)data->buf)[reg];
>
> Firstly cast to le16, then secondly don't then do a be16 to
> cpu conversion?  Which one is it le16 or be16?
>
Sorry for the confusion here. When I read the description of
regmap_bulk_read(), specifically that the buffer storing the data
should be "in native register size for device", I interpreted that to
mean I needed to use a single byte type array since the device uses
single byte registers. I think I read into that line a little too much
and I've since seen an iio driver example prove otherwise.

The device stores the data in big endian order, so I've just changed
my data buffer type to reflect that and will directly pass that to
be16_to_cpu. That way I can omit the unnecessary sample variable
that's adding to the confusion. I'll be posting a new series shortly.
> > +
> > +     /* Convert to native endianness */
> > +     *val =3D sign_extend32(be16_to_cpu(sample), 15);
> > +
> > +     return 0;
> > +}
> > +
> > +static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_=
sensor t,
> > +                         int odr, int uodr)
> > +{
> > +     int i, ret, val;
> > +     bool active_mode;
> > +     static const int odr_num =3D ARRAY_SIZE(fxos8700_odr);
> > +
> > +     ret =3D regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     active_mode =3D val & FXOS8700_ACTIVE;
> > +
> > +     if (active_mode) {
> > +             /*
> > +              * The device must be in standby mode to change any of th=
e
> > +              * other fields within CTRL_REG1
> > +              */
> > +             ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> > +                                val & ~FXOS8700_ACTIVE);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     for (i =3D 0; i < odr_num; i++)
> > +             if (fxos8700_odr[i].odr =3D=3D odr && fxos8700_odr[i].uod=
r =3D=3D uodr)
> > +                     break;
> > +
> > +     if (i >=3D odr_num)
> > +             return -EINVAL;
> > +
> > +     return regmap_update_bits(data->regmap,
> > +                               FXOS8700_CTRL_REG1,
> > +                               FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE=
,
> > +                               fxos8700_odr[i].bits << 3 | active_mode=
);
> > +}
> > +
> > +static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_=
sensor t,
> > +                         int *odr, int *uodr)
> > +{
> > +     int i, val, ret;
> > +     static const int odr_num =3D ARRAY_SIZE(fxos8700_odr);
> > +
> > +     ret =3D regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     val &=3D FXOS8700_CTRL_ODR_MSK;
> > +
> > +     for (i =3D 0; i < odr_num; i++)
> > +             if (val =3D=3D fxos8700_odr[i].bits)
> > +                     break;
> > +
> > +     if (i >=3D odr_num)
> > +             return -EINVAL;
> > +
> > +     *odr =3D fxos8700_odr[i].odr;
> > +     *uodr =3D fxos8700_odr[i].uodr;
> > +
> > +     return 0;
> > +}
> > +
> > +static int fxos8700_read_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int *val, int *val2, long mask)
> > +{
> > +     int ret;
> > +     struct fxos8700_data *data =3D iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D fxos8700_get_data(data, chan->type, chan->channel=
2, val);
> > +             if (ret)
> > +                     return ret;
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val =3D 0;
> > +             ret =3D fxos8700_get_scale(data, fxos8700_to_sensor(chan-=
>type),
> > +                                      val2);
> > +             return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             ret =3D fxos8700_get_odr(data, fxos8700_to_sensor(chan->t=
ype),
> > +                                    val, val2);
> > +             return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int fxos8700_write_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int val, int val2, long mask)
> > +{
> > +     struct fxos8700_data *data =3D iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SCALE:
> > +             return fxos8700_set_scale(data, fxos8700_to_sensor(chan->=
type),
> > +                                       val2);
> > +             break;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return fxos8700_set_odr(data, fxos8700_to_sensor(chan->ty=
pe),
> > +                                     val, val2);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
> > +                   "1.5625 6.25 12.5 50 100 200 400 800");
> > +static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
> > +                   "1.5625 6.25 12.5 50 100 200 400 800");
> > +static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.0=
00976");
> > +static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
> > +
> > +static struct attribute *fxos8700_attrs[] =3D {
> > +     &iio_const_attr_in_accel_sampling_frequency_available.dev_attr.at=
tr,
> > +     &iio_const_attr_in_magn_sampling_frequency_available.dev_attr.att=
r,
> > +     &iio_const_attr_in_accel_scale_available.dev_attr.attr,
> > +     &iio_const_attr_in_magn_scale_available.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group fxos8700_attrs_group =3D {
> > +     .attrs =3D fxos8700_attrs,
> > +};
> > +
> > +static const struct iio_info fxos8700_info =3D {
> > +     .read_raw =3D fxos8700_read_raw,
> > +     .write_raw =3D fxos8700_write_raw,
> > +     .attrs =3D &fxos8700_attrs_group,
> > +};
> > +
> > +static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi=
)
> > +{
> > +     int ret;
> > +     unsigned int val;
> > +     struct device *dev =3D regmap_get_device(data->regmap);
> > +
> > +     ret =3D regmap_read(data->regmap, FXOS8700_WHO_AM_I, &val);
> > +     if (ret) {
> > +             dev_err(dev, "Error reading chip id\n");
> > +             return ret;
> > +     }
> > +     if (val !=3D FXOS8700_DEVICE_ID && val !=3D FXOS8700_PRE_DEVICE_I=
D) {
> > +             dev_err(dev, "Wrong chip id, got %x expected %x or %x\n",
> > +                     val, FXOS8700_DEVICE_ID, FXOS8700_PRE_DEVICE_ID);
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D fxos8700_set_active_mode(data, FXOS8700_ACCEL, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D fxos8700_set_active_mode(data, FXOS8700_MAGN, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * The device must be in standby mode to change any of the other =
fields
> > +      * within CTRL_REG1
> > +      */
> > +     ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1, 0x00);
> > +     if (ret)
> > +             return ret;
> > +     /* Set max oversample ratio (OSR) and both devices active */
> > +     ret =3D regmap_write(data->regmap, FXOS8700_M_CTRL_REG1,
> > +                        FXOS8700_HMS_MASK | FXOS8700_OS_MASK);
> > +     if (ret)
> > +             return ret;
> > +     /* Disable and rst min/max measurements & threshold */
> > +     ret =3D regmap_write(data->regmap, FXOS8700_M_CTRL_REG2,
> > +                        FXOS8700_MAXMIN_RST | FXOS8700_MAXMIN_DIS_THS =
|
> > +                        FXOS8700_MAXMIN_DIS);
> > +     if (ret)
> > +             return ret;
> > +     /* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> > +     ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> > +                        FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> > +     if (ret)
> > +             return ret;
> > +     /* Set for max full-scale range (+/-8G) */
> > +     ret =3D regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G=
);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static void fxos8700_chip_uninit(void *data)
> > +{
> > +     struct fxos8700_data *fxos8700_data =3D data;
> > +
> > +     fxos8700_set_active_mode(fxos8700_data, FXOS8700_ACCEL, false);
> > +     fxos8700_set_active_mode(fxos8700_data, FXOS8700_MAGN, false);
> > +}
> > +
> > +int fxos8700_core_probe(struct device *dev, struct regmap *regmap,
> > +                     const char *name, bool use_spi)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct fxos8700_data *data;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data =3D iio_priv(indio_dev);
> > +     dev_set_drvdata(dev, indio_dev);
> > +     data->regmap =3D regmap;
> > +
> > +     ret =3D fxos8700_chip_init(data, use_spi);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_add_action_or_reset(dev, fxos8700_chip_uninit, data)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     indio_dev->dev.parent =3D dev;
> > +     indio_dev->channels =3D fxos8700_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(fxos8700_channels);
> > +     indio_dev->name =3D name ? name : "fxos8700";
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->info =3D &fxos8700_info;
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(fxos8700_core_probe);
> > +
> > +MODULE_AUTHOR("Robert Jones <rjones@gateworks.com>");
> > +MODULE_DESCRIPTION("FXOS8700 6-Axis Acc and Mag Combo Sensor driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_=
i2c.c
> > new file mode 100644
> > index 0000000..73a5f91
> > --- /dev/null
> > +++ b/drivers/iio/imu/fxos8700_i2c.c
> > @@ -0,0 +1,71 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * FXOS8700 - NXP IMU, I2C bits
> > + *
> > + * 7-bit I2C slave address determined by SA1 and SA0 logic level
> > + * inputs represented in the following table:
> > + *      SA1  |  SA0  |  Slave Address
> > + *      0    |  0    |  0x1E
> > + *      0    |  1    |  0x1D
> > + *      1    |  0    |  0x1C
> > + *      1    |  1    |  0x1F
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "fxos8700.h"
> > +
> > +static int fxos8700_i2c_probe(struct i2c_client *client,
> > +                           const struct i2c_device_id *id)
> > +{
> > +     struct regmap *regmap;
> > +     const char *name =3D NULL;
> > +
> > +     regmap =3D devm_regmap_init_i2c(client, &fxos8700_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&client->dev, "Failed to register i2c regmap %d\n=
",
> > +                     (int)PTR_ERR(regmap));
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     if (id)
> > +             name =3D id->name;
> > +
> > +     return fxos8700_core_probe(&client->dev, regmap, name, false);
> > +}
> > +
> > +static const struct i2c_device_id fxos8700_i2c_id[] =3D {
> > +     {"fxos8700", 0},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, fxos8700_i2c_id);
> > +
> > +static const struct acpi_device_id fxos8700_acpi_match[] =3D {
> > +     {"FXOS8700", 0},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fxos8700_acpi_match);
> > +
> > +static const struct of_device_id fxos8700_of_match[] =3D {
> > +     { .compatible =3D "nxp,fxos8700" },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, fxos8700_of_match);
> > +
> > +static struct i2c_driver fxos8700_i2c_driver =3D {
> > +     .driver =3D {
> > +             .name                   =3D "fxos8700_i2c",
> > +             .acpi_match_table       =3D ACPI_PTR(fxos8700_acpi_match)=
,
> > +             .of_match_table         =3D of_match_ptr(fxos8700_of_matc=
h),
> > +     },
> > +     .probe          =3D fxos8700_i2c_probe,
> > +     .id_table       =3D fxos8700_i2c_id,
> > +};
> > +module_i2c_driver(fxos8700_i2c_driver);
> > +
> > +MODULE_AUTHOR("Robert Jones <rjones@gateworks.com>");
> > +MODULE_DESCRIPTION("FXOS8700 I2C driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/iio/imu/fxos8700_spi.c b/drivers/iio/imu/fxos8700_=
spi.c
> > new file mode 100644
> > index 0000000..412ff08
> > --- /dev/null
> > +++ b/drivers/iio/imu/fxos8700_spi.c
> > @@ -0,0 +1,59 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * FXOS8700 - NXP IMU, I2C bits
> > + *
> nitpick :) Trailing blank line here doesn't add anything.
>
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
>
> If we are spinning again, another thread I read today pointed out that
> we don't actually need the of header in these files, but rather just
> mod_devicetable.h so it would be better to include that.
>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include "fxos8700.h"
> > +
> > +static int fxos8700_spi_probe(struct spi_device *spi)
> > +{
> > +     struct regmap *regmap;
> > +     const struct spi_device_id *id =3D spi_get_device_id(spi);
> > +
> > +     regmap =3D devm_regmap_init_spi(spi, &fxos8700_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> > +                     (int)PTR_ERR(regmap));
> > +             return PTR_ERR(regmap);
> > +     }
> > +     return fxos8700_core_probe(&spi->dev, regmap, id->name, true);
> > +}
> > +
> > +static const struct spi_device_id fxos8700_spi_id[] =3D {
> > +     {"fxos8700", 0},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(spi, fxos8700_spi_id);
> > +
> > +static const struct acpi_device_id fxos8700_acpi_match[] =3D {
> > +     {"FXOS8700", 0},
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fxos8700_acpi_match);
> > +
> > +static const struct of_device_id fxos8700_of_match[] =3D {
> > +     { .compatible =3D "nxp,fxos8700" },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, fxos8700_of_match);
> > +
> > +static struct spi_driver fxos8700_spi_driver =3D {
> > +     .probe          =3D fxos8700_spi_probe,
> > +     .id_table       =3D fxos8700_spi_id,
> > +     .driver =3D {
> > +             .acpi_match_table       =3D ACPI_PTR(fxos8700_acpi_match)=
,
> > +             .of_match_table         =3D fxos8700_of_match,
> > +             .name                   =3D "fxos8700_spi",
> > +     },
> > +};
> > +module_spi_driver(fxos8700_spi_driver);
> > +
> > +MODULE_AUTHOR("Robert Jones <rjones@gateworks.com>");
> > +MODULE_DESCRIPTION("FXOS8700 SPI driver");
> > +MODULE_LICENSE("GPL v2");
>
