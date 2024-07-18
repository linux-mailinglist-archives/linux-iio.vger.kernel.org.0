Return-Path: <linux-iio+bounces-7676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36260934D49
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5304F1C20C53
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6F13C660;
	Thu, 18 Jul 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR3H4Frr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB540875;
	Thu, 18 Jul 2024 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306145; cv=none; b=HtnjDHi2g71BxZzkK2dpQkr4vW0K2/r9ujyleqApIi3JKK6ofVhbUgkMl2uzscClsP8v0JeDlPu3mfmvk2DokgyuK9togaYGTM/Fo/2BFnFGRdsSPko3ANbT0mxt2xQievx4YdGSbjzV7rvoZphgExleztAOmjx2y7CCNFpSXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306145; c=relaxed/simple;
	bh=6nI+uT4LTwworj3RjtEM+71Pi96fMZHfOe8NOV/l2Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PqCDfeeNPdOEwMCXdP5oMs/Q7LlaCB2a6KsUpq77SoZLlxFatYf9wgyTkC8D7SdYiSzljeJSbkG3QdSuwS0gNk44SnrWjsle/toAQjTxsH7qPYTM/awS3I8J3odAuIxxdKQDusnFt7cjtaHdXmG/I1xxoaNJC64xKlNVIjYF4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR3H4Frr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C24FC116B1;
	Thu, 18 Jul 2024 12:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721306144;
	bh=6nI+uT4LTwworj3RjtEM+71Pi96fMZHfOe8NOV/l2Hg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tR3H4FrrcfouyGFb3xYc558pQYuT5+5rhSdE7KetuMrwLNSVCY1QyxVYXj5Jog8EG
	 s1EKkqVMiYjNDSamPE2n2e1a9JmnpNqpgjT2apkrwuCeblkW3ECyxs5uLfbUWbi7fN
	 v0rtOB7sqPQk1vbiIZ8BSDQe5F4fX+WQPZDy9OnitBr8u+in5LRVcHNcwyK7nqyHQD
	 O47xfWFtu8dZX4N1n9B51nVc0DRwLL5eAwekHYmfEZL3ydu3hrqimdIAZkpUaWryPM
	 HfFcx/zZmIalsWUzNQw3oNoB2tPUg9O+1otzU1H9Z2Sirc1kvtFIW5WOWIseZbhzQ8
	 qYG64S20wrixw==
Message-ID: <73cf8ac8-932b-44cf-88b8-6a175bcff8cb@kernel.org>
Date: Thu, 18 Jul 2024 14:35:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: Bosch SMI240 IMU Driver
To: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
 Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
References: <20240718122449.7607-1-Jianping.Shen@de.bosch.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240718122449.7607-1-Jianping.Shen@de.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2024 14:24, Jianping.Shen@de.bosch.com wrote:
> From: "Shen Jianping (ME-SE/EAD2)" <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> 
> Add Bosch SMI240 IMU IIO Driver to iio-for-6.10b

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters


> 
> Signed-off-by: Shen Jianping (ME-SE/EAD2) <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> ---
>  .../bindings/iio/imu/bosch,smi240.yaml        |  45 +

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.


>  drivers/iio/imu/Kconfig                       |   2 +
>  drivers/iio/imu/Makefile                      |   1 +
>  drivers/iio/imu/smi240/Kconfig                |  30 +
>  drivers/iio/imu/smi240/Makefile               |   8 +
>  drivers/iio/imu/smi240/smi240.h               |  31 +
>  drivers/iio/imu/smi240/smi240_core.c          | 814 ++++++++++++++++++
>  drivers/iio/imu/smi240/smi240_spi.c           | 153 ++++
>  8 files changed, 1084 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
>  create mode 100644 drivers/iio/imu/smi240/Kconfig
>  create mode 100644 drivers/iio/imu/smi240/Makefile
>  create mode 100644 drivers/iio/imu/smi240/smi240.h
>  create mode 100644 drivers/iio/imu/smi240/smi240_core.c
>  create mode 100644 drivers/iio/imu/smi240/smi240_spi.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> new file mode 100644
> index 00000000000..972819cacff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BOSCH SMI240
> +
> +maintainers:
> +  - unknown

You need person responsible for this. Otherwise why would we care?



> +
> +description: |
> +  Inertial Measurement Unit with Accelerometer, Gyroscope 
> +  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-driving/smi240/
> +
> +properties:
> +  compatible:
> +    const: BOSCH,SMI240

Nope, no uppercase. Do you see any posting like that?


> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - spi-max-frequency

Why?

> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example

Drop

> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        smi240@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "BOSCH,SMI240";
> +            spi-max-frequency = <10000000>;
> +            reg = <0>;

Please order the properties according to DTS coding style:
https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

...

> +
> +#ifndef _SMI240_H
> +#define _SMI240_H
> +
> +#define SENSOR_NAME    "SMI240"
> +#define DRIVER_VERSION "1.0.0"

No, drop.

> +
> +#define SET_BITS(reg_var, bitname, val)                                        \
> +	(((reg_var) & ~(bitname##_MASK)) |                                     \
> +	 (((val) << bitname##_POS) & bitname##_MASK))

Drop, use generic macros

> +
> +#define GET_BITS(reg_var, bitname)                                             \
> +	(((reg_var) & (bitname##_MASK)) >> (bitname##_POS))

Drop, use generic macros


> +
> +struct smi240_device {
> +	uint16_t accel_filter_freq;
> +	uint16_t anglvel_filter_freq;
> +	uint16_t sign_of_channels;
> +	uint8_t bite_reps;
> +	int8_t (*xfer)(uint32_t request, uint32_t *data);
> +};


...


> +
> +int smi240_probe(struct device *dev, struct smi240_device *smi240_dev)
> +{
> +	int ret;
> +	int16_t response;
> +	struct iio_dev *indio_dev;
> +
> +	ret = smi240_get_regs(SMI240_CHIP_ID_REG, &response, 1, 0, smi240_dev);
> +	if (ret) {
> +		pr_err("Read chip id failed.");

Uhu... drivers use dev_err. This applies everywhere.


> +		return ret;
> +	}
> +
> +	if (response == SMI240_CHIP_ID) {
> +		pr_info("SMI240 Chip ID: 0x%04x", response);

Drop

> +	} else {
> +		pr_err("Unexpected Chip ID for SMI240: 0x%04x", response);
> +		return -ENODEV;
> +	}
> +
> +	ret = smi240_soft_reset(smi240_dev);
> +	if (ret) {
> +		pr_err("Soft Reset failed.");
> +		return ret;
> +	}
> +
> +	ret = smi240_init(smi240_dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, 0);
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	iio_device_set_drvdata(indio_dev, smi240_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = smi240_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(smi240_channels);
> +	indio_dev->name = SENSOR_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &smi240_info;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Register IIO device failed");
> +		goto exit_failure;
> +	}
> +
> +	return ret;
> +
> +exit_failure:
> +	smi240_remove(dev);
> +	return ret;
> +}
> +
> +int smi240_remove(struct device *dev)
> +{
> +	dev_info(dev, "unregister SMI240");

Drop

> +	return 0;
> +}
> diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240/smi240_spi.c
> new file mode 100644
> index 00000000000..2be6320eaba
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_spi.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <generated/uapi/linux/version.h>
> +
> +#include "smi240.h"
> +
> +#define SMI240_SPI_MAX_BUFFER_SIZE 32
> +
> +static uint8_t *rx_buf;
> +static uint8_t *tx_buf;

No, drop

> +static struct spi_device *smi240_spi_dev;
> +static struct smi240_device smi240_dev;

No, drop all. No file-scope variables. How do you support two devices?

> +
> +static int8_t smi240_spi_transfer(uint32_t request, uint32_t *response)
> +{
> +	int8_t ret;
> +	struct spi_message msg;
> +	struct spi_transfer xfer = {
> +		.tx_buf = tx_buf, .rx_buf = rx_buf, .len = 4,
> +		//.bits_per_word = 32,
> +	};
> +
> +	if (smi240_spi_dev == NULL)
> +		return -ENODEV;
> +
> +	tx_buf[0] = request >> 24;
> +	tx_buf[1] = request >> 16;
> +	tx_buf[2] = request >> 8;
> +	tx_buf[3] = request;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +	ret = spi_sync(smi240_spi_dev, &msg);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (response != NULL)
> +		*response = (rx_buf[0] << 24) | (rx_buf[1] << 16) |
> +			    (rx_buf[2] << 8) | rx_buf[3];
> +
> +	return ret;
> +}
> +
> +static int smi240_spi_probe(struct spi_device *device)

This is never called "device"

> +{
> +	int err;
> +
> +	device->bits_per_word = 8;
> +	device->max_speed_hz = 10000000;
> +	device->mode = SPI_MODE_0;
> +
> +	err = spi_setup(device);
> +	if (err < 0) {
> +		pr_err("spi_setup err!\n");

Oh, no need to scream.

> +		return err;
> +	}
> +
> +	if (rx_buf == NULL)

WTF?

> +		rx_buf = kmalloc(4, GFP_KERNEL);

What the hell is 4?

> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	if (tx_buf == NULL)
> +		tx_buf = kmalloc(4, GFP_KERNEL);

Why none of these are devm?

> +	if (!tx_buf)
> +		return -ENOMEM;
> +
> +	smi240_spi_dev = device;
> +
> +	err = smi240_probe(&device->dev, &smi240_dev);
> +	if (err) {
> +		kfree(rx_buf);
> +		rx_buf = NULL;
> +		kfree(tx_buf);
> +		tx_buf = NULL;
> +		smi240_spi_dev = NULL;

What are these? What error handling is this? Sorry, this code is
absolutely ugly. Why this cannot be devm?

> +		dev_err(&device->dev,
> +			"Bosch Sensor Device %s initialization failed %d",
> +			SENSOR_NAME, err);
> +	} else
> +		dev_info(&device->dev, "Bosch Sensor Device %s initialized",
> +			 SENSOR_NAME);

No drop

> +
> +	return err;
> +}
> +
> +static void smi240_spi_remove(struct spi_device *device)
> +{
> +	if (rx_buf != NULL) {

??? Drop, useless

> +		kfree(rx_buf);

> +		rx_buf = NULL;

Why? What the heck is this?

> +	}
> +
> +	if (tx_buf != NULL) {
> +		kfree(tx_buf);
> +		tx_buf = NULL;
> +	}
> +	smi240_remove(&device->dev);
> +}
> +
> +static const struct spi_device_id smi240_id[] = { { SENSOR_NAME, 0 }, {} };
> +
> +MODULE_DEVICE_TABLE(spi, smi240_id);
> +
> +static const struct of_device_id smi240_of_match[] = {
> +	{
> +		.compatible = SENSOR_NAME,

No clue what's that, but that's a strong NAK.

There is no such code. NOWWHERE. Please do not invent your own, Bosch,
style.

> +	},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, smi240_of_match);
> +
> +static struct spi_driver smi240_driver = {
> +	.driver = {
> +		   .owner = THIS_MODULE,

Don't upstream some ancient code.

This contribution lacks basic review and does not follow basic
guidelines. Please carefully read submitting patches and coding style
before posting.

Be sure your driver has no W=1 warnings, nothing from
coccinelle/coccicheck, smatch and sparse.

Also, you shou;d have zero warnigns from checkpatch --strict


> +		   .name = SENSOR_NAME,
> +		   .of_match_table = smi240_of_match,
> +		    },
> +	.id_table = smi240_id,
> +	.probe = smi240_spi_probe,
> +	.remove = smi240_spi_remove,
> +};
> +
> +static int __init smi240_module_init(void)
> +{
> +	int err = 0;
> +
> +	smi240_dev.xfer = smi240_spi_transfer;
> +
> +	err |= spi_register_driver(&smi240_driver);
> +	return err;

Drop err, useless. Just return.

> +}
> +
> +static void __exit smi240_module_exit(void)
> +{
> +	spi_unregister_driver(&smi240_driver);
> +}
> +
> +module_init(smi240_module_init);
> +module_exit(smi240_module_exit);
> +
> +MODULE_DESCRIPTION("SMI240 IMU SENSOR DRIVER");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_VERSION(DRIVER_VERSION);

No, drop.

Best regards,
Krzysztof


