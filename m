Return-Path: <linux-iio+bounces-12068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C169C2D80
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973FBB21400
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4BE18EFC1;
	Sat,  9 Nov 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdQl9hCm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888B233D6B;
	Sat,  9 Nov 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731158176; cv=none; b=fJkInRB3+vZxPDzb23rwxTEERqxx6HuvzBY3Fza0/TXAd5cX7HcR7Ngy2iXCewYqbh00oYSFF4nErd/lgc/T9SfQ/plU/VeCPEv1xgyyPXQ0zr38pRdvunk0RuCQF5Jm8L5PbipKZdQhMCeJ6m6pYMxn9feIkk8VJ+SngIFxGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731158176; c=relaxed/simple;
	bh=W8bqZLpt4rrtBzLA5A6KOuK7kihkpV/PaF/68GqkGYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fo26iZBjfkaauRSiJkqzHvaxFJ2TXWlGpu9JRI9+X/4P96kbirdbIuWm7go+UTnhpvrakBo6bJDfDz+TbrR7c87EZcx0SNoN5Y1J8Hw5V9X22BHQOYoCZkDz2gon/rpObnlG3zrUhC+62oUNK48YC+ZoujCsDNuQ5u5HojYO+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdQl9hCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9964C4CECE;
	Sat,  9 Nov 2024 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731158176;
	bh=W8bqZLpt4rrtBzLA5A6KOuK7kihkpV/PaF/68GqkGYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jdQl9hCmLhD1qtr2s0+I48Op0yghNG8fgHQw7ehzVh+/6TSFo7sX8tGvLkuuHLmxZ
	 2Dmi/0WNBxgljjxrnYXnJ3l+MJvEhLEPQqIwPx7LkA3mPIbTv/jRiwilWJsEQK5dWk
	 bse3kCWLGmJwThuqA6axk5wAOyw0SM1wKe/Fx7BFEZ7lWT3a5zKBx5vmLv2mb1aIur
	 aPkJ1U4609C9BbexDRUyPyK+tIW3DKLw8e8wiorkzwQ863UgLCUdy+Wbyn0U9LP8I2
	 RDEr/ZNvW/Ar2FaYA7Wk9qpw6xbsj4IZS8+UrqUl+SCLzC6owZvh7GU1IH9+IPz/pX
	 OhG/J3lDZMCow==
Date: Sat, 9 Nov 2024 13:16:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Krzysztof
 Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hwmon: tmp108: Add support for I3C device
Message-ID: <20241109131604.5d8b701a@jic23-huawei>
In-Reply-To: <20241108-p3t1085-v2-3-6a8990a59efd@nxp.com>
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
	<20241108-p3t1085-v2-3-6a8990a59efd@nxp.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Nov 2024 17:26:57 -0500
Frank Li <Frank.Li@nxp.com> wrote:

> Add support for I3C device in the tmp108 driver to handle the P3T1085
> sensor. Register the I3C device driver to enable I3C functionality for the
> sensor.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/hwmon/tmp108.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> index bfbea6349a95f..83d6847cb542c 100644
> --- a/drivers/hwmon/tmp108.c
> +++ b/drivers/hwmon/tmp108.c
> @@ -13,6 +13,8 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/i2c.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>

Seems odd you need master.h in a device driver.
I'll guess that's because you should be using i3cdev_to_device()
and not looking in the i3c_device structure at all.


>  #include <linux/init.h>
>  #include <linux/jiffies.h>
>  #include <linux/regmap.h>
> @@ -442,6 +444,35 @@ static struct i2c_driver tmp108_driver = {
>  
>  module_i2c_driver(tmp108_driver);
>  
> +#ifdef CONFIG_REGMAP_I3C
> +static const struct i3c_device_id p3t1085_i3c_ids[] = {
> +	I3C_DEVICE(0x011b, 0x1529, NULL),
> +	{},

Trivial, but no trailing comma needed here as nothing can come after
this terminator entry.  That is also consistent with existing similar
tables in this driver.

> +};
> +MODULE_DEVICE_TABLE(i3c, p3t1085_i3c_ids);
> +
> +static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
> +				     "Failed to register i3c regmap\n");
> +
> +	return tmp108_common_probe(&i3cdev->dev, regmap, "p3t1085_i3c");
> +}
> +
> +static struct i3c_driver p3t1085_driver = {
> +	.driver = {
> +		.name = "p3t1085_i3c",
> +	},
> +	.probe = p3t1085_i3c_probe,
> +	.id_table = p3t1085_i3c_ids,
> +};
> +module_i3c_driver(p3t1085_driver);
> +#endif
> +
>  MODULE_AUTHOR("John Muir <john@jmuir.com>");
>  MODULE_DESCRIPTION("Texas Instruments TMP108 temperature sensor driver");
>  MODULE_LICENSE("GPL");
> 


