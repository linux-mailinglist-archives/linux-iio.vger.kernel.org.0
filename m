Return-Path: <linux-iio+bounces-7403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B41A929856
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C76B20DD4
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8F7288DB;
	Sun,  7 Jul 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfbxuzJI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FB2374C;
	Sun,  7 Jul 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720361709; cv=none; b=EOlunRYOtM8RVXS9JKcgNkY4fO5wqBWDCCCP2oFyZi7Ck0Rxzl0QwWeos7eeR+CjpQbMz1OXqJGKKRLlHc23PrA4/hA/gm2BHk1pgUuE3VNZj7uWTr/IJwMQAzkoBe9ly5rW0PmwzHU24Lk54o+WQ/mu/Vqj1JO0TZkN4B6MjSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720361709; c=relaxed/simple;
	bh=vkrlcom1iru6FFlS0UV2djnDdnIUAWjfO8eztANhI70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDJgR7E7HBRen5d2d58yxf2mQ1rQMZYMfZyy8WWJwN2LIiGAiEkoUxiQ7bNOxG/OYHjUPV4bwMPqaRVvg6hhJ/e6KoUvsWs/SFctUThVRQoechhW6MvHyJL5WFgIiYtNAvBb5vn7FS5pxfL9jbAMImYb8PGu8F2uqx1L2wDBKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfbxuzJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A22C3277B;
	Sun,  7 Jul 2024 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720361708;
	bh=vkrlcom1iru6FFlS0UV2djnDdnIUAWjfO8eztANhI70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfbxuzJIETZGn1xfUnDzoBKTfFSZlizgvlYvodoykdM9tQivAYVz5gCRc3S8xIgFi
	 u4glN52QLRrWmVx6Z5K7yxOr2TZmkuMLqUSL6vnkRpt9VXlPyFuYqzgAQ5Wh3GhAXF
	 y8NE5gjeYCpyRQJMl7VleZRuNCU3rsHZMU8BEuiIUTwXoH2feEa18e9iFzPCFZbSdV
	 ev6qeiL1JXabs7X4B/JeV94Ky9u+2umPPqR0eLiUoPLFtjHu1o50yYNv1Jo5Dvd/QP
	 ptj9aOqpOFjSpZyi/Cgxv75WryVYwz5Wlxv/zUWmUYxA3pBVMPuzCsm8yLimtb5r8d
	 TU9rnVGsvjgwA==
Date: Sun, 7 Jul 2024 15:15:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ti-dac7311: Add check for spi_setup
Message-ID: <20240707151450.595fe29a@jic23-huawei>
In-Reply-To: <20240705084250.3006527-1-nichen@iscas.ac.cn>
References: <20240705084250.3006527-1-nichen@iscas.ac.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jul 2024 16:42:50 +0800
Chen Ni <nichen@iscas.ac.cn> wrote:

> Add check for the return value of spi_setup() and return the error
> if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Hi Chen,

This driver is using dev_err_probe() in some error returns from
the probe function and not in others. It would be good to change them
all to dev_err_probe() as it's both shorter and brings other advantages
in some paths.   In meantime let's not introduce another one to convert!

I'll make the change and apply this.

Applied to the testing branch of iio.git. I'll rebase that on 6.11-rc1 once
that is available in a couple of weeks time. At that point it'll become
the iio.git togreg branch and be picked up by linux next etc


> ---
>  drivers/iio/dac/ti-dac7311.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
> index 7f89d2a52f49..8e8a8ab0ebf6 100644
> --- a/drivers/iio/dac/ti-dac7311.c
> +++ b/drivers/iio/dac/ti-dac7311.c
> @@ -249,7 +249,11 @@ static int ti_dac_probe(struct spi_device *spi)
>  
>  	spi->mode = SPI_MODE_1;
>  	spi->bits_per_word = 16;
> -	spi_setup(spi);
> +	ret = spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(dev, "spi_setup failed\n");
> +		return ret;
		return dev_err_probe(dev, ret, "spi_setup failed\n");
and drop the now unneeded brackets.
> +	}
>  
>  	indio_dev->info = &ti_dac_info;
>  	indio_dev->name = spi_get_device_id(spi)->name;


