Return-Path: <linux-iio+bounces-22830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D019EB28E97
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3537BE7D9
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409C23D291;
	Sat, 16 Aug 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="supULa7D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377B22D7A5
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355616; cv=none; b=uM6WUmmigCHoPdeQVWZ8OIb7MYJ7INfWse+tBxnCRNRrfJhDP5+SOEHf9zJFgAMnjqRqTfwxVgVfJnx9pGLz3pbQztyRnDQQ5vxB1puNc2q5/gx0T+XMCj4quF+DN2ysDmM3vacHPRGJiyAFK79qYH8te8RjMFXC/3Z6jWsiIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355616; c=relaxed/simple;
	bh=wPhVoZrGEe0u1BE7EAVBymZc4aOAdUYfe+gkFPUOaeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9zsxMnEH2tICzJUDlkSAI34jYkWZQ+8dpBW8a4ilQiFnho+u7LDStzRvmu0luLLBmL8KT0qSgu94tCvK8SKXMWouJwr6gZyzUGOZ7oNaG+p62sBH50gFQX0N8jiAr8dS1wiUBco6YWelXDmOc2GyZ+IXsUvriXm4LHfR4MoKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=supULa7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1137C4CEEF;
	Sat, 16 Aug 2025 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755355615;
	bh=wPhVoZrGEe0u1BE7EAVBymZc4aOAdUYfe+gkFPUOaeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=supULa7DRL5KoszA11IH0/CA7YLJUrsZp3Wb6RsjsCSYmFFCj5S0fN7xAp/2+vDXD
	 Vtqk4XpeMkuE3Odut6RASSaTf04AkxrG4Fagba9kYtfP6Ynk0y0JlWmM3vHHXGNmcN
	 2hhsNsULsaVb+hl1HxvSVaRNaXkZZXl+gS1qCw1p6XSbKSliEYSUKYwtioevx8a3YS
	 MqtxdnYQZvpQR10ZK4cGYw4ZX/oTcypetat7TE5f973y5Pz2sDtjikaXGomhXoyFtL
	 CI5dToaJKc523lhKmr7TXk79tVdbizTdGgdeNkAq9dsXN5N8t/5R9dXt+Ga/CwqFRa
	 cCs8RjwzAqk5Q==
Date: Sat, 16 Aug 2025 15:46:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/16] iio: light: vcnl4035: Fix endianness vs data
 placement in buffer issue.
Message-ID: <20250816154644.24919262@jic23-huawei>
In-Reply-To: <CAHp75Vd0KUs25P8cHM8EaAdLbXcDASXLs_nao8Qoee-pqQUF4A@mail.gmail.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-3-jic23@kernel.org>
	<CAHp75Vd0KUs25P8cHM8EaAdLbXcDASXLs_nao8Qoee-pqQUF4A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 3 Aug 2025 21:16:27 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 2, 2025 at 6:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The assumption is that the channel ends up in the first 16 bits
> > of the buffer.  On a big endian system, the regmap_read() will
> > read a 16 bit value into the 4 byte location, leaving the value in byte=
s =20
>=20
> 16-bit
> 4-byte
>=20
> > 2 and 3.  Fix this by using a a local variable and copying into the =20
>=20
> a a --> a
>=20
> > current location. =20
>=20
> ...
>=20
> > +       int val; =20
>=20
> Why signed? regmap API uses an unsigned type for values.
>=20
Good point. I got thrown by the type in the incorrect cast.

> ...
>=20
> > +       *((u16 *)buffer) =3D val; =20
>=20
> I don't understand this fix. Does it mean we simply transfer from HW
> to the user space in whatever endianess HW does this?
>=20
I was thinking that was dealt with by the regmap and the iio_chan_spec.

The regmap part is fine as sets REGMAP_ENDIAN_LITTLE but then I'd expect
the reads to result in cpu endian from that.  The chan spec says little end=
ian though
and I think it should CPU endian.

I'll spin a new little series to resolve that as well and fix this one up.

Jonathan









