Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55FE6443
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 17:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfJ0QhG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 12:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfJ0QhG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 12:37:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2384B21726;
        Sun, 27 Oct 2019 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572194225;
        bh=QrqJRLB2CvIZon4VyHcws0KFgqepB0PfXIDsLqLzeGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MwyVHYYJqUQE5K2eFkgNRIEaXG8hL/bkEBCgx+ea6n58zJtnawdB2OUZ8UhIXSal7
         fSV+zkJePDgnBphZjT53Fnc6/3oFl4FJUMJ/J86dy9hTCTCPLXqZg1nNoAy9xc3OG3
         0UvU/JghVwoK1Yy8CzWTtwy6zxGChNzQc6jZmiPo=
Date:   Sun, 27 Oct 2019 16:37:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: adis16480: Add debugfs_reg_access entry
Message-ID: <20191027163700.16d7d3f8@archlinux>
In-Reply-To: <20191025124508.166648-2-nuno.sa@analog.com>
References: <20191025124508.166648-1-nuno.sa@analog.com>
        <20191025124508.166648-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Oct 2019 14:45:08 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The driver is defining debugfs entries by calling
> `adis16480_debugfs_init()`. However, those entries are attached to the
> iio_dev debugfs entry which won't exist if no debugfs_reg_access
> callback is provided.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
As you are respinning the first one and this is probably stable
material as well, please add a fixes tag for v2.
Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 3b53bbb11bfb..94aa1c57e605 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -921,6 +921,7 @@ static const struct iio_info adis16480_info =3D {
>  	.read_raw =3D &adis16480_read_raw,
>  	.write_raw =3D &adis16480_write_raw,
>  	.update_scan_mode =3D adis_update_scan_mode,
> +	.debugfs_reg_access =3D adis_debugfs_reg_access,
>  };
> =20
>  static int adis16480_stop_device(struct iio_dev *indio_dev)

