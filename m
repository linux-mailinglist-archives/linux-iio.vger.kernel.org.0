Return-Path: <linux-iio+bounces-16880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9CA631DD
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82D6173E1C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2370192D9A;
	Sat, 15 Mar 2025 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb4GEsC+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007815573F;
	Sat, 15 Mar 2025 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064512; cv=none; b=hCYxuhZQa2cYZ75KgHlzSChSms/Dz441Ul5q1PFkwdgjxfIqiCRryXExzTs6vgY/OSsFjJV9cEluKWRaQJ/84UQtft2IHYvRnNmJrhPuYKPJyRuYUnD2CGZZ9enyb4ufrusp8uoTfBPVyk4vopgryXQzvs2H/M1OxABoDUMdUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064512; c=relaxed/simple;
	bh=I2sWxstsdFpKfWRB9vfgVYsGA4jY4+sCJ/SKLr49OGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmrXIxhbPtPYapeILZHt/C/3bMYuaUB2QczFgS1LuVFGv7pTAXnO3B119tl0T/wq41eCkeNkXqTGaCd8k0pH9NbW3i23aCNLcfQ85x7a5hR5vLYLXbWkpbak0CHdnTv/apG2HgtiM/MU2wLCeoofe3PWvwqZXWHDD9Nj94YUnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb4GEsC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9143C4CEE5;
	Sat, 15 Mar 2025 18:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064512;
	bh=I2sWxstsdFpKfWRB9vfgVYsGA4jY4+sCJ/SKLr49OGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cb4GEsC+XHM+ipx8v3YZETqqwUxLbUmARdDiIVinKcIGPjRm6EDT1LVM/vypSo7E2
	 de309eeLEuknsW8UHpIZxSZLcxXHTt0w4VPap/fL6B4UPh8Olsz3f1ZTvfohAEekRa
	 b3w3hKBtzmwA7vRHCOxVmLZyPUj1R2pRSn26YXp2zY6jQKOIvoTl3BKNz4M/M9xOm6
	 hxy7yTWNjkXBvMM0l9SNhKpkUKfk4NrZ172ZJMlnr5J/Fm0RgaNDUKEEAliYHn808b
	 1mWmiG9gJGaQznDSmzWx5YrQoDUVeqAL2DtPj0oKEttuZE2dO2uYQbHsbagevJtxpx
	 3q5jONAqLDXhQ==
Date: Sat, 15 Mar 2025 18:48:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iio: adc: ad7606_spi: check error in
 ad7606B_sw_mode_config()
Message-ID: <20250315184824.4cd068a7@jic23-huawei>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-1-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
	<20250312-iio-adc-ad7606-improvements-v1-1-d1ec04847aea@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 20:15:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add missing error check in ad7606B_sw_mode_config().
> 
> Fixes: d2a415c86c6b ("iio: adc: ad7606: Add support for AD7606B ADC")

Nice to have, but is there a path in which this happens other than
in hardware failure? If not probably not worth a fixes tag (which
tends to make people start backporting things).

> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7606_spi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 885bf0b68e7775c5f4a12dfb827f502d5f782e8c..c028e08efe2c82cd97249f98eec50a9a9c06471f 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -174,11 +174,13 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
>  static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	/* Configure device spi to output on a single channel */
> -	st->bops->reg_write(st,
> -			    AD7606_CONFIGURATION_REGISTER,
> -			    AD7606_SINGLE_DOUT);
> +	ret = st->bops->reg_write(st, AD7606_CONFIGURATION_REGISTER,
> +				  AD7606_SINGLE_DOUT);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Scale can be configured individually for each channel
> 


