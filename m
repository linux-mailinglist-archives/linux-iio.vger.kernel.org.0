Return-Path: <linux-iio+bounces-19912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E826AC35F6
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 19:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B0A3ACBBD
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F2200B99;
	Sun, 25 May 2025 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg992E3J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3471F4289;
	Sun, 25 May 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748194536; cv=none; b=CFGbi3f1+jxLPdUo7HaRil+LPfIxqenepMYzZMMHnA6gDc9ShK0XN5Bc2LNr6rEZ0cL5td7DWuV8XRDlDb928b4A62vzDCtINOshM9U9DMrkuCRFlihzFwvqj8+sJcfwvhImjNB7PDoj/6w4xnUzPNv7sJCrIknLA7KWnF3t220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748194536; c=relaxed/simple;
	bh=ven09nrg/Zbp4OZr5jcKKvIC9KJfxQcapKQr/5P3d+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEfnaq2GxlYeuDppyJBPTPKU5l6qiPnK2CBR/ELAaHRwfARiDOWSw7EQBay4FVije7d/gHs6bZd81aSN50grkw70lRfTjjQ3i7HnZSJQxSPr3sHmr0zGl4S1KZTmeSrseukocxLcXHIexgrSTy5CVqa7rarD8//9VMg0wIU5Sy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg992E3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC86FC4CEEA;
	Sun, 25 May 2025 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748194535;
	bh=ven09nrg/Zbp4OZr5jcKKvIC9KJfxQcapKQr/5P3d+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eg992E3J6q9pzjbfy0YgxicmGf1LRhhS4YxCEOxPvWJph5+rTzmxnJKfee/KVjrwG
	 9gLfJmAEwuPR3gua6qm3yPed/hWQWB1qXg3XzOQdHV4begTjVV6Db9aFBnx+53XioG
	 OMphNVYh9U6oPJA4LPfbdUsU7nAqy7BBRaChqgu28Ydkb8p9rIQrD0jf9VP3OwLpgm
	 kgNdIdiNXtRSxCS5idnzn0E6lWbzmM1wyCt9U+8S89xgpFLEm72Yi+xvlgtQzd4PfM
	 mckQMATVtoMpX1zHMZbrSgGvbNAq3K8uZTIfmPnogkp18mk5gdi3Z0Gnp8KCWGJSBI
	 n+A/7sxWctyCA==
Date: Sun, 25 May 2025 18:35:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/9] iio: buffer: Fix checkpatch.pl warning
Message-ID: <20250525183528.14877bd2@jic23-huawei>
In-Reply-To: <20250519-timestamp-v1-1-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
	<20250519-timestamp-v1-1-fcb4f6c2721c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 23:25:53 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Remove the following trivial warning:
> "WARNING: Block comments should align the * on each line"
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Applied.

As a general rule don't send unrelated cleanup in an RFC series
doing something interesting!  They might get missed.

Jonathan
> ---
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index c06515987e7a..9bf75dee7ff8 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> - /*
> +/*
>   * Copyright (c) 2012 Analog Devices, Inc.
>   *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
> 


