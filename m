Return-Path: <linux-iio+bounces-7123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7658D9239B4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 11:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950A31C2167C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5C14F9F3;
	Tue,  2 Jul 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie8YBhUY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791614D703
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912148; cv=none; b=JxwFu5yfzhFx68Lrs4PRpTx/xi9OtKsm8uRXQcGje4ZWGKbcCWu2sSd+QTGXt+CwjhM1whmV2F0PLwTKhtMxixfo+nXevnn0Symxlpwmay1pIbi30tW+ImPQu8yNOC/9B/8NEpE3Oo/0wXrfM3SlF3QldpI18TFCue/dHq8xDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912148; c=relaxed/simple;
	bh=glY7Q8fn7aGsXcjNXlspUsXPDbySy1NnuDwaeq5UHCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QRUOmmBSrI/lm9F2TFwChscSlCcHZg/ub17nuWPe7g9ZccCvho1c6MZW/MlhFFLF2nLR3U/dL2YEJfu4FpajXlomk7o0pJ7R9XSRPIIHn1SsTPFLwWs6jgN300qtrUAKxuZcCwM86SRKeMjsvtz/fRtUb1j4D0WPvC0ddyRigr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie8YBhUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A909C116B1;
	Tue,  2 Jul 2024 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719912148;
	bh=glY7Q8fn7aGsXcjNXlspUsXPDbySy1NnuDwaeq5UHCw=;
	h=Date:From:To:Cc:Subject:From;
	b=Ie8YBhUYb0NkSBxVa6g0ct6XjVnR3X6U27od1f32myy3AK0r3KbToR8Gpn/NtNkZV
	 vUN+sBKCxNKcJ/RVEynfpPJ6lw5mOzo0S/c8nwYejXHyfMqKqSUebFBkXxU++hhCuU
	 RO5sJA/87s3uUAO7OQDT5mNGjIcbqJo5lQ/MwCx+ATjqzrtSeSLUv8/UYwnmUZVRg7
	 6tGQTw9UpYK5RakwYEHxlx7+BV7tm9CzH8oM3JRt+Tzgq855rG9qjuzhN7486Q669S
	 ikuDDgu63xydIZ8hgpexFPRXTtg4ZB30sqa5t73++PsIkecbs6pOGuNwbvc3V1B/bl
	 9wq09fGIo6QSQ==
Date: Tue, 2 Jul 2024 18:22:22 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter updates for 6.11
Message-ID: <ZoPGzkmSA_sxY7-_@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oGH9TvCdaTzTriVT"
Content-Disposition: inline


--oGH9TvCdaTzTriVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.11

for you to fetch changes up to 988609f2aaf1c0dd1498eef6dec21c8a5fa34046:

  counter: ti-eqep: Allow eQEP driver to be built for K3 devices (2024-07-01 19:05:42 +0900)

----------------------------------------------------------------
Counter updates for 6.11

Primarily consists of cleanups and updates for ti-eqep; ti-eqep now
supports over/underflow events and can be build for K3 devices. In
addition, ftm-quaddec is updated to add a missing MODULE_DESCRIPTION()
macro.

----------------------------------------------------------------
David Lechner (3):
      counter: ti-eqep: implement over/underflow events
      counter: ti-eqep: remove unused struct member
      counter: ti-eqep: remove counter_priv() wrapper

Jeff Johnson (1):
      counter: ftm-quaddec: add missing MODULE_DESCRIPTION() macro

Judith Mendez (3):
      dt-bindings: counter: Add new ti,am62-eqep compatible
      counter/ti-eqep: Add new ti-am62-eqep compatible
      counter: ti-eqep: Allow eQEP driver to be built for K3 devices

 .../devicetree/bindings/counter/ti-eqep.yaml       |  27 ++++-
 drivers/counter/Kconfig                            |   2 +-
 drivers/counter/ftm-quaddec.c                      |   1 +
 drivers/counter/ti-eqep.c                          | 131 ++++++++++++++++++---
 4 files changed, 139 insertions(+), 22 deletions(-)

--oGH9TvCdaTzTriVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZoPGzgAKCRC1SFbKvhIj
K+wBAP9w3eE8T1c8azWEa7y8xUPeDDW36TIeqFBa07xUJ6ggiQD+KExfrERXYYnL
NobII5MCQu+z33kUvGCOfBK8h2z6CQg=
=yEL1
-----END PGP SIGNATURE-----

--oGH9TvCdaTzTriVT--

