Return-Path: <linux-iio+bounces-10777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF459A4DAC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D032827EF
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB61E0499;
	Sat, 19 Oct 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij9P9nGy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD91917E4;
	Sat, 19 Oct 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729339732; cv=none; b=fumR6Ey0Con5WFbviBHWtr3vaq1vJ9Lun7E4v1sXf7oEI+Y3nc8yvmQ7inLmjAon3Me9Z9Jj3X1aEkx/+SNCm6vtpo9ZJ7k6hwRmzXq2q8FvfeI3BLJ9D0MP5BfWjFyAqwQewxfFikyrYYjKpa5jNMDWdeoUNr6Qjdj4mjS13J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729339732; c=relaxed/simple;
	bh=oy/B2DG02BEjkHcvGptOBJMbPnWymrsdi67y1vXhhOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWqsT9kAUV+ODl4Ny5si4TxWbNjdi8QgVU3EqUT2gJ3n978RQk8S74fo9eOSsDY4RESvP4hI8tPeLZKWguUiOb4vo4+YrKCNsfRGICB16Bnmv3P3mxibGXqyIUZkTCXH8mG/CfODWsZYQs0Y0cCIu1jdj9UOPUY0aYslca/KSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij9P9nGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5A1C4CEC5;
	Sat, 19 Oct 2024 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729339731;
	bh=oy/B2DG02BEjkHcvGptOBJMbPnWymrsdi67y1vXhhOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ij9P9nGyjIHsE0vgvGjdX2ncMoVYlWVn8bh3wyau9izKmapU9pWN76shtJgYqHuBH
	 HxLmdRatlCDNL/MoEgvBKYFFjDJZA9Cr/5Lgi7bKZNTk+FMapbKhPqKBykW9c4DXV4
	 eBAN1MXKWxa29CuUQn5FOkziye1fZHQnA2QvwAjNM3joZjS1J1NObhkXWqRVr+cnX7
	 My+NultCNj1tBudRsXQZUFExPtTuXLcIMfGsNUwPSH9vp2Cz92zC+UyEgnKkmN/M0z
	 SxJ6BpZLlxu45K8xmH/yFM5Pbr/GyV7RXBMMKX4QeN/7dlHGneQh7Yj0Zaep0ylZlY
	 +1AP9vwIhyu+A==
Date: Sat, 19 Oct 2024 13:08:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: puranjay@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] iio: accel: adxl355: Fix typo "accelaration"
Message-ID: <20241019130844.0f721bec@jic23-huawei>
In-Reply-To: <9F137828F9F185FD+20241017092221.361511-1-wangyuli@uniontech.com>
References: <9F137828F9F185FD+20241017092221.361511-1-wangyuli@uniontech.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 17:22:21 +0800
WangYuli <wangyuli@uniontech.com> wrote:

> There is a spelling mistake of 'accelaration' in comments which
> should be 'acceleration'.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
Applied.

Thanks,

J
> ---
>  drivers/iio/accel/adxl355_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index eabaefa92f19..7ccd2f653b9b 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -643,7 +643,7 @@ static irqreturn_t adxl355_trigger_handler(int irq, void *p)
>  	 * The acceleration data is 24 bits and big endian. It has to be saved
>  	 * in 32 bits, hence, it is saved in the 2nd byte of the 4 byte buffer.
>  	 * The buf array is 14 bytes as it includes 3x4=12 bytes for
> -	 * accelaration data of x, y, and z axis. It also includes 2 bytes for
> +	 * acceleration data of x, y, and z axis. It also includes 2 bytes for
>  	 * temperature data.
>  	 */
>  	ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,


