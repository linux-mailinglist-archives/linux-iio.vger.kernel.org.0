Return-Path: <linux-iio+bounces-20996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B6AEBC8E
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422361C62DAC
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634542EA744;
	Fri, 27 Jun 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yend658O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018A2E88A6;
	Fri, 27 Jun 2025 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039563; cv=none; b=lA5Fafi+PmwK/VY0HnkheOQj7wMILOPyMKYf5XWob5c3t/1IKAXSuyGvipZ9LZqNA5akua8zZGiiuOH/SZ6Qiiysi6fTXBb7anzvwA1opBVIllRJ1b8XcOxZTJGGQaJQoA5l85/zZsQMzhaW8neO2u/TY2K1xIQNg+FH5ar7lVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039563; c=relaxed/simple;
	bh=XeKZz/4St1n12AJxYNX8W2/v+ZmZ2gValMKIHPpMaxY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cUJWN487m/wg5vzze9AeNTrGRqm1Fbqai4bLFlOV0K/lxQ0Yj3knP/N6VnTv8dKfHNh4huNHswF9XoK118h8yQdMlkcdZ6j6PKMeSt2wONDQw8fGQG5co0KeIctvKZz4niniufm+kxrQ6mAYw0GF6h7wcyFeT18P1x7XPBwqI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yend658O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso435685e9.0;
        Fri, 27 Jun 2025 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751039559; x=1751644359; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aROkZFIKLQ+lbqzVC7RQG9Yy2SLndEIotjckE9EqPY=;
        b=Yend658O83RddFkACc91Iz+z/WVWNc99CCIXgHWM2uL8O0wNdq4jF7bowFEGxvWa42
         cB9NgL4YRSY07wEoS3UwINy3LW9Ofm/0ddA9JDaC19h/NxhN5Dn4vM8r0lAZBlOnpl33
         g9U8qnNygXtHqTf9MzGQ/Z0L0Vk7EVwL1bUF2VaFV911pfa+JY4Ypmmeer2E3noDIPD5
         P9M9I8KZTdFa/2aO9tbRKTcRBq6c9yWaAQ41uoJQtyWjTN3ScvkYh3lUP7ztKQ72leju
         5TzINy29DyQA4biuGX7/j4kVdYlp5ZPmbRu8Zw7MHEBYt9BO7OM3jOWF9/sDkTbdTuUS
         aMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751039559; x=1751644359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2aROkZFIKLQ+lbqzVC7RQG9Yy2SLndEIotjckE9EqPY=;
        b=kxRb0SzBKN0r4yL544YffP23J0fRnS+mIkucTgsfKFhJ7PBKoAruKIaApAqaZsr5aK
         1w9X0ionxC9CG6fm7tw7ZJ2Y5jjf1s4vwz4pqatAfvkxa2V9Zr/nLrMCe7RWpLYB8l6t
         qvw8OVaI3ujiXPkNbGwfBL9X4xszfFgg93BAlFh9IoWBufXeNMENimgttTBvRq/sDY1b
         dZMc1KcNBuVMJbtD7TsgPkFNgNjch/F0j2+lSbuWKsvvQJb574EurN/sxDhPSyFbs4k5
         ssnemRo56ZGLAFTX+gBayo+2FwiydGkbUr48MWeGbmbEkDu2yACk2Kir4Td/gDj2LDsD
         LE3g==
X-Forwarded-Encrypted: i=1; AJvYcCUmcW28UScv0fQ/kfz4f0SCFaPldbxugPk0N4b8QLcm4ndRPj9qh0/C+bH2RU+sN9Vu0hMIHHY4w9YDbMT1@vger.kernel.org, AJvYcCVTQri+UtHpDE4pMUJPB+FiBQxFvzPDvsNWNx10GT6Zw+hgXOj4c6d9Ohszw/7lt1yAYWZ5GOuG03oR@vger.kernel.org, AJvYcCXlQBD5RgGsw6Q2jUZzZ1eAq/QdL81AXJNeufZxStxINNn77BCIP3GNsJUgYjjDPiSnBOc3+lR9afOz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Sikwg7FmyMUAXWcLzyLCvfh9Kpd50MFj2HunP+fomaBBgbJu
	6yhCfQ/RP8JyL1Xy63kp7LZADobjrgcCRvju+wvHIGsV9Cm4flB/GrGrmUDE2QQpfd0=
X-Gm-Gg: ASbGncv1LzlJImiP7Lerqmt5MZHWZTPTrD82OXq+Oj1CB0BAfIc6P146xg+UOZDR1Ra
	JLfec8QobhMeRDRFGCVXzDmwJotRzH+MJLkkwmtPL1/X9k+Z1tT15GPyKelej4NebFZtcInMML/
	QJNerdsTn0XxO52gDj/nA0g/1lGDKRKwxYHSPELWLZGwnhmwG2Y+qKL7mw2XHeL+Exi2woAaclF
	mgx6V0Gt0bmPzhD+Kmj2IScjor+6M4jlgbART3EzFhRcYpCieudpf8YKz8iuGprM/I3CRFd39hj
	q2ePsIrV6dBRlkDrOodR0ySZnp6vf7j9JEkLuuwPOZkvvYicxrHIh0kzrlivmxoQ3cPRnA==
X-Google-Smtp-Source: AGHT+IEpHPb17jwWV2U9yKDNsQX8hcJa/WEXDos5SeCcUccgjeuX2QhCUbhn2Cb9K3JGOmuqmM2qLg==
X-Received: by 2002:a05:600c:c0d7:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-4538f284df8mr27008625e9.1.1751039559287;
        Fri, 27 Jun 2025 08:52:39 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45388888533sm63173355e9.21.2025.06.27.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:52:39 -0700 (PDT)
Message-ID: <301b3c390b417c1268c0c1d3014d52f8b8660aba.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad4851: add spi 3-wire support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Jun 2025 16:52:49 +0100
In-Reply-To: <20250626104024.8645-2-antoniu.miclaus@analog.com>
References: <20250626104024.8645-1-antoniu.miclaus@analog.com>
	 <20250626104024.8645-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-26 at 13:40 +0300, Antoniu Miclaus wrote:
> Add support for 3-wire configuration within the driver.
> By default 4-wire configuration is used.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Had to look twice :). Commit message could have been better by saying that =
reset
value is 3-wire. Anyways:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4851.c | 10 ++++++----
> =C2=A01 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> index 31e1e02c0ce3..1ad77f2a4580 100644
> --- a/drivers/iio/adc/ad4851.c
> +++ b/drivers/iio/adc/ad4851.c
> @@ -444,10 +444,12 @@ static int ad4851_setup(struct ad4851_state *st)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> -			=C2=A0=C2=A0 AD4851_SDO_ENABLE);
> -	if (ret)
> -		return ret;
> +	if (!(st->spi->mode & SPI_3WIRE)) {
> +		ret =3D regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +				=C2=A0=C2=A0 AD4851_SDO_ENABLE);
> +		if (ret)
> +			return ret;
> +	}
> =C2=A0
> =C2=A0	ret =3D regmap_read(st->regmap, AD4851_REG_PRODUCT_ID_L, &product_=
id);
> =C2=A0	if (ret)

