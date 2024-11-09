Return-Path: <linux-iio+bounces-12071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890919C2D8D
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF981C20F01
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2C1925A2;
	Sat,  9 Nov 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h992DfQX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28613B297;
	Sat,  9 Nov 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159206; cv=none; b=jiS2TbYiCDUNBlp/ATovnwfRcmT+0aFNSKkUOvLt1d4Fgl98IX+SodLiyEwEfjJpxRwrh/H1o05rwU1N+fQGqywTwn9/9WImPEU8QX9bAt+n1uu6fOXDjC9fxDAeBa/8KSnW5DVu0XHlo1j8BPmRGfm3WpWMvJgtB0+j0GZwues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159206; c=relaxed/simple;
	bh=Nxkc10fbSrQ53EfsDaKKNPb1mzlkOX8gplEMSQFbHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQsvC6MFbMjmS3MaXesbsPsFktFoTgou1vtp9R0pdBw+iVTg7aLI/xRm6GwVUxeyTFwpcGyimSrGkfqPMvUU3LjK+tJluGqwVyxLTT3R/c0wqhGngzGIgIlkn5omL+rrenDM0WRNUNFUC1Y4i0hkG3//RT+gN5crY+aLqEV6Bco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h992DfQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBEEC4CECE;
	Sat,  9 Nov 2024 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731159205;
	bh=Nxkc10fbSrQ53EfsDaKKNPb1mzlkOX8gplEMSQFbHm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h992DfQXcWXxcAb3eX0928/bBjPl/XOEbQ2UlThV3xDRBcEmxUOdI6E2NoXF8NbUG
	 8zG9/iK/UpjdmU7ah4UlxVKPqg5HZ+chGG1o+28AjHIl9WFhsVsQNPivvaDQ1/FtMK
	 CRbMAgumiQr2VgQ8Xj6FwN+4eHs5t/+Essv8G3diva8ZCya+tqHscoJJ4/wauIutJf
	 m0Jjxz9Xfjk3hIu0oMVf4AldEv4tDRs0bdRZDNzEOeI5h6gWq3/OAUdT2S13xQkni8
	 /dSTVSDPYu/lkSdx/5jDfDcazkKPJfgoXoNoghzgb+pPWDF0J7rMDdHU5XJFq3X0cQ
	 diH+8FrURpFNw==
Date: Sat, 9 Nov 2024 13:33:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix spi burst write not
 supported
Message-ID: <20241109133317.0616252d@jic23-huawei>
In-Reply-To: <20241107-inv-icm42600-fix-spi-burst-write-not-supported-v1-1-800b22574d01@tdk.com>
References: <20241107-inv-icm42600-fix-spi-burst-write-not-supported-v1-1-800b22574d01@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 07 Nov 2024 22:20:06 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Burst write with SPI is not working for all icm42600 chips. It was
> only used for setting user offsets with regmap_bulk_write.
> 
> Allow tweak of common regmap_config for using only single write for
> spi.
> 
> Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Hi Jean-Baptiste,

You need to copy the regmap before modifying.
Otherwise the case were someone has two IMUs only one of which needs this
will set it for both.

Probably better to just have two regmap_config const structures and pick between
them based on the compatible.

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 3 +++
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index 3a07e43e4cf154f3107c015c30248330d8e677f8..36a3b0795fb7d6cb0c178fadd93896fbc346ba0d 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -402,7 +402,7 @@ struct inv_icm42600_sensor_state {
>  
>  typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
>  
> -extern const struct regmap_config inv_icm42600_regmap_config;
> +extern struct regmap_config inv_icm42600_regmap_config;
>  extern const struct dev_pm_ops inv_icm42600_pm_ops;
>  
>  const struct iio_mount_matrix *
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 93b5d7a3339ccff16b21bf6c40ed7b2311317cf4..680373f6267b37d386e4e7bda543ba4efe97e66b 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -74,7 +74,7 @@ static const struct regmap_access_table inv_icm42600_regmap_rd_noinc_accesses[]
>  	},
>  };
>  
> -const struct regmap_config inv_icm42600_regmap_config = {
> +struct regmap_config inv_icm42600_regmap_config = {
>  	.name = "inv_icm42600",
>  	.reg_bits = 8,
>  	.val_bits = 8,
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> index 3b6d05fce65d544524b25299c6d342af92cfd1e0..73cacfd157a4538ae8c9d1c8d97157afa28aa672 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -59,6 +59,9 @@ static int inv_icm42600_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	chip = (uintptr_t)match;
>  
> +	/* spi doesn't support burst write */
> +	inv_icm42600_regmap_config.use_single_write = true;
> +
>  	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
> 
> ---
> base-commit: c9f8285ec18c08fae0de08835eb8e5953339e664
> change-id: 20241107-inv-icm42600-fix-spi-burst-write-not-supported-efe78d7379a5
> 
> Best regards,


