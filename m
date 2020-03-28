Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADBF196843
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgC1Ry1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 13:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgC1Ry0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 13:54:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDCE20714;
        Sat, 28 Mar 2020 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585418066;
        bh=MEfK/Wd6je8M1cHxqH0HG5AU8WTrpsQp30mt+xBLJCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IlsMp9NNHsDb+NZj7iT15hk97roZTcS2isuGdoh64AOrdGScrsa326RlRqdJw6ddV
         S6e2OyQ7IBbsy44BQcxGPSyLZ7uhd3rjZPmM1e2jrRanqi7hbaHh/12E0GuHFcPjHu
         SJhgHqiMcwfsZhDqykwDO/1ypuJ71x66vVhKbs2A=
Date:   Sat, 28 Mar 2020 17:54:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH] iio: temperature: ltc2983: remove redundant comparison
 to bool
Message-ID: <20200328175421.605c7eae@archlinux>
In-Reply-To: <BN6PR03MB3347A202426BE1F409B3A68599CD0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <5e7ef454.1c69fb81.56770.82c7@mx.google.com>
        <BN6PR03MB3347A202426BE1F409B3A68599CD0@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Mar 2020 09:43:58 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Rohit Sarkar <rohitsarkar5398@gmail.com>
> > Sent: Samstag, 28. M=C3=A4rz 2020 07:53
> > To: linux-iio@vger.kernel.org
> > Cc: Sa, Nuno <Nuno.Sa@analog.com>; rohitsarkar5398@gmail.com;
> > jic23@kernel.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen
> > <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org; Bogdan, Dragos
> > <Dragos.Bogdan@analog.com>
> > Subject: [PATCH] iio: temperature: ltc2983: remove redundant comparison=
 to
> > bool
> >=20
> >=20
> > Remove redundant comparison to a boolean variable.
> >=20
> > Fixes coccinelle warning:
> > drivers/iio/temperature//ltc2983.c:393:20-32: WARNING: Comparison to
> > bool
> > drivers/iio/temperature//ltc2983.c:394:20-32: WARNING: Comparison to
> > bool
> >=20
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> > ---
> >  drivers/iio/temperature/ltc2983.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/temperature/ltc2983.c
> > b/drivers/iio/temperature/ltc2983.c
> > index d39c0d6b77f1..8976e8d59826 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> > @@ -390,8 +390,8 @@ static struct ltc2983_custom_sensor
> > *__ltc2983_custom_sensor_new(
> >  	 * For custom steinhart, the full u32 is taken. For all the others
> >  	 * the MSB is discarded.
> >  	 */
> > -	const u8 n_size =3D (is_steinhart =3D=3D true) ? 4 : 3;
> > -	const u8 e_size =3D (is_steinhart =3D=3D true) ? sizeof(u32) : sizeof=
(u64);
> > +	const u8 n_size =3D is_steinhart ? 4 : 3;
> > +	const u8 e_size =3D is_steinhart ? sizeof(u32) : sizeof(u64);
> >=20
> >  	n_entries =3D of_property_count_elems_of_size(np, propname, e_size);
> >  	/* n_entries must be an even number */
> > -- =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan


> Thanks,
> Nuno S=C3=A1
>=20

