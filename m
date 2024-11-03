Return-Path: <linux-iio+bounces-11868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAD9BA542
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E4D1F218D3
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D378716A949;
	Sun,  3 Nov 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfsI9xbL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64770832;
	Sun,  3 Nov 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730633483; cv=none; b=qlKoxuxPr2NL3BdiKG3+dDdlg6p9qjwwU9vEpt4JgaWICDv1Kmbhvauh6d8Xr4Mui55vLkoVNg4fy9fzLXij3Gh0mGHAI2Yx0sVwrS/WlGihBbdgXCwDwL717zW9fjTw99kzriEzHjjdt9Ibkx7I3IQKiZd4wA2AOHo1+6S4AgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730633483; c=relaxed/simple;
	bh=ZvbVHVuun8oeRhQlJajET7qBhOvsWylLAA2B8VkfPFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFxUng7VldNrQKJcFvDqJZ/gwUWTp/+vRkoCj4b+E8TUbUoy/130mwf9QPL7UstAP0CqfRSxwlqb8TPsmWMwrS6+keBSVuX186Fcm14OWcFPsWNW7J6+LHKFuqNn1Mn4jUdqZnlAHpLmw+vPS+w5e4LGpyWcIBFUjgAoZqttR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfsI9xbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD515C4CECD;
	Sun,  3 Nov 2024 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730633483;
	bh=ZvbVHVuun8oeRhQlJajET7qBhOvsWylLAA2B8VkfPFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WfsI9xbLsIDKjoAK61UpdaKB1MZDf+nzsNT6q0hqXnk+BOWHDvW+ZejPDr83/cTcC
	 5p0njkFXStrBEqtWjGHGB9TDDyanBXuM99CK93l8AEemJBPfXy8vS/PZLK3EiO8XLG
	 3XUKYcaiTZoAJKwbQlZRqIJ1nIw+0U4J4uut0SH5BJwUv1wbA1UxDXkuVbXu1q5mr1
	 v/7jbnVwp9LzEbLO5xuLhuRlX4GFPWG0RwW7rLq8L0B+EUBk9Z8m/Ei9WnH/5ntr6H
	 aYmjPhjfBmQpayBwpDHyvUFpoj7tl3JH+OhSLDKlgC93FHrKqVVWMhk7jbFEgjE6nz
	 hizgVfwY6NINA==
Date: Sun, 3 Nov 2024 11:31:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Kaustabh
 Chakraborty <kauschluss@disroot.org>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <trabarni@gmail.com>, Ondrej Jirman <megi@xff.cz>, Uwe =?UTF-8?B?S2xlaW5l?=
 =?UTF-8?B?LUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
Message-ID: <20241103112933.60f96f97@jic23-huawei>
In-Reply-To: <20241102195037.3013934-9-aren@peacevolution.org>
References: <20241102195037.3013934-3-aren@peacevolution.org>
	<20241102195037.3013934-9-aren@peacevolution.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 15:50:39 -0400
Aren Moynihan <aren@peacevolution.org> wrote:

> The vdd and leda supplies must be powered on for the chip to function
> and can be powered off during system suspend.
> 
> This was originally based on a patch by Ondrej Jirman[1], but has been
> rewritten since.
> 
> 1: https://codeberg.org/megi/linux/commit/a933aff8b7a0e6e3c9cf1d832dcba07022bbfa82
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> 
> Notes:
>     Changes in v4:
>      - fix variable declaration order in stk3310_resume to match the rest of
>        the driver

For this Andy was asking for consistency.  Generally we don't insist on a
particular ordering in IIO drivers, but we do prefer them to be the same.
Your new ordering is inconsistent between resume and suspend.  Whilst
existing code may be inconsistent, you can still pick most common ordering
and use that for your new code.

If the existing driver is inconsistent then feel free to tidy that up but
do it in a precursor patch so there is a consistent style for you to then
carry on.

>     
>     Changes in v3:
>      - use bulk regulators instead of two individual ones
>      - handle cleanup using devm callbacks instead of the remove function
>     
>     Changes in v2:
>      - always enable / disable regulators and rely on a dummy regulator if
>        one isn't specified
>      - replace usleep_range with fsleep
>      - reorder includes so iio headers are last
>      - add missing error handling to resume
> 
>  drivers/iio/light/stk3310.c | 76 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 181b7acb3f96..f93689c61f44 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -13,6 +13,8 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -130,6 +132,7 @@ struct stk3310_data {
>  	struct regmap_field *reg_int_ps;
>  	struct regmap_field *reg_flag_psint;
>  	struct regmap_field *reg_flag_nf;
> +	struct regulator_bulk_data supplies[2];
>  };
>  
>  static const struct iio_event_spec stk3310_events[] = {
> @@ -621,6 +624,31 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static int stk3310_regulators_enable(struct stk3310_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> +	if (ret)
> +		return ret;
> +
> +	/* we need a short delay to allow the chip time to power on */
> +	fsleep(1000);
> +
> +	return 0;
> +}
> +
> +static void stk3310_regulators_disable(void *private)
> +{
> +	int ret;
> +	struct stk3310_data *data = private;
> +	struct device *dev = &data->client->dev;
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> +	if (ret)
> +		dev_err(dev, "failed to disable regulators: %d\n", ret);
> +}
> +
>  static int stk3310_probe(struct i2c_client *client)
>  {
>  	int ret;
> @@ -642,6 +670,13 @@ static int stk3310_probe(struct i2c_client *client)
>  
>  	devm_mutex_init(&client->dev, &data->lock);
>  
> +	data->supplies[0].supply = "vdd";
> +	data->supplies[1].supply = "leda";
> +	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies),
> +				      data->supplies);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "get regulators failed\n");
> +
>  	ret = stk3310_regmap_init(data);
>  	if (ret < 0)
>  		return ret;
> @@ -652,6 +687,16 @@ static int stk3310_probe(struct i2c_client *client)
>  	indio_dev->channels = stk3310_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
>  
> +	ret = stk3310_regulators_enable(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "regulator enable failed\n");
> +
> +	ret = devm_add_action_or_reset(&client->dev, stk3310_regulators_disable, data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to register regulator cleanup\n");
> +
>  	ret = stk3310_init(indio_dev);
>  	if (ret < 0)
>  		return ret;
> @@ -682,18 +727,45 @@ static int stk3310_probe(struct i2c_client *client)
>  static int stk3310_suspend(struct device *dev)
>  {
>  	struct stk3310_data *data;
> +	int ret;
>  
>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>  
> -	return stk3310_set_state(data, STK3310_STATE_STANDBY);
> +	ret = stk3310_set_state(data, STK3310_STATE_STANDBY);
> +	if (ret)
> +		return ret;
> +
> +	regcache_mark_dirty(data->regmap);
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> +	if (ret) {
> +		dev_err(dev, "failed to disable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static int stk3310_resume(struct device *dev)
>  {
> -	u8 state = 0;
> +	int ret;
>  	struct stk3310_data *data;
> +	u8 state = 0;
>  
>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> +
> +	ret = stk3310_regulators_enable(data);
> +	if (ret) {
> +		dev_err(dev, "Failed to re-enable regulators: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = regcache_sync(data->regmap);
> +	if (ret) {
> +		dev_err(dev, "Failed to restore registers: %d\n", ret);
> +		return ret;
> +	}
> +
>  	if (data->ps_enabled)
>  		state |= STK3310_STATE_EN_PS;
>  	if (data->als_enabled)


