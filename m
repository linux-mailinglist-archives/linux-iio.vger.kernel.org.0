Return-Path: <linux-iio+bounces-13663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941D9F8032
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F4816A105
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C0147C9B;
	Thu, 19 Dec 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUiMioZ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAF8634B;
	Thu, 19 Dec 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626757; cv=none; b=IbMKpWoHehipUh/HzWSkF01Eo3UX30GYPEx4Co+33VxlBRBrpCtwShFNpHCM4f6BP3qs7ZoMc9YfgiuzOIJfe9OD95LceBN3MDw20YhgOuCBooW2NG1AcztxlR2gUFJVJNfNpWSOQq+BEtDqdCUU1w+cGA54G2wpnkPf2j7cbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626757; c=relaxed/simple;
	bh=zKW1zc9Rmx9IGZqG9ZsJwswi5LQVIoBdu7GvXmR2ySE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkJ3LTl+Rg3oZGM9D/xT1Xa8JHcFeB9mScPUG53kfSYW2ij9TjMsGjKKB/GhOAPq1W4HTi7EWuXoHyWcj3ifJuChChXBzx1aAyk+pkN7aSYZjjEGi1OAycB45703QElY3UN0pxwvToMzm6LoTKuYyHHYHSAdJ1nfQqsMjaTotMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUiMioZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FFEC4CECE;
	Thu, 19 Dec 2024 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734626756;
	bh=zKW1zc9Rmx9IGZqG9ZsJwswi5LQVIoBdu7GvXmR2ySE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUiMioZ489E+4FrGRWPiRAmcXt/8sVyYY08D+WDSjK26TubceRWZh0LCbwPBsoX4Z
	 NWgxy2AQzaBFtDTUs47h5g0GxvP8jGiqfEMix3eKBtJB7WF6hdA7Es5E68P7+nc7EQ
	 zyiKOH+YsXijg6y7/X4xZPFb/tXExXs5apzTW1Xpk4D0TIWnu1JeN8YcUpVR94ZuEg
	 XWumEoeUb8oeCJKShlXEDRbjvaLIKhusG6OYdt0dPendUxG205upDwrWtpNCiYOdGD
	 EqNVd7uJN8YH6sByjP4oY50oBlNd29UDVAK9p3dWMrAF/C4xvkNO4xZ3dBeGSbRAAn
	 3nHtVyeYvQJHg==
Date: Thu, 19 Dec 2024 16:45:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iio: dac: ad3552r-hs: clear reset status flag
Message-ID: <20241219164547.7332d6f0@jic23-huawei>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-2-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
	<20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-2-856ff71fc930@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 21:36:22 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Clear reset status flag, to keep error status register
> clean after reset (ad3552r manual, rev B table 38).
> 
> Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Again, something on what the visible effects of this area.
That helps people decide whether to backport.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad3552r-hs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 216c634f3eaf..8974df625670 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
>  			 AD3552R_ID, id);
>  
> +	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> +	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
> +				      AD3552R_MASK_RESET_STATUS, 1);
> +	if (ret)
> +		return ret;
> +
>  	ret = st->data->bus_reg_write(st->back,
>  				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
>  				      0, 1);
> 


