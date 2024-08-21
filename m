Return-Path: <linux-iio+bounces-8659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C3A95A5EF
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 22:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8421C2100D
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 20:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F01216F8F5;
	Wed, 21 Aug 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPDwwUZZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF311D1300;
	Wed, 21 Aug 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272400; cv=none; b=JTGgMKSRE7jzrP0zI5Oj2Id+MLhgm2T8mpcOv8eVk5H0loQ+3D6S+6BfULk3co+RXdLDkrQ21kTFOnes7wjXtOZCuPqhEQhP7KMpJX/Esi6rOrNq3AbwQ/fhsSOx2OcZhq84j0Lovex5ZL0pWmNB3BhzLqqsDM3fIqx/AdzFIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272400; c=relaxed/simple;
	bh=6FgnecSR8VhM53DQzNcFPbHy9j3pLUxYx6mq7I3vquw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaVwuF3FDc7TocdKrKDPGwMGSWzvBpAPIVKz7ZLcKFYELgs2wL5gc1aM4AH12vkqZucBNa7D9vtWATzF2LD1WVtcYvX/oao6EA8HqGzMbzqOs8RN39fnEd8wPWWd95F3CKDwOCRP8gRjDrg9lhQfoO3lKfeqaJIWCA7SGU1YrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPDwwUZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E2EC32781;
	Wed, 21 Aug 2024 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724272399;
	bh=6FgnecSR8VhM53DQzNcFPbHy9j3pLUxYx6mq7I3vquw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uPDwwUZZVvAMR6p4goIKY15q+KQ1a9f+5km3vKJUsF+q46LBE1uJ9LXAT3/TqoKKp
	 38bBkx9InsecHrFGQ+64RF2f0YEOeweJ1dFiwhwyoKvXqPuY3NxAIhYioVYpCLkJ1q
	 Jpvy47xuNGI8VO4N22WttrKmQIEOZ2rlFK4Wl4UR48o5lhhpbojEFYgkrx1gVkwkDC
	 kfUT4WutAH7kphlsKDKw+1BcpfCi8dbj07cbF3Q8rvIOIPLCbB7XQqtqayRNzerf/R
	 15WrMPWzmo/0+Izw4ZJbKugXhvxLC4nGLOCrbL+RMLwwFqaky/1IAPh9Fhe2lj/uTw
	 98xWjhaum9wpw==
Date: Wed, 21 Aug 2024 21:33:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yang Ruibin <11162571@vivo.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers:iio:Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
Message-ID: <20240821213312.7ec499c6@jic23-huawei>
In-Reply-To: <20240821083911.3411-1-11162571@vivo.com>
References: <20240821083911.3411-1-11162571@vivo.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 04:39:08 -0400
Yang Ruibin <11162571@vivo.com> wrote:

> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
> 
Applied.  Thanks,

Jonathan

> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  drivers/iio/industrialio-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index a52a6b61c8b5..20b3b5212da7 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -219,7 +219,7 @@ void iio_backend_debugfs_add(struct iio_backend *back,
>  	snprintf(name, sizeof(name), "backend%d", back->idx);
>  
>  	back_d = debugfs_create_dir(name, d);
> -	if (!back_d)
> +	if (IS_ERR(back_d))
>  		return;
>  
>  	if (back->ops->debugfs_reg_access)


