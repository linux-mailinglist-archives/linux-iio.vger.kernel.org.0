Return-Path: <linux-iio+bounces-24174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1911DB5A00F
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 20:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139827AB3C6
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE73D27B4E4;
	Tue, 16 Sep 2025 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DxGo1tup"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD527FB2B
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045887; cv=none; b=N31ybofd55Q0kng9mq9Yilx4kvfsI9/Nt6QsJF8bo6OdnO+itpxe/S5qmjkGWmIO5J1tfNjFa2PaKqtrWrRIKJtlGBoaiuHehSKPTXbhK11q2v5x8j1u4JAr6CaLGm49YEEtR51dd5LDHCtw4NpRnkmmd13VGD8KVhc38plH30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045887; c=relaxed/simple;
	bh=GjkZN1smr7yUW9Zq5CfJKcJON/l+nCM270B6a9XUupk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4PIBmAkKiNQdCgUDhfmPV6S3DWc8NgHfOl3iWnhcCM2BCSTXwkkENY1kYEBc4LbQc3wTLeEo739FqallxtKiRxGn0sU74BcWCJqhM3Srht2AJ4ohOxmNdYbLz3D0d++jl/CL/h4YWWuaTYtB57PdjP9s+etQE1EDTqGB4Hce0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DxGo1tup; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-745a415bf72so2190121a34.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758045883; x=1758650683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFrIIx80NS/E8M1Hnossbof5WVhKZVSMaz99hTjoGYg=;
        b=DxGo1tupI97oL2qHcnZeA7nvOPFy6X2eWqHzQDykQDXiANd7p9LK3mkXQGquAvcs3O
         H+ZzDElh9WnFEI14FlHTt1eIQAT+Ek/vkFeuyxBZLnSKyXycQlj1nTUJnxnDgZa5z2nZ
         8PNj81CHGrTKgEvLkHV8ycn4LbMDVtMrTgFiC6UmV2qrg2+hWDMkBW6oLpa2cvN16yr8
         IrhfF3TJV3aP4jv/qnKB/t5SqWXneNGzqeDDu6iL8rjjuaRsKM7qk9BS8K2wmt4hjkNW
         uTVIWvnBj9wgnmOJBYObwZuTYcLAjsPq2ZP7eLAM7blsKctakOi6BqwX98jBRut4FvdJ
         cydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758045883; x=1758650683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFrIIx80NS/E8M1Hnossbof5WVhKZVSMaz99hTjoGYg=;
        b=ObsF+1p1i/8tY+hpMUQm0pwY/25I4cVYjSSPePAjvkvJvZY1TtEwa7Tf5VdGrOgX+b
         TM5x8ORuy+YrFyFY3TzYySNsXobh78qh5Ve0IBYeqMorXLlLgSL9kVuoPzejUAM+Z11C
         8Bce6YAkj1XiQTYcX9o7tkSQkcgTaPWW0Qnyi2H/8w96NgttJyXzj97n1wYqYBY5Tak5
         3gmiLGV/j9w8sJyDzSsWYTXwx4mds66BdjA3ZZKyt+oK5QGaJBqo9nKBTC1qUn6UJYNS
         pdiMDPzvA3WjF7xBGVHJEz6kfu+U0ZRM5Tm4BZdM1GdnhVJvubSvUaSrJT3KILz4968e
         JmTg==
X-Forwarded-Encrypted: i=1; AJvYcCU/eEEwyN5DU7Z3ZFx5nt28M3K8M3pAAByO5A4smuFsd9hrAHJ4nfzoSlEd030HCc8iutWzS9AmcKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQ4O+bT6JZyBOIFM9g1L2rwjpPMmxd4MOsxJLfwHSP/W4nr5s
	klcY5nOgQ6oi5d5vVjkmSYKc4fe27jfW2oBmyhv/ct3OZjX9kMVrVXQNY4FwftQ8sYQ=
X-Gm-Gg: ASbGnctA6dpI6ZUhHohZVrJr6NVMnzdjOPhIprF0f08BO2Ra18/pxccUj5ebK2+yLD9
	3lrZIR6DezZi8E+1KBNHQ8NmjAXvcBBMIyWo8o8OwwdqWA/kbA60SnqpHuZL0oN4th41DkR8CU4
	tsX5EKCxLEwXpJqCzEkcXCF7Y4aCH8T0RIxq2frhs6GrzDE4EiQDl7WvuUnJVPQM694UlHRax1+
	gCwogdJ1cq7wlECmWbQDkb2CDVwtETCZJGbxX3u598JdeC2E15eug+jKeA8sATwAntuVI2/rHlG
	tmAdx3uIJNLefjGmIlUSVEs/a+2+CGoq0HBFRkpnSIJrdjVhAhiH+AVChu54qtYK7xA20a1/cAP
	zAKeiv5yFMzFCb/pCuYvwwZRA6oujZUg2pblwkjEtKcdTzwxYjR7OqCMUwDMgkq5hgiMWUCDbzX
	g=
X-Google-Smtp-Source: AGHT+IGs/JsDVjy39L2mz4/CLuVfXDjRCjXDSXi+hIEnnux0obrrZ84mLpOod05jClwfipmcAyE+3w==
X-Received: by 2002:a05:6830:6419:b0:741:3929:31a with SMTP id 46e09a7af769-75353779d63mr10320637a34.12.1758045883261;
        Tue, 16 Sep 2025 11:04:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a1:e065:6248:ef8b? ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524c260735sm4192321a34.39.2025.09.16.11.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 11:04:42 -0700 (PDT)
Message-ID: <2d5ef36b-ae37-453d-a19b-76fc97b7f14f@baylibre.com>
Date: Tue, 16 Sep 2025 13:04:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] iio: adc: max14001: New driver
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:
> The MAX14001/MAX14002 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs. In addition to ADC readings, the MAX14001/MAX14002 offers
> more features, like a binary comparator, a filtered reading that can
> provide the average of the last 2, 4, or 8 ADC readings, and an inrush
> comparator that triggers the inrush current. There is also a fault feature
> that can diagnose seven possible fault conditions. And an option to select
> an external or internal ADC voltage reference.
> 
> MAX14001/MAX14002 features implemented so far:
> - Raw ADC reading.
> - Filtered ADC average reading with the default configuration.
> - MV fault disable.
> - Selection of external or internal ADC voltage reference, depending on
> whether it is declared in the device tree.
> 
> Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> ---
> 
> I have addressed almost all of the comments, thank you very much for the 
> review. I would like to highlight some of them:
> 
> Changes since v10:
> - Dropped the kernel.h include
> - Add the cleanup.h, mutex.h, regmap.h and units.h includes
> - Renamed the reg_addr variable name to reg
> - Renamed the reg_data variable name to val
> - Added the regmap implementation
> - Used scoped_guard()
> - Refactored the get refin voltage code
> - Replace max14001_chip_model with data structures separated
> - Added debugfs_reg_access
> 
> Change I was not able to do:
> - I could not remove bitrev16 because I am using an SPI controller that
> does not support SPI_LSB_FIRST. So I suggest keeping bitrev16 and not using
> the spi-lsb-first devicetree property for now, since this driver currently
> works for both types of controllers: those that support it and those that
> do not. I left a TODO comment to address this issue as soon as the SPI
> kernel code starts handling the bit-reverse operation for controllers that
> do not have this support. Once I finish my work on this driver, if the SPI
> code still does not include this handling, I can submit patches to add it.

I looked more at what it would take to implement this in the SPI core code
and found that it would actually be quite difficult to do in a generic way
because there are so many edge/corner/n-dim cases. We can't change tx_buf
data in-place because it might be const data that is in some memory area
that can't be modified. And things would get complicated if different
transfers pointed to the same buffer memory addresses anyway. So we would
basically have to allocate new memory for all buffers, copy all tx data to
that new memory, reverse all of the tx bits, and update all the pointers in
the transfer structs. Then when the message was finished, we would have to
reverse all of the rx bits, copy all of the rx buffers back to the original
buffers and put all the buffer pointers back the way they were. But this
could write over some of the original tx data if tx_buf and rx_buf point to
the same original buffer, which would break things if a peripheral driver
expected the tx data to persist. And we can't do this during the SPI optimize
step because that currently allows the tx_buf data values to be modified after
optimization.

So perhaps it is best to just handle it in the peripheral driver. It will
be much more efficent that way anyway.

However, we still do want to handle SPI_LSB_FIRST now so that people with
hardware support can be more efficient and we don't want things to break
if someone puts spi-lsb-first in the devicetree.

I made some comments below on how we could handle this.

> 
>  MAINTAINERS                |   1 +
>  drivers/iio/adc/Kconfig    |  10 ++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max14001.c | 356 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 368 insertions(+)
>  create mode 100644 drivers/iio/adc/max14001.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bae420caa63..a9cf93ba8b21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14998,6 +14998,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> +F:	drivers/iio/adc/max14001.c
>  
>  MAXBOTIX ULTRASONIC RANGER IIO DRIVER
>  M:	Andreas Klinger <ak@it-klinger.de>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 237fa2061329..a1f2afce60ad 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -991,6 +991,16 @@ config MAX11410
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max11410.
>  
> +config MAX14001
> +	tristate "Analog Devices MAX14001/MAX14002 ADC driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices MAX14001/MAX14002
> +	  Configurable, Isolated 10-bit ADCs for Multi-Range Binary Inputs.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max14001.
> +

Shouldn't MAX14... be after MAX12... for alphabetical order?

>  config MAX1241
>  	tristate "Maxim max1241 ADC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 611c16430621..9c4ceb527db7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_MAX11100) += max11100.o
>  obj-$(CONFIG_MAX1118) += max1118.o
>  obj-$(CONFIG_MAX11205) += max11205.o
>  obj-$(CONFIG_MAX11410) += max11410.o
> +obj-$(CONFIG_MAX14001) += max14001.o

Same here.

>  obj-$(CONFIG_MAX1241) += max1241.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MAX34408) += max34408.o
> diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> new file mode 100644
> index 000000000000..2ade57970064
> --- /dev/null
> +++ b/drivers/iio/adc/max14001.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Analog Devices MAX14001/MAX14002 ADC driver
> + *
> + * Copyright (C) 2023-2025 Analog Devices Inc.
> + * Copyright (C) 2023 Kim Seer Paller <kimseer.paller@analog.com>
> + * Copyright (c) 2025 Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
> + */
> +
> +/*
> + * TODO:
> + * Replace bitrev16 with SPI_LSB_FIRST once the SPI kernel code supports handling
> + * SPI controllers that lack LSB-first support.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitrev.h>
> +#include <linux/bits.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +/* MAX14001 Registers Address */
> +#define MAX14001_REG_ADC		0x00
> +#define MAX14001_REG_FADC		0x01
> +#define MAX14001_REG_FLAGS		0x02
> +#define MAX14001_REG_FLTEN		0x03
> +#define MAX14001_REG_THL		0x04
> +#define MAX14001_REG_THU		0x05
> +#define MAX14001_REG_INRR		0x06
> +#define MAX14001_REG_INRT		0x07
> +#define MAX14001_REG_INRP		0x08
> +#define MAX14001_REG_CFG		0x09
> +#define MAX14001_REG_ENBL		0x0A
> +#define MAX14001_REG_ACT		0x0B
> +#define MAX14001_REG_WEN		0x0C
> +
> +#define MAX14001_REG_VERIFICATION(x)	((x) + 0x10)
> +
> +#define MAX14001_REG_CFG_BIT_EXRF	BIT(5)
> +
> +#define MAX14001_REG_WEN_VALUE_WRITE	0x294
> +
> +#define MAX14001_MASK_ADDR		GENMASK(15, 11)
> +#define MAX14001_MASK_WR		BIT(10)
> +#define MAX14001_MASK_DATA		GENMASK(9, 0)
> +
> +struct max14001_state {
> +	const struct max14001_chip_info *chip_info;
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	int vref_mV;
> +	/*
> +	 * lock protect against multiple concurrent accesses, RMW sequence,
> +	 * and SPI transfer.

regmap has it's own locking. Currently, this is only protecteing a couple
of reads. So eaither we don't need this because the lock in regmap is good
enough or we have missed some places where locking would be needed.

In other words, we probably don't need this lock until later, so could
drop it for now.

> +	 */
> +	struct mutex lock;

	bool spi_hw_has_lsb_first;

> +	/*
> +	 * The following buffers will be bit-reversed during device
> +	 * communication, because the device transmits and receives data
> +	 * LSB-first.
> +	 * DMA (thus cache coherency maintenance) requires the transfer
> +	 * buffers to live in their own cache lines.
> +	 */
> +	__be16 spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
> +	__be16 spi_rx_buffer;

These would no longer be strictly big-endian, so we could
just make them u16 with a note in the comments.

> +};
> +
> +struct max14001_chip_info {
> +	const char *name;
> +};
> +
> +static struct max14001_chip_info max14001_chip_info = {
> +	.name = "max14001",
> +};
> +
> +static struct max14001_chip_info max14002_chip_info = {
> +	.name = "max14002",
> +};
> +
> +static int max14001_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct max14001_state *st = context;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &st->spi_tx_buffer,
> +			.len = sizeof(st->spi_tx_buffer),
> +			.cs_change = 1,
> +		}, {
> +			.rx_buf = &st->spi_rx_buffer,
> +			.len = sizeof(st->spi_rx_buffer),
> +		},
> +	};
> +	int ret;

	u16 addr, data;

> +
> +	/*
> +	 * Prepare SPI transmit buffer 16 bit-value big-endian format and
> +	 * reverses bit order to align with the LSB-first input on SDI port
> +	 * in order to meet the device communication requirements.
> +	 */
> +	st->spi_tx_buffer = cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_MASK_ADDR, reg)));

	addr = FIELD_PREP(MAX14001_MASK_ADDR, reg);

	if (st->spi_hw_has_lsb_first)
		st->spi_tx_buffer = cpu_to_le16(addr);
	else
		st->spi_tx_buffer = cpu_to_be16(bitrev16(addr));	
	> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Convert received 16-bit value from big-endian to cpu-endian format
> +	 * and reverses bit order.
> +	 */
> +	*val = FIELD_GET(MAX14001_MASK_DATA, bitrev16(be16_to_cpu(st->spi_rx_buffer)));

	if (st->spi_hw_has_lsb_first)
		data = le16_to_cpu(st->spi_rx_buffer);
	else
		data = bitrev16(be16_to_cpu(st->spi_rx_buffer));

	val = FIELD_GET(MAX14001_MASK_DATA, data);

> +
> +	return 0;
> +}
> +
> +static int max14001_write(struct max14001_state *st, unsigned int reg, unsigned int val)
> +{

	u16 addr;

> +	/*
> +	 * Prepare SPI transmit buffer 16 bit-value big-endian format and
> +	 * reverses bit order to align with the LSB-first input on SDI port
> +	 * in order to meet the device communication requirements.
> +	 */
> +	st->spi_tx_buffer = cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_MASK_ADDR, reg) |
> +						 FIELD_PREP(MAX14001_MASK_WR, 1) |
> +						 FIELD_PREP(MAX14001_MASK_DATA, val)));


	addr = FIELD_PREP(MAX14001_MASK_ADDR, reg) |
	       FIELD_PREP(MAX14001_MASK_WR, 1) |
	       FIELD_PREP(MAX14001_MASK_DATA, val);

	if (st->spi_hw_has_lsb_first)
		st->spi_tx_buffer = cpu_to_le16(addr);
	else
		st->spi_tx_buffer = cpu_to_be16(bitrev16(addr));	

> +
> +	return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_buffer));
> +}
> +
> +static int max14001_write_single_reg(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct max14001_state *st = context;
> +	int ret;
> +
> +	/* Enable writing to the SPI register */
> +	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_REG_WEN_VALUE_WRITE);
> +	if (ret)
> +		return ret;
> +
> +	/* Writing data into SPI register */
> +	ret = max14001_write(st, reg, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable writing to the SPI register */
> +	return max14001_write(st, MAX14001_REG_WEN, 0);
> +}
> +
> +static int max14001_write_verification_reg(struct max14001_state *st, unsigned int reg)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	return max14001_write(st, MAX14001_REG_VERIFICATION(reg), val);
> +}
> +
> +static int max14001_disable_mv_fault(struct max14001_state *st)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	/* Enable writing to the SPI registers */
> +	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_REG_WEN_VALUE_WRITE);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Reads all registers and writes the values to their appropriate
> +	 * verification registers to clear the Memory Validation fault.
> +	 */
> +	for (reg = MAX14001_REG_FLTEN; reg <= MAX14001_REG_ENBL; reg++) {
> +		ret = max14001_write_verification_reg(st, reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Disable writing to the SPI registers */
> +	return max14001_write(st, MAX14001_REG_WEN, 0);
> +}
> +
> +static int max14001_debugfs_reg_access(struct iio_dev *indio_dev,
> +				       unsigned int reg, unsigned int writeval,
> +				       unsigned int *readval)
> +{
> +	struct max14001_state *st = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int max14001_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max14001_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &st->lock)
> +			ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;

The scoped_guard() looks a bit odd with the extra indent. I would write
it like this instead:



	case IIO_CHAN_INFO_RAW: {
		guard(mutex)(&st->lock);

		ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
		if (ret)
			return ret;

		return IIO_VAL_INT;
	}

> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		scoped_guard(mutex, &st->lock)
> +			ret = regmap_read(st->regmap, MAX14001_REG_FADC, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mV;
> +		*val2 = 10;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct regmap_config max14001_regmap_config = {
> +	.reg_read = max14001_read,
> +	.reg_write = max14001_write_single_reg,

	.max_register = ?;

Setting max_register is useful.
	> +};
> +
> +static const struct iio_info max14001_info = {
> +	.read_raw = max14001_read_raw,
> +	.debugfs_reg_access = max14001_debugfs_reg_access,
> +};
> +
> +static const struct iio_chan_spec max14001_channel[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_AVERAGE_RAW) |

I think there was some discussion about this last time [1] that it
would actually make sense to have the average as a separate channel.

There are a few reasons for this. If we add buffered read support
later, we could only read the average in a buffered read if it is
a separate channel. And the average channel should have an extra
control that is either the -3 dB low pass filter point (using existing
ABI) or the averaging window size (potentially new ABI).

If we don't care about ever reading the filtered and not filtered
value at the same time, we could just have a single channel and only
ever read from the FADC register and ignore the ADC register.

In either case, we would not need IIO_CHAN_INFO_AVERAGE_RAW.

[1]: https://lore.kernel.org/linux-iio/20250903171105.00003dcd@huawei.com/

> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static int max14001_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct max14001_state *st;
> +	int ret, ext_vrefin = 0;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;

	st->spi_hw_has_lsb_first = spi->mode & SPI_LSB_FIRST;

> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return dev_err_probe(dev, -ENODEV, "Failed to get match data\n");
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &max14001_info;
> +	indio_dev->channels = max14001_channel;
> +	indio_dev->num_channels = ARRAY_SIZE(max14001_channel);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	st->regmap = devm_regmap_init(dev, NULL, st, &max14001_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap), "Failed to initialize regmap\n");
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable Vdd supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vddl");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable Vddl supply\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
> +
> +	if (ret < 0)
> +		ret = 1250000;
> +	else
> +		ext_vrefin = 1;
> +	st->vref_mV = ret / (MICRO / MILLI);

Just a style choice here, but in other drivers with similar handling
we wrote it like this to avoid the extra if statement:

	if (ret < 0 && ret != -ENODEV)
		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");

	ext_vrefin = ret != -ENODEV;
	st->vref_mV = ext_vrefin ? ret / 1000 : 1250;

Keeping (MICRO / MILLI) instead of 1000 is fine too. There are varying opinions
on this.

Or we could drop ext_vrefin and have:

	if (ret < 0 && ret != -ENODEV)
		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");

	if (ret != -ENODEV) {
		st->vref_mV = ret / 1000;

		/* regmap set bits goes here. */
		... 
	} else {
		st->vref_mV = 1250;
	}

> +
> +	if (ext_vrefin) {
> +		/*
> +		 * Configure the MAX14001/MAX14002 to use an external voltage reference source
> +		 * by setting the bit 5 of the configuration register
> +		 */
> +		ret = regmap_update_bits(st->regmap, MAX14001_REG_CFG, MAX14001_REG_CFG_BIT_EXRF, MAX14001_REG_CFG_BIT_EXRF);

Can be simplifed with regmap_set_bits().

> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to set External REFIN in Configuration Register\n");
> +	}

These lines are getting very long. We try to wrap to 80 characters
as much as we can in the IIO subsystem.

> +
> +	ret = max14001_disable_mv_fault(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to disable MV Fault\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id max14001_id_table[] = {
> +	{ "max14001", (kernel_ulong_t)&max14001_chip_info },
> +	{ "max14002", (kernel_ulong_t)&max14002_chip_info },
> +	{ }
> +};
> +
> +static const struct of_device_id max14001_of_match[] = {
> +	{ .compatible = "adi,max14001", .data = &max14001_chip_info },
> +	{ .compatible = "adi,max14002", .data = &max14002_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max14001_of_match);
> +
> +static struct spi_driver max14001_driver = {
> +	.driver = {
> +		.name = "max14001",
> +		.of_match_table = max14001_of_match,
> +	},
> +	.probe = max14001_probe,
> +	.id_table = max14001_id_table,
> +};
> +module_spi_driver(max14001_driver);
> +
> +MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
> +MODULE_AUTHOR("Marilene Andrade Garcia <marilene.agarcia@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices MAX14001/MAX14002 ADCs driver");
> +MODULE_LICENSE("GPL");


