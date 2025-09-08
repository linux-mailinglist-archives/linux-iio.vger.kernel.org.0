Return-Path: <linux-iio+bounces-23887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4872DB495BD
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 18:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DF117237B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10F30F924;
	Mon,  8 Sep 2025 16:38:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58A30CDA9;
	Mon,  8 Sep 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349488; cv=none; b=GZ3zHK757kpKPainQngxWlB8FKMZZbV/xjkgwr8ySDkO1WBJzCXdEI09ofn+vBG9aH96Zqitvl7p79hs8hA3eCZxkzvF7MP1Hl7WFAVYH9cej4hGTxT42W7gNLLq0WYkv+1XcLJibajysg4GbXODisquZPlAo3OYdtzuHiLcBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349488; c=relaxed/simple;
	bh=zZHPynoOaZGptn++iz8ruNlYNX3tfi3RSMpIeMy4EyI=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:
	 In-Reply-To:Content-Type; b=As1ZwteE1KsHZLVtg69hMYeOu9mXajkZWlLrnR4BvvIbUhJd9v0da/Z4z3WbodswpB1vR1+WzdR6xIlWWfeh9s5uh4D4YPYZexIxOkE1nIc5iKnpDpZ2oIeHu9JhwlmUuUjNonN/QYq3+Ic84p0gNIIY3obDQIexW57A4iP0lEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from [192.168.42.135] (85-193-34-16.rib.o2.cz [85.193.34.16])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 359173918D;
	Mon, 08 Sep 2025 18:38:04 +0200 (CEST)
Message-ID: <f4256d82-e13a-4a67-9e72-7e9454f4e879@gpxsee.org>
Date: Mon, 8 Sep 2025 18:38:04 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
Subject: [PATCH 2/2] media: pci: mg4b: use iio_push_to_buffers_with_ts()
References: <f65be4fc-0ed2-4b7e-9955-7f64200a51bf@gpxsee.org>
Content-Language: en-US
To: jic23@kernel.org, mchehab@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
In-Reply-To: <f65be4fc-0ed2-4b7e-9955-7f64200a51bf@gpxsee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/5/25 9:06 PM, David Lechner wrote:
> Replace iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(). This adds an extra argument with the
> buffer size to ensure that we aren't writing past the end of the buffer.
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Closes: https://lore.kernel.org/linux-iio/20250724115610.011110fb@jic23-huawei/
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Martin Tůma <martin.tuma@digiteqautomotive.com>

> ---
>   drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
> index bed8bbd4bc595d1d131b9919c6f3b705e43ba3c4..4f9a35904b4186618a554e3047d6b46ff7ed74be 100644
> --- a/drivers/media/pci/mgb4/mgb4_trigger.c
> +++ b/drivers/media/pci/mgb4/mgb4_trigger.c
> @@ -97,7 +97,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
>   	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
>   	mgb4_write_reg(&st->mgbdev->video, 0xA0, scan.data);
>   
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
>   	iio_trigger_notify_done(indio_dev->trig);
>   
>   	mgb4_write_reg(&st->mgbdev->video, 0xB4, 1U << 11);
> 


