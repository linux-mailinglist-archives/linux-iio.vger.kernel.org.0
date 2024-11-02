Return-Path: <linux-iio+bounces-11843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE1E9BA111
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4691C20833
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3F19F131;
	Sat,  2 Nov 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn0eM4cp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF9185936;
	Sat,  2 Nov 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560709; cv=none; b=lpV+s2Qfk84LoXfH6kHv4wqr7V47+4/dpvRy0wUU9rLSKoK+ZXtvdLZGfWp8zBvX4gpjYiO4bzJnOrwyLgGflmItuKII3nmm3D39FyheY2tiXp5NHdggZqPFzFTk+jVkGi9UxiAFj+1cG1XVB3g8V/rNJ8cqC4BMU2mG4po68H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560709; c=relaxed/simple;
	bh=eBQzoo1AquovwalhpTStAoXAQHeDO1nu2xL8O6GPt7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=If5UtHemuCUTLrilyFYavV6H8G7c7PhkHLh5iL8qg/F5Sowzhj+3CZIAQkT6aqWJjT/aN4qycfc+1wECgw6m7TLVenQhGkQ5GTS4MfDiCoVk8zrPK1nw7s3ahIuRq8aSL0fE+z+/7NpQeCbbVR5ovNkWe1Ne5OmlltI4EJvnSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn0eM4cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30F9C4CEC3;
	Sat,  2 Nov 2024 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560709;
	bh=eBQzoo1AquovwalhpTStAoXAQHeDO1nu2xL8O6GPt7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xn0eM4cpt6M27s7cRuMbvHByBxbLr/RNfhxjkB4yu/gERmMsKpl00RLj7ajK0ZlwE
	 n3z0aTMBJyAgwISPxa9ZVHatoczR5V9pme8DPbCzf1WEN9SZRsZFvcYstCC+C4DTl3
	 uSL6BVIIkAvzEFyC335iwU+pFk9kazYJF/KLEbLxT1qrrl1MB3AeyIKZywn+coArlw
	 SejmMG5htFUZ0TcN56B8b/gjMkksU7nlDKQzC6eXm478IKxlraB18+dClqRtPwPjM8
	 qui/tYz2j3CfsW072oN5JKAUfUKDBBHUjU7XpJEiyNfHdYNtprN8nVIMzSkhsUVOAC
	 B6l8qStFYe2lg==
Date: Sat, 2 Nov 2024 15:18:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: <lars@metafoo.de>, <nuno.sa@analog.com>, <andy.shevchenko@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <tanghui20@huawei.com>, <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>
Subject: Re: [PATCH] iio: Fix fwnode_handle in
 __fwnode_iio_channel_get_by_name()
Message-ID: <20241102151820.609347ba@jic23-huawei>
In-Reply-To: <20241102092525.2389952-1-quzicheng@huawei.com>
References: <20241102092525.2389952-1-quzicheng@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Nov 2024 09:25:25 +0000
Zicheng Qu <quzicheng@huawei.com> wrote:

> In the fwnode_iio_channel_get_by_name(), iterating over parent nodes to
> acquire IIO channels via fwnode_for_each_parent_node(). The variable
> chan was mistakenly attempted on the original node instead of the
> current parent node. This patch corrects the logic to ensure that
> __fwnode_iio_channel_get_by_name() is called with the correct parent
> node.
> 
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 1e64b9c5f9a0 ("iio: inkern: move to fwnode properties")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Hi Zicheng,

Good catch. I briefly wondered if this was unused code.  It is
used, just not that much and it seems not on boards anyone is
testing.

arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts

Anyhow, fix looks good to me. Applied to the fixes-togreg branch of iio.git
and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 151099be2863..3305ebbdbc07 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -269,7 +269,7 @@ struct iio_channel *fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode,
>  			return ERR_PTR(-ENODEV);
>  		}
>  
> -		chan = __fwnode_iio_channel_get_by_name(fwnode, name);
> +		chan = __fwnode_iio_channel_get_by_name(parent, name);
>  		if (!IS_ERR(chan) || PTR_ERR(chan) != -ENODEV) {
>  			fwnode_handle_put(parent);
>   			return chan;


