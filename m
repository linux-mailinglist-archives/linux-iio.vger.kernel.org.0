Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD082313D
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfETKWP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 06:22:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40689 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbfETKWO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 06:22:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id r136so9558569oie.7;
        Mon, 20 May 2019 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gf8a2CWXs6unmM0ywBfWQHpD8xCycAe3VfTrL7MXDsM=;
        b=boYT4G9MOWMG2RrhzCRovJZ8/7Ed9KIvBmALcMOr8nSuEmLpfbKzTSbyxe3mCmh9gd
         TqKBpmGBawMGBiTvIvpCGZNssjOvmvsAJt4j19dCt4mk2VxMRjsAXPg8lztI4CUH8R0q
         7AYbXzUmAvgv8c8f1Re3wjpgM3VtfWe5vWUbLj1N8uNDNMDe5fNDeiGgu/gs3i3oY4lm
         R4RrP+17sMxJgu0T2Etyi/4EYsyrWANtIBLIwavFW9IkqBOM6mDPDhcPLRBK5DRQ5y7E
         eKOn54sAQSeQHs8QbeOCzrt98jqLIGI1p769rZ3UHsCAbxoCvpTR4TjnGsjSFlDyS/IW
         ML7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gf8a2CWXs6unmM0ywBfWQHpD8xCycAe3VfTrL7MXDsM=;
        b=kBPrNfiZz1/LQdbwx7n0gMEbIouVFmDlf6stuSzXhqtTTAJ90iKUl6qf6JwcgE5iBT
         05kReF9jneOX78fB4PmNR0Oq5d4Q/j1lBWK4MEi2NKMWRo9bWKND1prWsYUhVrYegpSN
         z2cnxlC+CXCL3uvzqp8alJC/9FqQTQVCaaosU03iijIYpp5IbQ2olSSxJ8EkajG63TPs
         QNvfpyGiqzO7mU53ClseL/r27CO1ALVgbT0rYhBtLS3lq2ToyiRu1RiUdVrMRZ6pTjVQ
         N0qD8EAo2PTMlez1PxeypOymeR2U8bFQuduLwakO/Ey4ByElK8K8Z24DMEE9VlAjcQ0u
         Ufmw==
X-Gm-Message-State: APjAAAVWt7q5R9DKxcWCQAWIf7RBySmloDDqmrjU/VTzejDhYK6fDgJJ
        9lSPzx/ZJBMQAdQcm9Z/Lf9XMJIrwvpji+gqII4=
X-Google-Smtp-Source: APXvYqyA2XSun70bicRTlY+wgyg11ZobNwmBsYdVyWi1auaMlBTiksqi4iL92IMRit1ObIk+4dC/R2HSIj+I68nEofY=
X-Received: by 2002:aca:4341:: with SMTP id q62mr17844736oia.140.1558347734073;
 Mon, 20 May 2019 03:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190518224435.18266-1-barbara.fernandes@usp.br> <20190519114634.0e2a9389@archlinux>
In-Reply-To: <20190519114634.0e2a9389@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 May 2019 13:22:02 +0300
Message-ID: <CA+U=DspVbb7UoyThsEG5kqJ+9D2TJtUixF846TkQwFMdaqCpqw@mail.gmail.com>
Subject: Re: [RESEND PATCH] staging: iio: ad7192: create of_device_id array
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

On Sun, May 19, 2019 at 8:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 18 May 2019 19:44:35 -0300
> B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:
>

I don't have anything else on top of what Jonathan added.

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

CC-ing my work-email
There are some issues with it and mailing lists; I'll hopefully sort
them out in the next weeks.

> > Create list of compatible device ids to be matched with those stated in
> > the device tree.
> >
> > Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
> > Signed-off-by: Wilson Sales <spoonm@spoonm.org>
> > Co-developed by: Wilson Sales <spoonm@spoonm.org>
> Hi B=C3=A1rbara, Wilson,
>
> One minor issue inline about code ordering.
> Actual content is fine.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/staging/iio/adc/ad7192.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc=
/ad7192.c
> > index 3d74da9d37e7..cc886f944dbf 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -810,11 +810,23 @@ static const struct spi_device_id ad7192_id[] =3D=
 {
> >       {"ad7195", ID_AD7195},
> >       {}
> >  };
> > +
> > +static const struct of_device_id ad7192_of_spi_match[] =3D {
> > +     { .compatible =3D "adi,ad7190" },
> > +     { .compatible =3D "adi,ad7192" },
> > +     { .compatible =3D "adi,ad7193" },
> > +     { .compatible =3D "adi,ad7195" },
> > +     {}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, ad7192_of_spi_match);
> > +
> Please keep the declaration of the table alongside the relevant
> MODULE_DEVICE_TABLE.
>
> In short, better to have your additions after this next line.
> >  MODULE_DEVICE_TABLE(spi, ad7192_id);
> >
> >  static struct spi_driver ad7192_driver =3D {
> >       .driver =3D {
> >               .name   =3D "ad7192",
> > +             .of_match_table =3D ad7192_of_spi_match,
> >       },
> >       .probe          =3D ad7192_probe,
> >       .remove         =3D ad7192_remove,
>
