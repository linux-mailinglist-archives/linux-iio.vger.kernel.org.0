Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4193A5BE7B4
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiITNys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiITNy1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 09:54:27 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E444A47BB1
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:53:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A83691C0004;
        Tue, 20 Sep 2022 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663681994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIlGeFbSdqitTtr0uWb11jZ/IbDiam3qsE3iTL+A9gA=;
        b=ZrHRrap1RAhB9I7EGA2dHOraOwN3TurjX+GOh8faV1N44bf6wiUmG9hHO8pD4MrlMXy4RA
        xVjVXA7Vt9g2jSxIjyEUsqX34N4P2P91Am05krN7mgnnTSJ9CXBdyWOUv8n1wFqCTzg5wD
        4y4bRnIbpSYeQznvzmtIFZuVzyb2Rhge1subZL0siVjJWSqVyQR8gQiu96aoc503LKW48v
        wXOrgvBUE+AFobzoEhL1iBNBwnURf1Oc3OWavISvJKg/pm95h64K7ID81J6BX49gQhB4z3
        IdIUyiHTtn65VJDZQTidlKvsGKx6BWt/66SNm0dzmrSxGWoTBPrnwk0US4Sy5w==
Date:   Tue, 20 Sep 2022 15:53:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        "Regus, Ciprian" <Ciprian.Regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 13/15] iio: health: max30100: do not use internal
 iio_dev lock
Message-ID: <20220920155305.395dad08@xps-13>
In-Reply-To: <SJ0PR03MB6778761640C55A5022F40822994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-14-nuno.sa@analog.com>
        <20220920142319.61557023@xps-13>
        <SJ0PR03MB6778FC7FD469F7C2BC7FB9DB994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
        <20220920145534.0bdd4e69@xps-13>
        <SJ0PR03MB6778761640C55A5022F40822994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

Nuno.Sa@analog.com wrote on Tue, 20 Sep 2022 13:15:32 +0000:

> > -----Original Message-----
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Sent: Tuesday, September 20, 2022 2:56 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-arm-kernel@lists.infradead.org; linux-rockchip@lists.infradea=
d.org;
> > linux-amlogic@lists.infradead.org; linux-imx@nxp.com; linux-
> > iio@vger.kernel.org; Chunyan Zhang <zhang.lyra@gmail.com>; Hennerich,
> > Michael <Michael.Hennerich@analog.com>; Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Cixi Geng <cixi.geng1@unisoc.com>; Kevin
> > Hilman <khilman@baylibre.com>; Vladimir Zapolskiy <vz@mleia.com>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Alexandru Ardelean
> > <aardelean@deviqon.com>; Fabio Estevam <festevam@gmail.com>; Andriy
> > Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>; Haibo Chen
> > <haibo.chen@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Hans de
> > Goede <hdegoede@redhat.com>; Jerome Brunet <jbrunet@baylibre.com>;
> > Heiko Stuebner <heiko@sntech.de>; Florian Boor
> > <florian.boor@kernelconcepts.de>; Regus, Ciprian
> > <Ciprian.Regus@analog.com>; Lars-Peter Clausen <lars@metafoo.de>; Andy
> > Shevchenko <andy.shevchenko@gmail.com>; Jonathan Cameron
> > <jic23@kernel.org>; Neil Armstrong <narmstrong@baylibre.com>; Baolin
> > Wang <baolin.wang@linux.alibaba.com>; Jyoti Bhayana
> > <jbhayana@google.com>; Chen-Yu Tsai <wens@csie.org>; Orson Zhai
> > <orsonzhai@gmail.com>
> > Subject: Re: [PATCH 13/15] iio: health: max30100: do not use internal i=
io_dev
> > lock
> >=20
> > [External]
> >=20
> > Hi Nuno,
> >=20
> > Nuno.Sa@analog.com wrote on Tue, 20 Sep 2022 12:44:08 +0000:
> >  =20
> > > > -----Original Message-----
> > > > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Sent: Tuesday, September 20, 2022 2:23 PM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: linux-arm-kernel@lists.infradead.org; linux- =20
> > rockchip@lists.infradead.org; =20
> > > > linux-amlogic@lists.infradead.org; linux-imx@nxp.com; linux-
> > > > iio@vger.kernel.org; Chunyan Zhang <zhang.lyra@gmail.com>; =20
> > Hennerich, =20
> > > > Michael <Michael.Hennerich@analog.com>; Martin Blumenstingl
> > > > <martin.blumenstingl@googlemail.com>; Sascha Hauer
> > > > <s.hauer@pengutronix.de>; Cixi Geng <cixi.geng1@unisoc.com>; Kevin
> > > > Hilman <khilman@baylibre.com>; Vladimir Zapolskiy <vz@mleia.com>;
> > > > Pengutronix Kernel Team <kernel@pengutronix.de>; Alexandru =20
> > Ardelean =20
> > > > <aardelean@deviqon.com>; Fabio Estevam <festevam@gmail.com>; =20
> > Andriy =20
> > > > Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>; Haibo Chen
> > > > <haibo.chen@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Hans de
> > > > Goede <hdegoede@redhat.com>; Jerome Brunet =20
> > <jbrunet@baylibre.com>; =20
> > > > Heiko Stuebner <heiko@sntech.de>; Florian Boor
> > > > <florian.boor@kernelconcepts.de>; Regus, Ciprian
> > > > <Ciprian.Regus@analog.com>; Lars-Peter Clausen <lars@metafoo.de>; =
=20
> > Andy =20
> > > > Shevchenko <andy.shevchenko@gmail.com>; Jonathan Cameron
> > > > <jic23@kernel.org>; Neil Armstrong <narmstrong@baylibre.com>; Baolin
> > > > Wang <baolin.wang@linux.alibaba.com>; Jyoti Bhayana
> > > > <jbhayana@google.com>; Chen-Yu Tsai <wens@csie.org>; Orson Zhai
> > > > <orsonzhai@gmail.com>
> > > > Subject: Re: [PATCH 13/15] iio: health: max30100: do not use intern=
al =20
> > iio_dev =20
> > > > lock
> > > >
> > > > [External]
> > > >
> > > > Hi Nuno,
> > > > =20
> > >
> > > Hi Miquel,
> > >
> > > Thanks for reviewing...
> > > =20
> > > > nuno.sa@analog.com wrote on Tue, 20 Sep 2022 13:28:19 +0200:
> > > > =20
> > > > > The pattern used in this device does not quite fit in the
> > > > > iio_device_claim_direct_mode() typical usage. In this case,
> > > > > iio_buffer_enabled() was being used not to prevent the raw access=
 but =20
> > to =20
> > > > > allow it. Hence to get rid of the 'mlock' we need to:
> > > > >
> > > > > 1. Use iio_device_claim_direct_mode() to check if direct mode can=
 be
> > > > > claimed and if we can return -EINVAL (as the original code);
> > > > >
> > > > > 2. Make sure that buffering is not disabled while doing a raw rea=
d. For
> > > > > that, we can make use of the local lock that already exists.
> > > > >
> > > > > While at it, fixed a minor coding style complain...
> > > > >
> > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > ---
> > > > >  drivers/iio/health/max30100.c | 24 +++++++++++++++++-------
> > > > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/health/max30100.c =20
> > b/drivers/iio/health/max30100.c =20
> > > > > index ad5717965223..aa494cad5df0 100644
> > > > > --- a/drivers/iio/health/max30100.c
> > > > > +++ b/drivers/iio/health/max30100.c
> > > > > @@ -185,8 +185,19 @@ static int max30100_buffer_postenable(struct=
 =20
> > > > iio_dev *indio_dev) =20
> > > > >  static int max30100_buffer_predisable(struct iio_dev *indio_dev)
> > > > >  {
> > > > >  	struct max30100_data *data =3D iio_priv(indio_dev);
> > > > > +	int ret;
> > > > > +
> > > > > +	/*
> > > > > +	 * As stated in the comment in the read_raw() function, tempera=
ture
> > > > > +	 * can only be acquired if the engine is running. As such the m=
utex
> > > > > +	 * is used to make sure we do not power down while doing a =20
> > > > temperature =20
> > > > > +	 * reading.
> > > > > +	 */
> > > > > +	mutex_lock(&data->lock);
> > > > > +	ret =3D max30100_set_powermode(data, false);
> > > > > +	mutex_unlock(&data->lock);
> > > > >
> > > > > -	return max30100_set_powermode(data, false);
> > > > > +	return ret;
> > > > >  }
> > > > >
> > > > >  static const struct iio_buffer_setup_ops max30100_buffer_setup_o=
ps =20
> > =3D { =20
> > > > > @@ -387,18 +398,17 @@ static int max30100_read_raw(struct iio_dev=
 =20
> > > > *indio_dev, =20
> > > > >  		 * Temperature reading can only be acquired while engine
> > > > >  		 * is running
> > > > >  		 */
> > > > > -		mutex_lock(&indio_dev->mlock);
> > > > > -
> > > > > -		if (!iio_buffer_enabled(indio_dev))
> > > > > +		if (!iio_device_claim_direct_mode(indio_dev)) { =20
> > > >
> > > > I wonder if this line change here is really needed. I agree the who=
le
> > > > construction looks like what iio_device_claim_direct_mode() does bu=
t in
> > > > practice I don't see the point of acquiring any lock here if we just
> > > > release it no matter what happens right after.
> > > > =20
> > >
> > > I can see that this is odd (at the very least) but AFAIK, this is the=
 only way
> > > to safely infer if buffering is enabled or not. iio_buffer_enabled() =
has no
> > > protection against someone concurrently enabling/disabling the buffer=
. =20
> >=20
> > Yes, but this is only relevant if you want to infer that the "buffers
> > are enabled" and be sure that it cannot be otherwise during the next
> > lines until you release the lock. Acquiring a lock, doing the if and
> > then unconditionally releasing the lock, IMHO, does not make any sense
> > (but I'm not a locking guru) because when you enter the else clause,
> > you are not protected anyway, so in both cases all this is completely
> > racy.
> >  =20
>=20
> Ahh crap, yes you are right... It is still racy since we can still try to=
 read
> the temperature with the device powered off. I'm not really sure how to
> address this. One way could be to just use an internal control variable
> to reflect the device power state (set/clear on the buffer callbacks) and
> only use the local lock (completely ditching the call to
> iio_device_claim_direct_mode())...

I tend to prefer this option than the one below.

I guess your implementation already prevents buffer_predisable() to run
thanks to the local lock being held during the operation. Maybe we
should just verify that buffers are enabled from within the local lock
being held instead of just acquiring it for the get_temp() measure. It
would probably solve the situation here.

> Other options would be to have helpers for acquiring/releasing the lock
> (I think this would defeat the idea of not abusing this lock at all) or h=
ave
> A version  iio_device_claim_direct_mode() that does not release the=20
> lock in case buffering is enabled. Any preference?
>=20
> - Nuno S=C3=A1


Thanks,
Miqu=C3=A8l
