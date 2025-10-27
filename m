Return-Path: <linux-iio+bounces-25499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A998C0F352
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 17:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342C3564942
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66D72877D2;
	Mon, 27 Oct 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsMdE0O6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2830CD91
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581080; cv=none; b=P9Ig1WJLyG7s2RAEWjYTXKv5XlUNDV/FO/iJUsC3jqvCuacYMvJaqIEKwpSVTUjYHOso3oaPidqXPul9OQJtRzsnmCUQJp8xEPKQfjPoyqVkKfItTYE3OC7dmp76lc0SwjRLfgtpyq6ojzgiO0MkW3LrSiYUXJTB7E/qWUgB/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581080; c=relaxed/simple;
	bh=2063pxklqusQxNqj6V9Nfgba5zH13grbuHqPROtkanQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P15lUal26aqmZJRPKn29RtQuXQYe2ujFMg7RkMbi3M52tGsNVoIV/q2DQne1WLjMJJMKLVccHUJV0MOKv3oOXz1CRLjwHdyFGUvUqXPrIx7YEV9O3sLi/1AdvPRA6FXQcIkfibZXOyh6sXbaLws7u+TKQKV9M7d48V+3Nd8QDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsMdE0O6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711b95226dso60533955e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761581077; x=1762185877; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vg3OblHUFTR5cgBEbwg1qfvtW4LF0GYw01JmGM+cw2g=;
        b=RsMdE0O6aZjQnfFSjEuA1wyj2NmIl8Ts0i5dL9tFOwWDKpOOnEIk8zP5Gjo3c/5jTX
         00feD9igIMWQb/u3cE3wGvtIELjgU6fiFf48O2ek7IKvB20fFmeKvvtJPSTn2X6V7qhr
         oRWmXFXWyZdUmpRgeEgQXZJo4U6srcaQUhs01UQz1kt1TMVVJIGSauCOeQ0B7DBSzry+
         AtYv8iwue0vyOxaoMupAuAQ5et3VduAkJQ59yk3iYTbo5+4779h6y0+QWPi+hW2I5sZO
         TLnEKANCi3IX8YkJIlGH8G2dSjpQaReA/K+KO15Ql/PypL1POOq6MX0Gyvco31KF7P7m
         /f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581077; x=1762185877;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vg3OblHUFTR5cgBEbwg1qfvtW4LF0GYw01JmGM+cw2g=;
        b=O5Sb9UeSm2BEimgaTeWgzj7vUAFWFPlzPaiiWT/kDr4rbI7Hd+BfZvm7tDFhen6EiP
         2z4TfvpamHnTiKVayj9pltLfFX/eMjFMQmRrKSA1DxdTaG+Z5N6zb6A00V+7qY0YbcjV
         bs8MOlK9Y1z8KwQtvYEiYrjH0vxvt7CjiQifNx5bc4XXG0a1zoH7GqDNNkGiKN9AtLWx
         Eh7DPDUKme1W1hxeRwpO+y8TsNv5xlOV3VIF7vVXQg6dvUtSTZMu8X5H5vwACOPC9nMz
         zNr5Ecfcz2cQRvJaHVtOxWrEoOP+V0zEDLpQOVWyKPu7q+ouXTFvY7Z9l1tBEeFt+iXm
         nvqA==
X-Forwarded-Encrypted: i=1; AJvYcCVyhTG0XFChiXO6GKb7ZU0kdY4Im+CGuePNaQ7XuaR6zHWd34HWCBa5VMmB1ZyaSoxzF3B+bMWhUI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuI/d7Z47tSrF6ewG2/r9Tfmpn/wosGzDmS6hZVJKidIoxTS8
	TdkR0a7+e/HSb3X9Hyq3vbS4rzd4Oln/dluajYXyUd61vkL+/c+Naonn
X-Gm-Gg: ASbGncuxps5F1nuZAcruOdomhntCx5U62YAArTAQtf+Tdv6FUKU3kgOi5bhKWxm1iBu
	mRb/RT6PWy1FeMZ44LD4WKMzCABBgOGcTg2WWt4gAIQruBn+O18ZnHIFmNj78jolh76xnKXkP9+
	lfzP6K37c87Zitw7mBLnFqI4n0JySA1KaNVxgvlH5oD7T06dfOuOOfre0TezgunyoDNzKgvrhRo
	yJIqMK+iDfbqvucHFKLQ1Z10ciQJK8bj4oxoyPRRDVWxR+aN2LmfRK7kLeBMgZ2qyVIkWj7yzZn
	1d9p3EKeyxzbxv2ycB5qr9pP04hX++EqBAx475roeCbOghTfSVDE0KAYiQLlpTAHj1y2dgWIIfM
	euYy9siPU1dWREOHxueZcoczDZlW/Lu+/7OdMBCS1z6XKBIQYRV6EdJaNbHIU+vQTht0yro3NMu
	vQY30TKIXnG4l05FoAtps=
X-Google-Smtp-Source: AGHT+IEytXao2mgX8yrfl9oB4UaAMNKRdCeCXGPN2ypjlDiGpr6ck1lmJGhadthbosUq0yKGoSRQOw==
X-Received: by 2002:a05:600c:46ca:b0:471:3b6:f2d with SMTP id 5b1f17b1804b1-47717e7a668mr1065825e9.38.1761581076812;
        Mon, 27 Oct 2025 09:04:36 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cbc6sm147055475e9.1.2025.10.27.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:04:36 -0700 (PDT)
Message-ID: <42e7a6644812626d7c1a58eb51bc7418ff31c0c4.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Miaoqian Lin <linmq006@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
  Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Mon, 27 Oct 2025 16:05:11 +0000
In-Reply-To: <20251027150713.59067-1-linmq006@gmail.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 23:07 +0800, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer, which may be less than the requested
> 'count' if the buffer size is insufficient. However, the current code
> incorrectly uses 'count' as the index for null termination instead of
> the actual bytes copied, leading to out-of-bound write.
>=20
> Add a check for the count and use the return value as the index.
>=20
> Found via static analysis. This is similar to the
> commit da9374819eb3 ("iio: backend: fix out-of-bound write")
>=20
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-hs.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 41b96b48ba98..a9578afa7015 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -549,12 +549,15 @@ static ssize_t ad3552r_hs_write_data_source(struct =
file
> *f,
> =C2=A0
> =C2=A0	guard(mutex)(&st->lock);
> =C2=A0
> +	if (count >=3D sizeof(buf))
> +		return -ENOSPC;
> +
> =C2=A0	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf=
,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 count);
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> -	buf[count] =3D '\0';
> +	buf[ret] =3D '\0';
> =C2=A0
> =C2=A0	ret =3D match_string(dbgfs_attr_source, ARRAY_SIZE(dbgfs_attr_sour=
ce),
> =C2=A0			=C2=A0=C2=A0 buf);

