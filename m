Return-Path: <linux-iio+bounces-10202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9399190D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E251C210D2
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF49158D96;
	Sat,  5 Oct 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8o4P8Dt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFC158D8F;
	Sat,  5 Oct 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150777; cv=none; b=Eu7H+WzjtmhFGjtsyjkPlCsfSAKOVg2qaY/U6m1avdZaS+SU01bjELsZ4E02dtoITiTFJwnv8ibAMJk54oDmJVQ+HhknZWQ499dfO5wMe7MtXD1dFx+YJ0V8thh0iNcZYzMsmaqBaJkT4QCseq3o4kDkgXJEF4Zax9QYXL0qB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150777; c=relaxed/simple;
	bh=pIwQAN4FdavGSGPv5+wTCfD5UEyGQIkHBKYeey2+oVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFQ1SHnvZsNjMvw6qEIo6MtGQYHHRjnlBDmc4B85RsIF30J8dF4ul+8BVvQTomvCb30Rrv/0EUquIx/fRbyH2aPCJt7ktpCKnaE6KQFUXqPPyGJvQtj6f2HGxpQFBmA+iC+UgPpbUekcR+pd0+D2xh9b8hb8krbief/vMHXNKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8o4P8Dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86717C4CEC2;
	Sat,  5 Oct 2024 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150776;
	bh=pIwQAN4FdavGSGPv5+wTCfD5UEyGQIkHBKYeey2+oVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e8o4P8DtgeiYx1z7cuYTsapKlbpPqvkp5VTgwmDYGIW025oFHVpdwa/xM1oXFDAqN
	 LipHzqtEC//2b2n6Kc4NrYR1zkDa5qIjxVhxU2D0j+gtTQID08mEJDBmcQjFrK5bQX
	 +AlSvH73VqFNCSs0JmGdDL9ci1eYDAVPAlxfMcR6R0VyDCMjfB7xneYydlS5iZ2KB4
	 G5DO4UsMN2zZ9bx5nk505MnEw21CiK3M63I5K7bKCaUzT5Nwk7/SQNTZafDZBu/mbT
	 AFaKmAtY8KArY50slfl9hLd6a17nxxJfrxv6z9nzrujay7FKQrgUTMwxohWubKjkHx
	 uZ2PMyoe/01XQ==
Date: Sat, 5 Oct 2024 18:52:23 +0100
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
Subject: Re: [PATCH 07/13] iio: dac: ad3552r: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005185223.7c5e3d33@jic23-huawei>
In-Reply-To: <20241003-iio-select-v1-7-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-7-67c0385197cd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 23:04:53 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

J
> ---
>  drivers/iio/dac/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 1cfd7e2a622f..9d4600ce0427 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -9,6 +9,8 @@ menu "Digital to analog converters"
>  config AD3552R
>  	tristate "Analog Devices AD3552R DAC driver"
>  	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD3552R
>  	  Digital to Analog Converter.
> 


