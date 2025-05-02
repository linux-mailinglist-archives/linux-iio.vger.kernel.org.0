Return-Path: <linux-iio+bounces-19013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915AFAA7D6E
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 01:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDA39871D5
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 23:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB3202F7B;
	Fri,  2 May 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heQgKWDF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746EE347C7;
	Fri,  2 May 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229640; cv=none; b=DdWVZZtcV3REagL5E5BorUFgSrY/46lr3MoXFZg9IGW3dAqiVVkDLPwlP6pwMiSHp8dOIrPvQjWaCt/ValFAzbaFk5rczg08MdQKF0MPBWRfmtzxw2IgtfBB4Xq7BwFw6Dx4SCTKe+mELqdvdeq5hQ3aR8hN0ILPwpuhHIaIHE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229640; c=relaxed/simple;
	bh=chQbFHWLyDPIYT5CGAaXyflprQGIG9eqxJXMs3mUwYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exnnIaHQZSAT2vN6egEPMS6xkeQSRMOeUJa1YQKsZp3NQfkidhusrPRfw+BNnC9HYSAK3O6+rmh9jLRVW4cGWf5dfzvTrdZJCwgnWotbr3jik18xLfhm++rLUMTUuiDmmteAN3wllYCAEUvUsnoqlHxtkISgQs87H66NT603Gxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heQgKWDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E4CC4CEE4;
	Fri,  2 May 2025 23:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746229638;
	bh=chQbFHWLyDPIYT5CGAaXyflprQGIG9eqxJXMs3mUwYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heQgKWDFtK+tL0BzKJ7maJJycUDb6+L8nowi/RjOjn4YunXTNCWqi1X+EepnEEbh8
	 zbY6R3FIKIkCdNHdSHFVIUxZSBsoYFgEV5KIEJRPvv41WVzPk3ibid2HEohOT+MwqE
	 e9X72kfFt1cSh7rO9Xt9u179RmHqEEPPKOK9Rpmg0pLn/ST83g0fq0oQ/2F1ATDGaR
	 3EudB3g826HSMn3dS8BDXpKkl+02xy7q8ngXVyXRlKrcJpscO9Ch92K7Jn8EM/QMKa
	 pPd4+VF2hGhnNYZ8rP5Gom/uqeFhzs54t1Q7osTO/s6loMgPnO17D41q6huw5yNxEE
	 5OLv7u4V+8BMA==
Date: Sat, 3 May 2025 08:47:15 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Message-ID: <aBVZg9ex8hBeRHLu@ishi>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
 <jir0aD7w3brmbPDdhC4xAhaEKCp-g08TBmtdn785u_Z5M77ZHMhsK7UoamaROSznl2WmcUmPSnocgVnCSYmUYg==@protonmail.internalid>
 <8394ef31a75fdf9122331ecb97dd6f986d5026f1.camel@siemens.com>
 <aBSv1pJ1mulT78gn@ishi>
 <ay4R_4q_htTRo8OdeJU2BdGIrWTv9VWlVN45cxdf77cb3ctchWcCdgaGynnmtKiKUwvEChh3y95zwPV7vrgfxw==@protonmail.internalid>
 <f1e4a1db585e58aca766d0f48ebce3a28986944f.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mzpr6YeyzpzfWdpH"
Content-Disposition: inline
In-Reply-To: <f1e4a1db585e58aca766d0f48ebce3a28986944f.camel@siemens.com>


--mzpr6YeyzpzfWdpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 04:32:02PM +0000, Sverdlin, Alexander wrote:
> On Fri, 2025-05-02 at 20:43 +0900, William Breathitt Gray wrote:
> > Would you provide a Fixes line so the stable trees can pick this up for
> > the necessary kernel versions?
>=20
> shall I re-spin or would this separate tag suffice?
>=20
> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")

No need to resend, I'll add in this Fixes line as I pick it up.

Thanks!

William Breathitt Gray

--mzpr6YeyzpzfWdpH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaBVZgwAKCRC1SFbKvhIj
K3zKAQD/MP8Df8zftdF1fkr08FMi0V+IQcVFHH4SmvRBjvEtSwD5AYrTHZClNBdN
NOz2gc651mKBGvkrHmzrRB4UM5nocwQ=
=I64P
-----END PGP SIGNATURE-----

--mzpr6YeyzpzfWdpH--

