Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F29919E612
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDDPdE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 11:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgDDPdE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 11:33:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9335220644;
        Sat,  4 Apr 2020 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586014383;
        bh=gBwjA/Xgt68E/PkOd2G7ivoVbgTFZ/UXr4oapzOjJwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kBpsjukKzQd14ZTCHV0h8muN0nlO7rraeccKlKIgOH4OSvZMYqNHl2Wjz1lC59+i9
         mH3+iH5yTMrDWwSz17x0GcNhN3ZNOqPyV5ntcKUoWM34kJohMjIvXT8BjwIMZxcrws
         lTC0Q06jdKQQ8YAlQ+lxt7hQKe/ydD2PkpwuhDlM=
Date:   Sat, 4 Apr 2020 16:32:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: imu: adis16400: use
 DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Message-ID: <20200404163258.3daba6e6@archlinux>
In-Reply-To: <BN6PR03MB3347F052B16EDFB9BED9029D99C80@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
        <20200331114732.14739-1-rohitsarkar5398@gmail.com>
        <20200331114732.14739-2-rohitsarkar5398@gmail.com>
        <BN6PR03MB3347F052B16EDFB9BED9029D99C80@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Mar 2020 15:28:03 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>=
 On
> > Behalf Of Rohit Sarkar
> > Sent: Dienstag, 31. M=C3=A4rz 2020 13:48
> > To: linux-iio@vger.kernel.org
> > Cc: Bogdan, Dragos <Dragos.Bogdan@analog.com>; Rohit Sarkar
> > <rohitsarkar5398@gmail.com>; Lars-Peter Clausen <lars@metafoo.de>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Stefan Popa
> > <stefan.popa@analog.com>; Jonathan Cameron <jic23@kernel.org>; Hartmut
> > Knaack <knaack.h@gmx.de>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>; linux-kernel@vger.kernel.org
> > Subject: [PATCH v2 1/2] iio: imu: adis16400: use
> > DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
> >=20
> > debugfs_create_file_unsafe does not protect the fops handed to it
> > against file removal. DEFINE_DEBUGFS_ATTRIBUTE makes the fops aware of
> > the file lifetime and thus protects it against removal.
> >=20
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> > ---
> >  drivers/iio/imu/adis16400.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> > index cfb1c19eb930..c8fcd40f58c0 100644
> > --- a/drivers/iio/imu/adis16400.c
> > +++ b/drivers/iio/imu/adis16400.c
> > @@ -258,7 +258,7 @@ static int adis16400_show_product_id(void *arg, u64
> > *val)
> >=20
> >  	return 0;
> >  }
> > -DEFINE_SIMPLE_ATTRIBUTE(adis16400_product_id_fops,
> > +DEFINE_DEBUGFS_ATTRIBUTE(adis16400_product_id_fops,
> >  	adis16400_show_product_id, NULL, "%lld\n");
> >=20
> >  static int adis16400_show_flash_count(void *arg, u64 *val)
> > @@ -275,7 +275,7 @@ static int adis16400_show_flash_count(void *arg, u64
> > *val)
> >=20
> >  	return 0;
> >  }
> > -DEFINE_SIMPLE_ATTRIBUTE(adis16400_flash_count_fops,
> > +DEFINE_DEBUGFS_ATTRIBUTE(adis16400_flash_count_fops,
> >  	adis16400_show_flash_count, NULL, "%lld\n");
> >=20
> >  static int adis16400_debugfs_init(struct iio_dev *indio_dev)
> > @@ -283,15 +283,16 @@ static int adis16400_debugfs_init(struct iio_dev
> > *indio_dev)
> >  	struct adis16400_state *st =3D iio_priv(indio_dev);
> >=20
> >  	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
> > -		debugfs_create_file("serial_number", 0400,
> > -			indio_dev->debugfs_dentry, st,
> > -			&adis16400_serial_number_fops);
> > +		debugfs_create_file_unsafe("serial_number", 0400,
> > +				indio_dev->debugfs_dentry, st,
> > +				&adis16400_serial_number_fops);
> >  	if (st->variant->flags & ADIS16400_HAS_PROD_ID)
> > -		debugfs_create_file("product_id", 0400,
> > +		debugfs_create_file_unsafe("product_id", 0400,
> > +				indio_dev->debugfs_dentry, st,
> > +				&adis16400_product_id_fops);
> > +	debugfs_create_file_unsafe("flash_count", 0400,
> >  			indio_dev->debugfs_dentry, st,
> > -			&adis16400_product_id_fops);
> > -	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry,
> > -		st, &adis16400_flash_count_fops);
> > +			&adis16400_flash_count_fops);
> >=20
> >  	return 0;
> >  } =20
>=20
> Tested-by Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to try it out.

Thanks,

Jonathan

>=20
> > --
> > 2.23.0.385.gbc12974a89 =20
>=20

