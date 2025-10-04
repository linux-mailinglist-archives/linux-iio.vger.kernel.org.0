Return-Path: <linux-iio+bounces-24707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B83BB8DE5
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 256724E5F89
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFADA27381F;
	Sat,  4 Oct 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLsZD0k0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FDCA4E
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759584105; cv=none; b=rJ+GW4Rvs52AtSQgiSURZEgyc4Yn4fW8YwPiJQUCT8UfK+Yo3cDelRmp99Y5eoqHDoxdJ35X7F5DNDQAMz1JR2a589yn8fGyqILh5hk7ild/9WwNyHIjG8CFnW8z+YvXM3qPX4MFSECLVrxbQrETpRfxR9BsgjP5r+hK3/U55NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759584105; c=relaxed/simple;
	bh=bSoTV5zZe0G7k7LL5Mdl7OAIOgw/nT/zydKYKt//xiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsVePFdbRboiDJQ27li5AfbZ+NMym0Mt8/QGErUeOVfkcGdK7LTohRLk/2xdKs+nHdVDWO8vpwa4bu05/GKbAMZ0Znu2PY2iAZMTbTnNCqElaZoPGCvqXdbWoQ2XnQd9p0S7YkQmxLdY1Bqg/7hFfIpXsl/wfIOZBZzjIJkl1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLsZD0k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BF0C4CEF1;
	Sat,  4 Oct 2025 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759584105;
	bh=bSoTV5zZe0G7k7LL5Mdl7OAIOgw/nT/zydKYKt//xiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QLsZD0k0sldVR2fqLg74Wa8VUauBPU+X+HQr3SjX9F4PYIRQXviultYeDuVTvWpjs
	 VKW5Jkj/lyi0/sytiOaW5FhDW93MNCwjyQasqOFuM29U+e5h+Tzuih9BfsTno6AB7C
	 DBYjPDk5UqWV3fQDKaFTsodGS7CSEIrIl/zJLPSjiU/dOudaYWChpDqUGIxWm4E2Al
	 cUggB5ZqxVPHtHv4xs3hkYMGrdHH6sgUE+/1/yw4bUJC1HMNzKPjNjXO831VnmSEMI
	 slkseLfFPDgW7LD3eZaBcniDEYK0jFfZVb/Ur3txB3UNwKN+tm+9CGtTKpdoCCViOX
	 GbujXEX6+CgDQ==
Date: Sat, 4 Oct 2025 14:21:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 0/3] iio: buffer: Fix DMABUF mapping in some systems
Message-ID: <20251004142137.5a4b8240@jic23-huawei>
In-Reply-To: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
References: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 02 Oct 2025 16:06:27 +0100
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

Not too bad indeed.

Series looks fine to me in general. Just those suggestions from David
to enact in v2.

Thanks,

Jonathan

>=20
> ---
> Nuno S=C3=A1 (3):
>       iio: buffer: support getting dma channel from the buffer
>       iio: buffer-dma: support getting the DMA channel
>       iio: buffer-dmaengine: enable .get_dma_dev()
>=20
>  drivers/iio/buffer/industrialio-buffer-dma.c       |  6 +++++
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 ++
>  drivers/iio/industrialio-buffer.c                  | 28 ++++++++++++++++=
+-----
>  include/linux/iio/buffer-dma.h                     |  1 +
>  include/linux/iio/buffer_impl.h                    |  2 ++
>  5 files changed, 33 insertions(+), 6 deletions(-)
> ---
> base-commit: b9700f87939f0f477e5c00db817f54ab8a97702b
> change-id: 20250930-fix-iio-dmabuf-get-dma-device-339ac70543db
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


