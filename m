Return-Path: <linux-iio+bounces-19418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63FAB26EC
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 08:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC913A4D3E
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 06:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738FA1519B8;
	Sun, 11 May 2025 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiQiezTa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF433C9
	for <linux-iio@vger.kernel.org>; Sun, 11 May 2025 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746945813; cv=none; b=ssQ7EfNYkiipZ5lgT4nloziBC99NPVSZCdyc8DkE1THMfdMyZgbENJOpIkHRqnD/ShbhM4Epw986V7YDwqMwFHmS+mtZmFQovF3xq37n7xzDls7CPwPpRRPMU4WXciKgyY9pRi7IRQ/4VBE5QCgMapHc3VTrmerPTnZUeXO8Jqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746945813; c=relaxed/simple;
	bh=3DIKxzkIl0tKEEFa6TIWiwShSwA5A2HEOLYUT55Kr3Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J5o0T4ZFg53Nzym0W5bfVQsfNU30oZTcMxIzjV3CGHTt+W7xWz4x2ljJSrZSxub+5Rmyd4y3iWJJx6LwMJw5ZvCBGtXoNeFksrh9GyvdOnUYTfA9A3550QFgCVW1EGtCveXUo9eUXKCcdnfdC5B8VtxYF43nnGcnE0clWbYkcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiQiezTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143E6C4CEE4;
	Sun, 11 May 2025 06:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746945812;
	bh=3DIKxzkIl0tKEEFa6TIWiwShSwA5A2HEOLYUT55Kr3Y=;
	h=Date:From:To:Subject:From;
	b=DiQiezTaScLd0BYvcXKnUCayAwbm2tFwv4W5sTi7GDUMy2bElUeE6v5RAJzUEN2R5
	 Lfs8mojIUWXmasQdxIKmzTh6ejO7/RIsTHOS99D9NiwObHGCqEZlkNjbXjitizgne4
	 jAHNAnSM/b2Sonv1299uKAdhprn39WcPgmdrTyO9rPaTfenFv9vYMXZGu8KKWlS7Ow
	 XsB8DWz5aVw0RcwEF95f5kliojvDbT/s7YQ6oiyCt/qYFcnTsNiUKvZ6p/yfCqOREp
	 fI0Kj9yGxpF+9trSAxMlazq1MimPavojKNqQVJvKv3kk0kNPFkcGObaSa71Gw2E0Zm
	 xTyW/eMhZA95g==
Date: Sun, 11 May 2025 15:43:29 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Counter fixes for 6.15
Message-ID: <aCBHEaGd0qlzkZa5@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PVhbzCu/GUBGZ+7c"
Content-Disposition: inline


--PVhbzCu/GUBGZ+7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.15

for you to fetch changes up to 7351312632e831e51383f48957d47712fae791ef:

  counter: interrupt-cnt: Protect enable/disable OPs with mutex (2025-05-03 08:45:11 +0900)

----------------------------------------------------------------
Counter fixes for 6.15

A fix to prevent a race condition when accessing the Count enable
component in interrupt-cnt.

----------------------------------------------------------------
Alexander Sverdlin (1):
      counter: interrupt-cnt: Protect enable/disable OPs with mutex

 drivers/counter/interrupt-cnt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--PVhbzCu/GUBGZ+7c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaCBHEQAKCRC1SFbKvhIj
Kw+BAPoCNQGu63SgFpQ1D9e470tLl0v8eIjBxB+ogN+4pXHDeQD/XLhyDHu1fAO1
V4wUnor98aVBKRFm9Yt0QLrJZD3+UAk=
=sx7b
-----END PGP SIGNATURE-----

--PVhbzCu/GUBGZ+7c--

