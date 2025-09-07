Return-Path: <linux-iio+bounces-23832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A2FB47A12
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5753C25C4
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D231321D5B0;
	Sun,  7 Sep 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtCz39oY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B831E0E08;
	Sun,  7 Sep 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757237576; cv=none; b=EqABeVeDXFYrEAuDRzlTGeWNJLGvfH0Kw8X2YEyvg1yijwuRXuv2XfqztOW4BU+PLi0IZ+Vzpc2lBVyCNran1ggCX8VErc0zljZ9JrXIifTSvmNv4y18FzqsmTu7J7RsOHtNw7RTUAcqp52mSObIdnuM51BTaO/ydSHQtzGeoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757237576; c=relaxed/simple;
	bh=dxZQir0SlR84IxXTfW5BTCfJAAt3eTCfb0hgRwAhNOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8eE5fXd0/T5O6Kz0IrHofMUYxHrU6+Uwz1/5QkW+MyLmhwELOA4NRfsjI6YO43N8CwqtVLKEkzqVJG54aZn7eEAMU1zoLgAhhA0PkSeE6H2QbAanhYDa28u2wLWOe1ixBvxuA1JpmUDBhgb2d3OrCug5xu23M7ozKqhmZV5opc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtCz39oY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D0DC4CEF0;
	Sun,  7 Sep 2025 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757237574;
	bh=dxZQir0SlR84IxXTfW5BTCfJAAt3eTCfb0hgRwAhNOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WtCz39oYobs55K4NnuSJwjwcXHZIq7OjCV6dp2jj4xd79+NC6Rc/Z0zWaMeypO1m1
	 nohNT5mNgAza1UbLrKT5ct1KhFBwKcDQ9QAyofCvjQ5qHf3/7BeYFatcF9toNm9ZsK
	 xncyVl43ODDtZSnGpTCnbG7v/45eMn2jAwRgMv4Bm4LiB9k5+nuAnf2PNk7vq2YkIw
	 bG09MuUfwB5NDbNjIZa4k6mzlk7Sp9hEY8+aPqD3fhvLctSS6ADkNCjcTBuITrSBga
	 Di9fC9SF8H46H3s+c0Qb65CnuaZpRzDYXlj/yONmxxUxPSLbgwoN2IEUolYGWbRmxm
	 0NqUqbr7AXUZw==
Date: Sun, 7 Sep 2025 10:32:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pci: mg4b: use iio_push_to_buffers_with_ts()
Message-ID: <20250907103246.405d57e6@jic23-huawei>
In-Reply-To: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-2-55996f077a02@baylibre.com>
References: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
	<20250905-media-pci-mfb4-iio-trigger-improvements-v1-2-55996f077a02@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2025 14:06:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Replace iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(). This adds an extra argument with the
> buffer size to ensure that we aren't writing past the end of the buffer.
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Closes: https://lore.kernel.org/linux-iio/20250724115610.011110fb@jic23-huawei/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
> index bed8bbd4bc595d1d131b9919c6f3b705e43ba3c4..4f9a35904b4186618a554e3047d6b46ff7ed74be 100644
> --- a/drivers/media/pci/mgb4/mgb4_trigger.c
> +++ b/drivers/media/pci/mgb4/mgb4_trigger.c
> @@ -97,7 +97,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
>  	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
>  	mgb4_write_reg(&st->mgbdev->video, 0xA0, scan.data);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	mgb4_write_reg(&st->mgbdev->video, 0xB4, 1U << 11);
> 


