Return-Path: <linux-iio+bounces-13230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8D9E86B0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA1D1884DA0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FAF1537A8;
	Sun,  8 Dec 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifxCmp3A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386420323
	for <linux-iio@vger.kernel.org>; Sun,  8 Dec 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733676591; cv=none; b=iDgYCUaGrWWbAWSPwq00SwcrJ+EOR8KF/sj7LNcoLh5Z3dWQVRK8d4DwooMI7J55M2NfXcCN+k3+cnyggZpSr+RlP6O2VTjOOeX7nrs8ZMtIKe6B4snHVyzfYk4MoC/6Q3T5ROjo0awRFrENBHNUsxzTrEOezV9P+0HYCusih3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733676591; c=relaxed/simple;
	bh=WepDuhslJBKFgh6c2ACZni9/UT5PoxAw0zgPB8rMnAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB45oEgCSFvKitS3Z0zjxiOjRRyg1MJoyAkVmacAwVvcjAvx0Hba8p9yLIpOTRMLfxsSUvlZER3g8BkL1BKXn00gz4RCsVNEC1ZiQQ5fOUs5GQ+ksuKZv39GNwAfICp92tzu5OKBSqvmeKg8C5vcMbqABNQ4Hm95o8z3H+KuViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifxCmp3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7266C4CED2;
	Sun,  8 Dec 2024 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733676591;
	bh=WepDuhslJBKFgh6c2ACZni9/UT5PoxAw0zgPB8rMnAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ifxCmp3AOK3dOCGTj5QTqlV491On2FKNe6hx6OXDBOyLb/ONBrNjDH0Ni4Vnqhpmh
	 keeC9uDgIRFiJE+dEsd+JCePl3FUuvHH0pOeSx/BJ8lGHZhYyPxKDKUnpGbhC4cbt6
	 lHRjm76TkokRx43itJaQ4YXm2HLMeu3PYzkVnltaAHPYmXVJuVl0pWOB2d+DgeIIQC
	 rkSZo2XZ4TtVDTXjG4Cd5B0pOsugNXTPe5R938pyOuXpg6vaqI5E9YJMiDZO8iPSWu
	 UA2UiFEkCvh+Cb42oKS10oicItsIh1oQYRMeVHLWS3qB7k7YVG7HrUcsExm380bXaU
	 /VgKSFzJ7WT7Q==
Date: Sun, 8 Dec 2024 16:49:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: call iio_device_put() only on mapped
 devices
Message-ID: <20241208164944.6fcee6c8@jic23-huawei>
In-Reply-To: <20241204111342.1246706-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241204111342.1246706-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 20:13:42 +0900
Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:

> In the error path of iio_channel_get_all(), iio_device_put() is called
> on all IIO devices, which can cause a refcount imbalance. Fix this error
> by calling iio_device_put() only on IIO devices whose refcounts were
> previously incremented by iio_device_get().
> 
> Fixes: 314be14bb893 ("iio: Rename _st_ functions to loose the bit that meant the staging version.")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 136b225b6bc8..9050a59129e6 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -500,7 +500,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  	return_ptr(chans);
>  
>  error_free_chans:
> -	for (i = 0; i < nummaps; i++)
> +	for (i = 0; i < mapind; i++)
>  		iio_device_put(chans[i].indio_dev);
>  	return ERR_PTR(ret);
>  }


