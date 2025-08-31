Return-Path: <linux-iio+bounces-23546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE39B3D46E
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9397A9EE6
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E7B2AD20;
	Sun, 31 Aug 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW0n5dOf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1A22256B;
	Sun, 31 Aug 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756658800; cv=none; b=accMbbKMHxoPzKVdMfrVbuMQ4VfHOU+f8fUYz8ZRghtcVKYVoOBzSM2b1fMT7B0/GdoMm3rRAsN6JwljVuV55uoIFUFoukm/9SIOIp4AoeYRanzM2tiEDbfH+n/slmXEtMWSXgrAKwCtmYLoaHI8Cedg/inTPC+SGybtrN4is0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756658800; c=relaxed/simple;
	bh=gQAuKPf3b1o9ZUpfIS7MOWN5FtN7rX6deBatuVThnzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqvvcCJt8OEn6NlprXdrRpGzV/cSgWR1Nb0BAT0wISemwisItxDUwFeFHIMxRgzRXWW+pI0ARvbz7gZEVqPzTxxjMLBCMVWCoRblfQXYDx0YF9NSmdo6m1JTtaSUfovb3lGBPZEHZEuVqgeaawHAgzfAxee2ZFpt42uMyE0W8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW0n5dOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4CDC4CEED;
	Sun, 31 Aug 2025 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756658800;
	bh=gQAuKPf3b1o9ZUpfIS7MOWN5FtN7rX6deBatuVThnzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VW0n5dOfUIqVVnwyReUugGsXpgohvNaZZk20jL+WR2nHnKK+rV67BdP9G3BWemguP
	 iTZ2f9K6rv0PXqHTBuiMx7rhyUK3dNq3EUOyWZnoKG0exTrRLICZSSWat2qgxYWVmX
	 LRc2fhpbTCi40qsdTQTBecH5iAhwk3MP6dTybuOy6wzPD9oPwtqatH0VpldReDFJZ3
	 nBA/0QnG33GoBvGHcHngiqK6T0wyYnHVSd4ZbEkOYc9QEaHjqtnzDi70bQWhGzOlb+
	 RSin7iboDCoyNtnASRJqo9fCXSSccOHHEIyxohYgJRBZdWpEP4ZSNzFdy/Vo/YDhAw
	 g7ncVWpDFe0DA==
Message-ID: <72c3ae7d-cb54-4a1b-a27a-9e673ffaddcc@kernel.org>
Date: Sun, 31 Aug 2025 18:46:32 +0200
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
 linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
 gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, peterz@infradead.org,
 jstephan@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, jonathan.cameron@huawei.com,
 akpm@linux-foundation.org, chao@kernel.org, jaegeuk@kernel.org
Cc: vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
References: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
 <20250827103105.2472328-2-lakshay.piplani@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250827103105.2472328-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2025 12:31, Lakshay Piplani wrote:
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


...

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

Now I wonder why regmap does not handle your data format?

> +}
> +
> +static int p3t1755_trigger_one_shot(struct p3t1755_data *data)
> +{
> +	unsigned int config;
> +	int ret;
> +
> +	mutex_lock(&data->lock);

Just use guard.

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


...


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

Pretty useless, static coming from DT :/

> +
> +	chip = i2c_get_match_data(client);
> +
> +	dev_dbg(&client->dev, "Registering p3t175x temperature sensor");

Drop

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

No need for {}

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
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register IBI free action\n");
> +
> +	dev_dbg(&i3cdev->dev, "IBI successfully registered\n");

You really should not need this. You already have one probe debug.


Best regards,
Krzysztof

