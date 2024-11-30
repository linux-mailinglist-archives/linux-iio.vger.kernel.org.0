Return-Path: <linux-iio+bounces-12855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F39A9DF123
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23225281315
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E581F19C542;
	Sat, 30 Nov 2024 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O53JkXlJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1A22066;
	Sat, 30 Nov 2024 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732976817; cv=none; b=BDhLARIODujmW9S7x/8Uk/sGxKzChz/YyuH/Ebf5vwMSLC4v4DQbaajhfAlFlY0dgePYcEK0KoLmirG3f83tdx40VAE9Hi4oB3Z3cTU+ajo6D35Cgn9xe+Xoy6WIQ9YBOJFZ+R+tEqiqvBBz+F+KkhN4XdSoLa46B7dpp+BGBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732976817; c=relaxed/simple;
	bh=1JfZBGt2E3X8qqsmgczArEGXlSVP0/Q35wYs6d/fGsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hc0VEfYKvtOBaisMxngLFZYIxntueDK/eoKNtJpt3kcHFIy9qNkPFKFBwwbAqbfJ5w7skjeGwtSpJwqCfajqtSFXCsy7gkj5zC0HCJ/uNGgnp8YYuo1h2EKEm2FAD/4ZoRnk3rz/UpgBV9ojQapmU0ZS8p6AfUY49xnk61ZJDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O53JkXlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA339C4CECC;
	Sat, 30 Nov 2024 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732976817;
	bh=1JfZBGt2E3X8qqsmgczArEGXlSVP0/Q35wYs6d/fGsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O53JkXlJynh2OL1AY8XDIr+WPQ2QQ7LEameYwa7X9L/56q6E7eyx4hibKV/lkDmz8
	 y4j59BnHz0H0k5Rw8A37ZAgc8bWWouAcWhDivyCCh3AIH1TOEFtrhM707YEptxtKR/
	 +Z0bP8WMOKhg4I7GGWVrP6LamVRZshA4GIJ+5hxv70dH35W6dylqBQ+ya6CG0Nhsn9
	 saWAIY54FegL0xYWgZ75XYnfD0TPLco8/kJUPb/ge2XWLkEBf2p4YhS7Cobhdw6yYP
	 8ax3HswTO0zmat/bmYRofdLtg+I9FRPkx0lDvzYSiGW0z7MqmBymRxTUsbZDvoSYcW
	 P4yWw9sN6v30A==
Date: Sat, 30 Nov 2024 14:26:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: chemical: bme680: add regulators
Message-ID: <20241130142648.62ead7fe@jic23-huawei>
In-Reply-To: <20241128193246.24572-3-vassilisamir@gmail.com>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
	<20241128193246.24572-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 20:32:45 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add support for the regulators described in the dt-binding.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 9783953e64e0..186e0a6cc2d7 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> @@ -111,6 +112,10 @@ enum bme680_scan {
>  	BME680_GAS,
>  };
>  
> +static const char *const bme680_supply_names[] = { "vdd", "vddio" };
> +
> +#define BME680_NUM_SUPPLIES ARRAY_SIZE(bme680_supply_names)
Trivial: What benefit do we get from this define that is used in one place?

> +
>  struct bme680_data {
>  	struct regmap *regmap;
>  	struct bme680_calib bme680;
> @@ -1114,6 +1119,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  	data->heater_dur = 150;  /* milliseconds */
>  	data->preheat_curr_mA = 0;
>  
> +	ret = devm_regulator_bulk_get_enable(dev, BME680_NUM_SUPPLIES,
	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(bme680_supply_names),
					     bme680_supply_names);

And don't worry about slightly over 80 chars line.

> +					     bme680_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get and enable supplies.\n");
> +
> +	fsleep(BME680_STARTUP_TIME_US);
> +
>  	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to reset chip\n");


