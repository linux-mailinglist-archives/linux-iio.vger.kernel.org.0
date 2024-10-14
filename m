Return-Path: <linux-iio+bounces-10573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB899D3CD
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44EC1C259FC
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C156231CA4;
	Mon, 14 Oct 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALCEt0uU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5F196;
	Mon, 14 Oct 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920791; cv=none; b=NhAO+5k3CDKnYFF1WjiDsboXu7IuFsDeJI4J0/cp7j2rzP+ExfyRIkxHuhNu6zOmvsYgHwMrsd4e6otMHLZXNIH2v3vKF/27lDUWjm3imm+wr/Z3JKLvVI0+JqigRHSEt/qAwE6OVirlueZU5pO3I7B5IZDzbSPGAhRR22hxEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920791; c=relaxed/simple;
	bh=cxGpsM/buSYu3pTRW68LEieOicsZzpEFO0dAjHdsYGs=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=K6bF0wyNaewGxxBv+sw6sRjnCWL96xH4VW7P/MjgEXy3GLi9RRcG9sX43FBQpNCR0PQRcWX5Ze+SUhBPGq2xBgjeekxwbhrKh/06qTMjuFtXqXRvQMGVHCGmpMyrQnFpPSYuDVAeqcBZJf6bCOQP8n+Y+oD+qPyCd65nVFWqcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALCEt0uU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so34699015e9.2;
        Mon, 14 Oct 2024 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728920788; x=1729525588; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxGpsM/buSYu3pTRW68LEieOicsZzpEFO0dAjHdsYGs=;
        b=ALCEt0uUXrEWpJtdHL8RY0TIMKgEngtt9e0GtiVrfC9a8vAEt9RejbwVpPePDg0St+
         ed0vGRkvIaJmWmPnOb4kT8vLTHBniT8zSynDsAyy+5uejIq5Jgq4UCfpOdx00MmH5W9J
         R3dzGoyOyYlyOUjV0AYxIE2UBeA9BsjMFzuEfi8iLU44DFaNoE42Ak1rpf9/9HE6ZMmJ
         dkbgYk0d2FE9bIWExxxbMWfzvZWOTSkicK0+pv9wcHn7zdSBiS7NDSbx7YIqgdVSoSme
         8ZQNdFSNBF3wuD455uC8JDxB+sGliRuHObzJ4An0VCd8UZ27NICFafzKHCTrG3jTSenB
         xFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920788; x=1729525588;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxGpsM/buSYu3pTRW68LEieOicsZzpEFO0dAjHdsYGs=;
        b=bdJ67Ws9Xf0yoUqPbJIRV8NBT8gzXrj+oy5oYGLfFazNgigBtFro74ZlgdyFI0XgAR
         Fh+XLT5gwpxuaNa+rD+/vy9E5pwI4BZU0pc7R/7+QdXMIzRGfkUr9+bwG6ybbiQChAOh
         qD3Er2kt4CPLKfZVz2OsvmYqvdT5kVU8BtLcDraqhQwgTAb4MPuxZRQOCqPQ/YmEnyq5
         r4Dvq1WcBN8bzA4ihmmbfu8X4RvPc+fzLHLc2U5TzhnNueUsJ+JCF/1gY9W+Dv+q4wwX
         B44Y/Qqv99AIAr46n5WAQJhr5/K5HRa4wVjRUl1fAghWMC6YElHLTEZ2EwYZBp66wlPo
         2wEg==
X-Forwarded-Encrypted: i=1; AJvYcCUwwYlEsE4gsN0YiMr2rRcy9aFeE1v/ueeXl8txd5E6XVs05o5w5olnt3WV3fhROhjWU40CkpwUkc0=@vger.kernel.org, AJvYcCWRADVDKzK+pAu1o9KOvmHuKD548Aur4cbVykqzC3DpMQ2rANa59S5FNqeN5L39YHyqQQS437KuLkqf90+G@vger.kernel.org
X-Gm-Message-State: AOJu0YyBghk7grKkajQQoycRqCsbqRmlrRgX6ItOwbicI0dOYOIP/3rY
	47/U6rAFiCJE9fEVv2L52NmZXSjVGUB3+iFGP6egWSUs8/F8Ag65KH84n7ig
X-Google-Smtp-Source: AGHT+IEUhTOMajNBn8OQg+65jQfGUteQJ145m04pOx3jvSaXJG4bX1j7umqLc29CCWkX0tK/c8ytYA==
X-Received: by 2002:a5d:5352:0:b0:37d:4894:6878 with SMTP id ffacd0b85a97d-37d5fe95846mr6267029f8f.10.1728920788056;
        Mon, 14 Oct 2024 08:46:28 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd266sm11626177f8f.40.2024.10.14.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:46:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e4cad20ed2f8d31bf71bc595ab54c64d96bfb4b4.camel@microchip.com>
References: <20241011134454.45283-1-victor.duicu@microchip.com> <172872753469.9340.10387646359307852048@njaxe.localdomain> <e4cad20ed2f8d31bf71bc595ab54c64d96bfb4b4.camel@microchip.com>
Subject: Re: [PATCH v3] iio: adc: pac1921: add ACPI support to Microchip pac1921.
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Marius.Cristea@microchip.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
To: Victor.Duicu@microchip.com, jic23@kernel.org, lars@metafoo.de
Date: Mon, 14 Oct 2024 17:46:26 +0200
Message-ID: <172892078642.158534.11658754591922958169@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Victor.Duicu@microchip.com (2024-10-14 12:08:05)
> On Sat, 2024-10-12 at 12:05 +0200, Matteo Martelli wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > Quoting victor.duicu@microchip.com=C2=A0(2024-10-11 15:44:54)
> > > From: Victor Duicu <victor.duicu@microchip.com>
> > >=20
> > > This patch implements ACPI support to Microchip pac1921.
> > > The driver can read shunt resistor value and label from ACPI table.
> > >=20
> > > The patch was tested on a minnowboard(64b) and sama5(32b).
> > > In order to avoid overflow when reading 64b values from ACPi table
> > > or
> > > devicetree it is necessary:
> > > - the revision of .dsl file must be 2 or greater to enable 64b
> > > arithmetic.
> > > - the shunt resistor variable in devicetree must have the prefix
> > > "/bits/ 64".
> > >=20
> > > Differences related to previous versions:
> > > v3:
> > > - simplify and make inline function pac1921_shunt_is_valid. Make
> > > argument u64.
> > > - fix link to DSM documentation.
> > > - in pac1921_match_acpi_device and pac1921_parse_of_fw, the shunt
> > > value is
> > > read as u64.
> > > - in pac1921_parse_of_fw remove code for reading label value from
> > > devicetree.
> > > - in pac1921_write_shunt_resistor cast the multiply result to u64
> > > in order
> > > to fix overflow.
> > >=20
> > > v2:
> > > - remove name variable from priv. Driver reads label attribute with
> > > sysfs.
> > > - define pac1921_shunt_is_valid function.
> > > - move default assignments in pac1921_probe to original position.
> > > - roll back coding style changes.
> > > - add documentation for DSM(the linked document was used as
> > > reference).
> > > - remove acpi_match_device in pac1921_match_acpi_device.
> > > - remove unnecessary null assignment and comment.
> > > - change name of function pac1921_match_of_device to
> > > pac1921_parse_of_fw.
> > >=20
> > > v1:
> > > - initial version for review.
> > >=20
> > > Signed-off-by: Victor Duicu <victor.duicu@microchip.com>

...

> > > =C2=A0/*
> > > =C2=A0 * Check if first integration after configuration update has
> > > completed.
> > > =C2=A0 *
> > > @@ -792,13 +801,13 @@ static ssize_t
> > > pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rshunt_uohm =3D val * MICRO + v=
al_fract;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rshunt_uohm =3D=3D 0 || rsh=
unt_uohm > INT_MAX)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rshunt_uohm =3D (u64)val * MICR=
O + val_fract;
> >=20
> > In commit a9bb0610b2fa ("iio: pac1921: remove unnecessary explicit
> > casts"),
> > unnecessary explicit casts had been removed since it seems the
> > preferred
> > approach in order to improve readability. This (u64)val cast seems
> > unnecessary
> > as well thus I would keep the expression without it.
>=20
> While testing on SamA5 board , the multiplication between val and MICRO
> can overflow when val is greater than INT_MAX. The cast to (u64) is
> necessary to correctly calculate the new shunt value.
>=20

You are right, the (u64) explicit cast is necessary and I think the
issue is relevant even when val is lesser than INT_MAX: on 32bit
architectures, val * MICRO is implicitly casted to u32, thus a resulting
value of that multiplication that is bigger than INT_MAX could pass as
valid even if it's not. For example if val is 0x40000000, val * MICRO
would be casted to 0 even if way bigger than INT_MAX.

...

> > > +static int pac1921_parse_of_fw(struct i2c_client *client, struct
> > > pac1921_priv *priv,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &client-=
>dev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 temp;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D device_property_read_u6=
4(dev, "shunt-resistor-micro-
> > > ohms", &temp);
> >=20
> > Since the driver would discard a value out of INT boundaries, I don't
> > see the
> > need to read a value larger than u32 that would be discarded anyway.
> > To my
> > understanding, device_property_read_u32() should fail for an
> > overflowing value
> > thus I would keep device_property_read_u32() here, and at that point
> > the temp
> > var would not be necessary as well. I think it would also help to
> > keep the patch
> > diff confined in the ACPI extension context.
>=20
> If the value in .dtso is greater than 32b, at compilation it will be
> truncated, and the incorrect value will be accepted by the driver. By
> adding "/bits/ 64" in the devicetree to shunt resistor the value will
> not be truncated. This way values on 32b and 64b can be read correctly.
>=20

I see your point but if I understand this correctly with this change the
shunt-resistor-micro-ohms field in the DT should always be specified
with /bits/ 64, even for values in 32bit boundaries. I might be wrong
but this looks like something that should be documented in
Documentation/devicetree/bindings, especially since all the other
shunt-resistor-micro-ohms instances look to be interpreted as u32.
Also, I think that such change would fit better in a different patch as
it is not related to the introduction of ACPI support.

> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, ret,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cann=
ot read shunt resistor
> > > property\n");
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pac1921_shunt_is_valid(temp=
))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, -EINVAL, "Invalid shunt
> > > resistor: %u\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv-=
>rshunt_uohm);
> >=20
> > The error should be returned when the shunt is NOT valid.
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->rshunt_uohm =3D (u32)temp;
> >=20
> > The temp var should not be necessary if switching back to
> > device_property_read_u32(),
> > otherwise I would remove the unnecessary explicit cast for the above
> > reason.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pac1921_calc_current_scales(pri=
v);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +

Thanks,
Matteo Martelli

