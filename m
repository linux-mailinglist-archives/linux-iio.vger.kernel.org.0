Return-Path: <linux-iio+bounces-21130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B789AECF28
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05AE3B68F5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C4623DEAD;
	Sun, 29 Jun 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXaoENv8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB445238152;
	Sun, 29 Jun 2025 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217939; cv=none; b=tupSMSY4auTju37IeLzh/NUQeAYJEFilHUhgGDyBlYiZwtRglQtdfDaxkZSP6wL0MpIYJgfGGFEi+xza4uNCP6xvl9t8UvczYSPf5HPLipRdYuRZ5Oix17KqSDvLzx6IQn71/nuxYcXpLH9FH13/qvrd0fzfeI7+YiM8c6RkL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217939; c=relaxed/simple;
	bh=Ocbm13LTOswpEaO6W+yjb/T5lXzRwXr4a3y4soN0ldE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcp5WxV9L/67zEAvXfojB9jpwS2SmyoptVaVRbtRb7X7UMyeuWyIl5vrYf0xtLSIWokluA2hbwjaB0v2ol+ppuZDmR1dOvcYe21xhqRaQwZVwWGbWl1EJtWqtKTTA5Tv0+Agd3c70Jc/Wvwds5cIVt47BGuM3PrNLalesQHGfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXaoENv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB61C4CEEB;
	Sun, 29 Jun 2025 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751217939;
	bh=Ocbm13LTOswpEaO6W+yjb/T5lXzRwXr4a3y4soN0ldE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MXaoENv8WmPVZ5Ywib4nabxiblga7TF5FbUBun8WKUkSQiqo44h7d4/tkCjhT3ZiS
	 fGnMDtTZQvQUcQiUgfwWE51/vYZn6l4xf0lrym84KXjNybTuR9bnq82hKb7Blo7Cqs
	 fsRXVVtVaYHRnYX11VS4HO7g/QxJ8Z59+Wek6O+wSm5S8hyx+lK2DVj+Y/HTgFJdUJ
	 Tv6StYuDiC1as5W/1nG77s/LIf2JS97HyudB3q1XVJkTBkHvKGl3vNrlD/o5XQ/X8W
	 Sg/9HcjJdjReGRFL25X5LFlrD3kBEVHG8guBPQylZi8QXCKTtOgGDRBjHcFGB9oX4C
	 W/05YxVTZ2f9w==
Date: Sun, 29 Jun 2025 18:25:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] iio: adc: ad7124: drop use of chip info array
Message-ID: <20250629182531.6666f690@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-5-v1-1-9e56c2f77979@baylibre.com>
References: <20250628-iio-const-data-5-v1-1-9e56c2f77979@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:16:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Change the ad7124 driver to use individual chip info structures instead
> of an array. This reduces the verbosity of the code. Also, the data is
> now const as it should have been in the first place.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I'm going to let these array to separate structures patches sit on list a while
as whilst I agree in general they are a nice to have, there is churn involved.

Also I might edit the titles to say
"drop use of array for chip info"

Current title kind of sounds like you stopped using any chip info at all!


For this one, Uwe has been active in the driver recently so would
be a reasonable +CC.

> ---
>  drivers/iio/adc/ad7124.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 92596f15e797378329d2072bff71e392664c69db..9808df2e92424283a86e9c105492c7447d071e44 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -94,11 +94,6 @@
>  
>  /* AD7124 input sources */
>  
> -enum ad7124_ids {
> -	ID_AD7124_4,
> -	ID_AD7124_8,
> -};
> -
>  enum ad7124_ref_sel {
>  	AD7124_REFIN1,
>  	AD7124_REFIN2,
> @@ -193,17 +188,16 @@ struct ad7124_state {
>  	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
>  };
>  
> -static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
> -	[ID_AD7124_4] = {
> -		.name = "ad7124-4",
> -		.chip_id = AD7124_ID_DEVICE_ID_AD7124_4,
> -		.num_inputs = 8,
> -	},
> -	[ID_AD7124_8] = {
> -		.name = "ad7124-8",
> -		.chip_id = AD7124_ID_DEVICE_ID_AD7124_8,
> -		.num_inputs = 16,
> -	},
> +static const struct ad7124_chip_info ad7124_4_chip_info = {
> +	.name = "ad7124-4",
> +	.chip_id = AD7124_ID_DEVICE_ID_AD7124_4,
> +	.num_inputs = 8,
> +};
> +
> +static const struct ad7124_chip_info ad7124_8_chip_info = {
> +	.name = "ad7124-8",
> +	.chip_id = AD7124_ID_DEVICE_ID_AD7124_8,
> +	.num_inputs = 16,
>  };
>  
>  static int ad7124_find_closest_match(const int *array,
> @@ -1341,17 +1335,15 @@ static int ad7124_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id ad7124_of_match[] = {
> -	{ .compatible = "adi,ad7124-4",
> -		.data = &ad7124_chip_info_tbl[ID_AD7124_4], },
> -	{ .compatible = "adi,ad7124-8",
> -		.data = &ad7124_chip_info_tbl[ID_AD7124_8], },
> +	{ .compatible = "adi,ad7124-4", .data = &ad7124_4_chip_info },
> +	{ .compatible = "adi,ad7124-8", .data = &ad7124_8_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad7124_of_match);
>  
>  static const struct spi_device_id ad71124_ids[] = {
> -	{ "ad7124-4", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_4] },
> -	{ "ad7124-8", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_8] },
> +	{ "ad7124-4", (kernel_ulong_t)&ad7124_4_chip_info },
> +	{ "ad7124-8", (kernel_ulong_t)&ad7124_8_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad71124_ids);
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-5-4cc817647407
> 
> Best regards,


