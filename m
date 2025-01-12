Return-Path: <linux-iio+bounces-14212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65519A0A9FC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5082E3A22DD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6491B6D16;
	Sun, 12 Jan 2025 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1YKP3pv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6329CA;
	Sun, 12 Jan 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736691637; cv=none; b=ep9/TEN7Kvg9IfH3RsYqPV59k+va5et3gWbO/gK4PRu9+Iy1amqTQmx40VlIqP76i6onSF7E+GwjRdInfaQDfCuUmqp/OtdIdZhYQDIV6Fb7JAZJZIpw9Ae/UXe+Eywv8Esw5N863ucREBgDoCQDQF2l+HuUsUMq5xfOir5AZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736691637; c=relaxed/simple;
	bh=66ngCBLt93WP2l4rkR5ifZvhPuzfXxlc5RHpvkj3uec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBGRVVKSljpalfIBbQCM7WOWhecHLazYChgz170g+YSZx8LBsgfgr35P4cAlTVtpIIyqrt/OJzhdBLN9oOzbJXYajwkl3zniysAcqFVpJarvZ5FnfCHthB7ArVHCc/m1Itm0BvBelk9vo2NnE3hLVc2MolvoYBaZyAPR71bI3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1YKP3pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EBCC4CEDF;
	Sun, 12 Jan 2025 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736691637;
	bh=66ngCBLt93WP2l4rkR5ifZvhPuzfXxlc5RHpvkj3uec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1YKP3pvFqqMaKWRANI8iKTZw46clO+jgAybpB8uKS4GiMujZf135uvg/UG32tZ2G
	 LQFJ8yuKMTTTxmE/9whteD/WhG4+p5tvh93r/TfdWlWBhGtKvpltRA6TQLZLOwarfv
	 1Iqn3OWr2HOAquTe+r4iBoY2iV5qD7aqxIYShvxE4BOK1BYzeulLgiPBIrCW1EZVgW
	 1bK3pMKXp4OAeEUrGNPKr0KydopUTSOBpI37G1dPTt6LsiPEE3m0v6w7CrqWARzgZb
	 q1OpE2/3nlXmscl3hbI557B9EDSU5m/RL+7gGzTshpkacaSm3qz5keshacXw/HhkOD
	 9OPbwtSNO46ZA==
Date: Sun, 12 Jan 2025 14:20:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iio: dac: ad3552r-hs: fix message on wrong chip
 id
Message-ID: <20250112142031.6979dc64@jic23-huawei>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-5-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
	<20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-5-2dac02f04638@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jan 2025 18:29:19 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Set a better info message on wrong chip id, fixing the
> expected value as read from the info struct.
Trivial but please wrap closer to 75 chars.
Makes not difference here, but in long logs of commits
it can help and it is good to be consistent.

Jonathan

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-hs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 8974df625670..27949f207d42 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  
>  	id |= val << 8;
>  	if (id != st->model_data->chip_id)
> -		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
> -			 AD3552R_ID, id);
> +		dev_info(st->dev,
> +			 "Chip ID mismatch, detected 0x%x but expected 0x%x\n",
> +			 id, st->model_data->chip_id);
>  
>  	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
>  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
> 


