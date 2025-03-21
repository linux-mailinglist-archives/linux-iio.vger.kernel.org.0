Return-Path: <linux-iio+bounces-17166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48265A6B615
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 09:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73A6189FCD9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289391EE7DF;
	Fri, 21 Mar 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5jimGfM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3B200B0;
	Fri, 21 Mar 2025 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546060; cv=none; b=bmlBk2D7CDWlgo07//Vrgej1BiP2hdKMOyKIjRUjMUjj/ExHYyEYI69U9qgdg7nha9+E++rGaVc+HngrCQ/lmP7Nh4RUibZfTl6Fuj12DScQ6Y2eJRsZcounVFMumHK+/BZH1rshy23MiqEikwwKV+pe0TiPN+ToeIUBtLSZHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546060; c=relaxed/simple;
	bh=XH25TSxJeIbYkdJcizSaqCRrErrT0Tg+slFQlHq2qkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7sLkLuUygNQuS17MaBhBTdMw6sjRWQPGuw1asbmqfcCSyIr4/jmy8/gIANWJfcf0NIxPjomLmCHBzYJNGh0kT1wy5UGuxviiQzN5vuyvmKGNQk3/i1FsUmGmI1MlfDnpAg+PnV5d58f3cfj+ZfnNFWEWTmeJyuzddPxNFRDdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5jimGfM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913cf69784so1359171f8f.1;
        Fri, 21 Mar 2025 01:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742546057; x=1743150857; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fcYNSB0t47gW922W6gqbVSX+TYjl+iLneTgJeaGGy1A=;
        b=S5jimGfMR8mxx663Degb4PCP0KjWASQgA1Hz4KaXYkfJc9nJ+E9kgVd7JQzCWw/75x
         QwnQr1GlOWvVGusy3+T3oym3R324T9Y7KEMTqO3v3YbG75aW9EPthXaOvqb1FsODl/36
         O3DJ+XqFGlSuIG+7KIkPa+n4ZOZmR5gOkpwi4b/G3NDjoLy4i3L6FwPKODphcEl66wDD
         PksU+mqt++jJ5lOhwflEh9XUYPSoCJ8vjLe174EEjCeNY8aiVluVwC6AAocurAezqkPc
         f+WhFnK/elV9nIUhN7ZgOzcOYpEgn3pgGZCE/XQ+ktcPFnf17oJW0H5bDMU6CnvS+qT1
         z36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742546057; x=1743150857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcYNSB0t47gW922W6gqbVSX+TYjl+iLneTgJeaGGy1A=;
        b=Zt1kxbzEhDS8bpl7evpBVAhXkzHYAV8mdgxHtoP7FGEsOl+wT6g8cjPJayZGlVd61g
         /gqpnQR2H9EAeCIxoifymWhLlJkdEMvhvvIchp0zPPjDVHBGKbxsNlmTrJRE402U8RP5
         H+di72UrUWfnQhTDQZ27hkSw5BqEfyVbMcBumorC2Epc7kBbWR6l7X3461LNW8+WTaf1
         KTG3pCiXDKlr3d9a5hjsX52WBmXAp8uRXeYXx2h3tt6ql8y6jrJ9rMu7HfipR0xRT0Nk
         Ql0ac/SqgmGFfbsaf+qoCHVfl8Qx4TQUxXRZlF6gbBmlsx6//9pQanW8sJdksNqTuLr1
         j9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVvDYBXsJ1Dxsyu2fKxYYMSs8WVmJYGlQIU+/LyClGA6/h9NVzGytHkTHJdV68o/LYjcBguRsZlpGXMWZEk@vger.kernel.org, AJvYcCWTt9pLZ05Qed2FlhbDJumUtCvx7zTC7TF4DDT1D35bOV6xVeQc7ZZRiJHYpkcuDI1s4Z2PSKalHKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbC8FDq8/M7WZPIWV1t7ytC0cBgYVdYelP/pMF7IpfhFiLgjl
	PM86RoLlpEFt9mJ0gjPxNCyCfxRkXxc1/RzWPlAvQEagQ+wz+YY0
X-Gm-Gg: ASbGncuBdS7pES7AQWEeseCPqozZg/fDqOY1cp/ppsGu4dTPQsfdFKB1MieCB8tj6aH
	TnRz6gbjCvf21LQiqIV85MI2PsQfaAF3mD8p+GNv3b2hVETy4hsbjboGtEDM7NFT0WSgBNAlY46
	FtesjI3dzc7li2vdSr5DS7pVYZxBP7QP9+F2kFaGZI4SaYElQ2ah0Z21xiHF4mUYeeiTsJtTH4x
	C4Os4q2uvtysEHXRL8gp9/lqDK5AEDjrXT0Y7HjJnqhUDLXY+yRTibkrEoYbk5ysEovPoaFscO8
	uEpMruvSZKXh80P2k6rVX2OGc3YkakYn0fW0Bpjifc+aC0dAZ/9dtEtkWgRcM4m1ouljMt0jfd0
	yp9FcL9WTqUerwZdCD1w=
X-Google-Smtp-Source: AGHT+IGMJkYoe1SC12xNZS8l5CpphWOtLUR1z7zxIbolsOA5/ZmEiT3GECxY5vBCziOdoX1rcTNNdQ==
X-Received: by 2002:a5d:588b:0:b0:399:737f:4de6 with SMTP id ffacd0b85a97d-3997f8f8c35mr2035085f8f.3.1742546057258;
        Fri, 21 Mar 2025 01:34:17 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f32fcdsm72414305e9.7.2025.03.21.01.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:34:16 -0700 (PDT)
Message-ID: <4bc1e6d47a33ffa49a3e4f8668b9d804bfcad10c.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7380: disable offload before using SPI bus
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org
Date: Fri, 21 Mar 2025 08:34:32 +0000
In-Reply-To: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>
References: 
	<20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-20 at 11:21 -0500, David Lechner wrote:
> Move disabling of the SPI offload before attempting to use the SPI bus
> to write a register in ad7380_offload_buffer_predisable().
>=20
> This caused a crash in the spi_engine_irq() interrupt handler due to
> being in an invalid state.
>=20
> Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 7 +++----
> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..a2b41980c942e4cd1575bfe4f3846e2=
97ad5d01d
> 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -1211,6 +1211,9 @@ static int ad7380_offload_buffer_predisable(struct =
iio_dev
> *indio_dev)
> =C2=A0	struct ad7380_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +	spi_unoptimize_message(&st->offload_msg);
> +
> =C2=A0	if (st->seq) {
> =C2=A0		ret =3D regmap_update_bits(st->regmap,
> =C2=A0					 AD7380_REG_ADDR_CONFIG1,
> @@ -1222,10 +1225,6 @@ static int ad7380_offload_buffer_predisable(struct=
 iio_dev
> *indio_dev)
> =C2=A0		st->seq =3D false;
> =C2=A0	}
> =C2=A0
> -	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> -
> -	spi_unoptimize_message(&st->offload_msg);
> -
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
>=20
> ---
> base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
> change-id: 20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-a801=
dcfb9c00
>=20
> Best regards,


