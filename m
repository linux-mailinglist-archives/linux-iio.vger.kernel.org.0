Return-Path: <linux-iio+bounces-24664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0989BB4759
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062AD16C286
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B97242D8A;
	Thu,  2 Oct 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jaYnjv7o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357A4F5E0
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421666; cv=none; b=Z+t7l/7kt+MuMTprTtZwRH19N/1W2fJGWkUcq1biu151L5VRDqUT/n2QRTkbgQpL4c8SDLJQNg3KVrYPiTforFa25yFMioI+rpVLGLk3xX8gpDEakGl99uTWLIOEzWveFWKmNlQZOcgxIXOVz1cWmlU2hKLX0XwGWX+R1JM+4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421666; c=relaxed/simple;
	bh=3EbcQxzrfSHvharvzoPV/TJ86deLyeMnQfmnslRVCdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dk2GCbxbdteihLRbBckicPDf4nzpUi6Kk/Or/sLDdK67Gewdswq5CsFqyeONBqu2evnunzRw2YSNXLB05owLXq6dk73qDQqw9qEvJzzuryAaGJ1qZBvZGihQklGpjp2mYJ8RROj/wnhBmyhE10EpNU+nfe4h+bMMX2ucHT7ePfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jaYnjv7o; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3612c38b902so11937931fa.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759421661; x=1760026461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLMFHoFP/+m9CsT2IfCn9Fi4sK7gfnIriAgFKaEJ/KM=;
        b=jaYnjv7oc3CoT3t9zvCrDC6yWxoAK9KaLqfN89Kf1UNQ1DjU4F2vfr7zqsrCyRztE+
         92eaS4d5ewwthItyXnhdSbNfS01tRR20766zX7fBOeFBPJbQxsJATNxo62bAI18OO/8j
         pG315QsAblhUqSSTTEcw7+33dZw+9EC27QDIfgn+ayLdLgheJqlY7PyddgZQj+Mvknik
         t8ZtPxXs3aCCe/29fV/hSDNged7wPu7m6Gelol36kMM+c6/H6qT4gDHR3Y17A0VX3A2o
         eWcmGJsMvn/ZrBSctmaZUixcO/CaT1mf+0qwo5MRKFLIh33g5Mz5a8mn0jykJeW5NMt5
         RZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421661; x=1760026461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLMFHoFP/+m9CsT2IfCn9Fi4sK7gfnIriAgFKaEJ/KM=;
        b=eJUMamM1wugqoVajkPub2PPa6agnQ3Do7ZgEaTvamxoMCReygerC6DA5lauoNS/w2B
         dWRHkvvzQ6373xhuSArax4yk+Hrqrxz07GDBR4JAjMpwXHAkWfI9gU1f3cACkZ/w131h
         2VAHqU9+kIICwHJZDxqn0/rY1g4d82K2jqNHn4iJfde1mmY+VX7ZlRCO4ATnUAdr+VMe
         tk4u1JoAxAQpQvpzmH9JV1NJouko74HeJqULwWEDbEb5Xh4MXaZcBZLD6qnPj9IDq9Ey
         fXksfwiue/lluOFB8tKVQ2wu0eczLzlPK2THM5PtWjwYygsa7dtJW0uQ0ClrZs0lA8/u
         /cBw==
X-Gm-Message-State: AOJu0YywdHdmpGL1GlyoPYGV5artL8pEtqSfgUOa33T8Wdg9bYlwMWo5
	zTjeuvjnh8pQE29phXJhMW/gxaU4cXJBj1Qt2W2juucfArMmzSw4M6VFJ3DGt4c+s3YwS4PJ6zr
	McMxVXqxLuWkH1sdNpHh5KeeIyTCZBu9nWVr4gw4hTCbf8JsmH075aXhn6w==
X-Gm-Gg: ASbGncvn9U5fb7DHPbNL4iTaofsSruuVu+ZcuTKQ0yN4VSf793HbfmDrrIv2ddN3GfB
	z2qs79eMwm+R8wUx7N2oGM3pqQ92DUU6XS39vfAT0TkPuLTe80tkvjfB+jRZK0BPm+WUnbCgC20
	GqV4BdVF07orxvoeVsAIprFRoEEsv520XDxx8db0h5EIY42DAP9caPSnM98998cUYMnSPqcqMq1
	xxtTvvBkOzY3uZ66UkLrh/5Nybz9cG9e39N+19cjw==
X-Google-Smtp-Source: AGHT+IExuS4XBnsUUGjk+Od1G3g1iER4n4UC+kyix2Qd2lqFeAVGBWE/t7xiLKHabU67uN8WeqLVQSvwL8dBapVNMUM=
X-Received: by 2002:a05:651c:1501:b0:36d:4996:1c26 with SMTP id
 38308e7fff4ca-373a73b3a16mr26013461fa.11.1759421660497; Thu, 02 Oct 2025
 09:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
 <20251002-fix-iio-dmabuf-get-dma-device-v1-1-c1c9945029d0@analog.com>
In-Reply-To: <20251002-fix-iio-dmabuf-get-dma-device-v1-1-c1c9945029d0@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 2 Oct 2025 18:14:09 +0200
X-Gm-Features: AS18NWCB05zp9VSNBn94ralNfwIt5DyM-rD2yn6PA-VLgpuSG37BDYvhwXVJ-oY
Message-ID: <CAMknhBEcK=S__AehN65eLP0zHa1__LrKqpRjmXQPg8PzPbt5xQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: buffer: support getting dma channel from the buffer
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 5:06=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> Add a new buffer accessor .get_dma_dev() in order to get the
> struct device responsible for actually providing the dma channel. We
> cannot assume that we can use the parent of the IIO device for mapping
> the DMA buffer. This becomes important on systems (like the Xilinx/AMD
> zynqMP Ultrascale) where memory (or part of it) is mapped above the
> 32 bit range. On such systems and given that a device by default has
> a dma mask of 32 bits we would then need to rely on bounce buffers (to
> swiotlb) for mapping memory above the dma mask limit.
>
> Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure"=
)

Does this actually fix it or is it just a prerequisite for a later
fix? (In that case, this would just be Cc: stable@vger.kernel.org)

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-buffer.c | 28 ++++++++++++++++++++++------
>  include/linux/iio/buffer_impl.h   |  2 ++
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index f1448ae1b843fc577599fc1b9cf6d859bba226f1..279c7d716bf5d467d40b5c290=
789fcbd1f949660 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1627,15 +1627,20 @@ static struct dma_buf_attachment *
>  iio_buffer_find_attachment(struct iio_dev_buffer_pair *ib,
>                            struct dma_buf *dmabuf, bool nonblock)
>  {
> -       struct device *dev =3D ib->indio_dev->dev.parent;
> +       struct device *dma_dev;
>         struct iio_buffer *buffer =3D ib->buffer;
>         struct dma_buf_attachment *attach =3D NULL;
>         struct iio_dmabuf_priv *priv;
>
> +       if (buffer->access->get_dma_dev)
> +               dma_dev =3D buffer->access->get_dma_dev(buffer);
> +       else
> +               dma_dev =3D ib->indio_dev->dev.parent;
> +

This gets repeated 3 times, so maybe worth adding a helper function?

>         guard(mutex)(&buffer->dmabufs_mutex);
>
>         list_for_each_entry(priv, &buffer->dmabufs, entry) {
> -               if (priv->attach->dev =3D=3D dev
> +               if (priv->attach->dev =3D=3D dma_dev
>                     && priv->attach->dmabuf =3D=3D dmabuf) {
>                         attach =3D priv->attach;
>                         break;
> @@ -1655,6 +1660,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_=
buffer_pair *ib,
>         struct iio_buffer *buffer =3D ib->buffer;
>         struct dma_buf_attachment *attach;
>         struct iio_dmabuf_priv *priv, *each;
> +       struct device *dma_dev;
>         struct dma_buf *dmabuf;
>         int err, fd;
>
> @@ -1679,7 +1685,12 @@ static int iio_buffer_attach_dmabuf(struct iio_dev=
_buffer_pair *ib,
>                 goto err_free_priv;
>         }
>
> -       attach =3D dma_buf_attach(dmabuf, indio_dev->dev.parent);
> +       if (buffer->access->get_dma_dev)
> +               dma_dev =3D buffer->access->get_dma_dev(buffer);
> +       else
> +               dma_dev =3D indio_dev->dev.parent;
> +
> +       attach =3D dma_buf_attach(dmabuf, dma_dev);
>         if (IS_ERR(attach)) {
>                 err =3D PTR_ERR(attach);
>                 goto err_dmabuf_put;
> @@ -1719,7 +1730,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_=
buffer_pair *ib,
>          * combo. If we do, refuse to attach.
>          */
>         list_for_each_entry(each, &buffer->dmabufs, entry) {
> -               if (each->attach->dev =3D=3D indio_dev->dev.parent
> +               if (each->attach->dev =3D=3D dma_dev
>                     && each->attach->dmabuf =3D=3D dmabuf) {
>                         /*
>                          * We unlocked the reservation object, so going t=
hrough
> @@ -1759,6 +1770,7 @@ static int iio_buffer_detach_dmabuf(struct iio_dev_=
buffer_pair *ib,
>         struct iio_buffer *buffer =3D ib->buffer;
>         struct iio_dev *indio_dev =3D ib->indio_dev;
>         struct iio_dmabuf_priv *priv;
> +       struct device *dma_dev;
>         struct dma_buf *dmabuf;
>         int dmabuf_fd, ret =3D -EPERM;
>
> @@ -1769,11 +1781,15 @@ static int iio_buffer_detach_dmabuf(struct iio_de=
v_buffer_pair *ib,
>         if (IS_ERR(dmabuf))
>                 return PTR_ERR(dmabuf);
>
> +       if (buffer->access->get_dma_dev)
> +               dma_dev =3D buffer->access->get_dma_dev(buffer);
> +       else
> +               dma_dev =3D indio_dev->dev.parent;
> +
>         guard(mutex)(&buffer->dmabufs_mutex);
>
>         list_for_each_entry(priv, &buffer->dmabufs, entry) {
> -               if (priv->attach->dev =3D=3D indio_dev->dev.parent
> -                   && priv->attach->dmabuf =3D=3D dmabuf) {
> +               if (priv->attach->dev =3D=3D dma_dev && priv->attach->dma=
buf =3D=3D dmabuf) {
>                         list_del(&priv->entry);
>
>                         /* Unref the reference from iio_buffer_attach_dma=
buf() */
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_i=
mpl.h
> index 0daff9ff20ce49de67fa0f2ac6191882de2f4a67..c0b0e0992a85b2813a126c1a6=
1f13f1ed0b498dd 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -51,6 +51,7 @@ struct sg_table;
>   * @enqueue_dmabuf:    called from userspace via ioctl to queue this DMA=
BUF
>   *                     object to this buffer. Requires a valid DMABUF fd=
, that
>   *                     was previouly attached to this buffer.
> + * @get_dma_dev:       called to get the DMA channel associated with thi=
s buffer.

Could probably clarify that this is required for DMA buffers but
should not be provided for other buffers.

>   * @lock_queue:                called when the core needs to lock the bu=
ffer queue;
>   *                      it is used when enqueueing DMABUF objects.
>   * @unlock_queue:       used to unlock a previously locked buffer queue
> @@ -91,6 +92,7 @@ struct iio_buffer_access_funcs {
>                               struct iio_dma_buffer_block *block,
>                               struct dma_fence *fence, struct sg_table *s=
gt,
>                               size_t size, bool cyclic);
> +       struct device * (*get_dma_dev)(struct iio_buffer *buffer);
>         void (*lock_queue)(struct iio_buffer *buffer);
>         void (*unlock_queue)(struct iio_buffer *buffer);
>
>
> --
> 2.51.0
>
>

