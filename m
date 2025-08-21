Return-Path: <linux-iio+bounces-23114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA31EB302CD
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 21:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C281BC6D32
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761C34AAFE;
	Thu, 21 Aug 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="PyOYl/Aa"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9E34AAF0;
	Thu, 21 Aug 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804103; cv=none; b=gpZl7YEwqa4ZHV05swSxl9Q5wfOkkO85A3MpHL6rNo7E9csMutQIp4G8MB4CpHaf7mxLarmQz7Fng4Hpj1buT3O5GBHPPOWi/3qcr8vE0lp2kFwS86iNNv2bjl3ibotjgG7qfVlOLPnDurTo0mfKDTkFl1agqd4puw/ii7oj7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804103; c=relaxed/simple;
	bh=9mmC57fqiW/CDgmXrXmLgJFmPtncNpi9tgM8einNv+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKvyIrHa0zUb6Wqr19ZKnXXcGM9TW8w+j8qvJAOH9eIC0FT7U8mlQXiShRvvqB4dDzdwhxKe8ajEt6FHjN/uqSmuH6exAS74nHXW2aGeCaMFPk6X9ph999Uaua0QZP3c/6iQe0krD8BXSd0IGSQJ/piGOh3EqRPuSaeXm1vkTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=PyOYl/Aa; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MJPn6pdlhSOyboOro+8VXBZQMw43Z9UgpGkHulJjXTE=; b=PyOYl/AaZYJ2hjEzZVWDwnNXQR
	NqNR2MSP0z6owBZQLtgUOqNyj9ECsdf8ehWSAJqxaLHRVQfooQ0D6GTuLJO8gtLA4uCs3D6KqLVPt
	Vxl8sa60OpIMDIJj/hj+s0KJZwq+jbKPELQm1UvCv9W03AyCO+Km8K4XX0e0uWphgbdiCOVylfNkH
	ffq7oF+fi4tqVdHd+UrGmb3034uifGkeMtmB0fK0GS4dRs6toGa3ad2dIKtnO1nkiKUj6UmIkrnmM
	cDogbj98thcuF1P3Q2JvQuAy9Sez7SXYl1Vm/zr9mE+iRHXEHP7os46NPOFXBSnphKTgB80Jm0kW2
	VQJFHHYQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1upAQ2-000CVe-07;
	Thu, 21 Aug 2025 20:53:49 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1upAQ1-0006XM-10;
	Thu, 21 Aug 2025 20:53:49 +0200
Date: Thu, 21 Aug 2025 20:53:47 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	arthur.becker@sentec.com, perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
	clamor95@gmail.com, emil.gedenryd@axis.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aKdrO7DE8ky2DBu2@mail.your-server.de>
References: <20250715085810.7679-1-ak@it-klinger.de>
 <20250715085810.7679-3-ak@it-klinger.de>
 <aHdWAUMMH43tIqV4@smile.fi.intel.com>
 <aIMy_BHJYNA20k-x@mail.your-server.de>
 <aKbqLpJMCxJd3QXW@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BsflbtbAoRY220fB"
Content-Disposition: inline
In-Reply-To: <aKbqLpJMCxJd3QXW@smile.fi.intel.com>
X-Virus-Scanned: Clear (ClamAV 1.0.7/27739/Thu Aug 21 10:27:23 2025)


--BsflbtbAoRY220fB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Do, 21. Aug =
12:43:
> > > > +	part_id =3D le16_to_cpu(reg);
> > > > +	if (part_id !=3D 0x0001)
> > > > +		dev_info(dev, "Unknown ID %#04x\n", part_id);
> > >=20
> > > For 0 it will print 0 and not 0x0000. Is it okay?
> >=20
> > I just tried and it prints 0x00 if the part_id is 0.
>=20
> This is interesting... So it's not 0, nor 0x0000?

No. It prints 0x00 on my BeagleBoneBlack with kernel 6.16.0-rc5.

Andreas


--BsflbtbAoRY220fB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAminazsACgkQyHDM+xwP
AVErKQv7BcvpopjcA540YIbkMLjXkAhC4E2sIeu0ECxlfQ/1MgQeLW/K99kULoQl
2m2JxkVaHl43qmmLdZwOAsWLOLGMmVrOJVambXsMTHAYqj3iP1sKB7TVmOvW6x0M
VtkRF+41spEStMUfkv8WViRVUvDHM8n/kI1EPZzcxqTBMF4FOyhBVVvM0qMZQDzs
f6SKi3xP8L1i5mCmHlZCC2o3t4Pwq0YT0x7iUGwq1RvGw1cVTkznYZLm8EbiqIt5
gvi3/s+Bp2RA+Hq1jKYEfDIikryYxRKns2UKsjfJ1lQDI9IG2Oqv6DjK0I+GEYLE
ZRQbMLEf9Vi+7/IGvCmHXhU7KJgJmXrMiJlA+g78jR8GjXqjmhKekQfcimsriVFY
z5YiR/zTcqw0iFKfRbDO9rHS7ZuBGiqhnfNmJ8TcXLHUHIMBLWmPZwt61XXTrNUM
Pic8ZJAv4ayAticgCBwz/zzhJt9YrYJktmc6w8hrq4UAbGMtn7pB89HrtxwWLQkF
93iem3Xg
=9IwD
-----END PGP SIGNATURE-----

--BsflbtbAoRY220fB--

