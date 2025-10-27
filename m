Return-Path: <linux-iio+bounces-25477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D359DC0E627
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE8A189E596
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B5307AFA;
	Mon, 27 Oct 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmpz5sLm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ACA17A2E0;
	Mon, 27 Oct 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575017; cv=none; b=HxYsRI3HCma6KH79WMSLsDDitb55Rf2hMg1KRLuWToIltSstgctBTOPRMd++TdKhLSroi8TI9CbIv1IKV+gRUivMj2hGpbTqLV922jfjafaUg3oX6T3YzNlTWJrOyf82POkYmZH/Sp+fxozreQiGy7jwqHKw3Gb3zvI49qR7DuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575017; c=relaxed/simple;
	bh=bEZAhKU/gmp7DRZn+x/CT+6rXAvYol0BBVHtXI9aG3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arMCbZ45DH/cEuPoDjgQhSq1IQG5MrTVg0YB8HwcfF/qifleLP7F1y2ulKQxT8V5tATHvqXEF8ip9INMlm2yo6Sy5MC96VLxL3PHOO2HVYyqjYIT8h8FrDNbkgW/+s8eULEskQfjWD/9O69KVckGcgvr3CJ1sHx43FJVOE7Csj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmpz5sLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B68C4CEF1;
	Mon, 27 Oct 2025 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761575017;
	bh=bEZAhKU/gmp7DRZn+x/CT+6rXAvYol0BBVHtXI9aG3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dmpz5sLmkgFWTzbdpjMsCcAdyuGEU6GNprBALP6mwxrpmDz69ZhOZqOoMDHoGLuaC
	 G+nqYVWqcZX4EarRGnLTy3C6zlvHxPgXwCjxpLd5pBlGSIsI6KNoB070SUb3vHJRZ7
	 BT0QqgUwseMy6ZB6+aH+tjfvPHdzKTa3zmkp0mN7rHrgknACtd+UexeMkLiOFy1Av/
	 og/3JfBuKdVuACELMYHlTsWU0gmd2b/O9LnxfTu+cl9NOQy9lERgcbetoK9+pTaoRV
	 C+z7KR0t3zDGJLJTUglQL7BvO+e9M6TvZZlCaUV85cxgWL/IX3rFxi6QlZ/WgOrEM+
	 LRjosk3WOdqmw==
Date: Mon, 27 Oct 2025 14:23:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Remi Buisson <remi.buisson@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iio: imu: inv_icm45600: Add a missing return
 statement in probe()
Message-ID: <20251027142331.29725dfe@jic23-huawei>
In-Reply-To: <aPi5vEp75jH0imQc@stanley.mountain>
References: <aPi5vEp75jH0imQc@stanley.mountain>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 14:02:20 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The intention here was clearly to return -ENODEV but the return statement
> was missing.  It would result in an off by one read in i3c_chip_info[] on
> the next line.  Add the return statement.
> 
> Fixes: 1bef24e9007e ("iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
> index b5df06b97d44..9247eae9b3e2 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
> @@ -57,7 +57,8 @@ static int inv_icm45600_i3c_probe(struct i3c_device *i3cdev)
>  	}
>  
>  	if (chip == nb_chip)
> -		dev_err_probe(&i3cdev->dev, -ENODEV, "Failed to match part id %d\n", whoami);
> +		return dev_err_probe(&i3cdev->dev, -ENODEV,
> +				     "Failed to match part id %d\n", whoami);
>  
>  	return inv_icm45600_core_probe(regmap, i3c_chip_info[chip], false, NULL);
>  }

I'm going to apply this but the resulting code is still wrong (even if not
a true bug after this fix).

A hard ID match like this breaks use of dt fallback compatibles.
What this should do is 'give it a go' on matching, but if there no match it should
carry on as if the match was to whatever the compatible that was supplied was.
When that happens a dev_info() is appropriate but not error out as this does.

Remi, if possible could you look at adding such a patch on top of this?

Thanks,

Jonathan

