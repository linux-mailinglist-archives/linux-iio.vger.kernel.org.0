Return-Path: <linux-iio+bounces-24976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A4BD065B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDD118935AA
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9441F5842;
	Sun, 12 Oct 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckUrBuOP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA831F4621;
	Sun, 12 Oct 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284006; cv=none; b=BfLbeMfzxM6Id27tUSO/94alS6vNs8QZdsBGHLNhYYPIzJg8gcJIpieOYp5ckCe/RSeUPxxcLxGNzWhMiRJoCDarfpUYCyAt4xruI6mOLjuMglZlmbQmhocWi/FCNQPqYn2gnwih0GpNsnAD+lMLrQ34xSsM9BnGpgHSvcZJs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284006; c=relaxed/simple;
	bh=IALbjy/pZA+eJCMxjut7dLRzd9yv5SaJ4twlV7U9dho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcXxSn5j8QZ7W/pTMDkGWxZ0FaFqQ+vTBoj0FgGXOnpS/k5LdB7Lh1/1nzoAEq3AZG7jmFHsNXu+miS6qlgmqrgXwYXwLzmmjVumQV4lMDRxYgYOt/ikFrjTpmSCbOMO4ZjoO7aM26QaPxiM07LK0hqr8DD89poIRm97fQc9yw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckUrBuOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51B2C4CEE7;
	Sun, 12 Oct 2025 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760284006;
	bh=IALbjy/pZA+eJCMxjut7dLRzd9yv5SaJ4twlV7U9dho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ckUrBuOP1iv8HEayAy0Q0SKGSBC5k2Vs9k9+iO91PkqxDLGwcqE3T5nK+u3MgdThC
	 8AfaYirKVqFUlxZhR6Q0DYpGOeBzJ/9m3izAtImOLpOaMicE60Mic/gbFJ12SHuCjG
	 D0aBQS6WdJ6FBIsuImnWx3YJJFkm53RUQzAwli4hnp5oMK8Fe25kWgTeY4MNqrbapR
	 K6moOupc1uTB1f2K9tLXh9zY6A0Gm4SMORf172HBvLYAp7m/Uc7HZLMcnPF6gZnWSU
	 2fkrRVlJKWxo20bbiVwF0zZgSXEdd7moBGW9cj7t19tTEl3n3t/Ldphe8rnypkY2EN
	 +Hyxr0JP/pwTA==
Date: Sun, 12 Oct 2025 16:46:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: buffer: Fix DMABUF mapping in some systems
Message-ID: <20251012164640.40d29b87@jic23-huawei>
In-Reply-To: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
References: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Oct 2025 10:15:20 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> This series fixes an issue with DMABUF support in the IIO subsystem where
> the wrong DMA device could be used for buffer mapping operations. This
> becomes critical on systems like Xilinx/AMD ZynqMP Ultrascale where memory
> can be mapped above the 32-bit address range.
>=20
> Problem:
> --------
> The current IIO DMABUF implementation assumes it can use the parent device
> of the IIO device for DMA operations. However, this device may not have
> the appropriate DMA mask configuration for accessing high memory addresse=
s.
> On systems where memory is mapped above 32-bits, this leads to the use of
> bounce buffers through swiotlb, significantly impacting performance.
>=20
> Solution:
> ---------
> This series introduces a new .get_dma_dev() callback in the buffer access
> functions that allows buffer implementations to specify the correct DMA
> device that should be used for DMABUF operations. The DMA buffer
> infrastructure implements this callback to return the device that actually
> owns the DMA channel, ensuring proper memory mapping without bounce buffe=
rs.
>=20
> Changes:
> --------
> 1. Add .get_dma_dev() callback to iio_buffer_access_funcs and update core
>    DMABUF code to use it when available
> 2. Implement the callback in the DMA buffer infrastructure
> 3. Wire up the callback in the dmaengine buffer implementation
>=20
> This ensures that DMABUF operations use the device with the correct DMA
> configuration, eliminating unnecessary bounce buffer usage and improving
> performance on high-memory systems.
>=20
> (AI generated cover. I would not be this formal but I guess is not
> that bad :))
>=20
> ---
> Changes in v3:
> - Patch 1
>   * Add a new iio_buffer_get_dma_dev() helper to get the DMA dev.
> - Link to v2: https://lore.kernel.org/r/20251006-fix-iio-dmabuf-get-dma-d=
evice-v2-0-d960bc9084da@analog.com

Looks like I misinterpreted outcome of v2 thread.  Anyhow dropped that and =
picked
this up.

Thanks

J
>=20
> ---
> Nuno S=C3=A1 (3):
>       iio: buffer: support getting dma channel from the buffer
>       iio: buffer-dma: support getting the DMA channel
>       iio: buffer-dmaengine: enable .get_dma_dev()
>=20
>  drivers/iio/buffer/industrialio-buffer-dma.c       |  6 ++++++
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 ++
>  drivers/iio/industrialio-buffer.c                  | 21 ++++++++++++++++=
-----
>  include/linux/iio/buffer-dma.h                     |  1 +
>  include/linux/iio/buffer_impl.h                    |  2 ++
>  5 files changed, 27 insertions(+), 5 deletions(-)
> ---
> base-commit: b9700f87939f0f477e5c00db817f54ab8a97702b
> change-id: 20250930-fix-iio-dmabuf-get-dma-device-339ac70543db
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20
>=20


