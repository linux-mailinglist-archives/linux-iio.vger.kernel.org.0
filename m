Return-Path: <linux-iio+bounces-26728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F02ACA36D0
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 12:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91516300D8FA
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73533EB15;
	Thu,  4 Dec 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrkzkOP+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5D33EB10
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847475; cv=none; b=d6QVvgzRVbWCIh+F7EXpEdZfEnnMgijf7FKoBDZcWWVmGCc2qthJWFWRLqGVWbPvHp8RTnESgrc46ezMM+69Qv3NwAnghjIyRSCn7WpwkImDSSbhrn/bQHKLI+Oqdx5fyBCnypmmwqUzrbUnbaJGGh1rtfyfh9iijqd9gOYpFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847475; c=relaxed/simple;
	bh=NH5gE8Ndk3TwErT/rG1HuBv7sWfd8MhpxgEZMMH+Quc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ff1tBM+ULwZiKU7g6J3kYVDLUpxCuB7WNh8XRoUeGxbgjnbiPSzb/yBdrAFK5elfqMc434NANrbk4QAscteQcwjdtLPPArUxSxhi5049tKFyY37sLY93jLO2NnjxwXEt3WmRr5kLLz6fsbjDe5soOiW7+MnkK0UNd137N+uw9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrkzkOP+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2e239ec0so571206f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 03:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764847472; x=1765452272; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wypQGdn5H+5kjaeZkD663jT2abr6XmzSQ5E2XOZo8Gs=;
        b=YrkzkOP+3PoZfg0MQLrdkmhC479wYRqmlYjONUXIvCdsq47jjmRRircNvQ+Q//2MuU
         0AY9ezhj02YAuX1ZlVqjY+5mdZq27ha0RueEiVSSarT0aqB8IPXRjnLm+1DOChqD4mgB
         /zwwTuKlLM0fyHnOE9i+jXHhCFAgZLbCDrKjxDYg5qvNE40qF2xQtwDGZIzybr04JzOj
         Lj4ZHKwBSUJHotUrpcHJzkU/aB9fxdxGgpotfy53OQtpLJ5I9DB17Tj8DmlZqpMW7D/k
         CDJYISPVJiu1L4zOP56RMSpmegbfZ0cf7vNDnoZSH2+hUvSjp4e36E2IwkcQjiLDWa30
         pOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764847472; x=1765452272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wypQGdn5H+5kjaeZkD663jT2abr6XmzSQ5E2XOZo8Gs=;
        b=k1gj93s/FKACjG1MVqcWJyNVlDcgUU8u9KWC6faqeGpePek3MNxz1ww7LfFOm0uQcf
         UqH0zWLWtsr4JsI2bw71BZdHT8wC7zxqOgqFpyPJWKUpsObCZw+Fmic8newUgZwKvvF1
         Rw3sPGbwDplmzyU2Qoxg6QMA2Ps9fxxS7m+UsAO1BfI0D2IGERMSvPFz3jSYjeR8NPJq
         6pi6pTKTIl9TIlFpRwD9m3nM7Z9xkvgJkvfdcxj28mTTuDyYaRbCaw/4E1mhgK1kCLWl
         8dfrVS06RRjgqMYa2Kc2ZPoaBq3i7PZZpCWAikZSoEQb5mfl5B5eAjnZeehdNXLjC8YK
         txeg==
X-Gm-Message-State: AOJu0YwzXlA64Eu3Ta2GA5ZkPN9xA1UrnG+vsmCQnf59GFCVxVziNlZr
	QeceepsKBRL2qN0169l1ZOOl3HOMigt+fqoYmiWEC/kWEhVtan694xDk
X-Gm-Gg: ASbGncvauKuVXL6EQBQZYVgiq0LgtLaJYB7mbk93aJ4SDbCHCX6DQaC0Lcq/7aykCfl
	AkQ4RJ83XrMXicmU4kzywfBpnZkDYY29+g7cl1e54gB5NEDPuHzA9NUmDx9zNDoxrSJuQKci1bx
	OH8Q0m64DcW8Fgo4ixX6PNN32LmXGIOZDKmDW4KV5/E7dk8bgQwWJ8vwz/A8E7YFFRRNcYAXZ7u
	r/VW/8A2BwJatbPGjA4XWfyOPcZTsqLle6nJyrY/1YHWuCPzPxt31mBIFJBT9PbClR7iQYb0GP1
	IGMjZk5kuXOogwGOQtVx8w6IGs5VBhp86qKecibZ2ZVr3fcOfL2bSAXSSQpNCMxU2O0SXrPQCzv
	E7VhHkPNBTg4bZRtSAEl+BJAwHpJt7g1p2Z2mv2H5WTkOSOFPT0lYTIJhe3iWqH7jlJxU99FLlr
	SNYraDMMQdiJ4dpMsiWcs=
X-Google-Smtp-Source: AGHT+IHESwAdCER78uO8Lgwx/GXnEYyUU+519Fj2iZNtB92XTPhQ8RqBg1Epir6nMtOONvD6jDy/uA==
X-Received: by 2002:a05:6000:4383:b0:429:d350:802d with SMTP id ffacd0b85a97d-42f731a30e3mr6030403f8f.45.1764847471710;
        Thu, 04 Dec 2025 03:24:31 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331092sm2670073f8f.30.2025.12.04.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 03:24:31 -0800 (PST)
Message-ID: <0824e2b0d4c29de9f4bba37dbf60dbba97bcd789.camel@gmail.com>
Subject: Re: [PATCH 4/6] iio: buffer-dma: Fix coding style complains
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 04 Dec 2025 11:25:12 +0000
In-Reply-To: <aTBlg2rW0rrjHh73@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
	 <20251203-iio-dmabuf-improvs-v1-4-0e4907ce7322@analog.com>
	 <aTBlg2rW0rrjHh73@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 18:29 +0200, Andy Shevchenko wrote:
> On Wed, Dec 03, 2025 at 03:11:39PM +0000, Nuno S=C3=A1 via B4 Relay wrote=
:
>=20
> > Just making sure checkpatch is happy. No functional change intended.
>=20
> ...
>=20
> > -static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
> > -	struct iio_dma_buffer_queue *queue, size_t size, bool fileio)
> > +static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(struct =
iio_dma_buffer_queue
> > *queue,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t size,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool fileio)
>=20
> What about 80 rule?
>=20

This falls in the bucket where readability is hurt. At least IMHO, so that'=
s why I
did it this way. If Jonathan disagrees, I'll of course change it to the bel=
ow style.


> static struct iio_dma_buffer_block *
> iio_dma_buffer_alloc_block(struct iio_dma_buffer_queue *queue, size_t siz=
e,
> 			=C2=A0=C2=A0 bool fileio)
>=20
> (And personally I think that in 2025 we should grow up and forget about t=
his
> =C2=A0and move on to 100, but... not a maintainer here :-)

FWIW, Agreed! (And that is what I do for all the out of tree stuff :))

- Nuno S=C3=A1




