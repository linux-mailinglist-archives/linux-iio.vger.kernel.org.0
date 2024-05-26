Return-Path: <linux-iio+bounces-5311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1EA8CF438
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAAD1C20AD4
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF60DDB2;
	Sun, 26 May 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUVz3q8B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA2946C;
	Sun, 26 May 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716726283; cv=none; b=gA5ur9H/iP3dgldhByRbfwEFV2cuo761avVEWI0A5xxm0YiiDL7IQCHRfPomuHfBZgEJDAdm3zGvVy/YUN4xO56SXzPxqZhR3JlxjExfG7yalsoUcrUrgSHLjyY5Ax8A72wgNbmRM5fBNgYMJnKUC0OrI1pzLTiZrOE7Vs0+wJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716726283; c=relaxed/simple;
	bh=/R1zGog2Y9d65uHyn2AWHfkJj5rsRDkXSZ10XaoeueY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9NPVkjJwM8JEEtIh520OeHHlgmyhDTFRqjrbT/uLdW29nq/XhhbXK9UsSfoAPc7P+l0Q693tBfHLxqvzXM+2fqfYr7wLxAEbRWJgDgUQz+RXXRedw+Cwmj5q78N969GG9D2xm/yWbNFHjxIlhW5pWinE8zf/7QJVME41GrPalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUVz3q8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3264FC2BD10;
	Sun, 26 May 2024 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716726283;
	bh=/R1zGog2Y9d65uHyn2AWHfkJj5rsRDkXSZ10XaoeueY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UUVz3q8BybOqfnN/1OZi+mbEsB8fIIPlxUnjsX4rSf+zvGgutbI7Y8kyDFPq1uwVZ
	 pCr3pDUB3bYECtGEBHOxqkOh/wnr/N9BtQaPTwkgIeWZs13jOj5GCfhCGsKdgX+MbU
	 BnWhFkz6yNh7j8sKmsWS3ISMcZ8QhPKxAHhWIA1MUOBBJq2BfTLEigd2ENNvE7WXcw
	 yqI6sB1f1g7WboKxjtDC+otPmzxOpzSSmQtd1q65rWNdZ60JBddiKP40NpwgV6eSWq
	 OTp9GYEEfmroAcOjwfXPlQMMu1A1RXpOShNH6DmWemsWMCsRfbaFYBRJMMKaeU9tZI
	 jZP3XstKHzhMw==
Date: Sun, 26 May 2024 13:24:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Luke D . Jones" <luke@ljones.dev>, Jonathan LoBue
 <jlobue10@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: imu: bmi323: Use iio read_acpi_mount_matrix()
 helper
Message-ID: <20240526132422.01d3855b@jic23-huawei>
In-Reply-To: <20240523174736.16692-2-benato.denis96@gmail.com>
References: <20240523174736.16692-1-benato.denis96@gmail.com>
	<20240523174736.16692-2-benato.denis96@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 19:47:36 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> bmi150-accel and bmi323-imu are declared in an almost identical way in the ACPI and in some devices such as the Asus RC71L the "ROTM" property can be found: parse and use the ACPI-defined mount-matrix.
> 
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 5d42ab9b176a..b391e5e701b1 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -2083,9 +2083,11 @@ int bmi323_core_probe(struct device *dev)
>  	if (ret)
>  		return -EINVAL;
>  
> -	ret = iio_read_mount_matrix(dev, &data->orientation);
> -	if (ret)
> -		return ret;
> +	if (!iio_read_acpi_mount_matrix(dev, &data->orientation, "ROTM")) {
> +		ret = iio_read_mount_matrix(dev, &data->orientation);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	indio_dev->name = "bmi323-imu";
>  	indio_dev->info = &bmi323_info;


