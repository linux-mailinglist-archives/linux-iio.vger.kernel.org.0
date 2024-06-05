Return-Path: <linux-iio+bounces-5831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74898FCCBB
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF191C20F89
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115521953AA;
	Wed,  5 Jun 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk4Guu8K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD51922EF;
	Wed,  5 Jun 2024 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588931; cv=none; b=qy/TT8SZ0L6H35Tx+ufKvt6pU0rXqrV20/8DNtHxYBHkXUbeWU7/FxXIQMPHwHma0vx8OcTBxa8chv7snwoUgD1FDxFiu2QO1GqPS7KWBrgHDTK/6LJKRZ1lm5vUT/JD0CJwQ+C+alatMnP5w7wgYnrXeIoXPNTf3lZmSg37n9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588931; c=relaxed/simple;
	bh=/JnJk3u3YJWebePHGZA49ncRq+3Mnp8aSYns2ZppWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfAuU1aG4/BZ3hmw/ZswQBoWNT3XTh+1lpOV3TjjjPsDjsUZXzXZsEICRxLZCjtVuFFakD5SeEL4f8+qzpMLLmC/Tr9DZ+aIV//E814kGEKi8bdsVerAhV+SoTBAwX2lchrN6PgJZrNTNc3Yd1k/yk/+eQ4wzPe27T6IlvPVxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk4Guu8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BA8C3277B;
	Wed,  5 Jun 2024 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588931;
	bh=/JnJk3u3YJWebePHGZA49ncRq+3Mnp8aSYns2ZppWUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gk4Guu8K+DqS+cUPtAVn0hZwmjBBtmWB4X8YB5gJ42F8B2oEr1dTG2IzPg5oY25uT
	 YqEYVs5Fn3dJkCMhGU/1cPVkGL06iLW//ylGxxZhy/BLApk4SJrPS77naHX3eCfe1Q
	 lV6nXmOcl3xcRE26+vcXqlfJ7MCb+EAVpaqeAtABFMVJO0SvbS7GIXGiGQlV8GeVr0
	 5lDycKUi68A0QaG1AnwyAqKruPW+eaiMrj/bHN0QNZvb6c3Z4z4WloxwearRbEH2Gx
	 JH3pXxBUiLj4MaA8dJ0ghoS34R3r95XQ59sMsoUVxndKyhLzH8mTIWiiJkxGy8aDlM
	 KvjriudQXlYyA==
Date: Wed, 5 Jun 2024 13:02:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <67f94cfb-6a33-4390-8032-a942f5f7b944@sirena.org.uk>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <21d3314355b43ecd6acc42f9dfedec501418332d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mHnYXajvsMh4YQv8"
Content-Disposition: inline
In-Reply-To: <21d3314355b43ecd6acc42f9dfedec501418332d.camel@gmail.com>
X-Cookie: Simulated picture.


--mHnYXajvsMh4YQv8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 11:14:33AM +0200, Nuno S=E1 wrote:
> On Tue, 2024-06-04 at 19:41 -0300, Marcelo Schmitt wrote:

> > +	/* Check against conflicting MOSI idle configuration */
> > +	if ((spi->mode & SPI_MOSI_IDLE_LOW) && (spi->mode &
> > SPI_MOSI_IDLE_HIGH)) {
> > +		dev_warn(&spi->dev,
> > +			 "setup: erratic MOSI idle configuration. Set to idle
> > low\n");
> > +		spi->mode &=3D ~SPI_MOSI_IDLE_HIGH;
> > +	}

> Should we assume such a thing? IOW, should this be treated as a warning o=
r a
> real error? I would assume this should be a configuration error and retur=
n -
> EINVAL but...

Right, and the error message isn't very clear.

--mHnYXajvsMh4YQv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZgU7wACgkQJNaLcl1U
h9A0/ggAgTnq3tUcFs/WHjsTmKen81FYend6Evg4EOrYaNr+oZYdmcjeA66KPgrD
vYwFJb8WGJFeUKw0f5BKIUMhaKfrPaQWbnNWcgd/PijcnpVPUpeSmcZhFrqyrBh6
t55SxVxckcatxKdiNFg4jkAA8VrVQe+kSMcldyEfoj57VBURiL/KDMDHZX8Dibe6
aqfyos5JxZgkSoQtKxPBNCLglqNAxDn2EXSkUFYychLsWu3YiDJt9DegA8ueq4XF
vO5kCGFX+koWdOF8YS0a1NmDs/Stt86OzpJNTfwoFrnJtsbOtim71pkAM/aZsBgO
7Jqoa4uiUvDtAWt0aOGNJw7jHvKPag==
=Y7mf
-----END PGP SIGNATURE-----

--mHnYXajvsMh4YQv8--

