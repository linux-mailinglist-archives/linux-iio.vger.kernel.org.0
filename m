Return-Path: <linux-iio+bounces-20654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C882AD9D04
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4272A189B493
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58E2D9EC7;
	Sat, 14 Jun 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQXc7ytV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119972C08D4;
	Sat, 14 Jun 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908714; cv=none; b=SG9eA2AnrlWunEwpv3sHPV3/Ust/POjyGggv9qKg4qt6Y81Vg2ETbJ5NLHv9zJa54J3U0X2RLnBRDmRmXT86p4gEaYnHjj31q4oC7z0sOj/7f+MNTr1tE7bftUv0JZReop61UuUk/akZmziL7vK9y6eAynxvyNa7XHb2brrVkQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908714; c=relaxed/simple;
	bh=iJAZsuMIUwJ+U3/QiFq8CYUodQeWJvnqEjsTJVX0uyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5J5hLL3RFENHASSToK3CUnYqHx/tx3TYbERASBH6QXlhJTe/oaho7A9jLrIB1LvG6MGC9zQfAIqCgqbhf7WbO6jL4t4azW8ggzF2BboRkPBlpy+zXIOvMp4uNFKeUHAnURxZHFliZN85s8kBqEM4EPX5wJM/Ymwvt/YaQc4AbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQXc7ytV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7429AC4CEEB;
	Sat, 14 Jun 2025 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908713;
	bh=iJAZsuMIUwJ+U3/QiFq8CYUodQeWJvnqEjsTJVX0uyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQXc7ytVsiK8cTSs+tuyBz5HHqJP653QnP9CDOUy8Nbx5bfQWhBBTrt3pVjG7Zclj
	 C3LQ1XBUQDFiPI/s26QHXrz0m3mj09TVQRUTvCpm3ndF6/tUyJy6oO+FxvyefdqOeR
	 +j7/A+1k+UWCU7lf8qBvWCwFU4a9jlt9MMopUmpS+NUHG4exARyPkTYU2mkag+MhHL
	 yj+KtC26g9Kh8JFWYzNhlN9a/2JnU7rzN3YYbuDa+vXgab+Cd9wCkbhnoafTuWsCN2
	 irb/oR/NqOwDmu1dUaUw8WT7YENyR7riHjwO8aYwhWcsaYJ9aTgg7P/oYYaGtcduSP
	 aE3FWreTeALjg==
Date: Sat, 14 Jun 2025 14:45:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 03/11] iio: accel: adxl345: simplify measure enable
Message-ID: <20250614144506.14d869fb@jic23-huawei>
In-Reply-To: <20250610215933.84795-4-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:25 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Simplify the function to enable or disable measurement. Replace the
> separate decision logic and call to regmap_update_bits() by a single
> call to regmap_assign_bits() taking a boolean argument directly.
> 
> This is a refactoring change and should not impact functionality.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Another good stand along change.

Applied.

> ---
>  drivers/iio/accel/adxl345.h      | 1 -
>  drivers/iio/accel/adxl345_core.c | 5 ++---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 6c1f96406136..9385affdefe3 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -73,7 +73,6 @@
>  #define ADXL345_BW_LOW_POWER		BIT(4)
>  #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
>  
> -#define ADXL345_POWER_CTL_STANDBY	0x00
>  #define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
>  #define ADXL345_POWER_CTL_SLEEP	BIT(2)
>  #define ADXL345_POWER_CTL_MEASURE	BIT(3)
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 07abab82d093..cae9e37e216f 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -233,9 +233,8 @@ EXPORT_SYMBOL_NS_GPL(adxl345_is_volatile_reg, "IIO_ADXL345");
>   */
>  static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  {
> -	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
> -
> -	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> +	return regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
> +				  ADXL345_POWER_CTL_MEASURE, en);
>  }
>  
>  /* tap */


