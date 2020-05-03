Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61451C2CA9
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgECNNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 09:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgECNNr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 09:13:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7231E2073E;
        Sun,  3 May 2020 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588511627;
        bh=r6kUel92F21xdlWgHiLGCVGgvrA9gKqAVuMvTe5dCa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kdkMz6Zg9PVBmx7JBLmbxD/dpFX1qe2Pny3gm+8BCzrWPCe9hcxAQePEqysMZ4lqN
         ZTSL0ypswdSTgvXj1eP7CNBR+4J89uv/v//UNc4or+9lWl3s8pkJ41r8eATnMkG1FN
         yGd3VVONW8CcZiaRxm8hfmkoPJj6/Af4U8XfdUrs=
Date:   Sun, 3 May 2020 14:13:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH] iio: imu: adis16xxx: use helper to access iio core
 debugfs dir
Message-ID: <20200503141343.1bf6c781@archlinux>
In-Reply-To: <BN6PR03MB3347761C636F1406DCA6F23199AA0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200430110422.7472-1-alexandru.ardelean@analog.com>
        <BN6PR03MB3347761C636F1406DCA6F23199AA0@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Apr 2020 11:53:08 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Sent: Donnerstag, 30. April 2020 13:04
> > To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Bogdan, Dragos <Dragos.Bogdan@analog.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>; jic23@kernel.org; Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com>
> > Subject: [PATCH] iio: imu: adis16xxx: use helper to access iio core deb=
ugfs dir
> >=20
> > The IIO core provides a iio_get_debugfs_dentry() helper.
> > It seems that the ADIS IMU drivers access that field directly.
> >=20
> > This change converts them to use iio_get_debugfs_dentry() instead.
> >=20
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/gyro/adis16136.c | 10 ++++------
> >  drivers/iio/imu/adis16400.c  | 10 ++++------
> >  drivers/iio/imu/adis16460.c  | 10 ++++------
> >  drivers/iio/imu/adis16475.c  | 15 ++++++---------
> >  drivers/iio/imu/adis16480.c  | 16 ++++++----------
> >  5 files changed, 24 insertions(+), 37 deletions(-)
> >  =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the usual reasons.

Thanks,

Jonathan
