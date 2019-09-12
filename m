Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32495B0D61
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfILK7Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:59:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36904 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbfILK7Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:59:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id s28so25635346otd.4;
        Thu, 12 Sep 2019 03:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mEd/o+j6LUXnxRNJJAbJ8bupb9RUXlnJD3bpuSIPRFA=;
        b=OMADvqvULBIcSwpsMibktidlWMehKEBAU5HAn7gkyQnpeCt3BBwzdzkeXCNn4+eKKF
         uasjRCNPHHUwcb/sSpOo02dmsVsnRqFO+GcK3RjJ+fFR6Kun5Cx3Bij31UOfubzG0x0i
         N1jt232qDrT+QmDSZ4FAw1a5ewBpHjd6P2M2htU0DfMwztHqUNB0a090/iYHWtgIKB5s
         s/UftO/Zmnb0TZryGKypuJbl/d3Rh0p0nvfB6hfjt/lxPEyAM3aMNTVtR9mXBUQE7v7/
         sE3kOBwj56WfvS7c/YRKrNEIS6iuXfpJpDnpRLQEANvdi0G7boWLNZ8Fs4Z7910F8/Bh
         xccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mEd/o+j6LUXnxRNJJAbJ8bupb9RUXlnJD3bpuSIPRFA=;
        b=BGxytWbTVNhYCynEaR74KY7Pf8SnZkYTicIyMfAL/RUnwbsot+zo9Rax2FIcunfaUe
         ptU7yRoBZYBFnH4oLEkYbZDiya9fgN2LFW5QIlq1y3XdC/q1O+lf1Qct2D+O15FRKem/
         myb+0Jr443MyvOp5tlagweRmJa06TijNgC3A4zaMpROZ1eT9dWcyv4XMqoXfi333ntZw
         oNQhwJQmQ/xoq++/0ED9U0TKNtbjYG38ossirxz7Wo4Vc+GIJMteDie9EjHTzOSVlbqf
         /vxkebb7qq6FALYG4e94q938wADAk1ry3+A3KEaOdwMGAeS9KNYwqci+90ST4/GD+De2
         vUGg==
X-Gm-Message-State: APjAAAWGz4ILz0KM8Jy5Z8dmw1cr/jgps2H/gOvkzCzs8mTaM3v4JK9K
        64rRW+MxdGpAgO1PoqUhpOj8vfZOIeL5mxwZ3ag=
X-Google-Smtp-Source: APXvYqz03VuS9D1ELvTw0ClXn5NMfBRnXT4lP/dcbbUvra7un9J5kMSc6vxL5Hzafzy5gLB/6blEI1ChDtBjsaVLEtE=
X-Received: by 2002:a05:6830:1b6b:: with SMTP id d11mr25071518ote.207.1568285962787;
 Thu, 12 Sep 2019 03:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190902005938.7734-1-rodrigorsdc@gmail.com> <20190902005938.7734-2-rodrigorsdc@gmail.com>
 <5cd4ad2f84280d8567d8c82e745a3189cecbde49.camel@analog.com>
 <20190908120905.4a1ffedc@archlinux> <4b20e66b44a113af6a2dfff5cb5592979b918101.camel@analog.com>
 <CAOeBkLrdSAk4H=BcDnFqR4x14kQDR+PYPxqgJk67ZfXfBq_nTw@mail.gmail.com>
In-Reply-To: <CAOeBkLrdSAk4H=BcDnFqR4x14kQDR+PYPxqgJk67ZfXfBq_nTw@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 12 Sep 2019 16:59:10 +0300
Message-ID: <CA+U=DsqZhcL2ch_cZ9ONn__74o97SfwbBhNNVLJqBVZcB05qeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: iio: accel: adis16240: move out of staging
To:     Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 11, 2019 at 7:21 PM Rodrigo Carvalho <rodrigorsdc@gmail.com> wr=
ote:
>
> Hi,
>
> Em seg, 9 de set de 2019 =C3=A0s 02:53, Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> escreveu:
> >
> > On Sun, 2019-09-08 at 12:09 +0100, Jonathan Cameron wrote:
> > > On Mon, 2 Sep 2019 13:26:02 +0000
> > > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> > >
> > > > On Sun, 2019-09-01 at 21:59 -0300, Rodrigo Carvalho wrote:
> > > > > Move ADIS16240 driver from staging to mainline.
> > > > >
> > > > > The ADIS16240 is a fully integrated digital shock detection
> > > > > and recorder system.
> > > >
> > > > Hey,
> > > >
> > > > Comments inline.
> > > >
> > > > I'll probably take a look in the next days again.
> > > > There seem to be some ABI/sysfs attributes that need to be resolved=
 before moving this out of staging.
> > >
> > > Absolutely. It is a 'new' type of device so there are definitely some
> > > corners that need discussing before we move out of staging and commit
> > > to maintaining the ABI moving forwards.
> > >
> > > That is the real reason this driver was still in staging!  No one
> > > had been through the process of proposing the ABI and responding to
> > > questions etc.
> > >
> > > The issue with impact sensors has always been that they don't really =
fit
> > > our normal model for buffers or triggers.
> > >
> > > So normally a trigger (if exposed in IIO) is used as one trigger
> > > causes 1 set of samples (so like a frame trigger for a camera).
> > >
> > > These devices tend to work in a mode where one trigger causes data
> > > to be captured for a period of time.  In this part that's the event
> > > recorder function
> > >
> > > No one is realistically going to buy an impact sensor to just use it
> > > as an accelerometer which is what this driver is currently doing.
> > > I suppose we could just leave support in that form for now, but
> > > I'm no sure how much use it is to anyone.
> > >
> > > Analog Devices people, worth working out how to support the event
> > > recorder?  For that someone needs to have hardware as it is complex
> > > to say the least!
> >
> > Worth it: yes.
> > But we don't have any resources to allocate for this [at this point in =
time].
> >
> > >
> > > We could move it out but might be worth adding a comment somewhere
> > > saying this only really supports direct access to channels, and
> > > not the event recorder functionality.
> > >
> >
> > I guess, I would vote for leaving it in staging.
> > It's also a way to mark it as a work-in-progress/not-done/still-needs-s=
omething kind of thing.
> > If we move it now, it gets the status of "everything-resolved" which is=
 not yet the case.
> >
> > Thanks for the insight/background info.
> > Much of it was discussed before my time.
>
> How about adis16203? Is it more simple to move this driver out of staging=
?

Replying from my personal email, as I seem to have my periodical
issues with the work-email.

At first glance I can't see any obvious blockers for this.

I think Jonathan may need to provide some feedback here.

Thanks
Alex

>
> > >
> > > Jonathan
> >
> > Alex
> >
> > >
> > >
> > > > > Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> > > > > ---
> > > > >  drivers/iio/accel/Kconfig             |  12 +
> > > > >  drivers/iio/accel/Makefile            |   1 +
> > > > >  drivers/iio/accel/adis16240.c         | 454 ++++++++++++++++++++=
++++++
> > > > >  drivers/staging/iio/accel/Kconfig     |  12 -
> > > > >  drivers/staging/iio/accel/Makefile    |   1 -
> > > > >  drivers/staging/iio/accel/adis16240.c | 454 --------------------=
------
> > > > >  6 files changed, 467 insertions(+), 467 deletions(-)
> > > > >  create mode 100644 drivers/iio/accel/adis16240.c
> > > > >  delete mode 100644 drivers/staging/iio/accel/adis16240.c
> > > >
> > > > Looks like MAINTAINERS file also needs to be updated, also with the=
 DT bindings file.
> > > > I think checkpatch usually complains about these.
> > > >
> > > > > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfi=
g
> > > > > index d4ef35aeb579..91fd8741c95f 100644
> > > > > --- a/drivers/iio/accel/Kconfig
> > > > > +++ b/drivers/iio/accel/Kconfig
> > > > > @@ -30,6 +30,18 @@ config ADIS16209
> > > > >     To compile this driver as a module, say M here: the module wi=
ll be
> > > > >     called adis16209.
> > > > >
> > > > > +config ADIS16240
> > > > > + tristate "Analog Devices ADIS16240 Programmable Impact Sensor a=
nd Recorder"
> > > > > + depends on SPI
> > > > > + select IIO_ADIS_LIB
> > > > > + select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> > > > > + help
> > > > > +   Say Y here to build support for Analog Devices adis16240 prog=
rammable
> > > > > +   impact Sensor and recorder.
> > > > > +
> > > > > +   To compile this driver as a module, say M here: the module wi=
ll be
> > > > > +   called adis16240.
> > > > > +
> > > > >  config ADXL345
> > > > >   tristate
> > > > >
> > > > > diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makef=
ile
> > > > > index 56bd0215e0d4..f7e025a86dd9 100644
> > > > > --- a/drivers/iio/accel/Makefile
> > > > > +++ b/drivers/iio/accel/Makefile
> > > > > @@ -6,6 +6,7 @@
> > > > >  # When adding new entries keep the list in alphabetical order
> > > > >  obj-$(CONFIG_ADIS16201) +=3D adis16201.o
> > > > >  obj-$(CONFIG_ADIS16209) +=3D adis16209.o
> > > > > +obj-$(CONFIG_ADIS16240) +=3D adis16240.o
> > > > >  obj-$(CONFIG_ADXL345) +=3D adxl345_core.o
> > > > >  obj-$(CONFIG_ADXL345_I2C) +=3D adxl345_i2c.o
> > > > >  obj-$(CONFIG_ADXL345_SPI) +=3D adxl345_spi.o
> > > > > diff --git a/drivers/iio/accel/adis16240.c b/drivers/iio/accel/ad=
is16240.c
> > > > > new file mode 100644
> > > > > index 000000000000..82099db4bf0c
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/accel/adis16240.c
> > > > > @@ -0,0 +1,454 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * ADIS16240 Programmable Impact Sensor and Recorder driver
> > > > > + *
> > > > > + * Copyright 2010 Analog Devices Inc.
> > > > > + */
> > > > > +
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/irq.h>
> > > > > +#include <linux/gpio.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/spi/spi.h>
> > > > > +#include <linux/slab.h>
> > > > > +#include <linux/sysfs.h>
> > > > > +#include <linux/list.h>
> > > > > +#include <linux/module.h>
> > > > > +
> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/iio/sysfs.h>
> > > > > +#include <linux/iio/buffer.h>
> > > > > +#include <linux/iio/imu/adis.h>
> > > > > +
> > > > > +#define ADIS16240_STARTUP_DELAY  220 /* ms */
> > > > > +
> > > > > +/* Flash memory write count */
> > > > > +#define ADIS16240_FLASH_CNT      0x00
> > > > > +
> > > > > +/* Output, power supply */
> > > > > +#define ADIS16240_SUPPLY_OUT     0x02
> > > > > +
> > > > > +/* Output, x-axis accelerometer */
> > > > > +#define ADIS16240_XACCL_OUT      0x04
> > > > > +
> > > > > +/* Output, y-axis accelerometer */
> > > > > +#define ADIS16240_YACCL_OUT      0x06
> > > > > +
> > > > > +/* Output, z-axis accelerometer */
> > > > > +#define ADIS16240_ZACCL_OUT      0x08
> > > > > +
> > > > > +/* Output, auxiliary ADC input */
> > > > > +#define ADIS16240_AUX_ADC        0x0A
> > > > > +
> > > > > +/* Output, temperature */
> > > > > +#define ADIS16240_TEMP_OUT       0x0C
> > > > > +
> > > > > +/* Output, x-axis acceleration peak */
> > > > > +#define ADIS16240_XPEAK_OUT      0x0E
> > > > > +
> > > > > +/* Output, y-axis acceleration peak */
> > > > > +#define ADIS16240_YPEAK_OUT      0x10
> > > > > +
> > > > > +/* Output, z-axis acceleration peak */
> > > > > +#define ADIS16240_ZPEAK_OUT      0x12
> > > > > +
> > > > > +/* Output, sum-of-squares acceleration peak */
> > > > > +#define ADIS16240_XYZPEAK_OUT    0x14
> > > > > +
> > > > > +/* Output, Capture Buffer 1, X and Y acceleration */
> > > > > +#define ADIS16240_CAPT_BUF1      0x16
> > > > > +
> > > > > +/* Output, Capture Buffer 2, Z acceleration */
> > > > > +#define ADIS16240_CAPT_BUF2      0x18
> > > > > +
> > > > > +/* Diagnostic, error flags */
> > > > > +#define ADIS16240_DIAG_STAT      0x1A
> > > > > +This looks like it could be converted to IIO_CHAN_INFO_SAMP_FREQ=
 attribute.
> > > > > +/* Diagnostic, event counter */
> > > > > +#define ADIS16240_EVNT_CNTR      0x1C
> > > > > +
> > > > > +/* Diagnostic, check sum value from firmware test */
> > > > > +#define ADIS16240_CHK_SUM        0x1E
> > > > > +
> > > > > +/* Calibration, x-axis acceleration offset adjustment */
> > > > > +#define ADIS16240_XACCL_OFF      0x20
> > > > > +
> > > > > +/* Calibration, y-axis acceleration offset adjustment */
> > > > > +#define ADIS16240_YACCL_OFF      0x22
> > > > > +
> > > > > +/* Calibration, z-axis acceleration offset adjustment */
> > > > > +#define ADIS16240_ZACCL_OFF      0x24
> > > > > +This looks like it could be converted to IIO_CHAN_INFO_SAMP_FREQ=
 attribute.
> > > > > +/* Clock, hour and minute */
> > > > > +#define ADIS16240_CLK_TIME       0x2E
> > > > > +
> > > > > +/* Clock, month and day */
> > > > > +#define ADIS16240_CLK_DATE       0x30
> > > > > +
> > > > > +/* Clock, year */
> > > > > +#define ADIS16240_CLK_YEAR       0x32
> > > > > +
> > > > > +/* Wake-up setting, hour and minute */
> > > > > +#define ADIS16240_WAKE_TIME      0x34
> > > > > +
> > > > > +/* Wake-up setting, month and day */
> > > > > +#define ADIS16240_WAKE_DATE      0x36
> > > > > +
> > > > > +/* Alarm 1 amplitude threshold */
> > > > > +#define ADIS16240_ALM_MAG1       0x38
> > > > > +
> > > > > +/* Alarm 2 amplitude threshold */
> > > > > +#define ADIS16240_ALM_MAG2       0x3A
> > > > > +
> > > > > +/* Alarm control */
> > > > > +#define ADIS16240_ALM_CTRL       0x3C
> > > > > +
> > > > > +/* Capture, external trigger control */
> > > > > +#define ADIS16240_XTRIG_CTRL     0x3E
> > > > > +
> > > > > +/* Capture, address pointer */
> > > > > +#define ADIS16240_CAPT_PNTR      0x40
> > > > > +
> > > > > +/* Capture, configuration and control */
> > > > > +#define ADIS16240_CAPT_CTRL      0x42
> > > > > +
> > > > > +/* General-purpose digital input/output control */
> > > > > +#define ADIS16240_GPIO_CTRL      0x44
> > > > > +
> > > > > +/* Miscellaneous control */
> > > > > +#define ADIS16240_MSC_CTRL       0x46
> > > > > +
> > > > > +/* Internal sample period (rate) control */
> > > > > +#define ADIS16240_SMPL_PRD       0x48
> > > > > +
> > > > > +/* System command */
> > > > > +#define ADIS16240_GLOB_CMD       0x4A
> > > > > +
> > > > > +/* MSC_CTRL */
> > > > > +
> > > > > +/* Enables sum-of-squares output (XYZPEAK_OUT) */
> > > > > +#define ADIS16240_MSC_CTRL_XYZPEAK_OUT_EN        BIT(15)
> > > > > +
> > > > > +/* Enables peak tracking output (XPEAK_OUT, YPEAK_OUT, and ZPEAK=
_OUT) */
> > > > > +#define ADIS16240_MSC_CTRL_X_Y_ZPEAK_OUT_EN      BIT(14)
> > > > > +
> > > > > +/* Self-test enable: 1 =3D apply electrostatic force, 0 =3D disa=
bled */
> > > > > +#define ADIS16240_MSC_CTRL_SELF_TEST_EN          BIT(8)
> > > > > +
> > > > > +/* Data-ready enable: 1 =3D enabled, 0 =3D disabled */
> > > > > +#define ADIS16240_MSC_CTRL_DATA_RDY_EN           BIT(2)
> > > > > +
> > > > > +/* Data-ready polarity: 1 =3D active high, 0 =3D active low */
> > > > > +#define ADIS16240_MSC_CTRL_ACTIVE_HIGH           BIT(1)
> > > > > +
> > > > > +/* Data-ready line selection: 1 =3D DIO2, 0 =3D DIO1 */
> > > > > +#define ADIS16240_MSC_CTRL_DATA_RDY_DIO2 BIT(0)
> > > > > +
> > > > > +/* DIAG_STAT */
> > > > > +
> > > > > +/* Alarm 2 status: 1 =3D alarm active, 0 =3D alarm inactive */
> > > > > +#define ADIS16240_DIAG_STAT_ALARM2      BIT(9)
> > > > > +
> > > > > +/* Alarm 1 status: 1 =3D alarm active, 0 =3D alarm inactive */
> > > > > +#define ADIS16240_DIAG_STAT_ALARM1      BIT(8)
> > > > > +
> > > > > +/* Capture buffer full: 1 =3D capture buffer is full */
> > > > > +#define ADIS16240_DIAG_STAT_CPT_BUF_FUL BIT(7)
> > > > > +
> > > > > +/* Flash test, checksum flag: 1 =3D mismatch, 0 =3D match */
> > > > > +#define ADIS16240_DIAG_STAT_CHKSUM      BIT(6)
> > > > > +
> > > > > +/* Power-on, self-test flag: 1 =3D failure, 0 =3D pass */
> > > > > +#define ADIS16240_DIAG_STAT_PWRON_FAIL_BIT  5
> > > > > +
> > > > > +/* Power-on self-test: 1 =3D in-progress, 0 =3D complete */
> > > > > +#define ADIS16240_DIAG_STAT_PWRON_BUSY  BIT(4)
> > > > > +
> > > > > +/* SPI communications failure */
> > > > > +#define ADIS16240_DIAG_STAT_SPI_FAIL_BIT 3
> > > > > +
> > > > > +/* Flash update failure */
> > > > > +#define ADIS16240_DIAG_STAT_FLASH_UPT_BIT        2
> > > > > +
> > > > > +/* Power supply above 3.625 V */
> > > > > +#define ADIS16240_DIAG_STAT_POWER_HIGH_BIT       1
> > > > > +
> > > > > + /* Power supply below 2.225 V */
> > > > > +#define ADIS16240_DIAG_STAT_POWER_LOW_BIT        0
> > > > > +
> > > > > +/* GLOB_CMD */
> > > > > +
> > > > > +#define ADIS16240_GLOB_CMD_RESUME        BIT(8)
> > > > > +#define ADIS16240_GLOB_CMD_SW_RESET      BIT(7)
> > > > > +#define ADIS16240_GLOB_CMD_STANDBY       BIT(2)
> > > > > +
> > > > > +#define ADIS16240_ERROR_ACTIVE          BIT(14)
> > > > > +
> > > > > +/* At the moment triggers are only used for ring buffer
> > > > > + * filling. This may change!
> > > > > + */
> > > > > +
> > > > > +enum adis16240_scan {
> > > > > + ADIS16240_SCAN_ACC_X,
> > > > > + ADIS16240_SCAN_ACC_Y,
> > > > > + ADIS16240_SCAN_ACC_Z,
> > > > > + ADIS16240_SCAN_SUPPLY,
> > > > > + ADIS16240_SCAN_AUX_ADC,
> > > > > + ADIS16240_SCAN_TEMP,
> > > > > +};
> > > > > +
> > > > > +static ssize_t adis16240_spi_read_signed(struct device *dev,
> > > > > +                                  struct device_attribute *attr,
> > > > > +                                  char *buf,
> > > > > +                                  unsigned int bits)
> > > > > +{
> > > > > + struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > > > + struct adis *st =3D iio_priv(indio_dev);
> > > > > + int ret;
> > > > > + s16 val =3D 0;
> > > > > + unsigned int shift =3D 16 - bits;
> > > > > + struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> > > > > +
> > > > > + ret =3D adis_read_reg_16(st,
> > > > > +                        this_attr->address, (u16 *)&val);
> > >
> > > Check for odd line breaks.  That looks like it'll fit under 80 chars
> > > just fine.
> > >
> > > > > + if (ret)
> > > > > +         return ret;
> > > > > +
> > > > > + if (val & ADIS16240_ERROR_ACTIVE)
> > > > > +         adis_check_status(st);
> > > > > +
> > > > > + val =3D (s16)(val << shift) >> shift;
> > >
> > > Use sign_extend32 (added after this driver I think!)
> > >
> > > > > + return sprintf(buf, "%d\n", val);
> > > > > +}
> > > > > +
> > > > > +static ssize_t adis16240_read_12bit_signed(struct device *dev,
> > > > > +                                    struct device_attribute *att=
r,
> > > > > +                                    char *buf)
> > > > > +{
> > > > > + return adis16240_spi_read_signed(dev, attr, buf, 12);
> > > > > +}
> > > > > +
> > > > > +static IIO_DEVICE_ATTR(in_accel_xyz_squared_peak_raw, 0444,
> > > > > +                adis16240_read_12bit_signed, NULL,
> > > > > +                ADIS16240_XYZPEAK_OUT);
> > > > > +
> > > > > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
> > > > > +
> > > > > +static const u8 adis16240_addresses[][2] =3D {
> > > > > + [ADIS16240_SCAN_ACC_X] =3D { ADIS16240_XACCL_OFF, ADIS16240_XPE=
AK_OUT },
> > > > > + [ADIS16240_SCAN_ACC_Y] =3D { ADIS16240_YACCL_OFF, ADIS16240_YPE=
AK_OUT },
> > > > > + [ADIS16240_SCAN_ACC_Z] =3D { ADIS16240_ZACCL_OFF, ADIS16240_ZPE=
AK_OUT },
> > > > > +};
> > > > > +
> > > > > +static int adis16240_read_raw(struct iio_dev *indio_dev,
> > > > > +                       struct iio_chan_spec const *chan,
> > > > > +                       int *val, int *val2,
> > > > > +                       long mask)
> > > > > +{
> > > > > + struct adis *st =3D iio_priv(indio_dev);
> > > > > + int ret;
> > > > > + u8 addr;
> > > > > + s16 val16;
> > > > > +
> > > > > + switch (mask) {
> > > > > + case IIO_CHAN_INFO_RAW:
> > > > > +         return adis_single_conversion(indio_dev, chan,
> > > > > +                         ADIS16240_ERROR_ACTIVE, val);
> > > > > + case IIO_CHAN_INFO_SCALE:
> > > > > +         switch (chan->type) {
> > > > > +         case IIO_VOLTAGE:
> > > > > +                 if (chan->channel =3D=3D 0) {
> > > > > +                         *val =3D 4;
> > > > > +                         *val2 =3D 880000; /* 4.88 mV */
> > > > > +                         return IIO_VAL_INT_PLUS_MICRO;
> > > > > +                 }
> > > > > +                 return -EINVAL;
> > > > > +         case IIO_TEMP:
> > > > > +                 *val =3D 244; /* 0.244 C */
> > > > > +                 *val2 =3D 0;
> > > >
> > > > This looks like a bug in the original driver.
> > > > I think *val =3D 0, and *val2 =3D 244 ?
>
> I have doubt about this. Also in adis16203, adis16209 and
> adis16201 decimal parts are in *val and not in *val2 on
> IIO_TEMP. What do you think? If it is really a bug, I can send
> a patch.
>
> > > > > +                 return IIO_VAL_INT_PLUS_MICRO;
> > > > > +         case IIO_ACCEL:
> > > > > +                 *val =3D 0;
> > > > > +                 *val2 =3D IIO_G_TO_M_S_2(51400); /* 51.4 mg */
> > > > > +                 return IIO_VAL_INT_PLUS_MICRO;
> > > > > +         default:
> > > > > +                 return -EINVAL;
> > > > > +         }
> > > > > +         break;
> > > > > + case IIO_CHAN_INFO_PEAK_SCALE:
> > > > > +         *val =3D 0;
> > > > > +         *val2 =3D IIO_G_TO_M_S_2(51400); /* 51.4 mg */
> > > > > +         return IIO_VAL_INT_PLUS_MICRO;
> > > > > + case IIO_CHAN_INFO_OFFSET:
> > > > > +         *val =3D 25000 / 244 - 0x133; /* 25 C =3D 0x133 */
> > > > > +         return IIO_VAL_INT;
> > > > > + case IIO_CHAN_INFO_CALIBBIAS:
> > > > > +         addr =3D adis16240_addresses[chan->scan_index][0];
> > > > > +         ret =3D adis_read_reg_16(st, addr, &val16);
> > > > > +         if (ret)
> > > > > +                 return ret;
> > > > > +         *val =3D sign_extend32(val16, 9);
> > > > > +         return IIO_VAL_INT;
> > > > > + case IIO_CHAN_INFO_PEAK:
> > > > > +         addr =3D adis16240_addresses[chan->scan_index][1];
> > > > > +         ret =3D adis_read_reg_16(st, addr, &val16);
> > > > > +         if (ret)
> > > > > +                 return ret;
> > > > > +         *val =3D sign_extend32(val16, 9);
> > > > > +         return IIO_VAL_INT;
> > > > > + }
> > > > > + return -EINVAL;
> > > > > +}
> > > > > +
> > > > > +static int adis16240_write_raw(struct iio_dev *indio_dev,
> > > > > +                        struct iio_chan_spec const *chan,
> > > > > +                        int val,
> > > > > +                        int val2,
> > > > > +                        long mask)
> > > > > +{
> > > > > + struct adis *st =3D iio_priv(indio_dev);
> > > > > + u8 addr;
> > > > > +
> > > > > + switch (mask) {
> > > > > + case IIO_CHAN_INFO_CALIBBIAS:
> > > > > +         addr =3D adis16240_addresses[chan->scan_index][0];
> > > > > +         return adis_write_reg_16(st, addr, val & GENMASK(9, 0))=
;
> > > > > + }
> > > > > + return -EINVAL;
> > > > > +}
> > > > > +
> > > > > +static const struct iio_chan_spec adis16240_channels[] =3D {
> > > > > + ADIS_SUPPLY_CHAN(ADIS16240_SUPPLY_OUT, ADIS16240_SCAN_SUPPLY, 0=
, 10),
> > > > > + ADIS_AUX_ADC_CHAN(ADIS16240_AUX_ADC, ADIS16240_SCAN_AUX_ADC, 0,=
 10),
> > > > > + ADIS_ACCEL_CHAN(X, ADIS16240_XACCL_OUT, ADIS16240_SCAN_ACC_X,
> > > > > +                 BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INF=
O_PEAK),
> > > > > +                 0, 10),
> > > > > + ADIS_ACCEL_CHAN(Y, ADIS16240_YACCL_OUT, ADIS16240_SCAN_ACC_Y,
> > > > > +                 BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INF=
O_PEAK),
> > > > > +                 0, 10),
> > > > > + ADIS_ACCEL_CHAN(Z, ADIS16240_ZACCL_OUT, ADIS16240_SCAN_ACC_Z,
> > > > > +                 BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INF=
O_PEAK),
> > > > > +                 0, 10),
> > > > > + ADIS_TEMP_CHAN(ADIS16240_TEMP_OUT, ADIS16240_SCAN_TEMP, 0, 10),
> > > > > + IIO_CHAN_SOFT_TIMESTAMP(6)
> > > > > +};
> > > > > +
> > > > > +static struct attribute *adis16240_attributes[] =3D {
> > > > > + &iio_dev_attr_in_accel_xyz_squared_peak_raw.dev_attr.attr,
> > > >
> > > > This one looks a bit weird/rare.
> > > > I am not sure about it's use-case/need right now (at this point in =
time).
> > > >
> > > > Maybe we could just drop it?
> > > > Since I did not write the initial driver, I don't know yet what it =
was supposed to be/do.
> > >
> > > For an impact sensor it's a fairly useful thing I suspect as it is gi=
ving the maximum
> > > acceleration in any direction that occured (once you square root it i=
n userspace.)
> > >
> > > > In any case, if we want to add it, it looks like it needs an ABI do=
cumentation.
> > >
> > > Agreed. Needs docs.  We actually have a modifier for it so can be han=
dled
> > > as a channel. IIO_MOD_SUM_SQUARED_X_Y_Z :)
> > >
> > >
> > > >
> > > > > + &iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > > >
> > > > This looks like it could be converted to IIO_CHAN_INFO_SAMP_FREQ at=
tribute.
> > > >
> > > >
> > > > > + NULL
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group adis16240_attribute_group =
=3D {
> > > > > + .attrs =3D adis16240_attributes,
> > > > > +};
> > > > > +
> > > > > +static const struct iio_info adis16240_info =3D {
> > > > > + .attrs =3D &adis16240_attribute_group,
> > > > > + .read_raw =3D adis16240_read_raw,
> > > > > + .write_raw =3D adis16240_write_raw,
> > > > > + .update_scan_mode =3D adis_update_scan_mode,
> > > > > +};
> > > > > +
> > > > > +static const char * const adis16240_status_error_msgs[] =3D {
> > > > > + [ADIS16240_DIAG_STAT_PWRON_FAIL_BIT] =3D "Power on, self-test f=
ailed",
> > > > > + [ADIS16240_DIAG_STAT_SPI_FAIL_BIT] =3D "SPI failure",
> > > > > + [ADIS16240_DIAG_STAT_FLASH_UPT_BIT] =3D "Flash update failed",
> > > > > + [ADIS16240_DIAG_STAT_POWER_HIGH_BIT] =3D "Power supply above 3.=
625V",
> > > > > + [ADIS16240_DIAG_STAT_POWER_LOW_BIT] =3D "Power supply below 2.2=
25V",
> > > > > +};
> > > > > +
> > > > > +static const struct adis_data adis16240_data =3D {
> > > > > + .write_delay =3D 35,
> > > > > + .read_delay =3D 35,
> > > > > + .msc_ctrl_reg =3D ADIS16240_MSC_CTRL,
> > > > > + .glob_cmd_reg =3D ADIS16240_GLOB_CMD,
> > > > > + .diag_stat_reg =3D ADIS16240_DIAG_STAT,
> > > > > +
> > > > > + .self_test_mask =3D ADIS16240_MSC_CTRL_SELF_TEST_EN,
> > > > > + .self_test_no_autoclear =3D true,
> > > > > + .startup_delay =3D ADIS16240_STARTUP_DELAY,
> > > > > +
> > > > > + .status_error_msgs =3D adis16240_status_error_msgs,
> > > > > + .status_error_mask =3D BIT(ADIS16240_DIAG_STAT_PWRON_FAIL_BIT) =
|
> > > > > +         BIT(ADIS16240_DIAG_STAT_SPI_FAIL_BIT) |
> > > > > +         BIT(ADIS16240_DIAG_STAT_FLASH_UPT_BIT) |
> > > > > +         BIT(ADIS16240_DIAG_STAT_POWER_HIGH_BIT) |
> > > > > +         BIT(ADIS16240_DIAG_STAT_POWER_LOW_BIT),
> > > > > +};
> > > > > +
> > > > > +static int adis16240_probe(struct spi_device *spi)
> > > > > +{
> > > > > + int ret;
> > > > > + struct adis *st;
> > > > > + struct iio_dev *indio_dev;
> > > > > +
> > > > > + /* setup the industrialio driver allocated elements */
> > >
> > > I would review comments and decide whether they actually add anything=
.
> > > This one for example - I'm not convinced!
> > >
> > > > > + indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > > > > + if (!indio_dev)
> > > > > +         return -ENOMEM;
> > > > > + st =3D iio_priv(indio_dev);
> > > > > + /* this is only used for removal purposes */
> > > > > + spi_set_drvdata(spi, indio_dev);
> > > > > +
> > > > > + indio_dev->name =3D spi->dev.driver->name;
> > > > > + indio_dev->dev.parent =3D &spi->dev;
> > > > > + indio_dev->info =3D &adis16240_info;
> > > > > + indio_dev->channels =3D adis16240_channels;
> > > > > + indio_dev->num_channels =3D ARRAY_SIZE(adis16240_channels);
> > > > > + indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > > +
> > > > > + ret =3D adis_init(st, indio_dev, spi, &adis16240_data);
> > > > > + if (ret)
> > > > > +         return ret;
> > >
> > > Might be nice to look at adding some white space after error handling
> > > blocks like this.  A blank line in locations like this make it
> > > easier for the eye to follow the code.
> > >
> > > > > + ret =3D adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> > > > > + if (ret)
> > > > > +         return ret;
> > > > > +
> > > > > + /* Get the device into a sane initial state */
> > > > > + ret =3D adis_initial_startup(st);
> > > > > + if (ret)
> > > > > +         goto error_cleanup_buffer_trigger;
> > > > > + ret =3D iio_device_register(indio_dev);
> > > > > + if (ret)
> > > > > +         goto error_cleanup_buffer_trigger;
> > > > > + return 0;
> > > > > +
> > > > > +error_cleanup_buffer_trigger:
> > > > > + adis_cleanup_buffer_and_trigger(st, indio_dev);
> > > > > + return ret;
> > > > > +}
> > > > > +
> > > > > +static int adis16240_remove(struct spi_device *spi)
> > > > > +{
> > > > > + struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > > > > + struct adis *st =3D iio_priv(indio_dev);
> > > > > +
> > > > > + iio_device_unregister(indio_dev);
> > > > > + adis_cleanup_buffer_and_trigger(st, indio_dev);
> > > > > +
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id adis16240_of_match[] =3D {
> > > > > + { .compatible =3D "adi,adis16240" },
> > > > > + { },
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, adis16240_of_match);
> > > > > +
> > > > > +static struct spi_driver adis16240_driver =3D {
> > > > > + .driver =3D {
> > > > > +         .name =3D "adis16240",
> > > > > +         .of_match_table =3D adis16240_of_match,
> > > > > + },
> > > > > + .probe =3D adis16240_probe,
> > > > > + .remove =3D adis16240_remove,
> > > > > +};
> > > > > +module_spi_driver(adis16240_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> > > > > +MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor an=
d Recorder");
> > > > > +MODULE_LICENSE("GPL v2");
> > > > > +MODULE_ALIAS("spi:adis16240");
> > > ...
>
> Thanks,
> Rodrigo
