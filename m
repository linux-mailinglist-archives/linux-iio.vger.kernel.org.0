Return-Path: <linux-iio+bounces-11382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC339B1CFE
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F94F1C20AEC
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE232131E2D;
	Sun, 27 Oct 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxJDx5VP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542945948;
	Sun, 27 Oct 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022889; cv=none; b=aWwzhjy4AqkyRU2PF0SpQbOyQhfgt7rlW5adxIHRjD9AXYVk2ma7bQmwElltabEsDufrJ3qIBWCL0nSvVv+ZQ27IuXqxyvmdmY+tpxweHQb0kDx80xgiTbwr5zrbNowrZpiR2laEEwnvX/CFzSK/lpO4Halz0YFZtBsHTpqgbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022889; c=relaxed/simple;
	bh=lGtuZz5UTm5XzI22JVql/LRT8C1ymU6U0GZnGcnhtJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn6s9dmbPcOgwAwaucEflTK+J1/EMMESpxJYDCT6BWEq5wsx4p4h18jDNOPD3rpRYKveLd/60sLarHiP1vmmJUmq2NX/H9hhdKkVoBNYa4o/twiciLfIH7wJ+sQ6KY++1T4LFcb6FGt14FRGOSCyG5x8f1uXziNwYtwS5n8LlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxJDx5VP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F86C4CEC3;
	Sun, 27 Oct 2024 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730022889;
	bh=lGtuZz5UTm5XzI22JVql/LRT8C1ymU6U0GZnGcnhtJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fxJDx5VPEwRmwZd1USNLdS3fxtVVKAex1W6xgOJ+0sOles+e5m0yyZt6+V+WLA+XC
	 74d6icw3xa3YQ9PP3ailtF2yoUKCMFiKTDniOiTIpL3L/+qlgj4rBEGxEhDJaTEZSy
	 klRvNET/Djb2yA3Gkogfe3w8PXklTD3uvWr5plwe5cIJU/229Hd6qKM9p3bNFnRmUn
	 JBbtJnrGM/kqv35aHoOKPz44PheZdqJxi7o9WKSzEqzvOto0lucDok9kfDupDIBE9q
	 lUXhTXde3010QOmdUp8XFvoIl9vjubFDek08IXUxaC05wTiErdL4JMpW8aORAp+0Mq
	 dSkeqgPuuo9MQ==
Date: Sun, 27 Oct 2024 09:54:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] iio: chemical: bme680: avoid using camel case
Message-ID: <20241027095438.1e523caf@jic23-huawei>
In-Reply-To: <20241021195316.58911-4-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:06 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Rename camel case variable, as checkpatch.pl complains.
> 
> While at it, fix also the indentation of the array for readability.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

> ---
>  drivers/iio/chemical/bme680_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 0b96534c6867..d228f90b4dc6 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -438,15 +438,15 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
>  	u32 calc_gas_res;
>  
>  	/* Look up table for the possible gas range values */
> -	static const u32 lookupTable[16] = {2147483647u, 2147483647u,
> -				2147483647u, 2147483647u, 2147483647u,
> -				2126008810u, 2147483647u, 2130303777u,
> -				2147483647u, 2147483647u, 2143188679u,
> -				2136746228u, 2147483647u, 2126008810u,
> -				2147483647u, 2147483647u};
> +	static const u32 lookup_table[16] = {
> +		2147483647u, 2147483647u, 2147483647u, 2147483647u,
> +		2147483647u, 2126008810u, 2147483647u, 2130303777u,
> +		2147483647u, 2147483647u, 2143188679u, 2136746228u,
> +		2147483647u, 2126008810u, 2147483647u, 2147483647u
> +	};
>  
>  	var1 = ((1340 + (5 * (s64) calib->range_sw_err)) *
> -			((s64) lookupTable[gas_range])) >> 16;
> +			((s64)lookup_table[gas_range])) >> 16;
>  	var2 = ((gas_res_adc << 15) - 16777216) + var1;
>  	var3 = ((125000 << (15 - gas_range)) * var1) >> 9;
>  	var3 += (var2 >> 1);


