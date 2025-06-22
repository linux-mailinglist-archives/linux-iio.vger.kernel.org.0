Return-Path: <linux-iio+bounces-20872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227DDAE3080
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C488170A64
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A458D1EB1BF;
	Sun, 22 Jun 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMlRjclu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2ED19309C;
	Sun, 22 Jun 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750604806; cv=none; b=e8lSb9kB5m1Ao72j1QUM0YhJ3sjJ0bi/Y06c4OIwQBjz2BhtZ1lF6EAcxNfMTP7jaENQVobJEMr1OdGr0CguXGgkpIeb0Q+XwNVqenvG0xRNrXCnvo8ARawIIjuAtqWy9QFgXkGXGlYiZpTIcV2DRK/oSRBAMXfI1tOnj6vCELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750604806; c=relaxed/simple;
	bh=9+6JKZfyC6Yzr/FRT7XWKr7oqOELxsxrpM58kXhzA4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHnJsgAww9aReupsGogYOuBixmPYYG3RC1fvzj4EYXQQxcZzIFftOI5Ej0j4s16bjLVqOW3K0+E0N0y/lOfqSC6UyvaWsusAuUucwxGN5aYKfT8HjHuonCX5/v/Q7Dz2sDB9MC1wevlXyydS3EGasW1faQ4ch72wlyzArlmbhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMlRjclu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D9C4CEE3;
	Sun, 22 Jun 2025 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750604805;
	bh=9+6JKZfyC6Yzr/FRT7XWKr7oqOELxsxrpM58kXhzA4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PMlRjcluOG97dRtRIHYV/wHPC8j4kJYjmlNHl/md2GnlbEFEyr1wvl90XULUqzeiO
	 eNZCcYYfG2XpOKSAiFBkg1XDoIjSoVFoQ5fGUTm8u31L4bxt1/zNQR2SHPlqCIU2tv
	 jVIA3RXcefy6ZIik1QULUxJo8GDy+snIamOsR1QBPdx3mpRtYF//0TBfT363hU1oHk
	 +CuKPxaEPfeYqXrTmp5lWU9F290V0V7ALfvjLvVRS/7fQvxwuDDUXK8R35RxaGFzxD
	 lrWmbAtqT/HgLRSlfcEsxsm7wNrefusfkXUGiZSerBlGp3EL3L+4rpv6toj7BgM8Ok
	 hjYvLJBKPKUyw==
Date: Sun, 22 Jun 2025 16:06:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <liquancin.mereenamathai@in.bosch.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <vassilisamir@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <javier.carrasco.cruz@gmail.com>, <Xu.Zhang@cn.bosch.com>,
 <Maoting.Bian@cn.bosch.com>
Subject: Re: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and
 support
Message-ID: <20250622160637.554b1953@jic23-huawei>
In-Reply-To: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 10:24:53 +0530
<liquancin.mereenamathai@in.bosch.com> wrote:

> From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> 
> This patch series adds support for the Bosch BMP390 pressure sensor to the
> Linux IIO subsystem. It includes the main driver implementation as well as
> the necessary device tree bindings for integration on supported platforms.

Hi Liquancin, 

Great to see this driver.  However, it is huge which will make it very challenging
to review.  I'll take a first look but in general you need to break this up
into more manageable steps of building up driver complexity.  The driver
must work and be useful at each step, but the usual approach is to introduce
first a fairly minimal driver that does basic measurements only and then build
up from there.  If any patch is getting substantially over 1000 lines of code
then it becomes unmanageable without reviewers dedicating a significant chunk
of their day to that review and hence them finding that time can take a while
if it happens at all.

Only exception to this is that the dt binding should be as complete
as possible from the start.

Jonathan

> 
> Patch 1 adds the IIO driver for the BMP390 pressure sensor.
> Patch 2 introduces the device tree bindings documentation.
> 
> Liquancin Mereena Mathai (2):
>   Add the iio driver for bosch pressure sensor bmp390. The bmp390 is a
>     pressure sensor module. It will support SPI and I2C protocol based
>     on configuration.
>   dt-bindings: iio driver: Add BMP390 pressure sensor device tree
>     binding
> 
>  .../bindings/iio/pressure/bosch,bmp390.yaml   |   65 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/pressure/Kconfig                  |   26 +
>  drivers/iio/pressure/Makefile                 |    1 +
>  drivers/iio/pressure/bmp390/Kconfig           |   29 +
>  drivers/iio/pressure/bmp390/Makefile          |   32 +
>  drivers/iio/pressure/bmp390/bmp3.c            | 2781 +++++++++++++++++
>  drivers/iio/pressure/bmp390/bmp3.h            |  537 ++++
>  drivers/iio/pressure/bmp390/bmp390_driver.c   | 1604 ++++++++++
>  drivers/iio/pressure/bmp390/bmp390_driver.h   |  232 ++
>  drivers/iio/pressure/bmp390/bmp390_i2c.c      |  328 ++
>  .../iio/pressure/bmp390/bmp390_iio_buffer.c   |  220 ++
>  drivers/iio/pressure/bmp390/bmp390_spi.c      |  286 ++
>  drivers/iio/pressure/bmp390/bmp3_defs.h       |  871 ++++++
>  drivers/iio/pressure/bmp390/bmp3_selftest.c   |  184 ++
>  drivers/iio/pressure/bmp390/bmp3_selftest.h   |   93 +
>  16 files changed, 7296 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml
>  create mode 100644 drivers/iio/pressure/bmp390/Kconfig
>  create mode 100644 drivers/iio/pressure/bmp390/Makefile
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3.h
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.h
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_i2c.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_spi.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3_defs.h
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.h
> 


