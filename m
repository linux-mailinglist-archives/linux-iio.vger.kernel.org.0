Return-Path: <linux-iio+bounces-23860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA6B47B73
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2392917F74C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3C2676F4;
	Sun,  7 Sep 2025 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvnpZCZT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227723BD1F;
	Sun,  7 Sep 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757249308; cv=none; b=aaGecnNOsVlBO9ExgRWi4rrjwId5zUvXxx2EYZZ34SS+zl9qCzj0pRCpp3Q+gKG2HTIcg4qQu9URKDq6km0z2ElEkrcRY++hW4GBlffNfGKcOYdM34KuPgCu1DW4iZ480KCQHzbc4ilmCVyX7wuk7z+MEqSCkxxVDsWW2NAtCC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757249308; c=relaxed/simple;
	bh=PpEf/FsZHJrtQa9NBBq5hzzIFGfzAZlSvyLWvozPJEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n21snqqzaUSQRM/mtCnRpcouM8GIM6YtN7Uf0xF82tqXZASRtgTagBUuN2vC5DkXY5yZRVj+GXVx7v9zpxTuZ4MtxLYOHmZBnzsH3HX3ajyEgdq495fKfoPOiog624oDPj/6JnaM7z6Mv9NYMAIl1RsCp/5h14Tbz78e8JBujs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvnpZCZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0838CC4CEF0;
	Sun,  7 Sep 2025 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757249307;
	bh=PpEf/FsZHJrtQa9NBBq5hzzIFGfzAZlSvyLWvozPJEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvnpZCZTwnLqpGBiXy/9H0dRf8kWZcXCCo1JqJbgxNiKIKaGsSWbCASqndd2uRDH5
	 laNK1awMH5gdMWlHydLLdTTum8OU6U3fyllIRdGCfqu62F1Yk5uI0FrJDip5IcrO3r
	 swSrhU/fGarbtn6gxJVLLvohXqTDWYvsT70qhPWxeOYgHjhqJhjmRsI57/KTSruorj
	 ebx8FOT2blfkQaH2OCMigpnsvGsb9M7EbsivwKKhD+sn67SkbmkiIysOk35Vxg03Mo
	 w3VPwbKcew+zZ0X8MggEZIqPsjYF2dmYcYYUu4alwOUeiPUx5PVI9pmRuhk0IqSNOq
	 W2e++9Rjck23g==
Date: Sun, 7 Sep 2025 13:48:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 05/10] iio: accel: BMA220 make use of the watchdog
 functionality
Message-ID: <20250907134819.5289f4fa@jic23-huawei>
In-Reply-To: <20250901194742.11599-6-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-6-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 22:47:31 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Sometimes the sensor gets stuck and enters a condition in which it pulls
> SDA low, thus making the entire i2c bus unusable.
> The optional bosch,watchdog property mitigates this problem by clearing
> the condition after a period of 1 or 10ms.

As I think was discussed with the binding, I'd turn this on by default
and we can figure out if we want to change that if it causes anyone
problems long run.

> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  drivers/iio/accel/bma220_core.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index fae84823d52b..86347cf8ab1e 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -158,6 +158,12 @@ enum bma220_axis {
>  	AXIS_Z,
>  };
> 
> +enum bma220_prop_wdt {
> +	BMA220_PROP_WDT_OFF,
> +	BMA220_PROP_WDT_1MS,
> +	BMA220_PROP_WDT_10MS,
> +};
> +
>  static const int bma220_scale_table[][2] = {
>  	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
>  };
> @@ -428,10 +434,17 @@ static int bma220_power(struct bma220_data *data, bool up)
>  	return -EBUSY;
>  }
> 
> +static int bma220_wdt(struct bma220_data *data, const u8 val)
> +{
> +	return regmap_update_bits(data->regmap, BMA220_REG_WDT, BMA220_WDT_MASK,
> +				  FIELD_PREP(BMA220_WDT_MASK, val));
> +}
> +
>  static int bma220_init(struct bma220_data *data)
>  {
>  	int ret;
>  	unsigned int val;
> +	u32 watchdog;
>  	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
> 
>  	ret = devm_regulator_bulk_get_enable(data->dev,
> @@ -462,6 +475,25 @@ static int bma220_init(struct bma220_data *data)
>  		return ret;
>  	}
> 
> +	ret = device_property_read_u32(data->dev, "bosch,watchdog", &watchdog);
> +	if (!ret) {
> +		switch (watchdog) {
> +		case BMA220_PROP_WDT_1MS:
> +			ret = bma220_wdt(data, BMA220_WDT_1MS);
> +			break;
> +		case BMA220_PROP_WDT_10MS:
> +			ret = bma220_wdt(data, BMA220_WDT_10MS);
> +			break;
> +		default:
> +			ret = bma220_wdt(data, BMA220_WDT_OFF);
> +			break;
> +		}
> +		if (ret) {
> +			dev_err(data->dev, "Failed to set watchdog\n");

dev_err_probe()

> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
> 
> --
> 2.49.1
> 
> 


