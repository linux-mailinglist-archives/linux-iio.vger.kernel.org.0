Return-Path: <linux-iio+bounces-10935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845FF9AB0AB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 16:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FD12845D2
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1441A0730;
	Tue, 22 Oct 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkKidgYe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9219D060;
	Tue, 22 Oct 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606743; cv=none; b=sVfc75KAb8WWvJdKWkcc8pv/wejd7Ksd6XrdSvpZkTTXMVESH7xnkYWdW1DBL4GeQosJczC/Tl9HU2ohaROW9laNmORUv1G3/31CYosPnbUaL8t0QFcTZSBChlZhYe0j8nzRFHP0Qq9IicJEEZuri0qZp12n5HCf0CYmJskRL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606743; c=relaxed/simple;
	bh=Q+1mGVztRNdJIrHuhOmd/0Qa1sTvnz9cDv4O75qLyV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=frAyJl1V87P/clILTnA2Lmwd+96sCk/WvsuQa2xGal5BCrcdzWeK+trTZa+V1oAuZ/SPF+2wi/yynthItNZ8pjrs8Px7+9Ttf1qwxPFG9e7sfRJmV/xaZQ86TxVA3zAZ9XS2OupJGyI9TQyT5G7TOuNr5jOVXp+PL+t5cz2t15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkKidgYe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315baec681so58982585e9.2;
        Tue, 22 Oct 2024 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729606739; x=1730211539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MdMzAusJBRJh6pyCqNld+00ftFOuHm80MKqVa6AO4Zc=;
        b=RkKidgYeH3CWy9GrDj4X4BMvjyxHZ4otahPldyej0HzLT3bzYnV+iS93JYKjsoNZM8
         b5mYZ1z2avdo4dh8Qosom6NHS+RV5n6ND2Xz90zUDQosDmXD7hzrqFioltbkm4to0v4t
         JVHLo/gJy06yUfAfmprJHl8MrRfu2SvctwRnqLDr9lbEgE0DpxpKwtCTEFs6OBrt6G5d
         4vVIGJbO5Y4wGumiDK+vc23UFqHH7NG+mjJZRaVwxPIavaUs9gbOx9kuO7dpjgX47xJX
         xI1joCMlINnOzKUpcTVN1b7VhkuAU9mPVPf/ycGfiQPcSTkfT/xm8SIRA0Fz1V4YiVTK
         TeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606739; x=1730211539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdMzAusJBRJh6pyCqNld+00ftFOuHm80MKqVa6AO4Zc=;
        b=A8awVjxTp892ombtaVx3IZHT2ORlIq0QIPjcDEY48Bw1G9NefKz2W9QqD81W7ZTFR7
         J6MxZ/d2z4W0WYUvWS4Ol+hnNR6Ys1dISLv6fcfFZZ96O0qAtUUH9NrGzHVOli0G8qxo
         /36WmyCXOxSeXVwUzRM9Rp8shTPLu+Y+ET0SsSKDmJXjJr3QAIVjFOzRCaZ6HYfzt3ra
         kOyKg869ayU6sz5zND93Yban6IYzD/iKKaWmVxZxGVQNFyoJgWMQaR67arzOSxonmeWx
         ZHOgsplU94xJcOMlnagPLy12RNk+TYaoEH/gXFvpMVOp47UE1Y2/x5AVkX9EPWXmlTgb
         UIug==
X-Forwarded-Encrypted: i=1; AJvYcCWwDLzvrrBIY5nWL9Y3miaP3ornG3YRihkhZJ7e6/siSIJ4PIduHAeAimiHkdrjnI23Irnva2tVewMXhm7w@vger.kernel.org, AJvYcCXTAEvdqytIaunCg1s9B8fX8FddLf3ykd3ts740MWJUb/qA3IA04iR/5zkxGRczqStV3NRDKrmunXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3v3WS85GxkpssMlhRxHjZyhG0n7tNY3dOWgiJ/4DnITIZJQYD
	PjuqaIRPf+hqX3NiVLfhKVYaLPOrkHWpj+0SkGr43e4EOxHhO6Ag
X-Google-Smtp-Source: AGHT+IEmQEXvqqnADJThezvpn0o63z/g54dizNY6aFFV3VlbdG1pYwhqjHXTAfK0QWRhqxT2nflXlg==
X-Received: by 2002:a05:600c:510f:b0:431:1868:417f with SMTP id 5b1f17b1804b1-43161667a1cmr131050425e9.17.1729606739308;
        Tue, 22 Oct 2024 07:18:59 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4c7sm88553235e9.48.2024.10.22.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:18:58 -0700 (PDT)
Message-ID: <561655d4b3bd063cb6ee339294ab9c62a5b06d53.camel@gmail.com>
Subject: Re: [PATCH] drivers/iio/adc/ad7124.c: fix division by zero in
 ad7124_set_channel_odr()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Zicheng Qu <quzicheng@huawei.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org,
 alexandru.tachici@analog.com, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
Date: Tue, 22 Oct 2024 16:23:17 +0200
In-Reply-To: <20241022134330.574601-1-quzicheng@huawei.com>
References: <20241022134330.574601-1-quzicheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-22 at 13:43 +0000, Zicheng Qu wrote:
> In the ad7124_write_raw() function, parameter val can potentially
> be zero. This may lead to a division by zero when DIV_ROUND_CLOSEST()
> is called within ad7124_set_channel_odr(). The ad7124_write_raw()
> function is invoked through the sequence: iio_write_channel_raw() ->
> iio_write_channel_attribute() -> iio_channel_write(), with no checks
> in place to ensure val is non-zero.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index a5d91933f505..b79c48d46ccc 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -637,7 +637,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev=
,
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (val2 !=3D 0) {
> +		if (val2 !=3D 0 || val =3D=3D 0) {
> =C2=A0			ret =3D -EINVAL;
> =C2=A0			break;
> =C2=A0		}


