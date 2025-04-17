Return-Path: <linux-iio+bounces-18197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652EFA92205
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5268189E7BB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDA2253F37;
	Thu, 17 Apr 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="CiN6Hkn2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10DB253956
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905240; cv=none; b=GkFT2N3JOChO/4C2sAYMpXzPyXr7/sWNKtqUmrMa+BnItnSWOFrLoKhbiJiwGrRjt61xVO5QMwroapkyWY+PT+dcqS+wYALrh+kg3ND5Y/lLC0ZPLNm8AZBJUmbO/pkYvfQf0kf70rKKzrAC7IKmbvneWXtTlHoMelq649ttjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905240; c=relaxed/simple;
	bh=ZIBfrh/c201PDhvEu0wpq1QFp8dzTYEC0yDBA/8kVyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HoQX9VGyI5nZSVA+zDWAITv5vUt6SeUisBl1495UyRl4RdMuTtkILqhA/EmndIU5+MlQKHxtS8vozyAvS7zKufqUnrhA+wrpt8gCqXk5YYwKdT4vN8ZaV407bDKXf2ABXhm58jwqllV6a3Qe6GiqeHXKE7uYGjC+rQaFD/3P/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=CiN6Hkn2; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1790A240028
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 17:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1744905237; bh=ZIBfrh/c201PDhvEu0wpq1QFp8dzTYEC0yDBA/8kVyE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=CiN6Hkn2jpDgTZz2Wie9Y97B6G/CKVswp0PfEZocu+aAYVRAp9atFDkI9qlP6Hjkg
	 eSzNUhBCmYpzvukvtPFCovY/rxlbRUZSIbIhw8rKhL8k+OIgq2t1YUtkqiuX5mzvrL
	 gtDjOwwuIhfFfdof91DPXrsB4iHRnNPNmLlvDixF5geAkfGt12nm1DeQQXF4IR+4BG
	 W42AHTb4iRsbv1mZvYD5IiiyDvonCa0znnmbB+PNCF0sOAoVgcLKmYWWad+Oho0hq+
	 plwvb+M8GOIPxo3rSnbB7qqKAHNtaDfPvNXOhm9J0+bkNGMjsur8k+KU5nYARZz/RM
	 HI5XFH4ixUiMQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Zdj9t5XRkz6txd;
	Thu, 17 Apr 2025 17:53:54 +0200 (CEST)
Message-ID: <56edfb88d3f31939fb343149bfad436f24671f9d.camel@posteo.net>
Subject: Re: [PATCH] iio: frequency:: Remove unused parameter from data
 documentation
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com
Date: Thu, 17 Apr 2025 15:53:51 +0000
In-Reply-To: <20250417143220.572261-1-gshahrouzi@gmail.com>
References: <20250417143220.572261-1-gshahrouzi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 10:32 -0400, Gabriel Shahrouzi wrote:
> The AD9832 driver uses the Common Clock Framework (CCF) to obtain the
> master clock (MCLK) frequency rather than relying on a frequency
> value
> passed from platform data.
>=20
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
> =C2=A0drivers/staging/iio/frequency/ad9832.h | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/staging/iio/frequency/ad9832.h
> b/drivers/staging/iio/frequency/ad9832.h
> index 98dfbd9289ab8..d0d840edb8d27 100644
> --- a/drivers/staging/iio/frequency/ad9832.h
> +++ b/drivers/staging/iio/frequency/ad9832.h
> @@ -13,7 +13,6 @@
> =C2=A0
> =C2=A0/**
> =C2=A0 * struct ad9832_platform_data - platform specific information
> - * @mclk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0master clock in Hz

Hi Gabriel,

This seems to be a leftover from
566564e80b0ed23ffa4c40f7ad4224bf3327053a ("staging: iio: ad9832: use
clock framework for clock reference")



> =C2=A0 * @freq0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0power up freq0 tuning word in Hz
> =C2=A0 * @freq1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0power up freq1 tuning word in Hz
> =C2=A0 * @phase0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0power up phase0 value [0..4095] correlates
> with 0..2PI


