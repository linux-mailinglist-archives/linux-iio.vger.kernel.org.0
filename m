Return-Path: <linux-iio+bounces-9303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F5970350
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 19:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEFE2831ED
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7E161902;
	Sat,  7 Sep 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L70dQnAq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DF40BE5;
	Sat,  7 Sep 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725729491; cv=none; b=OYhAwSDGn4knMt8ufsvHvBvPAJnGAr56dTiCFzS8qu8SYNW8BBpKDP42U4TtEcMkYvcv2QV47Uh+IlKGZTJ09H4z0ZEzBJ9TaRJTDEi0yLTBQrxkN3Zr6N8Qpn3mSrtbBJIV6vGlOmChW1IW9K9zC174kL/yTvKmsGt9m/CW4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725729491; c=relaxed/simple;
	bh=6nO/2jZ6ballFTuHFc/CYyoTZ/XdNPP32Q2kT9ibE7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJkZTLCfPrjDFrfVPS/MiKPpOp+kfxbXx/swS8YlOqVKJLyjRki8o23EwS2++v27B+jUY9bOQXoFk63rJVHCzqdvHADktv23/gMlNgCdL9OHvkqCcxBFErnNyt2yiQYPkVGwlYSVAMmG6EEVODM8oFO7fC5kDshMDOrZaSBSyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L70dQnAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410EAC4CEC2;
	Sat,  7 Sep 2024 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725729489;
	bh=6nO/2jZ6ballFTuHFc/CYyoTZ/XdNPP32Q2kT9ibE7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L70dQnAqI14SxVZGq8uI12mC/Lr+kTcv18aG/Bxjt4megCvT7yi/1bqueFOGotDdQ
	 IBaJgoy4Kebeu0eVPQdEQRIjDh9jubtlCcgV6IZevhRv3hQhsWpP+jKKVSDGSzwCRr
	 rYmh09X535+LKZNyIYkjTnRTbI0RE0ryrvZPSaiG1kGh0SaKc4IWF9/bhFjAa1Yc4E
	 NrAtqIV2BWYJRRVR2VbjOlae1cEhsMTTeVREE2aAJXmVdZ2L+WyiqEP1ZdW/bjlG4s
	 1SCKOtvD4AsHuHS38SXZSUJNpgbtxIhRejNw3frnmp5Qoha43nufgi/lQhbcSj7cFG
	 Qyzs7dnL5tL9Q==
Date: Sat, 7 Sep 2024 18:17:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tsai
 <ktsai@capellamicro.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: light: cm32181: Remove duplicate ACPI
 handle check
Message-ID: <20240907181750.78b27e6f@jic23-huawei>
In-Reply-To: <20240904183646.1219485-1-andy.shevchenko@gmail.com>
References: <20240904183646.1219485-1-andy.shevchenko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 21:36:46 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> cm32181_acpi_parse_cpm_tables() is a no-op if ACPI handle
> is not available. Remove duplicate ACPI handle check at
> the caller side.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Hmmm. Not the most obvious code give it relies on an error
being definitely less than the header size, but indeed it
will error out if the handle isn't there.

Applied.

Jonathan

> ---
>  drivers/iio/light/cm32181.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 9df85b3999fa..aeae0566ec12 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -217,8 +217,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  	cm32181->lux_per_bit = CM32181_LUX_PER_BIT;
>  	cm32181->lux_per_bit_base_it = CM32181_LUX_PER_BIT_BASE_IT;
>  
> -	if (ACPI_HANDLE(cm32181->dev))
> -		cm32181_acpi_parse_cpm_tables(cm32181);
> +	cm32181_acpi_parse_cpm_tables(cm32181);
>  
>  	/* Initialize registers*/
>  	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {


