Return-Path: <linux-iio+bounces-4793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75618BBAD6
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FA3B21B0A
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8292A10A3D;
	Sat,  4 May 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxZPpXyI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DBA1CD15;
	Sat,  4 May 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822778; cv=none; b=Rp5ghKxWTIqetaxxe6fbdu7vXm9Aaw3ggOj/tG+xMxDxzLm6oyvjYcT9wl1AEpv7aQ2NNaN4jJuyq4EjyPIAYeuJHFJftevApM17N3qbUmEdIVih9y+fwxImu8gN19PyOnUwHDm0j7N+j3pK61rn+CApoUL+tpRIarPBGywOrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822778; c=relaxed/simple;
	bh=4rfjFtM+CtzyIEI0Hix6vR1OfmWEc43hHJudSrw9vI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1yfpAO5RvALzV/JW0ZppOMPvtqRx/9dQNsoFm2vxx3wtAjB4oAmojHD5iPjlEe2QUv/30JlkgMAzccFHztQF/90XrAfsODPfQVSqHGKvLnq0PL7vxgkeEWtagdbho5H51qiDYHc3E4AIYcct6UYDY+d/6vwh3/EM2RwBHs9f4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxZPpXyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAEAC2BBFC;
	Sat,  4 May 2024 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714822778;
	bh=4rfjFtM+CtzyIEI0Hix6vR1OfmWEc43hHJudSrw9vI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NxZPpXyIHwafC48qLOELQ2MEgoPbmHt9o4yurHPUSJzg/VSNFZqup4fkWM0StiL+9
	 sPuuhVoleH7n7/E1m7UORaIzKXVGCkdfd5uddp6b/znGTRFidA4e0rscc8es+uPbek
	 H4HD4hgZYtUgxoC+tEdKBFFQikMwowkYQwqTlWZ39z+IuT4SenaRt5ZID3Hetd377K
	 HZHiPJMCeX/I35ZnhEdYorBpd8Osxh065AKRdIKPIDyrR2SIYzOhiu3FgwYWz/Uq5i
	 mAK57YJKeVnC6pzs7l+zdDmhJ7/8b93B4rRfHjAR0bWztBTt3CcE1kKqwGmANRgLK/
	 BgdfNqx+whWIw==
Date: Sat, 4 May 2024 12:39:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: max30208: Remove an unused field in
 struct max30208_data
Message-ID: <20240504123927.2d47c232@jic23-huawei>
In-Reply-To: <73f9f540ecdc7c10e833e6fc782324ae7d34ba9c.1714555144.git.christophe.jaillet@wanadoo.fr>
References: <73f9f540ecdc7c10e833e6fc782324ae7d34ba9c.1714555144.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 May 2024 11:19:41 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> In "struct max30208_data", the 'indio_dev' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied,

Thanks,

J
> ---
> Compile tested only.
> 
> It was added in the initial commit 9ee95ae4cffd ("iio: temperature: Add
> driver support for Maxim MAX30208") but was never used.
> ---
>  drivers/iio/temperature/max30208.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature/max30208.c
> index 48be03852cd8..720469f9dc36 100644
> --- a/drivers/iio/temperature/max30208.c
> +++ b/drivers/iio/temperature/max30208.c
> @@ -34,7 +34,6 @@
>  
>  struct max30208_data {
>  	struct i2c_client *client;
> -	struct iio_dev *indio_dev;
>  	struct mutex lock; /* Lock to prevent concurrent reads of temperature readings */
>  };
>  


