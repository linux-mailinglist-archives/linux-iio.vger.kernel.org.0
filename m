Return-Path: <linux-iio+bounces-23859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C461CB47B6B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7940C17F49A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66723BD1F;
	Sun,  7 Sep 2025 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awHAGKLc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8D849C;
	Sun,  7 Sep 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757249227; cv=none; b=LviK7V6w5jAhWxsDU8arz0X0WMsb+pHFnUg3TMce9aVc3+p0Xmn5gISiwTc4ryl1sT+iyHC6b79EEqP0pXcNnbneCiORkzEwimLjnIRsN3pFxC9MtUu9hKzwWko2lUCHs2evAB6a3UlkrMrP1LbEb1egvEk/EEo0VUiXe32YTq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757249227; c=relaxed/simple;
	bh=DB4B5azk4XsSO2Tukk8lN7KdDxoABmlfJ1WiYV1u/ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa+yRJLbG8i/BnccEWcntgsIyNtRM9VDrR1kpA/sXYr9U9pY7S3KvjffZZk8Em7d1aRG8XGyJvxx46vcPyI1E/9C+svyUssJPJfuA+vy+89yT4RydS7kHLCc5HvNUl6qafknjjgwOR022GywqLVuKhGGobMmFoGcZHq2Xb9pwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awHAGKLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37935C4CEFA;
	Sun,  7 Sep 2025 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757249226;
	bh=DB4B5azk4XsSO2Tukk8lN7KdDxoABmlfJ1WiYV1u/ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=awHAGKLchZ+4L5gFSuECU28oj/IedeDedYAyh3/W5V9dDsV7cntkFt1qEbeQMHckc
	 x9LchGXkGIv01UzsgLMX2hrXHSkK+QHhADjBecCK7Yb/zbnp7DUM/rOxYvhtBGs4Wf
	 a4JXsVmCGysTVcsKizCud6C6H4fKWeG+zz3bF3p1YctKZra8RtBGs41fjfouAkppl5
	 wkWKyV2sx7oDPwL3goYNLVWclMoKypw3xpTKynzGp4ymKxVIXtagWyMjidkfzyOerV
	 rwufmoprUi4BxrHkGogo8U8SE60KZL6WNogHpwz+mH1jKV/PA1nj5JClTi1ZhtpEWk
	 JnNCU0q+7tWUw==
Date: Sun, 7 Sep 2025 13:46:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 04/10] iio: accel: BMA220 add i2c module
Message-ID: <20250907134659.19ad1cc7@jic23-huawei>
In-Reply-To: <20250901194742.11599-5-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-5-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 22:47:30 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add i2c module.
> Note that the kernel module transparently shifts all register addresses
> 1 bit to the left, so all functions will operate based on the SPI memory
> map.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Trivial comments inline

> diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2c.c
> new file mode 100644
> index 000000000000..8a1644aac287
> --- /dev/null
> +++ b/drivers/iio/accel/bma220_i2c.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Bosch triaxial acceleration sensor
> + *
> + * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
> + *
> + * Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA220.pdf
> + * I2C address is either 0x0b or 0x0a depending on CSB (pin 10)
> + */
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "bma220.h"
> +
> +static int bma220_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &bma220_i2c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "failed to create regmap\n");
> +		return PTR_ERR(regmap);

return dev_err_probe()

> +	}
> +
> +	return bma220_common_probe(&client->dev, regmap, client->irq);
> +}

> 


