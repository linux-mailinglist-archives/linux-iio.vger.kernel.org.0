Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD971F88A4
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgFNLds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 07:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgFNLdr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 07:33:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B5A20714;
        Sun, 14 Jun 2020 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592134427;
        bh=Tkjr2H9x0FoQQcUzjOHlWMVgVouKT+6oQDjOYmz0nyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BfW8RwxXTq6R8TqcKn0TSM5+J5Wgd/71lgFFemENYsPRAC70aB0CMW6J2Q4evi2FH
         DtYWya5Qu/EHvIRw+KMKF01qAE+n661cdh6T9I6s1E1O/RKXU+i/q5uq1WnoTDhH9g
         6Xi0uWxYvD3145zM2WI/Oi+GhGgy9Yw8xf/6oQJM=
Date:   Sun, 14 Jun 2020 12:33:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: make iio_device_get_drvdata take a const struct
 iio_dev *.
Message-ID: <20200614123339.119da92e@archlinux>
In-Reply-To: <MN2PR12MB442273119FE72643B435CCA6C4850@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200521175322.247947-1-jic23@kernel.org>
        <SA0PR12MB44290C81C03F7DAEE315DBFBC48B0@SA0PR12MB4429.namprd12.prod.outlook.com>
        <20200606152430.023c9ef6@archlinux>
        <MN2PR12MB442273119FE72643B435CCA6C4850@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Jun 2020 09:43:26 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello Jonathan,
>=20
> thanks a lot, but I'm currently not able to find this patch in iio git re=
pository, neither in testing or fixes-togreg branches.
>=20
> Is there something I am missing or I just have to wait more ?

I forgot to push out.  Did so mid week after I saw another
email saying things weren't there that should have been.

Given I've just rebased testing, I won't push out a togreg
branch until at least mid week to let the build reports come
in.

Thanks,

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, June 6, 2020 16:24
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jonathan Camer=
on <Jonathan.Cameron@huawei.com>
> Subject: Re: [PATCH] iio: make iio_device_get_drvdata take a const struct=
 iio_dev *.=20
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
> On Tue, 2 Jun 2020 07:39:52 +0000
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
>=20
> > Hi Jonathan,
> >=20
> > simple and perfect.
> >=20
> > Thanks,
> > JB
> >=20
> > Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
> Applied.
>=20
>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > ________________________________
> > From: jic23@kernel.org <jic23@kernel.org>
> > Sent: Thursday, May 21, 2020 19:53
> > To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Jean-Baptiste Maney=
rol <JManeyrol@invensense.com>
> > Subject: [PATCH] iio: make iio_device_get_drvdata take a const struct i=
io_dev *.
> >=20
> >=C2=A0 CAUTION: This email originated from outside of the organization. =
Please make sure the sender is who they say they are and do not click links=
 or open attachments unless you recognize the sender and know the content i=
s safe.
> >=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > As this just calls dev_get_drvdata underneath which is happy with
> > a const struct device * we should change and avoid potentially
> > casting away a const in order to then put it back again.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> > ---
> >=C2=A0 include/linux/iio/iio.h | 2 +-
> >=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index a1be82e74c93..e846a0a7001e 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -669,7 +669,7 @@ static inline void iio_device_set_drvdata(struct ii=
o_dev *indio_dev, void *data)
> >=C2=A0=C2=A0 *
> >=C2=A0=C2=A0 * Returns the data previously set with iio_device_set_drvda=
ta()
> >=C2=A0=C2=A0 */
> > -static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)
> > +static inline void *iio_device_get_drvdata(const struct iio_dev *indio=
_dev)
> >=C2=A0 {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_get_dr=
vdata(&indio_dev->dev);
> >=C2=A0 }
> > --
> > 2.26.2
> >  =20

