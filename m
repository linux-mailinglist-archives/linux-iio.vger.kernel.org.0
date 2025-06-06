Return-Path: <linux-iio+bounces-20276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E421AD0724
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C681118999C5
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04A289356;
	Fri,  6 Jun 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cV32SNfp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09216193077
	for <linux-iio@vger.kernel.org>; Fri,  6 Jun 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229351; cv=none; b=epaLO6qS6EjSPHwyeo2q+2Yh+nJSayt1J0NI5DYcIFj2SCCFuh8Zeb/3zyU28Snp2lbAQOp4YDikadG1XQPoE+wQ0vUvf7ybjzQXw44CN4DTuWTLWOgiMDTa+kj5QoNopNJGKhRX9K56hllZrZcEfbtwzhbu63c1j9/4W3WPT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229351; c=relaxed/simple;
	bh=8qt/iLyzfLDt100yn+GEAy/R2dBCWnhApj2bMvTZOmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ay90zgV5xsvfwB+zf2iBFHZN0LZ/eq+4Cx+LfSg5VWbcfCL3eSJhYnIMcUwjMnMceAgHqsZWMKKivhI2sj4Z1VY8x1Hn+vJNiGumga1q7+pBN7kSoBmlknfENztWhvr/4ACGwfRqZ4GVzS0mUseWiJMyeI2VzFhE0ImsUiX7pPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cV32SNfp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a3db0666f2so48167571cf.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2025 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749229348; x=1749834148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Mr0Oa5vUe1PfY3eK/kBRVEAPyy1M+VggcMcOWiELWk=;
        b=cV32SNfpisG3unQj+b2h5pMGRuwJh+jLoZyLb1Mnt/X9Yphecsq16KtMw3kgnQG/lb
         0ARO/sFRV8pb4qhD8oEk+L467U6dNhxRs1DC5sx6/Gct9Cmg/N26Kbit8yTr2UnbrEOo
         fwpVuhRsW2x9k1QkBfZhTFZqBnAaARCmpBRgUh7UOUqSp56NsxZTCvO9CA6qak5Evahz
         Y3ALOwnoAtKnqgryrD8p4xGkql2Z7ocpGHieCegc8cBit+Cydydf7dwq67mfBRDzKnuy
         BUTzA7Xufhidz1a7q21UU9p6A4pYQqobjhRjErUOojTrRgv834dURVkQLRdskt+2K74S
         Tlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749229348; x=1749834148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Mr0Oa5vUe1PfY3eK/kBRVEAPyy1M+VggcMcOWiELWk=;
        b=KMiKeoicwErzCDKoWW9aqtjDEe6qD+GKzcOnWx6j429sXHKoQ0LW50OzWxdjVZJEtI
         meyolvI64fncO/QQ0oNX3B3LfzizHm3x5ANmK+Zi5Txf4bfcizyCd90P+0eWnHzt1VKO
         ayqCILLYsh6nK5SE7X7DO8N2418ZU+xywXtuCWG7ZHsOlozvWTj42LyRldiUVlhQG4TP
         YMVQDWkB4xOMTIVEN/+8AxLYTj77b1jFpoO4iDlwOUDY5ri35mO1DizxhTQBW3KW7QZA
         fbMQWSb8RFhS7V4Kyjm/4wB2L1T45RQNchr/rQ48tBK4xO8FAIMyIyWeVUwStT1cqPkB
         U+sA==
X-Forwarded-Encrypted: i=1; AJvYcCW+1N2FKA90M0Opsy3rl2RC+wkwe8wT832tdhMK2UvOhZR8NmWpf2JcU9F4SylxLQyTu+Q75RSnRXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIafxnBi/y+kR5xevmZrif7Q8NnmYtgeJiI7O1FBu/ySUtzeK5
	Jz6SGPcBe81I2mpUVWJjkPuuFBAkFvcxFEt/1b8nQxeFCE7bkAQGO5rGfzeyJoyp9qAGCWqULPy
	zcGQ8
X-Gm-Gg: ASbGnctEzfRwwTa9htBURZn/LE/XBMgTl9e0Cvan4xu8LKxQrZq9zamFY92KTn3QWbv
	/nXaEUok2mT07382OipfuUu7BMCpIiA5IfTGCa7NiTJQ2HZweCS+TjocvK79clg4iTiU9ENOR8d
	oxSV4f+c38tBw4MroHU/ZXFHct/MIP3+2QtqDUB30HQMUbLy82/bzw2NQTDjvdmKPsK7NaXt9GR
	ZBLpWBqhvelcGiHkHm1xIzK2rdTRekOFXmZcMuQjjSy/wvCY6s4kZI9NTQFNTlZjWvYP1RsgZ2o
	jQtskyDkv2/GMXF9wO9JEYt6oquKvPINQwS0hH7/byUB7cz8KuQsJtSXB3oVLOGJP5cw57ePXTl
	5aV6e3I+xIi0kzolOa5dq1lu+XqIz
X-Google-Smtp-Source: AGHT+IE8NoJHBpKyQCe+BPQgFALY795TjOAYV9ePcJVb7TZvrIeAjd7HqD+Oh7oqXl2SCsJ3B0zv3w==
X-Received: by 2002:a05:6808:2e46:b0:408:e05e:fb47 with SMTP id 5614622812f47-409051e72ccmr2766412b6e.13.1749229336530;
        Fri, 06 Jun 2025 10:02:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:6192:9921:d60e:1609? ([2600:8803:e7e4:1d00:6192:9921:d60e:1609])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40906a2e417sm382344b6e.49.2025.06.06.10.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 10:02:15 -0700 (PDT)
Message-ID: <1c7946f1-d712-4baa-8243-be6a55eec528@baylibre.com>
Date: Fri, 6 Jun 2025 12:02:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for PAC194X
To: marius.cristea@microchip.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 broonie@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250606093929.100118-1-marius.cristea@microchip.com>
 <20250606093929.100118-3-marius.cristea@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250606093929.100118-3-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 4:39 AM, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip PAC194X and PAC195X series of
> Power Monitors with Accumulator. The PAC194X family supports 9V
> Full-Scale Range and the PAC195X supports 32V Full-Scale Range.
> 
> There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices
> are for high-side current sensing and the PAC194X/5X-2 devices are
> for low-side current sensing or floating VBUS applications. The
> PAC194X/5X-1 is named shortly PAC194X/5X.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-pac1944     |   17 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   12 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/pac1944.c                     | 2841 +++++++++++++++++

Oof. Very hard to make a review of something this big. Is it possible
to break it down into more patches? e.g. start with just the basic
functionality, then add the accumulator in a separate patch, add events
in a separate patch, etc. It's not always possible, but 500 lines per
patch is a nice number to aim for.


>  5 files changed, 2878 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
>  create mode 100644 drivers/iio/adc/pac1944.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> new file mode 100644
> index 000000000000..ae88eac354a4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> @@ -0,0 +1,17 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/slow_alert1_cfg
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read/write property used to route, inside the PAC device, a specific ALERT
> +		signal to the SLOW/ALERT1 pin. The SLOW/ALERT1 pin must be configured for the
> +		ALERT function in order to control the device hardware pin (this is the default
> +		functionality of the device hardware pin).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/gpio_alert2_cfg
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read/write property used to route, inside the PAC device, a specific ALERT
> +		signal to the GPIO/ALERT2 hardware pin. The GPIO/ALERT2 pin must be configured
> +		for ALERT function in order to control the device hardware pin (this is the
> +		default	functionality of the device hardware pin).


What is the use case for needing these? In otherwords, why can't the driver just
make best use of available resources as it sees fit?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86a2045ba62e..240e84893ad9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15920,6 +15920,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
>  F:	drivers/iio/adc/pac1934.c
>  
> +MICROCHIP PAC1944 ADC DRIVER
> +M:	Marius Cristea <marius.cristea@microchip.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported

Missing the ABI docs, but hopefuly we can get rid of that.

> +F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> +F:	drivers/iio/adc/pac1944.c
> +
>  MICROCHIP PCI1XXXX GP DRIVER
>  M:	Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
>  M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 186a453af56c..a608aa6cb9c7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1148,6 +1148,18 @@ config PAC1934
>  	  This driver can also be built as a module. If so, the module
>  	  will be called pac1934.
>  
> +config PAC1944
> +	tristate "Microchip Technology PAC1944/PAC1954 driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Microchip Technology's PAC1941,
> +	  PAC1941-2, PAC1942, PAC1942-2, PAC1943, PAC1944, PAC1951,
> +	  PAC1951-2, PAC1952, PAC1952-2, PAC1953, PAC1954
> +	  Single/Multi-Channel Power Monitor with Accumulator.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pac1944.
> +
>  config PALMAS_GPADC
>  	tristate "TI Palmas General Purpose ADC"
>  	depends on MFD_PALMAS
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 09ae6edb2650..ee47d880babf 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -103,6 +103,7 @@ obj-$(CONFIG_NCT7201) += nct7201.o
>  obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>  obj-$(CONFIG_PAC1921) += pac1921.o
>  obj-$(CONFIG_PAC1934) += pac1934.o
> +obj-$(CONFIG_PAC1944) += pac1944.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>  obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
> diff --git a/drivers/iio/adc/pac1944.c b/drivers/iio/adc/pac1944.c
> new file mode 100644
> index 000000000000..ce09334b076a
> --- /dev/null
> +++ b/drivers/iio/adc/pac1944.c
> @@ -0,0 +1,2841 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for PAC194X and PAC195X series chips
> + *
> + * Copyright (C) 2022-2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Marius Cristea marius.cristea@microchip.com
> + *
> + * Datasheet for PAC1941, PAC1942, PAC1943 and PAC1944 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
> + * Datasheet for PAC1951, PAC1952, PAC1953 and PAC1954 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/unaligned.h>

This seems incomplete. Expecting at least linux/module.h, linux/property.h, etc.


> +
> +static const struct pac1944_features pac1944_chip_config[] = {

I know there are lots of existing drivers that use arrays like this, but
it just makes lots of extra code to read without any practial benifits.

Better is to just make standalone structs for each chip.

> +	/* PAC194X Family */
> +	[PAC1941] = {
> +		.phys_channels = 1,
> +		.prod_id = PAC_PRODUCT_ID_1941,
> +		.name = "pac1941",
> +	},
> +	[PAC1942] = {
> +		.phys_channels = 2,
> +		.prod_id = PAC_PRODUCT_ID_1942,
> +		.name = "pac1942",
> +	},
> +	[PAC1943] = {
> +		.phys_channels = 3,
> +		.prod_id = PAC_PRODUCT_ID_1943,
> +		.name = "pac1943",
> +	},
> +	[PAC1944] = {
> +		.phys_channels = 4,
> +		.prod_id = PAC_PRODUCT_ID_1944,
> +		.name = "pac1944",
> +	},
> +	[PAC1941_2] = {
> +		.phys_channels = 1,
> +		.prod_id = PAC_PRODUCT_ID_1941_2,
> +		.name = "pac1941_2",
> +	},
> +	[PAC1942_2] = {
> +		.phys_channels = 2,
> +		.prod_id = PAC_PRODUCT_ID_1942_2,
> +		.name = "pac1942_2",
> +	},
> +	/* PAC195X Family */
> +	[PAC1951] = {
> +		.phys_channels = 1,
> +		.prod_id = PAC_PRODUCT_ID_1951,
> +		.name = "pac1951",
> +	},
> +	[PAC1952] = {
> +		.phys_channels = 2,
> +		.prod_id = PAC_PRODUCT_ID_1952,
> +		.name = "pac1952_1",

Odd that this is the only one to have _1.

> +	},
> +	[PAC1953] = {
> +		.phys_channels = 3,
> +		.prod_id = PAC_PRODUCT_ID_1953,
> +		.name = "pac1953",
> +	},
> +	[PAC1954] = {
> +		.phys_channels = 4,
> +		.prod_id = PAC_PRODUCT_ID_1954,
> +		.name = "pac1954",
> +	},
> +	[PAC1951_2] = {
> +		.phys_channels = 1,
> +		.prod_id = PAC_PRODUCT_ID_1951_2,
> +		.name = "pac1951_2",
> +	},
> +	[PAC1952_2] = {
> +		.phys_channels = 2,
> +		.prod_id = PAC_PRODUCT_ID_1952_2,
> +		.name = "pac1952_2",
> +	},
> +};
> +

...

> +static IIO_DEVICE_ATTR(in_current1_shunt_resistor, 0644,
> +		       pac1944_shunt_value_show, pac1944_shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(in_current2_shunt_resistor, 0644,
> +		       pac1944_shunt_value_show, pac1944_shunt_value_store, 1);
> +static IIO_DEVICE_ATTR(in_current3_shunt_resistor, 0644,
> +		       pac1944_shunt_value_show, pac1944_shunt_value_store, 2);
> +static IIO_DEVICE_ATTR(in_current4_shunt_resistor, 0644,
> +		       pac1944_shunt_value_show, pac1944_shunt_value_store, 3);

These are specified in the devicetree. Why are there also sysfs attribtes?

> +
> +static IIO_DEVICE_ATTR(slow_alert1_cfg, 0644, pac1944_slow_alert1_show,
> +		       pac1944_slow_alert1_store, 0);
> +static IIO_DEVICE_ATTR(gpio_alert2_cfg, 0644, pac1944_gpio_alert2_show,
> +		       pac1944_gpio_alert2_store, 0);
> +

...

> +static int pac1944_frequency_get(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +
> +	return info->sampling_mode;
> +}

Pulled this out of order for context:

> +/* Available Sample Modes */
> +static const char * const pac1944_frequency_avail[] = {
> +	"1024_ADAP",
> +	"256_ADAP",
> +	"64_ADAP",
> +	"8_ADAP",
> +	"1024",
> +	"256",
> +	"64",
> +	"8",
> +	"single_shot_1x",
> +	"single_shot_8x",
> +	"fast",
> +	"burst",
> +};

> +
> +static const struct iio_enum sampling_mode_enum = {
> +	.items = pac1944_frequency_avail,
> +	.num_items = ARRAY_SIZE(pac1944_frequency_avail),
> +	.set = pac1944_frequency_set,
> +	.get = pac1944_frequency_get,
> +};
> +
> +static const struct iio_chan_spec_ext_info pac1944_ext_info[] = {
> +	IIO_ENUM("sampling_frequency", IIO_SHARED_BY_ALL, &sampling_mode_enum),
> +	{
> +		.name = "sampling_frequency_available",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = iio_enum_available_read,
> +		.private = (uintptr_t)&sampling_mode_enum,
> +	},
> +	{ }
> +};

sampling_frequency{_avialable} are already standard attributes in IIO and is
defined to be a number in Hz. So we will need to find a way to make this
work with the standard attribute (can use IIO_CHAN_INFO_SAMPLE_FREQ, by the way).
And figure out how the other parts fit into other existing IIO features.


> +
> +static int pac1944_of_parse_channel_config(struct i2c_client *client,
> +					   struct pac1944_chip_info *info)
> +{
> +	unsigned int current_channel;
> +	struct device *dev = &client->dev;
> +	int idx, ret, temp;
> +	bool is_bipolar, is_half_fsr;
> +
> +	current_channel = 1;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "reading invalid channel index\n");
> +
> +		/* adjust idx to match channel index (1 to 4) from the datasheet */
> +		idx--;
> +
> +		if (current_channel >= (info->phys_channels + 1) ||
> +		    idx >= info->phys_channels || idx < 0)
> +			return dev_err_probe(dev, -EINVAL, "invalid channel index %d value\n",
> +					     idx + 1);
> +
> +		/* enable channel */
> +		set_bit(idx, &info->active_channels_mask);
> +
> +		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms",
> +					       &info->shunts[idx]);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: invalid shunt-resistor value: %d\n",
> +					     fwnode_get_name(child), info->shunts[idx]);

If there is an error, then info->shunts[idx] is not set, so doesn't make sense to include
it in the error message.

> +
> +		if (fwnode_property_present(child, "label"))

No point in checking if property is present if not checking the return value of
read_string()

> +			fwnode_property_read_string(child, "label",
> +						    (const char **)&info->labels[idx]);
> +
> +		is_bipolar = false;
> +		if (fwnode_property_present(child, "microchip,vbus-bipolar"))
> +			is_bipolar = true;

Just do:

		is_bipolar = fwnode_property_read_bool(child, "microchip,vbus-bipolar");

> +
> +		is_half_fsr = false;
> +		if (fwnode_property_present(child, "microchip,vbus-half-range"))
> +			is_half_fsr = true;


ditto

> +
> +		/* default value is unipolar and Full Scale Range */
> +		info->chip_reg_data.vbus_mode[idx] = PAC1944_UNIPOLAR_FSR_CFG;
> +		if (is_half_fsr)
> +			info->chip_reg_data.vbus_mode[idx] = PAC1944_BIPOLAR_HALF_FSR_CFG;
> +		else if (is_bipolar)
> +			info->chip_reg_data.vbus_mode[idx] = PAC1944_BIPOLAR_FSR_CFG;
> +
> +		is_bipolar = false;
> +		if (fwnode_property_present(child, "microchip,vsense-bipolar"))
> +			is_bipolar = true;
> +
> +		is_half_fsr = false;
> +		if (fwnode_property_present(child, "microchip,vsense-half-range"))
> +			is_half_fsr = true;
> +
> +		/* default value is unipolar and Full Scale Range */
> +		info->chip_reg_data.vsense_mode[idx] = PAC1944_UNIPOLAR_FSR_CFG;
> +		if (is_half_fsr)
> +			info->chip_reg_data.vsense_mode[idx] = PAC1944_BIPOLAR_HALF_FSR_CFG;
> +		else if (is_bipolar)
> +			info->chip_reg_data.vsense_mode[idx] = PAC1944_BIPOLAR_FSR_CFG;
> +
> +		ret = fwnode_property_read_u32(child, "microchip,accumulation-mode", &temp);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "invalid accumulation-mode value on %s\n",
> +					     fwnode_get_name(child));
> +		if (temp == PAC1944_ACCMODE_VPOWER ||
> +		    temp == PAC1944_ACCMODE_VSENSE ||
> +		    temp == PAC1944_ACCMODE_VBUS) {
> +			dev_dbg(dev, "Accumulation{%d} mode set to: %d\n", idx, temp);
> +			info->chip_reg_data.accumulation_mode[idx] = temp;
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid mode for accumulator value on %s\n",
> +					     fwnode_get_name(child));
> +		}
> +		current_channel++;
> +	}
> +
> +	return 0;
> +}

...

> +
> +static const struct i2c_device_id pac1944_id[] = {
> +	{ .name = "pac1941", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1941] },
> +	{ .name = "pac19412", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1941_2] },
> +	{ .name = "pac1942", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1942] },
> +	{ .name = "pac19422", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1942_2] },
> +	{ .name = "pac1943", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1943] },
> +	{ .name = "pac1944", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1944] },
> +	{ .name = "pac1951", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1951] },
> +	{ .name = "pac19512", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1951_2] },
> +	{ .name = "pac1952", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1952] },
> +	{ .name = "pac19522", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1952_2] },
> +	{ .name = "pac1953", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1953] },
> +	{ .name = "pac1954", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1954] },

Drop the .name and .driver_data here. Thre is an effort to do this in all drivers so that
we can eventually get rid of the (kernel_ulong_t) casts.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pac1944_id);
> +



