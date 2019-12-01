Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E9C10E1CA
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 13:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfLAMON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 07:14:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfLAMOM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 07:14:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5442073C;
        Sun,  1 Dec 2019 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575202452;
        bh=0DT97Pdc2IEdIY6+Kqy0mhRB383vS+CNOyOsbAQPpWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JhZZ7qIf2fDLKLD0CyxaOlY1t0byOzB5wO9BAYYbm17XApvpFqMKgBjgKamZTTpcl
         L74jy3cyR3V9rytezwipQS6Dfyg3FtOoLb6BeGT6fjaeGNGW6si8GmU3JBWJSmwX/k
         eDuyJYxmWf+IGR5B7MhqL46UsorU4dCpO3ZEotJ0=
Date:   Sun, 1 Dec 2019 12:14:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Richard Weinberger <richard@nod.at>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Select I2C_MUX again
Message-ID: <20191201121403.454c67b2@archlinux>
In-Reply-To: <MN2PR12MB3373EF36E242B4F463D6BF71C4470@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191127201738.1234-1-linus.walleij@linaro.org>
        <MN2PR12MB3373EF36E242B4F463D6BF71C4470@MN2PR12MB3373.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Nov 2019 08:46:28 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello,
>=20
> very good idea, I was thinking about it recently.
>=20
> Thanks,
> JB
>=20
> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied to the togreg branch of iio.git and pushed out as testing
to let the autobuilders have a good poke at it.

Thanks,

Jonathan

>=20
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Linus Walleij <linus.walleij@linaro.org>
>=20
> Sent: Wednesday, November 27, 2019 21:17
>=20
> To: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org <linux=
-iio@vger.kernel.org>
>=20
> Cc: Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de=
>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Linus Walleij <linus.walleij=
@linaro.org>; Richard Weinberger <richard@nod.at>; Stephan Gerhold <stephan=
@gerhold.net>
>=20
> Subject: [PATCH v2] iio: imu: inv_mpu6050: Select I2C_MUX again
>=20
> =C2=A0
>=20
>=20
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
>=20
>=20
> commit f7072198f217 ("iio: imu: Fix inv_mpu6050 dependencies")
>=20
> undid the explicit selection of I2C_MUX previously
>=20
> done by the driver, because I2C_MUX implicitly depended
>=20
> on HAS_IOMEM.
>=20
>=20
>=20
> However commit 93d710a65ef0 ("i2c: mux: fix up dependencies")
>=20
> cleared up the situation properly and drivers that need
>=20
> to select I2C_MUX can now do so again.
>=20
>=20
>=20
> It makes a lot of sense for a driver to select the driver
>=20
> infrastructure it needs so restore the natural order of
>=20
> things.
>=20
>=20
>=20
> Cc: Richard Weinberger <richard@nod.at>
>=20
> Cc: Stephan Gerhold <stephan@gerhold.net>
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> ---
>=20
> ChangeLog v1->v2:
>=20
> - Depend on I2C instead of I2C_MUX, it's necessary to
>=20
> =C2=A0 at least have the I2C infrastructure...
>=20
> ---
>=20
> =C2=A0drivers/iio/imu/inv_mpu6050/Kconfig | 3 ++-
>=20
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
>=20
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mp=
u6050/Kconfig
>=20
> index e4c4c12236a7..d9dba6b8abf6 100644
>=20
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
>=20
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
>=20
> @@ -10,7 +10,8 @@ config INV_MPU6050_IIO
>=20
> =C2=A0
>=20
> =C2=A0config INV_MPU6050_I2C
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Invensense MPU=
6050 devices (I2C)"
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on I2C_MUX
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on I2C
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select I2C_MUX
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select INV_MPU6050_IIO
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select REGMAP_I2C
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>=20

