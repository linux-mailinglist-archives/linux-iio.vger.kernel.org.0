Return-Path: <linux-iio+bounces-16513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30781A56488
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 11:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409DB18979B1
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073AD20CCFD;
	Fri,  7 Mar 2025 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWdzRgis"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9201C84B5
	for <linux-iio@vger.kernel.org>; Fri,  7 Mar 2025 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341694; cv=none; b=A4WxyvIwXsLeQfMSp7gmXWtQ4MD51NxB/syLNzjrNKeaIOPA/RCkXg9FwJdEqP7lxWAkRzh8CpRWJA3CPNyfqFWwipdDsAYjExTRwYheHNrqbmYgbk/40HYDkaHJJQJ/X73daU9LJon9yJiVJqi9Hq/dc/vwipAK10hiPpskl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341694; c=relaxed/simple;
	bh=0riyXf713JPfrm2P3qqP57As29J5C5mbU9ErS2U0ez4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RN452DqRIJHvXsz3yucyhxjoJcDb2nk1aZt9FYS85G7exXRHq+uJJmVwjCjRyebkVplqZGi7oNkf8ztqxJK4Wv5Gnf52M0/kKYbJXhyBwok0buZ90mwmnZUvmIJbZpeaPomuQPq29gV5BLV4zsVXsWKKQ46OT0357U8bAxL/BnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWdzRgis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656CFC4CED1;
	Fri,  7 Mar 2025 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741341694;
	bh=0riyXf713JPfrm2P3qqP57As29J5C5mbU9ErS2U0ez4=;
	h=Date:From:To:Subject:From;
	b=TWdzRgisMkFEeqt2Ytt0tHkX1naAg//bGwBvshGYZwx6si8Ueui+KAtZEEaoggJhX
	 Qqc4DnowW4h8e9Bi0/r7OVSn8dpxHqfq8l2dlzE0geEF53Lo/ML1PVGLFc5wmaAi+i
	 5K6+bb6saOJrGo7TteVhgKFFnsjvK1+bATwQS3/C7p1sLDE6wg1cbhBX1EChYKL5Fv
	 cFuzJsRKtdLl9xnZoqjsijndRmTWX3nkMZEN8GAV9Bzu34qyqOl4R65d6OE33LLUO1
	 r0NzTT+HRIJBC7v8+DwgEsqrUrdA/y7hKyJNbuKWwxNi2m01Ea+POAgNK5XB/zIiRs
	 ps75F1pHaGGsA==
Date: Fri, 7 Mar 2025 19:01:30 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Counter fixes for 6.14
Message-ID: <Z8rD-jRvDNHPL-ha@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BweHssdNYJh/CgQF"
Content-Disposition: inline


--BweHssdNYJh/CgQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.14

for you to fetch changes up to c0c9c73434666dc99ee156b25e7e722150bee001:

  counter: microchip-tcb-capture: Fix undefined counter channel state on probe (2025-03-06 23:04:50 +0900)

----------------------------------------------------------------
Counter fixes for 6.14

A fix to resolve a timeout error during counter enable leading to a
false report of 'enable' state in stm32-lptimer-cnt. A fix to properly
intialize counter channels during probe to avoid operating under an
undefined state in microchip-tcb-capture.

----------------------------------------------------------------
Fabrice Gasnier (1):
      counter: stm32-lptimer-cnt: fix error handling when enabling

William Breathitt Gray (1):
      counter: microchip-tcb-capture: Fix undefined counter channel state on probe

 drivers/counter/microchip-tcb-capture.c | 19 +++++++++++++++++++
 drivers/counter/stm32-lptimer-cnt.c     | 24 +++++++++++++++---------
 2 files changed, 34 insertions(+), 9 deletions(-)

--BweHssdNYJh/CgQF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8rD+gAKCRC1SFbKvhIj
KxV1AP4j3s86fWmfGoyPFRQMSrMcsRHiGdlJQJBJW9cPubZ9hwEAyzRvlpZ5jAw4
YMX/yVxGPdTLl3WicEIXvAdaGWyyFQ4=
=2QFH
-----END PGP SIGNATURE-----

--BweHssdNYJh/CgQF--

