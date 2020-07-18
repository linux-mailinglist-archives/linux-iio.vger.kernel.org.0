Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7273A224CF4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGRQPm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbgGRQPm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:15:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E574B2070E;
        Sat, 18 Jul 2020 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088941;
        bh=RYYoGC33ot2PTRIYQJZqtzM135KyMAhZ0Tx+A5h+stA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JWLi2lyx4YSiRifXIlLL/T8pCbT9SIoBCxNOFhI80RH4g0Tc/1TMcho7HEY+JIjXD
         d4cy5LVdNWrfb+SzAh8BDuGSGMWuQrf4tKTf7Ynxvdpg8HE7v4d4bon5LB1GShrJ99
         8kJ+axZKoGc1Ga/eMDNEXlmuo7PuasBRey3baCL4=
Date:   Sat, 18 Jul 2020 17:15:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc:     Lee Jones <lee.jones@linaro.org>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 30/30] iio: adc: rockchip_saradc: Demote Demote
 seemingly unintentional kerneldoc header
Message-ID: <20200718171536.5b5ac001@archlinux>
In-Reply-To: <4422628.h3HLAr0T0d@diego>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-31-lee.jones@linaro.org>
        <4422628.h3HLAr0T0d@diego>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 21:10:27 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Am Freitag, 17. Juli 2020, 18:55:38 CEST schrieb Lee Jones:
> > This is the only use of kerneldoc in the source file and no
> > descriptions are provided.
> >=20
> > Fixes the following W=3D1 kernel build warning(s):
> >=20
> >  drivers/iio/adc/rockchip_saradc.c:190: warning: Function parameter or =
member 'reset' not described in 'rockchip_saradc_reset_controller'
> >=20
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org> =20
>=20
> Subject-line says "Demote Demote..."
>=20
> Otherwise
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Fixed up and applied.

Thanks for whole set Lee.

Jonathan

>=20
>=20
> > ---
> >  drivers/iio/adc/rockchip_saradc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockch=
ip_saradc.c
> > index 582ba047c4a67..cf4ec59c1dab0 100644
> > --- a/drivers/iio/adc/rockchip_saradc.c
> > +++ b/drivers/iio/adc/rockchip_saradc.c
> > @@ -183,7 +183,7 @@ static const struct of_device_id rockchip_saradc_ma=
tch[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
> > =20
> > -/**
> > +/*
> >   * Reset SARADC Controller.
> >   */
> >  static void rockchip_saradc_reset_controller(struct reset_control *res=
et)
> >  =20
>=20
>=20
>=20
>=20

