Return-Path: <linux-iio+bounces-4446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC88AD328
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 19:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0255A1F22138
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CF1153BCF;
	Mon, 22 Apr 2024 17:13:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C472EB11;
	Mon, 22 Apr 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806001; cv=none; b=SJwo7qdNBKLxWlnV6oOWVgfkCujMfdE6dfLV2ljkvcntRczOxDYH9+l+1f1fQOSkM+zncfggt6K7BU5C3NcgCW2HgQydscNpAHz783oYJS9N64VsDj7cZpnQBuFdO75HxO6jo5QGrNoG5rwj4QZRFVKNnLMrnuB/YYfRF7yDyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806001; c=relaxed/simple;
	bh=Qi0UashU32EVK41AYe5M6JfOWzLu17qW5BHdjn1C3PY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEi6M0h0dGz8xqu/kKGv18NWsDaqTQGgsrQnryU9f8VYCCrvnK7mRe+saYF9SFnI0ibPF+uEkRNIbrdKQs7XoF3rU+I74Jrv98nvb6gotb0MX9uokDPWE42/YdcGKSpD5THMBgh48tt6F9pwMy73nnqJLSJiUQdoc7Z5HzXpyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWzX0rHVz6K8xJ;
	Tue, 23 Apr 2024 01:13:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 268E5140C72;
	Tue, 23 Apr 2024 01:13:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 18:13:17 +0100
Date: Mon, 22 Apr 2024 18:13:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	<devnull+nuno.sa.analog.com@kernel.org>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	<olivier.moysan@foss.st.com>
Subject: Re: [PATCH 1/8] iio: backend: add API for interface tuning
Message-ID: <20240422181316.000060ff@Huawei.com>
In-Reply-To: <2131a0feac13fa8c1341c3546761ff1a34ca79df.camel@gmail.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-1-3e7628ff6d5e@analog.com>
	<20240420160006.720a3810@jic23-huawei>
	<2131a0feac13fa8c1341c3546761ff1a34ca79df.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >  =20
> > > + *
> > > + * Get the current state of the backend channel. Typically used to c=
heck if
> > > + * there were any errors sending/receiving data.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_chan_status(struct iio_backend *back, unsigned int c=
han,
> > > +			=A0=A0=A0 struct iio_backend_chan_status *status)
> > > +{
> > > +	return iio_backend_op_call(back, chan_status, chan, status);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_status, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_iodelay_set - Set digital I/O delay
> > > + * @back:	Backend device
> > > + * @lane:	Lane number
> > > + * @tap:	Number of taps
> > > + *
> > > + * Controls delays on sending/receiving data. One usecase for this i=
s to
> > > + * calibrate the data digital interface so we get the best results w=
hen
> > > + * transferring data. Note that @tap has no unit since the actual de=
lay per tap
> > > + * is very backend specific. Hence, frontend devices typically shoul=
d go through
> > > + * an array of @taps (the size of that array should typically match =
the size of
> > > + * calibration points on the frontend device) and call this API.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_iodelay_set(struct iio_backend *back, unsigned int l=
ane,
> > > +			=A0=A0=A0 unsigned int tap) =20
> >=20
> > taps maybe given it's a number of them? =20
>=20
> yeps...
>=20
> > Is this an industry standard term - sounds like it probably is but my
> > google fu is failing.
> >  =20
>=20
> Not really (I think). It's very AMD/Xilinx specific. If you google for Xi=
linx IDELAY
> control you may found something. I could not find a good name (originally=
 I just had
> 'delay' but without a proper unit it felt weird), so I admit I used the o=
ne it made
> more sense for my specific usecase. Open to suggestions though :).

Taps is fine.


> > > =A0
> > > +/* vendor specific from 32 */
> > > +enum iio_backend_test_pattern {
> > > +	/* modified prbs9 */
> > > +	IIO_BACKEND_ADI_PRBS_9A =3D 32, =20
> >=20
> > Not knowing anything much about this, does it make sense to use an enum,
> > or should we face facts that we can't have a true generic interface
> > and just use a suitably sized int?
> >  =20
>=20
> I'm also not a fan of the above but we do have generic/standard patterns =
in this core
> (and that could be used by others):
>=20
> - 0x0: pn9a (device specific, modified pn9)
> - 0x1: pn23a (device specific, modified pn23)
> - 0x4: pn7 (standard O.150)
> - 0x5: pn15 (standard O.150)
> - 0x6: pn23 (standard O.150)
> - 0x7: pn31 (standard O.150)
> - 0x9: pnX (device specific, e.g. ad9361)
> - 0x0A: Nibble ramp (Device specific e.g. adrv9001)
> - 0x0B: 16 bit ramp=20
>=20
> Lucky enough the user we have for this is only using a custom/modified pa=
ttern. my
> issue with the int is that how do frontends know what value do they need =
to pass into
> the API? It would really be very backend specific. I know we do expect fr=
ontends to
> have some assumed knowledge on the backend they're connected too but I wo=
uld like to
> avoid making those assumptions bigger than they need to be.
>=20
> My expectation with the enum is that we can have some "contract" between =
backends and
> frontends on the pattern to use. I guess we could give it a try (unless y=
ou have some
> other idea) and if it starts going out of control, I can assume defeat an=
d change it
> to an int.
>=20
> Or, is the idea to just have the int parameter and some plain defines in =
the backend
> header?

Keep it as an enum for now and let's see where this goes.  Things called=20
'modified' are always ominous.  Modified how?  The standard defined ones
are easier to argue for.


>=20
> > How do you unset the test pattern? I expected a IIO_BACKEND_NO_TESTPATE=
RN =3D 0
> > or something like that.
> >  =20
>=20
> Since this is on the input direction (and for our particular core), we do=
n't have to
> unset it. When you choose a test pattern, it just tells the core to match=
 for a
> specific signal/pattern. So when you do start getting "real" data, we may=
 still have
> those status bits saying there are "errors" but in reality we don't care.=
 We just
> care during the tuning/calibration procedure as we configure matching pat=
ters between
> frontend and backend...
>=20
> OTOH for the axi-dac, for example, we do need to unset the test pattern. =
And we do
> that by (re)configuring the internal CW tone or the external data source =
(typically
> some DMA core).

Can we unset it for both input and output?  May make no difference, but eas=
ier to reason about
perhaps.

>=20
>=20
> > > +	IIO_BACKEND_TEST_PATTERN_MAX
> > > +};




