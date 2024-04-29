Return-Path: <linux-iio+bounces-4655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCAF8B65EA
	for <lists+linux-iio@lfdr.de>; Tue, 30 Apr 2024 00:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2E8B21322
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 22:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC03C2E3E5;
	Mon, 29 Apr 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONvqc4cA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EE1E888
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431184; cv=none; b=InhnNYBE5AauqvfIZZB18QboBKlh/bGE+ydh79Ew1V6gjNzFTXrKyV15qypu+XzwujGnemIjrMKJWyFoUdJoGWRrii1j4hq23TwOTeMJh6LT0iz6BWxOEuhsoKCo/T2dxJAjYOG96LS2yVzt136c7h8cPOZZ/bTQWArt4FhkeII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431184; c=relaxed/simple;
	bh=CaoWKXjBywaoxHq89reyhkHVTr6uCUENh/7w3oTc8oU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EZNnkalYz+D3zN2uo69Upo5ZBhAce1WFTHbqyRMfYiumlH7PJFbSYfKPTFGPtkWKqj5RIdHiL1dDv8+gYbPhx8O9ibOVixsLrLAA+cFZittoiTwLU1v7L6urRYCMnIBr/m52yC9yul7Mj5PkvJucSYp2+tdXsJ8jHLoIfy+ueuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONvqc4cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EECC113CD;
	Mon, 29 Apr 2024 22:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714431184;
	bh=CaoWKXjBywaoxHq89reyhkHVTr6uCUENh/7w3oTc8oU=;
	h=Date:From:To:Cc:Subject:From;
	b=ONvqc4cAl/5vkUJnprWtKXPvrvVGWaXbkRHb43M0ydJnoH6ofq075KVW2RhK4eNY1
	 +FH2qwrgt9XeSM5EgHkpNLSRnqqEvsG3J44rvafLqZhS9+zoUtnvdW3Oijq3S785JP
	 JWZT9/qkaCKg8LcvOaXTFXRPJOTKB/8tOvgAVJ22Xe2R4tdIybsLJ8ZU1Og5+usvuD
	 RhUoayBbmRAVIbPjrVa1E07vh3rWNM5Q8fU7/YPHN4+XaqIub05LXZuPVRMTuGqWJt
	 +9UYmp6X4hfcCaOGUZ8Q7jshLxHP77+uGBQM9YOJq4nHg3dNJFSXMD6JHwj4dS6cx2
	 1p1EAXnCs6GDw==
Date: Tue, 30 Apr 2024 07:53:00 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Second set of Counter updates for 6.10
Message-ID: <ZjAkzFeHTJXY1LA0@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="440LJO6ZB5vGl7sv"
Content-Disposition: inline


--440LJO6ZB5vGl7sv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 916baadd293a4d11e08a7ca1e2968314451ade6c:

  counter: ti-ecap-capture: Utilize COUNTER_COMP_FREQUENCY macro (2024-04-02 13:15:03 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.10b

for you to fetch changes up to 89d5d9e9500826cbd3b15ea7b6e8d9fae966f073:

  counter: Don't use "proxy" headers (2024-04-23 09:03:37 +0900)

----------------------------------------------------------------
Second set of Counter updates for 6.10

Counter header file is updated to include only headers that are actually
use.

----------------------------------------------------------------
Andy Shevchenko (1):
      counter: Don't use "proxy" headers

 include/linux/counter.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--440LJO6ZB5vGl7sv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZjAkzAAKCRC1SFbKvhIj
K5NBAPsGyOSVbS8+Ys8SOcnxFexgJ7LMAJXYM5p5tkZFnh530QD/WVVN/i1GJt43
TKaWKAE67FBupW8poNv4ZZDjPna9ZAo=
=v0y0
-----END PGP SIGNATURE-----

--440LJO6ZB5vGl7sv--

