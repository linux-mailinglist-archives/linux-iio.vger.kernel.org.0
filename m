Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A2E23078
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfETJgu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 05:36:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39361 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfETJgu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 05:36:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id v2so9473944oie.6;
        Mon, 20 May 2019 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AZBDC+/mCFRo3qw+a99U/avIYwiJEL/Csf0BsRkNo7k=;
        b=G1evNGX580CvL1Bg9yjWgDSUqgqFd18SsqtZARCMpgDaW1aknB3f1KfTra3Hq62ZJC
         eHzW+oLbXj5JpRSoAT7+0M1lb2KjhBfpwMmx5ti/FC+6fE14Eu61/cylCQl9zyq25i7h
         Qj1zDQFJshUfwvtOyHaZ1vXbjDY0/b7R1wIMjUoT9zPx8C3W6+e8WI514mr2PmGyJ8ya
         T9fPzt4NcM3iScE/V6QSFx9oLnTxmikU8AANHq2DJqXH82sTz6udC/rZ+4xFHK0/wVXs
         D15F79EQbLUfdR+OOK0lhnX2oOh+F/Ix3zL3SJcJsi4uNqLw2xcDe7ZwQ27ne+KpIxw5
         REVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AZBDC+/mCFRo3qw+a99U/avIYwiJEL/Csf0BsRkNo7k=;
        b=Zmo8Yp5ySCMdFLDR3J7Nt6kRNBr4BLzheRHaD6NwUEDaNICuRjbqac7fpunfDTjTbV
         VeXuVsi4Pb1kYmTURY5ZeHcKVIHyy+RfGE5gGlEKK+4MByjo+vzFAz/gPiEAqIJvg2sQ
         Ci4CATw6Dn6lrPyakTgd7VQsNKOoEUuA0y815o5JgU9R6B/065ur+1x2H2Zec2ie7LaC
         5twPdD2hIZyd0m3iIPP28mToqVke0PEz9CBbCkSUc/vEzBHhif07FaB7R1Q/K3P5m1T/
         uN5k09cSDeVo3MN7odYPdjGkQzK10UOhzs+TQbpL9nYC46zJWm3mxJpF6NXoFB0COkSL
         /Smg==
X-Gm-Message-State: APjAAAW60rAtmtzCpb+H0czGk1uVpcQJehfhz/iyfUp0Z6iCGxLpIuET
        ny2zncG3NlzRqz/N+4NSm7KTsQwMtxArjAhr8fg=
X-Google-Smtp-Source: APXvYqyuKbNFJw8EKBMqbxucAuXTt5WEc0gs5Vo/FU3lCWpjMCU6PTXubunFnLlGtFewQE9Cfa3pVvpqD/hAgm+NiuM=
X-Received: by 2002:aca:4341:: with SMTP id q62mr17730671oia.140.1558345009093;
 Mon, 20 May 2019 02:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190518224333.18067-1-barbara.fernandes@usp.br> <20190519114400.5cc29c77@archlinux>
In-Reply-To: <20190519114400.5cc29c77@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 May 2019 12:36:37 +0300
Message-ID: <CA+U=Dsqir6Qyk_8yaBw1ei2dhR_TFmVWiMp6qsAOL4yL+nO7AA@mail.gmail.com>
Subject: Re: [RESEND PATCH] staging: iio: adt7316: create of_device_id array
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?B=C3=A1rbara_Fernandes?= <barbara.fernandes@usp.br>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wilson Sales <spoonm@spoonm.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 19, 2019 at 8:54 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 18 May 2019 19:43:33 -0300
> B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:
>
> > Create structure of type of_device_id in order to register all devices
> > the driver is able to manage.
> >
> > Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
> > Signed-off-by: Wilson Sales <spoonm@spoonm.org>
> > Co-developed-by: Wilson Sales <spoonm@spoonm.org>
> Looks good to me.
>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
> Thanks,

Also,

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

CC-ing my work-email
There are some issues with it and mailing lists; I'll hopefully sort
them out in the next weeks.


>
> Jonathan
>
> > ---
> >  drivers/staging/iio/addac/adt7316-spi.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/=
iio/addac/adt7316-spi.c
> > index 8294b9c1e3c2..9968775f1d23 100644
> > --- a/drivers/staging/iio/addac/adt7316-spi.c
> > +++ b/drivers/staging/iio/addac/adt7316-spi.c
> > @@ -127,9 +127,22 @@ static const struct spi_device_id adt7316_spi_id[]=
 =3D {
> >
> >  MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
> >
> > +static const struct of_device_id adt7316_of_spi_match[] =3D {
> > +     { .compatible =3D "adi,adt7316" },
> > +     { .compatible =3D "adi,adt7317" },
> > +     { .compatible =3D "adi,adt7318" },
> > +     { .compatible =3D "adi,adt7516" },
> > +     { .compatible =3D "adi,adt7517" },
> > +     { .compatible =3D "adi,adt7519" },
> > +     { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, adt7316_of_spi_match);
> > +
> >  static struct spi_driver adt7316_driver =3D {
> >       .driver =3D {
> >               .name =3D "adt7316",
> > +             .of_match_table =3D adt7316_of_spi_match,
> >               .pm =3D ADT7316_PM_OPS,
> >       },
> >       .probe =3D adt7316_spi_probe,
>
