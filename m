Return-Path: <linux-iio+bounces-10207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F5991924
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC11F22379
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA215957E;
	Sat,  5 Oct 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki5UGWGz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B78231C92;
	Sat,  5 Oct 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151347; cv=none; b=TaFixeGEfiYA+04WJg4VUGsI/xymS8/HAi5xcXmUwYaJdh2mnIy5QNzUTzhf38jh3z+8vBh4KkbinqC/tetOOu8vGrZMHDptf0mm8cw1DrVyxQkb5K9+6BNZjbtZzRA6LNyLAtBEml9NqRn1GL0Px28FGibIiuzs87MZNAE6yCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151347; c=relaxed/simple;
	bh=gVazKmTuWtYDPNUar85iX+Mbmm49PN6HqWGbf/hbLvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryBgHQEQbOt1Lw3+J22iiinpuydtUtUvvyGD1ibmTsFsMSFRocA7MxZRWBRutyxENs9C9g8fcyjqF+G0E3veOP3XaA7U/l0CR5dMvU7fw74Nu6qTKpFwqP1HTx5ZcILUm5yDvAa3p/I+uaIuFHiUNi4KW3uWsekqLCCyFnyQOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki5UGWGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A21BC4CECD;
	Sat,  5 Oct 2024 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151347;
	bh=gVazKmTuWtYDPNUar85iX+Mbmm49PN6HqWGbf/hbLvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ki5UGWGzK2vwqG6wwo4rqM0gc09tzrifJB68WTTbjVLRgkbnqgEWcwlS25GLzDLzO
	 qFwcv0WU9J7Sy5c3Ybi/aBGWW0pBvIkjXk//VX0OV6V2AmLiI+RIK4gyGk3SNJNxCq
	 b+wYXuxMS+N+uPemHE6tkfGE9V/tRJ3/cXpy/gCMn7ZDZWMy/1Gkf4kO6S52SL9VYP
	 p5WKlepVZ+ECMQhbb7UKy7HBEXHBMiHIWtoANxm5+ZGfQgRigm7aYGpM2eVKzv1Z4b
	 tH3v+2RXmfPOuefJjkbwUxqXgZZO3I8weWG3+FWgawIpdaVtp47Rh4+20VokchY0XO
	 ws2r/z6+cuN/w==
Date: Sat, 5 Oct 2024 19:01:47 +0100
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
Subject: Re: [PATCH 12/13] iio: pressure: bu1390: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005190147.084dd468@jic23-huawei>
In-Reply-To: <20241003-iio-select-v1-12-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-12-67c0385197cd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 23:04:58 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
Seems unlikely in the bm1390 driver. Huh. It is accurate, but I'll fix the
patch description to refer to the bm1390 which seems to be the right
name and add a note on this as it looks suspect otherwise.

> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/pressure/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index df65438c771e..d2cb8c871f6a 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -19,6 +19,9 @@ config ABP060MG
>  config ROHM_BM1390
>  	tristate "ROHM BM1390GLV-Z pressure sensor driver"
>  	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z
>  	  can measure pressures ranging from 300 hPa to 1300 hPa with
> 


