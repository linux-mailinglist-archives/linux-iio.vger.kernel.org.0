Return-Path: <linux-iio+bounces-15950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492E3A40937
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615793BA98B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D8018A6A7;
	Sat, 22 Feb 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqhcwYUl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339C1386B4
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235730; cv=none; b=BVj6fWMNOoFlWWXBwCXErtUugqS/3GwGXgC15NwwoipFuNpARTiHxeY2VdkdMT4MjGTsZpw7SWBghq/XhiXVZr1c3RuDfEJrTgfJwYZZIpoi0hbaFtIOkbLLQ8kvEdHaj8cwsGGCI3MAFUkosGc79q+bYRfW2s+TuhEnUUn4s8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235730; c=relaxed/simple;
	bh=3G9jTFn5PAmChzhooV8K9fR+QkfdqIWOsiZBUBwWuCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVI4utxl4wiK5B85X+pm3lyuMjGBm0gSh+ySfV2uFoM7qxS0OBB5lv0sOpvv/uhbENLceWv2CzjK431hrrZpi25Nw2P960kNTxhwaWPKTLyvnvACweIgcUkhK3/pKjK3OiLiV4AjYy7gtPwvV7S8nF60aW4oR1p9cVUTu2p75b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqhcwYUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F78C4CED1;
	Sat, 22 Feb 2025 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740235729;
	bh=3G9jTFn5PAmChzhooV8K9fR+QkfdqIWOsiZBUBwWuCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sqhcwYUl4GYHxPzrAc4H6dp4DGYMWU1h3Ox9px+yjJV0h7PUqq9mbqYZ6/Q93oMKQ
	 sEB4ByPtMyo7iSkblC44kSFtB41Um6kY1H49lEu/Db1pgWz6mSQ0f6lvrmquC4iGWm
	 Fy215qcrHMRZJd12B6VjWzvjH6K992b7hudGF28SfqiNDtq5kb31GPZ2/yhPo4jeKy
	 MkIREVT6QidxObaAFVDYRDfc4Lu/bn7OXYfj8uI0ScuLtGS98fgR3TLmrblWNzSBQ9
	 J0O1Gteyl4mgMSL4x++mkNWvF63RGJNreOPL29exWwouaOgmi+A7GcSbQstZZqoduR
	 ajb/FEEQp/oNA==
Date: Sat, 22 Feb 2025 14:48:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Guillaume Ranquet <granquet@baylibre.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Michael Walle <michael@walle.cc>, Dumitru
 Ceclan <mitrutzceclan@gmail.com>, Andy Shevchenko <andy@kernel.org>, Nuno
 Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iio: adc: ad{4130,7124,7173}: A few fixes and
 ad7124 calibration
Message-ID: <20250222144843.22c1431c@jic23-huawei>
In-Reply-To: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 19:31:07 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> this v2 series is a rework of two series:
>=20
> 	https://lore.kernel.org/iio/20250212105322.10243-5-u.kleine-koenig@bayli=
bre.com
> 	https://lore.kernel.org/iio/cover.1738258777.git.u.kleine-koenig@baylibr=
e.com
>=20
> ; they overlap thematically and so I put them together in a single
> series.

I considered tidying up the things David raised in patch 2 and picking
the first 4 patches up now, but that doesn't give room for others to apply =
tags
if they want to, so I'll wait for v3.


>=20
> Changes since their (implicit) v1:
>=20
>  - Use static_assert instead of BUILD_BUG, add more comments to the "Fix
>    comparison" patches
>  - Make ad7124 internal calibration actually compile
>  - Sort the fix to the front of the series and add a Fixes: tag
>  - Implement system calibration
>  - More comments and commit log improvements
>=20
> The "Fix comparison" patches trigger a checkpatch warning because the
> struct members are considered wrongly indented. For me the indention
> looks right, but I don't feel strong here and happily adapt if
> requested.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (6):
>   iio: adc: ad_sigma_delta: Disable channel after calibration
>   iio: adc: ad4130: Fix comparison of channel setups
>   iio: adc: ad7124: Fix comparison of channel configs
>   iio: adc: ad7173: Fix comparison of channel configs
>   iio: adc: ad7124: Implement internal calibration at probe time
>   iio: adc: ad7124: Implement system calibration
>=20
>  drivers/iio/adc/ad4130.c         |  41 ++++-
>  drivers/iio/adc/ad7124.c         | 293 ++++++++++++++++++++++++++++---
>  drivers/iio/adc/ad7173.c         |  25 ++-
>  drivers/iio/adc/ad_sigma_delta.c |   1 +
>  4 files changed, 331 insertions(+), 29 deletions(-)
>=20
> base-commit: ac856912f210bcff6a1cf8cf9cb2f6a1dfe85798


