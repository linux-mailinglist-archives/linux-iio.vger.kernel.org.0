Return-Path: <linux-iio+bounces-27598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75377D0ED60
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DE6E300F32A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A31D63D1;
	Sun, 11 Jan 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0WAvccb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387B14E2F2;
	Sun, 11 Jan 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768134044; cv=none; b=c/1fV2fdV01pnCM2AKM669s2oe/jw55leqeNRAWcXyED0/yNuWKJMG37BnQYwJ4bw74Bgc8LW7uARP+iiXB961RUsFAmw8rQVGjBcWiWx2US/wgrw9vg1NHhXLmJIOa1dweAA9JaxN/u+HbVymjgYuWFbqDjZTyvABfmI0IkBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768134044; c=relaxed/simple;
	bh=Knu/Gx7Pa/hXXPiQjx+vriML6qA2Roa6GZc8JB66ZTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6M9icUi7fE1Qq3+qnXUxmGt7pL5hITEXYnloOf/WT37m/ZWXYB+ZIC2CxvaAJo7nwWrBPctn57ByKD92C5cgTF6G1O78EdlfILzIgrOX3ulO7QoEi7qAXzLvQAxfbOmp49w/8n8DRx+Lj+hkGb14xu1IYB67fSX08zZdeG6Seg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0WAvccb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B86C4CEF7;
	Sun, 11 Jan 2026 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768134044;
	bh=Knu/Gx7Pa/hXXPiQjx+vriML6qA2Roa6GZc8JB66ZTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0WAvccbMYst6Ng6PnitgiXBw2LE9xtvRZgLRJSJh2pLIx2KjN+XjpyLmW9d8NYO3
	 846GUze+v4TNeqRvkE6pj6WxlD3Hnz3jBMrZ/bFS8rmd6VsliMW3euHgFyZdkLL+ni
	 tRGqV2Q3FWVitZzb1GlghtICpsyy2WhsV1x0LM765ZuMSdRwUOem2CF4ch3xpnrC5l
	 9EI3GvsZyz/5tbvAcn3hjQwPQ1EbRc6MqiQbdhvXwRh2Ty/xZUT+b9lRzBT53BfJ8v
	 RqBsvSir/rE/N+amOnUVtajdXQD6N6lTAaafsyWjFAN9m7yDfGBr77FYVv4ClZfmEJ
	 Syug7KZygvZng==
Date: Sun, 11 Jan 2026 12:20:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 5/6] staging: iio: ad9832: convert to iio channels
 and ext_info attrs
Message-ID: <20260111122034.174c754c@jic23-huawei>
In-Reply-To: <kyjemsha276njt5h57xtpev2sgxpxxlk3msax7kbkof2vkg6nz@3whszjxmbil2>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
	<20251230203459.28935-6-tomasborquez13@gmail.com>
	<CAHp75Vch9ud6fP=jg0tFx4WjHKYyfZjwaELBzfSubBVksQ7hSQ@mail.gmail.com>
	<kyjemsha276njt5h57xtpev2sgxpxxlk3msax7kbkof2vkg6nz@3whszjxmbil2>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Dec 2025 14:08:52 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> On Wed, Dec 31, 2025 at 12:55:50AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 30, 2025 at 10:35=E2=80=AFPM Tomas Borquez <tomasborquez13@=
gmail.com> wrote: =20
> > >
> > > Convert ad9832 from sysfs attributes to standard channel interface
> > > using a single IIO_ALTCURRENT channel with ext_info attributes, as th=
is
> > > device is a current source DAC with one output. =20
>=20
> ...
>=20
> > > -static int ad9832_write_frequency(struct ad9832_state *st,
> > > -                                 unsigned int addr, unsigned long fo=
ut)
> > > +static ssize_t ad9832_write_frequency(struct iio_dev *indio_dev,
> > > +                                     uintptr_t private, =20
> >=20
> > Torvalds said that uintptr_t shouldn't be used in the Linux kernel,
> > the unsigned long suffice and enough. Why do we need it here? =20
>=20
> Copied it from the definition of iio_chan_spec_ext_info:
>=20
> struct iio_chan_spec_ext_info {
> 	const char *name;
> 	enum iio_shared_by shared;
> 	ssize_t (*read)(struct iio_dev *, uintptr_t private,
> 			struct iio_chan_spec const *, char *buf);
> 	ssize_t (*write)(struct iio_dev *, uintptr_t private,
> 			 struct iio_chan_spec const *, const char *buf,
> 			 size_t len);
> 	uintptr_t private;
> };
>=20
> But can change it
As Linus has been clear on his preferences on this, we should probably
clean that iio_chan_spec_ext_info up as well at some
point.  Not urgent though and don't gate this patch on it.  Better
to clean up all existing users in one go.

This will do as a reference for why:

https://lore.kernel.org/all/CAHk-=3DwgSvPVGZp56uFCjOZoKcgQp7xpsj3P-Hhg+NXvh=
Pnzszg@mail.gmail.com/

Jonathan

>=20
> >  =20
> > > +static IIO_DEVICE_ATTR(out_altcurrent0_frequency_symbol, 0644,
> > > +                      ad9832_show, ad9832_store, AD9832_FREQ_SYM);
> > > +static IIO_DEVICE_ATTR(out_altcurrent0_phase_symbol, 0644,
> > > +                      ad9832_show, ad9832_store, AD9832_PHASE_SYM);
> > > +static IIO_DEVICE_ATTR(out_altcurrent0_enable, 0644,
> > > +                      ad9832_show, ad9832_store, AD9832_OUTPUT_EN); =
=20
> >=20
> > Why not IIO_DEVICE_ATTR_RW()? =20
>=20
> Not any good reason just didn't know it existed.
>=20
> > ...
> >  =20
> > > +       &iio_dev_attr_out_altcurrent0_frequency_symbol.dev_attr.attr,
> > > +       &iio_dev_attr_out_altcurrent0_phase_symbol.dev_attr.attr,
> > > +       &iio_dev_attr_out_altcurrent0_enable.dev_attr.attr,
> > > +       &iio_dev_attr_out_altcurrent0_pincontrol_en.dev_attr.attr,
> > >         NULL, =20
> >=20
> > At some point we may also drop the comma in the terminator entry. =20
>=20
> Will remove it as part of V3
>=20
> > --=20
> > With Best Regards,
> > Andy Shevchenko =20


