Return-Path: <linux-iio+bounces-26206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5314FC5C302
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B6294F74FB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB03019A8;
	Fri, 14 Nov 2025 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZPRT4Nk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FFF3019CF
	for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111219; cv=none; b=Zz2A0t/BjrRR8yoJr1bW9XaR2fimJiX5Ml861gyNrivjAsvwptWAKducxO327MVbPcDRb5CA89nie8lpVGdrC34jtNuw15CU2dfi2+O3rmLMH56aCCzyGjRh5oEcIwMtydl9cTiCk3Szos3SFo641D6LU+l1ujKeLhxD9H3yTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111219; c=relaxed/simple;
	bh=6zHnHDGEsf3utNSz4L3WgxRyx4n+9ITDWclyuCK6DGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgBdybPowYGGQpwDfvy9+sORFv/kOcHjmSwyY87ss0BnZ2+w9RQvS843MRejsP/MlNeP85KqfNCDyApFtZN7ufL3HSY/UFXY9xgMXBXaV/z5vf9QmdQ3KJFDN7tFs/LkkyKKdAifmAP6SXeO2S/k0hZjMNXin15Bjtp1wGaemqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZPRT4Nk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632cc932so8118095e9.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 01:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111216; x=1763716016; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MhzSvQe2CH4l6IIRGts1CDJxv3IbNpAVJaCMsNzVhko=;
        b=EZPRT4Nk+R1ZtfgfH3YHGNiO/q3I5lhXIQ1W3Cdl12r+W662W7fzX1XeoDd0AHDrlu
         rNQ7jvIR+a61u3B06zh416liOmzJ8G13VW04cMZMZOT8DqQ1yPCsl03P7AzRAHaUuCAR
         t8Nm5oOBNZI5oFXRrPvUhVnmwpxJZi8t2561ThaRcZvbtFsjmXcqCUm9uNPCah5gQVgu
         Zk4W/x51dI4iAVW5gTuVUJ6Zh7p3n8/K83L/6VF2GO3HEoV/6NZVT6cKP3QQ2xjWYLYR
         MgG2n4pnF6cvLmC1Xw31uDK+Hv4iS+fws+eCsUulVY1bJANQd32h2mtOxLNTppHz7GUK
         ObsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111216; x=1763716016;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhzSvQe2CH4l6IIRGts1CDJxv3IbNpAVJaCMsNzVhko=;
        b=rPIzZyJ0R9Nl9Mfum68SFyMwktAE/fMHQvlRs5AxVsbhguF2gF/uwjJR9Ubp3O9Gf8
         tk881LnaQ0Rp0IgGfxXk+PqWomLrWYhzejDdpd8o6Aj7VPTrxvEwJjPUGBdRoVTWlhLS
         7QkAA09Q0lB4yleOgCJtwjlrK9zYGfmFaQ1f8GAqGLGAOxcI/YoPih2SybAuk/BWsD0f
         B1g2bkN5fAhwzDQuCkp+W4pmUr3hxgrkMBkQ9mtCLDYHJ0jxVWBPQeBvi49d5kIvJ4Dt
         50cmuxVScqORUWQ2bPHn3ZnV3EF0tknMQoITGN+cYet9tAh7FsGXeySkKKV3N7xftxMB
         k7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVaAPVuWlqGYwYWXSULWArWN6GCeRwuvFeOQIN6t9Cf7xFX90y3/dRxS8IUpSatYtYSjTgEGHR39Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp89fukd/cB26McL8/QFnwrG9SXPl+TBv2M2FejZHPCe3H0YHg
	LJNKdnGFe+zu5OUOjqJDmrnYawxzgOneedmw4Y1iIs52mU6pgeenevLR
X-Gm-Gg: ASbGncvCLix+ybKTzviO7SvH4Luxmdcw8VM/hD5Wv1iDxmw31FQDZUSu4pWDBvyEFjr
	sovHI+VgwlwxqEBERpQK8XMrFxz1hc0arJkpbd00njUUDtiR1KnKnmz3rRujlPEdvk9yO+cvqPq
	Jl48fy+PwKysa7tr1xo9nZ6jTzfAYN8gduB6MnqtxnlDJbDVGP7iqb1Qe9hS7J8nvtQNy1ssBOP
	fB9dxXz1TyXGtsrlporZg9XmgIasbKDcK4kPMT7jmUcJ44mk3bqsoMxWNzq7zfy1XB8hk25oJh4
	pVdFAaB7Jdu2avLMfMavCYO8rZ9gc5QyTtlfvYCsww3KAQ4eZVr5Ufuhr0kSPDdDbD168deezsb
	nAgdpzbIlC8psU+toIObqvh6fSf3F8r2X96/eWxtLE0BwqtiXdY7flWLFm5Y0YyrrzsrpwlFw1z
	wEUFOheRI3
X-Google-Smtp-Source: AGHT+IFI+ClLTh8e5PZwbJHazQxmDRFj0ZSGRbSblC0Z/GkqM10glV9hJcbfKBsbw2e3ySHwMKi/uQ==
X-Received: by 2002:a05:600c:3b19:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-4778fe5c5f9mr19412595e9.11.1763111215765;
        Fri, 14 Nov 2025 01:06:55 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b074sm8484141f8f.7.2025.11.14.01.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:06:55 -0800 (PST)
Message-ID: <5cd213e377dbf6ff0fb24f92cefd0e4283375d17.camel@gmail.com>
Subject: Re: [PATCH] iio: buffer: use dma_buf_unmap_attachment_unlocked()
 helper
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Liang Jie <buaajxlj@163.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>, "open list:IIO
 SUBSYSTEM AND DRIVERS"	 <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Cc: liangjie@lixiang.com, fanggeng@lixiang.com, yangchen11@lixiang.com
Date: Fri, 14 Nov 2025 09:07:33 +0000
In-Reply-To: <20251114084725.2079196-1-buaajxlj@163.com>
References: <20251114084725.2079196-1-buaajxlj@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 16:47 +0800, Liang Jie wrote:
> From: Liang Jie <liangjie@lixiang.com>
>=20
> Replace open-coded dma_resv_lock()/dma_resv_unlock() around
> dma_buf_unmap_attachment() in iio_buffer_dmabuf_release() with the
> dma_buf_unmap_attachment_unlocked() helper.
>=20
> This aligns with the standard DMA-BUF API, avoids duplicating
> locking logic and eases future maintenance. No functional change.
>=20
> Reviewed-by: fanggeng <fanggeng@lixiang.com>
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-buffer.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index a80f7cc25a27..58330abbf40a 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1563,9 +1563,7 @@ static void iio_buffer_dmabuf_release(struct kref *=
ref)
> =C2=A0	struct iio_buffer *buffer =3D priv->buffer;
> =C2=A0	struct dma_buf *dmabuf =3D attach->dmabuf;
> =C2=A0
> -	dma_resv_lock(dmabuf->resv, NULL);
> -	dma_buf_unmap_attachment(attach, priv->sgt, priv->dir);
> -	dma_resv_unlock(dmabuf->resv);
> +	dma_buf_unmap_attachment_unlocked(attach, priv->sgt, priv->dir);
> =C2=A0
> =C2=A0	buffer->access->detach_dmabuf(buffer, priv->block);
> =C2=A0

