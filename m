Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D925EDF8
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 15:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgIFN3n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 09:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgIFN1t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 09:27:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE6D320708;
        Sun,  6 Sep 2020 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599398848;
        bh=Jg/ONzkyfeFBjpvfr7GYskrOf0uT3DsXsl8BYu/mmDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a8M9yC8Dd5apF5MDYMZgecvVUe/oS6CVtEiYH5Jf2RKAnxqqIjbiU10vUElvQkWH6
         miOlGk9Tf92/BS+a3Pg+pQlJL5l4nsR1k6ToXS/LVscdh2PmUPvxIFKo6OC2XSXB9w
         v8urqfH3XfAUsVDjtbAMs0Fx24BjJQu6lRXLAH/Q=
Date:   Sun, 6 Sep 2020 14:27:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Allow compile-testing with
 !ARM
Message-ID: <20200906142721.73a533dd@archlinux>
In-Reply-To: <1602652.ZmzXO7uU3z@diego>
References: <20200904170416.16061-1-alex.dewar90@gmail.com>
        <1602652.ZmzXO7uU3z@diego>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 04 Sep 2020 19:32:22 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Am Freitag, 4. September 2020, 19:04:16 CEST schrieb Alex Dewar:
> > There seems no reason to allow for compile-testing on ARM only, so
> > remove this restriction.
> >=20
> > Build-tested with allyesconfig on x86.
> >=20
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com> =20
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it and see if we missed anything.

Thanks,

Jonathan

>=20
> > ---
> >  drivers/iio/adc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index d94dc800b842..03929606bb01 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -863,7 +863,7 @@ config RN5T618_ADC
> > =20
> >  config ROCKCHIP_SARADC
> >  	tristate "Rockchip SARADC driver"
> > -	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
> > +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> >  	depends on RESET_CONTROLLER
> >  	select IIO_BUFFER
> >  	select IIO_TRIGGERED_BUFFER
> >  =20
>=20
>=20
>=20
>=20

