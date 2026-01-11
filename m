Return-Path: <linux-iio+bounces-27606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD01D0EF00
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7268F300ACF1
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF83375C5;
	Sun, 11 Jan 2026 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGOgOWwH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632A2D193F
	for <linux-iio@vger.kernel.org>; Sun, 11 Jan 2026 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768136330; cv=none; b=W1Kx0PwL1fmZL5XD3Vk2NP0TxTZuLR+kxAl+L44mbHBU+a+ik7HUOMr9nVVfeDugyF41oOT9uDmwCitjnAnQEpvbnFqxNWh3AL5+XWY5H/mbvqr2DmofsWf5VXDwkR8DLQGBAhIeAO9X6Q6ZThC3oD1FFlH/XlzhI9TqFn62tl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768136330; c=relaxed/simple;
	bh=TCCGwWjlvkoJaBl9Dit8AYmdR/tv29r15bkbOLEr2Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cd8p+og3PuQIoiAR4U4FCP1GYZ/AhPY1zpkqL+xcbv3jkvdDIjd7X9AWa0Ciej8EsHcPj+P6qcj77sXBcYBlPua61r930m9upgw68tPZ/G1MvUpIjAqOdUjBT5tuB6nZDuCRf+xbN7i5uBaKYCMqYyGOQuU4n51xXQ1rMH5AJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGOgOWwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C56C4CEF7;
	Sun, 11 Jan 2026 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768136330;
	bh=TCCGwWjlvkoJaBl9Dit8AYmdR/tv29r15bkbOLEr2Lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IGOgOWwHAp5OH3b2EiNfGUVegfymEwLEktRCPKMkrPZOxJVs8H6swn27ESAErZAml
	 Ujb5sKHbmVlPFCo27IiDSPCVUaEF5h3cJoNgM5DzTeF/SzFm7l0gAHngByhR3Eoz6w
	 hqCV8wnHKWhLc41r3UELd7w+z7tJAxYDFTxqVytgVRxt6/SnSBahtW3GTXypkSRQ4L
	 2BHNlxqBkNBMQJ2tAK9/Jd/slVuHoD6QcfyribcK2XdF9Qv9v9zp1DPOSJvbUEKoXp
	 YwHDy+RUYIDPFwdAS7FQTTsWgPCsrKB6zB7WW6P4VHDOVzUFjmohULWk85p5IU5EE0
	 FiTBb520Tk/hg==
Date: Sun, 11 Jan 2026 12:58:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: zopt2201: use lock guards
Message-ID: <20260111125844.493fe5ac@jic23-huawei>
In-Reply-To: <20260103192442.10826-1-gabrielsousa230@gmail.com>
References: <20260103192442.10826-1-gabrielsousa230@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Jan 2026 16:24:42 -0300
Gabriel Almeida <gabrielsousa230@gmail.com> wrote:

> Use guard() to handle the mutex lock instead of manually
> locking and unlocking it.
> 
> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
Hi Gabriel,

Welcome to IIO and thanks for your patch.

> ---
>  drivers/iio/light/zopt2201.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
> index 1dba1b949cc3..f5a41c293d9c 100644
> --- a/drivers/iio/light/zopt2201.c
> +++ b/drivers/iio/light/zopt2201.c

Needs cleanup.h include to be added.  The headers in this in this driver
aren't ordered, so just put it so it's in the correct order with one
of them! (alphabetical)



> @@ -351,15 +351,13 @@ static int zopt2201_write_scale_by_idx(struct zopt2201_data *data, int idx,
>  {
>  	int ret;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  	ret = zopt2201_set_resolution(data, zopt2201_scale_array[idx].res);
>  	if (ret < 0)
> -		goto unlock;
> +		return ret;
>  
>  	ret = zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
>  
> -unlock:
> -	mutex_unlock(&data->lock);
>  	return ret;
	return zopt2201_set_gain();

>  }
>  
Whilst this change is reasonable subject to comments above,
you should be looking at the rest of the driver to see if similar
changes apply. zopt2201_read() for example can use a guard with the
trivial increase in scope of the final endian swap occuring under the lock
(which is harmless!)  There are other places as well so take a good look.

Thanks,

Jonathan





