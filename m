Return-Path: <linux-iio+bounces-6293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38C90981E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EA92837E8
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B744C87;
	Sat, 15 Jun 2024 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiCOtB+B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A634A3D;
	Sat, 15 Jun 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453469; cv=none; b=V9gOJnTQZlXUKUcoEhFNJSzIXfKrSOD/u+CAEur4bJmXXCgULuQSYxIggQagnwY457Yn4MaOre2VFGyHHpKPH2hkEARoK9fBxewJGJUXLvL4OkWQhgfnxUrzaEV+jCN7pfS8+QUNlK2x6IGof2effLwpNugtnp6s3S5KieF2WjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453469; c=relaxed/simple;
	bh=YH+odpFULabpJU7aqXqApLDVXyYv+Y2IFr46RtpYOIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxWWJBoNtlGQeCCk6O2YmFYbVdgK6+NjJNxKAqXfjKvTstTXSqhpsKrN5YXpKMJHFBW6oOJQSrcdGhQj47JeczoCG/ahdBmF2ELsEYMCOW0K1QE+AV4K0dsW+PpEqX3wRQPJ6VQcf6MtXPm2LSUoIvMyqS6sHK+G8QLHCXRnH1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiCOtB+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10161C116B1;
	Sat, 15 Jun 2024 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718453468;
	bh=YH+odpFULabpJU7aqXqApLDVXyYv+Y2IFr46RtpYOIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiCOtB+Bg0I1YxN2iSUhJ9GpEwAdmGE0lzrAFyKiYsjoSCp4AUb/HPrBvlwRnpdj2
	 UqdsOMCtPbUrn6mXLG9daRt59zp5KKMQnjMLTAQ4UW8Ny5i1L2Aed8kiKKCIL+ajO/
	 oVc6GgL6SEYqEkGZ+YBnXKHERWAF9WImvTpmgwGloOWpuJwnvXFJ3U5a1pi3UPzT0T
	 3Pzfa3bjIe3OHbRCYFX1qG27/moAYnnay9HbQE7PvzrPo3LvDFI+aOemw8FkcVcUXP
	 lN7eg4YpApeCr4p/5gQPVVwJuMk1oWeYn67nf1wRJGnr4D98Z1IkX9NbANrNjoqYHv
	 ANco+4CIxkYdA==
Date: Sat, 15 Jun 2024 13:11:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, denis.ciocca@st.com,
	devicetree@vger.kernel.org, linus.walleij@linaro.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
Message-ID: <20240615-urgent-mammogram-3eb5ca127239@spud>
References: <20240611160821.13941-1-kauschluss@disroot.org>
 <20240611160821.13941-2-kauschluss@disroot.org>
 <20240611-reassign-eliminate-b05e4a302cfb@spud>
 <56ab50d7c542356b7e377023b84a6018@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gb03HWEHd/0r06Zb"
Content-Disposition: inline
In-Reply-To: <56ab50d7c542356b7e377023b84a6018@disroot.org>


--Gb03HWEHd/0r06Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 09:46:59AM +0000, Kaustabh Chakraborty wrote:
> On 2024-06-11 18:17, Conor Dooley wrote:
> > On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wrote:
> >> Add compatible for LIS2DS12 accelerometer by STMicroelectronics.
> >=20
> > I can see that! Your commit message should mention why this device
> > is not compatible with existing variants.
>=20
> Sure, is adding the WhoAmI value enough? Or do I also have to
> explain the different registers and sensor settings.

The whoami isn't sufficient, but if there's registers that behave
differently etc, please mention those.

Thanks,
Conor.

--Gb03HWEHd/0r06Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZm2E2AAKCRB4tDGHoIJi
0tMOAQDmSwRtYBwPeSLPrnX/LWpQKFNlmA0/jUyZF/ydJEiH/AD+LWBIX0Iot+C/
7dqyjMvJJtg2LAfjEKkRFMB2r7qbOwg=
=BQzc
-----END PGP SIGNATURE-----

--Gb03HWEHd/0r06Zb--

