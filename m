Return-Path: <linux-iio+bounces-19419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BFAB26F5
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 08:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6CD1757A4
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0673A19D8A8;
	Sun, 11 May 2025 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBG3bpFo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D71632CA
	for <linux-iio@vger.kernel.org>; Sun, 11 May 2025 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746946729; cv=none; b=jpRqfo6wMgItfp3eu/5y+sg4rQXl1pQd2hMLH5LiFOCrPaumlye58FevBnKoe5wvHN66H/FpEZGsPFdZ11n5cyTgEWYzXbxA32z9UaHNnQfeBvOURssQurQpfwN7QR7MY5v6i6XnywEEwuVox6eEkWBxCH5bXxjNSd9AcCjcE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746946729; c=relaxed/simple;
	bh=Bi6fEfXgxO2qYuuse10TP3e24tEa/wxUQ0Qu/XN8vuM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HvWP7ehY/N5z8Sgf42BYt6miITOCMUF/RN1zcNUKOzqmoVSS06Rc7AucibQ951hIDTUP1BDT0HIKrr4VxM8+YIKyN8+2gVWxifQWlZlxrjudFFRrr/K0CHPyRwoIyV1SqRNkRQPvFyePtroO2an87dbXTD+zlOep/qtfLqcaQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBG3bpFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0752C4CEE4;
	Sun, 11 May 2025 06:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746946729;
	bh=Bi6fEfXgxO2qYuuse10TP3e24tEa/wxUQ0Qu/XN8vuM=;
	h=Date:From:To:Subject:From;
	b=WBG3bpFoz8j6h+/BFkA2PSf+wWKlyhr7W8Pe/kvMVRp8o+GBjTPsQq4NUBatAmx2s
	 vmS73k/wsYfoBakRAY+Du+NablqZaJn7nOD5k8CAH9sLatFPYQvd0anmuhqK8sPYnj
	 ADoOrYOznnzkjx6mxXuM46CdBwh4AgbIUcyClDbjHwxoMxs2pvNfRT1bUrNjSNDBLc
	 0B1mcukRmh7FBeKNaf6ar4fiAIEF6aOpdKaq+b/RdCJTKdcIemwe/DGx6VIcmHCcZW
	 +9S3UElYqGEGSNUKeVGsYQuX0eNM8B7ADCah2HwF9VGkK5Yx2534197/siyCFrLlmF
	 0ocRjYdIcCl9w==
Date: Sun, 11 May 2025 15:58:46 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Counter updates for 6.16
Message-ID: <aCBKpiURrnfaacBf@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wF5OyJjnSlcDvA2c"
Content-Disposition: inline


--wF5OyJjnSlcDvA2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.16

for you to fetch changes up to 08e2a660b1601963ced37ac8e8d8c134a97f167e:

  counter: interrupt-cnt: Convert atomic_t -> atomic_long_t (2025-05-02 22:46:01 +0900)

----------------------------------------------------------------
Counter updates for 6.16

An update to allow for larger count values in interrupt-cnt.

----------------------------------------------------------------
Alexander Sverdlin (1):
      counter: interrupt-cnt: Convert atomic_t -> atomic_long_t

 drivers/counter/interrupt-cnt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--wF5OyJjnSlcDvA2c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaCBKpgAKCRC1SFbKvhIj
K4Z+AP0WSqlWjKwWytLDWq32BpQRYu7GptHHLq0cEw7uVvdNOQEA5qwp2PWpPeY3
irSIVpemR604V2jjJM7CHVv7Dru/MQc=
=ay9h
-----END PGP SIGNATURE-----

--wF5OyJjnSlcDvA2c--

