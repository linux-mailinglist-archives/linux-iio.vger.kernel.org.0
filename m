Return-Path: <linux-iio+bounces-19556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54845AB8D59
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 19:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB26A00874
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A52550CD;
	Thu, 15 May 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSsNv3I5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682E254874;
	Thu, 15 May 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329256; cv=none; b=lOaRRXUJ783icyoskQMRcLvGPZcTDc+G8Bi9Lb3x0fiFRcX/1TSyOCyoJlzsZpcBEUregD0oziyh7rWzZt+wPAakv8GclUB8U6feIh7k8JkYwvGJky/g0u1MnY+Mj/n0c8hygS6DOJmNoRUbfuFYyfosD5Ci0kiewhdriGJYLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329256; c=relaxed/simple;
	bh=1kH6Yj5YoLweQxGzcEBR6E9T5+65B0E7uvx6ZEZnB/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIBpk//gcK9lVTpuOywM0LZihZFO/HmJAXTpbKxVjdfWX4EyN6SYBgBWP47pjorCCy9iNWTfgRj1VBp7Ymx2D6tsFME7mR69bvMVBt4gr193I2pRZc4gWnEKjaImSYQWOoU60oVb7F2oeNlYSetc9Z/xrqCfWWLBaT1aS8uTHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSsNv3I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7350C4CEEB;
	Thu, 15 May 2025 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747329256;
	bh=1kH6Yj5YoLweQxGzcEBR6E9T5+65B0E7uvx6ZEZnB/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bSsNv3I5scownM4WDXL0buySulJKwhWadtJTglg2Ymi0vi+elgrixZTEkChrp9mhM
	 9Ma11OAA0uOPvB1i1zMAzxKFzYLeotQFpm08uwMXBpcrQRhSKLKi8RTxAK38WgOYkn
	 K34WwAMRRS548fbFD4VkSLR+/bbHVINKZTw9HonSLOrx1+d6Yn2WDxB6s6Gwah7O0e
	 UaORGImLH+mHzxlBbZ6rdS3zL5QPMpo5u2ZuSrc6pJjsiMom2zgtep4/8GzAwBXzGe
	 tiWW7gDIUHgYVxH+LS1AvE7hI7u/LoVwvv4JkupAWyvAk2p5zAgYLgp89hfI8Pb0WX
	 G6W4IO9LHq33g==
Date: Thu, 15 May 2025 18:14:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Soponar <asoponar@taladin.ro>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 pavel@ucw.cz, lee@kernel.org, baocheng.su@siemens.com,
 wim@linux-watchdog.org, tobias.schaffner@siemens.com,
 angelogioacchino.delregno@collabora.com, benedikt.niedermayr@siemens.com,
 matthias.bgg@gmail.com, aardelean@baylibre.com, contact@sopy.one
Subject: Re: [PATCH 11/16] iio: mcp3564: Fix type incompatibility with
 non-macro find_closest
Message-ID: <20250515181405.083dd030@jic23-huawei>
In-Reply-To: <20250515081332.151250-12-asoponar@taladin.ro>
References: <20250515081332.151250-1-asoponar@taladin.ro>
	<20250515081332.151250-12-asoponar@taladin.ro>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 11:13:27 +0300
Alexandru Soponar <asoponar@taladin.ro> wrote:

> The mcp3564_oversampling_avail array was previously declared as unsigned
> int but used with find_closest(). With find_closest() now implemented as
> a function taking signed int parameters instead of a macro,  passing
> unsigned arrays causes type incompatibility errors. This patch changes the
> arrays type from unsigned int to int to ensure compatibility with the
> function signature and prevent compilation errors.
> 
> Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/mcp3564.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index a68f1cd6883e..01efc77f710a 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -253,7 +253,7 @@ enum mcp3564_oversampling {
>  	MCP3564_OVERSAMPLING_RATIO_98304
>  };
>  
> -static const unsigned int mcp3564_oversampling_avail[] = {
> +static const int mcp3564_oversampling_avail[] = {
>  	[MCP3564_OVERSAMPLING_RATIO_32] = 32,
>  	[MCP3564_OVERSAMPLING_RATIO_64] = 64,
>  	[MCP3564_OVERSAMPLING_RATIO_128] = 128,


