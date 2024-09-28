Return-Path: <linux-iio+bounces-9828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD64989010
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81EF1F21DF6
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC1210FF;
	Sat, 28 Sep 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh8Yk9m1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381531B299;
	Sat, 28 Sep 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727537453; cv=none; b=G7pG8w3xDIELl8KBBJxfvzNqkBdE+eUV5tsSb+WBfzhOSRnAhHkrazZdanKBvZL6f2B67vczH6JPI0Kvi0qkpH7/1/H9+9vAmTRuRqJcHQvMgjbhoRY9fB8wmf1SXcBoBR0D2A6yot/JjBEX48wjXrLj9j/uCyq99ti1fg9mqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727537453; c=relaxed/simple;
	bh=fogb1hMBCduyik9CgRcLmE7yygTxQUjCoKc6wf23StU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7Hdu4bIrj55oPpytRerfMkVx1/c0kg0YGBsjzpaKq8/mHqs899+pqA+2hs6vL+ppVyxgGHCZmzTDO24oNAqD3eDQ/RUk+9tPTqJVfvvVO8lrQtw+4Bbd17sPLbr26Nz1bceJvwMufn1BHR/8dhUC2dgdrxJE7kDeVJi35p25kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh8Yk9m1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ABFC4CEC3;
	Sat, 28 Sep 2024 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727537452;
	bh=fogb1hMBCduyik9CgRcLmE7yygTxQUjCoKc6wf23StU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lh8Yk9m1fy3IZTgBD/HqtMYWFsUvYiSWTWNGkAi8d0dfNk+BcfEjDOXkCKsZLEnyo
	 TPrbryBOHOQEZF8E6GsEJ2UD5Fzzuz5QqPe2C68oqwUmNTzyW5gWO4fTFzoZCf0jG/
	 UhsWv2XN9WvdyiAgd1u7oOMTqXfN1RmtXum6uZr1TfcwntZVkbibUTfr6YeiN37e7R
	 o4xJwIdmYb43vF/1Ec/jruDz22sIDC02jfjttgWGhXDskgfGpQUMCQj4gW5LA3PlM5
	 KRwyW08AbpkgrQfKuhQrZekzkP1a0ltb+MMOrZbghXixMRfIoIYWIwUqfbpB31+AEy
	 Zc/ba5dls5FZQ==
Date: Sat, 28 Sep 2024 16:30:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1363: Convert to get_unaligned_be16
Message-ID: <20240928163046.2abc6943@jic23-huawei>
In-Reply-To: <20240920181437.20194-1-abhashkumarjha123@gmail.com>
References: <20240920181437.20194-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 23:44:37 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Converted manual shifting and or to use `get_unaligned_be16` api
> instead.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Applied

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1363.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index bf4b6dc53..0801317da 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -33,6 +33,8 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> +#include <asm/unaligned.h>
> +
>  #define MAX1363_SETUP_BYTE(a) ((a) | 0x80)
>  
>  /* There is a fair bit more defined here than currently
> @@ -391,7 +393,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  			if (data < 0)
>  				return data;
>  
> -			data = (rxbuf[1] | rxbuf[0] << 8) &
> +			data = get_unaligned_be16(rxbuf) &
>  				((1 << st->chip_info->bits) - 1);
>  		} else {
>  			/* Get reading */


