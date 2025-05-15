Return-Path: <linux-iio+bounces-19557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FC8AB8D65
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8842317C020
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1E2561D1;
	Thu, 15 May 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwK8HXO4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5F255F55;
	Thu, 15 May 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329286; cv=none; b=dw8N4uLCzu4u5mhh/yI0U0ASDGIDiDr4XkGZSaQeDei/Eezb2W669TkM1tz1NHD88cli50+r6DOxYw9oJYObwbsv0yYJjPfF66KJRml6zIOwiD/Yxq+hlbjW6hlnwKbPf5h/xziOe1fTgw3HWH2MonSIt1ohA0g2zU87b5LXCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329286; c=relaxed/simple;
	bh=nnM2Yxfy6SvDhbcADSk+0ey43o1zPShMFIO10useVYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb83V6WuPpm/FG3n4hdEzH3Gwha6PbnlORGxhLrvFuXSLFAreTmwvZ/J9WGC/R7WcWQANUTynNIhAE0fMYPk+dFiKr4rT2eHJkkfF6ZcEvDeVTbvffxrPY4x01inxb0yAOSrNPmNNoN4py8oYdECUQypJVFWa2rqt7kzQ290J+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwK8HXO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E092C4CEE7;
	Thu, 15 May 2025 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747329285;
	bh=nnM2Yxfy6SvDhbcADSk+0ey43o1zPShMFIO10useVYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pwK8HXO4uggupbL/lw5z5EwiF4qgCO22Gfye6S082uMvMxfUl/rbQ9uKrDglVdzzu
	 5sFz8nzyPO7pLlqofWtRAFDQG01LrTDxriCHp1RfU8Wsg3P6aHCkzGT+ViE2tjlpE2
	 8QtdofQ2Y3lSo8jtXNXtfEf9Lx6jwqj6XrG7bMapI+9uMecGodDIfZSmneX+ed+5re
	 3VFQvTGMURgWSI6DAs/W30drIL1DSgVmxz2NNhcaO9BnizFsSsZIXfYy9unKyWNQ6g
	 JiZzGxWavhTMOQ/sxrpeV366Tb/yH8s+vV+VFORpERT+HYRZi6L9NZ1lTHkPI+GRnA
	 6jq7rLaAevoZg==
Date: Thu, 15 May 2025 18:14:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Soponar <asoponar@taladin.ro>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 pavel@ucw.cz, lee@kernel.org, baocheng.su@siemens.com,
 wim@linux-watchdog.org, tobias.schaffner@siemens.com,
 angelogioacchino.delregno@collabora.com, benedikt.niedermayr@siemens.com,
 matthias.bgg@gmail.com, aardelean@baylibre.com, contact@sopy.one
Subject: Re: [PATCH 12/16] iio: max44009: Fix type incompatibility with
 non-macro find_closest
Message-ID: <20250515181425.6a16455c@jic23-huawei>
In-Reply-To: <20250515081332.151250-13-asoponar@taladin.ro>
References: <20250515081332.151250-1-asoponar@taladin.ro>
	<20250515081332.151250-13-asoponar@taladin.ro>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 11:13:28 +0300
Alexandru Soponar <asoponar@taladin.ro> wrote:

> The max44009_int_time_ns_array array was previously declared as u32 but
> used with find_closest(). With find_closest() now implemented as a
> function taking signed int parameters instead of a macro, passing unsigned
> arrays causes type incompatibility errors. This patch changes the arrays
> type from u32 to int to ensure compatibility with the function signature
> and prevent compilation errors.
> 
> Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/light/max44009.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> index 8cd7f5664e5b..d274224fc210 100644
> --- a/drivers/iio/light/max44009.c
> +++ b/drivers/iio/light/max44009.c
> @@ -55,7 +55,7 @@
>  /* The fixed-point fractional multiplier for de-scaling threshold values */
>  #define MAX44009_FRACT_MULT 1000000
>  
> -static const u32 max44009_int_time_ns_array[] = {
> +static const int max44009_int_time_ns_array[] = {
>  	800000000,
>  	400000000,
>  	200000000,


