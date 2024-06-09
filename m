Return-Path: <linux-iio+bounces-6093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE4F901556
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F73BB215A6
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 09:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0301CD3F;
	Sun,  9 Jun 2024 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZTgY9v7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7F1CD11;
	Sun,  9 Jun 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717925842; cv=none; b=BsVkKqW+cUTwfoXQ2zR1R2AiTgTxA7o2XoYnZir1lxm3hEFR4WMhKO6Cd6HGHmrrrgShrrFJ4jQOFD3u7x64D3Ci2ufNBhDdG4oUhYUaQLMcsYKpqCYi+BBan/+5f0y9FuSnN/d4bO5BAhVHe2GcLv68mYOPQhoZK1nIJuty9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717925842; c=relaxed/simple;
	bh=XN5bruVCFWDk6NK36GBzKNiw4s708+m+M96Lip7+3vE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfXKX2cp1PZzxrfX67rqdogwmUJ6lkWMz+UmggvQkQS2n3bJjlbwldVBJP1tHDCzBcAaSsKu8jzkGsMbBJur/+Vs8IpRgy8l3c7JmTW6GwxXMK0WpUkhF7pzMfq7QoDgTjkWICKft1PJRj1APJrwXRIbb16CGtcU3k15m34s/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZTgY9v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7DAC2BD10;
	Sun,  9 Jun 2024 09:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717925841;
	bh=XN5bruVCFWDk6NK36GBzKNiw4s708+m+M96Lip7+3vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZTgY9v7/JASD7XqrrqsDrzIXIkS3nOJ3RCPLsmnNhJYgCSw2IMxtuqJkdzd1OLPS
	 2dfBhMJvdPVzzUVhcJgB43rCO0zPdkFUDejU1mLPw6N4QOq18ey2YPD+ItAqmtaToL
	 PK5IuW8DyAswoW9iXU77X5lo5NNzazz2blMDxOIuxtWb4UPrmsWRKcJLDbdr4MthE2
	 AsuwsEp7Ft0Ch/7oFC9l8ZfACeaz7pdmQc78XeFopsQE68z2THw6nnqtGT7sf1z2Yr
	 kC2qkzUntlvOATRrs1v0OAVotnIsGE1zh+M6NcndGu9fU2MAOgeR7eBhrFRekUAPEw
	 B4AVpnm9XAsEg==
Date: Sun, 9 Jun 2024 10:36:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, christophe.jaillet@wanadoo.fr, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Add driver for ENS160 sensor
Message-ID: <20240609103655.29a1b53d@jic23-huawei>
In-Reply-To: <20240604225747.7212-1-gustavograzs@gmail.com>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 19:57:24 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> This series of patches adds a driver for ScioSense ENS160 multi-gas
> sensor, designed for indoor air quality monitoring.
Series applied with minor tweaks as called out for individual patches.

Applied to the togreg branch of iio.git and pushed out initially as
testing for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

> 
> ---
> Changes in v3:
> - Add missing `$ref: /schemas/spi/spi-peripheral-props.yaml#` in
>   devicetree binding
> - Move the devm_add_action_or_reset() call to right after setting the
>   operation mode to standard
> - Remove "_spi" and "_i2c" suffixes from device name
> - Add a comment explaining what data the mutex is protecting
> - Format register address macro
> 
> Link to v2: https://lore.kernel.org/linux-iio/20240529001504.33648-1-gustavograzs@gmail.com/
> 
> ---
> Gustavo Silva (6):
>   dt-bindings: vendor-prefixes: add ScioSense
>   dt-bindings: iio: chemical: add ENS160 sensor
>   iio: chemical: add driver for ENS160 sensor
>   iio: chemical: ens160: add triggered buffer support
>   iio: chemical: ens160: add power management support
>   MAINTAINERS: Add ScioSense ENS160
> 
>  .../iio/chemical/sciosense,ens160.yaml        |  70 ++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   8 +
>  drivers/iio/chemical/Kconfig                  |  22 ++
>  drivers/iio/chemical/Makefile                 |   3 +
>  drivers/iio/chemical/ens160.h                 |  10 +
>  drivers/iio/chemical/ens160_core.c            | 367 ++++++++++++++++++
>  drivers/iio/chemical/ens160_i2c.c             |  62 +++
>  drivers/iio/chemical/ens160_spi.c             |  61 +++
>  9 files changed, 605 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
>  create mode 100644 drivers/iio/chemical/ens160.h
>  create mode 100644 drivers/iio/chemical/ens160_core.c
>  create mode 100644 drivers/iio/chemical/ens160_i2c.c
>  create mode 100644 drivers/iio/chemical/ens160_spi.c
> 
> 
> base-commit: 084eeee1d8da6b4712719264b01cb27b41307f54


