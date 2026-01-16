Return-Path: <linux-iio+bounces-27870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE14D38484
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB39F305F667
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4F234D4D6;
	Fri, 16 Jan 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5zjriXy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CC34D3AD;
	Fri, 16 Jan 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588762; cv=none; b=scYyz3/jRUt6Ot5wyjz1xXTNTi1A8tY25mTO+RDxu4p3owtM41IHWk8bzAA6c12jecech5qP1y6IGgxf2ou163ESxEGCsB9P/Z/SZSqW9FJMzceSj8NrYuxRWO05GmBC4x31fKRaq9ycgn9x6wMtTaiBLsNDNFMDH+hmGNIMYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588762; c=relaxed/simple;
	bh=JfU6Hmil/kx+Hjons7FSzkCq+upEtdVWBh/phMgdQME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EesYHoiB3SAYlcdHEuvnbkPmzxphskiVCAQRvFVlLHHldKUM6Q9RIRN+B3yMpCY0S94Npo5hlk/ymwFICysb7widWHHsRIL1Cp83pCVNTJMso2iS9EldT5nF53U/Ctv/+O2NRVNCPy8AI4A2CTtb9AnmOaYlvpxcLAXU0eiSsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5zjriXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20695C116C6;
	Fri, 16 Jan 2026 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768588762;
	bh=JfU6Hmil/kx+Hjons7FSzkCq+upEtdVWBh/phMgdQME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M5zjriXyPedwE9sQg7WZzj6nskmNub++sbnFlamy/psYRLZ6ukroKso6yowBRrB5p
	 VlSzJqsmT0918frt70Hr9PfHIB9AfD7JMA+N1CPsq+DME42fM+MI9xElkDbVfCzFfe
	 od2oklfKHgyAh5lfzuzYvfpr2t4S7FvpUbS44izXkNNBtHTM+WyY+Lz1/noy/3likF
	 uR2KCtd3b1Ih8h/zpeqPyGzIi6mioUjdSbETP2SGtVom1CD88QvyOj3rd+XURi9BCh
	 og5KSosQCD1IpPwBRh5xol17SICG5IvT3+rKx0rRmSVNwKo3x/pW9ubnPCsGiTZnTe
	 B163fHzOuV+rg==
Date: Fri, 16 Jan 2026 18:39:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: adc: ad9467: include two's complement in
 default mode
Message-ID: <20260116183915.1bf331ba@jic23-huawei>
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-1-d2c84979d010@vaisala.com>
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	<20260114-b4-ad9467-optional-backend-v3-1-d2c84979d010@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 10:45:50 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> All supported drivers currently implicitly use two's complement mode.
> Make this clear by declaring two's complement in the default
> output mode. Calibration mode uses offset binary, so change the output
> mode only when running the calibration or other test mode.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Given this is not really related to the rest of the series, I'll pick it
up now.  Applied to the togreg branch of iio.git which I'll initially push
out as testing.

No need to send this one in v4!
Thanks,

Jonathan

