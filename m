Return-Path: <linux-iio+bounces-18433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE220A95154
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E32B169605
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190BD26560C;
	Mon, 21 Apr 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0JO6qpD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EE13C918;
	Mon, 21 Apr 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240629; cv=none; b=kzhnV9rCVUERcpjuIxHbb9P1xovlWdDmMtOVemwO0pr1lx+plv2HFzPf+TajO63kPVqnaRtsTLcIY6ndKLiHNzojiyNSv+Nrl9MAaY56aWsuLMEuykfhBjALY/ZDQZ+06iyX4eDttWWLWq28XGRZLBIGbh9lABse+nSRhYZNLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240629; c=relaxed/simple;
	bh=sP8/NKPFESl3jwqPE7MLSdYvKtkO2SIR8tLuFX5e2SA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrvcAsJxKcxExtoReKkh6jmUkBidSntf9r+2iyMBZ/bPYcxubOVv21v4pzsgyGI3ILeI7sIxdsJOjNnl6cdxE1Mkzbs9Pti2uZaTkt+yHKNWmcfG31QIfVZrM+Tu1eIgTMmj2XsSj6AOJpKuHBqX3DVlXbQFMM5ChQ7yecTc2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0JO6qpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCF8C4CEE4;
	Mon, 21 Apr 2025 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745240629;
	bh=sP8/NKPFESl3jwqPE7MLSdYvKtkO2SIR8tLuFX5e2SA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N0JO6qpDPxKWq68jvUxw8B5xKbKu3JSd/ruInsoQE179kBZggV0PgOj0z6kAAVgGz
	 gYzhy1IgBXFuTqu0UsnKlsVYQXvmqKcHqkxLlzCVJ3XD8+vj6iHvjaHwOSPCLMT/u2
	 Jhao2gSYTdw1k8PDt19p+pbSzhn4jICkF7Uq1A+pQs80tHzgK0wbC7b/CFNe9Je6s/
	 ovrMeEyVxlycWhwQB/rxuOkQsM0wItaEQ8P93msCBh7ZvQKTHTpF9Ai+KtVvtI/z8T
	 Lc7Vx25I32Ful5Jn2vq9vrihvQ8/D82xuboy/KTu4cUzrTE8ySnxrHQGKtPrq4fDzf
	 2puXKkezucLdQ==
Date: Mon, 21 Apr 2025 14:03:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20250421140342.4097c0c4@jic23-huawei>
In-Reply-To: <CAHp75VdcMoxoBU+fKQ5ex28N7YJNcEe96dOuq6hWFxpnn7UYyQ@mail.gmail.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
	<CAHp75VdcMoxoBU+fKQ5ex28N7YJNcEe96dOuq6hWFxpnn7UYyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Apr 2025 07:36:18 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Apr 19, 2025 at 1:59=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > Creating a buffer of the proper size and correct alignment for use with
> > iio_push_to_buffers_with_ts() is commonly used and not easy to get
> > right (as seen by a number of recent fixes on the mailing list).
> >
> > In general, we prefer to use this pattern for creating such buffers:
> >
> > struct {
> >     u16 data[2];
> >     aligned_s64 timestamp;
> > } buffer;
> >
> > However, there are many cases where a driver may have a large number of
> > channels that can be optionally enabled or disabled in a scan or the
> > driver might support a range of chips that have different numbers of
> > channels or different storage sizes for the data.  In these cases, the
> > timestamp may not always be at the same place relative to the data. We
> > just allocate a buffer large enough for the largest possible case and
> > don't care exactly where the timestamp ends up in the buffer.
> >
> > For these cases, we propose to introduce a new macro to make it easier
> > it easier for both the authors to get it right and for readers of the
> > code to not have to do all of the math to verify that it is correct.
> >
> > I have just included a few examples of drivers that can make use of this
> > new macro, but there are dozens more. =20
>=20
> I'm going to answer here as the summary of my view to this series and
> macro after your replies.
>=20
> So, first of all, the macro embeds alignment which is used only once
> in practice and the alignment used in most of the cases is DMA one.

It think that's because this is only converting a few examples.  There
are more of these to come (9 of the ones that David first converted
to structures then realized this was a better fit for starters!).

A lot might still be aligned for DMA but I'd expect to see more of
the cases that don't need that either because they are i2c only or
because data shuffling means the DMA hits a different buffer and we
unscramble it into this one.

> Having two alignments in a row seems a bit weird to me. Second one, if
> we drop alignment, it means each of the users will need it. That
> significantly increases the line size and with high probability will
> require two LoCs to occupy. And third, based on the examples, the
> macro doesn't help much if we don't convert drivers to properly handle
> what they are using instead of plain u8 in all of the cases. Yes, it
> might require quite an invasive change to a driver, but this is how I
> see it should go.

Agreed for almost all cases that a conversion to the right type
is good to have - preferably as a precursor.  There is that one case in
here where it depends on the specific part though which will remain
in a messier form.

>=20
> That said, it feels like this series took a half road.
>=20
> I leave it to Jonothan, but I don't like it to be merged in this form.
>=20

Whilst there are no current platforms where IIO_DMA_MINALIGN is < 8
in theory it might be in future.=20

The other way around, IIO_DMA_MINALIGN is large on some architectures
so could result in considerable additional padding and should only
be used where it is needed.  Also that alignment is useless on the
stack as it does nothing about data after the buffer. Hence there
isn't really a general solution with one or the other :(

So I like the idea in general as a way to make things a little better
but agree it is still somewhat ugly.

Maybe we could add...
IIO_DECLARE_BUFFER_WITH_TS_FOR_DMA()
Might be worth it?

Jonathan=20


