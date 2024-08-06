Return-Path: <linux-iio+bounces-8283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C51949523
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C404B286D81
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042C4653A;
	Tue,  6 Aug 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFI6D2Yc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92C28683;
	Tue,  6 Aug 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960119; cv=none; b=CzLW8i/6NmaQ/weVStwHfeF+Xrb6DpaESpkfrNVSdmrXAh41vmRzXCEnbrA+QOVN8j9bMkaV/fallL8mN8j1k7lM9QaSZPadKVerEotpXZMKoRa81n2e5b9RYcMITK6oQLcmQaqX0ywjlRENo/zOn30knGD98cz4JWfZNU8JYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960119; c=relaxed/simple;
	bh=3vtD445Fm/8LAmd5d2AXOFWFQRMqgkclZ+9tFFTZK9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So00B9GXOiox6rnFeHmPXr+wYQTRcWA5MJVLJVzDFBgUc1QexRQ94+ye4Z+yn0MHr6SqWh6izjj5qn7hnzvJ+w08zjpWhon0DbbOlWPR0B5faKgcOBVWgNM6yiHC2ysuc9vmZyK/Rh+NN72WhUXZAJf5XIsXBGrn+CyWj9hUWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFI6D2Yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED39DC32786;
	Tue,  6 Aug 2024 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960119;
	bh=3vtD445Fm/8LAmd5d2AXOFWFQRMqgkclZ+9tFFTZK9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFI6D2Yc54zRK1nBf87IgVWmaQXhaILSt/kgJeIR2uctGm+vOfMdyUlkifKnb5+Ui
	 hNMXRGg4YKzk32Yq19mgn0X3MuobAKz79JUJM41iq48SLUWug0/LdRgvNOOOgu1cMf
	 LkMf1njt5DrFhUDukAOZrNzF4N/D1ha7IaBrqwrFaarGiG8aOMqVTqg0WxR7dvuPki
	 hz3fBV0xCqHYwbq4lcrQpYpVoDAoEFVDr+PJ79Eu8j3AArTRzI3uhAQM73FY+1m3qO
	 w4gCtwePg9wzV/jp7GruD3SKojMHfZNEumJCuN1zWQwpuQ7tLCcxQUHWAQROP+g+fO
	 Y73TugISbu6vw==
Date: Tue, 6 Aug 2024 17:01:54 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Albrieux <jonathan.albrieux@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@mainlining.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: imu: magnetometer: Add ak09118
Message-ID: <20240806-crouch-poker-c8ae9cc07e7f@spud>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
 <20240806-ak09918-v2-2-c300da66c198@mainlining.org>
 <20240806-paycheck-visibly-4e114692ae98@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4nDRdZT2HlgzMSJc"
Content-Disposition: inline
In-Reply-To: <20240806-paycheck-visibly-4e114692ae98@spud>


--4nDRdZT2HlgzMSJc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 05:00:44PM +0100, Conor Dooley wrote:
> On Tue, Aug 06, 2024 at 08:10:19AM +0200, Barnab=E1s Cz=E9m=E1n wrote:
> > From: Danila Tikhonov <danila@jiaxyga.com>
> >=20
> > Document asahi-kasei,ak09918 compatible.
>=20
> Please explain what makes this device incompatible with those already in
> the binding and why a fallback is not suitable.

=46rom the driver patch:
| Add additional AK09118 to the magnetometer driver which has the same
| register mapping and scaling as the AK09112 device.

Why isnt a fallback suitable here?


--4nDRdZT2HlgzMSJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrJI8gAKCRB4tDGHoIJi
0hOuAQDDjd6TSxLm8fYz8evmF1fhBUTWM9XpygUdvaSHLB3glAEAup0W2ySfBOwt
xlNnOgTC++zpo+W/wf2KR5mfgcveCQ8=
=bfXv
-----END PGP SIGNATURE-----

--4nDRdZT2HlgzMSJc--

