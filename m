Return-Path: <linux-iio+bounces-7974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405E93DF9F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8EE1C20CD8
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C03139D15;
	Sat, 27 Jul 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEfsFHbD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AD80C09;
	Sat, 27 Jul 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722088535; cv=none; b=Shpz0X/UVAD1dqpi0DK6sNkOhIjGA6OQQE3xC799nMFr1Mu8FZ9BfWSHrLFMrYoRVrEqtblx6Gb8OztKpoRx6e/JgEPFovGzWDW84TZoqQIpcKh3uCwhhM36kTVYX16mBEi4lkdLbHH4uWSZ9fOncROmjwD4l/Sli8J1L9MVh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722088535; c=relaxed/simple;
	bh=lffS303vInQWnqG2tO7/2bEeOVcOncIyYoFx+NpW+bo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saUe+sCNiaTkKJZ++vjkWWn5mYgqDCkeX3dl2FkHi2iGjDGJp6cgw8pZS2eC2Xp4ef1KbMd9qy0O1NnvnfllNAj2bWLRtc+OtdS4KzdaH1TLO1gvQvkwbZTtNp+mM/m49K74UbhFCsno+K1swVPi+agLq1iWd63Kc6xphfKGRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEfsFHbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131A1C32781;
	Sat, 27 Jul 2024 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722088535;
	bh=lffS303vInQWnqG2tO7/2bEeOVcOncIyYoFx+NpW+bo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mEfsFHbDYOSdw42ojEqil9ytqL9jJn3nRq/O0t4Q9u5mKuwV3EZZbHeL2K1lAwsKl
	 ZTGlgRVBncLxfuY9bA2KuZSjfq/4IrtKL7o4SbZMKgKuulWpIyg1rnRHnXkBNVFdl/
	 A1sZoxxnHc7Q46apXIzBxdiNviv2mNjzJEdbz2OOj5hwgpSHr8GHOwD7wIzcpG/rSJ
	 PuouXvy6D3J/29ewD2NChYWJnJdxMZdvHE0xmFXFuxLpT+oMYJpAcEChUScPhijQiO
	 eWdXjgQ34+g0SVsMiHf3kcuSfn0bz/y81ToUHjV21HgkQgqqdj7U89YRfLBE95Jj+z
	 L0gAAdIcB1L9g==
Date: Sat, 27 Jul 2024 14:55:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer-dmaengine: fix releasing dma channel on
 error
Message-ID: <20240727145530.51b72e6e@jic23-huawei>
In-Reply-To: <20240723-iio-fix-dmaengine-free-on-error-v1-1-2c7cbc9b92ff@baylibre.com>
References: <20240723-iio-fix-dmaengine-free-on-error-v1-1-2c7cbc9b92ff@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jul 2024 11:32:21 -0500
David Lechner <dlechner@baylibre.com> wrote:

> If dma_get_slave_caps() fails, we need to release the dma channel before
> returning an error to avoid leaking the channel.
> 
> Fixes: 2d6ca60f3284 ("iio: Add a DMAengine framework based buffer")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

J
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 12aa1412dfa0..426cc614587a 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -237,7 +237,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  
>  	ret = dma_get_slave_caps(chan, &caps);
>  	if (ret < 0)
> -		goto err_free;
> +		goto err_release;
>  
>  	/* Needs to be aligned to the maximum of the minimums */
>  	if (caps.src_addr_widths)
> @@ -263,6 +263,8 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  
>  	return &dmaengine_buffer->queue.buffer;
>  
> +err_release:
> +	dma_release_channel(chan);
>  err_free:
>  	kfree(dmaengine_buffer);
>  	return ERR_PTR(ret);
> 
> ---
> base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
> change-id: 20240723-iio-fix-dmaengine-free-on-error-6e6e8b4dd058


