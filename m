Return-Path: <linux-iio+bounces-17373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D21A75B76
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493BA7A3268
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6765D1D8DF6;
	Sun, 30 Mar 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K48T2Iyn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EBF1C5D7B;
	Sun, 30 Mar 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356309; cv=none; b=PGTBCbhkQH38+yxnzVJOxZcB2HYeTmGFIzjSuTnjkd+3DUl4TvYI51V9Vph/eCD9iunt3pw6NXVFxbSsjDDmQC2YvdfziZK2JnYZlyXY/kFtv8Dr6h8W8qM+5Z3Yi5R4wqiqDGQNdkfLxLyg9SWXwkvmcNM1iLRgepWyXwEU0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356309; c=relaxed/simple;
	bh=ceBZtfLyywP4yQvIY/4gwycCdopG4FPqnbeKi7jR5l8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvjyVfICSy+nftOJ2+oSG7H7Prm73xv540DnTkSPQD4UJEbpbM47t/U/oudpqIs/q0ZwfMyf0RdloGtAnZ13vbBkQDY9bRxVlrkuLWIipXh72mGNcqbMJU0bZGBaihaZiRwOZ0Q5OQ46l3FXR4zYywOVQNKlTkjTAhfz9fSY6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K48T2Iyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99EBC4CEDD;
	Sun, 30 Mar 2025 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743356308;
	bh=ceBZtfLyywP4yQvIY/4gwycCdopG4FPqnbeKi7jR5l8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K48T2IynTRB2uC5Vbig9GflY/82ZaSExRWjwaYlMUHJPVv28VbSjoZnt5/mefY7P1
	 hN5yujzxn33FY0WGJvlezEdwXk3MxBnFnJY2Ik4fccYywvJFNYA/xn75iO/B0h1LQA
	 O6TKGXx5iWOwX/+NVn0daEXMQcRiumg4NzlpGoDvhPjyLZTdCek6XyMW4CYd7OWFYN
	 OrP3Oaj6rxYWd+G0ovfui6S6iP97+QT9NFSp76akJUCy/Nhs4E5MbtwNMDmF/O6IY1
	 u+TMeWc3Z30i5PZrPiYfyYnLd8Y6tWpihY/NGLvmYGsqdkKZwZkcSCOKv+KXWLxjBh
	 ML1o3BViwIn4w==
Date: Sun, 30 Mar 2025 18:38:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] iio: light: al3320a: Improve error handling
 with dev_err_probe
Message-ID: <20250330183821.0f4f1a45@jic23-huawei>
In-Reply-To: <20250319-al3010-iio-regmap-v2-11-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-11-1310729d0543@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:59:50 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> Slight simplification of the code.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3320a.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 1b2b0359ed5dad5e00d2fe584f8f3495c13c997e..1943e6f34a70b00b5d732dbf4ae6ccb4376303b7 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -206,14 +206,12 @@ static int al3320a_probe(struct i2c_client *client)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = al3320a_init(data);
> -	if (ret < 0) {
> -		dev_err(dev, "al3320a chip init failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init ALS\n");
>  
>  	ret = devm_add_action_or_reset(dev, al3320a_set_pwr_off, data);
Seeing this here made me look. Seems that the error path I highlighted in
patch 9 is here as well. I'd push this devm registration down into init
where it can immediately follow the power up.

> -	if (ret < 0)
> -		return ret;
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add action\n");
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }
> 


