Return-Path: <linux-iio+bounces-600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454CE803A25
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB16A28103D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B872E3F7;
	Mon,  4 Dec 2023 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+nkeW5S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0485395;
	Mon,  4 Dec 2023 16:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DE4C433C7;
	Mon,  4 Dec 2023 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701707138;
	bh=22m4bPVF4Ye6gvOYaIJnR7Fk6Wljx9n9u9W9CAkPDWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+nkeW5SJMT0DXnux7lrwLAzeenRDdPDAHT7JIMJKB++yD3y/qq7ZSu57OhvXkx6i
	 yG/Gg/OSFoHpAyvwm1kpI9M09FsMjPHfAzeg5xlyYwf8Pb98M4EWSPrhl6VQYMCXr8
	 YKTAHFfFj7en6OZGEhPcDsvcW0N0ZWSqInQAlvinczmAgRMdTm/uNF4s+/coClQQVb
	 uqIpNldcd6D5s5w0ILb4gY6t89lfeOivIhJxWAVzUTLJGrZDMUx54/bWR7jNnX5gHE
	 ah2jnG+uZpO5xtdhOnIxtVNorQjWii1fYb8f4086L6+jpAZIbM2MfQo+OPiE0OCIyQ
	 9rRTa0p7Ch83w==
Date: Mon, 4 Dec 2023 16:25:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: iio/adc: qcom,spmi: fix up examples
Message-ID: <20231204-exclude-tapioca-0db6d01640aa@spud>
References: <20231130171628.12257-1-johan+linaro@kernel.org>
 <20231204132624.03733d50@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QAlgK3xkgS7NPjoc"
Content-Disposition: inline
In-Reply-To: <20231204132624.03733d50@jic23-huawei>


--QAlgK3xkgS7NPjoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 01:26:24PM +0000, Jonathan Cameron wrote:
> On Thu, 30 Nov 2023 18:16:22 +0100
> Johan Hovold <johan+linaro@kernel.org> wrote:
>=20
> > When reviewing the various SPMI PMIC bindings, I noticed that several
> > examples were incorrect and misleading and could also use some cleanup.
> >=20
> > This series addresses the iio/adc ones.
>=20
> All look fine to me.  Just waiting for the DT folk to have time to take a=
 look.

Yah, they all look grand to me.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--QAlgK3xkgS7NPjoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW39fgAKCRB4tDGHoIJi
0umlAP41S5c3TE7AyMWFkxiVYj3Wtq1YF0jUGFVVePxnMN6UrwEAyEmXc/dKoaEH
tLiY8u7F9STaiyxQX1C5a1AURXuXqA8=
=rPc4
-----END PGP SIGNATURE-----

--QAlgK3xkgS7NPjoc--

