Return-Path: <linux-iio+bounces-4586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CC8B4C75
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426FE1F214C8
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961DC6F06F;
	Sun, 28 Apr 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+rGlUJX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504BB3BBCA;
	Sun, 28 Apr 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714319182; cv=none; b=bleBN9FfCwuVRrW65BVXiXwqo0/iYiHDpC0mMwaiCECAGm2kqFZ8H6Lnz/hf0U40u83NPp0D64JrRdv1WqSANNP4/X35aAoeH4kCqEj00BqIlQ8rhZiH1WLPQBcJnO3Pq1QzbWNYYW+YTVxr1Qmx3ZjytDVZZxhH0QTByCFfWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714319182; c=relaxed/simple;
	bh=uAeZuBqW61awTLctWI8a81I2LxZAB3Ilyx93Fl7CD58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDtmg2bB6K8bEyb+nKqox5W0W/NSlV/ZxJ2gFe31azv37oP6Cp0Y3iANI8edXGHvH+CFiTvDBuGwBymwpbM7WHezLF2rQGZih6ZF9EsFTtKqPAsnTmubdnuVkW9KNCKow+ez5oo0xcqoyaZUqdgOFI1fvwIplAFDZYKXNC77zx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+rGlUJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C8C113CC;
	Sun, 28 Apr 2024 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714319182;
	bh=uAeZuBqW61awTLctWI8a81I2LxZAB3Ilyx93Fl7CD58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+rGlUJXCxnt5uVH1ZI6bbbBObij+TgX2zjtInlbQ1MCyg4YsKOL0Lj7sqa2B7OdY
	 xQuh8bVqv8pTV+VBa2KHfn66VaR1kIHwRI2uGaGuuyu/GpHsrVm87Yk8jBISQoz5S4
	 Go+JAIKrqmnHMoOvsxFMcVGkmhmhcLDzv4ihwVj5w3Qy699njephHrykluuSTaKNf1
	 jgzNZB/JmHo9/bVcDahAH85dQVo0ha7m+fhiRmI5cIKiTulWOAVboPdnA1aut8Axoo
	 GJQ0fdeQ17+UFKtBzXSsyKCJvFb0o8IEe2cL51Qmf1Cr1zqbsm5kmsqFIUPfxWQToO
	 ItMcEkZguvMTQ==
Date: Sun, 28 Apr 2024 16:46:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Nuno Sa via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 1/8] iio: backend: add API for interface tuning
Message-ID: <20240428164607.2c49a1ac@jic23-huawei>
In-Reply-To: <a615b6f8a6a345ed35f9d2288b244ad1f67c697c.camel@gmail.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-1-3e7628ff6d5e@analog.com>
	<20240420160006.720a3810@jic23-huawei>
	<2131a0feac13fa8c1341c3546761ff1a34ca79df.camel@gmail.com>
	<20240422181316.000060ff@Huawei.com>
	<a615b6f8a6a345ed35f9d2288b244ad1f67c697c.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 09:52:09 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-04-22 at 18:13 +0100, Jonathan Cameron wrote:
> >  =20
> > > > =C2=A0  =20
> > > > > + *
> > > > > + * Get the current state of the backend channel. Typically used =
to check if
> > > > > + * there were any errors sending/receiving data.
> > > > > + *
> > > > > + * RETURNS:
> > > > > + * 0 on success, negative error number on failure.
> > > > > + */
> > > > > +int iio_backend_chan_status(struct iio_backend *back, unsigned i=
nt chan,
> > > > > +			=C2=A0=C2=A0=C2=A0 struct iio_backend_chan_status *status)
> > > > > +{
> > > > > +	return iio_backend_op_call(back, chan_status, chan, status);
> > > > > +}
> > > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_status, IIO_BACKEND);
> > > > > +
> > > > > +/**
> > > > > + * iio_backend_iodelay_set - Set digital I/O delay
> > > > > + * @back:	Backend device
> > > > > + * @lane:	Lane number
> > > > > + * @tap:	Number of taps
> > > > > + *
> > > > > + * Controls delays on sending/receiving data. One usecase for th=
is is to
> > > > > + * calibrate the data digital interface so we get the best resul=
ts when
> > > > > + * transferring data. Note that @tap has no unit since the actua=
l delay per
> > > > > tap
> > > > > + * is very backend specific. Hence, frontend devices typically s=
hould go
> > > > > through
> > > > > + * an array of @taps (the size of that array should typically ma=
tch the size
> > > > > of
> > > > > + * calibration points on the frontend device) and call this API.
> > > > > + *
> > > > > + * RETURNS:
> > > > > + * 0 on success, negative error number on failure.
> > > > > + */
> > > > > +int iio_backend_iodelay_set(struct iio_backend *back, unsigned i=
nt lane,
> > > > > +			=C2=A0=C2=A0=C2=A0 unsigned int tap)=C2=A0  =20
> > > >=20
> > > > taps maybe given it's a number of them?=C2=A0  =20
> > >=20
> > > yeps...
> > >  =20
> > > > Is this an industry standard term - sounds like it probably is but =
my
> > > > google fu is failing.
> > > > =C2=A0  =20
> > >=20
> > > Not really (I think). It's very AMD/Xilinx specific. If you google fo=
r Xilinx
> > > IDELAY
> > > control you may found something. I could not find a good name (origin=
ally I just
> > > had
> > > 'delay' but without a proper unit it felt weird), so I admit I used t=
he one it
> > > made
> > > more sense for my specific usecase. Open to suggestions though :). =20
> >=20
> > Taps is fine.
> >=20
> >  =20
> > > > > =C2=A0
> > > > > +/* vendor specific from 32 */
> > > > > +enum iio_backend_test_pattern {
> > > > > +	/* modified prbs9 */
> > > > > +	IIO_BACKEND_ADI_PRBS_9A =3D 32,=C2=A0  =20
> > > >=20
> > > > Not knowing anything much about this, does it make sense to use an =
enum,
> > > > or should we face facts that we can't have a true generic interface
> > > > and just use a suitably sized int?
> > > > =C2=A0  =20
> > >=20
> > > I'm also not a fan of the above but we do have generic/standard patte=
rns in this
> > > core
> > > (and that could be used by others):
> > >=20
> > > - 0x0: pn9a (device specific, modified pn9)
> > > - 0x1: pn23a (device specific, modified pn23)
> > > - 0x4: pn7 (standard O.150)
> > > - 0x5: pn15 (standard O.150)
> > > - 0x6: pn23 (standard O.150)
> > > - 0x7: pn31 (standard O.150)
> > > - 0x9: pnX (device specific, e.g. ad9361)
> > > - 0x0A: Nibble ramp (Device specific e.g. adrv9001)
> > > - 0x0B: 16 bit ramp=20
> > >=20
> > > Lucky enough the user we have for this is only using a custom/modifie=
d pattern.
> > > my
> > > issue with the int is that how do frontends know what value do they n=
eed to pass
> > > into
> > > the API? It would really be very backend specific. I know we do expec=
t frontends
> > > to
> > > have some assumed knowledge on the backend they're connected too but =
I would like
> > > to
> > > avoid making those assumptions bigger than they need to be.
> > >=20
> > > My expectation with the enum is that we can have some "contract" betw=
een backends
> > > and
> > > frontends on the pattern to use. I guess we could give it a try (unle=
ss you have
> > > some
> > > other idea) and if it starts going out of control, I can assume defea=
t and change
> > > it
> > > to an int.
> > >=20
> > > Or, is the idea to just have the int parameter and some plain defines=
 in the
> > > backend
> > > header? =20
> >=20
> > Keep it as an enum for now and let's see where this goes.=C2=A0 Things =
called=20
> > 'modified' are always ominous.=C2=A0 Modified how?=C2=A0 The standard d=
efined ones
> > are easier to argue for.
> >=20
> >  =20
> > >  =20
> > > > How do you unset the test pattern? I expected a IIO_BACKEND_NO_TEST=
PATERN =3D 0
> > > > or something like that.
> > > > =C2=A0  =20
> > >=20
> > > Since this is on the input direction (and for our particular core), w=
e don't have
> > > to
> > > unset it. When you choose a test pattern, it just tells the core to m=
atch for a
> > > specific signal/pattern. So when you do start getting "real" data, we=
 may still
> > > have
> > > those status bits saying there are "errors" but in reality we don't c=
are. We just
> > > care during the tuning/calibration procedure as we configure matching=
 patters
> > > between
> > > frontend and backend...
> > >=20
> > > OTOH for the axi-dac, for example, we do need to unset the test patte=
rn. And we
> > > do
> > > that by (re)configuring the internal CW tone or the external data sou=
rce
> > > (typically
> > > some DMA core). =20
> >=20
> > Can we unset it for both input and output?=C2=A0 May make no difference=
, but easier to
> > reason about
> > perhaps.
> >  =20
>=20
> Yeah, from an API point of view it would make sense for frontends to expl=
icitly set
> IIO_BACKEND_NO_TESTPATERN after they are done with it. On the input devic=
e (and on
> the ADI specific core) that would be a no-op. But for the output device t=
hings become
> a bit more ambiguous. On the ADI axi-dac, I guess this would mean setting=
 the
> internal CW tone (as tuning is not expected to happen during buffering an=
d the
> internal CW tone is the default data source).
>=20
> Yeah, there's a bit of overlapping between tuning and [1]. While from an =
output
> device point of view, it could make sense to have the tuning test pattern=
s as part of
> the internal signals, for an input device, that would not make much sense=
 (I think).
> Hence, I decided to have the test pattern separated from the data source =
enum. But I
> guess now is the correct time to bring this up so we can decide otherwise=
 :).
>=20
> Also, on a second thought, on the axi-dac driver, calling
> axi_dac_data_source_set(..., IIO_BACKEND_INTERNAL_CONTINUOS_WAVE) on
> IIO_BACKEND_NO_TESTPATERN does not look that wrong...
>=20

If that's the default for prior to starting tuning, then that seems a reaso=
nable
place to go back to I think.  Maybe this doesn't matter and implementations=
 that
don't care can leave the test pattern in place.

Jonathan

> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/d=
rivers/iio/dac/adi-axi-dac.c?h=3Dtesting#n449
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/i=
nclude/linux/iio/backend.h?h=3Dtesting#n19
>=20
> - Nuno S=C3=A1
>=20


