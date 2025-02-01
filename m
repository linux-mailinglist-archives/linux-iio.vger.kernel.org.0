Return-Path: <linux-iio+bounces-14810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE3A2491D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81621886751
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCFD1AC88B;
	Sat,  1 Feb 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpCwiArC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBF10E0;
	Sat,  1 Feb 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738414061; cv=none; b=iuGnedyzgIggPnElm9qSNl96zJ6PMLgH4VIU+utVVgo7q9Gho416nwPtrAd7akUjZX82zlXVmF420FpdlSkGjgJ7GXpDIEfvuWb5Irrj4rbzH7eq1pBQZfe/Ry2RyAr7pQqmkJEjeS8Uj29vZchE625o+ZAspnlunjzRr33diUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738414061; c=relaxed/simple;
	bh=UKPyLuJDQ7LBUqpJghi/mho9AX/9KRkS6LiXnA+hlQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAcSPHTe0eZ04oOGhgvbjI7XaEsCNLjVe/cDAGShPAf3szDywWuzzwjpPnsyfxU7GdPJGRJ8Q4p5RFEytEkIpCMDfE/o1XeA+rKyfSxjW0hPyakyli5VOp+kzPigizGqSj3c7lSq1vEPQn72jVISRmY8Mugd/t63sc2q+BirB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpCwiArC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D27C4CEE2;
	Sat,  1 Feb 2025 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738414061;
	bh=UKPyLuJDQ7LBUqpJghi/mho9AX/9KRkS6LiXnA+hlQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HpCwiArC7WGsu4TaxzZkl0M1l4CBNzLQfBWync8jNfSq6HCWDbOFba/fozCoVbKZ9
	 b2anEfIBXD4UM+rx3HjFR9QOll2qakr4eJUbqXi6/N+yD8VVsC9eGFhzVY/ovFgLN7
	 SU7wVO5Lu42wz061jKyxEQ2d9C4ljGmpfxmkWKZ+AgAEjBMBEci3jZDA/xGdTUWc2m
	 k4D+N63yYCrgBtTlmIm64M0Mum7y73CVSEU5Uy6Ytk//gvNxVBWEX5MMTQsN/8QJRy
	 Npi4t7TImvTwfnh6taIu4btJcp4qBSMcXLRjATQsnEHA9jEdqDnfFDa7tr1W6N2XMt
	 HKC4MbIB8+P6Q==
Date: Sat, 1 Feb 2025 12:47:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, Icenowy Zheng <icenowy@aosc.io>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich  <Michael.Hennerich@analog.com>, =?UTF-8?B?T25kxZllag==?= Jirman
  <megi@xff.cz>
Subject: Re: [PATCH v1 0/3] iio: drop useless assignment of cache_type
Message-ID: <20250201124732.2086afb0@jic23-huawei>
In-Reply-To: <a63a6a52102fc918ef60ed5ced0505729387a4fc.camel@gmail.com>
References: <20250129152546.1798306-1-andriy.shevchenko@linux.intel.com>
	<a63a6a52102fc918ef60ed5ced0505729387a4fc.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jan 2025 08:30:47 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-01-29 at 17:24 +0200, Andy Shevchenko wrote:
> > Default value is REGCACHE_NONE, no need to assign it explicitly.
> > Fix all IIO drivers that do that.
> >=20
> > Andy Shevchenko (3):
> > =C2=A0 iio: light: adux1020: Drop unneeded assignment for cache_type
> > =C2=A0 iio: magnetometer: af8133j: Drop unneeded assignment for cache_t=
ype
> > =C2=A0 iio: pressure: zpa2326: Drop unneeded assignment for cache_type
> >=20
> > =C2=A0drivers/iio/light/adux1020.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 1 -
> > =C2=A0drivers/iio/magnetometer/af8133j.c | 1 -
> > =C2=A0drivers/iio/pressure/zpa2326_i2c.c | 1 -
> > =C2=A0drivers/iio/pressure/zpa2326_spi.c | 1 -
> > =C2=A04 files changed, 4 deletions(-)
> >  =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

Thanks,

Jonathan


