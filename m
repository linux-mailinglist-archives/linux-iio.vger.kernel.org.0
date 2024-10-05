Return-Path: <linux-iio+bounces-10208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA8799192F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAECB211D9
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB5156C62;
	Sat,  5 Oct 2024 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRB4z9Kw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60944A31;
	Sat,  5 Oct 2024 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151452; cv=none; b=k3SaBDFMpEKZt6AKUJUiY3hiYyb2w+OHXx5Bf0pX7XcAtIUBOQVE0qDkCTmqJnhiQXM6ydV0G1yAHvG7ws+nza55t90Pg0u2CsjM4x2nLpKKsTK84UFT+nafNQVKHCeMPFwVvZCarvptHCcuU/cxSYUbVqy3zWgnQlbRbHPb8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151452; c=relaxed/simple;
	bh=yMBbvkOj/igKnf2TGeIut9usz81piSbaIP7f4W/+mT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLwWxVHqcXkuYStmjbIHzZC+jg3q8YUKR5J7LxSmsRxKQARXaDQ+ihesuzIWbFvp0g/FAkEIWw2x62XO17BLzPkSSR3AWYKJTPZEJ0037jlvFVKNRRilTVndd7ty7bPTSOu4YU5SEzNLHPNCmSKCbWBDy8C8UDWtRIcahyK8PPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRB4z9Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA7C4CEC2;
	Sat,  5 Oct 2024 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151452;
	bh=yMBbvkOj/igKnf2TGeIut9usz81piSbaIP7f4W/+mT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qRB4z9KwAljsWM7Fq/A9zqUKuJxsZjiQViO04edpAj+OJ4dIGguvF+6OoY6lVdsMe
	 oNLisUxtB6IrjA+yo7MoMBiEsbrk1NuhhY0qabn4akfhCWggKpMoDUUGz0wSg9Drja
	 XJDt16ffy1+9dAAUhYGfslgJ+yXH9XKMf3rdHsBvuCeeWH/FQAP03PvNiFHFKKYV4n
	 ZhZpfNwl5OPuFa7jnhIO4tAbiU1/LR4a5sUkLHlkuPUlIXKSllGjI4kxMPeHdSGHK0
	 y0u0nHbEHwbvyerXG6QOxPRd2CFv75jcPmtuP7cYjhuUzsIzTi4cvh1QGCm0fwOIIl
	 G54rDW41gHMtw==
Date: Sat, 5 Oct 2024 19:03:41 +0100
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
Subject: Re: [PATCH 13/13] iio: proximity: mb1232: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005190341.389e466b@jic23-huawei>
In-Reply-To: <20241003-iio-select-v1-13-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-13-67c0385197cd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 23:04:59 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 16b05261537e ("mb1232.c: add distance iio sensor with i2c")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.

Thanks for going through looking for these.  Hopefully this will reduce
chance of us getting a rand config hitting this in the future!

Jonathan

> ---
>  drivers/iio/proximity/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 31c679074b25..a562a78b7d0d 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -86,6 +86,8 @@ config LIDAR_LITE_V2
>  config MB1232
>  	tristate "MaxSonar I2CXL family ultrasonic sensors"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y to build a driver for the ultrasonic sensors I2CXL of
>  	  MaxBotix which have an i2c interface. It can be used to measure
> 


