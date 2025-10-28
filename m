Return-Path: <linux-iio+bounces-25578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE4EC14BE3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E30561210
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4033031E;
	Tue, 28 Oct 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW1EfESP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBF1DD525
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656508; cv=none; b=O1FhNpKb/hMaJRikicpB7RR7FKoAeVD9VzacbSfRTZB2Ea8LVAYXbdtnRsunp412QT0oKHbiIIL/tOlPnkRrUJOVLc16VgLu+QYsnEBdLwPIQnVVA2DJN5gvMGQLkcmy9+uaYGThiGhMDve3XAn2yE19MGKLozntNEgoppjQN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656508; c=relaxed/simple;
	bh=8dQGAJfCZYK7Ea4ZXj7Vo24efhEkY67U1keuwE20PHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I0WhbN3TMV2mKbAPObBwqTPY4RBYaTMfSoWlG9tWZqtI6qBU7EJIehhARtwjSmbWXOomVVZJd3GsQdXwlHx4e8+2/VG4Up8sBbpQoR5cxq/dtClEA3xJUIJT5ac4zjNepi0o6qOQQJIWqm6walqjYybrhUEX6jX88a13Velu/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW1EfESP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76664C4CEF7;
	Tue, 28 Oct 2025 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761656506;
	bh=8dQGAJfCZYK7Ea4ZXj7Vo24efhEkY67U1keuwE20PHI=;
	h=Date:From:To:Cc:Subject:From;
	b=pW1EfESPzkuhzpv9WFRvO5vS9u8pSF+StuOFJrune1qzNHlN31jn8Q/q3DWkMm2Pb
	 P0KPQJ7Y9I+gcqxhkRdX78jE5jB31idtEfrh4+MtbCVPwYtao9ZQoabZgeg5piL9Ew
	 63iU2v7YUfvLcVo4DaNKZMbf1TyJdtbIdd2rPZCgTiDbPMdYV0rZwgw3Px3BWlht7w
	 ekhxLXALks5g6Il4KaC6w4FmwcjKPVoT7wpz+nI9U9QMNz2DcNOG3UKkOr7u+/BTdS
	 PeRutiPy764xDms+Xd+zwq0rzidvCFU3OLOstMkZT4Fm+cE06eSh1R7aedMHRx+XoJ
	 atdbMC7OUcQIA==
Date: Tue, 28 Oct 2025 22:01:43 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter fixes for 6.18
Message-ID: <aQC-twp5Op1OFRNU@emerald>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Es88NBDiHPApMW6I"
Content-Disposition: inline


--Es88NBDiHPApMW6I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.18

for you to fetch changes up to 109ff654934a4752f8875ded672efd1fbfe4d31d:

  counter: microchip-tcb-capture: Allow shared IRQ for multi-channel TCBs (2025-10-13 14:56:30 +0900)

----------------------------------------------------------------
Counter fixes for 6.18

A fix to permit multiple counter channels to share the same TCB IRQ line
for microchip-tcb-cpature.

----------------------------------------------------------------
Dharma Balasubiramani (1):
      counter: microchip-tcb-capture: Allow shared IRQ for multi-channel TCBs

 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--Es88NBDiHPApMW6I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaQC+twAKCRC1SFbKvhIj
KwJBAQCuCF+Z+/CI4CYbXALZhmselCCfVPMkWxVoOBXgOC6vygEA+GJFuCYg3Yma
W+0aTYRgchT5KIvnaU2M+QzXgspHSAw=
=hhVA
-----END PGP SIGNATURE-----

--Es88NBDiHPApMW6I--

