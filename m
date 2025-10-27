Return-Path: <linux-iio+bounces-25492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50CC0EA3C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F4219C1E44
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122D729346F;
	Mon, 27 Oct 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UihYwL3k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917923EAB9
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576893; cv=none; b=YhXG+X63H7cOO4ZJRcgjcTwiD4oJCfYpMCdLwcc06Gls5e52qIyS+2+r5XE6MjeNiae+J0I/0U9eno5Say+I6qszWsbZRWE/xM1IlVm+WZCntqOye9CfaHKp6OwIlK+ZHtLb0nGBIyaOgXQdZiPndtQ3rbRCCtbPBMVv/0/aLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576893; c=relaxed/simple;
	bh=3FWHWFetZy4UIuonaqOW5S7qbAY00gfm4vdAgIDwra8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvJ0ogvXw/0Q1B7mOlrcETa/Wnhl04+DUTNK4zq+OTlPY757pOyHpm1ISHXFyOT0xeFqvbpXevfUVfyv0l3Zc7HtsvcXWQgdEABh+ohBVW3ridVpbzBCDAgjPM+QVM5VkG5j3L8Pw0XuMl/HMhyOqbopvWuEyPlBwUVDVCRFAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UihYwL3k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso16573115e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576889; x=1762181689; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+a7Kw6HwvdHWgVIAMQBV9GIUz+DeV6/r2H9pvIEbTsc=;
        b=UihYwL3kIHMdgBeuxm6HFz+RVLsOJjFiRZ8S5BZMIT/IFFTk4xugrfpBnhhHJkFQB8
         NcBj3OqvqYLp+xXuZxbiWCxlriFFahau9v1ZZFJoV/LV7BZiAi37fBUYo9MI52XU1VA/
         6n+Um1Gn6ekM04ysXajxbuLxpwmMsMFjzeSpsYobzQcSeT89UDS9XkvEeGHuReP9FQUK
         Phb2EF0rDFObrxYIZeHxWtuX3+MiMs1qNXxolKT2kHOo5THYDsOc5z/+FZC39pX6FbkP
         P2LPqaTuarK2zviqWnC29i9P+f3itwh/vGwdNDvrXv8ygmfpmcgui9i5ePHfmKTf43D8
         i4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576889; x=1762181689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+a7Kw6HwvdHWgVIAMQBV9GIUz+DeV6/r2H9pvIEbTsc=;
        b=PG5Jm/gZ1tIx1pNv1HdhvvIfK/pdFNCJugOIByQicuu+ulFw+EDjtPbJimM38CJJHz
         aToZsUHl5Kef760bNUxXxXZSE+jKhDH/lZNt3wiZa6GzhktJ/TWjgKb9a/cKVdbAKPEW
         EhNBTB09nZIIUHD/w55YdriE0qBfzO9I9wk6zG0WWR7FJiUHNnySzE2IgJFhugT6oTmh
         z9dwqourVTjKOGuojUh0nCBNN9Fz5HdERTV6jZXfgzq8NVRNnAkKqpmohX1TWwboYHeN
         e63p/THFyX9JFaEXJGgoXTGJBxctwDzuzOEebEVYTHuDaJem1AUzqpNx9g6ScYRP+15s
         mBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsclRpHcIl7cafDqfa4DJQLAb9WInP5PM8wtDcCjI8hE7Ytnoo//wrVJOm2m9m/Es/jU4Ma8OrYjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrI3EdWXIxxY0Hiwnf6eyNghC5cwxSTdx0EPVwxoTiACILDTw
	aixmcn0X9bmDz4jG4TJ+c+1DePpA0ol9qJAdPkRu/btr67g+DOjE8GGu
X-Gm-Gg: ASbGncvkV2zmUhiqHflZaSK0AO9igH0A+lFzDkYRuw1Ek2APwK85Xdimk6VQMvW1gfD
	7oI37O7zHoOfefBSfEEq3MdhdVRHgMFBIaVHNOkma2+qh1y2qBKuAPYmnYu4vRsNuIARVHeW+In
	AHjKMkmQrykez7Rz8dpULaIWjpgldzNcDeZfHjj9Ta/O1EbIhh7+4v8K8lCkqRMwYoFDHQjbYhG
	1W1T1fmc4S+aOjFQ+qpUbaQfL1tSE44IbD+Hk1+wRC3io3iK7rzkQF/uH5/nOeyg4wqIu66yuSb
	wPqujTlJLNzoPk+wDPHREH6hd7xW6T2LEbyTi4N290xrOK8ZEGQpaiE8LRsuwixhNEjI01Ndnp4
	kJDiJUN4zOkU4Wi8xjD4/9KLL00LdEN9gMVcZeCczw7OmQ1ypQxish1WnkY2wltAvxtWhH1WYLF
	bLR2yxMhCh5IupFhPhD0c=
X-Google-Smtp-Source: AGHT+IHIkp8fJ+ChBTVARCx5KpqVLzlnAhiTNDeEGgm3dSo10rCw74/XEJnL2Wbcoa+EtdJjRWt0rA==
X-Received: by 2002:a05:600c:450a:b0:46e:442c:f5e1 with SMTP id 5b1f17b1804b1-4711791cb1fmr287778345e9.35.1761576888865;
        Mon, 27 Oct 2025 07:54:48 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd05098dsm67472255e9.5.2025.10.27.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:54:48 -0700 (PDT)
Message-ID: <457d739b237bfdcf26361b3e4d5a39398468afd1.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: dac: ad5456: Add missing DT compatibles
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 27 Oct 2025 14:55:22 +0000
In-Reply-To: <20251023181321.00001511@huawei.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
		<20251023-ad5446-bindings-v2-2-27fab9891e86@analog.com>
	 <20251023181321.00001511@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 18:13 +0100, Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 14:01:38 +0300
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> I'd retitle this to say it's adding explicit DT compatibles
>=20
> Missing made me thing one or two were missing rather than it relying
> on the fallback path to use the i2c_device_id / spi_device_id paths.
>=20
> I'm not particularly keen on only get the drvdata from those other
> tables as that's fragile to the two remaining precisely in sync. Until
> we fix that better to not add these tables at all.
>=20
> The cleanup will need to switch to pointers rather than enum entries
> and then use generic fetchers to get those pointers which ever type
> of firmware we have.
>=20
> Not trivial but also fairly mechanical change to make so I don't
> feel too mean asking that you do that as part of this patch series.
> If nothing else looking at just this series, someone might think a fallba=
ck
> compatible would be fine given the differences between parts aren't
> visible.
>=20

For such an old part I was trying to get away without having to refactor th=
at
much eheh :). But fair enough, I'll do the above and look for some more obv=
ious
improvements (like i2c and spi dedicated files). Should also note that I do=
n't
really have HW with me so I'll really stick to obvious stuff.

- Nuno S=C3=A1

>=20
>=20
> > Add missing of_device_id compatibles for the i2c and spi drivers.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/dac/ad5446.c | 41 +++++++++++++++++++++++++++++++++++=
++++++
> > =C2=A01 file changed, 41 insertions(+)
> >=20
> > diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> > index ad304b0fec08..b6967f3b9386 100644
> > --- a/drivers/iio/dac/ad5446.c
> > +++ b/drivers/iio/dac/ad5446.c
> > @@ -445,6 +445,35 @@ static const struct spi_device_id ad5446_spi_ids[]=
 =3D {
> > =C2=A0MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
> > =C2=A0
> > =C2=A0static const struct of_device_id ad5446_of_ids[] =3D {
> > +	{ .compatible =3D "adi,ad5300" },
> > +	{ .compatible =3D "adi,ad5310" },
> > +	{ .compatible =3D "adi,ad5320" },
> > +	{ .compatible =3D "adi,ad5444" },
> > +	{ .compatible =3D "adi,ad5446" },
> > +	{ .compatible =3D "adi,ad5450" },
> > +	{ .compatible =3D "adi,ad5451" },
> > +	{ .compatible =3D "adi,ad5452" },
> > +	{ .compatible =3D "adi,ad5453" },
> > +	{ .compatible =3D "adi,ad5512a" },
> > +	{ .compatible =3D "adi,ad5541a" },
> > +	{ .compatible =3D "adi,ad5542a" },
> > +	{ .compatible =3D "adi,ad5543" },
> > +	{ .compatible =3D "adi,ad5553" },
> > +	{ .compatible =3D "adi,ad5600" },
> > +	{ .compatible =3D "adi,ad5601" },
> > +	{ .compatible =3D "adi,ad5611" },
> > +	{ .compatible =3D "adi,ad5621" },
> > +	{ .compatible =3D "adi,ad5641" },
> > +	{ .compatible =3D "adi,ad5620-2500" },
> > +	{ .compatible =3D "adi,ad5620-1250" },
> > +	{ .compatible =3D "adi,ad5640-2500" },
> > +	{ .compatible =3D "adi,ad5640-1250" },
> > +	{ .compatible =3D "adi,ad5660-2500" },
> > +	{ .compatible =3D "adi,ad5660-1250" },
> > +	{ .compatible =3D "adi,ad5662" },
> > +	{ .compatible =3D "ti,dac081s101" },
> > +	{ .compatible =3D "ti,dac101s101" },
> > +	{ .compatible =3D "ti,dac121s101" },
> > =C2=A0	{ .compatible =3D "ti,dac7512" },
> > =C2=A0	{ }
> > =C2=A0};
> > @@ -547,9 +576,21 @@ static const struct i2c_device_id ad5446_i2c_ids[]=
 =3D {
> > =C2=A0};
> > =C2=A0MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
> > =C2=A0
> > +static const struct of_device_id ad5446_i2c_of_ids[] =3D {
> > +	{ .compatible =3D "adi,ad5301" },
> > +	{ .compatible =3D "adi,ad5311" },
> > +	{ .compatible =3D "adi,ad5321" },
> > +	{ .compatible =3D "adi,ad5602" },
> > +	{ .compatible =3D "adi,ad5612" },
> > +	{ .compatible =3D "adi,ad5622" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
> > +
> > =C2=A0static struct i2c_driver ad5446_i2c_driver =3D {
> > =C2=A0	.driver =3D {
> > =C2=A0		=C2=A0=C2=A0 .name =3D "ad5446",
> > +		=C2=A0=C2=A0 .of_match_table =3D ad5446_i2c_of_ids,
> > =C2=A0	},
> > =C2=A0	.probe =3D ad5446_i2c_probe,
> > =C2=A0	.id_table =3D ad5446_i2c_ids,
> >=20

