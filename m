Return-Path: <linux-iio+bounces-8903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E39670F6
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C84F1F22A0D
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B104517B421;
	Sat, 31 Aug 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXkbYfGK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA414B949;
	Sat, 31 Aug 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725101628; cv=none; b=jHvCfvvfKWsMaRrwcrKdViAflyweBsIo5FRSkTJJNbsvBf42+vhvzQJwNLsVpSf1Hn0PR+qUgGWVll05AA6GeMXoGodfU3DIuOvdjs/bHplzovtCtvOjgof7QBOBcqd0ITxmxDTJf+2sA3pqzX8UvIlhuzWeKlLye6hke7IJmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725101628; c=relaxed/simple;
	bh=+Jvu/UdgzmcAXW+0d7ObytUme5eaUOhG6WbqyYns+TE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAo/WtV9iJ1QDTNUlWwoquS9t8jup5uKpyXjPO/d3E21sP5HBB2C5mTXQpnc0V86lET/mLdD5NvUCtyG9f3UjVtWcstX3P8NSO3022YLAOt+KTCqJDH0t6cmbzJlpR36Hqi3UnJLv95M4e97FL93kbdVPo3MVC4Hd3wG6AJ07nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXkbYfGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A14C4CEC0;
	Sat, 31 Aug 2024 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725101628;
	bh=+Jvu/UdgzmcAXW+0d7ObytUme5eaUOhG6WbqyYns+TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eXkbYfGKdbCxtfUesvuIJ1yNzzYSJZgjVrw6UTIpMdxcelfOwZGF1/9DZQ0EhXD3H
	 BPI7mByi+XW+aJNBrA+TBCwL9TDfdPsStNsYpp06iL2ffIg5rGNB/5wbkvcKDL6riZ
	 CpkN11bhBCmXNRsyDJE87GWfusNJ7oyVfKvVSaJNQnwFjeOwvY06125Ow69kqjh9+G
	 4Atb9tOVYO6gtHEL3IkKNlaPsZ2scl9b52GzWl3gIZiuy4s16f9WYQYLqDQof2lL+V
	 cN83XvxZJ2gpQ0vpGZ4jt6UMYfQG3vIV9oImuoOULQ5QjMC8IOa88d8AQORG4ynpTQ
	 MtVFaCjFgq01Q==
Date: Sat, 31 Aug 2024 11:53:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 0/2] iio: imu: st_lsm6dsx: Clean up ACPI/fwnode code
 paths
Message-ID: <20240831115343.775c6167@jic23-huawei>
In-Reply-To: <20240826212344.866928-1-andy.shevchenko@gmail.com>
References: <20240826212344.866928-1-andy.shevchenko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 00:22:38 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Here is a couple of cleanups that should not affect any functionality.
> 
> Andy Shevchenko (2):
>   iio: imu: st_lsm6dsx: Use iio_read_acpi_mount_matrix() helper
>   iio: imu: st_lsm6dsx: Remove useless dev_fwnode() calls
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 93 ++------------------
>  1 file changed, 7 insertions(+), 86 deletions(-)
> 

Applied the obvious fix for the bot error messages &drdy_pin
and applied to the togreg branch of iio.git (pushed out as testing)

Still time for other reviews however as I'll be rebasing that tree
anyway if Greg takes the pull request I sent last week.
There are some series waiting for fixes to loop back around, hence
this dance.

Jonathan

