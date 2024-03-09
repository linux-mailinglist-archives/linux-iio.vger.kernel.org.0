Return-Path: <linux-iio+bounces-3402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F587722E
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 17:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBA428188A
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0514243150;
	Sat,  9 Mar 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT+3fozM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D45383BE
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001200; cv=none; b=NepN8UPYWTMVxbP6YEybF1STAxAXwI1x4P6sR3brtpAYWGqyD8sd3FNsLMDCJLlMAwtp4ASyzPXYjN8/29Z3xaVncDFYZNPNpBoBFqJPLphN8JJFDt30hxbvMznaQMaCRZel89MC8nA9tVJEin4wq9lfBo1hvDlk0SZ8J3HLVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001200; c=relaxed/simple;
	bh=VWOLH+zwdbLDGSyDwtFM2yP9jeeoe/MNp0bGTd7Nzb4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JbsOCf6Ozv9hVvFE8VQ1HjgQz0Wo3qJ2JNMwoc2tDyvF11W/sBzmFDcWXKx2tqSFtZLyKFAqlO5JETtSOdkkgzLk4Ut+gPZZbdpxlYbaxlJMdsDtCVrAUQJSIDab4/aAXkx/v0LR5hhCVLqVF4CuDtmo6D345ghDA32fzjO9lN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT+3fozM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0351C433C7;
	Sat,  9 Mar 2024 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710001200;
	bh=VWOLH+zwdbLDGSyDwtFM2yP9jeeoe/MNp0bGTd7Nzb4=;
	h=Date:From:To:Subject:From;
	b=ZT+3fozMDFFFydox3aPGGmT5HUXJ7vZripG0heMHqAVaMYfEV5F76ssyiA0UIWQlS
	 TxAJMF6lVq7PnMiWqT8fnQZsh1zPogFZvX2hZr/Kh0ciWsjuu/k6RGNXe/xPxgkT7y
	 BRoD2yVYpAt3wvpfQ+Mn0gTr4zcGLFxQ8R2iKgoxs3/8DhsToLJKMcOS8ElBoA/EsF
	 IpfiiNp8poEK/0NwlzRPKYdIoFL//Lcob3+kug82/75SIHEJ10cQIPceZsOTDjW/2Z
	 CjixV64vud6IGDRBPce3Ow74kFKtvQxbB3wUxi970hdRnwktB+m5ddsN7HfV0n5Xfx
	 USSIFKIA7BgEQ==
Date: Sat, 9 Mar 2024 11:19:57 -0500
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter updates for 6.9
Message-ID: <ZeyMLe1lmfyMcrss@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aZOswP6EubRu7JTe"
Content-Disposition: inline


--aZOswP6EubRu7JTe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.9

for you to fetch changes up to d5b71a36a6afb6d2fe70ed134a3163be6e205ae6:

  MAINTAINERS: Update email addresses for William Breathitt Gray (2024-03-09 10:52:09 -0500)

----------------------------------------------------------------
Counter updates for 6.9

Three key updates of note herein:
  - Introduction of the COUNTER_COMP_FREQUENCY() macro to simplify
    creation of "frequency" Counter extensions
  - Three additional Signals (Clock, Channel 3, and Channel 4) are
    supported for the stm32-timer-cnt
  - Counter events support added for the stm32-timer-cnt

There are also some miscellaneous cleanups and improvements, such as
constifying Counter structures and resolving a kernel-doc description
warning.

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

William Breathitt Gray (1):
      MAINTAINERS: Update email addresses for William Breathitt Gray

 MAINTAINERS                       |  30 +--
 drivers/counter/counter-core.c    |   4 +-
 drivers/counter/stm32-timer-cnt.c | 461 ++++++++++++++++++++++++++++++++++++--
 include/linux/counter.h           |   4 +-
 include/linux/mfd/stm32-timers.h  |  13 ++
 5 files changed, 480 insertions(+), 32 deletions(-)

--aZOswP6EubRu7JTe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeyMLQAKCRC1SFbKvhIj
K+qtAQDcZspIYbxqSGIZbRkaQSycqDnp26sP6239EgWoETr+jAEA5MuRbIVEkmjX
EJMm2faTqIxaRRfhRA0kTqZKuMsARg4=
=g/Db
-----END PGP SIGNATURE-----

--aZOswP6EubRu7JTe--

