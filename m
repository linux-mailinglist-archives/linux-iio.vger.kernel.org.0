Return-Path: <linux-iio+bounces-7981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10AD93DFE1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 17:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714D01F217DC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F917D373;
	Sat, 27 Jul 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdeVVwem"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FE1E521;
	Sat, 27 Jul 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092931; cv=none; b=RzXn3sknzCTy4hUIPmU2Z5inzWA+QUVb2U8NzXRb6r+l/bvfrsuSu5go2mt/whs5T019zd84ef7sYh1BEmZDOfF/QqmOC9F6DO4wEobX9bK2FtzfoNHh+k8fAezJnXyS5Esaa5lknwcv41FOx7/tykkMIBFOf+NXwjfR+MIQ8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092931; c=relaxed/simple;
	bh=Gxx9fjqRR0M6NRF6KXCKoSZ/x9OaIlCJizEOVYY3p7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlgIjqYOXBzwuX0Fa8yFQxg0G60KkQU1jmhsvi6JOhr0XQ8F61pVUq2duuZElHeDRGdI3MtuD6Cgl7OgsHxFWrhIpO63SDdMHcCJHQA3Z12WC4E8nvAKeC44U8Xcdt7bpoMg32xX0ODlnDnmK2jq5KbEchgguzQVz7LfAVZDMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdeVVwem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FC1C32781;
	Sat, 27 Jul 2024 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722092930;
	bh=Gxx9fjqRR0M6NRF6KXCKoSZ/x9OaIlCJizEOVYY3p7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HdeVVwemANAbOjrOwA8UizeoHhLdB6NOr09ggJdlOtQvh0exilIXVk+4rTTSEhGiu
	 3lmpO0BjX9NBmLXqLfZlkb+10zRWoBmdBECY928ZvejmuRnAWPeesIKty3iip0d76t
	 ZJbSdPShmVgjJXEXYZ2YVJTei7TlD0HjDnPGj4ShcWrQhmXX+cJ5a4G1L3M6Mf7K1r
	 qmzWKumCieWY6fNJTE2EzcqPH/dFPmkBoVwe0uSper/SHAYwaKpnnjTkMGAHgRx6Sl
	 3zKxnI8+q5DeUeJ46TNvLT+YROLynUGVPlmXDW0hOEhdIXSpgfky8RStW8thR5C6BI
	 QUxxpDWxCalfA==
Date: Sat, 27 Jul 2024 16:08:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chemical: bme680: Convert to static the const lookup
 table
Message-ID: <20240727160844.28875c92@jic23-huawei>
In-Reply-To: <20240725231818.615530-1-vassilisamir@gmail.com>
References: <20240725231818.615530-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 01:18:18 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> By converting it to static, we ensure that this will be placed by the
> compiler in the read-only area.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

> ---
>  drivers/iio/chemical/bme680_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 74ac887d8d8e..5d2e750ca2b9 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -438,7 +438,7 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
>  	u32 calc_gas_res;
>  
>  	/* Look up table for the possible gas range values */
> -	const u32 lookupTable[16] = {2147483647u, 2147483647u,
> +	static const u32 lookupTable[16] = {2147483647u, 2147483647u,
>  				2147483647u, 2147483647u, 2147483647u,
>  				2126008810u, 2147483647u, 2130303777u,
>  				2147483647u, 2147483647u, 2143188679u,


