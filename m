Return-Path: <linux-iio+bounces-22828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ED1B28E3D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4483956446C
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B126CE1E;
	Sat, 16 Aug 2025 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il7LHoo3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECE1D5150
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755352070; cv=none; b=VdCg6PZGlkXoedeTTqK8iPeTQmemHTOH0ei/KxOhk7FFsMlr7gVQGgERbOGhLxSgNIxH75KntZqolkqQfw0GvrbuPhKspc4mKujTkgrQSUxvRVXUsXinYxMwvioLoZmK9ds51hSkTMH/TSNZ3lANj74Cd8hk5FSmGetvIAcOOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755352070; c=relaxed/simple;
	bh=N8nFyV/mOhcKzWGgmUbP23H+QwPlGEy9YrZyIrXtdAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqUbPHomXqkRyd4I0ryBtSlu6nn6DkbkNbSN3mnylVLXK2GwLNx/+0a7Fkrfz0ha7RO4EXQ2CSG3R8iTOU6ftUFTqcIHRQZPWQS1XlRZ6VlQA6umQpLzN/XhoRYzeJx2zjGeNtzloijAT8x6nbB6sqqwKq4ciwCaw1792k5010A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il7LHoo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56803C4CEEF;
	Sat, 16 Aug 2025 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755352070;
	bh=N8nFyV/mOhcKzWGgmUbP23H+QwPlGEy9YrZyIrXtdAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Il7LHoo3njpZtMNQ39zbAv2rD0hUD0MKJ/K+48efyCmt7B8EYK49IQePyegRi2uN/
	 hlp75N/b4GuyQOR8bHYGFu2HpFAHyH6GXVchIoQznYIJIoGA8XKPDBX2+R3BR8ENnD
	 tVew4R6xt7KMMJWZ4t+gRyHdbFAtaf9PHXL71m0LEzT6mReNTtFzig3WPMQCOdDpVf
	 gXTFIuDNhXKxlXO1I/c9crzna0cR5yn/2WgMK1RQ4YnXwptDesYYCiMFHwmnvOz0N1
	 TOxzbg9Lj97r9NR3R8s7+O+SF7FvoO+M2XYhDIYYDKXXCbUtMrLNNgZHDVLP4IPIdQ
	 v2rr+tO+7hU4g==
Date: Sat, 16 Aug 2025 14:47:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
Message-ID: <20250816144742.1442bb79@jic23-huawei>
In-Reply-To: <4unnib32pyl6bcwitvbrjre6zigwcldncx3jczodrrk7i4pyvg@jz7hxq2xgn2g>
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
	<CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>
	<g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
	<CAHp75Vcz1Syosz_uSOka2RCWP7-xiRB5f4iqmWkEPz12iLmkcQ@mail.gmail.com>
	<yvqbio6ip6zeycuccihiqnxpho4p7bpg6uk53zgdbwazlwpwkk@lozrfgb7ul7d>
	<CAHp75Ve-dYcD1j0n3PeRbUJO-8TR1ADyKp-u75sLysNp-uNxwg@mail.gmail.com>
	<ttos64aijdgv6tidi2iiweee2pf3fvu5u2a5hpijleeo533or3@nuaxva2ktrwc>
	<CAHp75Vdfqu6NEHuZXyTEo7aEhPEDjWbwBbk869TDH76SNruVig@mail.gmail.com>
	<4unnib32pyl6bcwitvbrjre6zigwcldncx3jczodrrk7i4pyvg@jz7hxq2xgn2g>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 16:11:11 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Aug 11, 2025 at 04:53:52PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 11, 2025 at 4:37=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
.com> wrote: =20
> > > On Mon, Aug 11, 2025 at 03:03:30PM +0200, Andy Shevchenko wrote: =20
> > > > On Mon, Aug 11, 2025 at 2:48=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@g=
mail.com> wrote: =20
> > > > > On Mon, Aug 11, 2025 at 01:53:20PM +0200, Andy Shevchenko wrote: =
=20
> > > > > > On Mon, Aug 11, 2025 at 11:42=E2=80=AFAM Nuno S=C3=A1 <noname.n=
uno@gmail.com> wrote: =20
> > > > > > > On Fri, Aug 08, 2025 at 11:56:23PM +0200, Andy Shevchenko wro=
te: =20
> > > > > > > > On Fri, Aug 8, 2025 at 6:09=E2=80=AFPM Nuno S=C3=A1 via B4 =
Relay
> > > > > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> >=20
> > ...
> >  =20
> > > > > > > > > +       st->r4_rf_div_sel =3D 0;
> > > > > > > > > +
> > > > > > > > > +       while (freq < ADF4350_MIN_VCO_FREQ) {
> > > > > > > > > +               freq <<=3D 1;
> > > > > > > > > +               st->r4_rf_div_sel++;
> > > > > > > > > +       } =20
> > > > > > > >
> > > > > > > > This is a reimplementation of ffs()/fls() or similar calls.=
 Do you
> > > > > > > > have a plan to clean up? =20
> > > > > > >
> > > > > > > Oh so? Not seeing any direct way of using ffs()/fls() for ach=
ieving the
> > > > > > > same as the above. =20
> > > > > >
> > > > > > Bit operations are hard, I know :-) =20
> > > > >
> > > > > Even more in the morning :)
> > > > > =20
> > > > > > r4_rf_div_sel is a power-of-two shift to make sure the freq is =
just
> > > > > > above the MIN_VCO_FREQ. Of course it's just a subtraction betwe=
en
> > > > > > fls() of the MIN_VCO_FREQ (which is compile-time constant, I be=
lieve),
> > > > > > and fls(freq). No need to loop, really. =20
> > > > >
> > > > > Yes, I agree the loop is not needed and if I got you right, you m=
ean something like:
> > > > >
> > > > > if (freq < ADF4350_MIN_VCO_FREQ) {
> > > > >         st->r4_rf_div_sel =3D fls(MIN_VCO_FREQ) - fls(freq);
> > > > >         /* But then, you would need to re-check the if condition.
> > > > >          * AFAICT, it is not guaranteed that we will always get
> > > > >          * the condition right just by subtracting (or shifting f=
req til
> > > > >          * the same MSbit)
> > > > >          */
> > > > >         if (freq * 2^st->r4_rf_div_sel < ADF4350_MIN_VCO_FREQ)
> > > > >                 st->r4_rf_div_sel++;
> > > > > }
> > > > >
> > > > > So yes, we can skip the loop but in terms of code it's not really=
 convincing me
> > > > > to bother in changing it. I also don't have HW with me to test it=
 (but
> > > > > it does look like a safe change though). I guess we could also use
> > > > > ilog2() but I think we always need to recheck to see if we need a=
nd
> > > > > extra shift. =20
> > > >
> > > > Yes, ilog2() to make compile-time constant for minimum.
> > > > But also one may think more about this and come with the idea of on=
ly
> > > > one check. I don't see why the second check is needed. =20
> > >
> > > Because if you just fls(MIN_VCO_FREQ) - fls(freq), you might (or might
> > > not) get freq * 2^st->r4_rf_div_sel  >=3D ADF4350_MIN_VCO_FREQ (which=
 is
> > > what we want). =20
> >=20
> > Yes, that's why I pointed out... =20
>=20
> Yes, but sometimes you do get what you want by simply subracting and
> sometimes you don't. That's why I had the re-check in the code snippet
> above.
>=20
> >  =20
> > > > The question the code tries to answer is "how is the freq lesser th=
an
> > > > the minimum in terms of power-of-two multiplier?". I have that alre=
ady
> > > > done in some drivers. And that becomes fls_long(). See implementati=
ons
> > > > of roundup_pow_of_two() and rounddown_pow_of_two(). =20
> >=20
> > ...these implementations. They accurately assume off-by-one cases.
> > =20
> > > I think the code wants to get the minimum value needed in order to get
> > > the above condition (r4_rf_div_sel ends up being programmed in the ch=
ip).
> > > Maybe I'm missing something but at this point (and replying to your
> > > original question) I'm not feeling too convinced in changing this code
> > > (more so given that I do not have HW to test). =20
> >=20
> > Okay, fair enough. But maybe TODO in the code to make sure somebody
> > looks at it again (e.g., me, if I ever have time for that)?
> > =20
>=20
> I personally have no problem with that but some maintainers do not like it
> (rightfully so) because these TODOs tend to never disappear :)
>=20
> So, Jonathan are you fine with it?

Yeah I guess so.  I haven't bothered figuring out the code you guys
are discussing though!
 ;)

>=20
> - Nuno S=C3=A1
>=20
> > > > https://elixir.bootlin.com/linux/v6.16/source/drivers/tty/serial/82=
50/8250_mid.c#L220
> > > > https://elixir.bootlin.com/linux/v6.16/source/drivers/spi/spi-pxa2x=
x.c#L820 =20
> >  =20
> > > > > That said, I would ack a change like (or better) the above. =20
> >=20
> > --=20
> > With Best Regards,
> > Andy Shevchenko =20
>=20


