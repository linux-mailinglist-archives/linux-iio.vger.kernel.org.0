Return-Path: <linux-iio+bounces-16452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6DA54272
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 06:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708F5169568
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 05:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBAC1990AB;
	Thu,  6 Mar 2025 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHM+s7re"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597DA94F;
	Thu,  6 Mar 2025 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240264; cv=none; b=NiaBJ1zUxaTI2anoMVuvog/4WACwecgTp3g/Ud8r8PgngkyALygT6AmqBGPugAQ2SLlbCsvHIX/KGL397HvKRBIDXRuGSenoIkOBDPVCzSQQj+Ic/HoVtSu5KztN6c0FpgT25DUBRkGzalfChqtpH/wjkB7uHiVSuKjej3UI2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240264; c=relaxed/simple;
	bh=mQKtHFDdhQ3Yo3y25Nq5gKNB0XaDYanapvwpAjYjGCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbqRMBobdi9m0xLqk187+nEXd5IHthewxNFDnyyPaXT31PC/xOjD870V2OVTSOS7KPAHHJQGSp4RrRaAkHhTKISsCk13ER9XXiqeHb4CrREu1KqF3Gu4ob6OdILK6PjltKffXI7XIboakRZUe+6PJrmTL3tSl4sH4I4VtmA+gxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHM+s7re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF60DC4CEE4;
	Thu,  6 Mar 2025 05:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741240263;
	bh=mQKtHFDdhQ3Yo3y25Nq5gKNB0XaDYanapvwpAjYjGCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHM+s7revVxn/DFM1r0AOx7CFBYgPk0FX7CpopgiuFK1PjeWsb/OgQs1SNOcohqJj
	 W/8Os9yMuKOr5Odk+IuGfk5ZArAT1YQFAk/3OCMrjLL8PIVRKOjaLGqOAsXLmLdYHT
	 flmbzTJl3fcp89t82nZlntfWO3CU91C1eTxNEcE4YEvcmtWCbNaMGR1JGMS8vkYbFM
	 0RTXLHFt/ig6mffCXqytD4Fj19Q+VE+TPSYn+aa0MEJTtskE9vOvmT3jIfKfaRS5wQ
	 wNnYY8uSzebFA+2WO6zqcvkgILegPgPgnNi3pZXQnMjTe+XIwzcqrihgDH4SRmCsIq
	 2o8jXNE6d3hiQ==
Date: Thu, 6 Mar 2025 14:51:00 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v7 2/2] counter: microchip-tcb-capture: Add capture
 extensions for registers RA/RB
Message-ID: <Z8k3xLaR2c1IR9uu@ishi>
References: <20250304155156.374150-1-csokas.bence@prolan.hu>
 <20250304155156.374150-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9nsbFTYlHPaQ7KFg"
Content-Disposition: inline
In-Reply-To: <20250304155156.374150-3-csokas.bence@prolan.hu>


--9nsbFTYlHPaQ7KFg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 04:51:52PM +0100, Bence Cs=F3k=E1s wrote:
> TCB hardware is capable of capturing the timer value to registers RA and
> RB. Add these registers as capture extensions.
>=20
> Signed-off-by: Bence Cs=F3k=E1s <csokas.bence@prolan.hu>

I'm putting my Acked-by line here to be a remainder for myself in the
next revision that this patch is fine and I already reviewed it.

Acked-by: William Breathitt Gray <wbg@kernel.org>

--9nsbFTYlHPaQ7KFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8k3xAAKCRC1SFbKvhIj
K1vkAP9uzi11I3Aa+bUH23E5MRlm7xr1Gf+8eHmAyANXwrZqHAD+IYkv2pqOFQuq
eMxDEEY7ZcqlYTgk8j7gNoFb72d+oAI=
=7c47
-----END PGP SIGNATURE-----

--9nsbFTYlHPaQ7KFg--

