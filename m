Return-Path: <linux-iio+bounces-27307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEC9CD4DC6
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 08:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F11D03009817
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB333064A3;
	Mon, 22 Dec 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="XLt/8ksT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959027F005;
	Mon, 22 Dec 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766388135; cv=none; b=cuSo9BDHDpno9h64o9k2Gthdy1t4HGkaIr/qgAxfBeUi4s60Ch1x3GVUrDDSGMK8BlcK+nvFqeJPL+JuyerpCn2v6KsZQHlCVA8CFHfOriJSUAz/pt9JwJ+WsEXIlP8XQNVQMWR8CRsvbG1SXd3Dfky5MAIUPOUpm+b60BqIwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766388135; c=relaxed/simple;
	bh=vh5Zyv1MEfisC48mG9kL91mnlyRoJAaIQI/ViPflgWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDfD0yrGq9bhCaKJLuymqBVq1KjhEabyoB5lDSubWOtOJ5TUjtRiJHtRqI3vg+Xxl6Eu0P7w4dUwSAXefrJPjLKj/J859u8zptSP0wGMXHDmbtpghxLC3G/vtnNDgJ1iX1MYFAKIBf0MAIVs5T75XrkR8Wc3K//7ZRxl6wFHtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=XLt/8ksT; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:27be:5960:c272:6ea8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 3059A160209;
	Mon, 22 Dec 2025 09:22:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766388129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sVc8PwiRe3hf4NqjmrgwXL/azuIo92lc2sxjORGMei4=;
	b=XLt/8ksTT/wRXe6MQSrhaDCl6LbZ0zyYmKqjwtHGcKmUY07nDjqP05pnhm4zIlGvxlMMZc
	22wtZ7/uB9hacZYNB33mFOrxVkqEvK6yZtFKUxb7LZRDZamSmlEiBILy6G5sLaazhT67NQ
	RbJ9aFQ593n3Z0YBqC1uf8fZnUZoGluDH3jmSL3sfmS3AxOrzMNIM30ih2cSZ91PS2xNRi
	qMO9UVHMmoTb26y30BnTNjqUaORpX93wcq83qgD6YcNdotSTMpIokTRUVYioPL7Xv2D108
	c/cbfdCuB48f/i/8poxecRcXWtBQri8oS2uu6mLL5QQDG31lcnDefAJ6lRs2Mg==
Date: Mon, 22 Dec 2025 09:22:06 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/14] iio: pressure: mprls0025pa: fix interrupt flag
Message-ID: <aUjxnibLMpvMtOY1@lipo.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-12-b36a170f1a5c@subdimension.ro>
 <20251221183826.3050247c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GHhW4BobS/k28h7m"
Content-Disposition: inline
In-Reply-To: <20251221183826.3050247c@jic23-huawei>


--GHhW4BobS/k28h7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello Jonathan,

On Sun, Dec 21, 2025 at 06:38:26PM +0000, Jonathan Cameron wrote:
> On Thu, 18 Dec 2025 13:05:54 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Interrupt falling/rising flags should only be defined in the device tre=
e.
> >=20
> > Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sen=
sor")
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Gah. We shoudn't have let this slip through in 2023.
> Some old drivers have done this for many years and for those we definitely
> can't be sure there aren't boards with it set wrong in DT that will see
> a regression with this fix.
>=20
> For a 2023 driver, maybe we can gamble that no one has broken DT (where t=
his
> would annoyingly be a regression).  One other question below.
>=20
>=20
> > ---
> >  drivers/iio/pressure/mprls0025pa.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/=
mprls0025pa.c
> > index 243a5717b88f..fc04988b9437 100644
> > --- a/drivers/iio/pressure/mprls0025pa.c
> > +++ b/drivers/iio/pressure/mprls0025pa.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/bits.h>
> >  #include <linux/delay.h>
> >  #include <linux/errno.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/math64.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > @@ -404,9 +405,7 @@ int mpr_common_probe(struct device *dev, const stru=
ct mpr_ops *ops, int irq)
> > =20
> >  	if (data->irq > 0) {
> >  		ret =3D devm_request_irq(dev, data->irq, mpr_eoc_handler,
> > -				       IRQF_TRIGGER_RISING,
> > -				       dev_name(dev),
> > -				       data);
> > +				       IRQF_ONESHOT, dev_name(dev), data);
> IRQF_ONESHOT addition here needs a separate explanation. Might well be co=
rrect
> but it's not related to your patch description.

do you feel like IRQF_TRIGGER_NONE would be a better fit?

I used ONESHOT just because it seemed like a good idea to isolate the senso=
r while the handler is running (if I understand the documentation correctly=
).

best regards,
peter

>=20
> >  		if (ret)
> >  			return dev_err_probe(dev, ret,
> >  					  "request irq %d failed\n", data->irq);
> >=20
>=20

--=20
petre rodan

--GHhW4BobS/k28h7m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmlI8ZsACgkQdCsnp2M6
SWMehQ//azPlDqBZ3OTYAkCgON75oBAA1s+e8H0vP1OSGEIdJmzQlQnDGeWtTmpI
QEaxS0PUcyFyqwg6UeO9/89ozNj+MOjpc9nDWwMhMiX3le6rA31Nb35WxS0Nrsf4
Qe16cgkVdwDx5DLfW7iEapyoQHSEYDyU+OHqqpY0xWq5kT7LINQiQx0InW7Az/1Z
hjgqnjGBSROsHbbb33qqxX+N0Y6/AUStde1ev216lJ0g748RxA4J3G7Jcclvoe3b
WycTsmFDd12nYv85mRjrmsv1xlO9PbTXFV3UX4q1xk68wOT8MNAhVFc9OO/cW1P7
D4VKzunZIT79DDrDQDd57buUC59PXmzOgUCiG3EUBX5yxnZlaQ8jPQh6RyoTAaKo
DbuYQ2l8yzw+BpxWiO3XReYpiwHCNbuykrfarApHy8Ma3gjbwNfy5VLg0+MLscKW
88JYxYxcko5q/9uA1ciz4kwevMPEA06Y/VvqnGYERduIn6S4GRVi4X93ktsQlYDV
pgfh0nPGm802t6CwhVTnhyY4fBDlQcpiUlmYHvoY6C470ik89xx5t/A474YUcVbp
zeyRevnkJQ2F8nuhsknB2EOOKAG6YsRpgKx4tSh7OjSsKuPK0lh6cmzml1e70RUq
iCb3lCy0iEs7b1B5QDW2JsPzOZk2XKmbpd1w+/4/JurPve6PPq4=
=k2IY
-----END PGP SIGNATURE-----

--GHhW4BobS/k28h7m--

