Return-Path: <linux-iio+bounces-6842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A8915758
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 21:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA191F22B89
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1091A01D2;
	Mon, 24 Jun 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZbrW5Dh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CE13D88B;
	Mon, 24 Jun 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258221; cv=none; b=H+c5kC1Db9PY+m2AVpBLXNtfiC7wawbVuGkjhT/ffv5+C/HiVwaI8BITV2UHZ1OpbBgGvIB8MgVaHO/CCaMXsRUa8ScooUaNgaUMSHWrbFxGlSW3dNF9ZrBkeVXn2PFDf82ncg9kIhp8by9h1vZCQFyaEy+Og0FJ3ZrCFTzvx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258221; c=relaxed/simple;
	bh=+EHhhDcnFJtZoCQqLnx5macIiZs9BLwsSEtQMcdIFls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXGOq69L48MyGQw1lMw5+GEYitom4GYus1mOGwKMC2wJ8ddp0AVeT3gIIGvLERMQxa6LoSvSdbbu+Oa7D3aGFuQy4wGix4bqNdvNbt/Tv9LPFbXLBRYcUOUUznysUVErnvQ970Zd35vJuOYckpd8icHA0T2eM/XtO72qTwEV2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZbrW5Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F076DC2BBFC;
	Mon, 24 Jun 2024 19:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719258221;
	bh=+EHhhDcnFJtZoCQqLnx5macIiZs9BLwsSEtQMcdIFls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FZbrW5Dhvom+TQpnaUw9K3crWuCAcH9WcjBPM3LdOJ8ASadwxWWOSqRpIkiOBWuV3
	 GAJsfg6Rk1GlRyKPGhxcz0Ow9G6oatM4a0lez/DLUK8GvU7pdkBsUj1Vs+asihQvgJ
	 F3TF+HhZaeInOQ+S1qXjdV+cUPiG0pBBaEeZQb4eQUoNSFOTd/hz9nJy8Yz5t3uCRN
	 hsF4FETK1YuqL5HfZH+sQ3ETQlj9JCC9E13W0dTAVV/4mqcS6bfgDU990f3udf8iXc
	 Ew8F7WNiNz3xx0SPNexvT0zBT4HE1IA6l4pfy1tPdY8HKfjodfhOYuxAh7m/rgWEws
	 fUKcvjVHCWaEA==
Date: Mon, 24 Jun 2024 20:43:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] spi: add devm_spi_optimize_message() helper
Message-ID: <20240624204332.7cb1243a@jic23-huawei>
In-Reply-To: <20240624203918.3ee643db@jic23-huawei>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
	<95eeae71-5270-4df2-acf4-a5308c2a8690@sirena.org.uk>
	<20240624203918.3ee643db@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 20:39:18 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 23 Jun 2024 18:20:39 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Fri, Jun 21, 2024 at 03:51:29PM -0500, David Lechner wrote:  
> > > In the IIO subsystem, we are finding that it is common to call
> > > spi_optimize_message() during driver probe since the SPI message
> > > doesn't change for the lifetime of the driver. This patch adds a
> > > devm_spi_optimize_message() helper to simplify this common pattern.    
> > 
> > The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:
> > 
> >   Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-devm-optimize  
> 
> Thanks.  Applied patch 3 on a merge of that tag into the togreg branch
> of iio.git which I've pushed out as testing to see if anything went
> horribly wrong ;)
> 
Hit send too soon.  The new devm_spi_optmize_message() is missing an
EXPORT_SYMBOL_*  so my local build test with modules failed.

Jonathan

> Jonathan
> 
> > 
> > for you to fetch changes up to d4a0055fdc22381fa256e345095e88d134e354c5:
> > 
> >   spi: add devm_spi_optimize_message() helper (2024-06-22 12:14:33 +0100)
> > 
> > ----------------------------------------------------------------
> > spi: add devm_spi_optimize_message() helper
> > 
> > Helper from David Lechner <dlechner@baylibre.com>:
> > 
> >     In the IIO subsystem, we are finding that it is common to call
> >     spi_optimize_message() during driver probe since the SPI message
> >     doesn't change for the lifetime of the driver. This patch adds a
> >     devm_spi_optimize_message() helper to simplify this common pattern.
> > 
> > ----------------------------------------------------------------
> > David Lechner (2):
> >       Documentation: devres: add missing SPI helpers
> >       spi: add devm_spi_optimize_message() helper
> > 
> >  Documentation/driver-api/driver-model/devres.rst |  3 +++
> >  drivers/spi/spi.c                                | 27 ++++++++++++++++++++++++
> >  include/linux/spi/spi.h                          |  2 ++
> >  3 files changed, 32 insertions(+)  
> 


