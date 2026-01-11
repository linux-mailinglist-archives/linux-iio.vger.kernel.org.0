Return-Path: <linux-iio+bounces-27599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C811D0ED64
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A56300D148
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F311330661;
	Sun, 11 Jan 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDqZZspm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311F2206AC;
	Sun, 11 Jan 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768134125; cv=none; b=i1jOo0P7XIQgSjLovPNumT8DwN0As/laRziUv4bi2YIjZbWmRcK1tZUEfBP3XfrPwPenfEyBd571mvBspd6b8VThUlpm05RkJLb4LxIqYO4G8/331XbCRN5M5V1IquZwvydouHpwa9xx5H37d72TENHuS3XXxxMyfjYC8hEW4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768134125; c=relaxed/simple;
	bh=6LKGvQFxKEe93GdF3bMwJAAKj7P0/PCMVVTaD5v3BUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXhAZOwG6DiB4gWiA+7u/Wbce6tPd6rDQHu77kgBoTguKwdGhFbZRM9a2OLOujE4Y5RdSuxDNPvvHSE1vHIa78HK1Hi40fxPB0BdaGK0OwgYDqKkHIaaj6mDel9N7kJ6JCTH0eHKQ1PKzTKbe7T4FV5CaNkNkCkTOFUhgHz4lDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDqZZspm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2FFC4CEF7;
	Sun, 11 Jan 2026 12:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768134124;
	bh=6LKGvQFxKEe93GdF3bMwJAAKj7P0/PCMVVTaD5v3BUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eDqZZspmNCXL/HxZi+gPXGgWLeYbc9XbawVxoLzx4/JpvRl711+Ae6WAWJI9bD+4Z
	 3+UBBtEr0SLM2vKj00304pVq6zHPw7jAF+MYUhm4D4FUdXxL95BXoJdhm/lQieCs2W
	 t63W0B4a0VKzapSevSZvhFuau4XAGLFERhAkDGaSGMtrUWwXDpCW25RUh3FKAZUgqK
	 3zM2Gz9ZW77k8YU42oap7WI2C7cj6dN4dGcPSowDy+JC1a4jfsIMx00hbzs30GaR/J
	 YxwN1I71WWFtZNwQOUbNMGUJFPjMe+xCPtqQ4DU9oiYmzlCJ9ruNkUtR3MptUpCoJC
	 8YRvl5xaDORCg==
Date: Sun, 11 Jan 2026 12:21:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andriy.shevchenko@intel.com,
 dev-jorge.sanjuangarcia@duagon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iio: adc: men_z188_adc: drop unneeded
 MODULE_ALIAS
Message-ID: <20260111122157.2fb32838@jic23-huawei>
In-Reply-To: <20260108135301.26448-2-dev-josejavier.rodriguez@duagon.com>
References: <20260108135301.26448-1-dev-josejavier.rodriguez@duagon.com>
	<20260108135301.26448-2-dev-josejavier.rodriguez@duagon.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 14:53:01 +0100
Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com> wrote:

> Since commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
> the MODULE_ALIAS() is redundant as the module alias is now
> automatically generated from the MODULE_DEVICE_TABLE().
> 
> Remove the explicit alias.
> 
> No functional change intended.
> 
> Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
> Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Applied. Thanks,

Jonathan

> ---
>  drivers/iio/adc/men_z188_adc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
> index cf8a8c0412ec..90919d282e7b 100644
> --- a/drivers/iio/adc/men_z188_adc.c
> +++ b/drivers/iio/adc/men_z188_adc.c
> @@ -171,5 +171,4 @@ module_mcb_driver(men_z188_driver);
>  MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("IIO ADC driver for MEN 16z188 ADC Core");
> -MODULE_ALIAS("mcb:16z188");
>  MODULE_IMPORT_NS("MCB");


