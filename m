Return-Path: <linux-iio+bounces-533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24AF8011FA
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F11B21293
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B934E636;
	Fri,  1 Dec 2023 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ACT9a4GH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D15FE
	for <linux-iio@vger.kernel.org>; Fri,  1 Dec 2023 09:44:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9c4df1287so32324841fa.2
        for <linux-iio@vger.kernel.org>; Fri, 01 Dec 2023 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701452697; x=1702057497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt6YTmgmj7iHRCIb8aRUB98S7dTyKCu/pLm3UrF1Jr4=;
        b=ACT9a4GHRYu1AHXugYO/YLKi3cSD6nsyIe4qIjpxkZKDfmU2LLyLJvkXkDJ9UhudoP
         +OE31pxmarbiZjV/LUDubQ7PR+zVsRp4H1coAZ9fFAdZhip96moTUMSJAbhPWBWIWZi0
         Za+ws1D+inXIhiCG1aMHisUe16TbeFdsvnyJzAiHnioXemP8exNOeOaERg6ZHbw8z8rT
         UJCJGCfngeAZH6ApoiYQUeCFmGneUb9H+OqT6EoOUqn0vkCKgsnONWHpdZ2fbDkJ57V0
         FGtbGwQd81XzAXCXLPoxJ7My7k7UwB33A8lZvBLLoj7sgkkW9e1mFnM//s0653qh79Gg
         3UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452697; x=1702057497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jt6YTmgmj7iHRCIb8aRUB98S7dTyKCu/pLm3UrF1Jr4=;
        b=P3RIaJZ37eQrq0CdRXg9SyVM80VBl29sAmO9j+s+T1RFDeXYVu60Q5vSGS7LS8Jiwn
         I0f9mGOHthi5BOylz4VtBZZhpJgVa7SN/FhbDSBujvo6PGpYxAH7d39wuYp5cNDY6yxU
         h+sXCg/ZwHPy3U1Jsu08Vc5joFkiGXB7k+z+e04GtwdEGx6tR1uFkJSSt32VU3+7eMhL
         IX8HeK6WNuw+vf4GZAZ1EBmTCbApZFIUd5CuWu49Um/CHHNDN2lfPCN38P5cWxrNw5y/
         4fyIQocoYfpLK8kun+BBI8OIZT1TGmJOyhsL5pybrRwuVC4NcLKDIcz6uo3hnctjnriR
         g1Eg==
X-Gm-Message-State: AOJu0YyQITlz7wGlGpDVm8N43ppnW3Gio7jQN64DPQhDOZ4GjHur+1dp
	t52jtI4Gb+X7kaYYcdrBOF366QNw/4QYxyfHWq/NQQ==
X-Google-Smtp-Source: AGHT+IGAnn8shoJyJhphhMJF7rJzMphyv7oA+NPuxZS/0Ve6G4mWdVjon60SyeGQGgrMs9ZL043Zzi0e2H96pRaFoKk=
X-Received: by 2002:a2e:9541:0:b0:2c9:cf5d:e156 with SMTP id
 t1-20020a2e9541000000b002c9cf5de156mr1089131ljh.36.1701452696763; Fri, 01 Dec
 2023 09:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
 <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com> <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
 <026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
In-Reply-To: <026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 1 Dec 2023 11:44:45 -0600
Message-ID: <CAMknhBGKinZB==QHLazZ9ZkfALyj2N=rVfZfsOk22p6X9SZSrQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	Olivier MOYSAN <olivier.moysan@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 3:08=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Thu, 2023-11-30 at 17:30 -0600, David Lechner wrote:
> > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >
> > > Convert the driver to use the new IIO backend framework. The device
> > > functionality is expected to be the same (meaning no added or removed
> > > features).
> >
> > Missing a devicetree bindings patch before this one?
> >
> > >
> > > Also note this patch effectively breaks ABI and that's needed so we c=
an
> > > properly support this device and add needed features making use of th=
e
> > > new IIO framework.
> >
> > Can you be more specific about what is actually breaking?
> >
> > >
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > >  drivers/iio/adc/Kconfig  |   2 +-
> > >  drivers/iio/adc/ad9467.c | 256 +++++++++++++++++++++++++++++--------=
----------
> > >  2 files changed, 157 insertions(+), 101 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 1e2b7a2c67c6..af56df63beff 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -275,7 +275,7 @@ config AD799X
> > >  config AD9467
> > >         tristate "Analog Devices AD9467 High Speed ADC driver"
> > >         depends on SPI
> > > -       depends on ADI_AXI_ADC
> > > +       select IIO_BACKEND
> > >         help
> > >           Say yes here to build support for Analog Devices:
> > >           * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Conver=
ter
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index 5db5690ccee8..8b0402e73ace 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c
> >
> > <snip>
> >
> > > +static int ad9467_buffer_get(struct iio_dev *indio_dev)
> >
> > perhaps a more descriptive name: ad9467_buffer_setup_optional?
> >
>
> Hmm, no strong feeling. So yeah, can do as you suggest. Even though, now =
that I'm
> thinking, I'm not so sure if this is just some legacy thing we had in ADI=
 tree. I
> wonder if it actually makes sense for a device like with no buffering sup=
port?!
>
> > > +{
> > > +       struct device *dev =3D indio_dev->dev.parent;
> > > +       const char *dma_name;
> > > +
> > > +       if (!device_property_present(dev, "dmas"))
> > > +               return 0;
> > > +
> > > +       if (device_property_read_string(dev, "dma-names", &dma_name))
> > > +               dma_name =3D "rx";
> > > +
> > > +       return devm_iio_dmaengine_buffer_setup(dev, indio_dev, dma_na=
me);
> >
> > The device tree bindings for "adi,ad9467" don't include dma properties
> > (nor should they). Perhaps the DMA lookup should be a callback to the
> > backend? Or something similar to the SPI Engine offload that we are
> > working on?
> >
>
> Oh yes, I need to update the bindings. In the link I sent you we can see =
my thoughts
> on this. In theory, hardwarewise, it would actually make sense for the DM=
A to be on
> the backend device because that's where the connection is in HW. However,=
 since we
> want to have the IIO interface in the frontend, it would be hard to do th=
at without
> hacking devm_iio_dmaengine_buffer_setup(). I mean, lifetime wise it would=
 be far from
> wise to have the DMA buffer associated to a completely different device t=
han the IIO
> parent device. I mean, one way could just be export iio_dmaengine_buffer_=
free() and
> iio_dmaengine_buffer_alloc() so we can actually control the lifetime of t=
he buffer
> from the frontend device. If Jonathan is fine with this, I'm on board for=
 it....
>
> - Nuno S=C3=A1
> >
>

I was planning on exporting iio_dmaengine_buffer_alloc() [1] for SPI
Engine offload support, so I hope that is the right way to go. ;-)

[1]: https://github.com/analogdevicesinc/linux/pull/2341/commits/71048ff83a=
63e9d0a5ddb9ffa331871edd6bd2a5

