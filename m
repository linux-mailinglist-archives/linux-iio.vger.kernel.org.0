Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC191E97FD
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgEaN6T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaN6T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:58:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF47920723;
        Sun, 31 May 2020 13:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590933498;
        bh=P0ZYutxLRZ5Nn4J4uOgSOkVo4czM/dT+KQmhLVoDdBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJAzHtyI3qbaXDQDcvQE3Tu2ISA+C3OKEaRgMgTgPSBsp+kPBvNEYO6DniUb0Cd5a
         pOupT5SqWRkspaWkXZZ2T4Zfn8M21IxP5U8LMIcOaJSElpPAtry11j0IIw3likT+Ft
         hDu586uloWsKI9i5LRGNpvHUIliqLFe1KCVVBUy8=
Date:   Sun, 31 May 2020 14:58:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, IIO and Power due for
 the v5.8 merge window
Message-ID: <20200531145814.2425e965@archlinux>
In-Reply-To: <20200528070939.7btxjwuqn7bhf4xe@earth.universe>
References: <20200526090646.25827-1-sravanhome@gmail.com>
        <20200526094702.GN3628@dell>
        <20200528070939.7btxjwuqn7bhf4xe@earth.universe>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

 On Thu, 28 May 2020 09:09:39 +0200
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
>=20
> Thanks for taking care of it Lee, merged!

Thanks indeed.

Given timing I'll probably only get this into IIO via a rebase
after rc1.

Thanks,

Jonathan

>=20
> -- Sebastian
>=20
> On Tue, May 26, 2020 at 10:47:02AM +0100, Lee Jones wrote:
> > Enjoy!
> >=20
> > The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f=
3136:
> >=20
> >   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd=
-iio-power-v5.8
> >=20
> > for you to fetch changes up to 904ac71f4b0c1c26ec47ff597cb3d3c7d36e618d:
> >=20
> >   MAINTAINERS: Add entry for mp2629 Battery Charger driver (2020-05-26 =
10:42:02 +0100)
> >=20
> > ----------------------------------------------------------------
> > Immutable branch between MFD, IIO and Power due for the v5.8 merge wind=
ow
> >=20
> > ----------------------------------------------------------------
> > Saravanan Sekar (6):
> >       dt-bindings: mfd: Add document bindings for mp2629
> >       mfd: mp2629: Add support for mps battery charger
> >       iio: adc: mp2629: Add support for mp2629 ADC driver
> >       power: supply: Add support for mps mp2629 battery charger
> >       power: supply: mp2629: Add impedance compensation config
> >       MAINTAINERS: Add entry for mp2629 Battery Charger driver
> >=20
> >  Documentation/ABI/testing/sysfs-class-power-mp2629 |   8 +
> >  .../devicetree/bindings/mfd/mps,mp2629.yaml        |  62 ++
> >  MAINTAINERS                                        |   5 +
> >  drivers/iio/adc/Kconfig                            |  10 +
> >  drivers/iio/adc/Makefile                           |   1 +
> >  drivers/iio/adc/mp2629_adc.c                       | 208 +++++++
> >  drivers/mfd/Kconfig                                |   9 +
> >  drivers/mfd/Makefile                               |   2 +
> >  drivers/mfd/mp2629.c                               |  79 +++
> >  drivers/power/supply/Kconfig                       |  10 +
> >  drivers/power/supply/Makefile                      |   1 +
> >  drivers/power/supply/mp2629_charger.c              | 669 +++++++++++++=
++++++++
> >  include/linux/mfd/mp2629.h                         |  26 +
> >  13 files changed, 1090 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.ya=
ml
> >  create mode 100644 drivers/iio/adc/mp2629_adc.c
> >  create mode 100644 drivers/mfd/mp2629.c
> >  create mode 100644 drivers/power/supply/mp2629_charger.c
> >  create mode 100644 include/linux/mfd/mp2629.h
> >=20
> > --=20
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Linaro Services Technical Lead
> > Linaro.org =E2=94=82 Open source software for ARM SoCs
> > Follow Linaro: Facebook | Twitter | Blog =20

