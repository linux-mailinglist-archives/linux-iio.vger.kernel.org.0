Return-Path: <linux-iio+bounces-24099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A460B56FE0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 07:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E59C1775D4
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 05:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A1D275B05;
	Mon, 15 Sep 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="zT3c1Fv3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F91E1E12;
	Mon, 15 Sep 2025 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915379; cv=none; b=sXlMqr8Y3b3ji8kZRr1oygjxLCZr43VHy07VQRgrkKaBDMOPLKq+fJ6zZufayrN1KvMMmeSVxJ9AmUAtz4p+gtMMp2R4DB4/5WRzJ/7/wi4V1M9Jm1SoOovqkStKdttgzPGiTns5lEUozSM0OvZjOV3Ar5wspcXVyLLemC63+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915379; c=relaxed/simple;
	bh=lzPRMmO52ut5aLucZHdz3eltDg7+fystvTtazU7gI5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbcglNQSWyDS580U5voUJe5/Vuhn8i7puSQS/vbjU0JVDTS0NTXzeIWEqoIJKZ9CTzsL/q/cYJuf3IiYJOHxSCes0mQZqWm16pmsm6nuyzNjensFQQzBYa3R5PrF68D+8jSQaH/P1dDNdAEvH/vndnA2NcawMtRuo1Mys+JNH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=zT3c1Fv3; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo (unknown [IPv6:2a02:2f0e:3e0c:5b00:f1e0:3f4b:286c:9ddb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 708C3173BE2;
	Mon, 15 Sep 2025 08:49:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757915375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqLjA+ubL/9DYZGEd5lqFmc3GH24rBewLMsLNh29sWk=;
	b=zT3c1Fv3PFeyAMZ6ie6kpxBkpItfOozsaTAvE5bZscjy59LuFf60puNNCMwV2Ko42gBdFw
	Xno1doKgviMXCyutc9KrYVC1NYuuvpsLnLiUly92If59mDDX7wpg5ETDbw6lMb2oTO160A
	7CTBsGrJMG+i6qI1yDxjZzF+CotgBC9XUkwe8i8HWluQxE9NhbSpL4DGpzC5OfuZN8+kca
	/ZfEBKnt+XlmTVopCrO03CTv0Qps83Al6nsq1vPFrAK24fKQQKqmjYVF9gcQ0JiMa6rFHW
	BcGF1AWKJVXnfnk9oj6i4l1XueycxjVjjZF2JFbelX17YuAc2iJUmsg7NQC9EQ==
Date: Mon, 15 Sep 2025 08:49:31 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/18] iio: accel: bma220: migrate to regmap API
Message-ID: <aMeo64_bXbn1OkcW@lipo>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-10-0b97279b4e45@subdimension.ro>
 <CAHp75Vf0W9Lge8ycQrx=Y-xKyH4rBr7EVsxLy8gsLZhtE2oqrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cp0i1FQ85qLPA76Z"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf0W9Lge8ycQrx=Y-xKyH4rBr7EVsxLy8gsLZhtE2oqrA@mail.gmail.com>


--cp0i1FQ85qLPA76Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Andy,

On Sun, Sep 14, 2025 at 03:21:30PM +0300, Andy Shevchenko wrote:
> > +#define BMA220_WDT_MASK                                GENMASK(2, 1)
> > +#define BMA220_WDT_OFF                         0x0
> > +#define BMA220_WDT_1MS                         BIT(1)
> > +#define BMA220_WDT_10MS                                GENMASK(1, 0)
>=20
> These do not look like bitfields, please use plain numbers (0, 2, 3).

ok.

> I feel like I commented on this previous time and my comment was ignored.=
=2E.

I can't find your comment. got a link?

best regards,
peter

--cp0i1FQ85qLPA76Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmjHqOsACgkQzyaZmYRO
fzA6wxAA1E8b4RmgS9/9qsp7OP4O1mXih8WpWSXLKFy87nEt9JWLQgOL3BRPUCNd
bexBCzeY48WhCyC8NWmbJmNC25VuqdQ5ZRrRijLdQcVtElbzZVs/kQebkrFCMBEC
h/tQP8e0MQnBd/1mKU/655EqmgcDgQe4kPaqe+ElXZx0V9MHQgWXK/j7/QZBUvvx
c0uWbkYRg1iIjbEEX832ddirSvJC9CjoLty9PP1hT7uYfg+CEz3P2kst9Smh8vYD
mkLihbq/njrU9NizwZILBGC5ppn3y47ImQcL1d0LtgAI8z8j2pTKZvLuPNLl/i1l
lese4mmHnU1jg2mrA1zSUU/l/2i2cIAAOTokSAHEUjITZvl2gpPVrXBgGl9EWbGl
bDg/QKv43ajrktuLFssXP9f5KZPLLetkSukQaKZCHY3UkMjWadpQY7kLDWzXJJey
/jytFddKtTHiQp0IMPGRezBAnpxZsI2ez9DW6/dFNIwRVdV8WdFAHsfxX6Ip5Tb2
K2ck971+fx35f+JpIuaZsozHFQBiq3iRYaQ+Hyl/Lmu/VH9EnUEmmV+FF8dK5P+m
BkUJY0oiNi7M1mZnk4VRLKPAACoUk133JqkfIqafcz4TfODM3Zr1CsWsDmoKDtei
kfY2WaRmVBxojVR5BdWFtmW2vFrdVgH0VFotN6g9DJFDVEk+8sg=
=FYT7
-----END PGP SIGNATURE-----

--cp0i1FQ85qLPA76Z--

