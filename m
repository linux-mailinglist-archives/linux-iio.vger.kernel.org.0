Return-Path: <linux-iio+bounces-8398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A5B94DC44
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA86282784
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEEC15747D;
	Sat, 10 Aug 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAcFWNhc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8314659F;
	Sat, 10 Aug 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285440; cv=none; b=bqrgLNS1CqP3kD+MFG0JtpcaINI9mp6YT2LGiw4toY8/ldebDYKawhQQCV2vwt7+XyT7ywz52m/bSPxb3iIjWvviQOOGcMLcaoR99x0xyZ1uzWBl3RSW3hEv7Jfikz7AQaqNAz8dnPBb1Qu/QDfPB+rFbvMva8GcoliS/tHAkl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285440; c=relaxed/simple;
	bh=qSupJuTLLZG8dgIkdJ6OXIxbntFMHCvge0X4lvT7rsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doEMvlcSX4z2fwgM2iFK1FnCwXuMVJrP+AVQYDWVPNO7IIwxsyebdft8K+iFvdifFkas78g+Am8vtv4r8dXkcbE3Ovh5SVF5uZ8Hd8LLw/bigeIIQLdj/i71ZzY8U87o+iRTLNuQ1risZ6fT0gvjSJ/dhrsLEmPn8bRhc+hM+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAcFWNhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA7CC32781;
	Sat, 10 Aug 2024 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723285440;
	bh=qSupJuTLLZG8dgIkdJ6OXIxbntFMHCvge0X4lvT7rsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GAcFWNhcKH/J7bESxsG/LBAiUaJlz+pmoCMf+YKs5K/IEKEOX0RIUwKwXQ0qOAIg+
	 r+/3sYcZr2xCyn/ynjJbVdmywg8NgcFBm7VicnIJxqcCM4nnqsgT2akcIr9tS9vZbL
	 pyBEaZSAvvgG10BxF0VyCgiffsIwFCEnF3RN2+yAj2iRrrZ6lMnxhExy/JFrv+QaYL
	 i5KYt5VbKDW6vAwC7oSGMub25RUuB+kn5jepVaWD7oQpboqy6RZ0M7zyXCeUIxHLa6
	 FO9P0Pi7bW17XjKkQST/mnjze3GvrvqFki/DlxKqTWrK9WEsFERzjj3mGNd8WTWQtw
	 ENZroe43y6j3A==
Date: Sat, 10 Aug 2024 11:23:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: Fix spelling mistake "avaialable" ->
 "available"
Message-ID: <20240810112354.0985ba35@jic23-huawei>
In-Reply-To: <20240807094745.4174785-1-colin.i.king@gmail.com>
References: <20240807094745.4174785-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 10:47:45 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in a dev_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied.

Thanks,

J
> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 3f2bc6451325..6a6568d4a2cb 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2002,7 +2002,7 @@ int iio_active_scan_mask_index(struct iio_dev *indio_dev)
>  	}
>  
>  	dev_warn(indio_dev->dev.parent,
> -		 "active scan mask is not part of the avaialable scan masks\n");
> +		 "active scan mask is not part of the available scan masks\n");
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(iio_active_scan_mask_index);


