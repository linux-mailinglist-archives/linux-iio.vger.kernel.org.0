Return-Path: <linux-iio+bounces-19825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22A7AC2343
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 14:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB3FA257C2
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7007404E;
	Fri, 23 May 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyHvwGJE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89910A1F
	for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005105; cv=none; b=uN5qwPmkUklzddM+DSZYQer8WjKyzGbSV6jMeKDPhLvekFo3vJapUAc/c86vcWvh17t4TxFN4GcfoJ8pU+dbeFulLHmxopifVXasg9Jkh+hKf5GPWzIx3aCEnDDfhL3w9Eiphsxg/rYxRtpWMptg6usDYbEFwUj6y9QdW/+gUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005105; c=relaxed/simple;
	bh=gx6sHjG+BtNCJ3V080fDCZsZ6QcCxfc/8lvEFrFK960=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p7gBqtynQ/FYtgipDRR8WuETg1oYOBGOlVAB0C46x2CLExNciA+y2lhC23zZmCssZhuEHRZz7d4liLAxymQ8u7BG0u/DqZNmC53PD359ojldyzIlFlXYFDO2VRWk8j1m+cQAsu7jiHIJJ3ZFgzZe9+teqXEdvePaqkkf44PMaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyHvwGJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAD1C4CEE9;
	Fri, 23 May 2025 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748005105;
	bh=gx6sHjG+BtNCJ3V080fDCZsZ6QcCxfc/8lvEFrFK960=;
	h=Date:From:To:Subject:From;
	b=RyHvwGJEZRFJqEFkURQpwq4Z6bBYEaMClkut3yTebxPgLeJ3SAsRumQkQ1Jl7z09t
	 ox2qJlQlAlQNgTv1BB9eMGZneMQTHdh7P3noJ8/Wmp55+9Zp9NKwbENVCJ9xaBoRkX
	 6m+c6ERerLJL3OZxwxZwQOTQjsA0cxn5LLqhDKQqk2fguAjtJil9pjbPp5ONKZKiZH
	 zhHLtq6We8o1S3GH1nsiexAbFExDwlTiRaHgRypFqg5zZPzmQqXjbaAwI60EdSEmEH
	 3cS2zwpzOJ/8q2adRIOQiII6qx2MqJ3Cc0GomsCEa4Cw5b+M2aeCMMwDieTam4GwVU
	 nYJX7hw/Yejvw==
Date: Fri, 23 May 2025 21:58:22 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Second set of Counter updates for 6.16
Message-ID: <aDBw7nF3TxsgHraC@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aI2GP7x5ZCoj+OqL"
Content-Disposition: inline


--aI2GP7x5ZCoj+OqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 08e2a660b1601963ced37ac8e8d8c134a97f167e:

  counter: interrupt-cnt: Convert atomic_t -> atomic_long_t (2025-05-02 22:46:01 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.16b

for you to fetch changes up to ae3392c0f12f179b969ce17856ed18bf8d69a35e:

  counter: microchip-tcb-capture: Add watch validation support (2025-05-22 18:40:19 +0900)

----------------------------------------------------------------
Second set of Counter updates for 6.16

Adds compatible for STM32MP25 SoC and enables respective encoder
capability for stm32-timer-cnt. Implements watch_validate callback for
microchip-tcb-capture.

----------------------------------------------------------------
Dharma Balasubiramani (1):
      counter: microchip-tcb-capture: Add watch validation support

Fabrice Gasnier (1):
      counter: stm32-timer-cnt: add support for stm32mp25

 drivers/counter/microchip-tcb-capture.c | 25 ++++++++++++++++++++++++-
 drivers/counter/stm32-timer-cnt.c       |  7 +++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

--aI2GP7x5ZCoj+OqL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaDBw7gAKCRC1SFbKvhIj
KxrkAQCGZ8vOVcjJqiCmdsjTXYiYqJndVcHbFgBELSI43zt6sQD9GHF0JhWrsEDV
3dYI5vGT5/f3C+btvWCZmn//pIL/OQM=
=7rmq
-----END PGP SIGNATURE-----

--aI2GP7x5ZCoj+OqL--

