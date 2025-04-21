Return-Path: <linux-iio+bounces-18419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5D8A95053
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351A516FCCD
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1212641E1;
	Mon, 21 Apr 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATv1IfHl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938A2571A6;
	Mon, 21 Apr 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235652; cv=none; b=JSL0g6r0C5fGJIdkd5MBqKXqFLJEsChuA1tDVqa6Ww/lbpdzrhmS/rKUqAIUJtrpjWURrY6EbamNmFYKvnYEmwGCe8Ej3d6fHYtZZcRdUDKVaP3KMbA5P58U+J3YYrebmSPSywSalMx2qHSHZL73HifdzL6PyOqN4GN2RUxd53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235652; c=relaxed/simple;
	bh=zDizn9tRur2WUAV8vqAjOoGZtkNexNx3sE46NEqlTwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlFE3YC0o7DhcZ6YRweCAJe3Z5h2BZk0j4kFfPxL8tMdW2pOvgzweK+HNsXJ4iMr+seSpc7CcB6ZFPYAUQ33yy709aPtEcC2PtddnDRSBae/5CAs4u9JjcJfEktdmbVDExhxLcIRvEUxftfWq9RReKlcjiOBgIqs+w1W3kFnPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATv1IfHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD7EC4CEE4;
	Mon, 21 Apr 2025 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745235651;
	bh=zDizn9tRur2WUAV8vqAjOoGZtkNexNx3sE46NEqlTwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ATv1IfHlBd/A+kOa4pRbj7NwJIS5JJKy3kqLwLuDok17X6tTARWUc4f4MNzyjlmZ0
	 GpPFpTn9FMLksO2uo3yRJ5YmiqQ68OtPpaSGzaICWpIKrfyxnwI4vJHhyil89TXJE/
	 VtJkpX4fKZAow8uKkZb7/scCpZ8DJW5+m+007b0tAm9ROOQ+ly1yk2qWt1PiRPkT0B
	 9wlFtDdvw9Bd0d8U0g7aOTpc9QlwSd47/nJiHfsJmDARramyT4BTbBTSw6p0Olq4fM
	 rMMsZhLukZRmhW9t+KGyG6KWMrynHZWhWO+JLnRSJ3Jvr85JxcY7aA/vRMEJCHa4Qo
	 iF1ml7BL3I8+A==
Date: Mon, 21 Apr 2025 12:40:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 3/3] staging: iio: ad9832: Add minor improvements to
 ad9832_write_powerdown
Message-ID: <20250421124044.400628f1@jic23-huawei>
In-Reply-To: <20250420175419.889544-4-gshahrouzi@gmail.com>
References: <20250420175419.889544-1-gshahrouzi@gmail.com>
	<20250420175419.889544-4-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Apr 2025 13:54:19 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> Minimize size of type that needs to be used by replacing unsigned long
> with bool. Avoid redundancy by checking if cached power state is the
> same as the one requested.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index a8fc20379efed..2ab6026d56b5c 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -173,13 +173,19 @@ static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribut
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad9832_state *st = iio_priv(indio_dev);
>  	int ret;
> -	unsigned long val;
> +	bool val;
> +	bool cur;
>  
> -	ret = kstrtoul(buf, 10, &val);
> +	ret = kstrtobool(buf, &val);
That could have been done in the previous patch as you are changing the ABI anyway.
>  	if (ret)
> -		goto error_ret;
> +		return ret;
>  
>  	mutex_lock(&st->lock);
> +
> +	cur = !!(st->ctrl_src & AD9832_SLEEP);

Worth thinking about whether this driver will ever be converted to regmap with regcache.
If that's a reasonable thing to do long term this sort of optimization adds nothing
useful as we'll skip the right anwyay if the driver is already in the appropriate state.

This isn't a high performance path, so I'd not bother with the check for now.

> +	if (val == cur)
> +		goto unlock;
> +
>  	if (val)
>  		st->ctrl_src |= AD9832_SLEEP;
>  	else
> @@ -189,10 +195,10 @@ static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribut
>  	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
>  				st->ctrl_src);
>  	ret = spi_sync(st->spi, &st->msg);
If this fails, where doe ret end up? Looks to me like we now don't report the error
Anyhow, see guard() comment in previous patch.  These days we can avoid a lot of
this complexity by using that to allow direct returns where we first see the error.

> -	mutex_unlock(&st->lock);
>  
> -error_ret:
> -	return ret ? ret : len;
> +unlock:
> +	mutex_unlock(&st->lock);
> +	return len;
>  }
>  
>  static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,


