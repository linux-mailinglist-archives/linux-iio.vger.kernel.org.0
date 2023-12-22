Return-Path: <linux-iio+bounces-1225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AEB81CAE7
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 14:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE80B20E89
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C913D199B7;
	Fri, 22 Dec 2023 13:50:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD356199A4
	for <linux-iio@vger.kernel.org>; Fri, 22 Dec 2023 13:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B44EC433C7;
	Fri, 22 Dec 2023 13:50:09 +0000 (UTC)
Date: Fri, 22 Dec 2023 08:50:06 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] First set of Counter updates for 6.8
Message-ID: <ZYWUDpW6nKfY5_Vs@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UbSXejfGqQtdiqGf"
Content-Disposition: inline


--UbSXejfGqQtdiqGf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.8a

for you to fetch changes up to b7760cf94d4f2665bf40d08dd69aa5d0b4aa593f:

  tools/counter: Remove unneeded semicolon (2023-12-20 11:43:31 -0500)

----------------------------------------------------------------
First set of Counter updates for the 6.8 cycle

A new Counter tool is introduced to provide a generic and flexible way
to watch Counter device events from userspace.

----------------------------------------------------------------
Colin Ian King (1):
      tools/counter: Fix spelling mistake "componend" -> "component"

Fabrice Gasnier (2):
      tools/counter: add a flexible watch events tool
      MAINTAINERS: add myself as counter watch events tool maintainer

Yang Li (1):
      tools/counter: Remove unneeded semicolon

 MAINTAINERS                          |   6 +
 tools/counter/Build                  |   1 +
 tools/counter/Makefile               |  12 +-
 tools/counter/counter_watch_events.c | 406 +++++++++++++++++++++++++++++++++++
 4 files changed, 423 insertions(+), 2 deletions(-)
 create mode 100644 tools/counter/counter_watch_events.c

--UbSXejfGqQtdiqGf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZYWUDgAKCRC1SFbKvhIj
K2R+AQCP99vJCJKr3pK0jZOV080IVeafqdP2KouYQLgZYCj9AQEAuiMTg9x6Tujn
JeLBxpRTqDHscYixMrXWKb4Cv3mgCQs=
=mFZQ
-----END PGP SIGNATURE-----

--UbSXejfGqQtdiqGf--

