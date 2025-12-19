Return-Path: <linux-iio+bounces-27207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32995CD0605
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1519A30A2998
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B833A032;
	Fri, 19 Dec 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYKEpf1o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B033A013
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155544; cv=none; b=bxo6Fk5ZgQ2zgO3/j/6ygvWwgULNkCy8qBV0oSVb9nMPfehEdVjyC4xjzu8lWcEyMgYKFS5GeCXXx+KBcAK2WECQC747iJjcDyC3viBYAoM9D+F6GzY/eipqKL/ZOwD28vKe8YQIKA+rvj2xL7WeBFemJ44mjMH+K+kgznJT6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155544; c=relaxed/simple;
	bh=0ED9b1vBXcUM/wufkmBFTxQAaOBzOuTk/rxQ6+xOxAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YnAvv6g/IJnEn/LAOsq/DVQ/E/nlSOoIC36RAbAulqtjDC99IrLrMYDDZAJc/iWsu6q4x10qdgfydFGGZXTPKCVwDBPU1TaMxacbpM/JcAi8k4fH/JU+pxesfgq45V0Z63HOXxVV62vUB+DfOJ5lUHAaV+vAtC3jMr/g14gtw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYKEpf1o; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso7664445e9.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 06:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766155540; x=1766760340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bBrb5/2asiO+xAwBsYh2X2OwJ8WzDyacND+6TSxABek=;
        b=fYKEpf1oDTThHEPN6+Bjetg1MbZhK6YO6Xvu16tTYHbKq/D8Y+onqqoogAneG3itlB
         uXSOUu/FFc4k1rK/BcjhnQMSqlT9naeRqzhi187l7ucLR4ftzG/G3E87cZ0ZVKO+gLyv
         EH5XmjnfdoBagB5Qw74R13Sxk736ftULyjiskpaaB+8P05FPS34Olewu0JOKVJqr0UUc
         Byo/+CoxgwoZFttnuDiQt60pC63WHM05QJXIKKeGRIiMSddnBwivfclHIecvLsoIzYhC
         HttD4CUmzhtyEvtyQr11NVQUBBIgpap2RNXemYOe1eYEk7B6qmQmmE6PiERYgpy4v3aE
         VwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155540; x=1766760340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBrb5/2asiO+xAwBsYh2X2OwJ8WzDyacND+6TSxABek=;
        b=eSR7dVcumX7E3LPeEexviASkuSTSQd7rJuby8/rei8T4n/C3Hd8DOTkmdyruKU5Tm2
         NdgAp4qbayj0J8+GUjSfuaKLt7PI+4PXmwcs4Ny02l5bnWMtDhTIGtjeMKlUZl5crHHr
         apDP0gMD0zHlwMAMMR527CO171ITNYs1gwVnRfLVCnWMlRn5JNUAz2byP6fc6p55GKTv
         UDR8RVqwFlBlgDNifCftvLPQw1OIA6DJZXT64HvrZg/o+1fcCpOjZ2K43VX4fqXhfzDi
         Yjj6a6KLJI3D3KhdWZHG46PGjDR+gLpFXqG2AainzC1kP7rGB/bzroUBK3ek+myCnE00
         cKIA==
X-Gm-Message-State: AOJu0Ywx5Sa/68coQe6+/fjSlu/r1XNq4ckP3brc2UciAQcWvROrjqlV
	Fm5/VMf3C4hAczxSRWHWQzIjnyQWAGAvflm4A86QkwGCyczrr1AdVy/O
X-Gm-Gg: AY/fxX7ORfTFXJhW9nDkvbIMJWnvHHXF0ky9XTyINGg6uykCspZVwkMr0wrozs5fQAq
	diY+BVUeROiVB01f44tzY43bN1i9I5Pyci+XKEhpW5vqL9tzIf/78CGssMcBAqNUzrBbmOEczzw
	Z4aR3Xq7WKjiPwyTXSILKpoNnmtMGL1F44Chet/W5Jp1250uP006WS+YWvd3oWv9KGymdrqUfHa
	Z76tg2RhFPnzE6Fd4X2jnXc5VobTAGek8MPq6mAIFCmSR7Uoo5RIfzAw1mQ+JG5R3nUuMUV6l4/
	zt4gIHJ6N3KKWBP/RdO0cXjgEaXfRbA3pOSVBIZvlBLUNWB2WDVVIsn0FXxxQhXPfoKyo3PPDVn
	+I2KR92xXTfU9uBc1HUgbfSsDu2ep7qlZMrUEHD7xjuuV+xSGyiJ5d7AJ3NcDH3fzdLuk48OJOs
	nFviEcmujpUMILaX7Zaj0=
X-Google-Smtp-Source: AGHT+IHKUy36Sx6/ExOq5gSuVJgdUyBG4b2jjTB/QWNUpTi+b8Y8pC0yozUwEOblhw5gaelW6BZqbQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:a21c:2066 with SMTP id 5b1f17b1804b1-47d19532f48mr29879215e9.5.1766155539477;
        Fri, 19 Dec 2025 06:45:39 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be26a81b6sm101968425e9.0.2025.12.19.06.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:45:39 -0800 (PST)
Message-ID: <2c61d7f3e169ee5204f795784a686e46613b7aa8.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 19 Dec 2025 14:46:20 +0000
In-Reply-To: <e095bc11-9986-40bb-8ad2-967ee85f67e9@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	 <88efd2784c9fce72e432a59a03472bb4441e975b.camel@gmail.com>
	 <e095bc11-9986-40bb-8ad2-967ee85f67e9@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-19 at 13:16 +0200, Tomas Melin wrote:
>=20
> On 18/12/2025 15:49, Nuno S=C3=A1 wrote:
> > On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
> > > Not all users can or want to use the device with an iio-backend.
> > > For these users, let the driver work in standalone mode, not coupled
> > > to the backend or the services it provides.
> > >=20
> > > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad9467.c | 37 +++++++++++++++++++++++++--------=
----
> > > =C2=A01 file changed, 25 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index 60fc3361b2689a4c38287c613ef93fe00338e5fa..37b8f88da6681d44f3fbb=
b6c8c171ae7117b9090
> > > 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c
> > > @@ -1000,6 +1000,9 @@ static int ad9467_update_scan_mode(struct iio_d=
ev *indio_dev,
> > > =C2=A0	unsigned int c;
> > > =C2=A0	int ret;
> > > =C2=A0
> > > +	if (!st->back)
> > > +		return -EOPNOTSUPP;
> > > +
> >=20
> > Let's not add the buffering interface if we can't control it.
> > Having it just to return error does not make sense to me. This means ye=
t another info:
> >=20
> > https://elixir.bootlin.com/linux/v6.18.1/source/drivers/iio/adc/ad9467.=
c#L916
> >=20
>=20
> I agree, not having the scan_mode at all would be more clean.
> But adding those different iio_info structs comes across as a bit messy.
> Would it make sense to create that iio_info dynamically in the probe and
> fill out the callbacks that are supported for the configuration we
> encounter? I could try out something like that and see how it would look
> like in practice.
>=20

Hmm yeah, it's not just one more iio_info we need but 2. But maybe let's ke=
ep it simple
and remove the check in ad9467_update_scan_mode(). I mean, if I'm not missi=
ng nothing,=20
if there's no buffer, there's no real way for userspace to reach that code =
path.

- Nuno S=C3=A1

>=20

