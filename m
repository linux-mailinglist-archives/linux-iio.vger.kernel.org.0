Return-Path: <linux-iio+bounces-10253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA6991EDD
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0715F281B10
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC296CDBA;
	Sun,  6 Oct 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYE/baFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09361BC5C;
	Sun,  6 Oct 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728224743; cv=none; b=qRlwwLX+AAo7JKx/opEKgMzo4anq15X0Cew8uTKpKgS+cKhQcC40UkQ9rUpXINnqsBzXFklIKPRpWiPTGTvZbftW7PNbxx8MiXftX2CDatPn8RHvhPBw6iHG9ZxjYhLodUFoQtznkBB+Acb2UhnChn+g92eNtFxhKOaMCQVCryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728224743; c=relaxed/simple;
	bh=VkvN3Ikd1Kd8c5idpilxjQqs75DVPd/LG7krmaFwONU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcpgJR5/SjC4FRD/UARp2G9vTWZUmLzJTMtYDUrBtVQpcD5EHFhFkirXC8clgENmYb7uhm30gW2Iwj5J18GAEPF+kKwO/DwY1fiudR7YxzsQnNWBo4+Da0w8dOhR9gNgm624ODS0AO6iv3r02WO86c0zcLbOY/90aeAhHPz+c5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYE/baFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94E8C4CEC5;
	Sun,  6 Oct 2024 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728224742;
	bh=VkvN3Ikd1Kd8c5idpilxjQqs75DVPd/LG7krmaFwONU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OYE/baFK1amumWqel3sL8cMrJ8BB4n0ctqFm30il2gTUlWfbP1utk2b+XSdLbQjG4
	 i6jezwXJNyoccxd76beQTaw4RmybG23uouRxlEeWey4MpPK4QF6Zg/Mmtb7OTsn6KF
	 xu8KyAgxvKN79tzldYlmyckCWOVNADFSmdvyHc0okMwJRb7263Ha439IVH98JDLw3g
	 nJI3WKKKu6vjV1snRY2D0TVe9hoib6PAGIjv0/cprnIRSjseXu5QHq8K0kQuXDrv+e
	 tE4Rn6wTA7D+xZdbmI+tPHPVGUtA/kZzpTd3T8FTtAOUG5jImh2IdSF07fLjKJ0ks/
	 521GNOiyw4Lxg==
Date: Sun, 6 Oct 2024 15:25:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Hennerich <michael.hennerich@analog.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iioc: dac: ltc2664: Fix span variable usage in
 ltc2664_channel_config function
Message-ID: <20241006152533.329d9b59@jic23-huawei>
In-Reply-To: <20241005170722.19542-1-pvmohammedanees2003@gmail.com>
References: <20241005170722.19542-1-pvmohammedanees2003@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Oct 2024 22:37:22 +0530
Mohammed Anees <pvmohammedanees2003@gmail.com> wrote:

> In the current implementation of the ltc2664_channel_config function,
> a variable named span is declared and initialized to 0, intended to
> capture the return value of the ltc2664_set_span function. However,
> the output of ltc2664_set_span is directly assigned to chan->span,
> leaving span unchanged. As a result, when the function later checks
> if (span < 0), this condition will never trigger an error since
> span remains 0, this flaw leads to ineffective error handling. The
> current patch resolves this issue by using the ret variable for 
> getting the return value, later assigning if successful and also 
> effectively removing span variable.
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> Fixes: 4cc2fc445d2e4e63ed6bd5d310752d88d365f8e4
> ---
> v2:
> - Using the ret variable to store the result from ltc2664_set_span
> ---
>  drivers/iio/dac/ltc2664.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> index 5be5345ac5c8..7dafcba7ece7 100644
> --- a/drivers/iio/dac/ltc2664.c
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>  	const struct ltc2664_chip_info *chip_info = st->chip_info;
>  	struct device *dev = &st->spi->dev;
>  	u32 reg, tmp[2], mspan;
> -	int ret, span = 0;
> +	int ret;
>  
>  	mspan = LTC2664_MSPAN_SOFTSPAN;
>  	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
> @@ -579,20 +579,24 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>  		ret = fwnode_property_read_u32_array(child, "output-range-microvolt",
>  						     tmp, ARRAY_SIZE(tmp));
>  		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
> -			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
> +			ret = ltc2664_set_span(st, tmp[0] / 1000,
>  						      tmp[1] / 1000, reg);
> -			if (span < 0)
> -				return dev_err_probe(dev, span,
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
>  						     "Failed to set span\n");
> +			else
else is unnecessary here as we have the standard check and error and return
if set pattern.


> +				chan->span = ret;
>  		}
>  
>  		ret = fwnode_property_read_u32_array(child, "output-range-microamp",
>  						     tmp, ARRAY_SIZE(tmp));
>  		if (!ret) {
> -			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> -			if (span < 0)
> -				return dev_err_probe(dev, span,
> +			ret = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
>  						     "Failed to set span\n");
> +			else
and here.
> +				chan->span = ret;
>  		}
>  	}
>  


