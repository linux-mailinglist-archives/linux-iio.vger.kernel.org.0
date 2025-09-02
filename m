Return-Path: <linux-iio+bounces-23655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B156B40989
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D086D54549E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B58E3376B3;
	Tue,  2 Sep 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uRFzey+Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E132ED2F
	for <linux-iio@vger.kernel.org>; Tue,  2 Sep 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827874; cv=none; b=asvn2HBZeqLWpmnwIagOZ+lxHG93Ib61Itha+TapOUxrQW2V3gTAKrlcNwPHiAphk2UNNRVvIPoDqpH9CFmQu63PjtwqDU3L5ojN+9QwNrP9Bwui2EOPzzEbGkZCMHW7dWYWbFD4fFe56AqlW9ssBiuPawu3TlY4aTec6XYLXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827874; c=relaxed/simple;
	bh=c/sOlfEq2OA3IZtcXh3gz5AiRMiBPf2jLUCCS2VdNXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rt6bHHU4VhY9Xe782rcSpeghBpIVpconC35aJJuduLRv/68k62fMMXoR/vWUgNzVledk9UE6Efz+x3LqodJp3YRXwOSA2w8RV4+8aAdWxPfggmaR7YNDE3Fuj16g4wC1nDIrw7pZ3chHPzosJ+f0zPjSFWeDfTmRFCBUyP4NtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uRFzey+Q; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-315bab2917bso4013263fac.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Sep 2025 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756827871; x=1757432671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLE488gYyvEzSAPfgpQZfVUn1BUOU/Tj59M3I7iYh5Q=;
        b=uRFzey+Quh/Vij2k/PKpJgu6Hwrh/LmNdUdAByurAnTuX/yK1eW16ycYE40HIWu4OF
         N4U/V2O+qf9r1CpxSBScAHDd680asMPP4jXmIAPQTzSUfmxHdFcrsZUGWYW+6ycnfnjH
         EQCIZF9Pt4hpMts72wqDxzgAwvOXF4U8E+PHE2MSXIrayYbuNN96C0kMXb1zvZxqGWMZ
         6T/tRFwdArLghZQbtobvUD+5fV/NC4uYCxVVGdo/HxLXSlm9R9eWPf10q4OqZPJiXHjB
         +y/4eI0tRC7l4Q77XU/lg57tvoVbq6x1pR0D07TFMqeFX/n2aYVwybCN4I2NXEEc5UDO
         px9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827871; x=1757432671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLE488gYyvEzSAPfgpQZfVUn1BUOU/Tj59M3I7iYh5Q=;
        b=wHo26swI9mdM55e9z00meLbGUzWTW4Czm08C4rD6Pm7Eo1Mf3j0DBTVkrB1e0SuMoX
         rUGDysFSCtFwl1cbmBPd+lQmkpxGzW6yeHmjxVz88zvd9rqPIXkbrKgEfHNlMLwuvoAg
         WoDMO4rgw8qCGWWWN1zPdKx6QGYTwD0FHqiEN9tSwN3F2UcYhAmkdJQv1ITfA6VIV3D0
         cgdCMITMiyzL24rQlFWn+lWXmDFdMPxUR5Cur1pRQnOKDoHQwStUsywJOyTM6Lh6iqaU
         85o5Z15VLXHa5Rg3vIpm/TJNm3YYjwW6nxK0ppj8husexJxE4N1nRhdJTM3QKcs2PQ9b
         d/mg==
X-Forwarded-Encrypted: i=1; AJvYcCUqLkRsQdrVC2N7FaOseyg9QKHeClCBlhYAY8VsjJhld314C8B+45WNcI9OB7vpi0NUTT7kEr4n1AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNFPlvqeivQl6QxTSMI2b4q81/E/LFl8ZZe3hpnQ0Kqb2R5zJ
	/+UvH9grzdAADr43xXrfAqokq5IfWxHzF5UpGnmVWb38dJb/KxD85beaAz/KT2DPFnw=
X-Gm-Gg: ASbGncukde/ZFVUkxBSFKi3A0rfuI81TRatR0MFDkOd6AAVKQClIbc46quhseqa9pY7
	nF1hXVDULFUXBIS6O2exFyPoEuucBs5H70ln/aZM9WvylS+8d/1ZUDgMN6j9OfMXkB3KE+TJVyk
	OplkT9IXcqJ9Ef/mgWhJiN9StsVSuBannBcQWmRtyiWqSNPK85apXPKNCC7+XTZnKm4IrJ3YRhg
	jKfrSbM2eI6+Gpa9sU5yJJswdFx5QM/ikRkDCDBCXZ1jM062+MYeQo2jHQwA/MgbUvy/xhbgF8R
	b/+hFFT9rAmwkNTLwprYYFD0BJuw8p5ihbYgLIvpx2haGWqdal8Hk2+4XkSWVWPk+2nQXsI297U
	PA1wbEoFd2SAqbsKB5eK4+emMPzlPn1NAe2um958zqHiwl64bWY7WllupG2fhgUQUkinV70hLwD
	KB1ROZftk=
X-Google-Smtp-Source: AGHT+IGtL7a3am4zTG/4YAPeXYQVmoWmJ+eC7Hp+pGX9UujQFStTTLUxDFQoIiZSxdI1evU/yAj3tg==
X-Received: by 2002:a05:6871:5227:b0:30b:ae4c:2e82 with SMTP id 586e51a60fabf-31963364100mr5777995fac.12.1756827870648;
        Tue, 02 Sep 2025 08:44:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b? ([2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7457428c153sm1634614a34.8.2025.09.02.08.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:44:30 -0700 (PDT)
Message-ID: <525a44e7-8e38-48fd-af84-4c56a6a0ffe7@baylibre.com>
Date: Tue, 2 Sep 2025 10:44:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] iio: adc: max14001: New driver
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
 <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 8:16 AM, Marilene Andrade Garcia wrote:
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
> Co-developed-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/iio/adc/Kconfig    |  10 ++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max14001.c | 355 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 367 insertions(+)
>  create mode 100644 drivers/iio/adc/max14001.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f145f0204407..b6457063da6c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14976,6 +14976,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> +F:	drivers/iio/adc/max14001.c
>  
>  MAXBOTIX ULTRASONIC RANGER IIO DRIVER
>  M:	Andreas Klinger <ak@it-klinger.de>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e3d3826c3357..11e911ceab4c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -958,6 +958,16 @@ config MAX11410
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
>  config MAX1241
>  	tristate "Maxim max1241 ADC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 89d72bf9ce70..569f2f5613d4 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_MAX11100) += max11100.o
>  obj-$(CONFIG_MAX1118) += max1118.o
>  obj-$(CONFIG_MAX11205) += max11205.o
>  obj-$(CONFIG_MAX11410) += max11410.o
> +obj-$(CONFIG_MAX14001) += max14001.o
>  obj-$(CONFIG_MAX1241) += max1241.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MAX34408) += max34408.o
> diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> new file mode 100644
> index 000000000000..6755df152976
> --- /dev/null
> +++ b/drivers/iio/adc/max14001.c
> @@ -0,0 +1,355 @@
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
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitrev.h>
> +#include <linux/bits.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
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
> +#define MAX14001_REG_CFG_EXRF		BIT(5)
> +
> +#define MAX14001_MASK_ADDR		GENMASK(15, 11)
> +#define MAX14001_MASK_DATA		GENMASK(9, 0)
> +
> +#define MAX14001_SET_WRITE_BIT		BIT(10)
> +#define MAX14001_WRITE_WEN		0x294
> +
> +enum max14001_chip_model {
> +	max14001,
> +	max14002,
> +};
> +
> +struct max14001_chip_info {
> +	const char *name;
> +};
> +
> +struct max14001_state {
> +	const struct max14001_chip_info *chip_info;
> +	struct spi_device *spi;
> +	int vref_mv;
> +	/*
> +	 * lock protect against multiple concurrent accesses, RMW sequence,
> +	 * and SPI transfer.
> +	 */
> +	struct mutex lock;
> +	/*
> +	 * The following buffers will be bit-reversed during device
> +	 * communication, because the device transmits and receives data
> +	 * LSB-first.

Some SPI controllers may be able to handle LSB first without us having
to reverse things in the driver. Search the kernel for SPI_LSB_FIRST
to see what I mean.

By setting `spi-lsb-first;` in the devicetree, the core SPI code will
check if the controller supports it and let the hardare handle everything
so we don't need to reverse bits here in this driver.

If we need to make this work on a SPI controller that doesn't support
SPI_LSB_FIRST, then we should add something in the core SPI code that
does the reversing during __spi_optimize_message() so that every
peripheral driver doesn't have to do this. For example, search spi.c
for SPI_CS_WORD to see how it handles that flag for controllers that
don't support it.


> +	 * DMA (thus cache coherency maintenance) requires the transfer
> +	 * buffers to live in their own cache lines.
> +	 */
> +	__be16 spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
> +	__be16 spi_rx_buffer;
> +};
> +



> +static int max14001_probe(struct spi_device *spi)
> +{

...

> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"Failed to init the mutex\n");
> +

The only possible error here is -ENOMEM, which we don't
print messages for. So just `return ret;` on this one.

