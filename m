Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3049D115BD8
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 11:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLGKdx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 05:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGKdx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 05:33:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E3424673;
        Sat,  7 Dec 2019 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575714832;
        bh=SuakieLmzH/APRkH24GmeiDVGJkhpgM0p3HYv5+YVNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IDF+m0ScfxXqIXX35QX4SQRSrqb7oX3ILXORqiFbrHXbogC6e4NSV+ypIJiSM8iOd
         bIFoKctSRG1XWFJ0PrA/hPfvxbipFd3/BFCY2k392XDZqo8/Vz0PRkeyiuog7DZ+xJ
         BnAdWSMHDzl7WPZyrYA14DuHXcsitfLdHbHVfC08=
Date:   Sat, 7 Dec 2019 10:33:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max9611: Fix too short conversion time
 delay
Message-ID: <20191207103348.58df9cd5@archlinux>
In-Reply-To: <20191202092328.GE1266@kunai>
References: <20191202085546.21655-1-geert+renesas@glider.be>
        <20191202092328.GE1266@kunai>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Dec 2019 10:23:29 +0100
Wolfram Sang <wsa@the-dreams.de> wrote:

> On Mon, Dec 02, 2019 at 09:55:46AM +0100, Geert Uytterhoeven wrote:
> > As of commit b9ddd5091160793e ("iio: adc: max9611: Fix temperature
> > reading in probe"), max9611 initialization sometimes fails on the
> > Salvator-X(S) development board with:
> >=20
> >     max9611 4-007f: Invalid value received from ADC 0x8000: aborting
> >     max9611: probe of 4-007f failed with error -5
> >=20
> > The max9611 driver tests communications with the chip by reading the die
> > temperature during the probe function, which returns an invalid value.
> >=20
> > According to the datasheet, the typical ADC conversion time is 2 ms, but
> > no minimum or maximum values are provided.  Maxim Technical Support
> > confirmed this was tested with temperature Ta=3D25 degreeC, and promised
> > to inform me if a maximum/minimum value is available (they didn't get
> > back to me, so I assume it is not).
> >=20
> > However, the driver assumes a 1 ms conversion time.  Usually the
> > usleep_range() call returns after more than 1.8 ms, hence it succeeds.
> > When it returns earlier, the data register may be read too early, and
> > the previous measurement value will be returned.  After boot, this is
> > the temperature POR (power-on reset) value, causing the failure above.
> >=20
> > Fix this by increasing the delay from 1000-2000 =C2=B5s to 3000-3300 =
=C2=B5s.
> >=20
> > Note that this issue has always been present, but it was exposed by the
> > aformentioned commit.
> >=20
> > Fixes: 69780a3bbc0b1e7e ("iio: adc: Add Maxim max9611 ADC driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org> =20
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> One minor nit, though:
>=20
> >  	/*
> >  	 * need a delay here to make register configuration
> > -	 * stabilize. 1 msec at least, from empirical testing.
> > +	 * stabilize. =20
>=20
> This could be a one line comment now?
>=20

Applied to the fixes-togreg branch of iio.git and tidied up.

Thanks,

Jonathan
