Return-Path: <linux-iio+bounces-27398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD79DCE4944
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 06:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9B1A300CBA5
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 05:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A01F7916;
	Sun, 28 Dec 2025 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBsWlq/c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAE20ED
	for <linux-iio@vger.kernel.org>; Sun, 28 Dec 2025 05:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766899273; cv=none; b=dvkeFLpZA7mrWW5jNPEXRzn0hD6esK4dnVCc0UhU23XGLB9sNcNkmRcexH/sA9meJv9sIbxbSrbt3fNj/pdkA1UQVR27MatL9xm6kukMcr5rKR6yTqg30TtgcIb9n8y8+yqGJDUT0VxmKvHdghq/h1ALb+ky6inR8Ddwfdnjrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766899273; c=relaxed/simple;
	bh=5WmgHDmt+hjvwJiuuT4LosK9EB8Hxmha0L/UcveEXRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E7u9MrAatmgTL2N++3YCJY8S09soYzDV9ptrgoFrb0fi8FYAyh+6e51xDF8ZQUxd4w/O+sa6nJZnWqOWETyNTX3tStDZXhrKXezvdCQ/wsoZAsMyNHjBKCPdBreZUgFFE0Sh+/NnZhCbh8nGAR3J/i3HF9NH28zGQjW8pM8TTcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBsWlq/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CE6C4CEFB;
	Sun, 28 Dec 2025 05:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766899269;
	bh=5WmgHDmt+hjvwJiuuT4LosK9EB8Hxmha0L/UcveEXRo=;
	h=Date:From:To:Cc:Subject:From;
	b=LBsWlq/czDliAY6uhJNhjCjSWhs1tFYX+9+FU0gnqy44VPHyaABVFXJkBFmNx23NU
	 rYK+FP/eUPiK1w9zSnmt3PPTWe/yFV6jRdZ/E5GvIyJKvc828NpzjEAO0ILp8M/Hdp
	 3eNCrNuSq7a+EeYRDc3uPOzd2/HoGHGm8LOi+yKMQ/mAX6kU4blROeNNKLQVEhqOqy
	 6tGv4fxx+EnkcDpELCT+lg7pkA7wvuAvxag34FdNEhxpavmPkDld1r7LTz4qcnzLJ2
	 WjgmCfmZC5z6PQP+MSVmZFaRHpHEkP+XyAkyTyiigXUEEQI9s6hj+Oc8Wglf0/lRDu
	 RNBd4dw9XPr+w==
Date: Sun, 28 Dec 2025 14:21:06 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter fixes for 6.19
Message-ID: <aVC-QsxCpDSnelZq@emerald>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pq3L5bpCZnoUZFil"
Content-Disposition: inline


--pq3L5bpCZnoUZFil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:

  Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.19

for you to fetch changes up to 9517d76dd160208b7a432301ce7bec8fc1ddc305:

  counter: 104-quad-8: Fix incorrect return value in IRQ handler (2025-12-22 20:03:23 +0900)

----------------------------------------------------------------
Counter fixes for 6.19

A fix for interrupt-cnt dropping the IRQF_NO_THREAD configuration to
allow the IRQ handler to correctly acquire a spinlock_t lock. A fix for
104-quad-8 correcting quad8_irq_handler() to return irqreturn_t enum
values rather than negative errno codes on error.

----------------------------------------------------------------
Alexander Sverdlin (1):
      counter: interrupt-cnt: Drop IRQF_NO_THREAD flag

Haotian Zhang (1):
      counter: 104-quad-8: Fix incorrect return value in IRQ handler

 drivers/counter/104-quad-8.c    | 20 ++++++++++++++------
 drivers/counter/interrupt-cnt.c |  3 +--
 2 files changed, 15 insertions(+), 8 deletions(-)

--pq3L5bpCZnoUZFil
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaVC+QgAKCRC1SFbKvhIj
KwSpAPsH4R8aXNRKYdL7KQriyhzJ8qekNSJDbDbHlMAP0uW/RAD/UEKcmuzly0fh
+8dFLcUlZUj4JKgVI9PcBT74iayfQgI=
=Sxsq
-----END PGP SIGNATURE-----

--pq3L5bpCZnoUZFil--

