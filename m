Return-Path: <linux-iio+bounces-22121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D8B146D2
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 05:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CC87ADFC5
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 03:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6921E0BB;
	Tue, 29 Jul 2025 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXeAqdHo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CC21D3F0;
	Tue, 29 Jul 2025 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759573; cv=none; b=igR09afgIf7SkG0Vedv02IaNMCA2LsAvwAIJHaavvbO24Jb18pBJl2L1c3lTDp/zdoB0ZNUAXbX1eXdk6yAZWVHQ9jBRzySA+SpbcUdrR9hTRXqQOvnWQ5VxJqKu9PqqhCLcDjouD+4i+PWH1hCsU7Z04BUxjJceeSisUh+gz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759573; c=relaxed/simple;
	bh=FWp2RCuYNClRdyW/L3DeYd4iVb7SgekzHHKLTkVEoYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slC2Ucte1d3lF4df4Ir+1mIyof6Wub2NS78bqCQSfLhEl8ELRI+O8isbznzoecuu7yKPhFcENT9QpfFTqIDMzOZU9WbAUQi84ps66aBBKBpqSyV5rueeho0ycotBNAx4dD19TeVwwJWmWLkKnnLYq0Ps0LVdyMZM2lqcKIkpXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXeAqdHo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b350704f506so478097a12.0;
        Mon, 28 Jul 2025 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753759571; x=1754364371; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fJhDGMY3+SHgK+DsqFkqtVChty3WL6CRvwpNWxOavcU=;
        b=AXeAqdHoMlXXEvPdboKSoMKNYO6wkxSwUV+2JXUsIG6SdEK9t0NtXGrMo/mU0AI7Qz
         6RG8uHkXvIMjJl9tHMCBraAH9VV3zHTTb/9dsMbRW5anp0JOMWcIQttiWd+NNeMJ1V/Z
         OIYod7fXQLq945cxIlyV+JW6BiAi5YWjmt7XwYjFXdbsNPa3UxhXK1WhUe+FxVmZ844A
         r+4JdE9OBHh4PpP63gA4z0BXuu9BBX+jsM7XBjaSxvl5u2JhLYqxvVU+JLJcwKhBKmEQ
         K2T/IYQFxtI4FmaBOu8a/uT2NDcgzyOX3FNSgLJn3t0QYGx4BP5LQ/+tUpN0EepRV68h
         k6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753759571; x=1754364371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJhDGMY3+SHgK+DsqFkqtVChty3WL6CRvwpNWxOavcU=;
        b=atrbwrsCHFIk+qlGXdewtXpjoPg21zMSxgPvootIjYIEPL0KdlMgkM091njZTfbsP2
         ZSzEJ3i7hTK0otM74FXhZDXYGMmj9jXE4QwlbafROpLY54AoWmOFgXKDF3LvyS0yzrye
         kqj4KcsnqhWk1NISeecHXPP4qQxEDVFpz93zSTZ+MPnsnLaot28k3K9AQ6YcWzz5qoNR
         E3gdwXvS1yAoh1K/bhIJcPjO0/HmSNRjGVO1TkyJj4B1qtXXSHAe/P6MRRGo/Bk0uF6R
         Uf8w29epKv64cbYAS/KbYHAI6swK5ylgrTrfZpG+XgPuCdS+xL3Z3L4mGMDYyplZVv0J
         vRCA==
X-Forwarded-Encrypted: i=1; AJvYcCU0mPTvz0LLYjF/0YRFWtPS0NWiw9C5ZJbHCr5KxyPZBaw1qPjXU2PamIuBve6/6HYiEQNUbJaoJPwj@vger.kernel.org, AJvYcCWWvfxWmpzyNmlkbF5n5rcWsdZZGoM0BtmiLcVyFA5HK6bddZVbMztfkBh46aduKAkV+eC3g1PFHCjA@vger.kernel.org, AJvYcCWXCke2ifwk6NQo1xjRZ2nFpZ381FJDt/LbxPDYz7ab9LW0+WJbuS8S/KIFyzc3T7pwyjE+8KesHlvy42l+@vger.kernel.org
X-Gm-Message-State: AOJu0YzVceGWPZw9iJtCu7pkXyLsEK10ntqz6ORpYzXBy/8GbXXdS3CJ
	sGMm+Go+2/xUuvp+ZqsHpQJUmfetndoxjr7NKDvoToi7O5jeNgqx4rEI
X-Gm-Gg: ASbGncsxwF9xd9SrthtNMNhBppp4WIgT+DehTdW0WfyemG9AMHfJINwhX1CCsgDk+G3
	t6PkA8htDmgR1V3imPe9l2ph0RteoC9CAaev+UB1FH4SgV+WKBhdk1GY3qi+HYReswVJ63znbyv
	LtM8SHD8AQQij2kpK02HvWza5ThbkcwcRnSCf9rvzhE7dM46u6laAmWPJ53aZ2x6CcimUf0RPlD
	08VFyQqHLcTL7ssuLItN0QXjErnh70/l1nKLvYOH5G9cCCEiEbLLcTANh2aXDtjiSZDF4Rkixsy
	l9Rz9zoiq7Shi5gx2ecRllFv/DnqGpFj210Vz47jmor1Tti8wEjwluG4JqJXZMbQZgXCzT6mf1R
	khYEPCHV6HfZgDPseDoHlJg==
X-Google-Smtp-Source: AGHT+IGPtt8vz8+sB4B0sjlHkFl/f9zuH3Bem/2i8GmRwffEhpiaTTu29z3USetDrG+I326nzRO+cA==
X-Received: by 2002:a17:902:f64f:b0:234:1e11:95a3 with SMTP id d9443c01a7336-24063d61ddamr27674815ad.13.1753759570583;
        Mon, 28 Jul 2025 20:26:10 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:9464:4ee2:7e58:1508:18c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401f3ef888sm35464435ad.106.2025.07.28.20.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 20:26:09 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:56:00 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <aIg_SClXq0pO69iH@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
 <141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com>

On Sat, Jul 26, 2025 at 03:44:03PM -0500, David Lechner wrote:
> On 7/26/25 4:37 AM, Dixit Parmar wrote:
> > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
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
> > [1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf
> > 
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
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
> We try to keep these in alphabetical order.
>
Ofcourse, I considered TI_TMAG5273 as whole. Will move it above that.
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
> > +#define TLV493D_VAL_MAG_X_AXIS_MSB	GENMASK(7, 0)
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
> I think most readers of the code would fare better without these macros.
> 
> And it could simplify things to make a
> 
> #define TLV493D_MODE1_MOD	GENMASK(1, 0)
> 
> and use FIELD_PREP() instead of 
> 
Ack.
> > +
> > +#define TLV493D_DATA_X_GET(b)	\
> > +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 | \
> > +			(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4), 11)
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
> 
> These are very generic names. Please add TLV493D_ prefix.
> 
Indeed.
> > +};
> > +
> > +enum tlv493d_op_mode {
> > +	TLV493D_OP_MODE_POWERDOWN = 0,
> > +	TLV493D_OP_MODE_FAST,
> > +	TLV493D_OP_MODE_LOWPOWER,
> > +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> > +	TLV493D_OP_MODE_MASTERCONTROLLED,
> > +	TLV493D_OP_MODE_MAX,
> > +};
> > +
> > +struct tlv493d_mode {
> > +	u8 m;
> > +	u32 sleep_us;
> > +};
> > +
> > +struct tlv493d_data {
> > +	struct device *dev;
> > +	struct i2c_client *client;
> > +	struct mutex lock;
> 
> Lock needs a comment describing what it is supposed to protect.
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
> 
> Let's add the tlv493d_ prefix to modes.
> 
Will rename is to tlv493d_modes_info.
> > +	{.m = TLV493D_OP_MODE_POWERDOWN, .sleep_us = 0 },
> > +	{.m = TLV493D_OP_MODE_FAST, .sleep_us = 305 },
> > +	{.m = TLV493D_OP_MODE_LOWPOWER, .sleep_us = 10 * USEC_PER_MSEC },
> > +	{.m = TLV493D_OP_MODE_ULTRA_LOWPOWER, .sleep_us = 100 * USEC_PER_MSEC },
> > +	{.m = TLV493D_OP_MODE_MASTERCONTROLLED, .sleep_us = 305 },
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
> 
> Why not regmap_read_poll_timeout()?
> 
We want to read all 7 register in single operation to make sure that we
read it from the same measurement cycle. out of those 7 registers
TLV493d_RD_REG_TEMP has a bit field TLV493D_VAL_CHANNEL which stats if
the measurement cycle was complete or not. Per my understanding
regmap_read_poll_timeout() does not support bulk/multi register read so,
read_poll_timeout is used with regmap_bulk_read().
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
> > +	if (ret < 0 || val >= TLV493D_OP_MODE_MAX) {
> > +		/* Fallback to default mode if property is missing or invalid */
> > +		data->mode = TLV493D_OP_MODE_MASTERCONTROLLED;
> > +	} else {
> > +		data->mode = val;
> > +	}
> 
> As mentioned in the dt-bindings review, we already control this paritially
> with the power management runtime, so having devicetree specify a power mode
> doesn't really make sense.
> 
> In fact, since the mode determines the sample rate, if we ever implemented
> handling the interrupt pin, it would make sense for the sampling_freqency
> to control mode rather than hard-coding it.
> 
Agreed, will drop the mode and temp-offset setting in DT.
> > +
> > +	/*
> > +	 * Read temperature offset (raw value at 25°C). If not specified,
> > +	 * default to 340.
> > +	 */
> > +	ret = of_property_read_u32(node, "temp-offset", &val);
> > +	if (ret)
> > +		val = 340;
> 
> As mentioned in the dt-bindings review, this sounds like a calibbias rather
> than something that should be hard-coded in a devicetree.
> 
Agreed, will drop it.
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
> > +		int *val, int *val2, long mask)
> > +{
> > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > +	s16 x, y, z, t;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> 
> Processed is not the same as raw. Just drop it.
> 
Ack.
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
> > +		if (ret) {
> > +			dev_err(data->dev, "failed to read sensor data\n");
> 
> The error gets returned to usespace, so we don't need to log errors here.
> 
Ack.
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
> 
> We use SI units, so this needs to be gauss, not tesela.
> 
Sure, Is there any documentation/reference this details are mentioned?
> > +			return IIO_VAL_FRACTIONAL;
> > +		case IIO_TEMP:
> > +			/*
> > +			 * Temperature scale: 1.1 °C per LSB, expressed as 1100 m°C
> > +			 * Returned as integer for IIO core to apply:
> > +			 * temp = (raw + offset) * scale
> > +			 */
> > +			*val = 1.1 * MILLI;
> 
> I guess this works since it is a constant, but we usually don't
> have floating point in the kernel. I would probably just write this
> as 1100. It doesn't have too many zeros that we can't easily see
> how many there are.
> 
Ack. Will make it 1100.
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
> 
> There is no break; so this is unreachable and can be removed.
> 
Ack.
> > +}
> > +
> > +static irqreturn_t tlv493d_trigger_handler(int irq, void *ptr)
> > +{
> > +	struct iio_poll_func *pf = ptr;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > +
> > +	struct {
> > +		s16 channels[3];
> > +		s16 temperature;
> > +		aligned_s64 timestamp;
> > +	} scan;
> 
> 	} scan = { };
> 
> Technically not needed here since we assign all values and there shuold
> not be any holes in the struct, but good to have for when others copy this
> and modify it in a new driver.
> 
Okay.
> > +
> > +	s16 x, y, z, t;
> > +	int ret;
> > +
> > +	ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read sensor data\n");
> > +		goto trig_out;
> > +	}
> > +
> > +	scan.channels[0] = x;
> > +	scan.channels[1] = y;
> > +	scan.channels[2] = z;
> > +	scan.temperature = t;
> 
> Why not just pass these directly to tlv493d_get_measurements() and avoid this
> assigment and extra local variables?
> 
Bcoz the same measurement function is used from raw_read where the
individiual channels values are needed. hence kept as independed args
based for each channel.
> > +
> > +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
> > +
> > +trig_out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +#define TLV493D_AXIS_CHANNEL(axis, index)			\
> > +	{							\
> > +		.type = IIO_MAGN,				\
> > +		.modified = 1,					\
> > +		.channel2 = IIO_MOD_##axis,			\
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> > +				BIT(IIO_CHAN_INFO_SCALE),	\
> > +		.address = index,				\
> 
> Setting address the same as scan_index is redundant. We can just
> use scan_index everywhere.
> 
we can, I hope this does not break anything on userspace iiolib's side.
> > +		.scan_index = index,				\
> > +		.scan_type = {					\
> > +			.sign = 's',				\
> > +			.realbits = 12,				\
> > +			.storagebits = 16,			\
> > +			.endianness = IIO_CPU,			\
> > +		},						\
> > +	}
> > +
> > +static const struct iio_chan_spec tlv493d_channels[] = {
> > +	TLV493D_AXIS_CHANNEL(X, AXIS_X),
> > +	TLV493D_AXIS_CHANNEL(Y, AXIS_Y),
> > +	TLV493D_AXIS_CHANNEL(Z, AXIS_Z),
> > +	{
> > +		.type = IIO_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				BIT(IIO_CHAN_INFO_SCALE) |
> > +				BIT(IIO_CHAN_INFO_OFFSET),
> > +		.address = TEMPERATURE,
> > +		.scan_index = TEMPERATURE,
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 12,
> > +			.storagebits = 16,
> > +			.endianness = IIO_CPU,
> > +		},
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(4),
> > +};
> > +
> > +static const struct regmap_range tlv493d_volatile_reg_ranges[] = {
> > +	regmap_reg_range(TLV493D_RD_REG_BX, TLV493D_RD_REG_RES3),
> > +};
> > +
> > +static const struct regmap_access_table tlv493d_volatile_regs = {
> > +	.yes_ranges = tlv493d_volatile_reg_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(tlv493d_volatile_reg_ranges),
> > +};
> 
> Would make sense to have these closer to tlv493d_regmap_config.
> 
Ack.
> > +
> > +static const struct iio_info tlv493d_info = {
> > +	.read_raw = tlv493d_read_raw,
> > +};
> > +
> > +static const struct iio_buffer_setup_ops tlv493d_setup_ops = {};
> 
> Just pass NULL if there are no ops.
> 
Ack.
> > +
> > +static const unsigned long tlv493d_scan_masks[] = { GENMASK(3, 0), 0 };
> > +
> > +static const struct regmap_config tlv493d_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = TLV493D_RD_REG_RES3,
> > +	.volatile_table = &tlv493d_volatile_regs,
> > +};
> > +
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
> 
> There is not i2c_get_clientdata(), so I don't think we need this.
> 
Correct, will remove it.
> > +
> > +	ret = devm_mutex_init(dev, &data->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->map = devm_regmap_init_i2c(client, &tlv493d_regmap_config);
> > +	if (IS_ERR(data->map))
> > +		return dev_err_probe(dev, PTR_ERR(data->map), "failed to allocate register map\n");
> > +
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> > +
> > +	ret = tlv493d_parse_dt(data);
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
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	ret =  devm_iio_device_register(dev, indio_dev);
> 
> random extra space
> 
Ack.
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "iio device register failed\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int tlv493d_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > +
> > +	return tlv493d_set_operating_mode(data, TLV493D_OP_MODE_POWERDOWN);
> > +}
> > +
> > +static int tlv493d_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > +
> > +	return tlv493d_set_operating_mode(data, data->mode);
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
> > +		tlv493d_runtime_suspend, tlv493d_runtime_resume, NULL);
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
Thank you for the review,
Dixit

