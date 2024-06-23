Return-Path: <linux-iio+bounces-6786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14094913EC4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 00:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AADB20C33
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 22:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169678C80;
	Sun, 23 Jun 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5632ET7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602565C
	for <linux-iio@vger.kernel.org>; Sun, 23 Jun 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180120; cv=none; b=k2+jXM3we1r1O22Jx1ZT5U6Eh8z0iX3f6kTm40kAj3Zp6naGipZfpmgUyPw2HJ3z9e9JvjyFfRAnRG1/VsoG8QZyo23bQZ/D4sjJ/FrT+/m4zs/+jd0s4cySwmZ7zaxm0LRgpxH8qMIqZ9jyz9urcM2VImuK0RquQ4XmsWG101U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180120; c=relaxed/simple;
	bh=Y+6lEEZFAHAimlcPz3uE0eGG1cFC7mV6Xopoqf7ASys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B98O8wBFZmv8DjIetKQXP6NCOQUkhEpTrMGY7qk6WKHF8HqI2PxUqto5hojrhVQl9wG50exisbRCf0xnxjppvEuWxvC2XjwIdZc/PrtEv8bC09rRZ44xh6VNLUVeUOs/iqg6goUadOz14qu8WTIwiyCWak7RFMYgleJfFqXTY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5632ET7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CC4C2BD10;
	Sun, 23 Jun 2024 22:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719180120;
	bh=Y+6lEEZFAHAimlcPz3uE0eGG1cFC7mV6Xopoqf7ASys=;
	h=Date:From:To:Cc:Subject:From;
	b=T5632ET751pOhiEhaMAe61qF9dr9MGJqwFQVm8L49bRL1hZFAjE2gu0Sh4ZZ5wwql
	 ys9fUV0h/4RPxKgO9UPImreDZckGWCW983hkMC065a6T44u1k7qnexNNn1FMjbym/U
	 3cFOaWxCFakTYaHc1/DuoYVrRKAWTqcrDwK1LM6TJ0m/tmLOAyyXx3n5hoDUEdQ8tS
	 UAQbOMxaTOr2XY/XvESNbEr7FiXEve7ew5N2oO96Vaf/KQKi6Y1eJSDYDdA+M6LUj0
	 49NhQvlSFA7eWsshkbn7ocmBF2eIR8NxidAQUZHneAOYUEUzmWXrOhFkSMCTWGbEfZ
	 1zG5Co/7DcqLg==
Date: Mon, 24 Jun 2024 07:01:57 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter fixes for 6.10
Message-ID: <ZnibVTlTsXiGP2Fi@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L8l0Wi5glRY82CWp"
Content-Disposition: inline


--L8l0Wi5glRY82CWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.10

for you to fetch changes up to 0cf81c73e4c6a4861128a8f27861176ec312af4e:

  counter: ti-eqep: enable clock at probe (2024-06-22 13:48:11 +0900)

----------------------------------------------------------------
Counter fixes for 6.10

A fix to enable the TI eQEP clock explicitly in the probe callback
rather than hope it's already enabled by something else on the system by
the time we need it.

----------------------------------------------------------------
David Lechner (1):
      counter: ti-eqep: enable clock at probe

 drivers/counter/ti-eqep.c | 6 ++++++
 1 file changed, 6 insertions(+)

--L8l0Wi5glRY82CWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZnibVQAKCRC1SFbKvhIj
K/r2AP4ki0o+o0cy7Nh0QR4NkOEQXO6t6YJ9AZOzAtZJqQfdbAEAuGEgQ4jLes6n
SXhFIStoeqsN+oez/bRZw7Ak+wAUkgY=
=Mw0R
-----END PGP SIGNATURE-----

--L8l0Wi5glRY82CWp--

