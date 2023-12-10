Return-Path: <linux-iio+bounces-797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93280BAB6
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 13:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6751C2091F
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94BBE7E;
	Sun, 10 Dec 2023 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siLUPEh+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2568C15
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 12:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77346C433C7;
	Sun, 10 Dec 2023 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702211828;
	bh=pRBeoq0i5wdIAoj64UnUDaiei1SKdwmcYgCs6WKw67s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=siLUPEh+g1d5hTqWbpQ0jYVZKFMXNeYUvAuGg3f2A+aw5FOgAZC3Amtf2qDAs+0KG
	 nFMQPcMPCTNO3VcNjFpN2jCrdOdoe0SQ3gM3Gtjwmv/6o/HSOLy4R0k0pb797cxNw1
	 Hh/kEaGHPy3XBDS5TPGIZD6iYKnizqVf3dnpMS/8rs16B3QFN73H+adkpY1j7rcveu
	 xDaWJwggp9s/o3SA93bwdwu9xSrAzUXgXVntANdVvjvwf5+HUyOU1Vh+PEh/Sa26p8
	 QnC73fxI0JHIc47R4ifPdP8WX4jHnla/8z3gGINU6jGKYRjne656/ZGyAsgJcayZ/P
	 053jZCyjbaPQQ==
Date: Sun, 10 Dec 2023 12:37:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] iio: light: isl76682: remove unreachable code
Message-ID: <20231210123704.4be7087e@jic23-huawei>
In-Reply-To: <20231208021715.32450-1-jiapeng.chong@linux.alibaba.com>
References: <20231208021715.32450-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Dec 2023 10:17:15 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> The function isl76682_read_raw cannot execute return -EINVAL up to 145
> lines, delete the invalid code.
> 
> drivers/iio/light/isl76682.c:145 isl76682_read_raw() warn: ignoring unreachable code.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7698
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/light/isl76682.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> index 0a7c3b09c3c0..cf6ddee44ffc 100644
> --- a/drivers/iio/light/isl76682.c
> +++ b/drivers/iio/light/isl76682.c
> @@ -142,7 +142,6 @@ static int isl76682_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		return -EINVAL;
>  	case IIO_CHAN_INFO_SCALE:
>  		for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
>  			if (chip->range != isl76682_range_table[i].range)


