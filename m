Return-Path: <linux-iio+bounces-4214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9A78A3B91
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 10:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40CF283FEA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB4C1D551;
	Sat, 13 Apr 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1LFND10"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FF1CD29
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712995653; cv=none; b=N5M+WZodnj1SNHzNgICHRQZi0EpAAjDQKQk5bIVm86SsWDThhi0Hi7uSLv3d07ts5eDnTHVg/cG7HcB5B8pDvn2T/sQ/E3LRDS0w2d7ItAvf/5B/DYIDqxrWwy17jAhtEhRMO0p2N6ZHZR8s7zmrOcCEvaLt7GVhjz6hRh9who8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712995653; c=relaxed/simple;
	bh=0rQlaebPmkNNNinpbITrPLvB7ic8Z0Kicx6e2pIEAps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fa2LFB1h4Y23L4TshbjFSa60SFau1T6mCnzowS6maciIZADGjpVpYcH1cYc6QgP7gBAlXsetU2H9c7RthJOOJIwTyAZ3hEW6C4WkcyDSZQ9AphHoHC3FaQZwDN8aNX+ISJu8kUozVuPnAacx2xIGxJb/gwclV+T/2cwD847GNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1LFND10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DECC113CD;
	Sat, 13 Apr 2024 08:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712995653;
	bh=0rQlaebPmkNNNinpbITrPLvB7ic8Z0Kicx6e2pIEAps=;
	h=Date:From:To:Cc:Subject:From;
	b=X1LFND10+cDhp895WSnJtuAJuTKfRTNi9evGCBMJuUN56/zgSgenRgNSXTlXvPZQt
	 6FswQ5cdVamxVq9K+lSASMrzHaHXAaGpZQcc4x05i0G+KPielRCNbrMxH2KtE6y3sl
	 GqreyQ0Cg8+12n3RGugwoRLpotpZPgkEYgMNiSJF2Tg5i5pbq0hZ98MXraqyyf6QZE
	 bdjuop0CiEYZQTlz75R9nptBP69wl4X5v41DlJSYN9UNRrV+E6YhyFDffOXUXRRH73
	 L988vK+Pyd59yrcGRrQCoBpq4Rkn3SEhwlnUmpAGwAQCvju6Fg8Xm23317ivdXb6WR
	 rDp3f7WpG5Llw==
Date: Sat, 13 Apr 2024 04:07:29 -0400
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter updates for 6.10
Message-ID: <Zho9QUfTfT-uHptA@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cjg/0OJkmkDYy+hw"
Content-Disposition: inline


--Cjg/0OJkmkDYy+hw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counte=
r-updates-for-6.10

for you to fetch changes up to 916baadd293a4d11e08a7ca1e2968314451ade6c:

  counter: ti-ecap-capture: Utilize COUNTER_COMP_FREQUENCY macro (2024-04-0=
2 13:15:03 -0400)

----------------------------------------------------------------
Counter updates for 6.10

Three key updates of note herein:
  - Introduction of the COUNTER_COMP_FREQUENCY() macro to simplify
    creation of "frequency" Counter extensions
  - Three additional Signals (Clock, Channel 3, and Channel 4) are
    supported for the stm32-timer-cnt
  - Counter events support added for the stm32-timer-cnt

There are also some miscellaneous cleanups and improvements, such as
constifying Counter structures, resolving a kernel-doc description
warning, and converting platform_driver remove callbacks to remove_new.

----------------------------------------------------------------
Fabrice Gasnier (11):
      counter: Introduce the COUNTER_COMP_FREQUENCY() macro
      counter: stm32-timer-cnt: rename quadrature signal
      counter: stm32-timer-cnt: rename counter
      counter: stm32-timer-cnt: adopt signal definitions
      counter: stm32-timer-cnt: introduce clock signal
      counter: stm32-timer-cnt: add counter prescaler extension
      counter: stm32-timer-cnt: add checks on quadrature encoder capability
      counter: stm32-timer-cnt: introduce channels
      counter: stm32-timer-cnt: probe number of channels from registers
      counter: stm32-timer-cnt: add support for overflow events
      counter: stm32-timer-cnt: add support for capture events

Randy Dunlap (1):
      counter: linux/counter.h: fix Excess kernel-doc description warning

Ricardo B. Marliere (2):
      counter: make counter_bus_type const
      counter: constify the struct device_type usage

Uwe Kleine-K=F6nig (2):
      counter: ti-ecap-capture: Convert to platform remove callback returni=
ng void
      counter: ti-eqep: Convert to platform remove callback returning void

William Breathitt Gray (2):
      MAINTAINERS: Update email addresses for William Breathitt Gray
      counter: ti-ecap-capture: Utilize COUNTER_COMP_FREQUENCY macro

 MAINTAINERS                       |  30 +--
 drivers/counter/counter-core.c    |   4 +-
 drivers/counter/stm32-timer-cnt.c | 461 ++++++++++++++++++++++++++++++++++=
++--
 drivers/counter/ti-ecap-capture.c |   8 +-
 drivers/counter/ti-eqep.c         |   6 +-
 include/linux/counter.h           |   4 +-
 include/linux/mfd/stm32-timers.h  |  13 ++
 7 files changed, 485 insertions(+), 41 deletions(-)

--Cjg/0OJkmkDYy+hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZho9QQAKCRC1SFbKvhIj
K0SQAP40IAC4xZiGRaX3JBR/xUjaLx9Tg3xObix2XLKIU8puHQD+NZhyCqvUAgwe
weuw8GP15EthWWQpQlVqbaPIi4/PjQ4=
=M5EB
-----END PGP SIGNATURE-----

--Cjg/0OJkmkDYy+hw--

