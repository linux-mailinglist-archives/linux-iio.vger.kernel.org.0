Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5E22F4E
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfETIuB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 04:50:01 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40934 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbfETIuB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 04:50:01 -0400
Received: by mail-oi1-f193.google.com with SMTP id r136so9381675oie.7;
        Mon, 20 May 2019 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P1TdkWjZDyMvgvAekCwH44KLfVofJlhltHXYPikObHM=;
        b=IQD9uO3C2GesLoN9nqijf6aIcsX9U5BWfDczuYVOvjk3EsEJyYV43dgWLtNCzb1dTE
         IeiK3cDrJ/32uMDDqQh9vLyYRkL2ykD9JFjLPX5pz0r7NXfLe7lHwZ9jxnsjyxlt53Lm
         oc85TGVG5YCtaYoOgEWPxDK5MNZwxZBAZAZRUM0e/ZFC7EoBn8I466nrluKwAN9twFBd
         FjwaZ19YxGNpi/C4ZNd8g5XOJntviZAL7NfoMzzTDyH1jgWcTJdfRzD1JB3q90ZkFk9v
         LWDNGymFv2AuP0LEE6mRLrzwTxpugoqeSMd+J8gAGgS95L9JKAbfEXFxSGwzibk1JnuL
         th9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P1TdkWjZDyMvgvAekCwH44KLfVofJlhltHXYPikObHM=;
        b=mYv7PpZjxQaNydMREFY9WriV/zYnFBqgrqt2+znpiq1kLOBuViFjtV6AfmvEx71Km1
         RjQIextM3ea6oKirhMO0woSfq9Y24NGNIqgPB4XU+NIuuunwGJo/oBUmHmMwnN/9mqip
         mB+OxHVfQeIvVDUzSV9h+4/WfGqR2GWqlK1j5t4bMlwA2vpnmknbmFmhuU8N7J1nPCRB
         vBbUdcAU57oDMHLwDwueN+8WG/9bkQPZ5QfDPnFV2rlCba9/T+IQODsG9Rw+C/vXhZ+F
         NPGb5BahPNSTW6+JArh+payfyva7v/9GDi6YVYemEdM7KnlJd2uSWoyHri6ST/ZAqOEe
         3Tcw==
X-Gm-Message-State: APjAAAWi3g3gx6W2A5xubJAUDa/0mbzy9UD510suuOWdDolnaQhbiMbJ
        LKQMd39qr6tgW7uHSVJgH0fBlS0p/e8kTrLXcAw=
X-Google-Smtp-Source: APXvYqy0A+TEpuXRVOGSPnrr8cGfN7DBGyeGHWRWr/gpf2dOimPebq+LJAdPpkASG2eQLHc5hPz2Vy54RMNA8LJe7NY=
X-Received: by 2002:aca:4341:: with SMTP id q62mr17612509oia.140.1558342200528;
 Mon, 20 May 2019 01:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190518204825.4kh5qkqo2e5q2se6@smtp.gmail.com> <20190519121935.341fd173@archlinux>
In-Reply-To: <20190519121935.341fd173@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 May 2019 11:49:48 +0300
Message-ID: <CA+U=DspTnzOeQexB4YiANBa+6N20uMPNQLDc+ntgW2bSxyHp=Q@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad9832: Add device tree support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Jo=C3=A3o_Seckler?= <joaoseckler@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 19, 2019 at 8:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 18 May 2019 17:48:25 -0300
> Jo=C3=A3o Seckler <joaoseckler@gmail.com> wrote:
>
> > Add a of_device_id struct variable and subsequent call to
> > MODULE_DEVICE_TABLE macro to support device tree.
> >
> > Signed-off-by: Jo=C3=A3o Seckler <joaoseckler@gmail.com>
> > Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
> > Co-developed-by: Anderson Reis  <andersonreisrosa@gmail.com>
> > Signed-off-by: Andre Tadeu de Carvalho <andre.tadeu.de.carvalho@gmail.c=
om>
> > Co-developed-by: Andre Tadeu de Carvalho <andre.tadeu.de.carvalho@gmail=
.com>
> Hi All,
>
> Missing the setting of the relevant entry in the spi_driver structure.
> Otherwise looks fine,
>
> Thanks,
>
> Jonathan
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/i=
io/frequency/ad9832.c
> > index 74308a2e72db..51e97c74c6b2 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -451,6 +451,13 @@ static int ad9832_remove(struct spi_device *spi)
> >       return 0;
> >  }
> >
> > +static const struct of_device_id ad9832_of_match[] =3D {
> > +     { .compatible =3D "adi,ad9832", },
> > +     { .compatible =3D "adi,ad9835", },
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, ad9832_of_match);
> > +


Yep.
To clarify what Jonathan said (see line below with plus + ) :

static struct spi_driver ad9832_driver =3D {
        .driver =3D {
                .name   =3D "ad9832",
+              .of_match_table =3D ad9832_of_match,
        },
        .probe          =3D ad9832_probe,
        .remove         =3D ad9832_remove,
        .id_table       =3D ad9832_id,
};



> >  static const struct spi_device_id ad9832_id[] =3D {
> >       {"ad9832", 0},
> >       {"ad9835", 0},
>
