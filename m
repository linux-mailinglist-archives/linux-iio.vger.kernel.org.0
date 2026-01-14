Return-Path: <linux-iio+bounces-27762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165FBD1E403
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33C3E3018F6C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D685394495;
	Wed, 14 Jan 2026 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk01aEwA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A938A719
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387595; cv=none; b=f0ZzqO5X2PHKD1ySr8Q6jJ5kqO2BCnTHO8cpPgk37VFgQPsvov94YP09b1I5ZxylviJ0BdIcSQ8ybqGzyRBQHj7Uxnzdmekdyjv73XpdtqLGQYkeVHzDY9m7yJxbwqj04NtQ56KNFRUbJjn4XKy1aUmGdgfsH2iP+AkvufgYeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387595; c=relaxed/simple;
	bh=itvCYkAxYYmP32fEkBYGZ/L1PhqdPqH8Sji/ZCYFq+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m0O4wvLobfjXF648gxuefV7FTgT9zftoe+MH+TMwxzVKZ5aiP62X6CmIaHr6RIgqPcds69kiUb7iL9/2VQeGeDnSGf89IugHNfqjGyrFTZlsMSr68mBa5FF/28t0utYK9Y97N4VyGWdIuaTDwHyuNKGF+LblJGYnB37V1hw1qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk01aEwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A5AC19422;
	Wed, 14 Jan 2026 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768387594;
	bh=itvCYkAxYYmP32fEkBYGZ/L1PhqdPqH8Sji/ZCYFq+A=;
	h=Date:From:To:Cc:Subject:From;
	b=Vk01aEwAxPak80PMIO0k5Dw1aQM9Hs4dO/wzBDdDMoAukp5SAF4QEF9u+Pr/v8Lsv
	 +xyhYqW6p/J/WV7nPkG9E21L9+XpMcDn1f+5zsAoZ/q6+jBYv2Ixa4Ca/iS22uGB7y
	 cJMOJmcUrQW6qTboszR+esaUMZ5GhHUM95MYUeySGHhhLLnbhBYYWK+J0dPeJ1Wi83
	 aR+cmfcfP0n0WlxO5aZbF5jIVzEtNnEjWRHA01YX89x3HGij7qLOaz90r2ctH8dPBj
	 44R7+0jHAOLq+Q8EUk95JQBTbDlbDtmJ6++3dNfMpMuJNLuYhLb4n07hXjhn6QHGej
	 aOdkdsz3rN/uA==
Date: Wed, 14 Jan 2026 19:46:30 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter updates for 6.20
Message-ID: <aWd0BhyFMqR_ltOT@merlin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mGR5N/3N/kW7Vgko"
Content-Disposition: inline


--mGR5N/3N/kW7Vgko
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:

  Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counte=
r-updates-for-6.20

for you to fetch changes up to ad415677b7e3b733270adaf04e3a7a9c46f1e929:

  MAINTAINERS: Update Intel Quadrature Encoder Peripheral maintainer (2025-=
12-22 19:44:58 +0900)

----------------------------------------------------------------
Counter updates for 6.20

Update MAINTAINERS file to reflect new Intel Quadrature Encoder
Peripheral counter driver maintainer.

----------------------------------------------------------------
Ilpo J=E4rvinen (1):
      MAINTAINERS: Update Intel Quadrature Encoder Peripheral maintainer

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--mGR5N/3N/kW7Vgko
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaWd0BgAKCRC1SFbKvhIj
KxUEAQC4m8HIrSfYIativR0kYgWpUB9vclvUcXagzLmmVRF/dwD/WXtEotGC6cHZ
DDWFdTckT6h50qcYcDIBglOYZ+h98Qw=
=Abn+
-----END PGP SIGNATURE-----

--mGR5N/3N/kW7Vgko--

