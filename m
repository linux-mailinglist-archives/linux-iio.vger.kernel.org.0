Return-Path: <linux-iio+bounces-13665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D439F80C8
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC69E1637F1
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12699166F0C;
	Thu, 19 Dec 2024 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjoQQ/gT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378686337;
	Thu, 19 Dec 2024 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627296; cv=none; b=eqmBw+tnkcivVIAtwc+2+kMSYMi5YV8bVWc+PHHunltVYbEBnpWSg0JgcHmoT92eO0+csbFvMLepHXBZHyqx6HcpuTaEivzPFJrVW49bb8tOlpnC5w3hPo7UEDG0LXt8WVPiKwAkUTb78PHmOM0apczPHjM18TBPFaTpS9poKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627296; c=relaxed/simple;
	bh=ic8ka99ZQbaN5a2Pm/izVtmdcls/9NCzxAL2V4qMVZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTxuaVDID90IiSm8nd0TBltJ3Hv7Ej0bgCMuJYnjmUG/8uSYiBShsITefNLNoniwN1sFI3BiI/zh0sd/wafn1QCmeOFjFtEJANp94e21rSsJnXV6AvdW4ohCWGRiQDhgnJ99gCPbNCkBYzgaWQoHWE2dz7a83QmHXjB0n6GuZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjoQQ/gT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86789C4CECE;
	Thu, 19 Dec 2024 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627296;
	bh=ic8ka99ZQbaN5a2Pm/izVtmdcls/9NCzxAL2V4qMVZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IjoQQ/gTKEvyFTmEbVAbEfBt4YQysEgyC40BZz5xq1fvK04Ix90uSaBayrDBLjHKq
	 bDmwLT6KCU0OQ//gZOgvlEaUtzC8dAUfIo2kPNgF6/JxrCFv1AoXXImV8N4n8DVgwR
	 iFzEh7zpSrvALW0FIG+zxGMU+SnZ2SYQWrZNyKXenki1/sPyhxL/bevAK4aq9XPft8
	 TcmAbK9LYxFYsC0Q4/oeU4GnrMQyf7EPEumJ5x1ItH2rYv5FjCxFSUQ/5v/eJ75zH0
	 zn55ZprsuReF52BhK4wfGUkbPJeslnk/jf0dS62qpCf/a9jStnL9GI4q+rl2n8TOZp
	 Wddw1GkhH/qaA==
Date: Thu, 19 Dec 2024 16:54:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] iio: dac: ad3552r-hs: exit for error on wrong chip
 id
Message-ID: <20241219165446.7b8d0a9a@jic23-huawei>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-6-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
	<20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-6-856ff71fc930@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 21:36:26 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Exit for error on wrong chip id, otherwise driver continues
> with wrong assumptions.
Why? Chip ID does not define all future compatible parts, just the
ones we know about today.

The reason not failing is that the moment we do exit on a mismatch
we can never support fallback device tree compatible IDs.  Is there
no chance that ADI will release a backwards compatible part in the
future that we'd like to work with old kernels?

Any mismatch in DT vs hardware present is considered a firmware
bug, not a kernel problem.
We used to reject missmatched IDs but after a long discussion with
DT maintainers it became clear that broke their model.

Thanks,

Jonathan

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-hs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 8974df625670..e613eee7fc11 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  
>  	id |= val << 8;
>  	if (id != st->model_data->chip_id)
> -		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
> -			 AD3552R_ID, id);
> +		return dev_err_probe(st->dev, -ENODEV,
> +				     "chip id error, expected 0x%x, got 0x%x\n",
> +				     st->model_data->chip_id, id);
>  
>  	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
>  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
> 


