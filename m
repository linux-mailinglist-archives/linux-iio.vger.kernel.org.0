Return-Path: <linux-iio+bounces-4095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4858E89A238
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 18:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0381A286B8C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D00171086;
	Fri,  5 Apr 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0ldclR+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCE16FF30;
	Fri,  5 Apr 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333687; cv=none; b=JbPbHY0DM82SgoO4M4WBLzDdSv6On8W4Snk4aysLHmplrYu69/0/sE8DrLZPSyhcw1eLP7LQH721bVVT35ELK/3bw/jXE3uMZiGG8VnEtyOTboRJIdhemQey2Dl8EW+B8ttjv3bzsVwS0YzOgm/IOJEJ3SQ9qOOrUcwbFqdCcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333687; c=relaxed/simple;
	bh=fg6kttbbMyChyDhAlKD1eJunLa6vLfVh9tocuUau+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM9RRTjaEVPRB81x7ueaicHzVozT7mBsh7ISyQCKawcRjNFXe1XOASuTjvonCZexSLHoWhDQT4czpmyEvbUFnFhwd2pRp3ld4LZFBSTUagd1g2uWUJuhTs2n89r+LTZmNZyWNGJd9GsBr4fgazSi9Xa74ZJDknZgFzdvSZRrw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0ldclR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DCBC433C7;
	Fri,  5 Apr 2024 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712333687;
	bh=fg6kttbbMyChyDhAlKD1eJunLa6vLfVh9tocuUau+NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0ldclR+s26yoy0wmPyV/OmMSJo0CGtKIEG698qoqfKUyEbB4MxapxXtwmbA+dIhN
	 5Xr2NjAsGjbp2nEJx7nd05ygCmOIssu8uw+B6AQvDI7JikQOCdbo+I/UjAk1uJxZP6
	 5EbipyM606ugAHXtVbGe1VzTwLSYyy0YH/vHbICpw44MnkGH0cf5CYMSWecE1saBB9
	 iV7bdiUjsgNxt8hJ68UG7j3qi5Jatwo+oO82CTh2KEXaoGACkHKlppVWrsV7DAqZv8
	 iSHEQoiDFTR72+18L+P+rG55C5YvdFLDvdQjtw0LagoaYluaMsIvpSyobXvmz0hyuq
	 dZo2W8zXvZrgg==
Date: Fri, 5 Apr 2024 17:14:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Marius.Cristea@microchip.com
Cc: jic23@kernel.org, Conor.Dooley@microchip.com, linux@roeck-us.net,
	jdelvare@suse.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, lars@metafoo.de,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: adding support for PAC193x
Message-ID: <20240405-dreamboat-posh-d8c7c2c8c35a@spud>
References: <20240222164206.65700-1-marius.cristea@microchip.com>
 <20240222164206.65700-3-marius.cristea@microchip.com>
 <20240224191559.40d233db@jic23-huawei>
 <20240405-embellish-bonnet-ab5f10560d93@wendy>
 <e432bddc16952d9144ccf6da5a54b88e3171b947.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kMmp7rBo0l2l8BHj"
Content-Disposition: inline
In-Reply-To: <e432bddc16952d9144ccf6da5a54b88e3171b947.camel@microchip.com>


--kMmp7rBo0l2l8BHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 12:53:38PM +0000, Marius.Cristea@microchip.com wrot=
e:
> Hi Conor,
>=20
>     Thanks for reporting the bug. I have detect it and I'm already
> working on a patch for it.

Oh cool, keep me posted :)

--kMmp7rBo0l2l8BHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhAjcgAKCRB4tDGHoIJi
0qfAAP0bCFojvFUV/W5HjACrgzvBBdX0YzYJgshqEHZSLzFg+QD/QR1G+P2ep8ux
HubIkUCrZGFyKzZD6toPesago84FywU=
=DuRu
-----END PGP SIGNATURE-----

--kMmp7rBo0l2l8BHj--

