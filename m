Return-Path: <linux-iio+bounces-25480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55220C0E7B9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AE718921D0
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772A01A5B8B;
	Mon, 27 Oct 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUvvHxlR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312512C11F3;
	Mon, 27 Oct 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575836; cv=none; b=U4m3cs99LvT2VD1KN0IHagx1dn6PA9JO4h91TZiFsiuuxHoZ3PVTThB0eIE8ShTEZDkiJttUZQCQFTcMQVmY7o0AUy8kQfN5GZ5pWasSiS6IjxsychXCCCLCIyKRriWsAXVBsfEhPRl31cIUuBTYyvMCEpsz2chnvrD0R039ugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575836; c=relaxed/simple;
	bh=fK8brO77qTePoebFZKcHMgovSqHDLDSa8gkUNQGjX9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9gO/INgjZYzinTv6rsHDJLinziNk5ENx1Xiqc/Fza9mUwSxsWBJGAtEYNoAOlZ40G6vo8uDvc8O/jB28lIvAjAr7Dhbk/roDplsDyTRTVh1rbAr38SsRCj6JJqsxY8lengiGhRiamc/DDTuVrW7xwNTiITXSfa1DXS5XB3qsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUvvHxlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AF4C4CEF1;
	Mon, 27 Oct 2025 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761575835;
	bh=fK8brO77qTePoebFZKcHMgovSqHDLDSa8gkUNQGjX9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUvvHxlRXl2ha0Fe+FglNZrwhx6rY3TXiOlNGnvg+K+JzlSN/7mgoU1k8oaRAOokY
	 88nGxFAL1x7YmbTrltoF30Uc70+QcLcRzzpjKSFdwKwlsG4hFzNTWjWD+N6SDQflok
	 9gcAXAxEgTOt+7eQlDyQOZ82bROJAlRxL3MmJJlz5wPCKqv4Ef3207TevZhPR6r046
	 dx1vi/4LI1Z3PFOv5AWvo2xUSIuT21t0MomRv3rB4XPdiVX8Yj3k2d0vwZUHT6ntKe
	 Um/Z5uGaDygDuwJCRsjRUtKS2+vuxXHCTPdxD7tViL1NEoldfCK9zLsUM/I5W5+GZD
	 E4A8n9kTx7V2Q==
Date: Mon, 27 Oct 2025 14:37:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis: fix all kernel-doc warnings in header
 file
Message-ID: <20251027143710.35ca032f@jic23-huawei>
In-Reply-To: <ff1af8b4d43ce31cbf94623e36b721b057ca4077.camel@gmail.com>
References: <20251026024759.433956-1-rdunlap@infradead.org>
	<ff1af8b4d43ce31cbf94623e36b721b057ca4077.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 13:03:54 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2025-10-25 at 19:47 -0700, Randy Dunlap wrote:
> > Correct and add to adis.h to resolve all kernel-doc warnings:
> >=20
> > - add a missing struct member description
> > - change one non-kernel-doc comment to use /* instead of /**
> > - correct function parameter @value to @val (7 locations)
> > - add function return value comments (13 locations)
> >=20
> > Warning: include/linux/iio/imu/adis.h:97 struct member 'has_fifo'
> > =C2=A0not described in 'adis_data'
> > Warning: include/linux/iio/imu/adis.h:139 Incorrect use of kernel-doc
> > =C2=A0format: * The state_lock is meant to be used during operations th=
at
> > =C2=A0require
> > Warning: include/linux/iio/imu/adis.h:158 struct member '"__adis_"'
> > =C2=A0not described in 'adis'
> > Warning: include/linux/iio/imu/adis.h:264 function parameter 'val'
> > =C2=A0not described in 'adis_write_reg'
> > Warning: include/linux/iio/imu/adis.h:371 No description found for
> > =C2=A0return value of 'adis_update_bits_base'
> >=20
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > --- =20
>=20
> Thanks!
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied.  Thanks.

Jonathan

