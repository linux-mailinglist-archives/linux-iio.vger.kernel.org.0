Return-Path: <linux-iio+bounces-18312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC93A93F41
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937B28A7FF1
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4023E33A;
	Fri, 18 Apr 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH0uAhx7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B21E008B;
	Fri, 18 Apr 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009740; cv=none; b=EGhlc3KOOkTLO2gbTPifR1r4Lo8u6Xza28mFo/896KqP3FUjpEeU1ChzwbIDFNmFsoqb6ODmX8T2LhSnOoRD7lbdH0m5C4qMTMHTUtVf45tnZ6zlBmvXZx9BXIujUhHuUed145jqikF3+WUCLk1lkhN/9/JSBzh4FMdoRSo3sUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009740; c=relaxed/simple;
	bh=u1c4oly1d3giAEd0nRsMu1dRpXLWf4GBOZL/G2Ux31s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCjerR3RWhElo5Ip9JZTjbq0IPIPXt4zxxACPU0smloWPZLA12em4XRPHc2vh1hfDDW1sturRLnXo50GRGOeBMD5Cqug8Hbpp+h0sUpEtIaXUIkONeKskaEbPTmNM0y/T9c3ecL9kPg6biNszwBzhlgi7EPNuhtUE1P1o+/TGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH0uAhx7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47688ae873fso22153321cf.0;
        Fri, 18 Apr 2025 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745009737; x=1745614537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEEgsRqHe/u+tK75rWHl+wuw12N/z37aZu/9b7/5Djo=;
        b=NH0uAhx7ClqNofJ18qbybQctQ7xVMuahOmyytgA+gE3J8bf1WLnji8znlUzmx5CiFE
         Lvjxtn04HejkpC71Cpxt98+h1IDY+qvvPoLHAAYovFjz/xMQYwLB+Usfy71Q95MsMgv3
         NH4PAjjDln5NLyN3RhcpmZvHxllq75nxNdtOsBNOjOuHLWRz17mGIMm3Y2GMvR/zkafR
         9WuwoMNMqPGD05w9lSKio6O5xT+P202F2mro2R5xVMWOoQHowoYghsXpphjF0mR/cnHg
         PMY5K8wkH1Q70d6wb2XvH5zT6n0YEG8StMoXvq3uqpQz5PwBZNwusWFY30THFEG2Npnd
         BY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745009737; x=1745614537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEEgsRqHe/u+tK75rWHl+wuw12N/z37aZu/9b7/5Djo=;
        b=UMxQvrZyZycngOH+YgwXIpsa7N7Ww9P8bfeHFV56YTLq/s7sFCd4oODr89g+xriwB4
         QhWNaEPqr3m4WWc+7UBUoFOFmgM61sjShlLO1b0XzraGxaT1wg32eHHMjLFk4dYsSbtK
         H9YbZVHsO8B2M+cg+KGBfJeQpI0MjnemdpCUmcy8GQIotNa68q68zE2AYn7yZnGFKJhn
         sDlfaVGqp5umNm8VQP1wUbTIzN0OVgjtCBPUKJCaXr51r6m4Agx9iJLWrNxLV2xRDrP3
         r5sJm9qEeolxVDcfzLcJV8k9aDS7ZtCPpX7vsHO+pLThvZUkIgsmC95LeKeAnT0rTkHi
         p7uw==
X-Forwarded-Encrypted: i=1; AJvYcCWEPHIJjDKiAWIhwOIad/ObKVlLCwdQPqD2Om0El8cKTrjqKgjPaRRF04uFmQ2lXzzuwRg+HH7FrL2j4uTZ@vger.kernel.org, AJvYcCWYsTABd+2w4K1jwyH3G+2EuhJVNFgCJUamauYoPZpHwVUpvLPRq4vLSoYs7+eKnKNuuC087ILd@vger.kernel.org, AJvYcCXm4oLRu1PBb5tVgE1MiSupbZoGZ0PM/YQx3neiIRIWZ5FpSt8FgoZnyKdEBGcrHOkII4BO5YSF9N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmM8m3hufhlIdXwL2PehAdy1y3Mo7Z3D9ndApyZVTVgwSgfL1x
	uUccLrUtiqu8/vC7apAuod/d9AkYy4Z6/i/XOgfebVMqcfUbD2z2thmrqDCyI5sD7YO0e0T/QIB
	lExdA1I0CFVVkJTTr5CZ1SJLtgPM=
X-Gm-Gg: ASbGnctfVw9d/URsuqohzrBq6H9mRbgfba7ofxaTO6YtuAObD/eyj7OkKZpHLE3YBjz
	VIV/MCgs5kBP1zIGnkrZdarFzsWw/uSFUs+gBK4GT3U5XrpdqPmP4TEqOlKVDpLx5wW3BHpB+Sr
	IeEXe1dcU7tm9SJJ4bmNIbDmE7bHEny+6z3cxNA1fyqnDFvglJ0aV4
X-Google-Smtp-Source: AGHT+IHK4EAX7kdbM8TwCw5yxGjPXtJ08ON48RHwi7jtNEDKZsZNKnjMRziIy1RGcYu7fYTp4vkbaCRzs7FpjS/ib4M=
X-Received: by 2002:a05:622a:155:b0:476:8595:fa09 with SMTP id
 d75a77b69052e-47aec4a52c2mr56884551cf.40.1745009736980; Fri, 18 Apr 2025
 13:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417170109.602659-1-gshahrouzi@gmail.com> <20250418163510.5dac416e@jic23-huawei>
In-Reply-To: <20250418163510.5dac416e@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Fri, 18 Apr 2025 16:55:26 -0400
X-Gm-Features: ATxdqUHI1tlmOMKRWreLdx4IBcPrgnWpNl_LHcBR7ElvQeXr3g63qJk7CYRq9kY
Message-ID: <CAKUZ0zKVrm8egyZ+3G7=JgcKwbgPe30UVT18j35RvR0OCr3V+g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: Include valid channel for channel selection
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 11:35=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 17 Apr 2025 13:01:09 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > According to the datasheet on page 9 under the channel selection table,
> > all devices (AD7816/7/8) are able to use the channel marked as 7. This
> > channel is used for diagnostic purposes by routing the internal 1.23V
> > bandgap source through the MUX to the input of the ADC.
> >
> > Replace checking for string equality with checking for the same chip ID
> > to reduce time complexity.
> >
> > Group invalid channels for all devices together because they are
> > processed the same way.
> >
> > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
>
> This is doing too many things for one patch.  The fix wants be
> on it's own. Ideally before everything else but if that is tricky to do
> then I don't mind that much.
Got it - will split them up into modular changes.
>
> > ---
> > Changes since v2:
> >       - Refactor by adding chip_info struct which simplifies
> >         condtional logic.
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 68 ++++++++++++++++++--------------
> >  1 file changed, 38 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc=
/ad7816.c
> > index 6c14d7bcdd675..ec955cbf06c17 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -41,8 +41,20 @@
> >   * struct ad7816_chip_info - chip specific information
> >   */
> >
> > +enum ad7816_type {
> > +     ID_AD7816,
> > +     ID_AD7817,
> > +     ID_AD7818,
> > +};
> The aim of moving to a chip_info structure is typically
> to get rid of this sort of enum in favour of specific data
> in the chip_info structures.  Anyhow see below for more on that.
>
> > +
> >  struct ad7816_chip_info {
> > -     kernel_ulong_t id;
> > +     const char *name;
> > +     enum ad7816_type type;
> > +     u8 max_channels;
> > +};
> > +
> > +struct ad7816_state {
>
> This effective rename needs to be a patch on it's own before
> you introduce the new struct ad7816_chip_info.  That lets
> us clearly see that all instances are renamed and is
> an easy patch to review as it's just a rename.
Got it.
>
> > +     const struct ad7816_chip_info *chip_info;
> >       struct spi_device *spi_dev;
> >       struct gpio_desc *rdwr_pin;
> >       struct gpio_desc *convert_pin;
> > @@ -52,16 +64,11 @@ struct ad7816_chip_info {
> >       u8  mode;
> >  };
> >
> > -enum ad7816_type {
> > -     ID_AD7816,
> > -     ID_AD7817,
> > -     ID_AD7818,
> > -};
> >
> > @@ -215,7 +215,7 @@ static ssize_t ad7816_show_value(struct device *dev=
,
> >                                char *buf)
> >  {
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -     struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > +     struct ad7816_state *chip =3D iio_priv(indio_dev);
> >       u16 data;
> >       s8 value;
> >       int ret;
> > @@ -271,7 +271,7 @@ static ssize_t ad7816_show_oti(struct device *dev,
> >                              char *buf)
> >  {
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -     struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > +     struct ad7816_state *chip =3D iio_priv(indio_dev);
> >       int value;
> >
> >       if (chip->channel_id > AD7816_CS_MAX) {
> > @@ -292,7 +292,7 @@ static inline ssize_t ad7816_set_oti(struct device =
*dev,
> >                                    size_t len)
> >  {
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -     struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > +     struct ad7816_state *chip =3D iio_priv(indio_dev);
> >       long value;
> >       u8 data;
> >       int ret;
> > @@ -345,14 +345,22 @@ static const struct iio_info ad7816_info =3D {
> >       .event_attrs =3D &ad7816_event_attribute_group,
> >  };
> >
> > +static const struct ad7816_chip_info ad7816_chip_infos[] =3D {
> > +     [ID_AD7816] =3D { .name =3D "ad7816", .max_channels =3D 0, .type =
=3D ID_AD7816 },
> Use separate named structures.
>
> This approach with an enum and an array is something we used to do but it
> actually obscures what is going on when compared with separate names stru=
cture
> instances.
>
> static const struct ad7816_chip_info ad7816_chip_info =3D {..};
>
> static const struct ad7816_chip_info ad7817_chip_info =3D {..};
>
> etc.
Got it.
> > +     [ID_AD7817] =3D { .name =3D "ad7817", .max_channels =3D 3, .type =
=3D ID_AD7817 },
> > +     [ID_AD7818] =3D { .name =3D "ad7818", .max_channels =3D 1, .type =
=3D ID_AD7818 },
> > +};
> > +
> >  /*
> >   * device probe and remove
> >   */
> >
> >  static int ad7816_probe(struct spi_device *spi_dev)
> >  {
> > -     struct ad7816_chip_info *chip;
> > +     struct ad7816_state *chip;
> >       struct iio_dev *indio_dev;
> > +     const struct spi_device_id *id =3D spi_get_device_id(spi_dev);
> > +     enum ad7816_type chip_type =3D (enum ad7816_type)id->driver_data;
>
> Don't go via an enum.  Put pointers directly in the driver_data field.
> + if the driver has on in the of_match_id table as well.
>
> Then use spi_get_device_match_data() to retrieve it in a firmware type
> independent way.
>
> Ideally by the end of the series you should no such enum
Sent the changes in v2 where no enum was used.
>
> >       int i, ret;
> >
> >       indio_dev =3D devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip))=
;
> > @@ -361,12 +369,12 @@ static int ad7816_probe(struct spi_device *spi_de=
v)
> >       chip =3D iio_priv(indio_dev);
> >       /* this is only used for device removal purposes */
> >       dev_set_drvdata(&spi_dev->dev, indio_dev);
> > +     chip->chip_info =3D &ad7816_chip_infos[chip_type];
> >
> >       chip->spi_dev =3D spi_dev;
> >       for (i =3D 0; i <=3D AD7816_CS_MAX; i++)
> >               chip->oti_data[i] =3D 203;
> >
> > -     chip->id =3D spi_get_device_id(spi_dev)->driver_data;
> >       chip->rdwr_pin =3D devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OU=
T_HIGH);
> >       if (IS_ERR(chip->rdwr_pin)) {
> >               ret =3D PTR_ERR(chip->rdwr_pin);
> > @@ -382,7 +390,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
> >                       ret);
> >               return ret;
> >       }
> > -     if (chip->id =3D=3D ID_AD7816 || chip->id =3D=3D ID_AD7817) {
> > +     if (chip->chip_info->type =3D=3D ID_AD7816 || chip->chip_info->ty=
pe =3D=3D ID_AD7817) {
>
> Given you now have a chip_info structure make this data rather than code.=
  That is
> it should be something ilke
>
>         if (chip->chip_info->has_busy_pin)
>
> >               chip->busy_pin =3D devm_gpiod_get(&spi_dev->dev, "busy",
> >                                               GPIOD_IN);
> >               if (IS_ERR(chip->busy_pin)) {
> > @@ -393,7 +401,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
> >               }
> >       }
> >
> > -     indio_dev->name =3D spi_get_device_id(spi_dev)->name;
> > +     indio_dev->name =3D chip->chip_info->name;
> >       indio_dev->info =3D &ad7816_info;
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> >
>

