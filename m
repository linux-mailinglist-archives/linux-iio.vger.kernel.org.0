Return-Path: <linux-iio+bounces-27264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A397CD3FB0
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 13:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C5873007186
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501942F6199;
	Sun, 21 Dec 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXQQ0x4u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9EC23536B
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318401; cv=none; b=UxtM987zIrXXaAddT4zuXmU1SeVXY3TgKPUWI1oj0a16VK7xvscfQOF9vMC2fM1vpxKR2eWmb20OmRUJ+jThLc6FW1ds+niyDlEA9D6k+YwP2wlUuGMJ0yAZ8Gp7IiYBoWP9qSdGCxXyQx2IgiZ0JPtR4sWjdUC1Z0L8iO/GR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318401; c=relaxed/simple;
	bh=0XmgteeNJyNaVYIdW4brvF1YmU7TP0fjd9uREN2JZE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9we3FV6YWJ6wqxlIV64rT56kP7i7Q9MH5exGTzRgAntmcqmedftfjU+4M0X5HOKa1pVTPECQsYL77rbfQGIgNa4d41yYyQh9tmMFRrq8G6hpNSUMcdUqAQSMBMJuNczVLm2rOKUmV9JowMCAPVzKXyk1teWriYfoHXjJwuobGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXQQ0x4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C201C4CEFB;
	Sun, 21 Dec 2025 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766318398;
	bh=0XmgteeNJyNaVYIdW4brvF1YmU7TP0fjd9uREN2JZE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eXQQ0x4uL4tmAEeGUsvhrmWaOXaHPXc9j99dLR4jPR3s5OqoDeOdP7KYqF6DBJzSJ
	 dSaaLybCEFDrDbEhHZamPyFqEQMMzpiv0wEtPOLIpdCGkmhYzbC90GJKOIGqMyEafZ
	 PcShyXmnW53EyK4DGQy+8sFq/ZSy+rxjZMEOtQNx8fEpY/dGP7DfD6AHInbsYo7LI2
	 hI6oJpqdFuciWyO1GCefuIss8N784c4DfraDSpYODWx/ZJJ8IdTKeoqVdGom0Hj8m3
	 vBOUbtDtF3JDVuxV2qSL0572d+sxmY2rgh3v7n5sq1PCW3XN0RCW8PJh88qU/JLV+M
	 YvPafW6Lg9F7g==
Date: Sun, 21 Dec 2025 11:59:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 4/6] iio: buffer-dma: Fix coding style complains
Message-ID: <20251221115950.7cbb5848@jic23-huawei>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-4-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
	<20251219-iio-dmabuf-improvs-v2-4-caa76de6e873@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 15:28:15 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Just making sure checkpatch is happy. No functional change intended.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
I made a couple of small tweaks whilst applying this one. See below.

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 23 ++++++++++-------------
>  include/linux/iio/buffer-dma.h               | 16 ++++++++++------
>  2 files changed, 20 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/b=
uffer/industrialio-buffer-dma.c
> index 3ab1349f9ea5..c5ee58effc92 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -169,8 +169,9 @@ static struct iio_dma_buffer_queue *iio_buffer_to_que=
ue(struct iio_buffer *buf)
>  	return container_of(buf, struct iio_dma_buffer_queue, buffer);
>  }
> =20
> -static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
> -	struct iio_dma_buffer_queue *queue, size_t size, bool fileio)
> +static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(struct ii=
o_dma_buffer_queue *queue,
> +							       size_t size,
> +							       bool fileio)
For this one I'd split it as:

static struct iio_dma_buffer_block *
iio_dma_buffer_alloc_block(struct iio_dma_buffer_queue *queue, size_t size,
			   bool fileio)

>  {
>  	struct iio_dma_buffer_block *block __free(kfree) =3D
>  			kzalloc(sizeof(*block), GFP_KERNEL);
> @@ -254,7 +255,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_block_done, "IIO_=
DMA_BUFFER");
>   * hand the blocks back to the queue.
>   */
>  void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
> -	struct list_head *list)
> +				     struct list_head *list)
>  {
>  	struct iio_dma_buffer_block *block, *_block;
>  	bool cookie;
> @@ -434,7 +435,7 @@ static void iio_dma_buffer_fileio_free(struct iio_dma=
_buffer_queue *queue)
>  }
> =20
>  static void iio_dma_buffer_submit_block(struct iio_dma_buffer_queue *que=
ue,
> -	struct iio_dma_buffer_block *block)
> +					struct iio_dma_buffer_block *block)
>  {
>  	int ret;
> =20
> @@ -478,8 +479,7 @@ static void iio_dma_buffer_submit_block(struct iio_dm=
a_buffer_queue *queue,
>   *
>   * This will allocate the DMA buffers and start the DMA transfers.
>   */
> -int iio_dma_buffer_enable(struct iio_buffer *buffer,
> -	struct iio_dev *indio_dev)
> +int iio_dma_buffer_enable(struct iio_buffer *buffer, struct iio_dev *ind=
io_dev)
>  {
>  	struct iio_dma_buffer_queue *queue =3D iio_buffer_to_queue(buffer);
>  	struct iio_dma_buffer_block *block, *_block;
> @@ -503,8 +503,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_enable, "IIO_DMA_=
BUFFER");
>   * Needs to be called when the device that the buffer is attached to sto=
ps
>   * sampling. Typically should be the iio_buffer_access_ops disable callb=
ack.
>   */
> -int iio_dma_buffer_disable(struct iio_buffer *buffer,
> -	struct iio_dev *indio_dev)
> +int iio_dma_buffer_disable(struct iio_buffer *buffer, struct iio_dev *in=
dio_dev)
>  {
>  	struct iio_dma_buffer_queue *queue =3D iio_buffer_to_queue(buffer);
> =20
> @@ -519,7 +518,7 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
>  EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_disable, "IIO_DMA_BUFFER");
> =20
>  static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue *queue,
> -	struct iio_dma_buffer_block *block)
> +				   struct iio_dma_buffer_block *block)
>  {
>  	if (block->state =3D=3D IIO_BLOCK_STATE_DEAD) {
>  		iio_buffer_block_put(block);
> @@ -531,8 +530,7 @@ static void iio_dma_buffer_enqueue(struct iio_dma_buf=
fer_queue *queue,
>  	}
>  }
> =20
> -static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
> -	struct iio_dma_buffer_queue *queue)
> +static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(struct iio_dm=
a_buffer_queue *queue)

static struct iio_dma_buffer_block *
iio_dma_buffer_dequeue(struct iio_dma_buffer_queue *queue)

is a bit nicer than that long line to my eyes and common enough style.

>  {
>  	struct iio_dma_buffer_block *block;
>  	unsigned int idx;
> @@ -661,8 +659,7 @@ size_t iio_dma_buffer_usage(struct iio_buffer *buf)
>  	for (i =3D 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
>  		block =3D queue->fileio.blocks[i];
> =20
> -		if (block !=3D queue->fileio.active_block
> -		    && block->state =3D=3D IIO_BLOCK_STATE_DONE)
> +		if (block !=3D queue->fileio.active_block && block->state =3D=3D IIO_B=
LOCK_STATE_DONE)
>  			data_available +=3D block->size;
>  	}
> =20
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dm=
a.h
> index 91f678e5be71..f794af0970bd 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -119,7 +119,12 @@ struct iio_dma_buffer_queue {
>  	struct device *dev;
>  	const struct iio_dma_buffer_ops *ops;
> =20
> +	/*
> +	 * A mutex to protect accessing, configuring (eg: enqueuing DMA blocks)
> +	 * and do file IO on struct iio_dma_buffer_queue objects.
> +	 */
>  	struct mutex lock;
> +	/* A spin lock to protect adding/removing blocks to the queue list */
>  	spinlock_t list_lock;
>  	struct list_head incoming;
> =20
> @@ -136,20 +141,19 @@ struct iio_dma_buffer_queue {
>   */
>  struct iio_dma_buffer_ops {
>  	int (*submit)(struct iio_dma_buffer_queue *queue,
> -		struct iio_dma_buffer_block *block);
> +		      struct iio_dma_buffer_block *block);
>  	void (*abort)(struct iio_dma_buffer_queue *queue);
>  };
> =20
>  void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block);
>  void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
> -	struct list_head *list);
> +				     struct list_head *list);
> =20
> -int iio_dma_buffer_enable(struct iio_buffer *buffer,
> -	struct iio_dev *indio_dev);
> +int iio_dma_buffer_enable(struct iio_buffer *buffer, struct iio_dev *ind=
io_dev);
>  int iio_dma_buffer_disable(struct iio_buffer *buffer,
> -	struct iio_dev *indio_dev);
> +			   struct iio_dev *indio_dev);
>  int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> -	char __user *user_buffer);
> +			char __user *user_buffer);
>  int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
>  			 const char __user *user_buffer);
>  size_t iio_dma_buffer_usage(struct iio_buffer *buffer);
>=20


