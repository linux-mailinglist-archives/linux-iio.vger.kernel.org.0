Return-Path: <linux-iio+bounces-11523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B949B3BF3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2251C21EF6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379BA18E03D;
	Mon, 28 Oct 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnNI4V26"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07DB1DF991
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147797; cv=none; b=Xt90rRReDOAyW+16ZyWg/IDI+s+cbBkZHX7xWPcr4PnmcjLKHCBXZZ6qt0YW6KpzV7XiYL2oZEiOOo6d38/VAFvrK4JzNMkiywaCaXK9cRyafLdvWIXDJSQan3A/Cd54R+150qBlpQMod9xtWu0FJdl4GtVS8zjqHMF+HEytRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147797; c=relaxed/simple;
	bh=L6QQmzQigDYqpEPupXUcllQS/3BBBeYPI99k5yFDgqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdCLpHX2LBU995wOWub8B3BpBJWvOvdk5cvOvaKXe9LkRK2lFcAyuQ1Gd6BqTQuEa0wvjAeVf0DNDQDDHdYgFrYo5sWGyVSDggJ7nEQHDJwMqb3Kqd9wL4gMUp2TdI0RWQNEiTV0r99/c/rlFdq12qzVtD3chffa3BC9tBdE4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnNI4V26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5805DC4CEE3;
	Mon, 28 Oct 2024 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147796;
	bh=L6QQmzQigDYqpEPupXUcllQS/3BBBeYPI99k5yFDgqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pnNI4V266EIjMsDIgCQ8uUE2Y4UMIb6qbf2FxXGxnbrSd3fk470gfnKTJ01m3wk7r
	 N4dMddItfPVwZC4zgxyhHHAIDe8lzm1MbVPs0c9YmVd+DfVIbXhaaZ4IRmfAoZQN7I
	 L3JW6MTqqNygUbE7knSAEzBFVNFl2VlpJVVYm08EPtMnE/bcFTkht5Wc9I9s7bv2NK
	 2xYqrAQvNNhq0CKLTgEpMCBZTUdZIYZkMXsIYlg3wCEUtWwCEWFZH/9/mr3luuMC1k
	 uIqIaWaOhZOMplzpxw5NPkgGz2TbEnrlbzrFCls+DV1OTV/KSa6CTLnj+IQiw1JBBx
	 ZwzkB2v8gOPgw==
Date: Mon, 28 Oct 2024 20:36:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: nuno.sa@analog.com, olivier.moysan@foss.st.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, yangyingliang@huawei.com,
 bobo.shaobowang@huawei.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] iio: backend: fix wrong pointer passed to IS_ERR()
Message-ID: <20241028203628.2b76cf5a@jic23-huawei>
In-Reply-To: <20241028135215.1549-1-yangyingliang@huaweicloud.com>
References: <20241028135215.1549-1-yangyingliang@huaweicloud.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 21:52:15 +0800
Yang Yingliang <yangyingliang@huaweicloud.com> wrote:

> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> It should be fwnode_back passed to IS_ERR().
> 
> Fixes: c464cc610f51 ("iio: add child nodes support in iio backend framework")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Thanks.

Applied to the fixes-togreg branch of iio.git.

I'm not sure if I'll get another fixes pull out due to some upcoming travel,
but if not I'll queue this up for the merge window instead.

Jonathan

> ---
>  drivers/iio/industrialio-backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 20b3b5212da7..fb34a8e4d04e 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -737,8 +737,8 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
>  	}
>  
>  	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
> -	if (IS_ERR(fwnode))
> -		return dev_err_cast_probe(dev, fwnode,
> +	if (IS_ERR(fwnode_back))
> +		return dev_err_cast_probe(dev, fwnode_back,
>  					  "Cannot get Firmware reference\n");
>  
>  	guard(mutex)(&iio_back_lock);


