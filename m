Return-Path: <linux-iio+bounces-27267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E681CD3FC6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 13:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92B5300FE1D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144792F7475;
	Sun, 21 Dec 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSjOlOk3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968E274670;
	Sun, 21 Dec 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318665; cv=none; b=XTf3j6YT5kHNOQG4NOhWWUBWnqZx2179SmimAGi5qfleNvfkqSD46HCkZZRtMrLiReJ4g3aHFIhqrySLCV4BdTsJevo1s5Y0UMWbYcRvoQgqshptTh2aJ3mYh9oL32mnUysccmuvQUY2ftJSvannKSPVA4IQfXvwX7TOslmA334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318665; c=relaxed/simple;
	bh=vYJHXTF57S2uWIWZSnj37Cbd8d3rIPZwHikEoAhE4qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYmSHt1jjH2efD/31WBewGmP42JqTLRE/vmxrDibwgab8xTW/epCP53EzDK63ZJTeCe3YIJ1N7PCmL6RzTTG5Uk6MmJ8ZVu4ZhCRt8VtLaFXaVRpTnQwmfpEeokj8hZCRPFip6jzeH9vGaWcsCdfHfbXgETIcKD+6ZkVtXzMZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSjOlOk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBF7C4CEFB;
	Sun, 21 Dec 2025 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766318665;
	bh=vYJHXTF57S2uWIWZSnj37Cbd8d3rIPZwHikEoAhE4qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kSjOlOk3h9BEnPlVU+aF/hIoaQV4c+oE2pmS+dEjUHl1yr+qW1KFlR8WM8sJ2bVd4
	 qG9vydCViH89KPRGzVk6N89j4gByJknCPPjmfXkB/xfnei0gPVtOQLaxmc2CEMYYAW
	 4cO6SbQTlo0TdXY/UrnfGdQ/rPWYIR9bfyysAGRF8P8CKYk+83V7PnQN5jvsJZorgO
	 gcY2l+ehX46+G4byGX25XLKjXZhj9K+AiEiiV7IJCP3myCkXSVy4Z4uhTxvXMDcOB3
	 3hmzaUdRhhnfbZzIM5IbaNdiEk6GEPy41lgxBviQenD55MuAM07dW2xJJNV66itTvr
	 GH0Ltqv4LgQ7A==
Date: Sun, 21 Dec 2025 12:04:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Krzysztof
 Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Heiko
 Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/5] iio: adc: aspeed: Simplify with dev_err_probe
Message-ID: <20251221120413.7f1fa877@jic23-huawei>
In-Reply-To: <20251219-iio-dev-err-probe-v1-1-bd0fbc83c8a0@oss.qualcomm.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
	<20251219-iio-dev-err-probe-v1-1-bd0fbc83c8a0@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 15:31:50 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use dev_err_probe() to make error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Not a comment on this patch as such, but this would benefit from a local
struct device *dev


> ---
>  drivers/iio/adc/aspeed_adc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index bf2bfd6bdc41..1ae45fe90e6c 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -535,11 +535,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(data->clk_scaler);
>  
>  	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
> -	if (IS_ERR(data->rst)) {
> -		dev_err(&pdev->dev,
> -			"invalid or missing reset controller device tree entry");
> -		return PTR_ERR(data->rst);
> -	}
> +	if (IS_ERR(data->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->rst),
> +				     "invalid or missing reset controller device tree entry");
> +
>  	reset_control_deassert(data->rst);
>  
>  	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,
> 


