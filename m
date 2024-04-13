Return-Path: <linux-iio+bounces-4225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FE8A3C61
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146AD2822C3
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4B3D57A;
	Sat, 13 Apr 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/3Nm+BO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D23D96B;
	Sat, 13 Apr 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713006023; cv=none; b=PUE9iKDHZng3HEmJ5WvlGlw/WJXMlZ5dKAHScjDaI7OAmuRPd3moPh162OWa54fFmpQNmO4LbwMsTmpGY9fKyAIQWjrtDvBk5do5ngRRqJAzAe1czxBmdtYdCtZYBXiq/ATnxAIrh6RMs7m3o9JXyd2Cj8KbRBVBnbBGJi8IQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713006023; c=relaxed/simple;
	bh=Wy4uAqrl89FReDsMDNHZLC7zszIaD0Qcq99/OiCwYmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSN5tmXy2fL3vNZFaUoFWqGhIvhPZahdd3CGO0PcTo1KLzW1QmjjmgQsPhZJxuKArNfszklmnb+dkJB10GzNQaYe6Vp+TsEI9qUvXUlChpqH/43D5SllioXUR0MszJjgd6S4reE25CsNoshMz1urO1KU+6FrQ2OOwaEcIEBkybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/3Nm+BO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47303C2BBFC;
	Sat, 13 Apr 2024 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713006022;
	bh=Wy4uAqrl89FReDsMDNHZLC7zszIaD0Qcq99/OiCwYmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/3Nm+BOj8dpLxdK8NFxvbyqlYu9yvH0cdWDqifm2Cdi69kOTxNXClYocymYWN6eb
	 YawW0JjfdOUjv572QFLfSzB2Lw8ztsctbhKhXCKhFxqOdpAuWwQ5xfaQ0ezGz8ufZ+
	 Mwxl4KE77CK3+VBrWB5Jzbv4sNqOUBM0sII5EJvY34+KPkZrYnKeP6Ye5D8UvSz4fi
	 qtZK3s1SqocX1jJMM6p4Fk4hNNaBNRBPv1/s5BROuY1Fetml48jZ/Rc24n/sFmKVg6
	 oRGLK0awmMsQ9anf9lRzH+bh1OVJCEitArfO8HkBDkuUq5jBrHd+K0lARk8XqTv4P6
	 zrbHCdXN9W9Vw==
Date: Sat, 13 Apr 2024 12:00:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 11/11] iio: dac: support the ad9739a RF DAC
Message-ID: <20240413120007.1f430cb4@jic23-huawei>
In-Reply-To: <d99653ec9a40a16b088c425d5552de85892564fe.camel@gmail.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
	<20240405-iio-backend-axi-dac-v2-11-293bab7d5552@analog.com>
	<20240406174119.38b821ff@jic23-huawei>
	<d99653ec9a40a16b088c425d5552de85892564fe.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Apr 2024 10:51:43 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-04-06 at 17:41 +0100, Jonathan Cameron wrote:
> > On Fri, 5 Apr 2024 17:00:09 +0200
> > Nuno Sa <nuno.sa@analog.com> wrote:
> >  =20
> > > The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are c=
apable
> > > of synthesizing wideband signals from DC up to 3 GHz.
> > >=20
> > > A dual-port, source synchronous, LVDS interface simplifies the digital
> > > interface with existing FGPA/ASIC technology. On-chip controllers are=
 used
> > > to manage external and internal clock domain variations over temperat=
ure to
> > > ensure reliable data transfer from the host to the DAC core.
> > >=20
> > > Co-developed-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> >=20
> > The only thing I really have remaining questions on is the choice
> > of chan_spec with altvoltage and voltage channels.=C2=A0 Why does that
> > split make sense?=C2=A0 It's odd enough that some comments in the code =
would
> > be a good thing to add.
> >=20
> > Jonathan
> >  =20
> > > new file mode 100644
> > > index 000000000000..9b91d66f826c
> > > --- /dev/null
> > > +++ b/drivers/iio/dac/ad9739a.c
> > > @@ -0,0 +1,454 @@ =20
> >  =20
> > > +
> > > +static struct iio_chan_spec ad9739a_channels[] =3D {
> > > +	{
> > > +		.type =3D IIO_ALTVOLTAGE, =20
> >=20
> > So this looks a little unusual. Perhaps some comments on why it
> > is appropriate to have this channel.
> >=20
> > In reality there is only one channel I think? =20
>=20
> Yeah, I had this same discussion internally and was also thinking in havi=
ng one
> channel (just ALTVOLTAGE). I ended up doing it as we have done it interna=
lly so
> far. The reasoning is that we have two sources of data:
>=20
> ALTVOLTAGE: It's the internally continuous wave the backend can generate.=
 That
> is in fact alternate voltage.
>=20
> VOLTAGE: Is kind of what I call external source where we assume is just t=
ypical
> DAC data and that typically is VOLTAGE (but for a dac like this, I think =
it may
> very well be, if not most of the time, also alternate - the thing is, we =
can't
> know for sure as we should be able to have both)
>=20

Ok. That makes some sense.  These are sort of different channels even if th=
ey
come out of the same physical pin and the phase etc definitions only make s=
ense
for the DDS case.

The operating mode being tied to only the VOLTAGE channel is a little odd b=
ut
I suppose it works  if we think of it as

   DDS altvotage ----inputto----\=20
                                  MUX -->   voltage channel. --> pin.
   DAC data      ----input to---/

I we really wanted to make this complex, we'd use an actual IIO Mux for that
but that is going to lead to a more complex driver for what is a bit of a s=
pecial
case so I don't think we need to do so.

Jonathan

> - Nuno S=C3=A1=20
>=20


