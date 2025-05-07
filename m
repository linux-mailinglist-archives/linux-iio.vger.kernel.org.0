Return-Path: <linux-iio+bounces-19262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CF5AAEC87
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BF500A0A
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5F628E59F;
	Wed,  7 May 2025 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tldOHEht"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5C28E59C;
	Wed,  7 May 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647705; cv=none; b=kDIP3jtzdiO7kyskiSfIBqk6VDgVu3B+U+WeMNprOWzIva+LRGByg6W2XBv4nIav1EQCAiQyI05pGREuFLHpqwh5WrwsTaDPz2BZpTqGIhNx7NkZPQFj/a1+JcIAWFhht5j3tzQ+JVs6hnvUq4FSXpdEU4LKUIGPw2a2L9dT55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647705; c=relaxed/simple;
	bh=rPyZzqsMRMqtnqdmdnjavXkrIbpF8/qLDdeqsOJ9Ios=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRrzKFlGvw6vH6nZKQRt7Kam1e2Qv0iphu71kweoBEtKcEFwSjxGTnbc8VeeHNrE89CIU5i7T6Ckc17eEd8pgAaa5W3ZzFsZ6wDTukU82WLl8vExvqpZ9hwLEyaHfYG48/2GLcTYWVhk4togI6r/zgEHrdBe4GC/u/vgu5xLBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tldOHEht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45D0C4CEE2;
	Wed,  7 May 2025 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647705;
	bh=rPyZzqsMRMqtnqdmdnjavXkrIbpF8/qLDdeqsOJ9Ios=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tldOHEhthjMki3eUjuhheaxEcBuzlj5cDaf9AK4eVn2lFYyiSMZEzt9CSx6VxqWUW
	 +zwyNEUGEyawvkXVqh3rRK7PDfn9prDKTfGS5UcoWk425i0gTuGlnRIBlylI74S3k8
	 uh98tdssW9lpqNZZ50oiLbh3UzXb/lLYxklSMxF80KdufATy2oytA3HrrKTgOBsn7D
	 ztjVlTv5/bDRaOV8F4Ni36RkKXJ8FxBhNWxW1akNTK8YatcXJcHB/OKmB/v5WaPtQy
	 176O2ZTvlsbr4HFRj6e3BvQVt6sdeJzMIPowkLI9pKtfz6RBC72mNHjqhEIBMw1WCM
	 9oEUleD95ckaA==
Date: Wed, 7 May 2025 20:54:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Eugen
 Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Trevor Gamblin
 <tgamblin@baylibre.com>
Subject: Re: [PATCH v5 0/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20250507205454.56cbf6e2@jic23-huawei>
In-Reply-To: <ec7c00c640b0b359bfd98d460d067aee64ca069f.camel@gmail.com>
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
	<ec7c00c640b0b359bfd98d460d067aee64ca069f.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 May 2025 07:39:07 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-05-05 at 11:31 -0500, David Lechner wrote:
> > Creating a buffer of the proper size and correct alignment for use with
> > iio_push_to_buffers_with_ts() is commonly used and not easy to get
> > right (as seen by a number of recent fixes on the mailing list).
> >=20
> > In general, we prefer to use this pattern for creating such buffers:
> >=20
> > struct {
> > =C2=A0=C2=A0=C2=A0 u16 data[2];
> > =C2=A0=C2=A0=C2=A0 aligned_s64 timestamp;
> > } buffer;
> >=20
> > However, there are many cases where a driver may have a large number of
> > channels that can be optionally enabled or disabled in a scan or the
> > driver might support a range of chips that have different numbers of
> > channels or different storage sizes for the data. In these cases, the
> > timestamp may not always be at the same place relative to the data. To
> > handle these, we allocate a buffer large enough for the largest possible
> > case and don't care exactly where the timestamp ends up in the buffer.
> >=20
> > For these cases, we propose to introduce new macros to make it easier
> > it easier for both the authors to get it right and for readers of the
> > code to not have to do all of the math to verify that it is correct.
> >=20
> > I have just included a few examples of drivers that can make use of this
> > new macro, but there are dozens more.
> >=20
> > --- =20
>=20
> LGTM
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Thanks,

Still time for additional comments, but given where we are in the
cycle I'm keen to get this at least undergoing build tests.

Applied to the togreg branch of iio.git and pushed out as testing for
those build tests.

Thanks,

Jonathan

>=20
> > Changes in v5:
> > - Add new patch to set minimum alignment to 8 for IIO_DMA_MINALIGN.
> > - Adjust IIO_DECLARE_DMA_BUFFER_WITH_TS() macro for above change.
> > - Drop one ad4695 patch that was already applied.
> > - Link to v4:
> > https://lore.kernel.org/r/20250428-iio-introduce-iio_declare_buffer_wit=
h_ts-v4-0-6f7f6126f1cb@baylibre.com
> >=20
> > Changes in v4:
> > - Dropped static_assert()s from the first patch.
> > - Handle case when IIO_DMA_MINALIGN < sizeof(timestamp).
> > - Added one more patch for ad4695 to rename a confusing macro.
> > - Link to v3:
> > https://lore.kernel.org/r/20250425-iio-introduce-iio_declare_buffer_wit=
h_ts-v3-0-f12df1bff248@baylibre.com
> >=20
> > Changes in v3:
> > - Fixed a few mistakes, style issues and incorporate other feedback (see
> > =C2=A0 individual commit message changelogs for details).
> > - Link to v2:
> > https://lore.kernel.org/r/20250422-iio-introduce-iio_declare_buffer_wit=
h_ts-v2-0-3fd36475c706@baylibre.com
> >=20
> > Changes in v2:
> > - Add 2nd macro for case where we need DMA alignment.
> > - Add new patch for ad4695 to convert buffer from u8 to u16 before
> > =C2=A0 making use of the new macro.
> > - Drop the bmp280 patch since it was determined to have a better
> > =C2=A0 alternative not using these macros.
> > - Add a few more examples to show the non-DMA case, both in a struct and
> > =C2=A0 stack allocated.
> > - Link to v1:
> > https://lore.kernel.org/r/20250418-iio-introduce-iio_declare_buffer_wit=
h_ts-v1-0-ee0c62a33a0f@baylibre.com
> >=20
> > ---
> > David Lechner (7):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: make IIO_DMA_MINALIGN minimum of 8 =
bytes
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: introduce IIO_DECLARE_BUFFER_WITH_T=
S macros
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4695: use IIO_DECLARE_DMA_BU=
FFER_WITH_TS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4695: rename AD4695_MAX_VIN_=
CHANNELS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7380: use IIO_DECLARE_DMA_BU=
FFER_WITH_TS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: accel: sca3300: use IIO_DECLARE_BUF=
FER_WITH_TS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: at91-sama5d2: use IIO_DECLARE_=
BUFFER_WITH_TS
> >=20
> > =C2=A0drivers/iio/accel/sca3300.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 18 ++--------------
> > =C2=A0drivers/iio/adc/ad4695.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 +++++-----
> > =C2=A0drivers/iio/adc/ad7380.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0drivers/iio/adc/at91-sama5d2_adc.c | 13 ++----------
> > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 42 ++++++++++++++++++++++++++++++++++++++
> > =C2=A05 files changed, 52 insertions(+), 35 deletions(-)
> > ---
> > base-commit: 7e9a82ab5b861d3c33c99a22c1245a5b262ee502
> > change-id: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7da=
d6
> >=20
> > Best regards, =20
>=20


