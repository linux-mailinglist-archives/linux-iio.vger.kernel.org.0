Return-Path: <linux-iio+bounces-18187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B4A918C9
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5711C7A402D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85022A811;
	Thu, 17 Apr 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adD66OMm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600E1D63D6;
	Thu, 17 Apr 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884413; cv=none; b=QXuEHilGHPXbfzCaUKE135SPyHkErevSdG5ksJpsMAsaeONdJMMf7JEfiCFpPI1F9I3C86ej4Hw2JAk187yeEQ5u9NTkI8uvWgEpAzJQbr4pcaIexljhWPr4fVHaoII+GR+6c28fWvPw/7NzY7veNXd97brgA+LVFWlSOcmqJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884413; c=relaxed/simple;
	bh=cHFaPOyz6ZSDjFr47T4p6zy7Okm2xy12Ulmr5wJCibE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=efhAs8IDK21do9DbMwGeuE2L7xuH7AOsnkg1GKmvsoJ+6KyI9Fl8xNy47rFXGrHfQj7PNafUcCPIE1puWTuy5IP/ZZS6GX7Sh0hPmawA4oV0349ypyknYkQoxG4mkuJeZ494TaoUYkXPDknLXdnbVDQ+hRkqFSURUrO5nLT65Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adD66OMm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso398061f8f.2;
        Thu, 17 Apr 2025 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744884409; x=1745489209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h6KysCT5Lx4QdfHdeHf4ybFRVCeriAOoOxCKRAfn2hc=;
        b=adD66OMmOgGU+KWZQ/vOO22SUesIQuidf7r+a1Kq9nat2Fk4fhU+refY7T3fl0EX2P
         B+zOJtkJ2x40Pqqxd1i82gsVI0xPK3zs1gK+LVppwII+Aaqf6b7Uj9/KBJU+VqNIV+Mm
         JpP2VlZe+GwmwEEabN4yNj/hEkSiOKkKhDardiR6pdv4DwK0SRUZR5kjce2rEj97sZkj
         yBojdbuYaGONZ3xccb+gny9PdhmUAMgM40C2N65+1C51zSoyQkVZCocSTe/WtJEv4UcZ
         l8S+Z4CpwYENYaZMfoMKDHexg8JQVdexEQlSNsldhgBVPTHIcuXJURuxo0R0M/Kxd4tW
         QNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744884409; x=1745489209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6KysCT5Lx4QdfHdeHf4ybFRVCeriAOoOxCKRAfn2hc=;
        b=OWmTnQnIHejgOKucEkRQIXnLU0nZZOG0WpxESsRCEyEQnmjAr0Sc/3/8ldPKaXzaLS
         76sYzPy1egYMbvJxLMJaPT8hP5BGJLpubedjg7KFqjMKarlfji33wD2JRgalIrw7Lmpp
         djJg7LuSmv+cFGJku5cCNtk4BdvMhmkxzKn1y4KrifrIoGgcieAk1xr0a8FV4Wk0rj81
         RJb00Fs/YOlmNrXTO44K+YlHSHpjFBKD4IuozbI3Uuf+7yuXcZ1ZK2xpWQuqtGZulKqj
         rB4hpgvJE5PRYRinjY6X8LpkVWQvRh/ltjbz+kqxyhdHDSslo9AmQi5+mJ/43DUdw/iT
         eeKw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9ChXpUKZSGLrWHunnjwpVDDSZlsrhoclo7TV73bAgAYLIo/iS9mAC4O6T/m/XquuAqIsIeLBL/7BIiJ2@vger.kernel.org, AJvYcCVGIOdnhHfcIbkZ4JQ6A8BQ07uuzDWRfHdHzQZMcbrYIPkI7pr5QeSmXxjJRUBievJ28Wy5McQu@vger.kernel.org, AJvYcCVfvzSts+JITZztmb6QHfYYm8Zd6OPJA95kThX0i1VIRJyoKlg2D2hTkUlvIUzu2YrM6xDoaEc6mEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7YJcw+wBQlcH7DwcpcfKs02Sd74h2Y5p5F/KLnbBKsBkGMx/
	bEKiVeH9Z8gfTR+ITTcuymvzIys/BYgxrjmMYttqQx2B5eP1ocuB
X-Gm-Gg: ASbGncv4jMizm6daMV2ul1eef6efUUAZCV6nPfTceK1NcGc41DRBFDqHAZAcHeL7Y2N
	z7cyPYF9cXwiXXJTGfs/Tl1tWSbhIjoo0vwMoLJYnZYkmqxq/UyqNs5QS8Bk+510OEehL/ljQNj
	9si9FNstEyLLAzfqHZ4EfJoW+DmjyleCen1bwKJMelXJ7eyqtj0VDEyKqfBkLKgG7/JuxnNWfTK
	ofPGE1D2EIFQ+e5LDwpR6eMLXuxHNwccwuaJaeCVhNQeH0c8+8/OXFJPFOLhyXx4xbW6XNivoYx
	L/4UL8Juv6Ji9vNxapQAaRV8sEHYfblcdrTE+nTcSYg+L0uR9DOINdMZuo1JyFa8+trUVs87f3O
	aPhYBdiPlRnrpTP9OnS66OEE=
X-Google-Smtp-Source: AGHT+IGFF+Ix12FNw157+6rzhtUnIoDjLmttVUpIm1dLdHy1xPMMwF7r2GAq56rSCkut3Q2GeHiZSA==
X-Received: by 2002:a05:6000:420d:b0:39c:2b28:604a with SMTP id ffacd0b85a97d-39ee5bb0c8fmr3985511f8f.50.1744884409297;
        Thu, 17 Apr 2025 03:06:49 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4c8263sm48251595e9.4.2025.04.17.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 03:06:48 -0700 (PDT)
Message-ID: <fb712c034eda0d5d711a90a00b6382315fb5f929.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: Revoke valid channel for error path
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>, gregkh@linuxfoundation.org, 
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org
Cc: skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org, 
	stable@vger.kernel.org
Date: Thu, 17 Apr 2025 11:06:51 +0100
In-Reply-To: <20250415182038.523186-1-gshahrouzi@gmail.com>
References: <20250415182038.523186-1-gshahrouzi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-15 at 14:20 -0400, Gabriel Shahrouzi wrote:
> According to the datasheet on page 9 under the channel selection table,
> all devices (AD7816/7/8) are able to use the channel marked as 7. This
> channel is used for diagnostic purposes by routing the internal 1.23V
> bandgap source through the MUX to the input of the ADC.
>=20
> Replace checking for string equality with checking for the same chip ID
> to reduce time complexity.
>=20
> Group invalid channels for all devices together because they are
> processed the same way.
>=20
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
> =C2=A0drivers/staging/iio/adc/ad7816.c | 15 +++++----------
> =C2=A01 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/staging/iio/adc/ad7816.c
> b/drivers/staging/iio/adc/ad7816.c
> index 6c14d7bcdd675..d880fe0257697 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -186,17 +186,12 @@ static ssize_t ad7816_store_channel(struct device *=
dev,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	if (data > AD7816_CS_MAX && data !=3D AD7816_CS_MASK) {
> -		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for
> %s.\n",
> -			data, indio_dev->name);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7818") =3D=3D 0 && data > 1) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7818.\n", data);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7816") =3D=3D 0 && data > 0) {
> +	if (data !=3D AD7816_CS_MASK &&
> +	=C2=A0=C2=A0=C2=A0 (data > AD7816_CS_MAX ||
> +	=C2=A0=C2=A0=C2=A0 (chip->id =3D=3D ID_AD7818 && data > 1) ||
> +	=C2=A0=C2=A0=C2=A0 (chip->id =3D=3D ID_AD7816 && data > 0))) {
> =C2=A0		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7816.\n", data);
> +			"Invalid channel id %lu for %s.\n", data, indio_dev-
> >name);
> =C2=A0		return -EINVAL;
> =C2=A0	}

Hmm, maybe I'm missing something but the code just looks the same as before
(from a functionality point of view)? I'm really not seeing any fix...

Having said the above, not sure if grouping helps with readability. But I d=
o
agree with moving from string comparison to use chip->id. And we also have
redundants 'else'

- Nuno S=C3=A1


