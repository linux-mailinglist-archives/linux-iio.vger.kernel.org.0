Return-Path: <linux-iio+bounces-11164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C819AEE7E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2FAB220AB
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4BA1FC7F7;
	Thu, 24 Oct 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2gnKRPi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E01F76A3;
	Thu, 24 Oct 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792004; cv=none; b=svyFLpgG1RpGycBPJxOy+HAAs1j7VpqYOSLB045rF0duQkIq70hPLM/udxegjv4gfgkAYcBbSdQE2jWtKqKPg0mn+qWT0jArI2gJWMmKRALeQND/zDrjivqvP9zsLC6nfnm5XzFjfzDfUoLnUIXcXHNCoI/ccCBeT2zEN6f7Pqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792004; c=relaxed/simple;
	bh=0oe8ZaFyqJHIzvDer+HKlnboZayD2eODXd02TS0w2+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faatVBiMRpf+4Eyd5bLJFbKxpYo5ieUIP26jFglUlwRIOmAcOGehAm40AgxW3stYCK5ZljFkH0Q+EI7LbjVwsMCViys77dX1Ue9rRgVxdBr6Ey4PvmHb5QNTH5ZOPXHuYgy/KipPfIzTW8obaoZjbtOpL6jb4hCT+t5bs0JWJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2gnKRPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60947C4CEC7;
	Thu, 24 Oct 2024 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729792003;
	bh=0oe8ZaFyqJHIzvDer+HKlnboZayD2eODXd02TS0w2+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y2gnKRPioD/Z5egwlJ/6dS+E/lum1fNQLt/sPBMPdcjNKpydwW0bZDFh0ZPU8rlX/
	 AGoSyQ5eDpRFfVzR2BkED0rtDVJLGsu8iGhAv4jBZhIgLGtyOlke3Fk4uR8LgL6IYb
	 ZXU8MzikUVwqgR0iewFfhkYpTWxhkXal5hU+RYDwGePDNJ39y+WdXrQkCJZv+N9vKQ
	 QyYk/qguUbsGAJRvMBZ+hMEdrnke6vsa/RUbd/KGLjmRhJd5tfz8GvpzAIxwlEN9NT
	 GIbrPgmohatXfVQzMrcltgwrKl4nvNDhXDs8YPKOF42TwpBkAjYboqthttTv4mib9e
	 bCRB56R17vzaA==
Date: Thu, 24 Oct 2024 18:46:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <lars@metafoo.de>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
 <aou@eecs.berkeley.edu>, <nuno.sa@analog.com>,
 <javier.carrasco.cruz@gmail.com>, <sunke@kylinos.cn>,
 <conor.dooley@microchip.com>, <anshulusr@gmail.com>,
 <kimseer.paller@analog.com>, <michael.hennerich@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <noname.nuno@gmail.com>
Subject: Re: [PATCH v2] iio: dac: Kconfig: Fix build error for ltc2664
Message-ID: <20241024184634.3bfcde82@jic23-huawei>
In-Reply-To: <20241024015553.1111253-1-ruanjinjie@huawei.com>
References: <20241024015553.1111253-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 09:55:53 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> If REGMAP_SPI is n and LTC2664 is y, the following build error occurs:
> 
> 	riscv64-unknown-linux-gnu-ld: drivers/iio/dac/ltc2664.o: in function `ltc2664_probe':
> 	ltc2664.c:(.text+0x714): undefined reference to `__devm_regmap_init_spi'
> 
> Select REGMAP_SPI instead of REGMAP for LTC2664 to fix it.
> 
> Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Applied to the fixes-togreg branch of iio.git 
Thanks,

Jonathan

> ---
> v2:
> - Select REGMAP_SPI instead of REGMAP.
> - Update the commit subject.
> - Add Reviewed-by.
> ---
>  drivers/iio/dac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 45e337c6d256..9f5d5ebb8653 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -380,7 +380,7 @@ config LTC2632
>  config LTC2664
>  	tristate "Analog Devices LTC2664 and LTC2672 DAC SPI driver"
>  	depends on SPI
> -	select REGMAP
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to build support for Analog Devices
>  	  LTC2664 and LTC2672 converters (DAC).


