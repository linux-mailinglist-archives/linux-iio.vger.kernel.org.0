Return-Path: <linux-iio+bounces-11963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B459BFEC1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 08:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436351C21338
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 07:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639B19412E;
	Thu,  7 Nov 2024 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwT7BCXa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A5192590
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963052; cv=none; b=o0OSADQosmIEaVyPJrzuVogmEi7Tp0ss5ng1klNC7JS6MhE1EOjyenQ7ybdO4Q9uIFiljpAhXFBUQ3esZDGqo+B++vaj8oE9KyV3daInb1hOBYzWakBCJFZ7xnFamQ3wdWWb5k2aE43qHVWUBcLKFtU4mnHQQqtL5rZVNjEuv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963052; c=relaxed/simple;
	bh=N3/+ju5yw6p2FHRc6Y8jM3pT7IqVbi64th6i/atdv8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z8YfSIN/tXsaR43+SAoQVnaPaWy3cfwVgvkYEAj6+23hneM57vr3xGe5mI8WbzBklxlwo9lFGdLUFptD1jfVRUa90yggXJIGIrqb9KiPx7Uv9Nw/HBdKsbN8Q3YGY3qzQqImK8YbTJyYI10eap2Pq8hw/V86QRGMbZruhB7fUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwT7BCXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E097C4CECC;
	Thu,  7 Nov 2024 07:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730963052;
	bh=N3/+ju5yw6p2FHRc6Y8jM3pT7IqVbi64th6i/atdv8M=;
	h=Date:From:To:Cc:Subject:From;
	b=jwT7BCXas0bFNuA0Y0NWFAqxcQmhrKYjzGj+xYSN3DaW24F4lNvbCRD7F5Ljm6aKO
	 1XYaSxXziKZ6iLyuiw0lEtpZn4wZaEJdf2ml6LB6imsAfRd6dNi/C2oiIdi+XcZxEJ
	 4xm3RNQf/Co5NHkmMjqH/vZVVmcLWdHqhKUAxadVa0wUjFuAU71wei72vCZr+aMYsF
	 wDzZBTXczuor5rFuvlF7FzxGuh+47lQcED07pKaNVOIlg0lGIuwIOvsMji3/ksVs8X
	 AQKdMhwu10VGq2ihdKzNk6wJK/G0EUKBvu4BrBmfWoEpjkL1vxmK0arEj0OwWBpSDs
	 9rnAwJ3o7fCQQ==
Date: Thu, 7 Nov 2024 16:04:06 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter fixes for 6.12
Message-ID: <ZyxmZi-xVcDV4lVL@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hQCOs4jsOANUc1Ac"
Content-Disposition: inline


--hQCOs4jsOANUc1Ac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.12

for you to fetch changes up to 1437d9f1c56fce9c24e566508bce1d218dd5497a:

  counter: ti-ecap-capture: Add check for clk_enable() (2024-11-05 09:20:11 +0900)

----------------------------------------------------------------
Counter fixes for 6.12

Fix device_node handling in stm32-timer-cnt by calling required
of_node_put() after device node is no longer needed. Check and handle
clk_enable() failures in stm32-timer-cnt and ti-ecap-capture.

Signed-off-by: William Breathitt Gray <wbg@kernel.org>

----------------------------------------------------------------
Javier Carrasco (1):
      counter: stm32-timer-cnt: fix device_node handling in probe_encoder()

Jiasheng Jiang (2):
      counter: stm32-timer-cnt: Add check for clk_enable()
      counter: ti-ecap-capture: Add check for clk_enable()

 drivers/counter/stm32-timer-cnt.c | 17 ++++++++++++++---
 drivers/counter/ti-ecap-capture.c |  7 ++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)

--hQCOs4jsOANUc1Ac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZyxmZgAKCRC1SFbKvhIj
K9S3AP4mCe60ilPR7vJmpYF/iLqYGokGuGUjPSwch1vpPIN7AQD/ZV7efuHBtn6C
IzNNH1861Eqe4WUlvziMnfBzMdTPBAw=
=FdUh
-----END PGP SIGNATURE-----

--hQCOs4jsOANUc1Ac--

