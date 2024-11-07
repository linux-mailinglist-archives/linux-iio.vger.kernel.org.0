Return-Path: <linux-iio+bounces-11961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D939BFEB0
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 07:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3732846C4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125D193086;
	Thu,  7 Nov 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1j3q7VC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637818FDC2
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730962341; cv=none; b=QXOG9pnc2MNWvfO10sr1vIIEyjj9g6zmpL1AEWFGLEp8wDZ4Do9G8IlsrT126vnQqYptZi9ANCW84C/Rxd0LVpf2zQmNz6XRyatFL6k8yFwq+UctyEpxyGiq31TGvrAvjGdUyrPu0EHmr9S7yG9q5tJsd+9UT0dmW4lMOXZfrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730962341; c=relaxed/simple;
	bh=6uWZqO59GFMm5WjmPGKrPE774ueS+fogwByatJgw4Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jcDtNDtxD8B66tUzxUuLQM+xvABUz9cc0eeqrqQmnsohqAklNySH3EysagQuxbVwSMpAOG+vtyxXFX9bXIcRxRcem8Nt22JlHgUqVZp/adggpAjeO8GldNIqi0u4X3DZMwcC48HZt2fGfwXkC3ItMwiusru+F/xs5RBb7FkqhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1j3q7VC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3CCC4CECC;
	Thu,  7 Nov 2024 06:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730962341;
	bh=6uWZqO59GFMm5WjmPGKrPE774ueS+fogwByatJgw4Yk=;
	h=Date:From:To:Cc:Subject:From;
	b=O1j3q7VCEMk5+x6wd/jydQSxyXPZBo3ysm91oyFLT0pdPGkN4AhXHzirAyv+ajIla
	 dKYIlLeLb+DTg2cXjiYQWYa3Yle3vOJfkQIVbMwdAUOa+caS8hX79e8Sy/TDy0SvNb
	 qWdiq/v3NUEi0aaJk+k4qoWE0EKB0KBAC8prgJ21Ix1nJzc8KyyaiEXu8t6TvzUH3O
	 rCyIt2r0AyG96eAZYU7nQVoqUk0ZlYa4Ed9pbCpltT6avyn8DaJlsm6QroFG0VdKtu
	 7Ib1FvZgmHzbHfDLDssxQuU5Ez9u2j+fTehwC30DhNbKjhOHTIwDXCSR5xlmabvD27
	 CAvtDt+3f49Uw==
Date: Thu, 7 Nov 2024 15:52:16 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter updates for 6.13
Message-ID: <ZyxjoC3zM3CgWrve@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gyB65DcxlDbO/wv/"
Content-Disposition: inline


--gyB65DcxlDbO/wv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counte=
r-updates-for-6.13

for you to fetch changes up to 522ae89b78580c62765e160aed3479297baa75be:

  counter: intel-qep: Replace deprecated PCI functions (2024-11-01 15:00:31=
 +0900)

----------------------------------------------------------------
Counter updates for 6.13

Add MODULE_DEVICE_TABLE() for ftm-quaddec to autoload based on the alias
=66rom of_device_id table. Replace deprecated pcim_iomap_regions() and
pcim_iomap_table() calls with pcim_iomap_region() in intel-eqp.

----------------------------------------------------------------
Liao Chen (1):
      counter: ftm-quaddec: Enable module autoloading

Philipp Stanner (1):
      counter: intel-qep: Replace deprecated PCI functions

 drivers/counter/ftm-quaddec.c |  1 +
 drivers/counter/intel-qep.c   | 10 +++-------
 2 files changed, 4 insertions(+), 7 deletions(-)

--gyB65DcxlDbO/wv/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZyxjoAAKCRC1SFbKvhIj
K+v/AQDp9ntdNKqL2GQmDJ4DLEaMs4o2IuS8yL+kH7VG5pi7/AD+PGoz04WY9cn5
tUucDnBwcFOfw/kmMg7seDtnrwDhOQk=
=50+w
-----END PGP SIGNATURE-----

--gyB65DcxlDbO/wv/--

