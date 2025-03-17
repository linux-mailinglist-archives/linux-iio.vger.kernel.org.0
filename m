Return-Path: <linux-iio+bounces-16960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81BA64D93
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D41F17393E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55049238162;
	Mon, 17 Mar 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6U6bv+z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582A2356CE
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212705; cv=none; b=QBELl3uo4noqtCETd5WGHhJA/00KGr98YnBYIy+3q1krjcoR4X+pbzt1Uv0l2KK+NRBgnPZtMrpNCi5bwJ8BOoQDseE/GiQmAVgpGXyIeOofayIvaUgFwODvVh9HNK7HD6VzlYIh+TXp9egIHjUhEbrg9KfcdQJsBrj2BWlZWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212705; c=relaxed/simple;
	bh=BQqUFkF4+WNdj/2/PnQwZrmSUTAZlsXbvPZDTarUs8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCe157dXaE//BbIm/Fq12vsPlJBIiM44wm2PFBhcvwvWzrgyp8LiQWl5CSihPwgfa6pzuYisB8XTB/5oka1zVx5WWEwuDiyxCJRlbW5Xb7PNiFdnEelnbj9OgOwF5oRQzCst3XH8E1TE4kUTHPGmO8h8Uohg7yKy55+KsT18BeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6U6bv+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA716C4CEE3;
	Mon, 17 Mar 2025 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742212704;
	bh=BQqUFkF4+WNdj/2/PnQwZrmSUTAZlsXbvPZDTarUs8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C6U6bv+zUU8xzd/F/jOWgsX3sZjHY1O+O7bqyvMKcRixKgqod5e8xIJOlkdUhh6Co
	 0VBBPq0gWTzCAlqLH82u/RRq72unrG5vXsaz0IlKs6JGV8WNpBSKpsiL2NELtXfuPG
	 Guy05Ilt8377K0o1UGVmgEAPzlI3Xlop7n0JTBlzAt/O6Egli3Nf3h98KUNl+vZx+x
	 pF7gpe815r+zLbQv8nF1qeK1iG9LOkM9yEFfhEwbIAwJDSNsJcUVi1UQu4W7k5wxyU
	 XGQz4o5wHYTJGOgc+uOx0pvRxiaLBhe4Yg8zz4J2+sI490rmU2N9rFnBaxyhiw8QHb
	 dZOu5W3JkghnA==
Date: Mon, 17 Mar 2025 11:58:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sergio Perez <sergio@pereznus.es>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
Message-ID: <20250317115815.2416c741@jic23-huawei>
In-Reply-To: <20250316145514.627-1-sergio@pereznus.es>
References: <20250316145514.627-1-sergio@pereznus.es>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 15:55:13 +0100
Sergio Perez <sergio@pereznus.es> wrote:

> Some BH1750 sensors require a hardware reset before they can be
> detected on the I2C bus. This patch adds support for an optional
> reset GPIO that can be specified in the device tree.
> 
> The reset sequence pulls the GPIO low and then high before
> initializing the sensor, which enables proper detection with
> tools like i2cdetect.
> 
> Update the devicetree binding documentation to include the new
> reset-gpios property with examples.
> 
> Signed-off-by: Sergio Perez <sergio@pereznus.es>
> ---
>  .../devicetree/bindings/iio/light/bh1750.yaml |  20 +++-
>  drivers/iio/light/bh1750.c                    | 113 ++++++++++++------
>  2 files changed, 95 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> index 1a88b3c253d5..d53b221eb84b 100644
> --- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> @@ -11,6 +11,9 @@ maintainers:
>  
>  description: |
>    Ambient light sensor with an i2c interface.
> +  
> +  Some BH1750 sensors require a hardware reset before being properly detected
> +  on the I2C bus. This can be done using the optional reset-gpios property.

I don't think this detail belongs here. In general we are going to reset
them all if we have the GPIO.

>  
>  properties:
>    compatible:
> @@ -23,6 +26,10 @@ properties:
>  
>    reg:
>      maxItems: 1
> +    
> +  reset-gpios:
> +    description: GPIO connected to the sensor's reset line (active low)
> +    maxItems: 1
>  
>  required:
>    - compatible
> @@ -41,5 +48,16 @@ examples:
>          reg = <0x23>;
>        };
>      };
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      light-sensor@23 {
> +        compatible = "rohm,bh1750";
> +        reg = <0x23>;
> +        reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
Add the GPIO to the existing example rather than having a new one.

> +      };
> +    };
>  
> -...
> +...
> \ No newline at end of file
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index 4b869fa9e5b1..53d64b70c03f 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -22,11 +22,16 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/module.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>

As already pointed out, there is a lot of accidental stuff in here.

I'll review again once that is sorted out. For now I'll ignore it.
If I weren't on a train and bored, I'd probably just have waited for v2.


>  
> -#define BH1750_POWER_DOWN		0x00
> -#define BH1750_ONE_TIME_H_RES_MODE	0x20 /* auto-mode for BH1721 */
> -#define BH1750_CHANGE_INT_TIME_H_BIT	0x40
> -#define BH1750_CHANGE_INT_TIME_L_BIT	0x60
> +#define BH1750_POWER_DOWN 0x00
> +#define BH1750_ONE_TIME_H_RES_MODE 0x20 /* auto-mode for BH1721 */
> +#define BH1750_CHANGE_INT_TIME_H_BIT 0x40
> +#define BH1750_CHANGE_INT_TIME_L_BIT 0x60
> +
> +/* Define the reset delay time in microseconds */
> +#define BH1750_RESET_DELAY_US 10000  /* 10ms */
>  
>  enum {
>  	BH1710,
> @@ -40,6 +45,7 @@ struct bh1750_data {
>  	struct mutex lock;
>  	const struct bh1750_chip_info *chip_info;
>  	u16 mtreg;
> +	struct gpio_desc *reset_gpio;
>  };
>  
>  struct bh1750_chip_info {
> @@ -62,11 +68,26 @@ struct bh1750_chip_info {

>  
> +static int bh1750_reset(struct bh1750_data *data)
> +{
> +	if (!data->reset_gpio)
No need to check outside and in here.

> +		return 0;  /* No GPIO configured for reset, continue */
> +
> +	/* Perform reset sequence: low-high */
> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
> +	usleep_range(BH1750_RESET_DELAY_US, BH1750_RESET_DELAY_US + 1000);

fsleep for cases like this where is approximately but greater than X usecs.

> +	gpiod_set_value_cansleep(data->reset_gpio, 1);
> +	usleep_range(BH1750_RESET_DELAY_US, BH1750_RESET_DELAY_US + 1000);
fsleep
> +
> +	dev_info(&data->client->dev, "BH1750 reset completed via GPIO\n");

Too noisy. dev_dbg at most for something like this.

> +	return 0;
> +}


> @@ -248,6 +266,19 @@ static int bh1750_probe(struct i2c_client *client)
>  	data->client = client;
>  	data->chip_info = &bh1750_chip_info_tbl[id->driver_data];
>  
> +	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->reset_gpio)) {
> +		ret = PTR_ERR(data->reset_gpio);
> +		dev_err(&client->dev, "Failed to get reset GPIO: %d\n", ret);
> +		return ret;
Use return dev_err_probe().  In general good to have because of pretty printing
errors messages etc, but in this case you might get a deferral request and
that call adds a bunch of debug info for probe deferal.

> +	}
> +
> +	if (data->reset_gpio) {
> +		ret = bh1750_reset(data);
There isn't a lot going on in that function, so I'd pull all the code down
here and not bother with a function at all.
> +		if (ret < 0)
> +			return ret;
> +	}
> +

