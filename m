Return-Path: <linux-iio+bounces-27596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA9DD0ED03
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A05E5303E696
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CFA33B6FC;
	Sun, 11 Jan 2026 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae5CCVjP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7E339863;
	Sun, 11 Jan 2026 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133375; cv=none; b=Exvdpj+v/Xt9+nJjTlIJLgEwu/58PEYBtFa3Pv2xBbskqUYgoivp87fIhdvHx+l/D0062RMpdFsQiJ6W/4CGrc8d/zxcRxC2wG+R1w5XoAnw8OqwzNAWHtVbOvOoUxLuoPcbDgnb70crQhPIdJTvv3QdHbc90rWzwSNAVW6MEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133375; c=relaxed/simple;
	bh=h3ZrYJmyJeIMzvRz9Ej06lSTtygpzVESZRtBb/b+jHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFpCZKzcpNgCE2cQvZuB329VIEBJCUaEq/lU3/jOlSzpfc7NJK0ZbeHyKbJyDaBqxgWn5V2luQRUu9rirLOgV3eipOb/t9cW1wqYgztc2OhUkAxOi0CMvrPhZCBzV5uzdrb2jr/dGqQcYIuRqulwBsdTcaH8fK+rhn//yb6Grcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae5CCVjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61347C4CEF7;
	Sun, 11 Jan 2026 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768133374;
	bh=h3ZrYJmyJeIMzvRz9Ej06lSTtygpzVESZRtBb/b+jHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ae5CCVjPb0/+vCLZ87cz3Hpb7ZGQrEZHpE+2xuSel/OnlLQznoiz5sZIOkdIsIF5q
	 6UU77OSVDuDmU/97ro7pbWCGGihNGdtl3+1Nv2tMPdEPN9EJZtZ5g6a7U/5kGtEb2y
	 oUwcFfORBUIkOduDJI+hvWvAu0wdrRXBii3U3k6IqD9wrlHiHMIqz+cvnlapc08lz/
	 sGutPDi+jIVcczvWfTdBSsYTfJQ3xmtUYv7r4FGGj+mbQSuABl0A9Ce7axBxoW5A9+
	 98qigw2HKLQUD09nl6my1bkjHLqVe7OnxSVmPliQPbFju36ksPVy4/JALXHBTDk81b
	 V0Bs/cwPoM4Xw==
Date: Sun, 11 Jan 2026 12:09:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: SeungJu Cheon <suunj1331@gmail.com>, antoniu.miclaus@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, andriy.shevchenko@intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset
 mask
Message-ID: <20260111120857.5087e396@jic23-huawei>
In-Reply-To: <CAHp75VdOX_h1Ksm4MbYyipiSpGrTp84GTkUAO9L_0o3auR3Xkg@mail.gmail.com>
References: <20251230123609.210454-1-suunj1331@gmail.com>
	<20251230132126.217802-1-suunj1331@gmail.com>
	<CAHp75VdOX_h1Ksm4MbYyipiSpGrTp84GTkUAO9L_0o3auR3Xkg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Dec 2025 13:19:46 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 30, 2025 at 3:21=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.co=
m> wrote:
> >
> > The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
> > twice instead of checking both SOFT_RESET_MSK (bit 0) and
> > SOFT_RESET_R_MSK (bit 7). This causes incomplete reset status check. =20
>=20
> an incomplete
>=20
> > Fix by using both masks as done in regmap_update_bits() above. =20
>=20
> ...
>=20
>=20
> May I ask how you tested this? Logically from the code it sounds
> correct, but I haven't read the datasheet yet, so I can't tell if this
> is the expected value to read or not.
>=20
>=20
> >         return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
> > -                                       !(read_val & (ADF4377_0000_SOFT=
_RESET_R_MSK |
> > +                                       !(read_val & (ADF4377_0000_SOFT=
_RESET_MSK |
> >                                         ADF4377_0000_SOFT_RESET_R_MSK))=
, 200, 200 * 100); =20
>=20
> Okay, I opened the datasheet, and the below is what I read there. The
> code first sets the SOFT_RESET_R and SOFT_RESET bits to "1", and waits
> for them to be cleared. But the Table 43 does not mention that
> SOFT_RESET_R is auto cleaned, and actually I don't see with a brief
> look what the "repeat of" term means.
>=20
> And for normal operation they needs to be 0ed as per:
>   "SOFT_RESET, SOFT_RESET_R, RST_SYS, and ADC_ST_CNV are the only
> remaining RW bit fields not mentioned yet, and must also be set to
> their POR state (see Table 34)."
>=20
> With that said, I would wait for AD people to clarify the programming
> workflow here.
>=20

Small kernel development process thing as well. Please don't send a v2 in r=
eply to a v1.
It can become very confusing if we end up with a larger number of versions.
Much better to just post a new thread for each version, and include
a link back to the lore archive of the previous version in your cover lette=
r.

Also from a practical point of view, it ends up pages up in people's inboxe=
s and
so is is less likely to get reviewed!

Thanks

Jonathan

