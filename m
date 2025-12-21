Return-Path: <linux-iio+bounces-27266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC3CD3FBC
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 13:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101F1300A36A
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE22D8798;
	Sun, 21 Dec 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5rnltEV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB1274670
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318563; cv=none; b=KOTA9H5OxrXeonJvz7dFDEErImmMoJR2duKvCcdwCtNlaxNfLImgRCsh/+3yFxxiGlV8qHdlD+ivFeMNg78UGvf09HnZR5dEX0zkIblUnSwtEdXNXXGLtqxX0M9pscvmnfaCeZPcXNoeYQp0VTNBqPBM4m5kUvNyJEXi2ZW+Rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318563; c=relaxed/simple;
	bh=XhbmSh6rV5fqudd+NuBEkp6MU+n69tlOGucaLEiJC7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF+B3f3Sd+/hiiU8Idbb0cKEsGAff+O62OkrClZIOjcAsf5eiyLrE+8LJ7Uv+gbyTQ5a9IxKjiA2BYl+j4kj8Ih3+0jtaTIAIrHCb4GpzWmyMFNXA0FA0QsBYhFEXeaVo/tHctWzhS6Rtn9S3jYlpjzcGWmveIMGvsZbg+yB4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5rnltEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3D7C4CEFB;
	Sun, 21 Dec 2025 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766318563;
	bh=XhbmSh6rV5fqudd+NuBEkp6MU+n69tlOGucaLEiJC7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V5rnltEVRFRBWDaTkzNrSiEea7GYLgGEVIm4d1uX0XkFAp1eBEsUBOA5ljF5EFMip
	 XeVNmt5sGYFL9+4DjSUL59iT5SFgTHJoNFS++pXytkuD6K+GxssFaM0J1K2/I/NJ0V
	 ojqIr/ehOV1vPwQCF6HAbNraGjA/C2g4OIH0x1Vg3V54LWqz6FuWqQRjYLVNERCNVn
	 q9TDidk24x2/jhfCtooDZqYuVtpZiI22g1PNnOgJigj0aHhs5d679dX2QG8FQZPhR/
	 c7rcGbB2VaBLBVS1oDIqIM5xiYbWBHWmngmbblUdxiDEG06KId4widECEig4GAX/kY
	 uLQmflibiQkFw==
Date: Sun, 21 Dec 2025 12:02:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 0/6] iio: buffer-dma: Minor cleanups and improvements
Message-ID: <20251221120235.6457d80a@jic23-huawei>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 15:28:11 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Small series with some minor improvements for IIO DMA buffers:
>  * Use lockdep instead of WARN() + mutex API;
>  * Use cleanup.h;
>  * Turn iio_dma_buffer_init() void;
>  * And I could not resist in cleaning up coding style.
>=20
> Also note that in some of the coding style cleanups I deliberately went
> above the 80 col limit as I think it otherwise hurts readability. If not
> the case for everyone, I can change it.
>=20

Series applied with a few tweaks.

Jonathan

> ---
> Changes in v2:
> - Patch 1
>   * Updated the commit subject and message (given that lockdep also WARNs=
())=20
> - Patch 2
>   * Slight change on the 80 column limit when allocating the block
>     (Jonathan expressed preference on that form).
> - Patch 4
>   * Updated mutex/spinlock comments according Andy feedback.
> - Link to v1: https://lore.kernel.org/r/20251203-iio-dmabuf-improvs-v1-0-=
0e4907ce7322@analog.com
>=20
> ---
> Nuno S=C3=A1 (6):
>       iio: buffer-dma: Use lockdep for locking annotations
>       iio: buffer-dma: Use the cleanup.h API
>       iio: buffer-dma: Turn iio_dma_buffer_init() void
>       iio: buffer-dma: Fix coding style complains
>       iio: buffer-dmaengine: Use the cleanup.h API
>       iio: buffer-dmaengine: Fix coding style complains
>=20
>  drivers/iio/buffer/industrialio-buffer-dma.c       | 187 +++++++++------=
------
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  22 +--
>  include/linux/iio/buffer-dma.h                     |  20 ++-
>  3 files changed, 97 insertions(+), 132 deletions(-)
> ---
> base-commit: c5411c8b9ed1caf53604bb1a5be3f487988efc98
> change-id: 20251104-iio-dmabuf-improvs-03d942284b86
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20
>=20


