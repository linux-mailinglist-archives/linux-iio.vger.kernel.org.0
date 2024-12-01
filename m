Return-Path: <linux-iio+bounces-12924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF5A9DF6DD
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA7281A9C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D4F1D7E5F;
	Sun,  1 Dec 2024 17:58:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89111BC094;
	Sun,  1 Dec 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075885; cv=none; b=trHAn71SkCByci31bwZApffTUPGLvQbaF+by8Fv3DbMgu7dJyHMhze2FoKzbooOj2oFkq9h7OkoO5lKIZUR9JmAfhYapcoSxVn9D9ZcaAmwQhMRJB7ouUKFKSE+HSC/sjFlxgDm41NvEQaZyLa/eQRLMG57PicGz9t+U9EPteSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075885; c=relaxed/simple;
	bh=YEMUTb9p0XMqw6vpoAcY2h7pU+7wrfEAnIVDzJejmOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSWpuAengrgZS8pSSybfyBuXoJnrdnJ6tMcq5LP6Iw2KoDE4X2Fn/BmLooqs9Fos/HbUt3C+udrO2wvbZXwe+ohDBKb8MdkFzUQtBhpndwVJ5h5RM6u/4MgBQDz8kNZuPPF8tsJ2rRKSGTYGZ9o9NvTIjvytE+0cSLf8UcCJ2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 2071D1F0003D;
	Sun,  1 Dec 2024 17:58:01 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 547BAA66BA7; Sun,  1 Dec 2024 17:58:00 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id C9FB1A66BA3;
	Sun,  1 Dec 2024 17:57:59 +0000 (UTC)
Date: Sun, 1 Dec 2024 18:57:58 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for the AMS TCS3430 color
 sensor
Message-ID: <Z0yjphBfTalBSId7@collins>
References: <20241130174239.3298414-1-paulk@sys-base.io>
 <20241130174239.3298414-2-paulk@sys-base.io>
 <20241201115841.0ee49736@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UNjgYTJFw7yfsVeg"
Content-Disposition: inline
In-Reply-To: <20241201115841.0ee49736@jic23-huawei>


--UNjgYTJFw7yfsVeg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Sun 01 Dec 24, 11:58, Jonathan Cameron a =C3=A9crit :
> On Sat, 30 Nov 2024 18:42:39 +0100
> Paul Kocialkowski <paulk@sys-base.io> wrote:
>=20
> > The AMS TCS3430 is a XYZ tristimulus color sensor, with an additional
> > infrared channel.
> >=20
> > This driver implements support for all channels, with configurable
> > integration time and gain. Both direct reading and triggered-buffer
> > modes are supported.
> >=20
> > The device's interrupt can be used to sample all channels at the end
> > of conversion and is optional.
> >=20
> > A thereshold mechanism is available in hardware but only applies to
> > the Z channel. As a result it is of very low interest and was not
> > implemented.
> >=20
> > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
>=20
> Hi Paul
>=20
> As at least some of the feedback I gave on your other driver applies
> here as well, I'm not going to review this version separately.
>=20
> I'd generally advise against sending multiple similar drivers for review
> at the same time as it is less efficient.  Sad truth is that reviewer
> time is generally a bigger bottleneck for kernel code than the time
> of driver authors.  Any time you can put in to help with that will genera=
lly
> also accelerate the rate at which we get to your code!
>=20
> Absolutely fine to overlap your submissions though. When the first
> driver is getting close to being merged, feel free to send the second
> one to get review started.

That makes sense yes! Let's focus on the first driver for now and I'll apply
corresponding changes to this one when the first one is ready.

Thanks!

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--UNjgYTJFw7yfsVeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmdMo6YACgkQhP3B6o/u
lQz60w//UtoHTekeqcwhlasDgpX9+PnuxbtOAfFr0lK2zEhtq3XSafGk2xXuIfvn
ebPLd3Cd3kbqd58LPaWgzRvSDkDgagwK3F+74/HOjCy1LVATegEfIaGEoOUUJ0Dz
SFJSPeIDRgRn4qylERmAmzkdltsI0zINpqgK6eugtaxnq6cHx6Lku7J32kIYVlhJ
Yz9PnkcxBx4asGHXJ8yuR+doFWwjrx3G34kUjYavoEhrL4nAoj+zzQ/zKkeET9iZ
eQe7BAjaFp0BNxCv/3vja1L2EI38NKVuzeqhiRM1yoQa2oFqyzyh3sf9BhZaDigv
hO93ANtOUtFN3m9Ay02X2L/BBR+fblXk33rveyhhL9BCS8RMtreR1kaN5b+a/nDT
2psQQK5lD3GXzlMh1oAatIk30+aDj8nbGGFLay76FKXa1AQiVcPfab61936bR9+n
72DS9XZjd2DLedwKWIqgk29M7XLMKK/mmc5DH3MNdQozv7xmPxcsdBalsXApS8PO
b7O1ta2ha2ffjs/xR9WBA0dkzOZejy004XFWzDSbL1MNqgC6r7r+MfVvPlCBfcvT
jPXYhVkW9H2mrlkOz5gJq6XShX8cONEi+lSTEh+8Q4A7G3quXhZcFuoEY/9AZOeX
od/0RGlIjn2QsK7Q99QNgBYkml4WVHgC8WVCbX3WhKzl8w7GvHc=
=sSZ/
-----END PGP SIGNATURE-----

--UNjgYTJFw7yfsVeg--

