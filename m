Return-Path: <linux-iio+bounces-548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC3801B8E
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 09:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2EC1C20B9A
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A59BE64;
	Sat,  2 Dec 2023 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX6jKVMz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891DE196;
	Sat,  2 Dec 2023 00:46:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so28121205e9.3;
        Sat, 02 Dec 2023 00:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701506788; x=1702111588; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=czzx1q5MfxMXc1J5zLVzfBntykl0FO7/ypOlTJVyDOk=;
        b=WX6jKVMzoKyC3xziGSvteEKv50/8dxx8tDm6UOXzsLSTyJhDYjjfk6oZ2SiGkkPLg0
         cbX4qPuFeA6FxO7eSqvFiWn8a6gJ4zsuFjlfAlUaYHzfloVQrMNHKV9Z45Z/MrF6T8OM
         VEhDM2L/1iHWDcTfeBhhACGHPL12+Z/ukgorkLYizwc2EuWBYWmyOgJkm02LpfXckHrF
         tiPJT/wovS8DOnvsKLk1rQe1DclEqEGItaGBJ9kZXIqZXzY9mSshj4hTiMkArxcOGb0p
         nAqEE5CiHjC5dwF4syTBbidia2kUQmCwvB2gmopUUU4kI5GkdpuQmtuaTwlIlh2fLa9Q
         mMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701506788; x=1702111588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czzx1q5MfxMXc1J5zLVzfBntykl0FO7/ypOlTJVyDOk=;
        b=QzTlqzj6TOPwLa6Dg9fG+siVwMnhMOfKjctMARFNte3UDrj8VrO0/WE4DPwwT4FzX9
         K+X0XULJshT4SK38iCiwf0L9lF6EkBWmF21hpio+kRmES92C90P6fZ8QdT6LFg2Uips0
         zMzrFmOyebpmR7NWULUQ354DkT+pxUNCUzS3G8gGpbwC4NxKIa+Y8w8SllLjqIGYyxv1
         7BeDQqDHjkR2GXr3jJQXJWjtK2aVrELIpQQJ+gqWeZAJ3lATF7AAHs6c2Vq8wv5oLJLg
         OVVdbUv+QNtc82rOg0+XO+3yRNp5amKpt0WnuwnMBVyDgy2Ra59divow38oXcvlnzT9Q
         Mdbg==
X-Gm-Message-State: AOJu0YzX4gW8WsaQ24Lh9lUjFyBvECOwPktSIplQEHP1o+mnc2pH82C0
	qHptve6C/JxaF+V+p9+ASA4=
X-Google-Smtp-Source: AGHT+IE1mJrcuFnnFr4mC9cQkci9vynRJB1GdY6TluWt9SfPETMDGd6oHEss82dtJ+Q2DxCUy5FbRw==
X-Received: by 2002:a05:600c:4690:b0:40c:67a:b3bc with SMTP id p16-20020a05600c469000b0040c067ab3bcmr99838wmo.71.1701506787548;
        Sat, 02 Dec 2023 00:46:27 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040b3867a297sm7800013wmq.36.2023.12.02.00.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 00:46:27 -0800 (PST)
Message-ID: <863114fa44cda4ca58e17a47191f0388df39cc80.camel@gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: nuno.sa@analog.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Date: Sat, 02 Dec 2023 09:46:26 +0100
In-Reply-To: <CAMknhBGKinZB==QHLazZ9ZkfALyj2N=rVfZfsOk22p6X9SZSrQ@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	 <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
	 <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
	 <026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
	 <CAMknhBGKinZB==QHLazZ9ZkfALyj2N=rVfZfsOk22p6X9SZSrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 11:44 -0600, David Lechner wrote:
> On Fri, Dec 1, 2023 at 3:08=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >=20
> > On Thu, 2023-11-30 at 17:30 -0600, David Lechner wrote:
> > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > >=20
> > > > From: Nuno Sa <nuno.sa@analog.com>
> > > >=20
> > > > Convert the driver to use the new IIO backend framework. The device
> > > > functionality is expected to be the same (meaning no added or remov=
ed
> > > > features).
> > >=20
> > > Missing a devicetree bindings patch before this one?
> > >=20
> > > >=20
> > > > Also note this patch effectively breaks ABI and that's needed so we=
 can
> > > > properly support this device and add needed features making use of =
the
> > > > new IIO framework.
> > >=20
> > > Can you be more specific about what is actually breaking?
> > >=20
> > > >=20
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 2 +-
> > > > =C2=A0drivers/iio/adc/ad9467.c | 256 +++++++++++++++++++++++++++++-=
---------------
> > > > --
> > > > =C2=A02 files changed, 157 insertions(+), 101 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > index 1e2b7a2c67c6..af56df63beff 100644
> > > > --- a/drivers/iio/adc/Kconfig
> > > > +++ b/drivers/iio/adc/Kconfig
> > > > @@ -275,7 +275,7 @@ config AD799X
> > > > =C2=A0config AD9467
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devices=
 AD9467 High Speed ADC driver"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ADI_AXI_ADC
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BACKEND
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here=
 to build support for Analog Devices:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * AD9467 16-=
Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> > > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > > index 5db5690ccee8..8b0402e73ace 100644
> > > > --- a/drivers/iio/adc/ad9467.c
> > > > +++ b/drivers/iio/adc/ad9467.c
> > >=20
> > > <snip>
> > >=20
> > > > +static int ad9467_buffer_get(struct iio_dev *indio_dev)
> > >=20
> > > perhaps a more descriptive name: ad9467_buffer_setup_optional?
> > >=20
> >=20
> > Hmm, no strong feeling. So yeah, can do as you suggest. Even though, no=
w that I'm
> > thinking, I'm not so sure if this is just some legacy thing we had in A=
DI tree. I
> > wonder if it actually makes sense for a device like with no buffering s=
upport?!
> >=20
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D indio_=
dev->dev.parent;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dma_name;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_property_present(=
dev, "dmas"))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device_property_read_stri=
ng(dev, "dma-names", &dma_name))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dma_name =3D "rx";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_dmaengine_buf=
fer_setup(dev, indio_dev, dma_name);
> > >=20
> > > The device tree bindings for "adi,ad9467" don't include dma propertie=
s
> > > (nor should they). Perhaps the DMA lookup should be a callback to the
> > > backend? Or something similar to the SPI Engine offload that we are
> > > working on?
> > >=20
> >=20
> > Oh yes, I need to update the bindings. In the link I sent you we can se=
e my
> > thoughts
> > on this. In theory, hardwarewise, it would actually make sense for the =
DMA to be
> > on
> > the backend device because that's where the connection is in HW. Howeve=
r, since
> > we
> > want to have the IIO interface in the frontend, it would be hard to do =
that
> > without
> > hacking devm_iio_dmaengine_buffer_setup(). I mean, lifetime wise it wou=
ld be far
> > from
> > wise to have the DMA buffer associated to a completely different device=
 than the
> > IIO
> > parent device. I mean, one way could just be export iio_dmaengine_buffe=
r_free()
> > and
> > iio_dmaengine_buffer_alloc() so we can actually control the lifetime of=
 the
> > buffer
> > from the frontend device. If Jonathan is fine with this, I'm on board f=
or it....
> >=20
> > - Nuno S=C3=A1
> > >=20
> >=20
>=20
> I was planning on exporting iio_dmaengine_buffer_alloc() [1] for SPI
> Engine offload support, so I hope that is the right way to go. ;-)
>=20
> [1]:
> https://github.com/analogdevicesinc/linux/pull/2341/commits/71048ff83a63e=
9d0a5ddb9ffa331871edd6bd2a5

I don't really want to extend much on this since this is still out of tree =
code so
I'm not sure we should be discussing it much in here. But there a couple of=
 concerns
already I'm seeing:

* AFAIU, you export the function so you can use it in your pwm trigger. And=
 you don't
want to attach the buffer to a device. That looks very questionable. If you=
 don't
attach to a device, how do you have the userspace interface working on that=
 buffer?
How can you fetch samples from it? Also hiding the buffer allocation in pur=
e trigger
device is at the very least questionable. But the point is, in the end of t=
he day,
the buffer should belong to a device.

* Your PWM trigger seems to be highly focused on the spi_engine offload fea=
ture. You
should go for a generic pwm trigger which is something that was already dis=
cussed on
the list and AFAIR, completely acceptable. That said, not so sure how much =
will we
win (in terms of code simplification) by having devices under the spi_engin=
e
controller using a pwm trigger. But conceptually it is correct and we do ha=
ve a mode
for hardware triggered buffers.

- Nuno S=C3=A1

