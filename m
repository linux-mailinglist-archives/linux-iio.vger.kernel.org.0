Return-Path: <linux-iio+bounces-18414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B310A9501E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685413B1147
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B4263F38;
	Mon, 21 Apr 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDcUXf9/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74019ADA4;
	Mon, 21 Apr 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234657; cv=none; b=TOj83FhOHafzwi6SgF1wxn0FAx677sCqs8BPVwuVkbRIg8X55eVTWSyxU67RxNJn+X5amPSo4RtDpZaa8KyaN/pHMW/jsfOejBjSDWL268avnaoouDEH5j+OAiouNEFYqqdV4is9Cb9yJobm2pr2m0Kr/NXAUGLQRJJnY0WIgdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234657; c=relaxed/simple;
	bh=8Ga9bMa+6Cm+8fRUsswxDiXS5Us0FHpqBOW+oHvBo4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ruwncl54NGEANYChUBBYLmDn2iPOptDKWWIbZMayeKq67mofUB51B6drl5czrJ8YrAY3qugDalCS3w2CYa+Mryz4HtlrGadusa6HcV+vfKa5GZ5QHoT1woa/ql6HTx1G8EUuQ+b+Fy5rTye4Pse99/1QablZ2XmNkz7BXX5eyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDcUXf9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05A9C4CEE4;
	Mon, 21 Apr 2025 11:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745234657;
	bh=8Ga9bMa+6Cm+8fRUsswxDiXS5Us0FHpqBOW+oHvBo4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tDcUXf9/v8ewocuCpUUaz6Y6o1bx9dmG325jybAa3uIFTwzhxgmIvJCj73w0YUe7K
	 +nlGrkEZwWHh/sdobv1iDnIV4pdPKWyJqgizAI5JpkzsbfFaQEI8S12XkghrmVDTPh
	 zBpFET+AGCHLfSSDxvfxbuvSVSWcw5e5gz1jRro6b0QRQB43nytgmb0yUoVPkKWwUz
	 mcFEpv0sGbHzbVKyKWa9PC9QmkTTN/aPIR9Qm5ZXs0FcsUeZYuWhq2jxdGBqIgZBOZ
	 teRQlQcM2ExQq7zCY0pdsSLkevchOtfofkavTeD+jb7zJF+UBsXboCHZqlhgewWeMk
	 a6KIQcs6zZKZQ==
Date: Mon, 21 Apr 2025 12:24:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: amplifiers: ada4250: clean up ada4250_init()
Message-ID: <20250421122409.79f5580c@jic23-huawei>
In-Reply-To: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v2-1-1bf9b033aaf5@baylibre.com>
References: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v2-1-1bf9b033aaf5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 15:37:54 -0500
David Lechner <dlechner@baylibre.com> wrote:

> There are a few opportunities to simplify the code in ada4250_init():
> * Replace local spi variable with dev since spi is not used directly.
> * Drop the data variable and use chip_id directly with the regmap bulk
>   read (__aligned() and initialization of the data variable were
>   unnecessary).
> * Don't use get_unaligned_le16() when not needed.
> * Use dev_err_probe() instead of dev_err() and return.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> In v1, I though we had a bug, but Andy set me straight. Still, since we
> were already looking at this, there is some room for improvement, so I
> changed this to a cleanup patch instead.
> 
> Changes in v2:
> - Totally new patch.
> - Link to v1: https://lore.kernel.org/r/20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com
As Andy suggested this wants breaking up.

One additional requested change inline.

> ---
>  drivers/iio/amplifiers/ada4250.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
> index 74f8429d652b17b4d1f38366e23ce6a2b3e9b218..13906e4b4842095717566781ad00cd58f3934510 100644
> --- a/drivers/iio/amplifiers/ada4250.c
> +++ b/drivers/iio/amplifiers/ada4250.c
> @@ -13,8 +13,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> -
> -#include <linux/unaligned.h>
> +#include <linux/types.h>
>  
>  /* ADA4250 Register Map */
>  #define ADA4250_REG_GAIN_MUX        0x00
> @@ -299,25 +298,23 @@ static void ada4250_reg_disable(void *data)
>  
>  static int ada4250_init(struct ada4250_state *st)
>  {
> +	struct device *dev = &st->spi->dev;
>  	int ret;
> -	u16 chip_id;
> -	u8 data[2] __aligned(8) = {};
> -	struct spi_device *spi = st->spi;
> +	__le16 chip_id;
>  
> -	st->refbuf_en = device_property_read_bool(&spi->dev, "adi,refbuf-enable");
> +	st->refbuf_en = device_property_read_bool(dev, "adi,refbuf-enable");
>  
> -	st->reg = devm_regulator_get(&spi->dev, "avdd");
> +	st->reg = devm_regulator_get(dev, "avdd");
>  	if (IS_ERR(st->reg))
> -		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> +		return dev_err_probe(dev, PTR_ERR(st->reg),
>  				     "failed to get the AVDD voltage\n");
>  
>  	ret = regulator_enable(st->reg);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable specified AVDD supply\n");
>  
> -	ret = devm_add_action_or_reset(&spi->dev, ada4250_reg_disable, st->reg);
> +	ret = devm_add_action_or_reset(dev, ada4250_reg_disable, st->reg);
>  	if (ret)
>  		return ret;
>  
> @@ -326,16 +323,13 @@ static int ada4250_init(struct ada4250_state *st)
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, data, 2);
> +	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, &chip_id,
> +			       sizeof(chip_id));
>  	if (ret)
>  		return ret;
>  
> -	chip_id = get_unaligned_le16(data);
> -
> -	if (chip_id != ADA4250_CHIP_ID) {
> -		dev_err(&spi->dev, "Invalid chip ID.\n");
> -		return -EINVAL;
> -	}
> +	if (le16_to_cpu(chip_id) != ADA4250_CHIP_ID)

Given you are working on this driver, these days we treat an ID match failure
as informational only.  The reason being to allow fallback compatibles to
be used in DT so that an old kernel can in theory support a new compatible
chip that shows up sometime in the future (but has a different chip ID).

So please add a final patch to the series that relaxes this to a dev_info()
print and carry on anyway.

I've considered just changing all rejected chip IDs, but it seems too noisy
unless people are touching the code for other reasons.  Hence I've not done it.
There is also a non zero chance that someone has a broken firmware and
odd error reports will ensue.

Jonathan

> +		return dev_err_probe(dev, -EINVAL, "Invalid chip ID.\n");
>  
>  	return regmap_write(st->regmap, ADA4250_REG_REFBUF_EN,
>  			    FIELD_PREP(ADA4250_REFBUF_MSK, st->refbuf_en));
> 
> ---
> base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
> change-id: 20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-93ebb1344295
> 
> Best regards,


