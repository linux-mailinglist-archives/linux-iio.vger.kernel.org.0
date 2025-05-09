Return-Path: <linux-iio+bounces-19396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B36AB1A2A
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6D3A01562
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07B2367B6;
	Fri,  9 May 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmoxnkmu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78E1EEF9;
	Fri,  9 May 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807148; cv=none; b=MOblTfyaNqrj96GZkLZz3SwSh3Io5z64TCBbxBuYZJAmH7a2Xx6WoiVa/JgJ96UCmuVw+ngLYa8U6Ut8d1p1DLLSTQhE8QAIjNc74A+HPEFXw3//T7F0nmGon5/k5SQU2b2STfVWF/ubf1Cv7xdeGwgCx7yu4a/cfaIWrkYcaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807148; c=relaxed/simple;
	bh=Dq5D69yoWswbvYRIjmfWPM2poV9CNK84eRZfBB1U4vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbvoYvQFqmoK/OAZ4KL4GKMAw+wLmVSTP5BECX1He0lHy5MYqqei4vkrVHXKcbqMbqX+PZSx38JNF3cYnU4J1UGUKmNlQV3EJrHl1VwN3p6itW9MmJ1iWFwd6xbfjec61ptHV5Az7h9fn9K4A/dZymHHUa6APUk6fztomG+xdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmoxnkmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24923C4CEE4;
	Fri,  9 May 2025 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807147;
	bh=Dq5D69yoWswbvYRIjmfWPM2poV9CNK84eRZfBB1U4vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmoxnkmuQ6WEChssh/bpWoWzZjyCkDBCUQAA9nRccmin1od2A+VeV2P6l/dxmF7cO
	 FQ8qlSv2aMmpQ4OeIN0jh6TN5+o0ALBy23EL3GxFC3dK93TwFw29vG2K6Trcxcq1G8
	 V6REOtqNkyvTbfiRuJw034xrqLyLtQehzQISrRiU568Wf2pxfSbYE0k4hTd33vtWAq
	 ofLCQnoFJRUBghfwcIYuteuvXx44KclbZJJtzeooriI7tSdYmzILr7pWkzJMfwqNSV
	 2gVowfEcZIWWMWRByMUE+FO12Qn4+8SweFxmZLTgXw7nMQDuw2dqQMh7UzYAiyXWtx
	 wLAASq4jIxAVA==
Date: Fri, 9 May 2025 17:12:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	David Lechner <dlechner@baylirbe.com>
Subject: Re: [PATCH v7 03/12] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250509-unthawed-opossum-ae1888537954@spud>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
 <731196750f27eee0bad5493647edb2f67a05a6e2.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jN6WHZCkGBJH0ccQ"
Content-Disposition: inline
In-Reply-To: <731196750f27eee0bad5493647edb2f67a05a6e2.1746662899.git.Jonathan.Santos@analog.com>


--jN6WHZCkGBJH0ccQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 02:03:30PM -0300, Jonathan Santos wrote:
> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
>=20
> Introduce the 'trigger-sources' property to enable SPI-based
> synchronization via SYNC_OUT pin, along with additional optional
> entries for GPIO3 and DRDY pins.
>=20
> Also create #trigger-source-cells property to differentiate the trigger
> sources provided by the ADC. To improve readability, create a
> adi,ad7768-1.h header with the macros for the cell values.
>=20
> While at it, add description to the interrupts property.
>=20
> Reviewed-by: David Lechner <dlechner@baylirbe.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--jN6WHZCkGBJH0ccQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaB4pZQAKCRB4tDGHoIJi
0mNaAQDdL1y/TThdxI7fc/v/G9631xi3DvNyDsHo2KeSIYpxXwEA7CJZC9ZTcIAn
D3uw/yJWhVle7cB0wkP88O+9Jf1/CQk=
=rMZV
-----END PGP SIGNATURE-----

--jN6WHZCkGBJH0ccQ--

