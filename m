Return-Path: <linux-iio+bounces-19231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE302AAD858
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A44E2F5F
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531F22069A;
	Wed,  7 May 2025 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m794G3VT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945A2144CF;
	Wed,  7 May 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603529; cv=none; b=UiN1SOdkhu/Yub8nCtX3MnV3GARlLPa1CgG1aTWGYKWc41DyDgpiSq2wL4YGgg9Lmo9S8wFUI64y1mmQIuMHayc9QAnijwASjWUUmvw0Gsy6zze05oea6gZjQMjgQ3BABRKuGup1GYUS+3XaKGu41v2sZtgE0wIhk5GOn3P4gVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603529; c=relaxed/simple;
	bh=LUbeHMzIFsOzUSMB2htO29hpRr03KwAvpfp2sAuDens=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaZ88yI1Lkyb01lMMjLBDyCWOYhEdn9NVRcxLwR17nA6FI2d6SOtQXq5gN55MfnKwrUGff/Vq7CM383hD+/y5zy2vQ06UrUCG1AGOTyxaXuA+JanEkjBKMPe3TB/E/l657I72wrRAGjrKG441bsi+ozcxOQtDLo6SzBMCbQdxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m794G3VT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b6aa08e5so106601f8f.1;
        Wed, 07 May 2025 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746603524; x=1747208324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LUbeHMzIFsOzUSMB2htO29hpRr03KwAvpfp2sAuDens=;
        b=m794G3VTeuhMlKp8TdId3looqhtQiyGgYcAx5KjDR3+jxVx5fqHJxM4frZT9SXULq9
         n05Q0+/GAAoQEPu/GnImg4eF3jGy3n4oCr77MZAvp+F7DdyNzw1lk4fh9PLX4fBGG0ki
         NmCg4qVOMlPFBzZjscxd/LPdkJN1kbUNHDuBcBcv5IHzaWHBDZdKpyVNZ4qteEYCQXDm
         py3p0AFSiGBSToDOk+Ews7cMrzYSXgDHeEoUnyjHSvVYKT2rql1txA/xNVbfLBiXRdoy
         yZt09FBi4Dw98Mh1MQaW76u+im9SZUC2KpcenqaBYsezBbwO/WiCSu0/KYpVNSeh1Ytn
         WHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746603524; x=1747208324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUbeHMzIFsOzUSMB2htO29hpRr03KwAvpfp2sAuDens=;
        b=rMOXXrjSZQ7OgVQAuIQRuK4B9SSwEdn1djeHvU9wS3mJ+OC3KiAZg5ZBt2YP/zolYj
         bFPL4rvI+u5YrxhbaXrG6bUnHUWiEOzge19ori/81/s9Nt7yg/l4BMlKEGVwfhU4mclY
         jveUug+9aXiR0doPNKGqXOtutfw58dtZSpgNkoKWBwkT23sO1MRpAZkVt4M+D+ahSJl2
         T5bP/uhXOOgj2d782yZ3EXmpUogSy1t2UbA2VI+DHnh1gbRpltCDkE8O03ahzwhUX6va
         NrKpoAj7Q2Rb1FgzR5HYPDiy/H8mTJfftOffSAtc73dP1nJQkfqP0TlMQKYNZIuDieHe
         6ujg==
X-Forwarded-Encrypted: i=1; AJvYcCVIVniUtIduXOhzNeK9SbOKZ0KXbq6i+fA1PqRJJKiDUkWA6zfw2qFY92qh9T0xAqMONhqmtLcX30WIbB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiM6S0qiqFTrr+GV3Q/sineoL/ntdYTZrMDxw9YQhOCXhXp1kj
	Gp57ZfIHH6jMl0dvwn/u0mEoK3hWH0XeSrU26gRPTmAOxXCUb3qR
X-Gm-Gg: ASbGnctrbxZdo8QsymSM9ld2CrCqo7wp8LTbxr1A0CyNZxmj3tBVMmFE9QocssCq06U
	5h3pjgO5QcaxZsfCGF37ehWqzHIoPOZjePYWOKYAReumMCKXKNP+OFAM/f5TiloeCGmUPZvqinS
	SjYg9oaR3v5uuL3DtfsCd1oB/GXHUkxqBrN/7KMCTilaK+ifCGtSEUeSSuc6OlRTrqVTy09tjDc
	sUcYb7YkIWq6qsh/0xBG3l1Twise1dHFkXAA1mvfkgJhhmFspMRQ4UP+7EKfDaF70hlEEjXwNrk
	PFy+lQj29WG7iJ1uGeKSk7LrFugXnROFhQ0pVOrX7i4r5PtIlsgfmoItuAia+LdfQP8jQRNZmog
	hUer6jceir97TXgc=
X-Google-Smtp-Source: AGHT+IFcrfJVgjIHTQQ2WPmB67RGJPQ8xi7u9h/v5miFvmeP2RpN+ZcyLqGtFi9WsQS7CkgsL5VSLw==
X-Received: by 2002:a5d:64ad:0:b0:39e:cbca:74cf with SMTP id ffacd0b85a97d-3a0b53a06bfmr1636435f8f.6.1746603523625;
        Wed, 07 May 2025 00:38:43 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17748sm15851404f8f.100.2025.05.07.00.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:38:43 -0700 (PDT)
Message-ID: <ec7c00c640b0b359bfd98d460d067aee64ca069f.camel@gmail.com>
Subject: Re: [PATCH v5 0/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 07 May 2025 07:39:07 +0100
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
References: 
	<20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 11:31 -0500, David Lechner wrote:
> Creating a buffer of the proper size and correct alignment for use with
> iio_push_to_buffers_with_ts() is commonly used and not easy to get
> right (as seen by a number of recent fixes on the mailing list).
>=20
> In general, we prefer to use this pattern for creating such buffers:
>=20
> struct {
> =C2=A0=C2=A0=C2=A0 u16 data[2];
> =C2=A0=C2=A0=C2=A0 aligned_s64 timestamp;
> } buffer;
>=20
> However, there are many cases where a driver may have a large number of
> channels that can be optionally enabled or disabled in a scan or the
> driver might support a range of chips that have different numbers of
> channels or different storage sizes for the data. In these cases, the
> timestamp may not always be at the same place relative to the data. To
> handle these, we allocate a buffer large enough for the largest possible
> case and don't care exactly where the timestamp ends up in the buffer.
>=20
> For these cases, we propose to introduce new macros to make it easier
> it easier for both the authors to get it right and for readers of the
> code to not have to do all of the math to verify that it is correct.
>=20
> I have just included a few examples of drivers that can make use of this
> new macro, but there are dozens more.
>=20
> ---

LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v5:
> - Add new patch to set minimum alignment to 8 for IIO_DMA_MINALIGN.
> - Adjust IIO_DECLARE_DMA_BUFFER_WITH_TS() macro for above change.
> - Drop one ad4695 patch that was already applied.
> - Link to v4:
> https://lore.kernel.org/r/20250428-iio-introduce-iio_declare_buffer_with_=
ts-v4-0-6f7f6126f1cb@baylibre.com
>=20
> Changes in v4:
> - Dropped static_assert()s from the first patch.
> - Handle case when IIO_DMA_MINALIGN < sizeof(timestamp).
> - Added one more patch for ad4695 to rename a confusing macro.
> - Link to v3:
> https://lore.kernel.org/r/20250425-iio-introduce-iio_declare_buffer_with_=
ts-v3-0-f12df1bff248@baylibre.com
>=20
> Changes in v3:
> - Fixed a few mistakes, style issues and incorporate other feedback (see
> =C2=A0 individual commit message changelogs for details).
> - Link to v2:
> https://lore.kernel.org/r/20250422-iio-introduce-iio_declare_buffer_with_=
ts-v2-0-3fd36475c706@baylibre.com
>=20
> Changes in v2:
> - Add 2nd macro for case where we need DMA alignment.
> - Add new patch for ad4695 to convert buffer from u8 to u16 before
> =C2=A0 making use of the new macro.
> - Drop the bmp280 patch since it was determined to have a better
> =C2=A0 alternative not using these macros.
> - Add a few more examples to show the non-DMA case, both in a struct and
> =C2=A0 stack allocated.
> - Link to v1:
> https://lore.kernel.org/r/20250418-iio-introduce-iio_declare_buffer_with_=
ts-v1-0-ee0c62a33a0f@baylibre.com
>=20
> ---
> David Lechner (7):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: make IIO_DMA_MINALIGN minimum of 8 by=
tes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: introduce IIO_DECLARE_BUFFER_WITH_TS =
macros
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4695: use IIO_DECLARE_DMA_BUFF=
ER_WITH_TS
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4695: rename AD4695_MAX_VIN_CH=
ANNELS
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7380: use IIO_DECLARE_DMA_BUFF=
ER_WITH_TS
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: accel: sca3300: use IIO_DECLARE_BUFFE=
R_WITH_TS
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: at91-sama5d2: use IIO_DECLARE_BU=
FFER_WITH_TS
>=20
> =C2=A0drivers/iio/accel/sca3300.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 18 ++--------------
> =C2=A0drivers/iio/adc/ad4695.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 11 +++++-----
> =C2=A0drivers/iio/adc/ad7380.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> =C2=A0drivers/iio/adc/at91-sama5d2_adc.c | 13 ++----------
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 42 ++++++++++++++++++++++++++++++++++++++
> =C2=A05 files changed, 52 insertions(+), 35 deletions(-)
> ---
> base-commit: 7e9a82ab5b861d3c33c99a22c1245a5b262ee502
> change-id: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6
>=20
> Best regards,


