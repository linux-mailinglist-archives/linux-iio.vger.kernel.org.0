Return-Path: <linux-iio+bounces-27314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E3CD6007
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 13:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09A81300152B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6C429B766;
	Mon, 22 Dec 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KptdmEDU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB9299A8F
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407069; cv=none; b=bT9qTUumy/fGX2gMax7G8kixQYK+gYEaJJrz5AtGK++vNZ8OyUkl0YoTbfAlF20lQnjJmjPAgMuTg9dkvFENJsuIS7x7CgDBxQfNH87brFw3c2CXjJrJ3szpouDxEXNzDLGBZOEweSOGo0mUAoQYfdzjsQeK/7JuDoKbeFBnMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407069; c=relaxed/simple;
	bh=fEouJQOE7sQqMMbC35Nu8Vn/XwUuIrT95D31jWCJFd8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwk6nnEQpEq2Gdv40w3C5Xqoyxb4MMU2zXey5FmgqALiVyJHQtRLxVk8aG3CkcmlkB2ZZ2nEklvQPUIABgYi+T8Vlq1NSDaR8sUYWODMwzR7c87G8qd6WndVfM3da49VqBGpybu85H4qYIBM57oZUhWXWG7BunvBx6E+JD8VxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KptdmEDU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso2558934f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 04:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766407066; x=1767011866; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5bTiLULFTkxsJ6ipgmNCOJXQo76sWlR0pZtuOAft1SY=;
        b=KptdmEDUFKAiWZUG7AdjeSu9rJEX8xB3iWVQGm86tn7HZdgAs4qZwT1MLejwZvDS+x
         05ndDTHrA1Va1Hr51n193OlAAQ2lrC9fOwFUJh6635GHBvNv9hpX20VuvBrIQ1gBm87j
         e0y7QYEiYENXOLl2K3fxcvBK0wr9reOBEmvRnlonnf4YNnHQaJnAjuNhPK23b1xsbN9g
         m641321/nleUNITeNln4ovicGvTGgi6ffQy96ujsnF1MOh7JquPq3y8gxZpbT1761zrw
         5PgGK7rK4AdoR1i6j5f7lj3KUUC0gYhpRtZKvqoDyDXNiO68f+cyQV4kJ53BETQ/7RC9
         D8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766407066; x=1767011866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bTiLULFTkxsJ6ipgmNCOJXQo76sWlR0pZtuOAft1SY=;
        b=HHpdMLfF9Dxd4XaD0fLiApQN87KTuBCHTo9+MvO4VoBuTGlRhc35Jqsgab3dUYbtTD
         +UwUHdeJJdQAZcxD+tmcbu9bTQlD3kK+FXx98HxMQYtjF+jiwn0oGpcavs0FyHO6PK6Q
         fGmgVxrpKvxm9zX5wQvQUmZrBcJRnqhE8FUqVlSO2v939Spt/1qyt3ZiImdUig1rS2bj
         S7aHMnMK1pTi1nl/kg233ntmwKeUvIEnvHAq0n5gXyM8ZVfkpEP0SSSke0MYn8H1oc9W
         EyDvByMjaXslXFqVtTJncukUo1idLs+LNAvIYlU3qePfahovGq30tW26qR67DqyHKl+T
         LXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvlQgjx4k/fwzZ5WGaBhS/y8Enf8OU/m4iGp/HCEJ3+K1i/fJJBsTmvd8vgRf8z50Ex9YYShIFJkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EhYn+aTNDwQJ1YzUlMQ+1eoRa3we9Ix7+mxE82BzrCmz1zLX
	r9DBbzfr2LplgunbEUubh72wkTpShKPdw7BpTd4B+JcsssTlaqW2QBwY
X-Gm-Gg: AY/fxX5giWC65z6ORGtOJmDxG7N6bC3HlmHQdo3cpbSFtWjBE4K0wBxYKfmFfUYOvFk
	GciBHcpuLzo99CSzNXfF+dc+jxfM6wqI9a0gVstIUFi55M/1i5VhMwf0lk/9duHtaBqZfb2HVQ6
	TUKi17meXa2giey9nBGHhMjiope++vhQ1vaWtMBXhRQuNjZWXGTRC1/qWJ8YNd0cL2dvy8D7zr1
	jlkSU3vdpIqlaZNfY+sqRTYONvKnZmrxeIQdUk/LfAtFTHQ79H4w58x+VnOoGLyCclJq5XkR3Ho
	jJBmAJqU3YTypIl+fpMaYsZGMSaBDRyYXTVytlpMJVf5IqMzGAgB8wk+wH/bqeMBVFATjjp/L8u
	nibZ1aK5HohG66qrMBqQHzf0dEb2iV8hoazj6PzkS4b0LWxf6APCYjGAKcXs3Lo9rntP7vRe+8k
	EMv3IZsYc2+mGgi48f31yti7ZFUA+1yQ==
X-Google-Smtp-Source: AGHT+IFeglLw5EVY2FLHamT0HlCEjk0XsMXVhwnxeqzFy5QGH5KiBeMuO7N8z2AzYpsLnS3Nt+IaAA==
X-Received: by 2002:a05:6000:178c:b0:430:f41f:bd5a with SMTP id ffacd0b85a97d-4324e709017mr13350552f8f.57.1766407065520;
        Mon, 22 Dec 2025 04:37:45 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm21801975f8f.7.2025.12.22.04.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 04:37:45 -0800 (PST)
Message-ID: <3cf8fa55396b520f0f933477b0e5ec723a79f406.camel@gmail.com>
Subject: Re: [PATCH v2 4/6] iio: buffer-dma: Fix coding style complains
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= via B4
 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Mon, 22 Dec 2025 12:38:26 +0000
In-Reply-To: <20251221115950.7cbb5848@jic23-huawei>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
		<20251219-iio-dmabuf-improvs-v2-4-caa76de6e873@analog.com>
	 <20251221115950.7cbb5848@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-12-21 at 11:59 +0000, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 15:28:15 +0000
> Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Just making sure checkpatch is happy. No functional change intended.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> I made a couple of small tweaks whilst applying this one. See below.
>=20

LGTM... Thanks!

- Nuno S=C3=A1

> Jonathan
>=20
> > ---
> > =C2=A0drivers/iio/buffer/industrialio-buffer-dma.c | 23 ++++++++++-----=
--------
> > =C2=A0include/linux/iio/buffer-dma.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++------
> > =C2=A02 files changed, 20 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio=
/buffer/industrialio-
> > buffer-dma.c
> > index 3ab1349f9ea5..c5ee58effc92 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> > @@ -169,8 +169,9 @@ static struct iio_dma_buffer_queue *iio_buffer_to_q=
ueue(struct iio_buffer
> > *buf)
> > =C2=A0	return container_of(buf, struct iio_dma_buffer_queue, buffer);
> > =C2=A0}
> > =C2=A0
> > -static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
> > -	struct iio_dma_buffer_queue *queue, size_t size, bool fileio)
> > +static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(struct =
iio_dma_buffer_queue
> > *queue,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t size,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool fileio)
> For this one I'd split it as:
>=20
> static struct iio_dma_buffer_block *
> iio_dma_buffer_alloc_block(struct iio_dma_buffer_queue *queue, size_t siz=
e,
> 			=C2=A0=C2=A0 bool fileio)
>=20
> > =C2=A0{
> > =C2=A0	struct iio_dma_buffer_block *block __free(kfree) =3D
> > =C2=A0			kzalloc(sizeof(*block), GFP_KERNEL);
> > @@ -254,7 +255,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_block_done, "II=
O_DMA_BUFFER");
> > =C2=A0 * hand the blocks back to the queue.
> > =C2=A0 */
> > =C2=A0void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue =
*queue,
> > -	struct list_head *list)
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *list)
> > =C2=A0{
> > =C2=A0	struct iio_dma_buffer_block *block, *_block;
> > =C2=A0	bool cookie;
> > @@ -434,7 +435,7 @@ static void iio_dma_buffer_fileio_free(struct iio_d=
ma_buffer_queue *queue)
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void iio_dma_buffer_submit_block(struct iio_dma_buffer_que=
ue *queue,
> > -	struct iio_dma_buffer_block *block)
> > +					struct iio_dma_buffer_block *block)
> > =C2=A0{
> > =C2=A0	int ret;
> > =C2=A0
> > @@ -478,8 +479,7 @@ static void iio_dma_buffer_submit_block(struct iio_=
dma_buffer_queue *queue,
> > =C2=A0 *
> > =C2=A0 * This will allocate the DMA buffers and start the DMA transfers=
.
> > =C2=A0 */
> > -int iio_dma_buffer_enable(struct iio_buffer *buffer,
> > -	struct iio_dev *indio_dev)
> > +int iio_dma_buffer_enable(struct iio_buffer *buffer, struct iio_dev *i=
ndio_dev)
> > =C2=A0{
> > =C2=A0	struct iio_dma_buffer_queue *queue =3D iio_buffer_to_queue(buffe=
r);
> > =C2=A0	struct iio_dma_buffer_block *block, *_block;
> > @@ -503,8 +503,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_enable, "IIO_DM=
A_BUFFER");
> > =C2=A0 * Needs to be called when the device that the buffer is attached=
 to stops
> > =C2=A0 * sampling. Typically should be the iio_buffer_access_ops disabl=
e callback.
> > =C2=A0 */
> > -int iio_dma_buffer_disable(struct iio_buffer *buffer,
> > -	struct iio_dev *indio_dev)
> > +int iio_dma_buffer_disable(struct iio_buffer *buffer, struct iio_dev *=
indio_dev)
> > =C2=A0{
> > =C2=A0	struct iio_dma_buffer_queue *queue =3D iio_buffer_to_queue(buffe=
r);
> > =C2=A0
> > @@ -519,7 +518,7 @@ int iio_dma_buffer_disable(struct iio_buffer *buffe=
r,
> > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_disable, "IIO_DMA_BUFFER");
> > =C2=A0
> > =C2=A0static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue *q=
ueue,
> > -	struct iio_dma_buffer_block *block)
> > +				=C2=A0=C2=A0 struct iio_dma_buffer_block *block)
> > =C2=A0{
> > =C2=A0	if (block->state =3D=3D IIO_BLOCK_STATE_DEAD) {
> > =C2=A0		iio_buffer_block_put(block);
> > @@ -531,8 +530,7 @@ static void iio_dma_buffer_enqueue(struct iio_dma_b=
uffer_queue *queue,
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > -static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
> > -	struct iio_dma_buffer_queue *queue)
> > +static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(struct iio_=
dma_buffer_queue *queue)
>=20
> static struct iio_dma_buffer_block *
> iio_dma_buffer_dequeue(struct iio_dma_buffer_queue *queue)
>=20
> is a bit nicer than that long line to my eyes and common enough style.
>=20
> > =C2=A0{
> > =C2=A0	struct iio_dma_buffer_block *block;
> > =C2=A0	unsigned int idx;
> > @@ -661,8 +659,7 @@ size_t iio_dma_buffer_usage(struct iio_buffer *buf)
> > =C2=A0	for (i =3D 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> > =C2=A0		block =3D queue->fileio.blocks[i];
> > =C2=A0
> > -		if (block !=3D queue->fileio.active_block
> > -		=C2=A0=C2=A0=C2=A0 && block->state =3D=3D IIO_BLOCK_STATE_DONE)
> > +		if (block !=3D queue->fileio.active_block && block->state =3D=3D
> > IIO_BLOCK_STATE_DONE)
> > =C2=A0			data_available +=3D block->size;
> > =C2=A0	}
> > =C2=A0
> > diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-=
dma.h
> > index 91f678e5be71..f794af0970bd 100644
> > --- a/include/linux/iio/buffer-dma.h
> > +++ b/include/linux/iio/buffer-dma.h
> > @@ -119,7 +119,12 @@ struct iio_dma_buffer_queue {
> > =C2=A0	struct device *dev;
> > =C2=A0	const struct iio_dma_buffer_ops *ops;
> > =C2=A0
> > +	/*
> > +	 * A mutex to protect accessing, configuring (eg: enqueuing DMA block=
s)
> > +	 * and do file IO on struct iio_dma_buffer_queue objects.
> > +	 */
> > =C2=A0	struct mutex lock;
> > +	/* A spin lock to protect adding/removing blocks to the queue list */
> > =C2=A0	spinlock_t list_lock;
> > =C2=A0	struct list_head incoming;
> > =C2=A0
> > @@ -136,20 +141,19 @@ struct iio_dma_buffer_queue {
> > =C2=A0 */
> > =C2=A0struct iio_dma_buffer_ops {
> > =C2=A0	int (*submit)(struct iio_dma_buffer_queue *queue,
> > -		struct iio_dma_buffer_block *block);
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dma_buffer_block *block);
> > =C2=A0	void (*abort)(struct iio_dma_buffer_queue *queue);
> > =C2=A0};
> > =C2=A0
> > =C2=A0void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block=
);
> > =C2=A0void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue =
*queue,
> > -	struct list_head *list);
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *list);
> > =C2=A0
> > -int iio_dma_buffer_enable(struct iio_buffer *buffer,
> > -	struct iio_dev *indio_dev);
> > +int iio_dma_buffer_enable(struct iio_buffer *buffer, struct iio_dev *i=
ndio_dev);
> > =C2=A0int iio_dma_buffer_disable(struct iio_buffer *buffer,
> > -	struct iio_dev *indio_dev);
> > +			=C2=A0=C2=A0 struct iio_dev *indio_dev);
> > =C2=A0int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> > -	char __user *user_buffer);
> > +			char __user *user_buffer);
> > =C2=A0int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
> > =C2=A0			 const char __user *user_buffer);
> > =C2=A0size_t iio_dma_buffer_usage(struct iio_buffer *buffer);
> >=20

