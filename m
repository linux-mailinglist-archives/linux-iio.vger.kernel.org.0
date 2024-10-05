Return-Path: <linux-iio+bounces-10203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E40C991912
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A0E1F23E6F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624B159565;
	Sat,  5 Oct 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM8MEbml"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC7156F54;
	Sat,  5 Oct 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150859; cv=none; b=QSXFN3FpbsAg2n8xAFtG355IuBhTiYW4qMkucBA37saGW5om8v9w7j9rsa4zZGHTdmI8tR8k7XOb7tV1Xkin5GR1fDh2JlI7FAHYy1Mx14KwxYHR/r/u3pGsPjaCCb4AHQ71qnFmEzUapdvADxvnY3/eraBD5EtIqCKUn20tW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150859; c=relaxed/simple;
	bh=Zdc1nEsPDJGkjG68GGebjBMLvSeloWUPXn1YuA+8Elc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhrMAjlMJEqx7TBS6wValKv8or2dxQA3PX2mB5jleFTqYhdImx1dsOalZWSRH/VjyJ4K/xOCX1t82VThUODx/C77Ah8x8eH22+Lh83qF7e/E/7iarzxfjnx5LiWJw00EWJeJZTaCkd/GtsJGMYehfrYi1wqQ/EQ408C+Drv3Bzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM8MEbml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A46C4CEC2;
	Sat,  5 Oct 2024 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150859;
	bh=Zdc1nEsPDJGkjG68GGebjBMLvSeloWUPXn1YuA+8Elc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fM8MEbmli3sv0f+lM7tTdouSOpI5oxcSwAR27oCOVai7QxhklbCHskfJUQM5QcVkH
	 HURlnY68+x/lKL2JjO+4cf5VWBydhnpSjCG3BHdrpEL0JLrxKtY8b5OrmWcX9oneCU
	 0U1Fi63LtaSyLtP6ZPzbLzon9sVJslKQOJXuA0uNoVC20OtjHR7Z+tJGeNWcTzCCkd
	 pZTNbpV+Z5KK/LE0IoUerBKURrX9USKi/B8DKgR2sSMgQ5Bi7XGRsKqcg1MpNE1FP8
	 NJpMFfodCfGn8rAeI96xfgVkt41A1hc9c1mlbv/1KMpnFQEoO2LZxbB1PUfweuooEW
	 Z4Hl+MCCT3DsA==
Date: Sat, 5 Oct 2024 18:53:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Lechner <dlechner@baylibre.com>,
 Nuno Sa <nuno.sa@analog.com>, Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer
 <sean@geanix.com>, Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
 Mihail Chindris <mihail.chindris@analog.com>, Alexandru Ardelean
 <ardeleanalex@gmail.com>, Gustavo Silva <gustavograzs@gmail.com>, Shoji
 Keita <awaittrot@shjk.jp>, Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, Andreas
 Klinger <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>
Subject: Re: [PATCH 08/13] iio: dac: ad5766: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005185338.52d0780b@jic23-huawei>
In-Reply-To: <20241003-iio-select-v1-8-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-8-67c0385197cd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 23:04:54 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 885b9790c25a ("drivers:iio:dac:ad5766.c: Add trigger buffer")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the fixes-togreg branch of iio.git.

thanks,

J
> ---
>  drivers/iio/dac/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 9d4600ce0427..bb6cb9af9ed9 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -254,6 +254,8 @@ config AD5764
>  config AD5766
>  	tristate "Analog Devices AD5766/AD5767 DAC driver"
>  	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD5766, AD5767
>  	  Digital to Analog Converter.
> 


