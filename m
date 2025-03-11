Return-Path: <linux-iio+bounces-16721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADA3A5B413
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 01:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E21172F6C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7B1DA21;
	Tue, 11 Mar 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU2VX9gc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B83FBF6
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653387; cv=none; b=eBLqtDJVGDFnLpLaRtaG1gOMj6Hwi5odgbGRNpkLgJvAyVE5MCjdXsWBscEMeB9B40j/Ggvg0Km9hFf3DzHQmac/gg6dkIpE/Ya2wU+iOQ5gK0QGLQhwI54xhL3o6U73xzqjkCZA3kK/cYx1jPVZZiummmbleAe3Lx53+6+gveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653387; c=relaxed/simple;
	bh=PFeufA9HP5U8p//dp3QAORScg7WC4w131o4jTDrwQjk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hZdAAu/vfLQh/f1ooqiXLDSZWELQVgqRwIoym4DdlS1zPs9K0EeoniFHFDtmXl2kXBYWpimIS38i63w6q2JTu4lG7BX5HhJNcaDf12q5UV5PWqz4dBzB9efhK+8ZFN639B0zvE+c1X2cn5kGG9nixHyVtfGxdaK+GAQG+hOxEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU2VX9gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4634AC4CEE5;
	Tue, 11 Mar 2025 00:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741653386;
	bh=PFeufA9HP5U8p//dp3QAORScg7WC4w131o4jTDrwQjk=;
	h=Date:From:To:Subject:From;
	b=cU2VX9gcr+SxOIFc9ZCym7ZNQEA2pnDR7VO2dSbggA5iHQ6trkcwvZ3/tpvPotR3N
	 gyiwePTC9HYCyIO48OTaB2hpYT52pHaqWHMjPWt7QMI4cpcjOa6EDUlPB3Xu9r+rSE
	 afWSXnr2dzFS+o/GVnqMm7+439iluDsD2ZPJLiZVlLV2RyyLh2SqL3YlNah6R/8EB/
	 V90tNGi4zDT8RTVuWf56mWPlCkRreNacD83OiovIazRgVL74+0tOTqs9rCGgtnBJLO
	 CfstjPyVnv35Ib4rBCI8HzbNiWx2o9/SLeLlaexWSgT4L1j7czA5bRf49qo3Jg0W5E
	 ptJMikEOFKXlw==
Date: Tue, 11 Mar 2025 09:36:23 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter updates for 6.15
Message-ID: <Z8-Fh9pzgxS1idk2@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lU7ASS82GjffM2oe"
Content-Disposition: inline


--lU7ASS82GjffM2oe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counte=
r-updates-for-6.15

for you to fetch changes up to ba27a0247b7187af36cb0b1fe7f7a68067ccb555:

  counter: microchip-tcb-capture: Add support for RC Compare (2025-03-10 18=
:20:32 +0900)

----------------------------------------------------------------
Counter updates for 6.15

counter:
 - Introduce the COUNTER_EVENT_DIRECTION_CHANGE event
 - Introduce the COUNTER_COMP_COMPARE helper macro
microchip-tcb-cpature:
 - Add IRQ handling
 - Add support for capture extensions
 - Add support for compare extension
ti-eqep:
 - Add support for reading and detecting changes in direction
tools/counter:
 - Add counter_watch_events executable to .gitignore
 - Support COUNTER_EVENT_DIRECTION_CHANGE in counter_watch_events tool

----------------------------------------------------------------
Bence Cs=F3k=E1s (2):
      counter: microchip-tcb-capture: Add IRQ handling
      counter: microchip-tcb-capture: Add capture extensions for registers =
RA/RB

David Lechner (4):
      tools/counter: gitignore counter_watch_events
      counter: add direction change event
      tools/counter: add direction change event to watcher
      counter: ti-eqep: add direction support

William Breathitt Gray (2):
      counter: Introduce the compare component
      counter: microchip-tcb-capture: Add support for RC Compare

 Documentation/ABI/testing/sysfs-bus-counter        |   9 ++
 MAINTAINERS                                        |   1 +
 drivers/counter/microchip-tcb-capture.c            | 160 +++++++++++++++++=
++++
 drivers/counter/ti-eqep.c                          |  32 +++++
 include/linux/counter.h                            |   3 +
 include/uapi/linux/counter.h                       |   2 +
 include/uapi/linux/counter/microchip-tcb-capture.h |  40 ++++++
 tools/counter/.gitignore                           |   1 +
 tools/counter/counter_watch_events.c               |   5 +
 9 files changed, 253 insertions(+)
 create mode 100644 include/uapi/linux/counter/microchip-tcb-capture.h

--lU7ASS82GjffM2oe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8+FhwAKCRC1SFbKvhIj
K222AQDaFpdNAaWc4CxUnRR83BXNUTSjniTlvMs0UHmOJeG9PwD+MBlQOIcw+v/m
7vPIklz4ob7ChfUwjX1HjayP2Cj2cgY=
=ObcE
-----END PGP SIGNATURE-----

--lU7ASS82GjffM2oe--

