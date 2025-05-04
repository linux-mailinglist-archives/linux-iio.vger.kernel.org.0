Return-Path: <linux-iio+bounces-19059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33742AA8860
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E79F189279B
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC491E0DD8;
	Sun,  4 May 2025 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZBhADz8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE613D539;
	Sun,  4 May 2025 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379080; cv=none; b=h/z5K5bbB4FLTzAqKc88fimytspLbJb+yr3DGaTTFmLbl19qPgAFFFPBPFiLrafnsmq/viPr+s0GVEdhoM/COX8J9jrIOYg4Vn87uBV4EBSDxwK2bdWld33lK2EPxQB5xIQMfABz93uFtsX61P61Xvq6bFPK/kAIuBCYPMwYfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379080; c=relaxed/simple;
	bh=xN/UhnYZvA8bqFUTBIzPLHgfDCJcKLVH31XKcoauZwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0Xlqi2rW11nD0B8QYe5cBiVUhRTrUdFzRTlZ9vcO4wKcFF8uWFilsb2A4R0lW5D7MlcuSVFlz+3Lkc6IHpTP20ALjRr5I47cvYSu3Zk0TCiHhAu/wlqTahtS2XMcznRh9agGbIKqSSdXjiOYhD0OuneSK/u+xgKdcmllve0M94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZBhADz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E156C4CEE7;
	Sun,  4 May 2025 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746379079;
	bh=xN/UhnYZvA8bqFUTBIzPLHgfDCJcKLVH31XKcoauZwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cZBhADz8LGQJIOY0/6Co3GLbELT0YZ6cx/72kXDSyoGXppqn3YdSFL5G2UuKPGEXU
	 boef0+PndSalbZGpo4uax6JS6/+J1HtAvt+mfQ8UMAX5oPMx2PR6b54Ctwtkd5q2zD
	 1rtAT0hfzXd3LB7v37MO+IYhYFOZLdqquLOkQ+olBr98iKM7WAm9nVmXtKqFhjRobI
	 lxWaEhS484I9GMSkk1tPiZnrdjqPf76zUqccIFqlb00hA3aXZrP+WSjWoXtvjnLkkZ
	 wX9kikVPJLDYySP1i3gKczodzVriItRdZ7B18jC/xF87gCjE+3F+0PuJ9TdPFYVkt/
	 VeERNLNRN856w==
Date: Sun, 4 May 2025 18:17:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Eugen
 Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Message-ID: <20250504181749.67d0d92e@jic23-huawei>
In-Reply-To: <38e243b0-e81b-4d4d-97fe-91ea2bec6270@baylibre.com>
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
	<20250428-iio-introduce-iio_declare_buffer_with_ts-v4-1-6f7f6126f1cb@baylibre.com>
	<1d90fae5-9c58-4a77-b81c-2946e7cc74d4@baylibre.com>
	<5c762653-b636-45bd-8800-e804ad8dfda5@baylibre.com>
	<CAHp75VfcmvLhBDjbu6x46wGyzG+i7=rVypzSm11qzWN9Qq_rew@mail.gmail.com>
	<38e243b0-e81b-4d4d-97fe-91ea2bec6270@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Apr 2025 14:47:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/29/25 2:36 PM, Andy Shevchenko wrote:
> > On Tue, Apr 29, 2025 at 10:31=E2=80=AFPM David Lechner <dlechner@baylib=
re.com> wrote: =20
> >> On 4/28/25 9:12 PM, David Lechner wrote: =20
> >>> On 4/28/25 3:23 PM, David Lechner wrote: =20
> >>>> Add new macros to help with the common case of declaring a buffer th=
at
> >>>> is safe to use with iio_push_to_buffers_with_ts(). This is not trivi=
al
> >>>> to do correctly because of the alignment requirements of the timesta=
mp.
> >>>> This will make it easier for both authors and reviewers.
> >>>>
> >>>> To avoid double __align() attributes in cases where we also need DMA
> >>>> alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS(). =20
> >=20
> > ...
> >  =20
> >>>> +/**
> >>>> + * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer =
with timestamp
> >>>> + * @type: element type of the buffer
> >>>> + * @name: identifier name of the buffer
> >>>> + * @count: number of elements in the buffer
> >>>> + *
> >>>> + * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_=
DMA_MINALIGN)
> >>>> + * to ensure that the buffer doesn't share cachelines with anything=
 that comes
> >>>> + * before it in a struct. This should not be used for stack-allocat=
ed buffers
> >>>> + * as stack memory cannot generally be used for DMA.
> >>>> + */
> >>>> +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count)   \
> >>>> +    __IIO_DECLARE_BUFFER_WITH_TS(type, name, count)         \
> >>>> +    /* IIO_DMA_MINALIGN may be 4 on some 32-bit arches. */  \
> >>>> +    __aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64))) =20
> >>>
> >>> I just realized my logic behind this is faulty. It assumes sizeof(s64=
) =3D=3D
> >>> __alignof__(s64), but that isn't always true and that is what caused =
the builds
> >>> to hit the static_assert() on v3.
> >>>
> >>> We should be able to leave this as __aligned(IIO_DMA_MINALIGN)
> >>>
> >>> And have this (with better error message):
> >>>
> >>> static assert(IIO_DMA_MINALIGN % __alignof__(s64) =3D=3D 0); =20
> >>
> >> I was working late yesterday and should have saved that reply until mo=
rning
> >> to think about it more!
> >>
> >> We do want to align to to sizeof(s64) instead of __alignof__(s64) to a=
void
> >> issues with, e.g. 32-bit kernel and 64-bit userspace (same reason that
> >> aligned_s64 exists and always uses 8-byte alignment).
> >>
> >> So I think this patch is correct as-is after all. =20
> >=20
> > I'm wondering, shouldn't it be better just to make sure that
> > IIO_DMA_MINALIGN is always bigger or equal to sizeof(s64)?
> >  =20
>=20
> Sounds reasonable to me. From what I have seen while working on this is t=
hat
> there are quite a few drivers using IIO_DMA_MINALIGN expecting it to be
> sufficient for timestamp alignment, which as it seems is not always the c=
ase.
>=20
> I'll wait for Jonathan to weigh in though before spinning up a new patch.
>=20
It would be very odd if we ever see a platform with a DMA alignment require=
ment
that is not a multiple of sizeof(s64) just forcing IIO_DMA_MINALIGN to max
of the arch constraint and sizeof(s64) seems fine to me and fixes up
all those other drivers that were assuming this was true already...
I thought it was and only got fussy for this macro :(


Jonathan



