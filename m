Return-Path: <linux-iio+bounces-4794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D28BBADB
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F6281B15
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B141CD2F;
	Sat,  4 May 2024 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qySZHPI3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51210A3D;
	Sat,  4 May 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822904; cv=none; b=dyxFYRAMjho/1GxH8mpRLmXUrC5NdtGTQBRpd/3p4EcDseJug34BIwSfw07HqHqCqN2FVuCG7fhx3LwB8pX30qfe6orVoN33YhvChylpkHII6wnLTAkT4h4/1EaboUSZ28VnYCe9fWJV/tJ7NtVg8vwiKQ3zpHwX+Mj1WQpRV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822904; c=relaxed/simple;
	bh=RbSToE/SPz2M6tN7QkqPPKcGZsMzIJzMKsTKU9zMKD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMoQ4eWdE96WWzyj9diiwLiUw3Y3UZ/lFvGAJzlQLUF/zI0gJEeMs3nVj56fm5hSbMMvFVzOAqWBICTuY27zG+75GYMFeKP29AHRDpT8mNHv5DbndnXb6PrBSzGV47r1Ex169JCXC8N6jZVwn49eFcLbT+H74M3nM+Et8BxN5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qySZHPI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96AAC072AA;
	Sat,  4 May 2024 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714822903;
	bh=RbSToE/SPz2M6tN7QkqPPKcGZsMzIJzMKsTKU9zMKD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qySZHPI35YIJeqrOlhqMSJnYrI5Sh9csLXtqWrmnRZs2hy4rQD8wLZpCxME+TvYtc
	 JToTa+nUgzJ5tyyOBxnvL/DxcWnfAhvbhhfqtTlInoOfEgPN8a1D9q1ot2CRuCGj6S
	 rxG53f6djeuIEpPSvKJqCJiM3u/oBCblekjxTdYxZPw/EDbRYSkaVq5xjD+Es0Zv1+
	 T531NRncUPiBLsDOVQ/3BOfPU8vUHXTUfZvIqz/bMNG+bPujjXNyvdhpfch+2972d+
	 WO12OtA8V7ncdTqTkPydJPsEjHHzCFqyhkvyh4nLw5Ac8vE2vpWVXxpo0sH9nvwrgk
	 wd0im14MIUTzA==
Date: Sat, 4 May 2024 12:41:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Peter Rosin <peda@axentia.se>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: multiplexer: Remove an unused field in struct mux
Message-ID: <20240504124131.6c6e3e8e@jic23-huawei>
In-Reply-To: <7bb04abdc2815caf090a6c9ecab2a51d837792a7.1714556499.git.christophe.jaillet@wanadoo.fr>
References: <7bb04abdc2815caf090a6c9ecab2a51d837792a7.1714556499.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 May 2024 11:41:54 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> In "struct mux", the 'indio_dev' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied,

Thanks,

> ---
> Compile tested only.
> 
> It was added in the initial commit 7ba9df54b091 ("iio: multiplexer: new iio
> category and iio-mux driver") but was never used.
> ---
>  drivers/iio/multiplexer/iio-mux.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index edd8c69f6d2e..2953403bef53 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -30,7 +30,6 @@ struct mux {
>  	int cached_state;
>  	struct mux_control *control;
>  	struct iio_channel *parent;
> -	struct iio_dev *indio_dev;
>  	struct iio_chan_spec *chan;
>  	struct iio_chan_spec_ext_info *ext_info;
>  	struct mux_child *child;


