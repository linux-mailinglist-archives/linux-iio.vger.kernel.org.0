Return-Path: <linux-iio+bounces-23329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944CCB3851F
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F2618966BC
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98F1FDA9E;
	Wed, 27 Aug 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pu4nTgU2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562271B4F1F
	for <linux-iio@vger.kernel.org>; Wed, 27 Aug 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305393; cv=none; b=N0QPN7FSLvErJ/hKboxdFkD2X0kYQSxtIAJsRgYOGmtNIPhLjjq1m1f3FDABDZedkRD5POtsoE1vdRHBr4zCiE9s1ecZm5iP1piSInRHyqCcJCOrD0gXWIbe8A2y+pvfReo5NIKzklZf7N1Z94ULnwBpr+5fJevbswyL2En9+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305393; c=relaxed/simple;
	bh=D1QDjpSpG8ANWpRlN4u32UA1ccRrJaleyyx3toWBrPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5ToSPbvDM0tV8N8GYaav4Bkgr5gJBo8oWehv55BNPc9fmB+SpQIJzwL5NO0F87ym4ZJQ/p/gltK7aRBwYJv74SoX2Gy/BLRowNmMwpa3QSOiNzJjeQb39pgv/iBFlIOMskUtS5a/UljOqupdLFUn7krkOkjy17NrAVgpEoGWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pu4nTgU2; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74381fbd6f3so1597943a34.2
        for <linux-iio@vger.kernel.org>; Wed, 27 Aug 2025 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756305389; x=1756910189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIcwCx5R11D1SOysbea2Y8D+LCmOKRYDeadXbmbk7Ms=;
        b=Pu4nTgU2+arcqjeMBg2EUN0Dwnb8oi7SHNZhJA5BS91isOB+a1X0kGq6Xlf5o/Bif3
         XWZruUtsrpK/My2AEq6yrTta52DDSewCyhoAwWlAIXvqsEj+IngWJC7Cvs+FgNuPF0Og
         0rG+Cc1xmnQ5ihazwOHKZ2rjB3/m09be1z4DC8tgBrNb3zNNfR1tJ/NZIQ9JMpImD6/Z
         zlfB0/SIhyH5o+NBvMmt82en45C+Cyt+AwkitVtz4Vpp8qu53LQvOBgWv17SHa0rfwb/
         g9B8hFRI9axfE5ban/FTKsXJF04op1vfYdF79UCM6sM9oIl7yOyy3r5c0xx7IA86laSU
         leoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305389; x=1756910189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIcwCx5R11D1SOysbea2Y8D+LCmOKRYDeadXbmbk7Ms=;
        b=wHXxVFBJIGGtGJ3NVGN8GScESZN+DL5qKJXnbiyVwdZuEgkJt1MvkVoUe47Q2pMDIA
         IAjJC0B0QGHrP0tAJRAQekPAt7hTkXdbvhWv7CLFTbZ3+WNvlMnzZTf/pQd8UOUjdAql
         US+sGVkQMJzCLtWXw5mG1eczWruEqLaRvghkbKPQTedp9GTZrPYSz3HtYZUXPDvDG/55
         7O1gAyQK+5M7SmaSvYEgdZ2E6a9+4HzGYBd9sqadZrxH4Y1KGzTu9yJJTyWEInFmCm8A
         aAg8ZvCuNfsm78MLKHAHPt4oIvgZ8uLx/eVI5h/twOSvU1bcQjTiMr9SCoOYCyiZjpGb
         Ie2w==
X-Forwarded-Encrypted: i=1; AJvYcCXnYuJ+tzrWwr9MjHGwkD/J2OktjQrl61jKm0DTsOfbD26Vo2BP5ja1KFrN8bEt9X+KfNkSwe0o+4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoWpxdiJEyT8xn+D39JQ4YvivkYZobovQMd5vPbLhI1bI75rQo
	1zTWt0pSpl27bA4PTNrTzfNEj5u5R1m4eYV72bKkzTNsFva9l0xKWADFTdM25OMdvDk=
X-Gm-Gg: ASbGncuwtn0V/yfriCF769YviMMjTQG4DTFTVmJ3R7pjhL7/AyYzKmInzctSirtF5Fg
	IUKHanff8DeHrb8dT4UYQBcAlDk4t9GZzkpgyG30TXfDl3doyFh/KQ/H9/xNusR6VbZfhug6HR1
	JVu/OlwiROD6cnEXRI894VWx9fCppfJoEYjWllgl0zpKLAXBxTVnbIEHPBQPlxnQiLPnz9WMQbH
	uPAIuvT09HFr1rhQpV06qiaGnHdiE0zNycD+HdwOaku8ZIf3kmc61pZL6riuqn9Bsg4P2SpjRhp
	mRTaGyzqBYYC4IUo7J5UWV+QpmAfbh1mpZocL2Q/L1xlQISCq4uHudfSlluVhvM7ydrnYUvDOHd
	r5UGyud9WacUA4rKeJwdZQx1WD61OId04QKNudsFt25cl8bapIxTtaOFzFA8K6+aYRnF4o/V6ie
	E=
X-Google-Smtp-Source: AGHT+IEy9USJUgmT74KbzUpX7AGfuQCdPDsKJ+vYPYP0sOUu32HuCVhpNLkFfObD4xt8fYao3fRLuA==
X-Received: by 2002:a05:6830:2804:b0:73b:2617:87eb with SMTP id 46e09a7af769-74500ab1a68mr10488489a34.17.1756305389274;
        Wed, 27 Aug 2025 07:36:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f172:fde4:ff0c:d0ee? ([2600:8803:e7e4:1d00:f172:fde4:ff0c:d0ee])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e268e92sm3002933a34.1.2025.08.27.07.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 07:36:28 -0700 (PDT)
Message-ID: <5ff8c95c-9f22-47b6-90b3-65f910791229@baylibre.com>
Date: Wed, 27 Aug 2025 09:36:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor
To: Lakshay Piplani <lakshay.piplani@nxp.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org,
 viro@zeniv.linux.org.uk, peterz@infradead.org, jstephan@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 jonathan.cameron@huawei.com, akpm@linux-foundation.org, chao@kernel.org,
 jaegeuk@kernel.org
Cc: vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
References: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
 <20250827103105.2472328-2-lakshay.piplani@nxp.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250827103105.2472328-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 5:31 AM, Lakshay Piplani wrote:
> Add support for the NXP P3T175x (P3T1750/P3T1755) family of temperature
> sensor devices. These devices communicates via both I2C or I3C interfaces.
> 
> This driver belongs under IIO because:
>   The P3T1750/P3T1755 sensors require interrupt or IBI support to handle
>   threshold events, which the hwmon subsystem does not provide. In contrast,
>   the IIO subsystem offers robust event handling that matches the hardware
>   capabilities of these sensors. Therefore, this driver is better suited
>   under IIO.
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
> Changes in v2 (addressed review comments from Jonathan Cameron, Krzysztof Kozlowski, Andy Shevchenko):
>  - Added endian-safe handling for register read (__be16 conversion).
>  - Replaced manual bit masking with FIELD_GET bit extraction.
>  - General cleanups: dropped unused headers, reduced logging to dev_dbg.
>  - Dropped sysfs attributes for fault queue length and thermostat mode (comparator or interrupt).
>  - Added ABI doc: Documentation/ABI/testing/sysfs-bus-iio-temperature-p3t1755 describing
>    trigger_one_shot attribute.
>  - Updated Kconfig to allow building both I2C and I3C drivers simultaneously.
>  - I3C: switched to device_property_* from of_property_*.
>  - Added devm_add_action_or_reset() for IBI disable/free.
>  - Cleaned i3c_ibi_setup init.
>  - Channel info structures are now part-specific (p3t1755_channels_info, p3t1750_channels_info), no wildcards.
> 
>  .../testing/sysfs-bus-iio-temperature-p3t1755 |  11 +
>  drivers/iio/temperature/Kconfig               |   1 +
>  drivers/iio/temperature/p3t/Kconfig           |  28 ++
>  drivers/iio/temperature/p3t/Makefile          |   5 +
>  drivers/iio/temperature/p3t/p3t1755.h         |  56 +++
>  drivers/iio/temperature/p3t/p3t1755_core.c    | 456 ++++++++++++++++++
>  drivers/iio/temperature/p3t/p3t1755_i2c.c     |  91 ++++
>  drivers/iio/temperature/p3t/p3t1755_i3c.c     | 133 +++++
>  8 files changed, 781 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-p3t1755
>  create mode 100644 drivers/iio/temperature/p3t/Kconfig
>  create mode 100644 drivers/iio/temperature/p3t/Makefile
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755.h
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_core.c
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_i2c.c
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_i3c.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-p3t1755 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-p3t1755
> new file mode 100644
> index 000000000000..4ab79e814e6a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-p3t1755
> @@ -0,0 +1,11 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/trigger_one_shot

What is the use case for this attribute? Normally, a one-shot feature on a
chip like this would just be transparently used when doing a direct read
(reading single sample via in_temp0_raw). We shouldn't need a custom attribute
for it.

If there is a convincing reason we need it, it should be in a separate patch
and the commit message should explain the motivation.

> +Date:		August 2025
> +KernelVersion:	6.17
> +Contact:	Lakshay Piplani <lakshay.piplani@nxp.com>
> +Description:
> +		(WO) Write-only attribute to trigger a one-shot temperature
> +		measurement on the P3T1750/P3T1755 sensor. Writing '1' initiates
> +		the measurement if the device is in shutdown mode. Writing '0' or
> +		any other value is invalid.
> +
> +		Returns -EBUSY if the device is not in shutdown mode.
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 1244d8e17d50..7bfa204ba428 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -181,5 +181,6 @@ config MCP9600
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called mcp9600.
> +source "drivers/iio/temperature/p3t/Kconfig"
>  
>  endmenu
> diff --git a/drivers/iio/temperature/p3t/Kconfig b/drivers/iio/temperature/p3t/Kconfig
> new file mode 100644
> index 000000000000..bec2fb09eceb
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config IIO_P3T1755
> +	tristate
> +	depends on (I2C || I3C)
> +
> +config IIO_P3T1755_I2C
> +	tristate "NXP P3T1755 temprature sensor I2C driver"

s/temprature/temperature/


> +	select IIO_P3T1755
> +	select REGMAP_I2C

	depends on I2C

> +	help
> +	  Say yes here to build support for NXP P3T1755 I2C temperature
> +	  sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called p3t1755_i2c
> +
> +config IIO_P3T1755_I3C
> +	tristate "NXP P3T1755 temprature sensor I3C driver"

s/temprature/temperature/

> +	select IIO_P3T1755
> +	select REGMAP_I3C
> +	depends on I3C
> +	help
> +	  Say yes here to build support for NXP P3T1755 I3C temperature
> +	  sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called p3t1755_i3c
> diff --git a/drivers/iio/temperature/p3t/Makefile b/drivers/iio/temperature/p3t/Makefile
> new file mode 100644
> index 000000000000..7d33b507f1f1
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_IIO_P3T1755) += p3t1755_core.o
> +obj-$(CONFIG_IIO_P3T1755_I2C) += p3t1755_i2c.o
> +obj-$(CONFIG_IIO_P3T1755_I3C) += p3t1755_i3c.o
> diff --git a/drivers/iio/temperature/p3t/p3t1755.h b/drivers/iio/temperature/p3t/p3t1755.h
> new file mode 100644
> index 000000000000..8e56dd64b813
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#ifndef P3T1755_H
> +#define P3T1755_H
> +
> +#include <linux/device.h>

Normally, we would just write `struct device;` instead of including
this header.

> +#include <linux/iio/iio.h>

We can do the same for `struct iio_chan_spec;`.

But we should be including linux/types.h for bool and linux/mutex.h
for struct mutex since that one is not just used as a pointer.

> +
> +#define P3T1755_REG_TEMP		0x0
> +#define P3T1755_REG_CFGR		0x1
> +#define P3T1755_REG_LOW_LIM		0x2
> +#define P3T1755_REG_HIGH_LIM		0x3
> +
> +#define P3T1755_SHUTDOWN_BIT		BIT(0)
> +#define P3T1755_TM_BIT			BIT(1)
> +#define P3T1755_POL_BIT			BIT(2)
> +#define P3T1755_ONE_SHOT_BIT		BIT(7)
> +
> +#define P3T1755_FAULT_QUEUE_SHIFT	3

Use FIELD_PREP() with P3T1755_FAULT_QUEUE_MASK instead of
P3T1755_FAULT_QUEUE_SHIFT and remove P3T1755_FAULT_QUEUE_SHIFT.

> +#define P3T1755_FAULT_QUEUE_MASK	GENMASK(4, 3)
> +
> +#define P3T1755_CONVERSION_TIME_BITS	GENMASK(6, 5)
> +
> +extern const struct p3t1755_info p3t1755_channels_info;
> +extern const struct p3t1755_info p3t1750_channels_info;
> +
> +enum p3t1755_hw_id {
> +	P3T1755_ID = 0,
> +	P3T1750_ID,
> +};
> +
> +struct p3t1755_info {
> +	const char *name;
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +};
> +
> +struct p3t1755_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex lock; /* Protects access to sensor registers */
> +	bool tm_mode;
> +};
> +
> +int p3t1755_fault_queue_to_bits(int val);
> +int p3t1755_probe(struct device *dev, const struct p3t1755_info *chip,
> +		  struct regmap *regmap, bool tm_mode, int fq_bits, int irq);
> +int p3t1755_get_temp_and_limits(struct p3t1755_data *data,
> +				int *temp_raw, int *thigh_raw, int *tlow_raw);
> +void p3t1755_push_thresh_event(struct iio_dev *indio_dev);
> +
> +#endif /* P3T1755_H */
> diff --git a/drivers/iio/temperature/p3t/p3t1755_core.c b/drivers/iio/temperature/p3t/p3t1755_core.c
> new file mode 100644
> index 000000000000..264bf4abb088
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_core.c
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/types.h>
> +#include <linux/regmap.h>
> +#include <linux/device.h>
> +#include <linux/iio/events.h>
> +
> +#include "p3t1755.h"
> +
> +enum p3t1755_attr_index {
> +	P3T1755_ATTR_THERMOSTAT_MODE,
> +	P3T1755_ATTR_TRIGGER_ONE_SHOT,
> +	P3T1755_ATTR_FAULT_QUEUE_LENGTH,

Two of these aren't used in the code.

> +};
> +
> +static const struct {
> +	u8 bits;
> +	unsigned int freq_hz;
> +} p3t1755_samp_freqs[] = {
> +	{ 0x00, 36 },
> +	{ 0x01, 18 },
> +	{ 0x02, 9 },
> +	{ 0x03, 4 },
> +};
> +
> +static const int p3t1755_fault_queue_values[] = { 1, 2, 4, 6 };
> +
> +int p3t1755_fault_queue_to_bits(int val)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(p3t1755_fault_queue_values); i++)
> +		if (p3t1755_fault_queue_values[i] == val)
> +			return i;
> +	return -EINVAL;
> +}
> +
> +int p3t1755_get_temp_and_limits(struct p3t1755_data *data,
> +				int *temp_raw, int *thigh_raw, int *tlow_raw)
> +{
> +	__be16 be;
> +	int ret;
> +	int raw12;
> +
> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, &be, sizeof(be));
> +	if (ret) {
> +		dev_dbg(data->dev, "TEMP read failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	raw12 = sign_extend32(be16_to_cpu(be) >> 4, 11);
> +	*temp_raw = raw12;
> +
> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_HIGH_LIM, &be, sizeof(be));
> +	if (ret) {
> +		dev_dbg(data->dev, "HIGH_LIM read failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	raw12 = sign_extend32(be16_to_cpu(be) >> 4, 11);> +	*thigh_raw = raw12;
> +
> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_LOW_LIM, &be, sizeof(be));
> +	if (ret) {
> +		dev_dbg(data->dev, "LOW_LIM read failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	raw12 = sign_extend32(be16_to_cpu(be) >> 4, 11);
> +	*tlow_raw = raw12;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(p3t1755_get_temp_and_limits, IIO_P3T1755);
> +
> +void p3t1755_push_thresh_event(struct iio_dev *indio_dev)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	int ret, temp, thigh, tlow;
> +	unsigned int cfgr;
> +
> +	/* Read CFGR register to check device mode and implicitly clear the ALERT latch.

IIO subsystem style is:

	/*
	 * Read ...

> +	 * As per Datasheet: "Any register read will clear the interrupt"
> +	 */
> +	ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to read CFGR register: %d\n", ret);
> +		return;
> +	}
> +
> +	if (FIELD_GET(P3T1755_SHUTDOWN_BIT, cfgr)) {
> +		dev_dbg(data->dev, "Device is in shutdown mode, skipping event push\n");
> +		return;
> +	}
> +
> +	ret = p3t1755_get_temp_and_limits(data, &temp, &thigh, &tlow);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to get temperature and limits: %d\n", ret);
> +		return;
> +	}
> +
> +	if (temp >= thigh || temp <= tlow) {
> +		dev_dbg(data->dev, "Threshold event: DIR_EITHER (T=%d, TH=%d, TL=%d)\n",
> +			temp, thigh, tlow);
> +
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_TEMP, 0, IIO_NO_MOD,
> +							     IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
> +	} else {
> +		dev_dbg(data->dev, "Temperature within limits: no event triggered (T=%d, TH=%d, TL=%d)\n",
> +			temp, thigh, tlow);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(p3t1755_push_thresh_event, IIO_P3T1755);
> +
> +static int p3t1755_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	unsigned int cfgr;
> +	__be16 be;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, &be, sizeof(be));
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read temperature register\n");

The error goes to userspace, so dev_err() is redundant and should be removed.
Same advice applies elsewhere.

> +			return ret;
> +		}
> +		*val = sign_extend32(be16_to_cpu(be) >> 4, 11);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 625;
> +		*val2 = 10000;
> +
> +		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_ENABLE:
> +		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read configuration register\n");
> +			return ret;
> +		}
> +		*val = !FIELD_GET(P3T1755_SHUTDOWN_BIT, cfgr);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		u8 sel;
> +
> +		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read configuration register\n");
> +			return ret;
> +		}
> +
> +		sel = FIELD_GET(P3T1755_CONVERSION_TIME_BITS, cfgr);
> +		if (sel >= ARRAY_SIZE(p3t1755_samp_freqs))
> +			return -EINVAL;
> +
> +		*val = p3t1755_samp_freqs[sel].freq_hz;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int p3t1755_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		ret = regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +					 P3T1755_SHUTDOWN_BIT,
> +					 val == 0 ? P3T1755_SHUTDOWN_BIT : 0);

Generally, a shutdown mode like this would be controled by power management
rather than through an enable bit. Perhaps something to save for a later
patch.

> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to update SHUTDOWN bit\n");
> +			return ret;
> +		}
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		u32 regbits;
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(p3t1755_samp_freqs); i++) {
> +			if (p3t1755_samp_freqs[i].freq_hz == val)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(p3t1755_samp_freqs))
> +			return -EINVAL;
> +
> +		regbits = FIELD_PREP(P3T1755_CONVERSION_TIME_BITS, (u32)i);
> +
> +		return regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +					  P3T1755_CONVERSION_TIME_BITS,
> +					  regbits);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int p3t1755_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int *val,
> +				    int *val2)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	unsigned int reg;
> +	__be16 be;
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	reg = (dir == IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> +					   P3T1755_REG_LOW_LIM;
> +
> +	ret = regmap_bulk_read(data->regmap, reg, &be, sizeof(be));
> +	if (ret < 0) {
> +		dev_err(data->dev, "Failed to read Thigh or Tlow register\n");
> +		return ret;
> +	}
> +
> +	*val = sign_extend32(be16_to_cpu(be) >> 4, 11);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int p3t1755_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info, int val,
> +				     int val2)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	unsigned int reg;
> +	__be16 be;
> +
> +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	reg = (dir == IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> +					   P3T1755_REG_LOW_LIM;
> +
> +	if (val < -2048 || val > 2047)
> +		return -ERANGE;
> +
> +	be = cpu_to_be16((u16)((val & 0xfff) << 4));
> +
> +	return regmap_bulk_write(data->regmap, reg, &be, sizeof(be));
> +}
> +
> +static int p3t1755_trigger_one_shot(struct p3t1755_data *data)
> +{
> +	unsigned int config;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &config);
> +	if (ret)
> +		goto out;
> +
> +	if (!(config & P3T1755_SHUTDOWN_BIT)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	config |= P3T1755_ONE_SHOT_BIT;
> +	ret = regmap_write(data->regmap, P3T1755_REG_CFGR, config);
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static ssize_t p3t1755_attr_store(struct device *dev, struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	int ret;
> +	bool enable;
> +
> +	switch (iattr->address) {
> +	case P3T1755_ATTR_TRIGGER_ONE_SHOT:
> +		ret = kstrtobool(buf, &enable);
> +		if (ret || !enable)
> +			return ret ? ret : -EINVAL;
> +		ret = p3t1755_trigger_one_shot(data);
> +		return ret ?: count;
> +
> +	default:
> +		return -EINVAL;
> +		}
> +	}
> +
> +static IIO_DEVICE_ATTR(trigger_one_shot, 0200, NULL, p3t1755_attr_store,
> +		       P3T1755_ATTR_TRIGGER_ONE_SHOT);
> +
> +static const struct iio_event_spec p3t1755_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> +	},
> +};
> +
> +static const struct iio_chan_spec p3t1755_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_ENABLE) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = p3t1755_events,
> +		.num_event_specs = ARRAY_SIZE(p3t1755_events),
> +	},
> +};
> +
> +const struct p3t1755_info p3t1755_channels_info = {
> +	.name = "p3t1755",
> +	.channels = p3t1755_channels,
> +	.num_channels = ARRAY_SIZE(p3t1755_channels)
> +};
> +EXPORT_SYMBOL_NS(p3t1755_channels_info, IIO_P3T1755);
> +
> +const struct p3t1755_info p3t1750_channels_info = {
> +	.name = "p3t1750",
> +	.channels = p3t1755_channels,
> +	.num_channels = ARRAY_SIZE(p3t1755_channels)
> +};
> +EXPORT_SYMBOL_NS(p3t1750_channels_info, IIO_P3T1755);
> +
> +static struct attribute *p3t1755_attributes[] = {
> +	&iio_dev_attr_trigger_one_shot.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group p3t1755_attr_group = {
> +	.attrs = p3t1755_attributes,
> +};
> +
> +static const struct iio_info p3t1755_info = {
> +	.read_raw = p3t1755_read_raw,
> +	.write_raw = p3t1755_write_raw,
> +	.read_event_value = p3t1755_read_event_value,
> +	.write_event_value = p3t1755_write_event_value,
> +	.attrs = &p3t1755_attr_group,
> +};
> +
> +static irqreturn_t p3t1755_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +
> +	dev_dbg(&indio_dev->dev, "IRQ triggered, processing threshold event\n");
> +
> +	p3t1755_push_thresh_event(indio_dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int p3t1755_probe(struct device *dev, const struct p3t1755_info *chip,
> +		  struct regmap *regmap, bool tm_mode, int fq_bits, int irq)
> +{
> +	struct p3t1755_data *data;
> +	struct iio_dev *iio_dev;
> +	unsigned long irq_flags;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio_dev);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +	data->tm_mode = tm_mode;
> +
> +	mutex_init(&data->lock);
> +
> +	iio_dev->name = chip->name;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->info = &p3t1755_info;
> +	iio_dev->channels = chip->channels;
> +	iio_dev->num_channels = chip->num_channels;
> +
> +	dev_set_drvdata(dev, iio_dev);
> +
> +	ret = regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +				 P3T1755_TM_BIT,
> +				(tm_mode ? P3T1755_TM_BIT : 0));
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Failed to update TM bit\n");
> +
> +	if (fq_bits >= 0)
> +		regmap_update_bits(data->regmap, P3T1755_REG_CFGR, P3T1755_FAULT_QUEUE_MASK,
> +				   fq_bits << P3T1755_FAULT_QUEUE_SHIFT);
> +
> +	ret = devm_iio_device_register(dev, iio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Temperature sensor failed to register\n");
> +
> +	if (irq > 0) {
> +		iio_dev = dev_get_drvdata(dev);

iio_dev is already in scope, so this is not needed.

> +		data = iio_priv(iio_dev);

ditto.

> +
> +		if (tm_mode)
> +			irq_flags = IRQF_TRIGGER_FALLING;
> +		else
> +			irq_flags = (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING);

Usually, these flags are coming from the interrupts property in the
devicetree.

> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						p3t1755_irq_handler, irq_flags | IRQF_ONESHOT,
> +						"p3t175x", iio_dev);
> +		if (ret)
> +			dev_err_probe(dev, ret, "Failed to request IRQ: %d\n", ret);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS(p3t1755_probe, IIO_P3T1755);
> +
> +MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
> +MODULE_DESCRIPTION("NXP P3T175x Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/temperature/p3t/p3t1755_i2c.c b/drivers/iio/temperature/p3t/p3t1755_i2c.c
> new file mode 100644
> index 000000000000..7c12f326a859
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_i2c.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +
> +#include "p3t1755.h"
> +
> +static const struct regmap_config p3t1755_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static const struct of_device_id p3t1755_i2c_of_match[] = {
> +	{ .compatible = "nxp,p3t1755-iio", .data = &p3t1755_channels_info },
> +	{ .compatible = "nxp,p3t1750-iio", .data = &p3t1750_channels_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, p3t1755_i2c_of_match);
> +
> +static const struct i2c_device_id p3t1755_i2c_id_table[] = {
> +	{ "p3t1755", (kernel_ulong_t)&p3t1755_channels_info },
> +	{ "p3t1750", (kernel_ulong_t)&p3t1750_channels_info},

Missing space before }.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, p3t1755_i2c_id_table);
> +
> +static int p3t1755_i2c_probe(struct i2c_client *client)
> +{
> +	const struct p3t1755_info *chip;
> +	struct regmap *regmap;
> +	bool tm_mode = false;
> +	int fq_bits = -1;
> +	int ret;
> +	u32 fq;
> +
> +	regmap = devm_regmap_init_i2c(client, &p3t1755_i2c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "regmap init failed\n");
> +	}
> +
> +	tm_mode = device_property_read_bool(&client->dev, "nxp,interrupt-mode");
> +
> +	if (!device_property_read_u32(&client->dev, "nxp,fault-queue", &fq)) {
> +		fq_bits = p3t1755_fault_queue_to_bits(fq);
> +		if (fq_bits < 0) {
> +			return dev_err_probe(&client->dev, fq_bits,
> +						     "invalid nxp,fault-queue %u (1/2/4/6)\n", fq);
> +			}
> +	}
> +
> +	dev_dbg(&client->dev, "Using TM mode: %s\n",
> +		tm_mode ? "Interrupt" : "Comparator");
> +
> +	chip = i2c_get_match_data(client);
> +
> +	dev_dbg(&client->dev, "Registering p3t175x temperature sensor");
> +
> +	ret = p3t1755_probe(&client->dev, chip, regmap,
> +			    tm_mode, fq_bits, client->irq);
> +
> +	if (ret) {
> +		dev_err_probe(&client->dev, ret, "p3t175x probe failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver p3t1755_driver = {
> +	.driver = {
> +		.name = "p3t175x_i2c",
> +		.of_match_table = p3t1755_i2c_of_match,
> +	},
> +	.probe = p3t1755_i2c_probe,
> +	.id_table = p3t1755_i2c_id_table,
> +};
> +module_i2c_driver(p3t1755_driver);
> +
> +MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
> +MODULE_DESCRIPTION("NXP P3T175x I2C Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_P3T1755);
> diff --git a/drivers/iio/temperature/p3t/p3t1755_i3c.c b/drivers/iio/temperature/p3t/p3t1755_i3c.c
> new file mode 100644
> index 000000000000..9f61544b2eb6
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_i3c.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +
> +#include "p3t1755.h"
> +
> +static void p3t1755_ibi_handler(struct i3c_device *dev,
> +				const struct i3c_ibi_payload *payload)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&dev->dev);
> +
> +	p3t1755_push_thresh_event(indio_dev);
> +}
> +
> +/*
> + * Both P3T1755 and P3T1750 share the same I3C PID (0x011B:0x152A),
> + * making runtime differentiation impossible, so using "p3t1755" as
> + * name in sysfs and IIO for I3C based instances.
> + */
> +static const struct i3c_device_id p3t1755_i3c_ids[] = {
> +	I3C_DEVICE(0x011B, 0x152A, &p3t1755_channels_info),
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i3c, p3t1755_i3c_ids);
> +
> +static void p3t1755_disable_ibi(void *data)
> +{
> +	i3c_device_disable_ibi((struct i3c_device *)data);
> +}
> +
> +static void p3t1755_free_ibi(void *data)
> +{
> +	i3c_device_free_ibi((struct i3c_device *)data);
> +}
> +
> +static int p3t1755_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	const struct regmap_config p3t1755_i3c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,

Needs more indent.

> +	};
> +
> +	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, p3t1755_i3c_ids);
> +	const struct p3t1755_info *chip;
> +	struct device *dev = &i3cdev->dev;
> +	struct i3c_ibi_setup ibi_setup;
> +	struct regmap *regmap;
> +	bool tm_mode = false;
> +	int fq_bits = -1;
> +	int ret;
> +	u32 fq;
> +
> +	chip = id ? id->data : NULL;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &p3t1755_i3c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
> +				     "Failed to register I3C regmap %ld\n", PTR_ERR(regmap));
> +	}
> +
> +	tm_mode = device_property_read_bool(dev, "nxp,interrupt-mode");
> +
> +	if (!device_property_read_u32(dev, "nxp,fault-queue", &fq)) {
> +		fq_bits = p3t1755_fault_queue_to_bits(fq);
> +		if (fq_bits < 0) {
> +			return dev_err_probe(&i3cdev->dev, fq_bits,
> +					     "invalid nxp,fault-queue %u (1/2/4/6)\n", fq);
> +		}
> +	}
> +
> +	dev_dbg(&i3cdev->dev, "Using TM mode: %s\n", tm_mode ? "Interrupt" : "Comparator");
> +
> +	ret = p3t1755_probe(dev, chip, regmap, tm_mode, fq_bits, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "p3t175x probe failed: %d\n", ret);
> +
> +	if (!tm_mode) {
> +		dev_warn(&i3cdev->dev, "IBI not supported in comparator mode, skipping IBI registration\n");
> +		return 0;
> +	}
> +
> +	ibi_setup = (struct i3c_ibi_setup) {
> +		.handler = p3t1755_ibi_handler,
> +		.num_slots = 4,
> +		.max_payload_len = 0,
> +	};
> +
> +	ret = i3c_device_request_ibi(i3cdev, &ibi_setup);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request IBI\n");
> +
> +	ret = i3c_device_enable_ibi(i3cdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable IBI\n");
> +
> +	ret = devm_add_action_or_reset(dev, p3t1755_disable_ibi, i3cdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register IBI disable action\n");
> +
> +	ret = devm_add_action_or_reset(dev, p3t1755_free_ibi, i3cdev);

This should be immediatly after the action that it undoes. I assume
i3c_device_request_ibi(). Otherwise, if enable fails, it won't be
freed.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register IBI free action\n");
> +
> +	dev_dbg(&i3cdev->dev, "IBI successfully registered\n");
> +
> +	return 0;
> +}
> +
> +static struct i3c_driver p3t1755_driver = {
> +	.driver = {
> +		.name = "p3t175x_i3c",
> +	},
> +	.probe = p3t1755_i3c_probe,
> +	.id_table = p3t1755_i3c_ids,
> +};
> +module_i3c_driver(p3t1755_driver);
> +
> +MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
> +MODULE_DESCRIPTION("NXP P3T175x I3C Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_P3T1755);


