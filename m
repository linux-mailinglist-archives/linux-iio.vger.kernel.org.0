Return-Path: <linux-iio+bounces-6104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F549015CE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0244C1C20F84
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5524B2A;
	Sun,  9 Jun 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HABvmus5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFB13FF6;
	Sun,  9 Jun 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717930883; cv=none; b=EVvY3v/3Oha6ax6Xku6PdbWwVCkKkS0YmIv8+EwJEnuMYhJzwEfY52ykuC8AKKBfQ2XawYWaMLW92P1ioKJlSMn+c34PdW9w+T1R6feLNz7hhocjydPvgLTR/W+wxEsw+HjW5hihL552DxnnGw7yICImjW+4Ptv3AyVMZl+D/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717930883; c=relaxed/simple;
	bh=AhEa2OH8Q5CkYiNwsnP3WrKE9riUXshFmOwpff18gGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Il5nOpXcgfrlq9d8Xcfej9SlMz8jvkNMSNHJzOjDl/FEzHXTsQBYwfl3HekXgtQzUsfyFeoSpPpKnl8VMiWXpsvXavxvX3phxpQ/zSpKC426WKNa+KaM8QSYXYXls9LfpefSJi6aFh3ZtKx9iknobXc5R6RdGHayFQavj3v20/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HABvmus5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397C4C2BD10;
	Sun,  9 Jun 2024 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717930883;
	bh=AhEa2OH8Q5CkYiNwsnP3WrKE9riUXshFmOwpff18gGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HABvmus5FqzeGpoNNYoP/0wSBYL9UOQA2zlsDWiJ8yiYhrawMq2/65U3izS7orvVd
	 kcOM4tm5dIFceZLl7kHeY2cTd7jVeWtQNmkLEeb2+Db2TI5vUKa262ex9+tFYYa+OK
	 +b7TET8ZR5liffZwSdSwFdqUITRe1hepYJdtTg0F+IQiGuoErGuwTZJInhgFskDXt/
	 lEFOu2Kiwh0hUt0pojt/QW+aCoNXy4U3bZ8ukP5FIc94a8d0eqOET+ps/Vz5l4tYQm
	 NXrMAn8FY65TDOaYXs9HV7pNAQcQAKoeEGHReXg6rXQE3RVQQIuHC3gyEyfmmskre2
	 K5giJUQPSSeHA==
Date: Sun, 9 Jun 2024 12:00:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 02/19] iio: chemical: bme680: Fix calibration data
 variable
Message-ID: <20240609120032.1bc6cbd7@jic23-huawei>
In-Reply-To: <20240606212313.207550-3-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
	<20240606212313.207550-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 23:22:54 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> According to the BME68x Sensor API [1], the h6 calibration
> data variable should be an unsigned integer of size 8.
> 
> [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L789
> Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
> ---
>  drivers/iio/chemical/bme680_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 2c40c13fe97a..812829841733 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -38,7 +38,7 @@ struct bme680_calib {
>  	s8  par_h3;
>  	s8  par_h4;
>  	s8  par_h5;
> -	s8  par_h6;
> +	u8  par_h6;
>  	s8  par_h7;
>  	s8  par_gh1;
>  	s16 par_gh2;


