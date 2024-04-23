Return-Path: <linux-iio+bounces-4454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B803F8ADE96
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 09:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFFB1C220E0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A460347F7A;
	Tue, 23 Apr 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibcVxHsS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143046522;
	Tue, 23 Apr 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858734; cv=none; b=mQaBGMPrijCPtWkm19EZa1FnOnGGiRGzIUaVTFwEqUMUBp1hEIK1qe7GnfpdX4+tPR28WRnkeBFH/rJtjwnMe/QCC5bQByMTyCC1IDeOPW5Oms7uDsL/RcqPb5pAn2pRO2WQIg9Aiof1cK3QWwZtWDb/PnsKeNPF5skHF/NtTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858734; c=relaxed/simple;
	bh=fHwuoukCeCqCjc8T6+FFR68lBu0tdDcTNDIb9JNe5p4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPk9XmuVg758wmoYxwFzcPAf4XuI4/IBV1Ix8s07roOOrPLAvaXs0T+usFTU/1SNFcTQXHs0m80ZQnZfTqMZpW/IgeeBgcn15QW/bdvl0rfLXRwiGh9nkIIw3mR8sNTiQuMYkvcfq7RpzK0QxBUUuVP9uL6nw9Pw/RHh1eepp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibcVxHsS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ab9619681so2812525e9.0;
        Tue, 23 Apr 2024 00:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713858731; x=1714463531; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ile/Oak8ObbNun+Z9FpHI4n/U7rfBm/BR3d3J5EorfU=;
        b=ibcVxHsSYFdzvx/FWLhSesK5/qfsoMv3yKMUSWu+KFxP61RRRAVjpNrFX0G+SM9YeS
         unpzqK1Q1ZfGVmq5zjjBz9IrfN/Vg0kzfTdYlUlK3RD0zbMfWY2X1clBFpID8c3n4Ipj
         AB90t2iiQx5sdnYakNh8jVC7pTubPL7GFbk2MSDEkbzVA3Ty0mg3a3vk5s2nvH5YWo/L
         55sJ5t8On0xqY9r8/4XJdOHSy2VDIddxmJYhibwz1JE9Fnqeq24KVlVlwfmYI6FhmXDh
         O2N2Djh9riEVjb5kTnPA3cw/lGyra/9+4UQHvA7XcDY7fPSceQuM1FopRXJ9SGedXG/h
         0A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713858731; x=1714463531;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ile/Oak8ObbNun+Z9FpHI4n/U7rfBm/BR3d3J5EorfU=;
        b=BEr4L+03svPG6cZ/H/JVpQyZn6lemnDALed9AHcrq384/Lrv2m+ltKNPNc4UbOrfmP
         vQxYjGh+KciZfjsvwMb7867FU2Yiht8Pzf9GeKzjGDdhjXA94AiR6xPgXxlhawwM6lcR
         F3Gppdi3rSfU8SP97gBg+hok8TpkGD9A0xiMxBD0GUdWa1nT8/1bi/p+mLXMMJBPzzqo
         rhh4D4oqdTmnHN4kGCBr19X4J4MAzPnsQjy90f3qvW3v8ejVLJSSjdi5OYliMSt3lTLr
         iZ5ltWa7mvo7LR0JIFIqcxi9bg0cdreY6bIx3+lLp8o1+3qvXb2vQd9zqJKCzx2liCct
         4vzw==
X-Forwarded-Encrypted: i=1; AJvYcCWOvdFZWJMwUIvduZN1Qh57gPS8Db8Y9TC9crYCgh5nL646vNByFcnI8YLhOyMlcoTTCvD8g4YoMX36gPyVkNkdzLnZUybQstZNKwGapw1VLpWW3jP0ru00O1owslY88k5cyNlbtQ==
X-Gm-Message-State: AOJu0YzMD0eEBLNLa3OU/Fy7fw8U3g6Fu5J3fXK/WzXmS0EP2gAWhUqb
	z9BZQqt2klExVRaYdx9o8tB0n4zRypPB8Vjv0Dq0yyBvP37qtgQY
X-Google-Smtp-Source: AGHT+IE+0KwlRsXX6BDV9H3SakIp6IOmXurdnqphy7HCvuTbmqqIMqEMNX9e5gnVYRS/QPSofA8WFQ==
X-Received: by 2002:a05:600c:c8e:b0:419:f630:57c2 with SMTP id fj14-20020a05600c0c8e00b00419f63057c2mr6873007wmb.37.1713858730691;
        Tue, 23 Apr 2024 00:52:10 -0700 (PDT)
Received: from ?IPv6:2001:a61:3481:2201:6106:96db:d27b:d2c2? ([2001:a61:3481:2201:6106:96db:d27b:d2c2])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b0041ac5f19213sm714545wmb.8.2024.04.23.00.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:52:10 -0700 (PDT)
Message-ID: <a615b6f8a6a345ed35f9d2288b244ad1f67c697c.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: backend: add API for interface tuning
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>, nuno.sa@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,  Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Tue, 23 Apr 2024 09:52:09 +0200
In-Reply-To: <20240422181316.000060ff@Huawei.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	 <20240419-ad9467-new-features-v1-1-3e7628ff6d5e@analog.com>
	 <20240420160006.720a3810@jic23-huawei>
	 <2131a0feac13fa8c1341c3546761ff1a34ca79df.camel@gmail.com>
	 <20240422181316.000060ff@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-22 at 18:13 +0100, Jonathan Cameron wrote:
>=20
> > > =C2=A0=20
> > > > + *
> > > > + * Get the current state of the backend channel. Typically used to=
 check if
> > > > + * there were any errors sending/receiving data.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_chan_status(struct iio_backend *back, unsigned int=
 chan,
> > > > +			=C2=A0=C2=A0=C2=A0 struct iio_backend_chan_status *status)
> > > > +{
> > > > +	return iio_backend_op_call(back, chan_status, chan, status);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_status, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_iodelay_set - Set digital I/O delay
> > > > + * @back:	Backend device
> > > > + * @lane:	Lane number
> > > > + * @tap:	Number of taps
> > > > + *
> > > > + * Controls delays on sending/receiving data. One usecase for this=
 is to
> > > > + * calibrate the data digital interface so we get the best results=
 when
> > > > + * transferring data. Note that @tap has no unit since the actual =
delay per
> > > > tap
> > > > + * is very backend specific. Hence, frontend devices typically sho=
uld go
> > > > through
> > > > + * an array of @taps (the size of that array should typically matc=
h the size
> > > > of
> > > > + * calibration points on the frontend device) and call this API.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_iodelay_set(struct iio_backend *back, unsigned int=
 lane,
> > > > +			=C2=A0=C2=A0=C2=A0 unsigned int tap)=C2=A0=20
> > >=20
> > > taps maybe given it's a number of them?=C2=A0=20
> >=20
> > yeps...
> >=20
> > > Is this an industry standard term - sounds like it probably is but my
> > > google fu is failing.
> > > =C2=A0=20
> >=20
> > Not really (I think). It's very AMD/Xilinx specific. If you google for =
Xilinx
> > IDELAY
> > control you may found something. I could not find a good name (original=
ly I just
> > had
> > 'delay' but without a proper unit it felt weird), so I admit I used the=
 one it
> > made
> > more sense for my specific usecase. Open to suggestions though :).
>=20
> Taps is fine.
>=20
>=20
> > > > =C2=A0
> > > > +/* vendor specific from 32 */
> > > > +enum iio_backend_test_pattern {
> > > > +	/* modified prbs9 */
> > > > +	IIO_BACKEND_ADI_PRBS_9A =3D 32,=C2=A0=20
> > >=20
> > > Not knowing anything much about this, does it make sense to use an en=
um,
> > > or should we face facts that we can't have a true generic interface
> > > and just use a suitably sized int?
> > > =C2=A0=20
> >=20
> > I'm also not a fan of the above but we do have generic/standard pattern=
s in this
> > core
> > (and that could be used by others):
> >=20
> > - 0x0: pn9a (device specific, modified pn9)
> > - 0x1: pn23a (device specific, modified pn23)
> > - 0x4: pn7 (standard O.150)
> > - 0x5: pn15 (standard O.150)
> > - 0x6: pn23 (standard O.150)
> > - 0x7: pn31 (standard O.150)
> > - 0x9: pnX (device specific, e.g. ad9361)
> > - 0x0A: Nibble ramp (Device specific e.g. adrv9001)
> > - 0x0B: 16 bit ramp=20
> >=20
> > Lucky enough the user we have for this is only using a custom/modified =
pattern.
> > my
> > issue with the int is that how do frontends know what value do they nee=
d to pass
> > into
> > the API? It would really be very backend specific. I know we do expect =
frontends
> > to
> > have some assumed knowledge on the backend they're connected too but I =
would like
> > to
> > avoid making those assumptions bigger than they need to be.
> >=20
> > My expectation with the enum is that we can have some "contract" betwee=
n backends
> > and
> > frontends on the pattern to use. I guess we could give it a try (unless=
 you have
> > some
> > other idea) and if it starts going out of control, I can assume defeat =
and change
> > it
> > to an int.
> >=20
> > Or, is the idea to just have the int parameter and some plain defines i=
n the
> > backend
> > header?
>=20
> Keep it as an enum for now and let's see where this goes.=C2=A0 Things ca=
lled=20
> 'modified' are always ominous.=C2=A0 Modified how?=C2=A0 The standard def=
ined ones
> are easier to argue for.
>=20
>=20
> >=20
> > > How do you unset the test pattern? I expected a IIO_BACKEND_NO_TESTPA=
TERN =3D 0
> > > or something like that.
> > > =C2=A0=20
> >=20
> > Since this is on the input direction (and for our particular core), we =
don't have
> > to
> > unset it. When you choose a test pattern, it just tells the core to mat=
ch for a
> > specific signal/pattern. So when you do start getting "real" data, we m=
ay still
> > have
> > those status bits saying there are "errors" but in reality we don't car=
e. We just
> > care during the tuning/calibration procedure as we configure matching p=
atters
> > between
> > frontend and backend...
> >=20
> > OTOH for the axi-dac, for example, we do need to unset the test pattern=
. And we
> > do
> > that by (re)configuring the internal CW tone or the external data sourc=
e
> > (typically
> > some DMA core).
>=20
> Can we unset it for both input and output?=C2=A0 May make no difference, =
but easier to
> reason about
> perhaps.
>=20

Yeah, from an API point of view it would make sense for frontends to explic=
itly set
IIO_BACKEND_NO_TESTPATERN after they are done with it. On the input device =
(and on
the ADI specific core) that would be a no-op. But for the output device thi=
ngs become
a bit more ambiguous. On the ADI axi-dac, I guess this would mean setting t=
he
internal CW tone (as tuning is not expected to happen during buffering and =
the
internal CW tone is the default data source).

Yeah, there's a bit of overlapping between tuning and [1]. While from an ou=
tput
device point of view, it could make sense to have the tuning test patterns =
as part of
the internal signals, for an input device, that would not make much sense (=
I think).
Hence, I decided to have the test pattern separated from the data source en=
um. But I
guess now is the correct time to bring this up so we can decide otherwise :=
).

Also, on a second thought, on the axi-dac driver, calling
axi_dac_data_source_set(..., IIO_BACKEND_INTERNAL_CONTINUOS_WAVE) on
IIO_BACKEND_NO_TESTPATERN does not look that wrong...

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/dri=
vers/iio/dac/adi-axi-dac.c?h=3Dtesting#n449
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/inc=
lude/linux/iio/backend.h?h=3Dtesting#n19

- Nuno S=C3=A1


