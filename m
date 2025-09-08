Return-Path: <linux-iio+bounces-23886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5975B495AC
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62041C20D4E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19E231197C;
	Mon,  8 Sep 2025 16:36:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98430F7EA;
	Mon,  8 Sep 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349369; cv=none; b=BIG7h8r/GX4Kj/IfWYjSxsECtJwO0nY/ctw1DkbXH+bFspkoaGoXI4bRcI6tEAg9Hkd3+XdSulEd+Ev3DsM9EqajuTbrO2Bs1nzX1E05DSTUmsqCOn4IsXNDWXn+8NMCf1FfPvDB+V5q8860qQQC/hAoMp1zFoVR+IP/JibeI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349369; c=relaxed/simple;
	bh=AMyMyekIZqDNrCq7O70iFcw5iGCi1qxe8v4SS9r8Zqg=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:
	 In-Reply-To:Content-Type; b=PsF4djpje1jX5ZosFoVNK4dne28mZr9veHDfYIlf0CrdJXwJ8skZypubCqRIlQqNaZHFjdQVYTyAOko04hu7Mx0nWO+TA+Q/4VgMbUzzMmW5a9EmgG20JCqODZf7leVZ6qEhEQkA5qXrE7533bVhYSZbb/oca0LfiQEUuwpFyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from [192.168.42.135] (85-193-34-16.rib.o2.cz [85.193.34.16])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 4143938F82;
	Mon, 08 Sep 2025 18:36:00 +0200 (CEST)
Message-ID: <6f59004b-5f0c-4686-96f2-8a386acf097d@gpxsee.org>
Date: Mon, 8 Sep 2025 18:36:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
Subject: [PATCH 1/2] media: pci: mg4b: use aligned_s64
References: <4501714e-8433-404a-a526-fd6919031f39@gpxsee.org>
Content-Language: en-US
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, jic23@kernel.org, mchehab@kernel.org
In-Reply-To: <4501714e-8433-404a-a526-fd6919031f39@gpxsee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/5/25 9:06 PM, David Lechner wrote:
> Use aligned_s64 for IIO timestamp field instead of explicit __align().
> This is the convention used throughout the IIO subsystem. No functional
> change.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Closes: https://lore.kernel.org/linux-iio/20250724115610.011110fb@jic23-huawei/
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Martin Tůma <martin.tuma@digiteqautomotive.com>

> ---
>   drivers/media/pci/mgb4/mgb4_trigger.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
> index d7dddc5c8728e81c6249b03a4cbf692da15a4ced..bed8bbd4bc595d1d131b9919c6f3b705e43ba3c4 100644
> --- a/drivers/media/pci/mgb4/mgb4_trigger.c
> +++ b/drivers/media/pci/mgb4/mgb4_trigger.c
> @@ -17,6 +17,7 @@
>   #include <linux/iio/triggered_buffer.h>
>   #include <linux/pci.h>
>   #include <linux/dma/amd_xdma.h>
> +#include <linux/types.h>
>   #include "mgb4_core.h"
>   #include "mgb4_trigger.h"
>   
> @@ -90,7 +91,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
>   	struct trigger_data *st = iio_priv(indio_dev);
>   	struct {
>   		u32 data;
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>   	} scan = { };
>   
>   	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
> 


