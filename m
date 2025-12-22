Return-Path: <linux-iio+bounces-27315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 002EFCD6019
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 13:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C33530024AA
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4954C29D277;
	Mon, 22 Dec 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbA3fQ0t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708BE29B8D9
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407167; cv=none; b=icsmQAfVWFDwL+DE0LGaVoYbfFYEd5E43V5IHRSnZtk4k93G+MgZAlvpHMkK8DL9X1RncklPYaKYz7VrwJB75lUbUdsiq0T23jl1QtyTrZ9axkLXxMLin8awz0Xu95mn2eacoeg+ZJbevDjQK5KxC0HuR+wtle/OXRFyzQvgib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407167; c=relaxed/simple;
	bh=lCTfbVIKBYmBlRDvI+Gepn6oas7Thlve+lSt0f5hRnA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdP9w/ld/aeEUIUYoK+lJy4zc8Sp/LItUK7IjW+PlCPCasAxRIytAieUdZ9C11hH8G1qo8Iecp/QyYIzipXNAfEfx4T7u5V6mIi3uU7H4QGdEDn47C+J9q430XER0Mek/3vFuo8yOakt3bvDA+wsw7gSjVS99thHEI6b1RaJUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbA3fQ0t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbc305552so3217352f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 04:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766407164; x=1767011964; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HZZF8cnIkvjCePJr8wZmRknRokkqyFBW6WivQao5Fh0=;
        b=FbA3fQ0tOmoQcY8Wjje+jiySii/5x0eoNZiZMpl0ofMjuEAs7pn6JFZjFPw4F/El0O
         LwLq9Ugw1K/HhKHa+M5BiNOTJZ8QTqCv8iy/vCaq7PGrtH2925WaMDQWMp2Nfwx7z6A8
         TmgZD2RCMUK9NGQVp5YxubsI5aNSXcM5CmVezXcMZDwamyyZdLwt4mbO/xg7d+urT/hR
         ef161q/APK59A+49UePP/2RlJolM9E4BKq/KDpgE2BqI5dF7ca+wrh4jEiimhEprGAY+
         AuurLh1DoVrPqAK9gLNnl0wlaFoiU+l27vF5Ouw1HArvnCCgXwet3gFr2L3/d1i3gdkE
         hgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766407164; x=1767011964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZZF8cnIkvjCePJr8wZmRknRokkqyFBW6WivQao5Fh0=;
        b=Zv0KJm5Q9ojnj2kxAtxNy1TKHJgyc9HsVh7wySkCgcOzORmu88koP/102+UK1StD9b
         6rDOGEgzF43f/CGdtz/RYasuGFqasE48hjRLkBtUU1zTMtv7aLOtpfkEegNRDfMqZqsB
         TEvIoYgI3JLLi84p7vTUvygpuvjKl/eak6N9EDUqR+y6HipMqEVWV5L+PjlDWqo7pVRr
         H9h+rtHuNoidqqVfH6pFxPm1hs7hYNobHoMohjoX4HDyWzsczMbchA6iV0MAjK25n9a7
         VNUUdYbn/OoFyTlwlwU0TOtLqFJ9mPzd/OsByFE1XMIW/WxZ4wllcxUzL0vtD+Yt4FlY
         WTsA==
X-Forwarded-Encrypted: i=1; AJvYcCWxOd8KVSbxBpps5o/en4riPlMigJCSw7QZDPuP6n8HUip17HHjAHNW2IrYo/dsf9DqGmpHrAeKmF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2hzUL1MU6w1RboWjPBAJErQWMsoi3rGOI+Zs4DNlm2WJgSUl
	qilJuGf4itJDtlljG0tA4vpD0sLExesHN6N8PEfIM6oAbw9oAIUfl98P
X-Gm-Gg: AY/fxX5bF4Xs5M3/P40BGcF7pqWESPWqrXynxprb3DpiJQrGv931+fDTL+Dt5rc7XKF
	guOaHxwQCZqW8KbH9EiCtFZf0ilb5nhc4cG1wL9crA2/6sit8EA4q5GB+R7vkc8jIk43kAlrQdI
	lp9ZMBS5smxqFg5JxLoZXtA783Ot1Aowh+cB4r9DjsJL8hICMysn5GryReUEGF9o4oJa8/PtWzB
	hipFFapB63Vqg1cVOmSbbtILeqJ3qkmlov6xWgTJvhHaQc7RranyIXfrnBXzn2QKfMkNo3jpNrY
	sqnxd2J8BwrRGduHUC3ZRFqQAwNYkgmlFwserWg565gnO2/oIqDXldBCErkLfX0GkwLJ2vLuYYv
	ohDcbz9YqiyRwOPMl76w4sxJCgww6c/AzKSkpOAY8Ucrtr+seeNq4hjpBt53C+/j9FbLZZV7FXC
	MmKnHcfPJ15WOa5Wfwt14=
X-Google-Smtp-Source: AGHT+IF383xFD5VK6ZTmIBHS/tlmdtVD5oLqaAb0ub0WjH/rkLOten1DLzhngHvGr1x1+YWeZLZERA==
X-Received: by 2002:a05:6000:2308:b0:430:ff0c:35f9 with SMTP id ffacd0b85a97d-4324e50d989mr10927368f8f.48.1766407163616;
        Mon, 22 Dec 2025 04:39:23 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm21462271f8f.0.2025.12.22.04.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 04:39:23 -0800 (PST)
Message-ID: <b90ba28d594e1d710274a9097bfde9aff4b6b5a5.camel@gmail.com>
Subject: Re: [PATCH v2 5/6] iio: buffer-dmaengine: Use the cleanup.h API
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= via B4
 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Mon, 22 Dec 2025 12:40:04 +0000
In-Reply-To: <20251221120141.02d01840@jic23-huawei>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
		<20251219-iio-dmabuf-improvs-v2-5-caa76de6e873@analog.com>
	 <20251221120141.02d01840@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-12-21 at 12:01 +0000, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 15:28:16 +0000
> Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make use of the cleanup.h API for locks in order to simplify some code
> > paths.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Needs cleanup.h for scoped_guard() definition.
>=20
> I'm not seeing this as a significant simplification but this driver is
> your problems so fair enough.

Mostly for being consistent and the minimal improvement of not needing the =
local flags variable.

>=20
> So applied with the header include added.

Thanks!

- Nuno S=C3=A1

> Jonathan
>=20
>=20
>=20
> > ---
> > =C2=A0drivers/iio/buffer/industrialio-buffer-dmaengine.c | 11 ++++-----=
--
> > =C2=A01 file changed, 4 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > index e9d9a7d39fe1..a8a4adb5ed3a 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -49,11 +49,9 @@ static void iio_dmaengine_buffer_block_done(void *da=
ta,
> > =C2=A0		const struct dmaengine_result *result)
> > =C2=A0{
> > =C2=A0	struct iio_dma_buffer_block *block =3D data;
> > -	unsigned long flags;
> > =C2=A0
> > -	spin_lock_irqsave(&block->queue->list_lock, flags);
> > -	list_del(&block->head);
> > -	spin_unlock_irqrestore(&block->queue->list_lock, flags);
> > +	scoped_guard(spinlock_irqsave, &block->queue->list_lock)
> > +		list_del(&block->head);
> > =C2=A0	block->bytes_used -=3D result->residue;
> > =C2=A0	iio_dma_buffer_block_done(block);
> > =C2=A0}
> > @@ -131,9 +129,8 @@ static int iio_dmaengine_buffer_submit_block(struct=
 iio_dma_buffer_queue
> > *queue,
> > =C2=A0	if (dma_submit_error(cookie))
> > =C2=A0		return dma_submit_error(cookie);
> > =C2=A0
> > -	spin_lock_irq(&dmaengine_buffer->queue.list_lock);
> > -	list_add_tail(&block->head, &dmaengine_buffer->active);
> > -	spin_unlock_irq(&dmaengine_buffer->queue.list_lock);
> > +	scoped_guard(spinlock_irq, &dmaengine_buffer->queue.list_lock)
> > +		list_add_tail(&block->head, &dmaengine_buffer->active);
> > =C2=A0
> > =C2=A0	dma_async_issue_pending(dmaengine_buffer->chan);
> > =C2=A0
> >=20

