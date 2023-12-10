Return-Path: <linux-iio+bounces-798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8D80BB13
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F7280E16
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F836C2D3;
	Sun, 10 Dec 2023 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMDWKvtF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA76FBC
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 13:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47975C433C8;
	Sun, 10 Dec 2023 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702215154;
	bh=648SWHIYNJDT/+aiucrXnkcL7Mil/8x5gJTHL49sKWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pMDWKvtF+c+gtQLFvWS7ZcoEriiLmbqJDSvCnPeAuqmNmIs6jVsQrCrFItuDo+o0u
	 XKsWQeK2qjQInSI+oT9SGX2cLtX8onqoETF2EldZuU1uWUOgjP3UF3Uvb2ztp0VXvr
	 qlVlrvRGYbtkzSR6q5N+s/0710ZAiGWs1KywxDmJK9XnWlFkMaPh4T1hI8uGj2OIWO
	 DrQmxNzCxuAtMjk9z4H/nertu0v9pHWH952DH3W3rkkUoKWVeI6yFK/Fcq08gbQUrk
	 puPyFEDILYjoqEHwz0Gdw8CFwo11Act6UIVgJ/1GMEW4f3jl7mBhqPF+VnE3Q6Fnsc
	 jodWG3KoIWGxg==
Date: Sun, 10 Dec 2023 13:32:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix memleak in iio_device_register_sysfs
Message-ID: <20231210133228.5fd425ea@jic23-huawei>
In-Reply-To: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
References: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Dec 2023 15:31:19 +0800
Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When iio_device_register_sysfs_group() fails, we should
> free iio_dev_opaque->chan_attr_group.attrs to prevent
> potential memleak.
> 
> Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Hi.

Looks good to me, but I'd like to leave this one on the list a little
longer to see if anyone else has comments.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index c77745b594bd..e6d3d07a4c83 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1581,10 +1581,13 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  	ret = iio_device_register_sysfs_group(indio_dev,
>  					      &iio_dev_opaque->chan_attr_group);
>  	if (ret)
> -		goto error_clear_attrs;
> +		goto error_free_chan_attrs;
>  
>  	return 0;
>  
> +error_free_chan_attrs:
> +	kfree(iio_dev_opaque->chan_attr_group.attrs);
> +	iio_dev_opaque->chan_attr_group.attrs = NULL;
>  error_clear_attrs:
>  	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
>  


