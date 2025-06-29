Return-Path: <linux-iio+bounces-21111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7513AECEC1
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5749F1894C17
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD512230BEB;
	Sun, 29 Jun 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZWB1u5r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A66FB9;
	Sun, 29 Jun 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751215761; cv=none; b=YJSMavwnO81HsKsmaefMRYPFShKMzeewUJqKrAkuQdCQYYnTVkFG1uuYdEDcRZ3Z0cbQFYve+nYukQQ5sYBGv3ZSD4cM5fhtUVc7/AV0yJ0UgUIezYppkuQxk0d+YzqQmpY3J9O+Cq3RiSI0upLc5toqXtSkvNz20xAo74XLveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751215761; c=relaxed/simple;
	bh=8OS0yqoShl9eu3bjLrpMehY4QeHWIZLBTSu9YNCh4g4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV0seurRAXZBYS1h2pjR11gZvQ43l/xwG/E8KiVT//9wVxFEzfb1+AQn7utoqlViaWMtftVShQhT3ow0wicvKsmFr0dLhArTiHm5oqhFScYwLakApU3WlqNmY3PlZlrrgtzZgMwJPCWMBhBH2UzBTre/WjZJxDmIQH2nQXDPSH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZWB1u5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A6CC4CEEB;
	Sun, 29 Jun 2025 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751215761;
	bh=8OS0yqoShl9eu3bjLrpMehY4QeHWIZLBTSu9YNCh4g4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZWB1u5rgHRoGeHvR5fza9ZuPVuqbWzSPB3yZhDEDxRXQw6S6sxtasrG7ZHgQn3GX
	 lvdXVGYkJRtfIe4QJr0vuiFyuVhDZZNYC4bOWpzdVMm8P7D1Gkw1Ha2eKT2vz6bLnB
	 AdKsFia9ZxJpC5mjyylXT3eSX3EU/VpSlsqrG5Pv6feVuagwSyscKzGLpfqxLm+jEC
	 swniy75NHtXltbU/0RLuES1uLlblKuQshJQhbI1rY214PSzXKnrK838ALxLWnctk1O
	 ZzqMPBctknMwTH8ZTDsWHNCEGMCkMENJ/Z5DUHy1LRyjCRZ8wHCfCVTrRgSTKhJfAA
	 9ngWQ0YiGR3iQ==
Date: Sun, 29 Jun 2025 17:49:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7091r5: make ad7091r5_init_info const
Message-ID: <20250629174912.036e6898@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-3-v1-1-13d3f0af5f3f@baylibre.com>
References: <20250628-iio-const-data-3-v1-1-13d3f0af5f3f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:06:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct ad7091r_init_info ad7091r5_init_info. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7091r5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
> index b472b9498fd1307e493579e257769ace233eb073..bd4877268689f048eb67e262ac5ea0c1f5c04a76 100644
> --- a/drivers/iio/adc/ad7091r5.c
> +++ b/drivers/iio/adc/ad7091r5.c
> @@ -92,7 +92,7 @@ static void ad7091r5_regmap_init(struct ad7091r_state *st,
>  	st->map = devm_regmap_init_i2c(i2c, regmap_conf);
>  }
>  
> -static struct ad7091r_init_info ad7091r5_init_info = {
> +static const struct ad7091r_init_info ad7091r5_init_info = {
>  	.info_irq = &ad7091r5_chip_info_irq,
>  	.info_no_irq = &ad7091r5_chip_info_noirq,
>  	.regmap_config = &ad7091r_regmap_config,
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-3-fecf1e7698ac
> 
> Best regards,


