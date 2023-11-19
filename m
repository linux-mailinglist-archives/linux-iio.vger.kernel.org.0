Return-Path: <linux-iio+bounces-162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DCD7F067D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 14:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A70BB2096D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910DD10A22;
	Sun, 19 Nov 2023 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTw5C7Bt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51845107B2;
	Sun, 19 Nov 2023 13:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A15C433C8;
	Sun, 19 Nov 2023 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700401308;
	bh=uWZuKv5N4zUVwbNVNiCFzHxfITFcbhSnLaP4Ui5fFTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTw5C7Btmzdmy+7BbWU6+iyapnk/QRva0iXhGjv1SRbl3UuTqNzkjm8FQ7x3j2py4
	 ZA3HBrCyTcUasOvvLTgiPpNvTAYQ6hj+t9bgKU2dyw6rcXDQXPuc2NOsDop7KZr93H
	 nWiIXnXXQxJPB/JD80JEAI/65/X69iE+kJkgbU8jkTZskA1bMtd62ZocLOblXSCgaX
	 PgjY8DZWPNJ9W34vKOF3D9ML76MMJbUgLfvCz2oxXiNmMuXLwhZBAUHFVINRN/Iupy
	 8o4METhrXn6Klwkm2izOjeG+f250xo5lrtvJdquQW9ITF4Ca+QG9SJPFh03GaLVHxV
	 oYKVDO4YvYfiA==
Date: Sun, 19 Nov 2023 13:41:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Li peiyu <579lpy@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: humidity: Add TI HDC302x support
Message-ID: <20231119-donated-hypnotist-33529b63bee8@spud>
References: <20231118105815.17171-1-579lpy@gmail.com>
 <20231118110232.17261-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kk2ARJ5ujP5J6eF3"
Content-Disposition: inline
In-Reply-To: <20231118110232.17261-1-579lpy@gmail.com>


--Kk2ARJ5ujP5J6eF3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 07:02:32PM +0800, Li peiyu wrote:
> Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> temperature sensors.
>=20
> changes for v2:

Changelog needs to be below the --- line so that it doesn't end up in
the commit log.

> - change the maintainers to me.
> - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.

Does that even compile? It was the binding I wanted you to change, not
the driver. Take a look at the example-schema for how to do this.

Cheers,
Conor.

--Kk2ARJ5ujP5J6eF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVoQmAAKCRB4tDGHoIJi
0jSYAP41RGT8QYdUAb9zkFk3WzU+bpoKjRVX+lDgxqQ1kHAPAAEAm7GdkHDMyrOM
V81WtgMCG0DbIBWu5DfC0BzSM6jBPw0=
=L7gs
-----END PGP SIGNATURE-----

--Kk2ARJ5ujP5J6eF3--

