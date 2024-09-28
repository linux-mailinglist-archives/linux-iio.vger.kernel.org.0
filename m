Return-Path: <linux-iio+bounces-9845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F8989067
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4441C21355
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0B13E40F;
	Sat, 28 Sep 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEuzXFvy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4617136352;
	Sat, 28 Sep 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540740; cv=none; b=D4donpYsCSOhXQpVksPArbtpq4Vojlhi6T/6/ApCXLg1blzZ5zdoa8pA4JTjmu9mv5Aw9bXGCxOMPuHj31/pJE+BagycV2ZtVDoKuWCOE8OWbzBFSbHy+y21jAQtpe+CiEXeX3eloPtI6Gq1auBL/O7wUZ8rbiPMF5S1tMQLVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540740; c=relaxed/simple;
	bh=vq13hHE5O7lTVEqGifGbhmWUFMTmHLB/74zu5TrzjoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5cfHRi0WkWQI3S+voqN80+qNugKwfLBrlil1PeeDux0xopDUvqsaOkg1x4vfcoie7QcJ5S0iU+ca6S4cSqoFkmvLik/i2TE3md+6uNplM2+u8Gj3GCPsU+wyltNBuLqApC82uMiuDHDfUTmOCmJVGlxZXuvKgdGoerDVIT8Dgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEuzXFvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAB5C4CEC3;
	Sat, 28 Sep 2024 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727540739;
	bh=vq13hHE5O7lTVEqGifGbhmWUFMTmHLB/74zu5TrzjoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEuzXFvyLhZnsVZ8b12194bXyid4vCDD1MyCxEJy/78LFVcvclyB4WdsWhta/3exJ
	 LJN4vKOu+xTBFu803Uh25yZTb2lQBU3pu0mFxp4MJtoE08s6vEkbhXyOMDrOPJXFtZ
	 P50qJBCtsJrdT+E9Wi1fAK7iIANhY4bL2axDVoPfbORp26CA20IgASc9IN8Al8DfJP
	 a7Z8zca2bqI8ZoV9qlCyj6CRKvU/detkgpKKpZimAG43fSj1SUOPBLobfQK4Re7Rab
	 hPHMwRxNOrRtezBOk+412rTEvTSvYWTr0mnoPQt5l4hpVEmb1uZZCw//lTNWuDcWaP
	 49FwBmTh3TIxA==
Date: Sat, 28 Sep 2024 17:25:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/10] iio: light: veml6030: add support for veml6035
Message-ID: <20240928172532.487df904@jic23-huawei>
In-Reply-To: <20240923-veml6035-v2-10-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
	<20240923-veml6035-v2-10-58c72a0df31c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 00:17:58 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The veml6035 is an ALS that shares most of its functionality with the
> veml6030, which allows for some code recycling.
> 
> Some chip-specific properties differ and dedicated functions to get and
> set the sensor gain as well as its initialization are required.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Just a trivial formatting follow up comment inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 19c69bfad8cb..d5c09c148d22 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -78,6 +104,15 @@ static const int veml6030_scale_vals[][2] = {
>  	{2, 0},
>  };
>  
> +static const int veml6035_scale_vals[][2] = {
> +	{0, 125000},
> +	{0, 250000},
> +	{0, 500000},
> +	{1, 0},
> +	{2, 0},
> +	{4, 0},

Similar to previous comments, add spaces after { and before }

> +};

