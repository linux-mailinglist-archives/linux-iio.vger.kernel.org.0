Return-Path: <linux-iio+bounces-10499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA499B4A5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818ADB24B2A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D6117B51B;
	Sat, 12 Oct 2024 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+PNmFhw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20047F69;
	Sat, 12 Oct 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734031; cv=none; b=ZT/OOHLhI8er5jTOHk+s++IX12bO8jHjO2ftnBehuAV2bFjpoLhK/YHmRSSotQGsu6WsiulBN5xTCjZ6bYb1qr5ZtRjY9WU3b7+51hCZEYlDqc0BEumJXPM1EgJJR+2qwvFH0vfR4p6cjn6wqEM4x0xOhZwOPurgTLuvPkUvamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734031; c=relaxed/simple;
	bh=vXiaSdRg9aRlCNkPnL1YQeRuBmCPYjv8AyNlfWRF9BU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhD1XHpSvEOxYu4+RSgNbSYzv1bsB/cPt3OBK8bhjx2bs0RvwCRlLoFpc5MZN6GRLJQfnCKOm8udoRxXvxYxwA1VaOSZvp1Ngu/M/wWmemgr/BOEQNJiOzq85jgJuEMdyqPk+MSas1PC9vQbzuzP+VR4SDx6/6qhiYblwPT6aiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+PNmFhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BB6C4CEC6;
	Sat, 12 Oct 2024 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728734031;
	bh=vXiaSdRg9aRlCNkPnL1YQeRuBmCPYjv8AyNlfWRF9BU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+PNmFhw/bh3e+ceb2rPBKLgv0ZlRtvvGRBe7PKL71ZWi2ydDYpvr+uREfpR3Hyqr
	 cBySkKHxry7uhCBrcbZZvudi6qpIHbfuVNQF7AkaU/LjIhzbfNmcAiEO0JC23Icy3E
	 CHFY7i48fNgJLkDVvrQhFS4mJPzm+tkauJ7klDsbtqNURjrHoLTVe39b2gj04CAd/O
	 XTR3YvOUwhI8cij8tZ4Sygu4GR96yR07mT/xIZakwB9bPqUv7PWL0eQlPjG35dOcIG
	 Hd2QeEh5IgcB5eQBHE+j48Fcztlw/GGb9KMUCDXRh9Ed5o6QIMPei9KZrRF4OJpUsM
	 Mb9V4flS4gVew==
Date: Sat, 12 Oct 2024 12:53:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: vamoirid <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
 andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/13] iio: chemical: bme680: add regulators
Message-ID: <20241012125343.729425e5@jic23-huawei>
In-Reply-To: <20241010210030.33309-8-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-8-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 23:00:24 +0200
vamoirid <vassilisamir@gmail.com> wrote:

> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Add support for the regulators described in the dt-binding.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index dedb7edaf43d..a2039b966f20 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -100,6 +101,12 @@ enum bme680_op_mode {
>  	BME680_FORCED,
>  };
>  
> +static const char *const bme680_supply_names[] = {
> +	"vdd", "vddio"
> +};
> +
> +#define BME680_NUM_SUPPLIES ARRAY_SIZE(bme680_supply_names)
> +
>  struct bme680_data {
>  	struct regmap *regmap;
>  	struct bme680_calib bme680;
> @@ -110,6 +117,8 @@ struct bme680_data {
>  	u16 heater_dur;
>  	u16 heater_temp;
>  
> +	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
> +
>  	union {
>  		u8 buf[3];
>  		unsigned int check;
> @@ -857,6 +866,13 @@ static const struct iio_info bme680_info = {
>  	.attrs = &bme680_attribute_group,
>  };
>  
> +static void bme680_regulators_disable(void *data)
> +{
> +	struct regulator_bulk_data *supplies = data;
> +
> +	regulator_bulk_disable(BME680_NUM_SUPPLIES, supplies);
> +}
> +
>  int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  		      const char *name)
>  {
> @@ -885,6 +901,20 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  	data->heater_temp = 320; /* degree Celsius */
>  	data->heater_dur = 150;  /* milliseconds */
>  
> +	regulator_bulk_set_supply_names(data->supplies, bme680_supply_names,
> +					BME680_NUM_SUPPLIES);
> +	ret = devm_regulator_bulk_get(dev, BME680_NUM_SUPPLIES, data->supplies);

devm_regulator_bulk_get_enable() should replace all this with functionally
equivalent code.  You can also have the supplies list local as you don't
then need to hang on to a copy.


> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(BME680_NUM_SUPPLIES, data->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable regulators\n");
> +
> +	devm_add_action_or_reset(dev, bme680_regulators_disable, data->supplies);

> +
> +	fsleep(BME680_STARTUP_TIME_US);
> +
>  	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to reset chip\n");


