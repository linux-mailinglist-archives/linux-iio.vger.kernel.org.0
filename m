Return-Path: <linux-iio+bounces-3109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDA868116
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 20:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9A4B2454B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8026130AE4;
	Mon, 26 Feb 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFcytFUo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAB130ADC
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975850; cv=none; b=Elaxhn9DNZGLH3ekP6JArFg14bC8bhdLWh1PawXGtBZpG0JwJFDddReDHjW3wonucgJ6kjMVeCwi4AHq5nn6TqaOMmlPbGfkyc6FcdXhzZJrQBsWElTVr7IhC6d8X+07NgWMPr86Jo4HaNKoI5DvebiwARHkHHeaLhButFUaPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975850; c=relaxed/simple;
	bh=kE6zLLb1tnOUDDKFC/quI0xRs/9ThRJHQm/9ZWrhTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cArJXa31GFAHbox7/96tJMNRd8Y8nWXpcBsTCC3QChvXPOUtMMk5ECKa3gxCpymRFW6VngsNuyD7aMOtgAeS0K1MhE1wNKC2O6C/2TmQQWAh55G4YeBbE8EFpkZICgM323elT7MoUvH8PBt3ZbQ1Ley9mJ7XNPvEjb+3nvTDY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFcytFUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139B9C433F1;
	Mon, 26 Feb 2024 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975849;
	bh=kE6zLLb1tnOUDDKFC/quI0xRs/9ThRJHQm/9ZWrhTV0=;
	h=Date:From:To:Cc:Subject:From;
	b=AFcytFUoyGT1ZIa0q6kX6MhuZz3ZKswhsp/fQH1LAJYyGvb8OxuIeW8FaNtMeyo4/
	 Jar/mcQ7YL5effPDRyHS82gNGa36zfDd4be7kBy1Rw6NN8CcnGi1nOxTBfTsqgpEPQ
	 FyGSk+/vFJbsTDz1GT3x60zYGenFeNFfW2p0jrgx90PBCwmEi9FgRFI0zbB3oDigEt
	 d/XTIwf4XfiWWCTgAO9uQcLHdOcgcYAMHMLlSKU0Lsre1W1R5PSdBU5kt+dnAKzOaL
	 KO5WXSEOJmTeTCLCAUZzse3npRH0gw6GKXtcgFJjoms2DNt/+9l8187rNNZW5ojYDX
	 htch1eTd8O73Q==
Date: Mon, 26 Feb 2024 14:30:47 -0500
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Cc: william.gray@linaro.org
Subject: [GIT PULL] First set of Counter fixes for 6.8
Message-ID: <Zdzm51zyzSipL8T_@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5VNEUj3A4kaxKrW5"
Content-Disposition: inline


--5VNEUj3A4kaxKrW5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.8b

for you to fetch changes up to c83ccdc9586b3e9882da9e27507c046751999d59:

  counter: fix privdata alignment (2024-02-16 18:51:00 -0500)

----------------------------------------------------------------
First set of Counter fixes for 6.8

One fix to ensure private data in struct counter_device_allochelper has
minimum alignment for safe DMA operations.

----------------------------------------------------------------
Nuno Sa (1):
      counter: fix privdata alignment

 drivers/counter/counter-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--5VNEUj3A4kaxKrW5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZdzm5wAKCRC1SFbKvhIj
K2hhAP4xlysEUmsDtRY04XV22J5rUxWj0apLzIouRklPIEq8swEAvE8qksHzZqO8
Ze+YU4QF4xabyAmxAjlYI0gTnCQyCA0=
=Apxi
-----END PGP SIGNATURE-----

--5VNEUj3A4kaxKrW5--

