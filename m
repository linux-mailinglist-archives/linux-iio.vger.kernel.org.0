Return-Path: <linux-iio+bounces-27705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B5BD1D4A0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F8530940F8
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C913806CF;
	Wed, 14 Jan 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmbFwVVN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48A37FF4A;
	Wed, 14 Jan 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380719; cv=none; b=OP5HkdRuARpZCwhlg3njKwioJxuJ/lJ00Yv/Ru99K9QHNWBrWyuQh8eDh30HvdpEGjk+18RPR/WT6EvIKCP8J9DsYsy+Pl2TtdYu/O+p8op8JALgCnsLvfr/41WFii4swexQrh46fd6QkmlHWIULhjM9O1fpG2MA2IMtE8Vx2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380719; c=relaxed/simple;
	bh=lOZvqw3ggydiiHeL30T8f29Mcyk7YPU0Xtwl6LDxnSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGzAq29QQlVf4972EuS1wtQaRjKaWij6fSQGMpRWCfaeugMRU83UrvyV/ay1BDWIQKvJi22rZMRaf7VXR7RHRxtZfpndp2k6EtPMQMDN/vtniOoR28qFwOGkjvVeteHa4tE1zgObPuv07OgnrtZS21M1QuGu0UmEvNHmVlIxrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmbFwVVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089D6C4CEF7;
	Wed, 14 Jan 2026 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768380718;
	bh=lOZvqw3ggydiiHeL30T8f29Mcyk7YPU0Xtwl6LDxnSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WmbFwVVN3Oam+fcK0hElRSCDzdW/ra9IOkYzF+72MLi0IwleGUeOMUeTKUWe6GDyb
	 aWSD76xfgG08hbbihqcr5nI1ZK8llg1nbFGKczcKpftFlNFt9ZYOyJzyxsDn5W5cS/
	 KowzQ5j0sbfJdheeJaeDpQuAt33HvlRiOBi4mh5pCwtXUm+/YM0QLtNhAfvOeiVKpG
	 pslWsxuSXeApvTJvv8gE4zAOEDkAgGiyZZPCKF+vOrQ+AKdwipfsH5Ze1Ia2KK0Azs
	 TKunu0pWBoFx0KpXcf6PPPvQgdgmNYGbkaONXpJtvEhEwZukyEkbrdia/IoueKLpVq
	 eQlt9aJihwTAw==
Date: Wed, 14 Jan 2026 08:51:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 1/2] iio: pressure: abp2030pa: fix typo in Kconfig
 description
Message-ID: <20260114085148.15bb6ed8@jic23-huawei>
In-Reply-To: <20260114-honeywell_abp2_driver-v6-1-231c3a8c222b@subdimension.ro>
References: <20260114-honeywell_abp2_driver-v6-0-231c3a8c222b@subdimension.ro>
	<20260114-honeywell_abp2_driver-v6-1-231c3a8c222b@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 09:51:37 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Replace "I2C" with "SPI" in the SPI module description.
> 
> Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
I dropped the fixes tag as we wouldn't normally bother for a help text
typo (+ it might be a pain if I do have to rebase my tree for something
nasty that I haven't noticed yet).

Applied.
> ---
>  drivers/iio/pressure/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 0d25842aa414..838a8340c4c0 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -38,7 +38,7 @@ config ABP2030PA_SPI
>  	depends on SPI_MASTER
>  	select ABP2030PA
>  	help
> -	  Say Y here to build I2C bus support for the Honeywell ABP2
> +	  Say Y here to build SPI bus support for the Honeywell ABP2
>  	  series pressure and temperature digital sensor.
>  
>  	  To compile this driver as a module, choose M here: the module
> 


