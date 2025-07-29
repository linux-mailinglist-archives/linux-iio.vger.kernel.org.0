Return-Path: <linux-iio+bounces-22124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C1EB146F4
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 05:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E958F1AA146B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230222333D;
	Tue, 29 Jul 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUCgshSs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE44409;
	Tue, 29 Jul 2025 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753761009; cv=none; b=ZBfNND1INb/ZCiwVfuiynbfc1GLSoZvQxnQS7JBfcNdjxWqoAfI0lKbEoWRz04be72Gi73K8T7DEEhX4I68//1iDLT9wuJDFVqs61CT7Tw7XitgF2YV8RjUyftaeI8tkNeD2wSkvSnJ//HTTQtGHqmPXIqtgB8pzopwTsLEkR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753761009; c=relaxed/simple;
	bh=GwoSywqb75A9kUyJRRwCUhzosQu7xCUlT2xBV0B6uDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH9rR/R8WyuLUrUMNDSR20enOUDF/GmOQRDlCxXFO3dmb+k64V9MqTWi7vuzYu0IW9wzxV2JsYm+I1oXxvIO6GnscCexfOmvKG+e+z/D8VhqRkPKYGro9s9vBspJpZZSbn5Rc2AdDo/xMDSd1penQ7hoy7nP6hR2VJegCZgT+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUCgshSs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748fe69a7baso4576570b3a.3;
        Mon, 28 Jul 2025 20:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753761006; x=1754365806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zWDOZ1t9Wu1DIPstZs5/0XOPZzkzoqFA2BqltpC8yxk=;
        b=JUCgshSs7vUoZH4y7WtHo827di9qVEbmc+fAqEiRqA4TmrFmeNsuJ6Ez0iVsEc5uvu
         xydPzODVQmkxwYAmTu5pNYRGU5KeCW9Kf8ee0iytUTHKa8oZbQx1jCKHYhHF6ywE2pNi
         PIHtDjwGo70CyZ6YQ2LNxmPmksx662Cbf3s5dKORPNHCVJn9dR+M7IyTj7ua/uTXIsd0
         BdDbjSm/ezMEvv852F+Hmb6VtDBT2C52UiV+w4lwSgbUJkegbXxU0lQwvB2tGec5htTc
         7HAjDAm4bRp+o1aPhiJLgQdlU0mV3rqxTp8tY/ujY664/O0s4KWYwaRbFP04/Rkf6MMy
         6OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753761006; x=1754365806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWDOZ1t9Wu1DIPstZs5/0XOPZzkzoqFA2BqltpC8yxk=;
        b=uV/amQnbjze+J5cTZ2yaczF3506JskPXjHbx+4wQj8YP2vuNBpaVGR9Vq0ZGY0R2ut
         xa+NIKRpRpIWu7RxiHO9GtK/1mYMuOe/hdoLESE/qnx7OBzLGD7kRXQ42O0sluVOb8AL
         foASkD/s7QlSMrBF6fZhDg57AvDFnBfp/7mlEyk6L793MAlPRQr4GopVg2gnHDNJ7eg/
         S0xzC05MokiG+aVtF8205mUu9VLtjniR4Q1GAISXAQiqNWHzLW6BwhcIeAVwkRro8kzB
         HkIncQSet3rFCwDA0fo4L4XjVLpYwt1j8Awrj+B0qpo8o4D16qQRViVlz3F8rn8LraAA
         rCrg==
X-Forwarded-Encrypted: i=1; AJvYcCWG3113lKJShTCFHRo/AbpGPxP1P+SEHNtb9V5Oici1DTXbyW58e2DQdQNqwhw1uqdI1ThkDJ0sbGLtVydx@vger.kernel.org, AJvYcCX6x42ejdyBmCQnAFOnLTZr8ZY1NNFLbDicuG6E/eoyLz0yXk/rlhMWA0M8Z/cNtfvNj3rlr93IzRWF@vger.kernel.org, AJvYcCXhnPpvKNV2zkkE3H9Zxc+6kr8e3C/r+cF2dCnsWtd5K0SMKrhGVfLfKNHPG0bZLr5luEAd8xlKXy1c@vger.kernel.org
X-Gm-Message-State: AOJu0YwGczQKgAOSwTmNIeOjTZuaapEqkI1QLTa+YT0I7X+6NtQ3JbYa
	WB5GkndLF2g7VEX31Ly/nwHJL//OvIZN0PJ0VEcMmZ7EAXdaiK8L5Rmw
X-Gm-Gg: ASbGncuWX4xToMwuuUTh8xyU7kkFcwc9+fUnl4DjEEb1Eb65Ej7xZUDk8Q2aqX8m5OH
	IJ9FOAsqvemDeT8PteVYiBCmNx2QUWffLwTEayx22unIQr9yGSyG76dUjw90SnglmjvtvaSjIYP
	mtgRJ9WK/3PNUkCiMyC27OfljfM4djP384mTLcfq7QNBovtbliFG0FZ6TRXxrZyas9oJ8j9VO0O
	28OICij5KzAIf4Ib0q2ebBbJ69Q0p4bSo4oHLkj+MLrmRFzRp8nR3+cNrjI8ErMvalkFwkkKQ7H
	kp4Vxz7grnGeBK9KVGAJZVMGoB8BqrslNAHjgdTIzx4y9wW1wcHzC69xytPGtkzDdu/EZYw0yNC
	+AizXeSOzQcaEAMw/X5cu3Q8f6l1lB9/1
X-Google-Smtp-Source: AGHT+IFpaGFmTjXI+1+e1JXzleEF5bgJXxM0L7lqGP9DbR4Z6vjZ+ZPN9vOmcuqRwT2S6aIldQwk5g==
X-Received: by 2002:a05:6a20:3d19:b0:22b:f4e5:d0ee with SMTP id adf61e73a8af0-23d700529d2mr25236592637.14.1753761006274;
        Mon, 28 Jul 2025 20:50:06 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:9464:4ee2:7e58:1508:18c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640881ededsm6783990b3a.17.2025.07.28.20.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 20:50:05 -0700 (PDT)
Date: Tue, 29 Jul 2025 09:19:59 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <aIhE5zwrPljqHqGX@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
 <20250727140559.1f6c1668@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250727140559.1f6c1668@jic23-huawei>

On Sun, Jul 27, 2025 at 02:05:59PM +0100, Jonathan Cameron wrote:
> On Sat, 26 Jul 2025 15:07:01 +0530
> Dixit Parmar <dixitparmar19@gmail.com> wrote:
> 
> Hi Dixit,
> 
> Very clean driver for a v1. Nice.
> 
> > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> 
> Slightly odd wrap.  Aim for 75 chars for patch descriptions.
>
Okay, 75.
> > applications includes joysticks, control elements (white goods,
> > multifunction knops), or electric meters (anti tampering) and any
> > other application that requires accurate angular measurements at
> > low power consumptions.
> > 
> > The Sensor is configured over I2C, and as part of Sensor measurement
> > data it provides 3-Axis magnetic fields and temperature core measurement.
> > 
> > The driver supports raw value read and buffered input via external trigger
> > to allow streaming values with the same sensing timestamp.
> > 
> > The device can be configured in to different operating modes by optional
> > device-tree "mode" property. Also, the temperature sensing part requires
> > raw offset captured at 25°C and that can be specified by "temp-offset"
> > optional device-tree property.
> > 
> > While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> > configurations interrupt(INT) is not recommended, unless timing constraints
> > between I2C data transfers and interrupt pulses are monitored and aligned.
> > 
> > The Sensor's I2C register map and mode information is described in product
> > User Manual[1].
> > 
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> Tag, so in the tags block (no blank line to the SoB)
Sorry, didn't quite get it.
> > [1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf
> Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf #1
> 
> So make it a tag with a trailing comment to give the reference number.
> 
> > 
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> 
> 
> > ---
> >  drivers/iio/magnetometer/Kconfig   |  14 +
> >  drivers/iio/magnetometer/Makefile  |   2 +
> >  drivers/iio/magnetometer/tlv493d.c | 606 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 622 insertions(+)
> > 
> > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> > index 3debf1320ad1..e0070dccc751 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -246,6 +246,20 @@ config SI7210
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called si7210.
> >  
> > +config TLV493D
> > +	tristate "Infineon TLV493D Low-Power 3D Magnetic Sensor"
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  Say Y here to add support for the Infineon TLV493D-A1B6 Low-
> > +	  Power 3D Megnetic Sensor.
> > +
> > +	  This driver can also be compiled as a module.
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called tlv493d.
> > +
> >  config TI_TMAG5273
> >  	tristate "TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> > index 9297723a97d8..39c62dd06db8 100644
> > --- a/drivers/iio/magnetometer/Makefile
> > +++ b/drivers/iio/magnetometer/Makefile
> > @@ -35,4 +35,6 @@ obj-$(CONFIG_SI7210)			+= si7210.o
> >  
> >  obj-$(CONFIG_TI_TMAG5273)		+= tmag5273.o
> >  
> > +obj-$(CONFIG_TLV493D)	+= tlv493d.o
> 
> As already noted, alphabetical.
> 
Ack.
> > +
> >  obj-$(CONFIG_YAMAHA_YAS530)		+= yamaha-yas530.o
> > diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> > new file mode 100644
> > index 000000000000..f230d6409a4b
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/tlv493d.c
> > @@ -0,0 +1,606 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/**
> > + * Driver for the Infineon TLV493D Low-Power 3D Magnetic Sensor
> > + *
> > + * Copyright (C) 2025 Dixit Parmar <dixitparmar19@gmail.com>
> > + *
> 
> Trivial comment of the day - what does this blank line add?  I'd drop it.
> 
okay, will drop last blank line.
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> > +#define TLV493D_RD_REG_BX	0x00
> > +#define TLV493D_RD_REG_BY	0x01
> > +#define TLV493D_RD_REG_BZ	0x02
> > +#define TLV493D_RD_REG_TEMP	0x03
> > +#define TLV493D_RD_REG_BX2	0x04
> > +#define TLV493D_RD_REG_BZ2	0x05
> > +#define TLV493D_RD_REG_TEMP2	0x06
> > +#define TLV493D_RD_REG_RES1	0x07
> > +#define TLV493D_RD_REG_RES2	0x08
> > +#define TLV493D_RD_REG_RES3	0x09
> > +#define TLV493D_RD_REG_MAX	0x0a
> > +#define TLV493D_WR_REG_RES	0x00
> > +#define TLV493D_WR_REG_MODE1	0x01
> > +#define TLV493D_WR_REG_RES2	0x02
> > +#define TLV493D_WR_REG_MODE2	0x03
> > +#define TLV493D_WR_REG_MAX	0x04
> 
> Add a blank line here.
> 
Ack.
> > +#define TLV493D_VAL_MAG_X_AXIS_MSB	GENMASK(7, 0)
> 
> Can we name these to relate them to the registers they are in?
> If it's the whole register can probably just skip the mask.
>
Will try to fit the registers name.
> > +#define TLV493D_VAL_MAG_X_AXIS_LSB	GENMASK(7, 4)
> > +#define TLV493D_VAL_MAG_Y_AXIS_MSB	GENMASK(7, 0)
> > +#define TLV493D_VAL_MAG_Y_AXIS_LSB	GENMASK(3, 0)
> > +#define TLV493D_VAL_MAG_Z_AXIS_MSB	GENMASK(7, 0)
> > +#define TLV493D_VAL_MAG_Z_AXIS_LSB	GENMASK(3, 0)
> > +#define TLV493D_VAL_TEMP_MSB		GENMASK(7, 4)
> > +#define TLV493D_VAL_TEMP_LSB		GENMASK(7, 0)
> > +#define TLV493D_VAL_FRAME_COUNTER	GENMASK(3, 2)
> > +#define TLV493D_VAL_CHANNEL	GENMASK(1, 0)
> > +#define TLV493D_VAL_PD_FLAG	BIT(4)
> > +#define TLV493D_RD_REG_RES1_WR_MASK	GENMASK(4, 3)
> > +#define TLV493D_RD_REG_RES2_WR_MASK	GENMASK(7, 0)
> > +#define TLV493D_RD_REG_RES3_WR_MASK	GENMASK(4, 0)
> > +#define TLV493D_MODE1_MOD_FAST	BIT(1)
> > +#define TLV493D_MODE1_MOD_LOW	BIT(0)
> > +#define TLV493D_MODE2_TEMP_CTRL	BIT(7)
> > +#define TLV493D_MODE2_LP_PERIOD	BIT(6)
> > +#define TLV493D_MODE2_PARITY_CTRL	BIT(5)
> > +
> > +#define SET_BIT(b, bit)	(b |= bit)
> > +#define CLR_BIT(b, bit)	(b &= ~bit)
> 
> As others have mentioned. Drop these - they aren't things a kernel reviewer will
> expect and just make the code harder to read as a result.
> 
Understood.
> > +
> > +#define TLV493D_DATA_X_GET(b)	\
> > +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 | \
> > +			(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4), 11)
> 
> These are odd enough I'd make them c functions rather than macros. Burn a few lines
> for better readability. 
> 
I saw this kind of data retrival and formation from registers as macros so I sticked to
it. Having all these as function will also require a seperate function
for each channel coz the masks and the layout of the bits changes over
the register. Do you still recommend it as c functions?
> > +#define TLV493D_DATA_Y_GET(b)	\
> > +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 | \
> > +			FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]), 11)
> > +#define TLV493D_DATA_Z_GET(b)	\
> > +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_Z_AXIS_MSB, b[TLV493D_RD_REG_BZ]) << 4 | \
> > +			FIELD_GET(TLV493D_VAL_MAG_Z_AXIS_LSB, b[TLV493D_RD_REG_BZ2]), 11)
> > +#define TLV493D_DATA_TEMP_GET(b)	\
> > +	sign_extend32(FIELD_GET(TLV493D_VAL_TEMP_MSB, b[TLV493D_RD_REG_TEMP]) << 8 | \
> > +			FIELD_GET(TLV493D_VAL_TEMP_LSB, b[TLV493D_RD_REG_TEMP2]), 11)
> > +
> > +enum tlv493d_channels {
> > +	AXIS_X = 0,
> > +	AXIS_Y,
> > +	AXIS_Z,
> > +	TEMPERATURE,
> > +};
> > +
> > +enum tlv493d_op_mode {
> > +	TLV493D_OP_MODE_POWERDOWN = 0,
> > +	TLV493D_OP_MODE_FAST,
> > +	TLV493D_OP_MODE_LOWPOWER,
> > +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> > +	TLV493D_OP_MODE_MASTERCONTROLLED,
> > +	TLV493D_OP_MODE_MAX,
> No comma on a 'terminating entry'.  We don't want anyone to accdientally add
> anything after the MAX entry.
> 
Makes sense.
> > +};
> > +
> > +struct tlv493d_mode {
> > +	u8 m;
> > +	u32 sleep_us;
> > +};
> > +
> > +struct tlv493d_data {
> > +	struct device *dev;
> 
> Isn't this just client->dev?  If so don't bother having both.
> 
Ack.
> > +	struct i2c_client *client;
> > +	struct mutex lock;
> Needs a comment on what data it protects.
> 
Ack.
> > +	struct regmap *map;
> > +	u8 mode;
> > +	u8 wr_regs[TLV493D_WR_REG_MAX];
> > +	s32 temp_offset;
> > +};
> > +
> > +/*
> > + * Different mode has different measurement cycle time, this time is
> > + * used in deriving the sleep and timemout while reading the data from
> > + * sensor in polling.
> > + * Power-down mode: No measurement.
> > + * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
> > + * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
> > + * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
> > + * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
> > + */
> > +static struct tlv493d_mode modes[TLV493D_OP_MODE_MAX] = {
> > +	{.m = TLV493D_OP_MODE_POWERDOWN, .sleep_us = 0 },
> > +	{.m = TLV493D_OP_MODE_FAST, .sleep_us = 305 },
> > +	{.m = TLV493D_OP_MODE_LOWPOWER, .sleep_us = 10 * USEC_PER_MSEC },
> > +	{.m = TLV493D_OP_MODE_ULTRA_LOWPOWER, .sleep_us = 100 * USEC_PER_MSEC },
> > +	{.m = TLV493D_OP_MODE_MASTERCONTROLLED, .sleep_us = 305 },
> 
> Space before .m
> 
Ack.
> > +};
> > +
> > +/*
> > + * The datasheet mentions the sensor supports only direct byte-stream write starting from
> > + * register address 0x0. So for any modification to be made to any write registers, it must
> > + * be written starting from the register address 0x0.
> > + * I2C write operation should not contain register address in the I2C frame, it should
> > + * contains only raw byte stream for the write registers. As below,
> > + * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
> > + */
> > +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> > +{
> > +	int ret;
> > +
> > +	if (!data || !data->client)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * As regmap does not provide raw write API which perform I2C write without
> > +	 * specifying register address, direct i2c_master_send() API is used.
> > +	 */
> > +	ret = i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->wr_regs));
> 
> Given we have to do this, I'm a bit doubtful about regmap usage in general in here.
> Maybe it's just not a good fit and we should stick to direct use of the i2c stuff
> like here?
> 
Sorry, didn't get entirely? From what I understood, you meant we could
drop regmap from this driver entirely and use direct I2C APIs. I believe
that would be too much, coz of the frequency we perform operations and
regmap is easier and clean imo.
Also, we could have used regmap_raw_write() API by specifying register
0x0 as address and rest of the 3 bytes as data. regmap will perform raw
write of these byte stream over the I2C the same way sensor expects. But
the problem with that approach is we are not using it as per the API
convention. let me know your thoughts? Is it a good option, it'll look
like this:
regmap_raw_write(data->map, data->wr_regs[0], &data->wr_regs[1],
ARRAY_SIZE(data->wr_regs) - 1);
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "failed to write registers. error %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tlv493d_set_operating_mode(struct tlv493d_data *data, u8 mode)
> > +{
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	u8 *reg_mode1 = &data->wr_regs[TLV493D_WR_REG_MODE1];
> > +	u8 *reg_mode2 = &data->wr_regs[TLV493D_WR_REG_MODE2];
> > +
> > +	switch (mode) {
> > +	case TLV493D_OP_MODE_POWERDOWN:
> > +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> 
> As already mentioned by others, use FIELD_PREP etc.
> 
Ack.
> > +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> > +		break;
> > +
> > +	case TLV493D_OP_MODE_FAST:
> > +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> > +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> > +		break;
> > +
> > +	case TLV493D_OP_MODE_LOWPOWER:
> > +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> > +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> > +		SET_BIT(*reg_mode2, TLV493D_MODE2_LP_PERIOD);
> > +		break;
> > +
> > +	case TLV493D_OP_MODE_ULTRA_LOWPOWER:
> > +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> > +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> > +		CLR_BIT(*reg_mode2, TLV493D_MODE2_LP_PERIOD);
> > +		break;
> > +
> > +	case TLV493D_OP_MODE_MASTERCONTROLLED:
> > +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> > +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> > +		break;
> > +
> > +	default:
> > +		dev_err(data->dev, "invalid mode configuration\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return tlv493d_write_all_regs(data);
> > +}
> > +
> > +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s16 *y,
> > +				s16 *z, s16 *t)
> > +{
> > +	u8 buff[7] = {0};
> The 0 isn't needed and did odd things in older compilers (though only ones
> we've since dropped support form.
> 	= { };
> 
> is fine.
> 
Okay.
> > +	int err, ret;
> > +	struct tlv493d_mode *mode;
> > +
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = pm_runtime_resume_and_get(data->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mode = &modes[data->mode];
> > +
> > +	/*
> > +	 * Poll until data is valid,
> > +	 * For a valid data TLV493D_VAL_CHANNEL bit of TLV493D_RD_REG_TEMP should be set to 0.
> > +	 * The sampling time depends on the sensor mode. poll 3x the time of the sampling time.
> > +	 */
> > +	ret = read_poll_timeout(regmap_bulk_read, err, err ||
> > +			FIELD_GET(TLV493D_VAL_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,
> > +			mode->sleep_us, (3 * mode->sleep_us), false, data->map, TLV493D_RD_REG_BX,
> > +			buff, ARRAY_SIZE(buff));
> > +	if (ret) {
> > +		dev_err(data->dev, "read poll timeout, error:%d", ret);
> > +		goto out;
> > +	}
> > +	if (err) {
> > +		dev_err(data->dev, "read data failed, error:%d\n", ret);
> > +		ret = err;
> > +		goto out;
> > +	}
> > +
> > +	*x = TLV493D_DATA_X_GET(buff);
> > +	*y = TLV493D_DATA_Y_GET(buff);
> > +	*z = TLV493D_DATA_Z_GET(buff);
> > +	*t = TLV493D_DATA_TEMP_GET(buff);
> > +
> > +out:
> > +	pm_runtime_mark_last_busy(data->dev);
> 
> As below  This should get simpler.
> 
> Not directly relevant to this patch:
> 
> If this cycle is quiet I plan to propose some cleanup.h based handling for runtime
> pm as it's annoying how often we need a goto for it.  The new ACQUIRE()  / ACQUIRE_ERR()
> should work for this. 
> 
Does this need any modifications with current codebase?
> 
> > +	pm_runtime_put_autosuspend(data->dev);
> > +	return ret;
> > +}
> > +
> > +static int tlv493d_init(struct tlv493d_data *data)
> > +{
> > +	int ret;
> > +	u8 buff[TLV493D_RD_REG_MAX];
> > +
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The sensor initialization requires below steps to be followed,
> > +	 * 1. Power-up sensor.
> > +	 * 2. Read and store read-registers map (0x0-0x9).
> > +	 * 3. Copy values from read reserved registers to write reserved fields (0x0-0x3).
> > +	 * 4. Set operating mode.
> > +	 * 5. Write to all registers.
> > +	 */
> > +	ret = regmap_bulk_read(data->map, TLV493D_RD_REG_BX, buff, ARRAY_SIZE(buff));
> > +	if (ret) {
> > +		dev_err(data->dev, "bulk read failed, error %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	data->wr_regs[0] = 0; /* Write register 0x0 is reserved. Does not require to be updated.*/
> > +	data->wr_regs[1] = buff[TLV493D_RD_REG_RES1] & TLV493D_RD_REG_RES1_WR_MASK;
> > +	data->wr_regs[2] = buff[TLV493D_RD_REG_RES2] & TLV493D_RD_REG_RES2_WR_MASK;
> > +	data->wr_regs[3] = buff[TLV493D_RD_REG_RES3] & TLV493D_RD_REG_RES3_WR_MASK;
> > +
> > +	ret = tlv493d_set_operating_mode(data, data->mode);
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "failed to set operating mode\n");
> > +		return ret;
> > +	}
> > +
> > +	return ret;
> return 0?
Its the same though. ret from tlv493d_set_operating_mode is 0 on
success and -ve on failure.
> 
> > +}
> > +
> > +static int tlv493d_parse_dt(struct tlv493d_data *data)
> > +{
> > +	struct device_node *node;
> > +	u32 val = 0;
> > +	int ret;
> > +
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	node = data->dev->of_node;
> > +
> > +	/* Optional 'mode' property to set sensor operation mode */
> > +	ret = of_property_read_u32(node, "mode", &val);
> Use accessors from property.h not, the of specific ones.
> 
> This will go away anyway (see comments on dt-bindings from others) but..
> 
> > +	if (ret < 0 || val >= TLV493D_OP_MODE_MAX) {
> > +		/* Fallback to default mode if property is missing or invalid */
> > +		data->mode = TLV493D_OP_MODE_MASTERCONTROLLED;
> If it's invalid error out so we know we have a bad DT for default
> a common pattern is.
> 
> 	data->mode = TLV493D_OP_MODE_MASTERCONTROLLED;
> 	device_property_read_u32(data->dev, "mode", &data->mode);
> 	if (data->mode >= TLV493D_OP_MODE_MAX)
> 		return dev_err_probe()...
> 
> 	
> 
> > +	} else {
> > +		data->mode = val;
> > +	}
> > +
> > +	/*
> > +	 * Read temperature offset (raw value at 25°C). If not specified,
> > +	 * default to 340.
> > +	 */
> > +	ret = of_property_read_u32(node, "temp-offset", &val);
> 
> As others have mentioned, this sort of calibration thing is normally a userspace
> problem unless it's coming from something wiring related?  E.g. external components.
> 
This whole tlv493d_parse_dt() will be dropped.
> > +	if (ret)
> > +		val = 340;
> > +	/*
> > +	 * The above is a raw offset; however, IIO expects a single effective offset.
> > +	 * Since final temperature includes an additional fixed 25°C (i.e. 25000 m°C),
> > +	 * we compute a combined offset using scale = 1100 (1.1 * 1000).
> > +	 */
> > +	data->temp_offset = -val + (s32)div_u64(25000, 1100);
> > +
> > +	return 0;
> > +}
> > +
> > +static int tlv493d_read_raw(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> 
> wrap to keep this under 80.  Doesn't look like it will hurt readability.
> 
Ack. Is 80 standard for whole kernel or iio only?
> > +		int *val, int *val2, long mask)
> > +{
> > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > +	s16 x, y, z, t;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> 
> Not used.
Ack.
> 
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
> > +		if (ret) {
> > +			dev_err(data->dev, "failed to read sensor data\n");
> > +			return ret;
> > +		}
> > +		/* Return raw values for requested channel */
> > +		switch (chan->address) {
> > +		case AXIS_X:
> > +			*val = x;
> > +			return IIO_VAL_INT;
> > +		case AXIS_Y:
> > +			*val = y;
> > +			return IIO_VAL_INT;
> > +		case AXIS_Z:
> > +			*val = z;
> > +			return IIO_VAL_INT;
> > +		case TEMPERATURE:
> > +			*val = t;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_MAGN:
> > +			/*
> > +			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 µT)
> > +			 * Expressed as fractional: 98/10 = 9.8 µT.
> > +			 */
> > +			*val = 98;
> > +			*val2 = 10;
> > +			return IIO_VAL_FRACTIONAL;
> > +		case IIO_TEMP:
> > +			/*
> > +			 * Temperature scale: 1.1 °C per LSB, expressed as 1100 m°C
> > +			 * Returned as integer for IIO core to apply:
> > +			 * temp = (raw + offset) * scale
> > +			 */
> > +			*val = 1.1 * MILLI;
> Whilst a compiler should figure this out, maybe safer to just do 1100
> 
As acked already.
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		switch (chan->type) {
> > +		case IIO_TEMP:
> > +			/*
> > +			 * Temperature offset includes sensor-specific raw offset
> > +			 * plus compensation for +25°C bias in formula.
> > +			 * This value is precomputed during probe/init:
> > +			 * offset = -raw_offset + (25000 / scale)
> > +			 */
> > +			*val = data->temp_offset;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> 
> 
> > +static int tlv493d_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct tlv493d_data *data;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->dev = dev;
> > +	data->client = client;
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	ret = devm_mutex_init(dev, &data->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->map = devm_regmap_init_i2c(client, &tlv493d_regmap_config);
> > +	if (IS_ERR(data->map))
> > +		return dev_err_probe(dev, PTR_ERR(data->map), "failed to allocate register map\n");
> 
> Long line, break before the string.  For IIO we 'aim' for 80 chars
> but let that slip if there is a good readability reason.
> 
Got it.
> 
> > +
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> > +
> > +	ret = tlv493d_parse_dt(data);
> 
> Rename as parse_firmware() or similar after changing to property.h.
> For a case as simple as this there is no advantage in limiting the firmware
> handling to DT.
> 
The function itself will be dropped.
> 
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to parse device-tree\n");
> > +
> > +	ret = tlv493d_init(data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to initialized\n");
> > +
> > +	indio_dev->info = &tlv493d_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->name = client->name;
> > +	indio_dev->channels = tlv493d_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(tlv493d_channels);
> > +	indio_dev->available_scan_masks = tlv493d_scan_masks;
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +			iio_pollfunc_store_time, tlv493d_trigger_handler,
> > +			&tlv493d_setup_ops);
> 
> Align as per comments below.
> 
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
> > +
> > +	ret = pm_runtime_set_active(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = devm_pm_runtime_enable(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	pm_runtime_mark_last_busy(dev);
> 
> By the time this lands, a series to make pm_runtime_put_autosuspend()
> include a call to pm_runtime_mark_last_busy() should be upstream.
> I'll hopefully remember to drop this when applying or it'll get
> caught by a follow up series tidying up the ones that crossed with that
> series.
> 
Good to know.
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	ret =  devm_iio_device_register(dev, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "iio device register failed\n");
> > +
> > +	return 0;
> > +}
> 
> > +static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
> > +		tlv493d_runtime_suspend, tlv493d_runtime_resume, NULL);
> Align typically as
> static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops, tlv493d_runtime_suspend,
> 				 tlv493d_runtime_resume, NULL);
> 
> If you do have a very long line, perhaps due to a verbose parameter name
> and need to not align after the ( then use just one tab more than the line
> above, not 2.
> 
Ack.
> > +
> > +static const struct i2c_device_id tlv493d_id[] = {
> > +	{ "tlv493d" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, tlv493d_id);
> > +
> > +static const struct of_device_id tlv493d_of_match[] = {
> > +	{ .compatible = "infineon,tlv493d-a1b6", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, tlv493d_of_match);
> > +
> > +static struct i2c_driver tlv493d_driver = {
> > +	.driver = {
> > +		.name = "tlv493d",
> > +		.of_match_table = tlv493d_of_match,
> > +		.pm = pm_ptr(&tlv493d_pm_ops),
> > +	},
> > +	.probe = tlv493d_probe,
> > +	.id_table = tlv493d_id,
> > +};
> > +
> > +module_i2c_driver(tlv493d_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Infineon TLV493D Low-Power 3D Magnetic Sensor");
> > +MODULE_AUTHOR("Dixit Parmar <dixitparmar19@gmail.com>");
> > 
>

Thank you for such detailed review. Appriciate it,
Dixit

