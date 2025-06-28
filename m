Return-Path: <linux-iio+bounces-21030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF31AEC7F1
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3415817D26F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08792571D9;
	Sat, 28 Jun 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvSYFQoW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856F253B40;
	Sat, 28 Jun 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122280; cv=none; b=moc2vIVIMR8BDVLdQs73pGuT2+lUM8jA/3Kg5zuyrer60evXsfv7EbsXORbFzVPTwdrwDdNZh3tQ+YjZn1lMSTjHxPA4G41stvCT7R7TAjBJIySU9bzNlmi9D9Kng6+ChKxwB8JRTLNdeiwXlcGbRS1n/qTJKrF4mcCIiuqxcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122280; c=relaxed/simple;
	bh=1QxAFsBgthe7+8/aWbErprguVQxwCeMWu1FhGtsOzWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCQ158Fjx+VDi3iP65ZsXOALRhRr0f5LCxMX7xlNhD3CcSSQBbYwNoM/Nuja5tRhmgR2LTE8v8a59wK7CAYm9fA9BGXDUSKmLUIMzgf2+nxNlL7NGNpphzt7nWPl4UnruwM4i164/tY/QKMYB9BIfbABmC0TbBxa54Q7i2MuVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvSYFQoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C4DC4CEEA;
	Sat, 28 Jun 2025 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751122280;
	bh=1QxAFsBgthe7+8/aWbErprguVQxwCeMWu1FhGtsOzWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hvSYFQoWLpoLmZcGhTRchDq/RofWPfwVh0EmDMSpxqd6/hYh0/UD0MP6rjEUlNG+M
	 KY4/tTlsqG0YgjRB2aIGMI1NxZv1Ub3tPhaNKnOvZA2HWhp9uD3jgLjFXZ0e50Uk6u
	 2MCyCirSu2UNfq3Uwcj9mvO69PZG5UGbIbxMpKwywhQ/M52v2iYmQsH3UTP7lmhGPR
	 vBiFT8eEdW4Bp8MRDBUkhFcEndIpDhF4+FUDHfkYTsjFhhGrKEGpoLgoOWShkvqLFY
	 YS0eMqBXr1H5iI9vHbz44Uer4oeTi+gRffo2IJTZFX1ITlg2+9wOWujE5nSndZHgpK
	 QcrpOSkt3CIwQ==
Date: Sat, 28 Jun 2025 15:51:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, linux-iio@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: axp20x_adc: Add missing sentinel to AXP717
 ADC channel maps
Message-ID: <20250628155112.2d45ffe1@jic23-huawei>
In-Reply-To: <20250628044326.2844027-1-wens@kernel.org>
References: <20250628044326.2844027-1-wens@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:43:26 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The AXP717 ADC channel maps is missing a sentinel entry at the end. This
> causes a KASAN warning.
> 
> Add the missing sentinel entry.
> 
> Fixes: 5ba0cb92584b ("iio: adc: axp20x_adc: add support for AXP717 ADC")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
I picked up the version you posted on 7th June.
I've been a bit slow to send a fixed pull request - sorry about that; busy
few weeks.

Jonathan


> ---
>  drivers/iio/adc/axp20x_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 71584ffd3632..1b49325ec1ce 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -187,6 +187,7 @@ static struct iio_map axp717_maps[] = {
>  		.consumer_channel = "batt_chrg_i",
>  		.adc_channel_label = "batt_chrg_i",
>  	},
> +	{ }
>  };
>  
>  /*


