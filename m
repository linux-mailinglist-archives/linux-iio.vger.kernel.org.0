Return-Path: <linux-iio+bounces-7077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F03891D114
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F30281D68
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A4132113;
	Sun, 30 Jun 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD97672E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0319E39AF4;
	Sun, 30 Jun 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719743033; cv=none; b=WLvEYwUtsqRbcyyjhimob0Zy+B98XH1y85l/iLvwYrpTb9buAMil/XEvdX/2+bK1hepGDQ5qk0jjQV28v7f66hpXe4hzcUUQ/Y0I5zzafKee2LsQzAFncIQm3ZEhwxNrnj09MYU7JzNK90anC9TQSYry26eu9sKAH4X3Pub5oU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719743033; c=relaxed/simple;
	bh=y0ejgBJ3UauYVz+T8z0rRMKFb8zGfTiA1i0ks44YuiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJfZUEoDW26bjOjuCMHaSF0picM9IP2C8RhhG+oDOqhBxONlYIckQP7Ajrdv788x7sMvgyn0IX6wR09rQ9nL3t6D9KjfbqP9F5hycdZuQM3VUkPNSlIXcTfLf7017kR4rASAOyJaRTNEVJQ82cwzHDyTlDc5ttuZS6HiqeOC6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD97672E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66EAC2BD10;
	Sun, 30 Jun 2024 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719743032;
	bh=y0ejgBJ3UauYVz+T8z0rRMKFb8zGfTiA1i0ks44YuiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gD97672EZWlc83vEUhas5eexxBYFsAfDTg3KBSG5TtW2D59ov5GBJtMtmz3wZs32l
	 8EyfXEGIx+dEvJUYWpMn2GAsljVoRTVU3lUuIZss0qMBOHBg2XostBIyra5eMHWzzP
	 yJtFG5D1AaCDhXUtcTk3ejOa6g/ORa7KdWNKHUkUqk6D9OZKLJn5DviAWnH5XWV4cI
	 9QLXWsOTONQ+kJtbXXM2ghJcoMlibzcKuF+m2yBARx4xQvW1uC/KozuBtBSDUZwOuh
	 yvMXKy27a8Hbac2JOPHPGFl7nfVgZ2or4lLQkrZI3HnL8QqmBlAXNf7ycqZMqKbg/4
	 TxjsYoBjjDmlw==
Date: Sun, 30 Jun 2024 11:23:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, petre.rodan@subdimension.ro, mazziesaccount@gmail.com,
 ak@it-klinger.de, ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 tgamblin@baylibre.com, ajarizzo@gmail.com, phil@raspberrypi.com,
 579lpy@gmail.com, andriy.shevchenko@linux.intel.com,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/3] iio: pressure: bmp280: Minor cleanup and
 triggered
Message-ID: <20240630112342.4ab1f021@jic23-huawei>
In-Reply-To: <20240628171726.124852-1-vassilisamir@gmail.com>
References: <20240628171726.124852-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 19:17:23 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Changes in v9:
> 
> Patch 1/3:
> 	- In bmp580_temp_coeffs, instead of *1000/2^16, now we have *125/2^13
> 	  to avoid overflows, as it was proposed.
> 	- Type casting to (s64) to temperature read in the read_raw_impl
> 	  function was removed as well as it is no longer needed.
> 
> Patch 3/3:
> 	- Renamed "buffer_handler" to "trigger_handler" to keep consistency
> 	  with the rest of the drivers.
> 	- Added new iio_channel_spec for bmp580 in order to use IIO_LE and
> 	  real_bits = 24.
> 
> v8: https://lore.kernel.org/linux-iio/20240617230540.32325-1-vassilisamir@gmail.com/

This seems fine to me now, but I'd like a final 'we didn't break anything' from
Adam before i pick it up.  Once bitten, twice shy and all that ;)

J


> 
> Vasileios Amoiridis (3):
>   iio: pressure: bmp280: Generalize read_*() functions
>   iio: pressure: bmp280: Add SCALE, RAW values in channels and
>     refactorize them
>   iio: pressure: bmp280: Add triggered buffer support
> 
>  drivers/iio/pressure/Kconfig       |   2 +
>  drivers/iio/pressure/bmp280-core.c | 643 +++++++++++++++++++++++++----
>  drivers/iio/pressure/bmp280-spi.c  |   8 +-
>  drivers/iio/pressure/bmp280.h      |  34 +-
>  4 files changed, 589 insertions(+), 98 deletions(-)
> 
> 
> base-commit: 3341d69268accb5294b569ec37e55212a8a28ac5


