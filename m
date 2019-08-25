Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4BE9C55E
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2019 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfHYSH7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Aug 2019 14:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfHYSH7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 14:07:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A85A206E0;
        Sun, 25 Aug 2019 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566756478;
        bh=4nI9EVoki8vxkSJ/zDZbSVDiitqmWgrw765i2CmsLog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kYgjMYZknoIhdYvJproMRd6OLZ7F/bvwT477rd3NE0+jhY/rCqqeQ3RoGlbGkt2Bu
         fJBON6mUG46xtV5Hs6gslgy1Q63v5mbOcphcaUB9FoxocsNyiJRBzTYhVesc6HAMax
         Hg4YURhXtlcSMkFvzF4hwfX5LiKvSewij9ktiHQk=
Date:   Sun, 25 Aug 2019 19:07:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Phil Reid <preid@electromag.com.au>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, linux@roeck-us.net,
        Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 4/4] iio: adc: ina2xx: Use label proper for device
 identification
Message-ID: <20190825190753.7d52c3f9@archlinux>
In-Reply-To: <bca73b6d-87ae-f8cc-b9f4-3b0a558942d9@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
        <0542b562a813c5c22c42484ac24bbb626ac3c022.1566310292.git.michal.simek@xilinx.com>
        <970c3988-24e4-26c2-9027-d8ff40c3a9bb@electromag.com.au>
        <bca73b6d-87ae-f8cc-b9f4-3b0a558942d9@xilinx.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 11:12:00 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> On 21. 08. 19 4:11, Phil Reid wrote:
> > On 20/08/2019 22:11, Michal Simek wrote: =20
> >> Add support for using label property for easier device identification =
via
> >> iio framework.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >> =C2=A0 drivers/iio/adc/ina2xx-adc.c | 2 +-
> >> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc=
.c
> >> index 7c7c63677bf4..077c54915f70 100644
> >> --- a/drivers/iio/adc/ina2xx-adc.c
> >> +++ b/drivers/iio/adc/ina2xx-adc.c
> >> @@ -1033,7 +1033,7 @@ static int ina2xx_probe(struct i2c_client *clien=
t,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(chip->name, sizeof(chip->name)=
, "%s-%s",
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->n=
ame, dev_name(&client->dev));
> >> =C2=A0 -=C2=A0=C2=A0=C2=A0 indio_dev->name =3D chip->name;
> >> +=C2=A0=C2=A0=C2=A0 indio_dev->name =3D of_get_property(np, "label", N=
ULL) ? : chip->name;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->setup_ops =3D &ina2xx_setup_=
ops;
> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buffer =3D devm_iio_kfifo_alloca=
te(&indio_dev->dev);
> >> =20
> > I like this personally. It'd be nice if it was a core function so
> > it could be an opt in to any iio device.
> >=20
> > Don't know how well received that'd be thou.
> >  =20
I'm not particularly keen on changing the semantics of existing
ABI, but how about adding new ABI to provide this?

/sys/bus/iio/devices/iio\:device0/label for example?

I haven't thought about it in depth yet though.  If you spin
a patch with that and the DT docs we'll be more likely to get
a view from DT maintainers if this is acceptable use of label.

Thanks

Jonathan

>=20
> Something like this?
>=20
> diff --git a/drivers/iio/industrialio-core.c
> b/drivers/iio/industrialio-core.c
> index 524a686077ca..d21b495d36a1 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1647,6 +1647,9 @@ int __iio_device_register(struct iio_dev
> *indio_dev, struct module *this_mod)
>         if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>                 indio_dev->dev.of_node =3D indio_dev->dev.parent->of_node;
>=20
> +       indio_dev->name =3D of_get_property(indio_dev->dev.of_node,
> "label", NULL) ? :
> +                                         indio_dev->name;
> +
>         ret =3D iio_check_unique_scan_index(indio_dev);
>         if (ret < 0)
>                 return ret;
>=20
>=20
> M

