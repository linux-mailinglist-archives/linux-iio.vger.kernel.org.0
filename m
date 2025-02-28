Return-Path: <linux-iio+bounces-16189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E83A49A6B
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 14:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610A9173E35
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420B26BD8F;
	Fri, 28 Feb 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2rH7pke"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102326B95B;
	Fri, 28 Feb 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748957; cv=none; b=JFuzASoVc4Gtjw3KyNzS+kBiaBMCIuYOhVXwGGcLvVl6r5PE+15rXODBPSyN1ppgTjxJlNm7crtiQXc1+ruep+xyvVuqib/KpRYKdqjdvKGdZw8gv6EkHIFewfbFiue45bDn0PrtWmO40m+gVSg4AUwqBbJVABMHCZgX2/wCBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748957; c=relaxed/simple;
	bh=/K4e9u07/0adN/nKYJbK+nupYCprYEqW3G9rQDSQwME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EK53yAWOT+kvu1/+TJUxgZuBCNvhqYk7k5nORuO09A+bwZ+/mccseY9lxJ8IN6U07YcyVfMEscJW24pJQLQe5vi8P4vLgUNzsO055ExyUQn7cR+ATlHDpK3hinWirBEpRXO30ed6Ca3eO6BM8J/o8u1ccy2cAL0XXvRbgKIjOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2rH7pke; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so19455665e9.2;
        Fri, 28 Feb 2025 05:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740748954; x=1741353754; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4eIbtrSEXum06fjOR39sZiyIp8N/SDS+KUv5qVuk+io=;
        b=i2rH7pkeJyOcGuS4H5YhgnBgdN0mgwmoArxrUKGkzaMfAL+T8pcYKB3GJlqAJINbyk
         kXtq5V/UfohI50gsk5arg3Qo0U0gHFsgXNLPu8eO2TjjA8eA9dTDs0N4Q3658HFdG37A
         d9glZj2VXxv2sZgrZfgo7DpK0iKhwjNm/Cm6rLxC41z1rA0WEJ6NIC41iTA8YBshFQuN
         QwoF/K3SKr5S8o9ZqOC1coZKaeCrPDG1eEJNN1/5kW0pp9JNIVxAIJWceXWI14hPcwjf
         q2fzToL19U22l/I9bE1Lrdz00cHJd21KRaEPKHi5F7PEa6ZU71f3lR/8nbcRN6Nd0Bzc
         t47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748954; x=1741353754;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eIbtrSEXum06fjOR39sZiyIp8N/SDS+KUv5qVuk+io=;
        b=QIwuySMbruWj/eIze1WQYkM+OHcTcPv68bp1OZ9JlxfvlUnjG0hxHyncytzFNbNemi
         istxX0380LfsQC8tA9JifHLpi9MugXor4ouWsOOSa2NCec1AsokioqpkPfYeVV4Zsx7v
         hd1j1La2WFJmRMuROYjOQpuz2kd3fg1KgavFBTaji9OpPNFWxU5k09xnu+l80Y6SWTV4
         5Ic3t+wTyYn4cctNsOCEVKnRee3bb3K20Ecbc6m7SzQzHCHTEzMWDoSVdjS6dVsS9U/9
         NigVniAYmnwhYsbGrjWr2eSj0NKqZxnpjd5ieAtEHXzDLAGVY/12Km55tAapp7tyuL9K
         Pzkw==
X-Forwarded-Encrypted: i=1; AJvYcCU7U7MpBfQjIoRaE1VlY22MtGaVvGFNbHDQtFEHOM6lpC+trXhsYL2pfeXIYab5YP9Acr5Gq33+8nViJmsIzAc=@vger.kernel.org, AJvYcCVNVxa++/Rz26uYydD3P9irSYMcN+ctkD8Kk16AOKKhYadWKsfdOlHWbcC8VkkWh8HeM0PMYywxCrYhfaoG@vger.kernel.org, AJvYcCWAvbDVEnbAtSmf1/9QBWqNade//0OoI6Oy8EQuA1RW8mREdfP9zY4kvTDuKATirjKIv0+RdjHzKcGP@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVwGedApBpg6x6C4uqDaqNWWEyOPl7D8zx/ig0a/9eyboQiMl
	5jgfq7Nz8RhnzNCHhxSm+SvnsXnCr3Z0fl7eUwNd2MH3RJAuVTnM
X-Gm-Gg: ASbGnctJmsPqD4KoiOfqCAZsPyajgCGYZh2eygn3u5kOWmqZDVZCTnJbh4O9jflENx9
	CIe15Otu/f0OCs+UkXL+RkSe6cjMRxz5ZWh2JzthRViihTm5yfPCTWP2yXlDmdibqSPSbTnI687
	roNYJpDYmmjh1kdC57d9D/K98o8w/I+oE4ueXCmkpmkwrD5IKQGAyvFhlut6Mf004cuZFMArNGB
	9qCjRA0cmsdXj0XTPSvlFKJs72hjxCpx8tOkpEWL6ZxjRA9QKQYlD9pauB2/Ri66q8D1h4bVA7s
	kLXj4UsBmE8gR73wPK/2s9oXzBq/Tg3FdmB9SIXw5RhHI/diM/ZnuAZ3ir4PCe49m3E/OkIiVw=
	=
X-Google-Smtp-Source: AGHT+IEo6uyegW0gX7Jh7gwp5A9pDguY3LYUzLBHzt6N2/YZtqEsQ3UVTnNfG2B6vg1ZjL9aApveYw==
X-Received: by 2002:a05:600c:c8c:b0:439:64eb:67cf with SMTP id 5b1f17b1804b1-43ba7d66346mr21594375e9.13.1740748953492;
        Fri, 28 Feb 2025 05:22:33 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717230sm55385915e9.19.2025.02.28.05.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:22:33 -0800 (PST)
Message-ID: <3c9bfa8bd08d835e0151fb66fce443457e2f2a98.camel@gmail.com>
Subject: Re: [PATCH next] iio: adc: ad4030: fix error pointer dereference in
 probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Esteban Blanc
	 <eblanc@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Cameron	 <jic23@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Fri, 28 Feb 2025 13:22:37 +0000
In-Reply-To: <cc67cee7-9c65-46d2-aae3-f860fc3cc461@stanley.mountain>
References: <cc67cee7-9c65-46d2-aae3-f860fc3cc461@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 12:35 +0300, Dan Carpenter wrote:
> The intention here was obviously to return an error if devm_regmap_init()
> fails, but the return statement was accidentally left out.=C2=A0 This lea=
ds to
> an error pointer dereference when we call:
>=20
> 	ret =3D ad4030_detect_chip_info(st);
>=20
> Add the return statement.
>=20
> Fixes: ec25cf6f1ee3 ("iio: adc: ad4030: add support for ad4632-16 and ad4=
632-
> 24")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> There is a second Smatch warning which we may want to fix as well:
>=20
> =C2=A0=C2=A0=C2=A0 drivers/iio/adc/ad4030.c:397 ad4030_get_chan_scale()
> =C2=A0=C2=A0=C2=A0 error: 'scan_type' dereferencing possible ERR_PTR()
>=20
> There's not error checking on iio_get_current_scan_type().
>=20
> =C2=A0drivers/iio/adc/ad4030.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index ab5497c8ea1e..b7caf7e89710 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -1014,8 +1014,8 @@ static int ad4030_probe(struct spi_device *spi)
> =C2=A0	st->regmap =3D devm_regmap_init(dev, &ad4030_regmap_bus, st,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ad4030_regmap_config);
> =C2=A0	if (IS_ERR(st->regmap))
> -		dev_err_probe(dev, PTR_ERR(st->regmap),
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap\n");
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap\n");
> =C2=A0
> =C2=A0	st->chip =3D spi_get_device_match_data(spi);
> =C2=A0	if (!st->chip)


