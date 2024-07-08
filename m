Return-Path: <linux-iio+bounces-7440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9092A3CA
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 15:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52E5B20E4D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D04137C35;
	Mon,  8 Jul 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6hRnEnS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87D1171D;
	Mon,  8 Jul 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446002; cv=none; b=SEd72HocL2IF0yMrkWeZ7w4GtFuH68Io+5DT0AhbpMk3wcSVWysprCOl2h+WvIoDbJYG1BiAtCESaZP4Tg154H/j3YBpV/Ro/LRt3mHs/dHtHqkZvYsSooEeGy9F+6SZhMv5T/OpVsTp0ctGOKgFpiGcRSqZvP8fAETrPqd6zsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446002; c=relaxed/simple;
	bh=GtQ3ES9dM6tnHOMKDsx+I9bktE5ptx3fCniyNfd35EM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cQewEY+ARdpF+H2t5xkGYU8Cw8FrJxSM6+0wH+/GB1hY8WhV+ktA6Ac9aRk8j8FpKKH/SMko9Q5IK5gFKdjj7XttRPZoYLuun57PIncv53OUuNNWdULqFIWQnlm04H8JnZtuiL/bSQHdkCB0zMdKZWaOgoaQQao2eC28If0Ch0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6hRnEnS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee90dc1dc1so37924741fa.3;
        Mon, 08 Jul 2024 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445998; x=1721050798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eesy2pn3itcP1WMJLgHgMe6OQpUXtPho+emPCzI/UAQ=;
        b=D6hRnEnSa+TsycJiNvIFs2gUiXbjuoFfULLW7Hn4l9CQAe7PExX7ylKi+aaFWbzrd5
         kEGpT8I0yKpoKpGeJxcMLUkG/NjkvFFVGhNC9al9wohE8i42lD020l2YWkdS43aon3jz
         AYJlGg6GIxUplW5ZYm09qRV/SMqtz48LmrzWnH1wrr9rTy2ZOst2ntX3//Xa+76gUf2K
         QBvQ+Sc3VtgS2vJxyyEO+Si9lOAglJtbxb+dTgghIEGCBOz146+P5JTGxe5lEgMVbp+h
         2ZM2Kb9OnLpqg4Yv45LLiHYme2xtT40ccCqX9HZIbB0wS2r7BSlJvke5TxbXTjHp9HOn
         4S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445998; x=1721050798;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eesy2pn3itcP1WMJLgHgMe6OQpUXtPho+emPCzI/UAQ=;
        b=ikAqNhXJOnSIpmklq61bMPcCaxDh4HzQqQzL+wJ3ZLCJQMqcH2wLQO19Clm/KJCLM7
         tT2Rwr9BaN+NZAjTSEhqW96igAjD3oBd9CbBziY8lEoASIMlTlmxu7fXcC7vQsEPLEyA
         VLmV3FzdP5Mu6EN8ukMg3UntmBfVMFk5bJGGsT7GcPC9mBXCxA6TRgXZ02vXWKkEg+so
         MASZjBkwp19STLxzNZoRtYVc38i5g8Arbc9xdYQjHkAIuWwhlnVn7VePG54ZhFFDT7GW
         SBQ0aW9tKkh/jXOmHzJ+W3UA8WI6yCYjHkvcuFtNfDvqtlAu+PNm2bsI1Q+Rcm7Ex9rY
         O9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIt9oqptMOyX54J7bNHV5w46z++h3AjO2BlLscnR8U9BzO+e5m/l3Ll+oPXP/kRDP4xHgeP4l9S2qDg2m7VeoUMLQydQLIcJZjW2ypgIN3moA29PAZVoj0k+9odBBCJTtL6Uq8GZilr/ojSqV0Jh4nZy4iJeVqw43HcyCAVXqCgZS1gg==
X-Gm-Message-State: AOJu0YwCLZy88gA3UieB+hSCyrPeVMg5Hb+zBfz79kcQOxp5VnLYOaAG
	FnJQw9X4rr+MPdmmlPLq36uvU6XPskM/sq1hWeEL66Rn1R9pKvfh
X-Google-Smtp-Source: AGHT+IFleR+qG5VXdGG7tlCzE5DvpbBFSkgR0u6McYQ15nHs6qMOvBecwfkk6vaqC7NMQ5BNx1tBpg==
X-Received: by 2002:a2e:be0f:0:b0:2ec:5699:5e6 with SMTP id 38308e7fff4ca-2ee8ed9fc91mr99444291fa.26.1720445997123;
        Mon, 08 Jul 2024 06:39:57 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42666680fa5sm59059845e9.22.2024.07.08.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:39:56 -0700 (PDT)
Date: Mon, 08 Jul 2024 15:39:54 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <668bec2a8b23a_6e037017@njaxe.notmuch>
In-Reply-To: <20240707160442.6bab64c9@jic23-huawei>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
 <20240707160442.6bab64c9@jic23-huawei>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
> On Thu, 04 Jul 2024 19:42:02 +0200
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
> 
> > Add support for Microchip PAC1921 Power/Current monitor.
> > 
> > Implemented features:
> > * capture of bus voltage, sense voltage, current and power measurements
> >   in free-run integration mode
> > * support for both raw and triggered buffer reading
> > * support for overflow events
> > * userspace controls for voltage and current gains, measurement
> >   resolution, integration samples and filters enabling/disabling
> > * simple power management support
> > 
> > Limitations:
> > * operation mode fixed to free-run integration
> > * measurement resolution and filters controls are applied to both VSENSE
> >   and VBUS measurements
> > 
> > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> 
> Hi Matteo,
> 
> A little too fast for sending a new version.  Result is Marius reviewed
> v1. I may replicate some of Marius' comments but do make sure you
> cover them all for v3.
> 
> One big question I have here, is do typical usecases for this device care
> much about reducing integration time? I'd have thought they were all
> relatively slow.  As such it may make sense to not support some
> of the modes that need to lower integration time (this is a common thing
> to decide to skip in the interests of maintainability and user interface
> complexity reduction).
> 
> Looks reasonably speedy to me, unless very high numbers of samples
> are used.  So that control makes sense to expose, perhaps not
> the resolution one.
> 
> Note that custom ABI is almost always a bad idea.  We enable it for the
> cases where there is no other choice, but reality is those cases then
> all need custom userspace software, so the controls are much less likely
> to actually used :(
> 
> 
> Jonathan
>

Hi Jonathan,

Thanks for your feedback, this clarified a lot.

I agree to keep the user interface simple, so I will remove the
controls that don't look necessary, based on your comments below. Anyway note
that some of the comments from Marius (from patch v1) are in contrasts with
this, suggesting to actually extend the interface, by exposing the
shunt-resistor and controls for the OUT analog pin.

I could add the shunt-resistor controls to allow calibration as Marius
suggested, but that's also a custom ABI, what are your thoughts on this?

Instead I would not introduce controls for the OUT pin, at least not for the
moment, since it would require some more considerations on the additional
custom controls and an implementation extension to support the pin-controlled
integration mode. Right now I defaulted the device operation mode to the
free-run power integration mode, which to me it looks like the more versatile
since in this way the device exposes all three measurements of voltage, current
and power, but the OUT pin setting is fixed to output the power value in a
fixed range.
I think that the OUT pin might not be used at all in many use cases so I would
leave the OUT pin setting as fixed for now and maybe extend it in the future
when more use cases arise. I am open to reconsider this though.

> 
> > ---
> >  .../ABI/testing/sysfs-bus-iio-adc-pac1921          |   45 +
> >  MAINTAINERS                                        |    7 +
> >  drivers/iio/adc/Kconfig                            |   10 +
> >  drivers/iio/adc/Makefile                           |    1 +
> >  drivers/iio/adc/pac1921.c                          | 1038 ++++++++++++++++++++
> >  5 files changed, 1101 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
> > new file mode 100644
> > index 000000000000..4a32e2d4207b
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
> Quite a bit of custom ABI in here.
> 
> Rule of thumb is that custom ABI is more or less pointless ABI for 99% of users
> because standard userspace won't use it.  So keep that in mind when defining it.
> 
> > @@ -0,0 +1,45 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/resolution_bits
> > +KernelVersion:	6.10
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		ADC measurement resolution. Can be either 11 bits or 14 bits
> > +		(default). The driver sets the same resolution for both VBUS and
> > +		VSENSE measurements even if the hardware could be configured to
> > +		measure VBUS and VSENSE with different resolutions.
> > +		This attribute affects the integration time: with 14 bits
> > +		resolution the integration time is increased by a factor of
> > +		1.9 (the driver considers a factor of 2). See Table 4-5 in
> > +		device datasheet for details.
> 
> Is the integration time ever high enough that it matters?
> People tend not to do power measurement 'quickly'. 
> 
> If we are doing it quickly then you'll probably want to be providing buffered
> support and that does allow you to 'read' the resolution for a part where
> it changes for some other reason.   I haven't yet understood this case.

I will remove this control and fix the resolution bits to 14 (highest value),
same as the HW default.

> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/resolution_bits_available
> > +KernelVersion:	6.10
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		List all possible ADC measurement resolutions: "11 14"
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/integration_samples
> > +KernelVersion:	6.10
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Number of samples taken during a full integration period. Can be
> > +		set to any power of 2 value from 1 (default) to 2048.
> > +		This attribute affects the integration time: higher the number
> > +		of samples, longer the integration time. See Table 4-5 in device
> > +		datasheet for details.
> 
> Sounds like oversampling_ratio which is standards ABI. So use that or explain
> why you can't here.

I am not sure that this is an oversampling ratio but correct me if I am wrong:
generally by increasing the oversampling you would have additional samples in a
fixed time period, while in this case by increasing the number of samples you
would still have the same number of samples in a fixed time period, but you
would have a longer integration period. So maybe the comment is not very
clear since this parameter actually means "the number of samples required to
complete the integration period".

Initially I thought to let the user edit this by writing the integration_time
control (which is currently read-only), but since the integration period
depends also on the resolution and whether filters are enabled or not, it would
have introduced some confusion: what parameter is being changed upon
integretion_time write? Maybe after removing resolution and filter controls
there would be no such confusion anymore.

> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/integration_samples_available
> > +KernelVersion:	6.10
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		List all possible numbers of integration samples:
> > +		"1 2 4 8 16 32 64 128 256 512 1024 2048"
> > +
> > +What:		/sys/bus/iio/devices/iio:devices/filters_en
> > +KernelVersion:	6.10
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Attribute to enable/disable ADC post filters. Enabled by
> > +		default.
> > +		This attribute affects the integration time: with filters
> > +		enabled the integration time is increased by 50%. See Table 4-5
> > +		in device datasheet for details.
> 
> Do we have any idea what this filter is? Datasheet seems very vague indeed and from
> a control point of view that makes this largely useless. How does userspace know
> whether to turn it on?
> 
> We have an existing filter ABI but with so little information no way to fit this in.
> Gut feeling, leave it on all the time and drop the control interface.

I will remove this control and leave it on all the time as the HW default.

> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index f60fe85a30d5..b56e494da970 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -991,6 +991,16 @@ config NPCM_ADC
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called npcm_adc.
> >  
> > +config PAC1921
> > +	tristate "Microchip Technology PAC1921 driver"
> > +	depends on I2C
> 
> Needs to ensure REGMAP_I2C as well I think.  Check similar cases.

Yes, I missed it. I think I also need to ensure IIO_BUFFER and
IIO_TRIGGERED_BUFFER.

> > +	help
> > +	  Say yes here to build support for Microchip Technology's PAC1921
> > +	  High-Side Power/Current Monitor with Analog Output.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called pac1921.
> > +
> >  config PAC1934
> 
> > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> > new file mode 100644
> > index 000000000000..879753466093
> > --- /dev/null
> > +++ b/drivers/iio/adc/pac1921.c
> > @@ -0,0 +1,1038 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * IIO driver for PAC1921 High-Side Power/Current Monitor
> > + *
> > + * Copyright (C) 2024 Matteo Martelli <matteomartelli3@gmail.com>
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/regmap.h>
> > +
> > +/* pac1921 registers */
> > +#define PAC1921_REG_GAIN_CFG		0x00
> > +#define PAC1921_REG_INT_CFG		0x01
> > +#define PAC1921_REG_CONTROL		0x02
> > +#define PAC1921_REG_VBUS		0x10
> > +#define PAC1921_REG_VSENSE		0x12
> > +#define PAC1921_REG_OVERFLOW_STS	0x1C
> > +#define PAC1921_REG_VPOWER		0x1D
> > +
> > +/* pac1921 gain configuration bits */
> > +#define PAC1921_GAIN_I_RES		BIT(7)
> > +#define PAC1921_GAIN_V_RES		BIT(6)
> > +#define PAC1921_GAIN_DI_GAIN_SHIFT	3
> > +#define PAC1921_GAIN_DI_GAIN_MASK	GENMASK(5, PAC1921_GAIN_DI_GAIN_SHIFT)
> > +#define PAC1921_GAIN_DI_GAIN_MAX	7
> > +#define PAC1921_GAIN_DV_GAIN_SHIFT	0
> > +#define PAC1921_GAIN_DV_GAIN_MASK	GENMASK(2, PAC1921_GAIN_DV_GAIN_SHIFT)
> 
> Define only the MASKs not SHIFTs and use FIELD_GET(), FIELD_PREP() throughout.
> Gives more readable code in general as well as halving the number of defines.
> 
I was not aware of FIELD_GET() and FIELD_PREP() macros, thanks for pointing
them out. I will use them indeed.

> > +#define PAC1921_GAIN_DV_GAIN_MAX	5
> > +
> > +/* pac1921 integration configuration bits */
> > +#define PAC1921_INT_CFG_SMPL_SHIFT	4
> > +#define PAC1921_INT_CFG_SMPL_MASK	GENMASK(7, PAC1921_INT_CFG_SMPL_SHIFT)
> > +#define PAC1921_INT_CFG_SMPL_MAX	11
> > +#define PAC1921_INT_CFG_VSFEN		BIT(3)
> > +#define PAC1921_INT_CFG_VBFEN		BIT(2)
> > +#define PAC1921_INT_CFG_RIOV		BIT(1)
> > +#define PAC1921_INT_CFG_INTEN		BIT(0)
> > +
> > +/* pac1921 control bits */
> > +#define PAC1921_CONTROL_MXSL_SHIFT	6
> > +enum pac1921_mxsl {
> > +	PAC1921_MXSL_VPOWER_PIN = 0,
> > +	PAC1921_MXSL_VSENSE_FREE_RUN = 1,
> > +	PAC1921_MXSL_VBUS_FREE_RUN = 2,
> > +	PAC1921_MXSL_VPOWER_FREE_RUN = 3,
> > +};
> > +#define PAC1921_CONTROL_SLEEP		BIT(2)
> > +
> > +/* pac1921 overflow status bits */
> > +#define PAC1921_OVERFLOW_VSOV		BIT(2)
> > +#define PAC1921_OVERFLOW_VBOV		BIT(1)
> > +#define PAC1921_OVERFLOW_VPOV		BIT(0)
> > +
> > +/* pac1921 constants */
> > +#define PAC1921_MAX_VSENSE_MV		100
> > +#define PAC1921_MAX_VBUS_V		32
> > +#define PAC1921_RES_RESOLUTION		1023 /* Result registers resolution */
> > +
> > +/* pac1921 defaults */
> > +#define PAC1921_DEFAULT_DV_GAIN		0 /* 2^(value): 1x gain */
> > +#define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain */
> > +#define PAC1921_DEFAULT_HIGH_RES	true /* 14-bit measurement resolution */
> > +#define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample */
> > +#define PAC1921_DEFAULT_FILTERS_ENABLED true
> > +
> > +/* pac1921 tables to create iio available parameters */
> > +static const unsigned int pac1921_di_gains[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> > +static const unsigned int pac1921_dv_gains[] = { 1, 2, 4, 8, 16, 32 };
> > +enum pac1921_meas_resolution_idx {
> > +	PAC1921_MEAS_RESOLUTION_IDX_LOW = 0,
> > +	PAC1921_MEAS_RESOLUTION_IDX_HIGH,
> > +};
> > +static const char *const pac1921_meas_resolutions[] = { "11", "14" };
> > +static const char *const pac1921_integr_num_samples[] = {
> > +	"1",  "2",   "4",   "8",   "16",   "32",
> > +	"64", "128", "256", "512", "1024", "2048"
> > +};
> > +
> > +/* pac1921 regmap configuration */
> > +static const struct regmap_range pac1921_regmap_wr_ranges[] = {
> > +	regmap_reg_range(PAC1921_REG_GAIN_CFG, PAC1921_REG_CONTROL),
> > +};
> 
> Trivial but I'd like a blank line here.
> 
Ok.

> > +static const struct regmap_access_table pac1921_regmap_wr_table = {
> > +	.yes_ranges = pac1921_regmap_wr_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(pac1921_regmap_wr_ranges),
> > +};
> 
> here
> 
Ok.

> > +static const struct regmap_range pac1921_regmap_rd_ranges[] = {
> > +	regmap_reg_range(PAC1921_REG_GAIN_CFG, PAC1921_REG_CONTROL),
> > +	regmap_reg_range(PAC1921_REG_VBUS, PAC1921_REG_VPOWER + 1),
> > +};
> 
> here
>
Ok.

> > +static const struct regmap_access_table pac1921_regmap_rd_table = {
> > +	.yes_ranges = pac1921_regmap_rd_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(pac1921_regmap_rd_ranges),
> > +};
> 
> and here as my eyes stuggle a bit with parsing this without the
> separations. Similar applies above.
> 
Ok.

> > +static const struct regmap_config pac1921_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.rd_table = &pac1921_regmap_rd_table,
> > +	.wr_table = &pac1921_regmap_wr_table,
> > +};
> 
> > +
> > +/* Check if overflow occurred and if so, push the corresponding events.
> 
> As mentioned below, without controls I don't think userspace has any way to know
> these are coming.   It is useful even for overflow events to provide
> a) A way to mask them off.
> b) The threshold values.  So that userspace can see that they are overflow events.
>    These will be readonly of course.
> 
I see your point, I will add controls. About thresholds, should they be related
to raw values or to scaled values? In the first case they would always be
fixed to 1023 being the measurement resolution, regardless of the selected
gains. In the latter case they would depend on the current gains and I guess
that they would be in the same unit of the scale (mV/mA/mW).

> > + *
> > + * Must be called with lock held.
> > + */
> > +static int pac1921_check_push_overflow(struct iio_dev *indio_dev, s64 timestamp)
> > +{
> > +	struct pac1921_priv *priv = iio_priv(indio_dev);
> > +	unsigned int flags;
> > +
> > +	int ret = regmap_read(priv->regmap, PAC1921_REG_OVERFLOW_STS, &flags);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (flags & PAC1921_OVERFLOW_VBOV &&
> > +	    !(priv->prev_ovf_flags & PAC1921_OVERFLOW_VBOV)) {
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(
> > +				       IIO_VOLTAGE, PAC1921_CHAN_VBUS,
> > +				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
> > +			       timestamp);
> > +	}
> > +	if (flags & PAC1921_OVERFLOW_VSOV &&
> > +	    !(priv->prev_ovf_flags & PAC1921_OVERFLOW_VSOV)) {
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(
> > +				       IIO_VOLTAGE, PAC1921_CHAN_VSENSE,
> > +				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
> > +			       timestamp);
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(
> > +				       IIO_CURRENT, PAC1921_CHAN_CURRENT,
> > +				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
> > +			       timestamp);
> > +	}
> > +	if (flags & PAC1921_OVERFLOW_VPOV &&
> > +	    !(priv->prev_ovf_flags & PAC1921_OVERFLOW_VPOV)) {
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(
> > +				       IIO_POWER, PAC1921_CHAN_POWER,
> > +				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
> > +			       timestamp);
> > +	}
> > +
> > +	priv->prev_ovf_flags = (u8)flags;
> > +
> > +	return 0;
> > +}
> > +
> > +/* Read the value from a result register
> > + *
> > + * Result registers contain the most recent averaged values of Vbus, Vsense and
> > + * Vpower. Each value is 10 bits wide and spread across two consecutive 8 bit
> > + * registers, with 6 bit LSB zero padding.
> > + */
> > +static int pac1921_read_res(struct pac1921_priv *priv, unsigned long reg,
> > +			    int *val)
> > +{
> > +	u8 val_buf[2];
> > +
> > +	int ret = regmap_bulk_read(priv->regmap, (unsigned int)reg, &val_buf,
> > +				   sizeof(val_buf));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val = (val_buf[0] << 8 | val_buf[1]) >> 6;
> 
> Looks like it could be done with the self documenting combination of
> 
> get_unaligned_be16() + FIELD_GET()
> 
> or use a __b16 for the read and the be16_to_cpu() approach.

Ok.

> > +
> > +	return 0;
> > +}
> > +
> > +static int pac1921_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct pac1921_priv *priv = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW: {
> > +		guard(mutex)(&priv->lock);
> 
> Given you grab this in all but error paths, I'd just grab it always
> and avoid need for the guard() and careful scoping in all these case blocks.
> 
Ok. So just a guard(mutex)(&priv->lock) call at the beginning of the function.

> > +
> > +		if (!pac1921_data_ready(priv))
> > +			return -EBUSY;
> > +
> > +		s64 ts = iio_get_time_ns(indio_dev);
> > +
> > +		int ret = pac1921_check_push_overflow(indio_dev, ts);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = pac1921_read_res(priv, chan->address, val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return IIO_VAL_INT;
> > +	}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->channel) {
> > +		case PAC1921_CHAN_VBUS: {
> > +			/* Vbus scale factor in mV:
> > +			 * max_vbus (mV) / vgain / resolution
> > +			 */
> > +			guard(mutex)(&priv->lock);
> > +
> > +			*val = PAC1921_MAX_VBUS_V * 1000;
> > +			*val2 = PAC1921_RES_RESOLUTION << (int)priv->dv_gain;
> > +
> > +			return IIO_VAL_FRACTIONAL;
> > +		}
> > +		case PAC1921_CHAN_VSENSE: {
> > +			/* Vsense voltage scale factor in mV:
> > +			 * max_vsense (mV) / igain / resolution
> > +			 */
> > +			guard(mutex)(&priv->lock);
> > +
> > +			*val = PAC1921_MAX_VSENSE_MV;
> > +			*val2 = PAC1921_RES_RESOLUTION << (int)priv->di_gain;
> > +
> > +			return IIO_VAL_FRACTIONAL;
> > +		}
> > +		case PAC1921_CHAN_CURRENT: {
> > +			/* Current scale factor in mA:
> > +			 * Vsense LSB (nV) / shunt (uOhm)
> > +			 */
> > +			guard(mutex)(&priv->lock);
> > +
> > +			*val = pac1921_vsense_lsb(priv->di_gain);
> > +			*val2 = (int)priv->rshunt;
> > +
> > +			return IIO_VAL_FRACTIONAL;
> > +		}
> > +		case PAC1921_CHAN_POWER: {
> > +			/* Power scale factor in mW:
> > +			 * Vsense LSB (nV) * max_vbus (V) / vgain / shunt (uOhm)
> > +			 */
> > +			guard(mutex)(&priv->lock);
> > +
> > +			*val = pac1921_vsense_lsb(priv->di_gain) *
> > +			       (PAC1921_MAX_VBUS_V >> (int)priv->dv_gain);
> > +			*val2 = (int)priv->rshunt;
> > +
> > +			return IIO_VAL_FRACTIONAL;
> > +		}
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > +		switch (chan->channel) {
> > +		case PAC1921_CHAN_VBUS: {
> > +			guard(mutex)(&priv->lock);
> > +			*val = 1 << (int)priv->dv_gain;
> > +			return IIO_VAL_INT;
> > +		}
> > +		case PAC1921_CHAN_VSENSE:
> > +		case PAC1921_CHAN_CURRENT: {
> > +			guard(mutex)(&priv->lock);
> > +			*val = 1 << (int)priv->di_gain;
> > +			return IIO_VAL_INT;
> > +		}
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +	case IIO_CHAN_INFO_INT_TIME: {
> > +		/* Integration time is read only: it depends on the number of
> > +		 * integration samples, measurement resolution and post filters
> > +		 */
> > +		*val2 = 1000000; /* From usecs to fractional secs */
> > +		guard(mutex)(&priv->lock);
> > +		*val = (int)priv->integr_period;
> > +		return IIO_VAL_FRACTIONAL;
> > +	}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> > +static int pac1921_update_cfg_reg(struct pac1921_priv *priv, unsigned int reg,
> > +				  unsigned int mask, unsigned int val)
> > +{
> > +	/* Enter READ state before configuration */
> > +	int ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > +				     PAC1921_INT_CFG_INTEN, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Update configuration value */
> > +	ret = regmap_update_bits(priv->regmap, reg, mask, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Re-enable integration and reset start time */
> > +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > +				 PAC1921_INT_CFG_INTEN, PAC1921_INT_CFG_INTEN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->integr_start_time = jiffies;
> 
> Add a comment for why this value.
>
Could you elaborate what's confusing here? The comment above states "reset
start time", maybe I should move it above the assignment of
priv->integr_start_time? Or it's the use of jiffies that it's confusing?

> > +	priv->first_integr_done = false;
> Will default to this anyway, so you could skip it unless you feel this is
> useful from documentation point of view.
>
That variable is being asserted after the first integration period is complete
to avoid spurious data (see pac1921_data_ready()). Here it is being reset after
a configuration change to invalidate previous data. So the assignment is
necessary.

> > +
> > +	return 0;
> > +}
> > +
> >
> 
> > +static int pac1921_set_int_num_samples(struct iio_dev *indio_dev,
> > +				       const struct iio_chan_spec *chan,
> > +				       unsigned int val)
> > +{
> > +	struct pac1921_priv *priv = iio_priv(indio_dev);
> > +
> > +	if (WARN_ON_ONCE(val > PAC1921_INT_CFG_SMPL_MAX))
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&priv->lock);
> > +
> > +	if (priv->n_samples == val)
> > +		return 0;
> > +
> > +	int ret = pac1921_update_cfg_reg(priv, PAC1921_REG_INT_CFG,
> > +					 PAC1921_INT_CFG_SMPL_MASK,
> > +					 val << PAC1921_INT_CFG_SMPL_SHIFT);
> 
> FIELD_PREP() etc.
> 
Ok.

> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->n_samples = (u8)val;
> > +
> > +	return pac1921_update_integr_period(priv);
> > +}
> > +
> > +static ssize_t pac1921_read_filters_enabled(struct iio_dev *indio_dev,
> > +					    uintptr_t private,
> > +					    const struct iio_chan_spec *chan,
> > +					    char *buf)
> > +{
> > +	struct pac1921_priv *priv = iio_priv(indio_dev);
> > +	bool enabled;
> > +
> > +	scoped_guard(mutex, &priv->lock) {
> > +		enabled = priv->filters_en;
> > +	}
> > +	return sysfs_emit(buf, "%d\n", enabled);
> 
> It's not a fast path hence holding the lock a little longer than necessary doesn't
> matter, so I'd do the simpler.
> 
> 	guard(mutex)(&priv->lock);
> 
> 	return sysfs_emit(buf, "%d\n", enabled);
>
Ok, but I think you mean:

	guard(mutex)(&priv->lock);
	return sysfs_emit(buf, "%d\n", priv->filters_en);
> > +}
> 
> 
> > +};
> > +static const struct iio_chan_spec_ext_info pac1921_ext_info[] = {
> > +	IIO_ENUM("resolution_bits", IIO_SHARED_BY_ALL,
> > +		 &pac1921_resolution_enum),
> > +	IIO_ENUM_AVAILABLE("resolution_bits", IIO_SHARED_BY_ALL,
> > +			   &pac1921_resolution_enum),
> > +	IIO_ENUM("integration_samples", IIO_SHARED_BY_ALL,
> > +		 &pac1921_int_num_samples_enum),
> > +	IIO_ENUM_AVAILABLE("integration_samples", IIO_SHARED_BY_ALL,
> > +			   &pac1921_int_num_samples_enum),
> > +	{
> > +		.name = "filters_en",
> > +		.read = pac1921_read_filters_enabled,
> > +		.write = pac1921_write_filters_enabled,
> > +		.shared = IIO_SHARED_BY_ALL,
> 
> I address these above with the documentation.
>
Answered above as well.

> > +	},
> > +	{},
> No need for a comma after a terminator like this as we will never add anything
> after it.
>
Ok.

> 
> > +};
> > +
> > +static const struct iio_event_spec pac1921_overflow_event[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> 
> No controls at all?  Without some form of enable userspace won't
> be able to tell these even exist.  If the device doesn't support
> disabling the interrupt, we can fallback to to irq_enable/disable()
> on the host end of the wire.  Ideally disable / enable at the device
> though.
I will add controls, please see my question about thresholds above.

> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec pac1921_channels[] = {
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> Marius pointed out that hardware gain is rarely the way to go.
> It is typically used when the gain is not directly affecting the
> thing being read.  E.g. light sensitivity of a time of flight sensor.
> 
> In order to maintain a simple userspace inteface we squash gain related
> stuff into the scale attributes.  There a user can easily see what
> flexibility is available to them and understand what affect it has on
> the values they will read back.
> 
I see, thanks for clarify this, I would do it via iio_info.read_avail() callback.

> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.channel = PAC1921_CHAN_VBUS,
> > +		.address = PAC1921_REG_VBUS,
> > +		.scan_index = PAC1921_CHAN_VBUS,
> > +		.scan_type = {
> > +			.sign = 'u',
> > +			.realbits = 10,
> > +			.storagebits = 16,
> > +			.endianness = IIO_CPU
> > +		},
> > +		.indexed = 1,
> > +		.event_spec = pac1921_overflow_event,
> > +		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
> > +		.ext_info = pac1921_ext_info,
> > +	},
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.channel = PAC1921_CHAN_VSENSE,
> > +		.address = PAC1921_REG_VSENSE,
> > +		.scan_index = PAC1921_CHAN_VSENSE,
> > +		.scan_type = {
> > +			.sign = 'u',
> > +			.realbits = 10,
> > +			.storagebits = 16,
> > +			.endianness = IIO_CPU
> > +		},
> > +		.indexed = 1,
> > +		.event_spec = pac1921_overflow_event,
> > +		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
> > +		.ext_info = pac1921_ext_info,
> > +	},
> > +	{
> > +		.type = IIO_CURRENT,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.channel = PAC1921_CHAN_CURRENT,
> > +		.address = PAC1921_REG_VSENSE,
> > +		.scan_index = PAC1921_CHAN_CURRENT,
> > +		.scan_type = {
> > +			.sign = 'u',
> > +			.realbits = 10,
> > +			.storagebits = 16,
> > +			.endianness = IIO_CPU
> > +		},
> > +		.event_spec = pac1921_overflow_event,
> > +		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
> > +		.ext_info = pac1921_ext_info,
> > +	},
> > +	{
> > +		.type = IIO_POWER,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.channel = PAC1921_CHAN_POWER,
> > +		.address = PAC1921_REG_VPOWER,
> > +		.scan_index = PAC1921_CHAN_POWER,
> > +		.scan_type = {
> > +			.sign = 'u',
> > +			.realbits = 10,
> > +			.storagebits = 16,
> > +			.endianness = IIO_CPU
> > +		},
> > +		.event_spec = pac1921_overflow_event,
> > +		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
> > +		.ext_info = pac1921_ext_info,
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(PAC1921_NUM_MEAS_CHANS),
> > +};
> > +
> > +static irqreturn_t pac1921_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *idev = pf->indio_dev;
> > +	struct pac1921_priv *priv = iio_priv(idev);
> > +
> > +	guard(mutex)(&priv->lock);
> > +
> > +	if (!pac1921_data_ready(priv))
> > +		goto done;
> > +
> > +	int ret = pac1921_check_push_overflow(idev, pf->timestamp);
> > +	if (ret)
> > +		goto done;
> > +
> > +	memset(&priv->scan, 0, sizeof(priv->scan));
> 
> We normally don't bother.  The worse that can happen here is that
> gaps can contain stale data.  We can't leak anything beyond that and
> such stale data should be harmless.
> 
Ok.

> > +
> > +	int bit, ch = 0;
> 
> Move definitions to the top of the function.
> Also, don't mix items that assign with ones that don't.  Just use separate
> lines.  Obviously fine here as only two of them, but when we get 10+ on
> a line and only some of them are set, it can be easy to miss bugs.
> 
Ok.

> 
> > +	for_each_set_bit(bit, idev->active_scan_mask, idev->masklength) {
> > +		int val;
> > +
> > +		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> > +		if (ret)
> > +			goto done;
> > +
> > +		priv->scan.chan[ch++] = (u16)val;
> 
> Why not make read_res take a u16 * and pass in the destination directly?
> 
pac1921_read_res() takes an int *val so that pac1921_read_raw() can pass its
int *val argument directly and to avoid an additional u16 var. However I don't
mind changing it if that looks more clear.

> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(idev, &priv->scan, pf->timestamp);
> > +
> > +done:
> > +	iio_trigger_notify_done(idev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int pac1921_init(struct pac1921_priv *priv)
> > +{
> > +	/* Time after power-up before ready to begin communications */
> > +	msleep(20);
> 
> I'd move that to the caller where we can see the power up happening.
> If this code gets reorganized in future, the delay may end up in the wrong
> place.
> 
Ok.

> > +
> > +	/* Enter READ state before configuration */
> > +	int ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > +				 PAC1921_INT_CFG_INTEN, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Configure gains and measurements resolution */
> > +	unsigned int val = priv->di_gain << PAC1921_GAIN_DI_GAIN_SHIFT |
> > +			   priv->dv_gain << PAC1921_GAIN_DV_GAIN_SHIFT;
> FIELD_PREP() throughout.
> 
Ok.

> > +	if (!priv->high_res)
> > +		val |= PAC1921_GAIN_I_RES | PAC1921_GAIN_V_RES;
> > +	ret = regmap_write(priv->regmap, PAC1921_REG_GAIN_CFG, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Configure integration:
> Comment style for multiline comments in IIO is
> 	/*
> 	 * Configure...
>
All right. I will change all multiline comments accordingly.

> > +	 * - num of integration samples, filters enabled/disabled
> > +	 * - set READ/INT pin override (RIOV) to control operation mode via
> > +	 *   register instead of pin
> > +	 */
> > +	val = priv->n_samples << PAC1921_INT_CFG_SMPL_SHIFT |
> > +	      PAC1921_INT_CFG_RIOV;
> > +	if (priv->filters_en)
> > +		val |= PAC1921_INT_CFG_VSFEN | PAC1921_INT_CFG_VBFEN;
> > +	ret = regmap_write(priv->regmap, PAC1921_REG_INT_CFG, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Init control register:
> > +	 * - VPower free run integration mode
> > +	 * - OUT pin full scale range: 3V (HW detault)
> > +	 * - no timeout, no sleep, no sleep override, no recalc (HW defaults)
> > +	 */
> > +	val = PAC1921_MXSL_VPOWER_FREE_RUN << PAC1921_CONTROL_MXSL_SHIFT;
> > +	ret = regmap_write(priv->regmap, PAC1921_REG_CONTROL, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable integration */
> > +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > +				 PAC1921_INT_CFG_INTEN, PAC1921_INT_CFG_INTEN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->first_integr_started = true;
> > +	priv->integr_start_time = jiffies;
> > +
> > +	return pac1921_update_integr_period(priv);
> > +}
> > +
> 
> > +
> > +static int pac1921_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct pac1921_priv *priv = iio_priv(indio_dev);
> > +
> > +	guard(mutex)(&priv->lock);
> > +
> > +	int ret = regulator_enable(priv->vdd);
>  
> As below. Local variable definitions at the top (old school c style).
> It obviously doesn't matter here, but it's what reviewers are used to for
> kernel code.
> 
> Please fix all cases for v3.
> 
Ok.

> > +	if (ret)
> > +		return ret;
> > +
> > +	return pac1921_init(priv);
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(pac1921_pm_ops, pac1921_suspend,
> > +				pac1921_resume);
> > +
> > +static void pac1921_regulator_disable(void *data)
> > +{
> > +	struct pac1921_priv *priv = data;
> > +
> > +	regulator_disable(priv->vdd);
> I'd pass in the regulator rather than the private structure.
> Then this can just be
> 
> 	regulator_disable(data);
> 
Ok.

> > +}
> > +
> > +static int pac1921_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct pac1921_priv *priv;
> > +
> > +	struct iio_dev *indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> 
> checkpatch probably warns about this.  Blank line here.
> 
Ok.

> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	priv = iio_priv(indio_dev);
> > +	priv->client = client;
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
> > +	if (IS_ERR(priv->regmap))
> > +		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > +			      "Cannot initialize register map\n");
> > +
> > +	mutex_init(&priv->lock);
> 
> Whilst mutex cleanup only matters in lock debugging cases and isn't really important
> for this sort of mutex, we now have devm_mutex_init() so good to use
> that just to avoid anyone having to think if we should cleanup the mutex or not.
> 
Ok.

> > +
> > +	priv->dv_gain = PAC1921_DEFAULT_DV_GAIN;
> > +	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
> > +	priv->high_res = PAC1921_DEFAULT_HIGH_RES;
> > +	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
> > +	priv->filters_en = PAC1921_DEFAULT_FILTERS_ENABLED;
> > +
> > +	int ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> local variable declarations still belong at the top unless there is a strong
> readson to do otherwise.
> 
The reason in general is just to keep the variable scope as tight as possible
to avoid unwanted use of such variable earlier than its wanted usage, and since
this is allowed with recent C versions, I thought it would be good to start
applying it. However, I understand this could make the code harder to read for
many people so I will stick to declare variables at the top.

> > +					   &priv->rshunt);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Cannot read shunt resistor property\n");
> > +	if (priv->rshunt == 0 || priv->rshunt > INT_MAX)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Invalid shunt resistor: %u\n",
> > +				     priv->rshunt);
> > +
> > +	priv->vdd = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(priv->vdd))
> > +		return dev_err_probe(dev, (int)PTR_ERR(priv->vdd),
> > +				     "Cannot get vdd regulator\n");
> > +
> > +	ret = regulator_enable(priv->vdd);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Cannot enable vdd regulator\n");
> > +
> > +	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable, priv);
> 
> Check ret.
> 
Indeed! Thanks for the catch.

> > +
> > +	ret = pac1921_init(priv);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Cannot initialize device\n");
> > +
> > +	priv->iio_info = pac1921_iio;
> > +
> > +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> We still mostly (exception is cleanup.h magic) stick to c style of
> local variable declarations before code.  I'd just move this to the top
> fo this fucntion.
> 
Ok.

> > +
> > +	indio_dev->name = id->name;
> > +	indio_dev->info = &priv->iio_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = pac1921_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(pac1921_channels);
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +					      &iio_pollfunc_store_time,
> > +					      &pac1921_trigger_handler, NULL);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Cannot setup IIO triggered buffer\n");
> > +
> > +	ret = devm_iio_device_register(dev, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Cannot register IIO device\n");
> > +
> > +	return 0;
> > +}
> 

Thanks again,
Matteo

