Return-Path: <linux-iio+bounces-6340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB4490A8FF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 11:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116D3B28766
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9719067E;
	Mon, 17 Jun 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fM9YY5+S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059A1836FC;
	Mon, 17 Jun 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615104; cv=none; b=MbHr5TxWfvMdQyGVhrvQ7rAvg6ihveqVrDtaNzkzr2Dj3c6t9Ag8U5b0B5sdXF/QB/XAfC+kdATzot94YcN8bYpQA0NNQqjR8E6DCmFQaLCxI7Y52mXNo83Mit85i0IkdHkzwNVxuhtOUkd3V4/JCV2sLxv7z21BBpo+Eq8k0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615104; c=relaxed/simple;
	bh=bJyr/aO6dAr6Q8n3K309ag9Uvh8BkTlic8lhxJq16yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Enpy9DHnsemm5c72qadFL70mcKseRtSEl9q1oMKDOGpQP1PrdAli0C4ddf0yM8LhZBHiilT4pAOkwzbmN10E1RFhbTpPLQLk6+um6/kW3ICy8NG1OXMKGN14MpO8ElLW7HSs2rSTsyVC10uDxHCujkZrZ2AWRNle0xk+eVwJlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fM9YY5+S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4D8D840E01A5;
	Mon, 17 Jun 2024 09:04:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ObG_vPpV5sYZ; Mon, 17 Jun 2024 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718615095; bh=6PftBkAsybJq5wobZkn4YNmGhgUEBQQ3Lg1pMZ4UKX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM9YY5+Sbw/y7zIIoxZQBPodCHfF2Ldl8dPnYAml/QDIIh2OADxEVudmDT1VwmB6s
	 l3foABm6DKNhMwUFo876QaWuasTe44MBjvYFZGLAokceOiyv+qlgVVwIxjXMo6zaJg
	 sRZ1ITda+OH7iDt3t768G9rbbx9lh0D4fCEn1SlkVCdgeXjvzXGXhzHZ59iWKb2peW
	 aGmIOEyCL2zzGwDmGP+IXZ1Sl17YFAHOBppf5+NXd6em8xW6HecPviRK2E76kAPF/2
	 y5DsgotF4l8N4oVxZtLBB152PrrfW1N+H1YZ0oVyZtW0LcFfFoBYyVEpmIuSYtj/sQ
	 mbrJKYqCqb3loUiG4VgL9oyjgoZEuWV40R9jdkRvtrReXOFTJhqeFE0gfGAwptpANh
	 M6HAowoYUV1bBLDEQbxeammlyiNvqiTOCmbvza0KtTtTz0q4jEc/DP5lyBaW7P/lz/
	 rpmqHGS/wkwG5naT1mMscb33dK9iUON4wGOX1bCW8P6NBjJvhzS7lOP5NIKpE1NUbh
	 nML1aoGd4gqFp/1BRNSP0V7SBNILWGUmbiOzUhdchKuxjfIQvdEv4J/8RKG9txAxi2
	 14CULug0iz/GGVvMDPEa6k0/2n1CJmQ4mK2HSfP8cHxjEJQX76ijX9VX6K+AAOpRmX
	 ag2yM21XKxhJ31JBWVD/gAFE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDA2940E0219;
	Mon, 17 Jun 2024 09:04:34 +0000 (UTC)
Date: Mon, 17 Jun 2024 11:04:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	lkp@intel.com, zack.rusin@broadcom.com,
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, linux-iio@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, nuno.sa@analog.com,
	dragos.bogdan@analog.com, anshulusr@gmail.com,
	andrea.collamati@gmail.com, oe-kbuild-all@lists.linux.dev,
	x86@kernel.org
Subject: Re: [PATCH 2/2] iio: dac: Fix dependencies of AD9739A
Message-ID: <20240617090428.GBZm_8HMQ9XJe_VQga@fat_crate.local>
References: <202406152104.FxakP1MB-lkp@intel.com>
 <20240616012511.198243-1-alexey.makhalov@broadcom.com>
 <20240616012511.198243-2-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240616012511.198243-2-alexey.makhalov@broadcom.com>

On Sat, Jun 15, 2024 at 06:25:11PM -0700, Alexey Makhalov wrote:
> 0-DAY CI Kernel Test automation reported an issue:
> 
>    ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_read':
>    regmap-spi.c:(.text+0xf): undefined reference to `spi_write_then_read'
>    ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_gather_write':
>    regmap-spi.c:(.text+0x2b4): undefined reference to `spi_sync'
>    ld: drivers/base/regmap/regmap-spi.o: in function `spi_sync_transfer.constprop.0':
>    regmap-spi.c:(.text+0x337): undefined reference to `spi_sync'
>    ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_async_write':
>    regmap-spi.c:(.text+0x445): undefined reference to `spi_async'
>    ld: drivers/iio/dac/ad9739a.o: in function `ad9739a_driver_init':
>    ad9739a.c:(.init.text+0x10): undefined reference to `__spi_register_driver'
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for REGMAP_SPI
>    Depends on [n]: SPI [=n]
>    Selected by [y]:
>    - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])
> 
> The issue is caused by CONFIG_AD9739A=y when CONFIG_SPI is not set.
> 
> Add explicit dependency on SPI and conditional selection of REGMAP_SPI.
> 
> Fixes: e77603d5468b ("iio: dac: support the ad9739a RF DAC")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> ---
>  drivers/iio/dac/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 3c2bf620f00f..d095f4d26e49 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -133,8 +133,8 @@ config AD5624R_SPI
>  
>  config AD9739A
>  	tristate "Analog Devices AD9739A RF DAC spi driver"
> -	depends on SPI || COMPILE_TEST
> -	select REGMAP_SPI
> +	depends on SPI
> +	select REGMAP_SPI if SPI_MASTER
>  	select IIO_BACKEND
>  	help
>  	  Say yes here to build support for Analog Devices AD9739A Digital-to
> -- 

FWIW, I appreciate it you fixing other breakages. However, there's a patch for
that already, on its way:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=75183e461ce033605c3e85518a9f3d4e4ef848a3

Don't get discouraged, though, when fixing something that is not in our
immediate area of interest!

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

