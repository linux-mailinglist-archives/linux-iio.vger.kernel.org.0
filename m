Return-Path: <linux-iio+bounces-18985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF05AA7131
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 14:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740A73A9199
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2BC248F4E;
	Fri,  2 May 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAhib/0q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B40241131;
	Fri,  2 May 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187573; cv=none; b=hF2LJ+RfexJVcAiksIeMmJrrcUHJxWpDTHODPXB3CCrkV6znueti8uER6o/MJDw82bzKEYYF62SiwgWKKJvSvphYkeAl3HguvKSxpe/g8LnfqjythvjDScXDhiaPJbd9si8RdyGyLQXw/rMXjOvb3pJU6yNHQsK1brQLeF5PPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187573; c=relaxed/simple;
	bh=ylTDMNTJsX+fU1Fc1DS/h8rpSxVIonrpJGIhDeOznP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFTESal7qNFveVsANUe4JCqUnVzc3CM6D1/DrKSq882dy0/pF9LXQHUNx82fQQqRg08KfDmWn2k20KK22DLhVJHYR72TtEG4s7xyOIE3ur5ugdcDsNxykuJmLZUSD1iCnobzOrH5skAk8/Y2Srv3bdWNSbApEqkjB9sBBeYH8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAhib/0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2115C4CEE4;
	Fri,  2 May 2025 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746187572;
	bh=ylTDMNTJsX+fU1Fc1DS/h8rpSxVIonrpJGIhDeOznP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAhib/0qiIR/x/ZP1Nqx2RdkhB634Dxmg0HP27rSPENeLrfCwulU4fGLCNFPErn5E
	 tB270rs6P4iO+9sHEcAvXiGL7ppgIrI3eQApWiSi2rV9OB/AIzDxqsTJJOLAEJYwxZ
	 P6W9iiEMjgsTH68TcrTNKFVbAzw1QUVRzPp+YmSbS9U2ba4w5xdCkYJu0VTJsdjZmS
	 D0QK2RwEGR0dp265b3VGzXW/QWqO7l3UtrqyNhmFa9RCWPA647iIUm+Y6F1YWpdu1p
	 RQkybCVXO3BeCUjoHWip51b/wW6B4NoBD8M8cm89Dl8zqfz+7E59QjTOqjM52lWq6p
	 NXIctjzUI2nqg==
Date: Fri, 2 May 2025 21:06:09 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Message-ID: <aBS1Mbta2iAV4EX-@ishi>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
 <jir0aD7w3brmbPDdhC4xAhaEKCp-g08TBmtdn785u_Z5M77ZHMhsK7UoamaROSznl2WmcUmPSnocgVnCSYmUYg==@protonmail.internalid>
 <8394ef31a75fdf9122331ecb97dd6f986d5026f1.camel@siemens.com>
 <aBSv1pJ1mulT78gn@ishi>
 <T0L7ZCpSzY8FaifF0VyBKLHBAndGU6TVQvtDuTbuqP4obrm-klTY7wbgRJucvcTHklGYVpYkn5rD3nioq756lw==@protonmail.internalid>
 <aBSxgDuw42kPlweT@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6cTzLjJd0PAya12u"
Content-Disposition: inline
In-Reply-To: <aBSxgDuw42kPlweT@pengutronix.de>


--6cTzLjJd0PAya12u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 01:50:24PM +0200, Oleksij Rempel wrote:
> On Fri, May 02, 2025 at 08:43:18PM +0900, William Breathitt Gray wrote:
> > On Fri, May 02, 2025 at 09:24:20AM +0000, Sverdlin, Alexander wrote:
> > > I've noticed that the patch has been marked as "Changes Requested" in
> > > the patchwork, could it be a mistake? Because I never received any
> > > change request.
> >
> > Hi Alexander,
> >
> > I can't comment on the patchwork status because I don't use that
> > service, but I apologize nonetheless for the delay in responding to your
> > patch submission. I'm hoping for an Ack from Oleksij, but this is a
> > pretty straight-forward fix that I'll be happy to pick it up regardless.
> >
> > Would you provide a Fixes line so the stable trees can pick this up for
> > the necessary kernel versions?
>=20
> Sorry for delay, you can add my
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thanks Oleksij!

Would you provide an Ack as well for Alexander's other interrupt-cnt
patch involving a change from atomic_t to atomic_long_t? [^1]

William Breathitt Gray

[^1] https://lore.kernel.org/linux-iio/20250331152222.2263776-1-alexander.s=
verdlin@siemens.com/

--6cTzLjJd0PAya12u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaBS1MQAKCRC1SFbKvhIj
K+10AP9moQ0ZBiJCymyZyRt4NL+0CuMaUoYh/Y2ny5aELP8vUQD+I0U3VWsuN3ZG
L5yKFru5ddYpdihse/1UikfdNNuYCwk=
=6g2Q
-----END PGP SIGNATURE-----

--6cTzLjJd0PAya12u--

