Return-Path: <linux-iio+bounces-9749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED10F98400B
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED772840BF
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28014BF8D;
	Tue, 24 Sep 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y4ZV1SFQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59B14A639
	for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165513; cv=none; b=fW+p0es85Bow5Y2YDyivzz2tu+BuHkcUsuIn7ySMnS3LiQfgcNjKEAci+lME0I7iwhASVvjY6HB6OXPQXThb6cLidq3ZOuR2Z1tLJogNrQWYwGuHCznXBgDhXMv7RWabaVaZw7Hzf5sIk29BBl66qDNjGx7czG5OKX1EllmDFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165513; c=relaxed/simple;
	bh=GZieD0wwB19efrppi0bX0zyDcb+m6uUZs+cA9Sg4vGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IubazmqsC6iXI622lrTiTEB277VOFdynWpQuVPdCw9ICnzZekitjLxfsF7l5/zT42eY6CpCBmp25EpiZCG1ewR43DaMah2k/phIbDHR5nCrLZ9GMMPz7MXNDOSpJiTZbE1plMJZdhZThzE/Y1Ovc9MxDROn3Y55bbN8QJZouSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y4ZV1SFQ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-846c452898cso3235464241.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2024 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727165509; x=1727770309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ5aCr4nKpGxLnIHu8vZFPnQrbdmyn3RvCnkEa5JLA0=;
        b=Y4ZV1SFQOapAL4wLnadCMoWNmtCeQ7Zv+Q6Nd/wfb+1HKX9vkjlqvTeePWtJRq4bBx
         kt/tfw0PlLd3gFoxYW2IsAFxBJ/1lGU//uTCeIDhGloNfaAR6N1/L0V28FW8QcgHNHQe
         Jj3z9JqeSQ5ZrPLPizivp5nkJqixzXM/JfNXfh6x0XXXKp98SnmkT9LoKBofLbAZQbB6
         YrJzJh0rZku0k/R9DhTzaodYtdxjfjum4q0KNNx97wFei/WlacawYldFEWaSKDWuktSc
         2cTQNMVmoaS0WhvJOlpAvi2x6mhGKFk5DvwoEWhhhgwa0reQ6boY3zyrk7Co6hf72J8J
         8Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727165509; x=1727770309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ5aCr4nKpGxLnIHu8vZFPnQrbdmyn3RvCnkEa5JLA0=;
        b=cxRhSMmUGrk5MUzmGDSE/lbXI7Wtz6IKmf3VgiPjO/ICtvwGiTHyivTBr+K8xKM7cL
         cwEmNCB5ZStkCKAXU2116AS9WLdjH9QEjgFhJjqbRSO0hDurDkv9Q6ziLKVhlJ0F01ck
         moqtWqdfgEwHDKImKLl7mBn0I4/j/oA1lLL9YV+AV0OiIvjxphEZ2kx4E9RDb4XYa/oj
         e0BNAaxcqQ0FqkMIWwYPGVx7CHAJnHdE5jC+kOSUslIIUknDXw/58sRUcl8u3o097/9B
         zxWR3HBiSUWqr5+PnRuhuDc73/OQzNPiAo1O9fsqi/CTaTxRyy7MxyjO4MSRhSZZCUmf
         iLdA==
X-Gm-Message-State: AOJu0Yz8igXB+gBEVKW2viL/Lc73w6Z+eEcbGSThiV70eyRKCoPbdp0J
	XD34CP2G4SeDZATGfQ9Gxpac/1KlI/8pXH5NjZTVTyezNawSuJFe0tsz4VRWfj88F7jnea7lHLP
	VDmB3opzIzlqdNh3H3jj2vZKqK7kQv+DtvmFt9g==
X-Google-Smtp-Source: AGHT+IG6dyWhb+qS2jR9OxwQMq3i0J9hatk60jNsnBBX1/1eymktchQ8ksRPtXrbMSO5SN9NrvxtFid8rXGmhzL1zeI=
X-Received: by 2002:a05:6122:3b0b:b0:4ef:54dd:c806 with SMTP id
 71dfb90a1353d-505a6cb8386mr1511327e0c.7.1727165509546; Tue, 24 Sep 2024
 01:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919130444.2100447-1-aardelean@baylibre.com>
 <20240919130444.2100447-2-aardelean@baylibre.com> <CAMknhBFso4RXhhLSN_x1JEDCi70y-2BDVHKAzuh=bp7dt7dgxA@mail.gmail.com>
In-Reply-To: <CAMknhBFso4RXhhLSN_x1JEDCi70y-2BDVHKAzuh=bp7dt7dgxA@mail.gmail.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 24 Sep 2024 10:11:38 +0200
Message-ID: <CA+GgBR94rNX4wLh527EmfO4pzYFU02fQOr-KfzMt6Reyb5QFgA@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] iio: adc: ad7606: add 'bits' parameter to channels macros
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:51=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Thu, Sep 19, 2024 at 3:04=E2=80=AFPM Alexandru Ardelean
> <aardelean@baylibre.com> wrote:
> >
> > There are some newer additions to the AD7606 family, which support 18 b=
it
> > precision. Up until now, all chips were 16 bit.
> >
> > This change adds a 'bits' parameter to the AD760X_CHANNEL macro and ren=
ames
> > 'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.
> >
> > The AD7606_SW_CHANNEL() macro is also introduced, as a short-hand for I=
IO
> > channels in SW mode.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
>
> ...
>
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > index 6649e84d25de..204a343067e5 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
> > @@ -8,7 +8,7 @@
> >  #ifndef IIO_ADC_AD7606_H_
> >  #define IIO_ADC_AD7606_H_
> >
> > -#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {   \
> > +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {    =
 \
> >                 .type =3D IIO_VOLTAGE,                            \
> >                 .indexed =3D 1,                                   \
> >                 .channel =3D num,                                 \
> > @@ -19,24 +19,26 @@
> >                 .scan_index =3D num,                              \
> >                 .scan_type =3D {                                  \
> >                         .sign =3D 's',                            \
> > -                       .realbits =3D 16,                         \
> > -                       .storagebits =3D 16,                      \
> > +                       .realbits =3D (bits),                     \
> > +                       .storagebits =3D (bits) > 16 ? 32 : 16,   \
> >                         .endianness =3D IIO_CPU,                  \
> >                 },                                              \
> >  }
> >
> >  #define AD7605_CHANNEL(num)                            \
> >         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),     \
> > -               BIT(IIO_CHAN_INFO_SCALE), 0)
> > +               BIT(IIO_CHAN_INFO_SCALE), 0, 16)
> >
> > -#define AD7606_CHANNEL(num)                            \
> > +#define AD7606_CHANNEL(num, bits)                      \
> >         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),     \
> >                 BIT(IIO_CHAN_INFO_SCALE),               \
> > -               BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> > +               BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> >
> > -#define AD7616_CHANNEL(num)    \
> > +#define AD7606_SW_CHANNEL(num, bits)   \
> >         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_=
SCALE),\
> > -               0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> > +               0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> > +
> > +#define AD7616_CHANNEL(num)    AD7606_SW_CHANNEL(num, 16)
>
> It looks like the AD7616_CHANNEL macro is no longer used, so can be
> dropped. Or alternately, don't change the lines below to use
> AD7606_SW_CHANNEL.

Well, the AD7616_CHANNEL() macro is still being used for the actual
AD7616 channels.
For the AD7606B software channels, the AD7616_CHANNEL() macro was
being re-used, which seemed like a bit of a lazy/convenient way to do
it.

The patch here, just cleans up that minor quirk, but just for AD7606B.
The AD7616 driver part, still uses the AD7616_CHANNEL() macro.

Though, interestingly, the AD7616_CHANNEL() macro is only used for SW chann=
els.
Maybe in a subsequent patch, the AD7616_CHANNEL() macro can be removed
altogether.
I thought about doing it in this series, but decided against it, to
keep the series small.

>
> With either of those changes:
>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>
> >
> >  /**
> >   * struct ad7606_chip_info - chip specific information
> > diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.=
c
> > index 62ec12195307..e00f58a6a0e9 100644
> > --- a/drivers/iio/adc/ad7606_spi.c
> > +++ b/drivers/iio/adc/ad7606_spi.c
> > @@ -67,14 +67,14 @@ static const struct iio_chan_spec ad7616_sw_channel=
s[] =3D {
> >
> >  static const struct iio_chan_spec ad7606b_sw_channels[] =3D {
> >         IIO_CHAN_SOFT_TIMESTAMP(8),
> > -       AD7616_CHANNEL(0),
> > -       AD7616_CHANNEL(1),
> > -       AD7616_CHANNEL(2),
> > -       AD7616_CHANNEL(3),
> > -       AD7616_CHANNEL(4),
> > -       AD7616_CHANNEL(5),
> > -       AD7616_CHANNEL(6),
> > -       AD7616_CHANNEL(7),
> > +       AD7606_SW_CHANNEL(0, 16),
> > +       AD7606_SW_CHANNEL(1, 16),
> > +       AD7606_SW_CHANNEL(2, 16),
> > +       AD7606_SW_CHANNEL(3, 16),
> > +       AD7606_SW_CHANNEL(4, 16),
> > +       AD7606_SW_CHANNEL(5, 16),
> > +       AD7606_SW_CHANNEL(6, 16),
> > +       AD7606_SW_CHANNEL(7, 16),
> >  };
> >
> >  static const unsigned int ad7606B_oversampling_avail[9] =3D {
> > --
> > 2.46.0
> >

