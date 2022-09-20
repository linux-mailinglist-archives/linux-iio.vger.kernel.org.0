Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824DC5BE67F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 14:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiITM4S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiITM4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 08:56:02 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BDA1109
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 05:55:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E2A8524000B;
        Tue, 20 Sep 2022 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663678542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvP2VnaVeAmv7X3q0XnLZdYYvccTNDrdUp8IpW6a02Q=;
        b=T1Sa9Wln1x+MhKCvfwM4dJ17lIiQ+b+OJkYYehng/7fDBc5KNeDP+phVj7MPEcFCD6Ysk9
        qodSEKVByB7yXFL05wE0ZcMvwOJUR7rx9yBgRYL+DWuS6B+BeDLUdzNV+QoYmUF47N6Wzj
        IwWDTq2UwIQX6A7to2eiUHD+U1lcDbbQSN6BmFKEiywuclk+0J8SOtdXY3YIwa17BZT8a3
        0cAWriLPEJWZ7VFzE6BXXGWLMiYWfGkKW6G5bZ5d58jYTs6rRA07OQOYhAhLiB2GAMKpDG
        4KbbSoiMS22ITEbZBEgmno1WO+nMwOSg2cqqDLfHhB62glWkS+herj8RzC5dRw==
Date:   Tue, 20 Sep 2022 14:55:34 +0200
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
Message-ID: <20220920145534.0bdd4e69@xps-13>
In-Reply-To: <SJ0PR03MB6778FC7FD469F7C2BC7FB9DB994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-14-nuno.sa@analog.com>
        <20220920142319.61557023@xps-13>
        <SJ0PR03MB6778FC7FD469F7C2BC7FB9DB994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
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

Nuno.Sa@analog.com wrote on Tue, 20 Sep 2022 12:44:08 +0000:

> > -----Original Message-----
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Sent: Tuesday, September 20, 2022 2:23 PM
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
> >  =20
>=20
> Hi Miquel,
>=20
> Thanks for reviewing...
>=20
> > nuno.sa@analog.com wrote on Tue, 20 Sep 2022 13:28:19 +0200:
> >  =20
> > > The pattern used in this device does not quite fit in the
> > > iio_device_claim_direct_mode() typical usage. In this case,
> > > iio_buffer_enabled() was being used not to prevent the raw access but=
 to
> > > allow it. Hence to get rid of the 'mlock' we need to:
> > >
> > > 1. Use iio_device_claim_direct_mode() to check if direct mode can be
> > > claimed and if we can return -EINVAL (as the original code);
> > >
> > > 2. Make sure that buffering is not disabled while doing a raw read. F=
or
> > > that, we can make use of the local lock that already exists.
> > >
> > > While at it, fixed a minor coding style complain...
> > >
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > >  drivers/iio/health/max30100.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30=
100.c
> > > index ad5717965223..aa494cad5df0 100644
> > > --- a/drivers/iio/health/max30100.c
> > > +++ b/drivers/iio/health/max30100.c
> > > @@ -185,8 +185,19 @@ static int max30100_buffer_postenable(struct =20
> > iio_dev *indio_dev) =20
> > >  static int max30100_buffer_predisable(struct iio_dev *indio_dev)
> > >  {
> > >  	struct max30100_data *data =3D iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * As stated in the comment in the read_raw() function, temperature
> > > +	 * can only be acquired if the engine is running. As such the mutex
> > > +	 * is used to make sure we do not power down while doing a =20
> > temperature =20
> > > +	 * reading.
> > > +	 */
> > > +	mutex_lock(&data->lock);
> > > +	ret =3D max30100_set_powermode(data, false);
> > > +	mutex_unlock(&data->lock);
> > >
> > > -	return max30100_set_powermode(data, false);
> > > +	return ret;
> > >  }
> > >
> > >  static const struct iio_buffer_setup_ops max30100_buffer_setup_ops =
=3D {
> > > @@ -387,18 +398,17 @@ static int max30100_read_raw(struct iio_dev =20
> > *indio_dev, =20
> > >  		 * Temperature reading can only be acquired while engine
> > >  		 * is running
> > >  		 */
> > > -		mutex_lock(&indio_dev->mlock);
> > > -
> > > -		if (!iio_buffer_enabled(indio_dev))
> > > +		if (!iio_device_claim_direct_mode(indio_dev)) { =20
> >=20
> > I wonder if this line change here is really needed. I agree the whole
> > construction looks like what iio_device_claim_direct_mode() does but in
> > practice I don't see the point of acquiring any lock here if we just
> > release it no matter what happens right after.
> >  =20
>=20
> I can see that this is odd (at the very least) but AFAIK, this is the onl=
y way
> to safely infer if buffering is enabled or not. iio_buffer_enabled() has =
no
> protection against someone concurrently enabling/disabling the buffer.

Yes, but this is only relevant if you want to infer that the "buffers
are enabled" and be sure that it cannot be otherwise during the next
lines until you release the lock. Acquiring a lock, doing the if and
then unconditionally releasing the lock, IMHO, does not make any sense
(but I'm not a locking guru) because when you enter the else clause,
you are not protected anyway, so in both cases all this is completely
racy.

> So the call is needed to make sure 'mlock' is internally grabbed before
> calling iio_buffer_enabled().
>=20
> > Unless of course if there is a hidden goal like "stop exporting
> > iio_buffer_enabled()" or something like that.
> >=20
> > At least I would separate this from the main change which targets the
> > removal of mlock because I don't see how it is directly related. =20
>=20
> In a sense both changes are needed to ultimately get rid of mlock. I'm=20
> also not sure how could I do the separation... Do you have something
> in mind?
>=20
> - Nuno S=C3=A1


Thanks,
Miqu=C3=A8l
