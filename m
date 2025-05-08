Return-Path: <linux-iio+bounces-19340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0CAB0362
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EAC7B9A8C
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3D288CBE;
	Thu,  8 May 2025 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCuGqDJp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FD285418;
	Thu,  8 May 2025 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746731313; cv=none; b=V1rmons8H7UuQTOXtLs7BU92OYqJ5XVY0f/OK1dmElZQNtCG7gzXkprS8Tp1N3GsWhO+F/aoiG7c41xI+/mh0yd7tQfZzkuI/EAfoSF5VOeaIsEnOvktIREEwpuilWlvwZnpLBRpD+1BQwBEyC/s7jHOCZm5tYOq7/hQ4iFw85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746731313; c=relaxed/simple;
	bh=P4XnUVeNawK7yZuUmVScBRDOiIBA3C7uskeMrXM69+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWd6lFMRJ6I56uCpw6gHxIOmLh82hUwXrzzl9G7H28PPE7nQaikreRZxNyuQjF3CpkhdlO+Zx3u2GbnLN80J6DYXuMISihvptMbNQmpsDjAHZBxUDEfR4SDB1YyVcUDvBTcYSgos0dBGXNkcdRFgDb9IKjgu3AcGnx1q0ifdHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCuGqDJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BA7C4CEE7;
	Thu,  8 May 2025 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746731313;
	bh=P4XnUVeNawK7yZuUmVScBRDOiIBA3C7uskeMrXM69+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nCuGqDJpAV/oX1WvC6i/Zx/PRssrjg5OrIkODMLIFMQFOxsbUYNdYHtfNjAPl2GsE
	 pXbjGni3ODxRFA/9SU9SoyI1EeiEI19pPv3MLwdWwSqmRN8RBOcO5Kqy1XE1Nhspzz
	 fP2zzs8cob2M6olhiZSihP/gA921BxmWRL7kxoa0TuEABfcFUYg792wsGE+wQ/n4Cs
	 JxzaLM9UxA35uK1+dkqBqcuHN+x8+hE3vCzSO/e1VvSpUZywYlix8Tp/K01NB51Hsn
	 mf3a/SuAsdI7U+45a3GhNNu3fjFSgToQN/Pg2YdhCIpd8CHvwVY/K3nYbVxd9LIgEt
	 rqCIKTiGDW7EA==
Date: Thu, 8 May 2025 20:08:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Gyeyoung Baek <gye976@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iio: chemical: mhz19b: Fix error code in probe()
Message-ID: <20250508200824.4cb509fa@jic23-huawei>
In-Reply-To: <aBtZFLFlr0slcYSi@stanley.mountain>
References: <aBtZFLFlr0slcYSi@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 May 2025 15:59:00 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Return -ENOMEM if devm_iio_device_alloc() fails.  Don't return success.
> 
> Fixes: b43278d66e99 ("iio: chemical: Add support for Winsen MHZ19B CO2 sensor")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Applied.

Tah
> ---
>  drivers/iio/chemical/mhz19b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
> index c0052ba3ac6c..3c64154918b1 100644
> --- a/drivers/iio/chemical/mhz19b.c
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -276,7 +276,7 @@ static int mhz19b_probe(struct serdev_device *serdev)
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
> -		return ret;
> +		return -ENOMEM;
>  	serdev_device_set_drvdata(serdev, indio_dev);
>  
>  	st = iio_priv(indio_dev);


