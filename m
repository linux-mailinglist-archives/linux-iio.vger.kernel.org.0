Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8519E614
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 17:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDDPeO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 11:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgDDPeN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 11:34:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2919020644;
        Sat,  4 Apr 2020 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586014452;
        bh=eFw0G1rocYNSMkmx7wbHY89J3Z5jhHzNptxaDoSpimM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WlZPRrACYhx0Ap0AeWIvBtTAi2cs2uJYr8O6o3wyVmSK2sPgJTlGIg6QmF9nU8lm7
         3KfHvoUtYY4R8H/vZCf5JbqPquMyRFAf5lNXtj5ObMOaeMt3R4nK4XFh5W2SjH2MXS
         mfVU4uYL2PQt9fqTlh5trli5EmddiwqkOisBGJCE=
Date:   Sat, 4 Apr 2020 16:34:08 +0100
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
Subject: Re: [PATCH v2 2/2] iio: imu: adis16460: use
 DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Message-ID: <20200404163408.61a8c77e@archlinux>
In-Reply-To: <BN6PR03MB33478A31AA2CF52CF3A81AB999C80@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
        <20200331114732.14739-1-rohitsarkar5398@gmail.com>
        <20200331114732.14739-3-rohitsarkar5398@gmail.com>
        <BN6PR03MB33478A31AA2CF52CF3A81AB999C80@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Mar 2020 15:28:22 +0000
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
> > Subject: [PATCH v2 2/2] iio: imu: adis16460: use
> > DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
> >=20
> > debugfs_create_file_unsafe does not protect the fops handed to it
> > against file removal. DEFINE_DEBUGFS_ATTRIBUTE makes the fops aware of
> > the file lifetime and thus protects it against removal.
> >=20
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> > ---
> >  drivers/iio/imu/adis16460.c | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> > index 9539cfe4a259..f96cfd007957 100644
> > --- a/drivers/iio/imu/adis16460.c
> > +++ b/drivers/iio/imu/adis16460.c
> > @@ -87,8 +87,8 @@ static int adis16460_show_serial_number(void *arg,
> > u64 *val)
> >=20
> >  	return 0;
> >  }
> > -DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
> > -	adis16460_show_serial_number, NULL, "0x%.4llx\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_serial_number_fops,
> > +		adis16460_show_serial_number, NULL, "0x%.4llx\n");
> >=20
> >  static int adis16460_show_product_id(void *arg, u64 *val)
> >  {
> > @@ -105,8 +105,8 @@ static int adis16460_show_product_id(void *arg, u64
> > *val)
> >=20
> >  	return 0;
> >  }
> > -DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
> > -	adis16460_show_product_id, NULL, "%llu\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_product_id_fops,
> > +		adis16460_show_product_id, NULL, "%llu\n");
> >=20
> >  static int adis16460_show_flash_count(void *arg, u64 *val)
> >  {
> > @@ -123,19 +123,22 @@ static int adis16460_show_flash_count(void *arg,
> > u64 *val)
> >=20
> >  	return 0;
> >  }
> > -DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
> > -	adis16460_show_flash_count, NULL, "%lld\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
> > +		adis16460_show_flash_count, NULL, "%lld\n");
> >=20
> >  static int adis16460_debugfs_init(struct iio_dev *indio_dev)
> >  {
> >  	struct adis16460 *adis16460 =3D iio_priv(indio_dev);
> >=20
> > -	debugfs_create_file("serial_number", 0400, indio_dev- =20
> > >debugfs_dentry, =20
> > -		adis16460, &adis16460_serial_number_fops);
> > -	debugfs_create_file("product_id", 0400, indio_dev->debugfs_dentry,
> > -		adis16460, &adis16460_product_id_fops);
> > -	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry,
> > -		adis16460, &adis16460_flash_count_fops);
> > +	debugfs_create_file_unsafe("serial_number", 0400,
> > +			indio_dev->debugfs_dentry, adis16460,
> > +			&adis16460_serial_number_fops);
> > +	debugfs_create_file_unsafe("product_id", 0400,
> > +			indio_dev->debugfs_dentry, adis16460,
> > +			&adis16460_product_id_fops);
> > +	debugfs_create_file_unsafe("flash_count", 0400,
> > +			indio_dev->debugfs_dentry, adis16460,
> > +			&adis16460_flash_count_fops);
> >=20
> >  	return 0;
> >  } =20
>=20
> Tested-by Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.  Thanks,

Jonathan

>=20
> > --
> > 2.23.0.385.gbc12974a89 =20
>=20

