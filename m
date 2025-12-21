Return-Path: <linux-iio+bounces-27289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CF2CD4434
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A4503006F40
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD74E2FF144;
	Sun, 21 Dec 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP1kgADE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816428BAB9;
	Sun, 21 Dec 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766343006; cv=none; b=r7hH7gRt0w/kHTvMudNJrG1jENgJSBvrLq+82UhzFsyVAH+WBOE6D4nbw2wCeQZRbGv3RT463sTezQaD4yyQzT5eQ2YEJRszzkVZb1C+BCcEEpbXuXy9DR2ow+/a5sM9Xhdbm6BUdGvP+2sTTDMRb40VLW6D8LGI5EJxQxRxpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766343006; c=relaxed/simple;
	bh=iJxESWoZswFEivRLufK5vXZdeM5vwQIXotRdSan+dMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZid82JEvYV/52vBpduiXh2vUQWZjiA4We8xTSgi6qOVt2qcQIO/IhQSZL4Rq7w95yAVmUhMUA0GbqwKRo3dNKQ06l1tLhIY7R0Trbw7bVYfp/Wv+0808MUep3Maa5cLgY6yhjqhwlxvQqWA/eULOMdveqVh03JlQTMukrYtLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP1kgADE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CBBC4CEFB;
	Sun, 21 Dec 2025 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766343005;
	bh=iJxESWoZswFEivRLufK5vXZdeM5vwQIXotRdSan+dMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NP1kgADE4yTwjwMMYthqRAJCtZ9Fg5KKHvP+K9MwIsIGOhzyaOnrVZ+MFfqPlO1HI
	 sBxfly3BDa/+CvKTbAq7l4MFzciMI3mQCwo2leoUfd80sqZOXXIwtJ12bYAnMBnD5g
	 5obIDTZqVUgKTJoZF3/1zPLlXlR2YqHGMVSOOW+9YslKelozW4bPL221WAWcbZoa46
	 XwkFb4YjAUsDaW4K/DjrdI+7cPA3EuRdMyZy8Z6L8H+eHY6kOWppSnHbgD8VADQjgl
	 QvYUS93o+i51Y8H1xj8jVPOCD43AYrTOpI9/b/dVwgjRVjJ9JmeoCwaOVmPMa5SzvF
	 lt0Rb35Icn0Vw==
Date: Sun, 21 Dec 2025 18:49:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1018: Drop
 iio_device_claim_buffer_mode() call
Message-ID: <20251221184958.2d825e2e@jic23-huawei>
In-Reply-To: <20251216-ads1018-patch-v1-1-cf41d193e187@gmail.com>
References: <20251216-ads1018-patch-v1-1-cf41d193e187@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 19:52:01 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Drop iio_device_claim_buffer_mode() call in ads1018_trigger_handler() as
> it's not actually protecting anything.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
I squashed this in.  One comment inline.
> ---
>  drivers/iio/adc/ti-ads1018.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> index af08702b62d2..b34184f68e63 100644
> --- a/drivers/iio/adc/ti-ads1018.c
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -557,9 +557,6 @@ static irqreturn_t ads1018_trigger_handler(int irq, void *p)
>  	} scan = {};
>  	int ret;
>  
> -	if (iio_device_claim_buffer_mode(indio_dev))
> -		goto out_notify_done;
> -
>  	if (iio_trigger_using_own(indio_dev)) {
>  		disable_irq(ads1018->drdy_irq);
>  		ret = ads1018_spi_read_exclusive(ads1018, &scan.conv, true);
> @@ -568,14 +565,11 @@ static irqreturn_t ads1018_trigger_handler(int irq, void *p)
>  		ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
>  		scan.conv = ads1018->rx_buf[0];
>  	}
> -	if (ret)
> -		goto out_release_buffer;
>  
> -	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
> +	if (!ret)
Generally I fairly strongly prefer error paths out of line but in this
case I'd rather just get this merged than go around again so I'll leave
this as it stands.

Thanks,

Jonathan

> +		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +					    pf->timestamp);
>  
> -out_release_buffer:
> -	iio_device_release_buffer_mode(indio_dev);
> -out_notify_done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
> ---
> base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
> change-id: 20251216-ads1018-patch-ad02382e0a04
> 


