Return-Path: <linux-iio+bounces-3664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58639886463
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 01:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE2DB21533
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 00:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B251B389;
	Fri, 22 Mar 2024 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+gouHyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283B2572
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067663; cv=none; b=MoGuzVI/oCCwSHXoZSufbLjRXbRj6as3BBZcWCU0M7OZ+k6RYXnLCQIcdQYk/prW1qQMhqb4lGmLRDmTjsgNmyEpvdqHabHLCpMFeJnHmI7RL2DmeDnl2+5xNBcOuew2hgQVzk4UL7ZUnpz+emWL5K+xDXsZWRDnPAFu4ZRmFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067663; c=relaxed/simple;
	bh=lrdRyuAal7AyRhNP5ZjslIagpzWENKY8IEzlOLovomo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCrHLmQdIOgFolzUjvo1gsxZFEOCeYxhnUJNkMVo2DK84sR57uVzBxqmXTtrQdKm3yoB228z0waYK/rl0JVtBKJoaCHXlTs4LH0tCOUCY+hEZyOIhpoLebqgvPtSc215MAhTqEXaP2R+mrvJb1dkdpLbAG5vgVCBWuhw4/LPx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+gouHyW; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1618486276.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2024 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711067661; x=1711672461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fnP7k795lfHJxk+noHEe2AfyC0AemcoaBgzQQgHmB0=;
        b=m+gouHyWq7zSNzXNT05CdGLVFO1QCPcP6YVAZlPqDw7anuSW57R5VxUqGG3js1SAKL
         vsCYpsVYyxK7w3UP4DTfNwsms8UhuhEK8DZN7oiaPHgjbAAffBWdS0bjkMdbDVOniVC7
         RCgjj/CkxIsGco4zp+bpLPZJEQQM9lqV9MOUn6+/qOHCXlqesF7ql6E60LlzNMoovbNr
         9HduD/uMQE7wPyeNYSgwA9luYAlVfrwUZ21eFPmWfqKLTCrVL1T7YP3gfxM4nKW7bThX
         GqLYc/+/gjmeVxq91j5vjEy6M/NImlgO/9qJMv5TJfsZ3lRkNs4Lj05iT78GFamR202a
         iYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711067661; x=1711672461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fnP7k795lfHJxk+noHEe2AfyC0AemcoaBgzQQgHmB0=;
        b=f10htM7MXrAOEfnWp9QeVmbS6RQISaHHCdqhQUr0A7wCM5DGhX7D/F/n9/k5W/vhOq
         RR444FQZT4AZHejy3KLyV9Khqo/ShYLSpaNqvB2Huu3omMtNBUoOet9FLavHCOheLi6E
         Qhu9zS8agUMaWaCdR1UkXe4aMcga1db5lpYM05FB9+LJSnNtPCA7EZSowDWCToNYkEJ5
         Nsyf+1n1QBWSfWGfEdoIEj7PKGMM77y6Ejj2zIbLi46La/ZCcnXxZDViYW+IWPibPM/X
         nVvYHxfYjQqousLjM/P8YbBAMGTBAi2008sFcf4OrBB3lCsxYDKyYMkBKH9FUS7T6e8U
         /zmA==
X-Forwarded-Encrypted: i=1; AJvYcCUtxhN/qLiygjFr543T1rJR+toZ4X0os+7Og8rqZ33V/K9oWzvs2r2A4u1SlQvPOlCj2lwU3P2rsjpspWj19D07qxE84EmTFrG4
X-Gm-Message-State: AOJu0YxmeyENXoyjlSZ9Fw72YPeO1gsmDCffoA5S4FHgYFxzMdFbCiqz
	N/VpxK9qtsZYl4IpNtEQ/Dh5snwsWpNDEtPsMMI3KvMU3NlDBz4Du9EsRdTuZWos1R/hyvyA4ig
	EHOOQkVw64PQRtaIiE8nqT3A2UpE=
X-Google-Smtp-Source: AGHT+IGkckFcbCA23Fy6+BKKMp9f3JJSXiyMmain0S6MK6FUeOwg7YVu+YLvm8elg2C6wwscaGtJGTC5eMTzHmmYHMI=
X-Received: by 2002:a25:d349:0:b0:dd1:7532:c0f3 with SMTP id
 e70-20020a25d349000000b00dd17532c0f3mr769289ybf.16.1711067661007; Thu, 21 Mar
 2024 17:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319212713.257600-1-l.rubusch@gmail.com> <20240319212713.257600-2-l.rubusch@gmail.com>
 <95b4f98948f1c3a802d185e947ad0bbcfef0a779.camel@gmail.com>
In-Reply-To: <95b4f98948f1c3a802d185e947ad0bbcfef0a779.camel@gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 22 Mar 2024 01:33:45 +0100
Message-ID: <CAFXKEHZaME-OPQsWE8tOGMA+ZHtSeBQ6ZOFo9Pwb12J8y4pJ7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adxl345: add spi-3wire
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:30=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
>
> On Tue, 2024-03-19 at 21:27 +0000, Lothar Rubusch wrote:
> > Adds the spi-3wire feature and adds general refactoring to the
> > iio driver.
> >
> > The patch moves driver wide constants and fields into the
> > header. Thereby reduces redundant info struct definitions.
> > Allows to pass a function pointer from SPI/I2C specific probe,
> > and smaller refactorings. A regmap_update_bits() in the core
> > file replaces the regmap_write() to format_data.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
>
> On top of what Krzysztof already said I would also like for you to split =
the
> spi-3wire (which is adding a new feature) from the refactor in two differ=
ent
> patches. One more comment inline...

Agree

> >  drivers/iio/accel/adxl345.h      |  44 +++++++++++-
> >  drivers/iio/accel/adxl345_core.c | 116 +++++++++++++++++--------------
> >  drivers/iio/accel/adxl345_i2c.c  |  30 ++++----
> >  drivers/iio/accel/adxl345_spi.c  |  50 ++++++++-----
> >  4 files changed, 153 insertions(+), 87 deletions(-)
> >
>
> ...
>
> > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl34=
5_spi.c
> > index 93ca349f1..e456b61c6 100644
> > --- a/drivers/iio/accel/adxl345_spi.c
> > +++ b/drivers/iio/accel/adxl345_spi.c
> > @@ -20,48 +20,62 @@ static const struct regmap_config
> > adxl345_spi_regmap_config =3D {
> >       .read_flag_mask =3D BIT(7) | BIT(6),
> >  };
> >
> > +static int adxl345_spi_setup(struct device *dev, struct regmap *regmap=
)
> > +{
> > +     struct spi_device *spi =3D container_of(dev, struct spi_device, d=
ev);
> > +     int ret;
> > +
> > +     if (spi->mode & SPI_3WIRE) {
> > +             ret =3D regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
> > +                                ADXL345_DATA_FORMAT_SPI);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
>
> I think this would be neater:
>
> if (!(spi->mode & SPI_3WIRE))
>         return 0;
>
> return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
>                     ADXL345_DATA_FORMAT_SPI);

Definitely. Thank you.

Best,
L

