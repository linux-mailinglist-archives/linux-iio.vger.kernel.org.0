Return-Path: <linux-iio+bounces-6841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0E915749
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 21:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7211F21DE7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9331A01CA;
	Mon, 24 Jun 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0GDQZHi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E714F1A00D6;
	Mon, 24 Jun 2024 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257964; cv=none; b=b5bNj6I9kWKRtXEp689x7HktxohJXEDoSs1AdJFa/iGDDszex2QqZU60E+EZ4lH2bWHFr3RmW79fYS6yhm/piqG2qPP3vh/lHKSpXw4pAaZq5jFkLTEKR2jzgN2UU+p0FwI1ToCNpNCaMnrzWMPnFrWthkqjJnOpzPHY608sqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257964; c=relaxed/simple;
	bh=lX9RcMi8n6pONUGOHPEejszWQdpVZ8J4CmfNy0OyFA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4BC3xAYdHWjn4JPzQE5WAJTxYyck84VKKcHdPN7EJpXymDdHKp5ZGe2FelwELQQ9C4X2EVyVvfZ97Q/nvhBJiW1fj3qZTX8AOjXL6jhLY9vM/xI2bfsam5CIbG3pqjLuHFQRlCsZpFimZdD23Din/fHoJoIdQeyy80yOJ6oeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0GDQZHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756C9C2BBFC;
	Mon, 24 Jun 2024 19:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719257963;
	bh=lX9RcMi8n6pONUGOHPEejszWQdpVZ8J4CmfNy0OyFA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0GDQZHi8SDsimNDysl2wSOnmT7ZtQRLEBvHPHttkpjeBlCk+7l12N3rks6FuZShl
	 k+IBdr8YWvjS0m9BK5A2jBAsWEK0fJ9tPBohxforHWs490RpPqGR/KE4OqivTfbb2x
	 Ydp0JtQaDSr8uSElm495X5SaQh8zcxfVREBhY2cFxmElYsWe4lKXiaLuKfWxklexSG
	 YeyxmtVEvLzl/HWAZLMfEwD68UiblXf3xPHylF5miRVU14KFKnym2NB7hM4Y6ki+50
	 19qgRYusufSn0ir5pffezTtM8EzhdX26RMlUCfkeikSN5FvKpS9/SWzX+s0XYok5ig
	 PVt/sNS6+iMFg==
Date: Mon, 24 Jun 2024 20:39:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] spi: add devm_spi_optimize_message() helper
Message-ID: <20240624203918.3ee643db@jic23-huawei>
In-Reply-To: <95eeae71-5270-4df2-acf4-a5308c2a8690@sirena.org.uk>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
	<95eeae71-5270-4df2-acf4-a5308c2a8690@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 18:20:39 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jun 21, 2024 at 03:51:29PM -0500, David Lechner wrote:
> > In the IIO subsystem, we are finding that it is common to call
> > spi_optimize_message() during driver probe since the SPI message
> > doesn't change for the lifetime of the driver. This patch adds a
> > devm_spi_optimize_message() helper to simplify this common pattern.  
> 
> The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:
> 
>   Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-devm-optimize

Thanks.  Applied patch 3 on a merge of that tag into the togreg branch
of iio.git which I've pushed out as testing to see if anything went
horribly wrong ;)

Jonathan

> 
> for you to fetch changes up to d4a0055fdc22381fa256e345095e88d134e354c5:
> 
>   spi: add devm_spi_optimize_message() helper (2024-06-22 12:14:33 +0100)
> 
> ----------------------------------------------------------------
> spi: add devm_spi_optimize_message() helper
> 
> Helper from David Lechner <dlechner@baylibre.com>:
> 
>     In the IIO subsystem, we are finding that it is common to call
>     spi_optimize_message() during driver probe since the SPI message
>     doesn't change for the lifetime of the driver. This patch adds a
>     devm_spi_optimize_message() helper to simplify this common pattern.
> 
> ----------------------------------------------------------------
> David Lechner (2):
>       Documentation: devres: add missing SPI helpers
>       spi: add devm_spi_optimize_message() helper
> 
>  Documentation/driver-api/driver-model/devres.rst |  3 +++
>  drivers/spi/spi.c                                | 27 ++++++++++++++++++++++++
>  include/linux/spi/spi.h                          |  2 ++
>  3 files changed, 32 insertions(+)


