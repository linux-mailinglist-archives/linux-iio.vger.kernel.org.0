Return-Path: <linux-iio+bounces-19515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7060EAB7112
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E6F1B63571
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423527A442;
	Wed, 14 May 2025 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va79Lqq/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7B2797AB;
	Wed, 14 May 2025 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239572; cv=none; b=Tg/9uk74lPF+cdMSStfdFSHnV25ZYqE7q//NjigaMHdPnEhDmmqi5iC5/riGsWGGb6VRffyGGnDmUV9vW0uO2gw+6q+mZsx0dINR9JovZyB5GXndiNHZ35U7hoUB7BORU8vNktYhNaNGi9t7Or+N5bdTVgxDP7hctDZ0NpjYCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239572; c=relaxed/simple;
	bh=TkcKReooaX7BWS/X7043yb29DlAjrU6sVJsBD2so59o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFkxG69A4TujyYv/IRtZH5+cnIV6YNNFjnRH94XSjJT/QKv25q1NloRVsNuePXvkx2AleJoJz3J1HN7gAntqi9iTRVaHUVPmch/T5+9YttSS9x79zOOI5iS9xZcTtbw4LsyG16vcOBUgEdKQiQ7H5nWddabzfNRAF6D8L1yMxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va79Lqq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496F9C4CEE3;
	Wed, 14 May 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239571;
	bh=TkcKReooaX7BWS/X7043yb29DlAjrU6sVJsBD2so59o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Va79Lqq/yhvHgFZ6MuuLDL2mVIHmbUPKMAmBOSwLwdT7Whr7v5fwOvh+ASzXy1k8I
	 P7liWHi43ooRWLnCbZtmNWyBUDYPr+TnacRvr2xO6ZlMSK5Zy1aXiEjgTQla9A3E46
	 wbTURDIBcs1q3/v8wuKJWgrzaT94YJJkL5H2TI3mNMqw/s2C63yVvkYQ/qiqnWS50I
	 aaW+OcwoxFQiBEW+ZkO6OpRZG4JHeAt7sZculNzaDhMUmJtSgdQHbrjlfqe+/j80ir
	 wcczzQM+oKa8Xax/hLgt5M/ddgH2mtuubMJTypAGzxyVrwGzbN6TBHwdwaw5DMIcLT
	 XsuMgeMYpiErA==
Date: Wed, 14 May 2025 17:19:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dima.fedrau@gmail.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: smi330: Add binding
Message-ID: <20250514-deserve-marina-224bef5b2db3@spud>
References: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
 <20250513150028.42775-2-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4s1uKMatRE6dYioR"
Content-Disposition: inline
In-Reply-To: <20250513150028.42775-2-Jianping.Shen@de.bosch.com>


--4s1uKMatRE6dYioR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 05:00:27PM +0200, Jianping.Shen@de.bosch.com wrote:
> From: Jianping Shen <Jianping.Shen@de.bosch.com>
>=20
> Add devicetree binding for Bosch imu smi330.
> The smi330 is a combined three axis angular rate and
> three axis acceleration sensor module.
>=20
> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--4s1uKMatRE6dYioR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCTCjwAKCRB4tDGHoIJi
0lSKAP9XoBcsBcAdPPriU4TgFQX92hjMfjGf7mekfhfTPRNkrgD8D00B/qrlj8XA
7fmpWz5WiL9b0XbGEhRbFScC7dmT0Qs=
=jlLn
-----END PGP SIGNATURE-----

--4s1uKMatRE6dYioR--

