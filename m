Return-Path: <linux-iio+bounces-27265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 090AECD3FB3
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 13:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE16D3008EB7
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F2F28A3FA;
	Sun, 21 Dec 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYkI+LO6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E5191F98
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318509; cv=none; b=XoVbB5wlFGEI3D65YAXpZazRDHniGnQeMblmkVIMhd94sXLN1T4FU5MmW5Fe/voHUgxMJ6UQDyLmr1vVtTnv0Rp4J7GS3f5RbAjjgvh+1foKUgXujAwMZ2McEC45MjDJKPOa6Rgf9BfFYKDn5qDz2mpY7QdgLQuUeX+oocjX3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318509; c=relaxed/simple;
	bh=dT1uxhEFEtmBtJWbPfhdC3UX/ycmc/ZP9gQNyymijCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mA+6Gu32fBdKe7qmhD87pkIRZJGaYW0eCmrwMFdZaoGYAl2YLxBQB1dZOItOHmC/hwRlf3XrT5D8vejWXkkUqDnWNFKIQwuVOqZy7kPwSB9gv440Hg4LxMcKF8q9RaaF06ixbmglDia4GPNJV9v6LlpOB+BR82xhAHO4SBbRw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYkI+LO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90423C4CEFB;
	Sun, 21 Dec 2025 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766318508;
	bh=dT1uxhEFEtmBtJWbPfhdC3UX/ycmc/ZP9gQNyymijCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OYkI+LO6oeznRGKuW9rTwjLAqCkV1t0FgTX/miqZUCOmXkS7knG6tJ5w9x49aMl3p
	 6M5vG+kG0PaVj+OALlFLhbCWnW9RZyskLqPolZAMEqKPQ9bsrW6KSYObpNK5F06ild
	 fpy0rb4IFk7yMeaI/l2Gqdx3IomVrWIoYnV//N19qAY2hBbA2a4xhNNG5nEIE13DKp
	 gTSW77Ds2LXWc8Uhykj1yD6VuEMGAkdBtFPcdEanaLuUWB/8Fw7hH7fUya5I8Ye7TN
	 +tk7n6hV5u6sWWcDc8M8O1lm/JPxeIq457QO87zWTX4yS7GKI4APAwZKuZue6ekGGb
	 v1MsPiLlTVYAg==
Date: Sun, 21 Dec 2025 12:01:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 5/6] iio: buffer-dmaengine: Use the cleanup.h API
Message-ID: <20251221120141.02d01840@jic23-huawei>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-5-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
	<20251219-iio-dmabuf-improvs-v2-5-caa76de6e873@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 15:28:16 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Make use of the cleanup.h API for locks in order to simplify some code
> paths.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Needs cleanup.h for scoped_guard() definition.

I'm not seeing this as a significant simplification but this driver is
your problems so fair enough.

So applied with the header include added.

Jonathan



> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index e9d9a7d39fe1..a8a4adb5ed3a 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -49,11 +49,9 @@ static void iio_dmaengine_buffer_block_done(void *data,
>  		const struct dmaengine_result *result)
>  {
>  	struct iio_dma_buffer_block *block =3D data;
> -	unsigned long flags;
> =20
> -	spin_lock_irqsave(&block->queue->list_lock, flags);
> -	list_del(&block->head);
> -	spin_unlock_irqrestore(&block->queue->list_lock, flags);
> +	scoped_guard(spinlock_irqsave, &block->queue->list_lock)
> +		list_del(&block->head);
>  	block->bytes_used -=3D result->residue;
>  	iio_dma_buffer_block_done(block);
>  }
> @@ -131,9 +129,8 @@ static int iio_dmaengine_buffer_submit_block(struct i=
io_dma_buffer_queue *queue,
>  	if (dma_submit_error(cookie))
>  		return dma_submit_error(cookie);
> =20
> -	spin_lock_irq(&dmaengine_buffer->queue.list_lock);
> -	list_add_tail(&block->head, &dmaengine_buffer->active);
> -	spin_unlock_irq(&dmaengine_buffer->queue.list_lock);
> +	scoped_guard(spinlock_irq, &dmaengine_buffer->queue.list_lock)
> +		list_add_tail(&block->head, &dmaengine_buffer->active);
> =20
>  	dma_async_issue_pending(dmaengine_buffer->chan);
> =20
>=20


