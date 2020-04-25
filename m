Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498FA1B874C
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDYPS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 11:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYPSZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 11:18:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C27D2071C;
        Sat, 25 Apr 2020 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587827905;
        bh=rOkvclJzaXVnBhcnnHYunJz4EyHyd4zB1pXX/giEa6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cOzRyirjqSHYhZL4KaXK2Ni+S/Tf7cb0hpFj5a/Q0zprMwWbjCUJHRvfdsbHEY1xX
         C09jLCwyxZfnGiLMNqLKEHI6QPMkHVbqHl+sBy5hANYsPOeFK43cmJPV7c6bde5snk
         ITvzVw2fyT9ume4EoCBwzkkbwP0X3JrVpQgERDQI=
Date:   Sat, 25 Apr 2020 16:18:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 0/6] Support ADIS16475 and similar IMUs
Message-ID: <20200425161821.1975fe3e@archlinux>
In-Reply-To: <20200413172722.1cb5f55e@archlinux>
References: <20200413082445.17324-1-nuno.sa@analog.com>
        <20200413172722.1cb5f55e@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 17:27:22 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 13 Apr 2020 10:24:39 +0200
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > This series adds support for the adis16475 and similar IMUs. This driver
> > will be the first user of some changes on the adis library. Hence, the
> > first three patches are related to the library:
> >  * Add anaged device functions for registering triggers with the librar=
y;
> >  * Updates the way `irq_mask` is passed to `request_irq()`;
> >  * It adds an update_bits() like API.
> >=20
> > A new patch was introduced (iio: adis: Add burst_max_len variable) in
> > order to make burst32 configuration at runtime. =20
>=20
> Series looks good to me, but I'd like to allow a bit of time for DT
> review + anyone else who wants to take another look.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Nuno S=C3=A1 (6):
> >   iio: imu: adis: Add Managed device functions
> >   iio: imu: adis: Add irq mask variable
> >   iio: adis: Add adis_update_bits() APIs
> >   iio: adis: Support different burst sizes
> >   iio: imu: Add support for adis16475
> >   dt-bindings: iio: Add adis16475 documentation
> >=20
> >  .../bindings/iio/imu/adi,adis16475.yaml       |  137 ++
> >  MAINTAINERS                                   |    8 +
> >  drivers/iio/imu/Kconfig                       |   13 +
> >  drivers/iio/imu/Makefile                      |    1 +
> >  drivers/iio/imu/adis.c                        |   25 +
> >  drivers/iio/imu/adis16400.c                   |    2 +-
> >  drivers/iio/imu/adis16475.c                   | 1336 +++++++++++++++++
> >  drivers/iio/imu/adis_buffer.c                 |   58 +-
> >  drivers/iio/imu/adis_trigger.c                |   72 +-
> >  include/linux/iio/imu/adis.h                  |   87 +-
> >  10 files changed, 1728 insertions(+), 11 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis1=
6475.yaml
> >  create mode 100644 drivers/iio/imu/adis16475.c
> >  =20
>=20

