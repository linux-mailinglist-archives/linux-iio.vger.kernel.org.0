Return-Path: <linux-iio+bounces-7798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C657939487
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264A41F21082
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC518042;
	Mon, 22 Jul 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGXi5th1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED808DDDC;
	Mon, 22 Jul 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678478; cv=none; b=czsZQva9pmbLHVcrj3PNqpDjFt37OojUkyBltpsziX15TWb8xELvTckwkRz9copMNsMx/QSozM8HzOV2ujTM4Pk7tAzMG+vDzsNcEObPlalzknSx1ml4xczOcGlhXbMdLKQe4l2+FuOpzbJ6h7MnaQ/P14Mt/T17pWXHQAdFS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678478; c=relaxed/simple;
	bh=cfx2IEBAJvr/Le7OR2NOFIbsx6vpBws+z8Tgwex+Ras=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agF26Ej6qR+bYG6H6J0iYQ0upePm5nxoUWWGMVHZWstsmx0TzhKq5KOrGbunz6mUUqzAysJ9iz21wwnyf+nCf0CqjKPjiKqhLLwe8FPpSRu3SdkJFN2T3d79PTJ1MPgfLjquCRgmNUf1VuDenBA2tpHrW70TAH1+h2mXS1rarRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGXi5th1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C75C116B1;
	Mon, 22 Jul 2024 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721678477;
	bh=cfx2IEBAJvr/Le7OR2NOFIbsx6vpBws+z8Tgwex+Ras=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nGXi5th1VN70wpahO3OHaswmRmu1x+884UcatqPke1zNs90KRWYIMzbrPGBUgXZJG
	 FW2p8BSUL3ZhVEy2zjajtCHoyz3sbaj6fkue3goniZ/TJghYcb+qyWEirKufCQ2+b0
	 wjSWjFC361B8hCRKBfHuWY+xidKW17zNH5bg1o6HFu02vjg/4x9IvL1kgZDWjbZqOF
	 ssWsC3PQ+r5WE1Nn2eYZnoL+8oe/emvfzeKt+conzZ1S0qWfpXWn9UEnKC5F6FsJu+
	 tP/XMQGWqw/UT/8ImWdX/4aJoM0WdEaSy9xLKcCcelC2tTVdtNWePGzB4N8w5spoDF
	 E7EKgWfcSrMyA==
Date: Mon, 22 Jul 2024 21:01:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vasileios Amoiridis
 <vassilisamir@gmail.com>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: pressure: bmp280-core: Make read-only const
 array conversion_time_max static
Message-ID: <20240722210111.49e66c4e@jic23-huawei>
In-Reply-To: <20240722151738.572913-1-colin.i.king@gmail.com>
References: <20240722151738.572913-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 16:17:38 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only array conversion_time_max on the stack at
> run time, instead make it static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

I'm almost 100% the compiler can hoist this off the stack if it feels like
it but sure, it might not and adding the static keyword probably obliges
it to do so. Is that better or worse? Probably better.

Ah well, I don't feel strongly and it's probably a good thing.
Applied to the testing branch of iio.git for now. I'll rebase on rc1 once available.

Thanks,

Jonathan


> ---
>  drivers/iio/pressure/bmp280-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 49081b729618..9ead52954de3 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1865,7 +1865,7 @@ EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
>  
>  static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
>  {
> -	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
> +	static const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
>  	unsigned int delay_us;
>  	unsigned int ctrl;
>  	int ret;


