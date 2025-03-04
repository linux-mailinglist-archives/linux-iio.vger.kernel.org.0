Return-Path: <linux-iio+bounces-16329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146C5A4DA42
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 11:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD093AC72E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A91FECAF;
	Tue,  4 Mar 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXg83nEv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3B1FAC50;
	Tue,  4 Mar 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083700; cv=none; b=BSNrN/W3GVAsO6Tx5cAsmoe9dwFrfKbMZO5ydGsB33U+LfHjQgYI8IT1I275+aYDasAYWMTlGOixdqO1qWX/5aNyxwkJgzaK2KeE4/KqRuHp+qXMsLJUEn8Asx7DzWwGxOuM6KhkFjeYzDVVkBe7wNGeXCV7PCx/5CNWKnxG4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083700; c=relaxed/simple;
	bh=zjCfzkJWAuREuIOJtX7TyjCt6YvD8DU4xNEMjHgcK4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUrFUeQJn5JyA3rICnMxfMdO4clQ9vxmndNU0urXUx2uWP2HFZkt1jO84o8wxyUwKyPXzq5OiHm5nFVfrRTs+UcWVIufrEn1juOPgN+IU6EI9LdmPUYsgMK/cy49YDIhm653xnTOLe5448ZuN7qVO8PKNsMXM8pzpp/u3/uMaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXg83nEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86506C4CEE5;
	Tue,  4 Mar 2025 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741083699;
	bh=zjCfzkJWAuREuIOJtX7TyjCt6YvD8DU4xNEMjHgcK4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXg83nEvmhFddBKQkWuL1eWXfxRdJQSPBBjEIKx6iMvMCHtJfBU4Q23zSJTVdpwAE
	 BszUnEoe2edhT+0kPZwoOJg14R5z0Ie3SX/mA+i9OeHr9U2K8U2EReXklhEt5M/oOk
	 YovJCudVjhpPBfnJfv3ytmGv3pWeIBfhjnxQ9DYhlet9AAJTOID2H/SbjjHBdOsPAt
	 SX1chnX26HOg9juOVKHepSvEcy4LvoVNNddjVUYtTgaCZDnWe92vhjeuiBd06S/pAu
	 nxarxFw73Ma/zt03aNkveQ75bOimb0bFDgFtqMt76oWsX99O2CRVwiNP1GdDheJihv
	 jMzMSnsGeVhIA==
Date: Tue, 4 Mar 2025 19:21:35 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v6 3/3] counter: microchip-tcb-capture: Add capture
 extensions for registers RA/RB
Message-ID: <Z8bULwq70CAAQRSe@ishi>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-4-csokas.bence@prolan.hu>
 <Z8awGBW8obpG1QPN@ishi>
 <1604dce5-7be6-4a95-a51c-0c760a6c9a76@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8RKMqNlmenfe7hgf"
Content-Disposition: inline
In-Reply-To: <1604dce5-7be6-4a95-a51c-0c760a6c9a76@prolan.hu>


--8RKMqNlmenfe7hgf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 11:03:17AM +0100, Cs=F3k=E1s Bence wrote:
> On 2025. 03. 04. 8:47, William Breathitt Gray wrote:
> > One final comment: is RA/RB the best way to differentiate these? One of
> > the benefits of abstraction layers is that users won't need to be
> > concerned about the hardware details, and naming the capture values
> > after their respective general register hardware names feels somewhat
> > antithetic to that end.
> >=20
> > I imagine there are better ways to refer to these that would communicate
> > their relationship better, such as "primary capture" and "secondary
> > capture". However at that point capture0 and capture1 would seem
> > obvious enough, in which case you might not even need to expose these to
> > userspace at all.
>=20
> Hmm. Well, RA and RB is what it says in the datasheet, and since we don't=
 do
> much processing on their value, I'd say we're still closely coupled to the
> hardware. So, if one wants to understand what they do, they will have to
> read the datasheet anyways in which case I think it's best to be consiste=
nt
> with it naming-wise.

All right, let's keep it as RA and RA then.

William Breathitt Gray

--8RKMqNlmenfe7hgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8bULwAKCRC1SFbKvhIj
Kw8WAQCRpc2Qw5kFGL9s5kdxmZ56vP/4YntVebgyQRU1I8GNUwEAk9SWhblz25jK
Owtuglyhwhnmmc2OriiggEtxWMOhfAc=
=ihCK
-----END PGP SIGNATURE-----

--8RKMqNlmenfe7hgf--

