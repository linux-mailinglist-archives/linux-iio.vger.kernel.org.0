Return-Path: <linux-iio+bounces-16347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2CA4E13B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6251699EC
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A89271295;
	Tue,  4 Mar 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9K1ll2L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7D12702AE;
	Tue,  4 Mar 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098763; cv=none; b=WtQ72Ts5FXioBr431X2yz7q9t3vquwd0Uw8MdzPT8tMAtmdLBCmy2gtkeOq8xKKj/T+YzL7oOvEnfD/daWJDGPs0iggyYqlEJtQJYbz/r2luzyCA6zM6M1NvkzlrUQ2aAUQaz2VP37eOH2fZHaVQowC6QqF0XqkAl8Nq0Mn6R5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098763; c=relaxed/simple;
	bh=O+lCSZcmEJcVIFuSmo7TYEoF15P296Bz+JrECTR+zZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cT4GtFCFrcnFWgLwQnz9ZcmSGYVOjhtlqLKeo7yKu9RW1b0vZzsIDQfFofBsPjoVnJ0fW7p0GTHS0f1rbgGCtj/Cw7MVk40QnOuZnI1znbaEFxXPMb8/WcNmLnTM0WvEd7td9UuDEZT5brqd/E8a1b49F3ibrLX3QSwnPJh7TEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9K1ll2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D05C4CEE5;
	Tue,  4 Mar 2025 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098763;
	bh=O+lCSZcmEJcVIFuSmo7TYEoF15P296Bz+JrECTR+zZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l9K1ll2LLEnYQntWa+vP4Hf5gxD55o5b+j8cqsWECkolnN4pZ3ZZuSTmJKNwfF7nP
	 DaYmdEZLSqAhSONzHwOx72KUG4te159h7TWJXAryfIEIFMULvM3mQfEBtmBNn1AcmV
	 MnB1BakO4GKnfVHY8BoriLfVEJjS3qb9qxcM+H9ykMtXyQVZpWs6gebXJ8JJQmXl/n
	 +lLmq/iGyLtAqmN7tnwg3FqU7c1znJw6hlFvZpPQY/WYYijdZPUu1sn9fp00Zs4nFs
	 99K4Dl50x6kB23HikYYsMlUKFEaZGEKVs/70zR/1VeTZVvb+0n3QbMVE6PKU0y7IST
	 XlZojwyuTOR6A==
Date: Tue, 4 Mar 2025 14:32:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: adis16203: Remove unneeded
 spi_set_drvdata()
Message-ID: <20250304143230.6d91f64d@jic23-huawei>
In-Reply-To: <20250303180523.15445-1-danascape@gmail.com>
References: <20250303180523.15445-1-danascape@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 23:35:23 +0530
Saalim Quadri <danascape@gmail.com> wrote:

> * Since we are making use of devm_iio_device_register(), we no longer
>   need this nor do we have any spi_get_drvdata() in the driver.
> 
Why have a single bullet point?  
Also please rewrite in imperative sense. Something like

Driver no longer has a remove callback after conversion to fully
devm_ managed probe().  Remove now unneeded spi_get_drvdata()
as that value was previously on read in the remove() callback.

> Signed-off-by: Saalim Quadri <danascape@gmail.com>
Code is fine, so just this patch description stuff.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16203.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index c1c73308800c..3faf3c61046a 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -267,8 +267,6 @@ static int adis16203_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
>  	indio_dev->channels = adis16203_channels;


