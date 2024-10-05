Return-Path: <linux-iio+bounces-10197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1912C9918F7
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2001C20EDB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8D01591FC;
	Sat,  5 Oct 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNK3sXfb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DD158DCA;
	Sat,  5 Oct 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150059; cv=none; b=GkegITe2jjpBFl9ADt6h/Bm8dHnuSiJsVthMwHWSLAWf44Tb/ijG0jRByKNJKe4vDVg4baymgsiwaPok8VnrtN7c2hPf2E/NPtJnZ9NqJNYNW9v4gX/KeMgFJXjDUARNWhSoKpNTHGgutHXV9XZdkiR/6x067HvrDnunEIENEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150059; c=relaxed/simple;
	bh=cBdbuPTUpxfP6eMgC/lhcKtPx49h+a7Y8BWA0yItIA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAcr0dEb64ZyO61l41T+Nj7zwOdmshJFFTrYE6wnOm503R7IsfSwfzioCaU1vs/Alinm4BXgO671tCFsK/wwODhYMY1xvVpTyi0VfF7YT6tLPnLiQy/PuHsI3ScayDcwphJictE3OAWNC8edAAp5Q6eqoPwcPbqMSP7awUp/Dk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNK3sXfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0CFC4CEC2;
	Sat,  5 Oct 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150058;
	bh=cBdbuPTUpxfP6eMgC/lhcKtPx49h+a7Y8BWA0yItIA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UNK3sXfbC+99Mklm71r+M3DFqwg4LIjMBwFjJorMyZ9k3DNzO49znYtugIA/Fk1ez
	 +gnbXv6mCZp5kRs6vcijWSE1cwivb/xPfYh/iuO8Nx5CLQGpOSsn72dg9CuREsqO9p
	 2HvLY8D3trHBuKcDp2EBtGFM/ejLjGdEY1wY0/irfzr/abjQ4wx1rRANAP9qM8Q31M
	 6Umt/iUVshCq6/h5oqGA5lsBQJy8fnYuM/DZgEeTAyS4jz+REvp+DMPYVuLVWGjFZ9
	 Mwuz1R4LnYb5lOlLD4VDOQEBzV6StV+bFE29E8AJQJ8JqDW6ym65xTLmGwnabI0QyD
	 kA+Gb7Rq7LXGw==
Date: Sat, 5 Oct 2024 18:40:18 +0100
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
Subject: Re: [PATCH 04/13] iio: adc: ti-ads8688: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005184018.6b06e850@jic23-huawei>
In-Reply-To: <20241003-iio-select-v1-4-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-4-67c0385197cd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 23:04:50 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Fixes: 2a86487786b5 ("iio: adc: ti-ads8688: add trigger and buffer support")
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
Fixes tag must be part of the tag block.

Also this one looks to be a false positive. The driver includes
buffer.h but doesn't actually have buffered support.

> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/adc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 45872a4e2acf..e6be1f1ec79f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1483,6 +1483,8 @@ config TI_ADS8344
>  config TI_ADS8688
>  	tristate "Texas Instruments ADS8688"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for Texas Instruments ADS8684 and
>  	  and ADS8688 ADC chips
> 


