Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F473547612
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiFKPWE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiFKPWC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 11:22:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688B349C99;
        Sat, 11 Jun 2022 08:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A90EB8094F;
        Sat, 11 Jun 2022 15:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C35DC34116;
        Sat, 11 Jun 2022 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654960918;
        bh=3pqXIwRkCpdL23FW5mayQWHp6W7BS1dZVjgKzjnDFkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gRYmawn2TQl74Bw/FNJHf1SJ6RAwL94/acq6k1g35qf2FOtiAN3+PihnX5bQ5hRuq
         3uOrlm95IBa6x3oLDbyis8wyOj1uHpi8HmNCGoMlMNIfzh9ULQ+KeRkjppxBmhbzl1
         d+nH96GOEMXAm+VfdROKid8ugRGAjmZ/iBhkTb/bFjpDF91Pe0taFShCfFdn0G8F+c
         ieCC0FcuZn/ZgP7lGR8Prxy6MkTWFJ8OCxjBHoqfF9f427gSJRhIH+l/onidMKd7BV
         HjGaJLGeQQSCS1J2IURet3Koyimbu+ry+K4+zKmyb6ZHnw7jPufymaqmNYVRg18xbt
         EJuPE5rmdKQ4w==
Date:   Sat, 11 Jun 2022 16:30:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 24/34] iio: inkern: move to fwnode properties
Message-ID: <20220611163057.2e2606aa@jic23-huawei>
In-Reply-To: <97b9278953d923008a4c1230ca9bd354117e7213.camel@gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
        <20220610084545.547700-25-nuno.sa@analog.com>
        <CAHp75Vf6dYFR8TESk6oj=SFiXmw-tBAa9Fz-jhRk57ARumxzhA@mail.gmail.com>
        <97b9278953d923008a4c1230ca9bd354117e7213.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jun 2022 22:01:09 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2022-06-10 at 17:19 +0200, Andy Shevchenko wrote:
> > On Fri, Jun 10, 2022 at 10:48 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrot=
e: =20
> > >=20
> > > This moves the IIO in kernel interface to use fwnode properties and
> > > thus
> > > be firmware agnostic.
> > >=20
> > > Note that the interface is still not firmware agnostic. At this
> > > point we
> > > have both OF and fwnode interfaces so that we don't break any user.
> > > On
> > > top of this we also want to have a per driver conversion and that
> > > is the
> > > main reason we have both of_xlate() and fwnode_xlate() support. =20
> >=20
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Thanks!
> >=20
> > A few nit-picks below, though.
> >  =20
...

>=20
> >  =20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D of_parse_phandle_with_a=
rgs(np, "io-channels",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "#io-channel-cells",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index, &iiospec);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D fwnode_property_get_ref=
erence_args(fwnode, "io-
> > > channels",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "#io-cha=
nnel-
> > > cells", 0,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index, &=
iiospec);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return err;
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idev =3D bus_find_device(&iio_b=
us_type, NULL, iiospec.np,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idev =3D bus_find_device(&iio_b=
us_type, NULL, iiospec.fwnode,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_dev_node_match); =20
> >=20
> > Wondering if this
> > https://elixir.bootlin.com/linux/v5.19-rc1/C/ident/bus_find_device_by_f=
wnode
> > can be utilized (yes, I noticed iio_device_type above). =20
>=20
> Hmm, at first glance I would say we can use it. AFAICT, we are already
> grabbing a node which contains "#io-channel-cells" which is very
> indicative that is an IIO device. I also find it very unlikely to have
> two IIO devices with the same fwnode (I guess it would be an issue even
> in the old code) and even more unlikely two devices of diferent types
> with the same fwnode?

If we are talking struct iio_dev instances, then there are quite a few cases
where there are multiple with the same fwnode.  We had to do that pre
multiple buffers being introduced so it's fairly common, though not in
ADCs which is probably why we haven't seen breakage here. Not sure how
broken things already are as a result or if any of those devices (most
IMUs) provide #io-channel-cells etc.  I'd put that breakage down as
one to look into if anyone every hits it or one of us is bored enough
to poke at it.  (superficially I think we'd have to check all matches
for an xlate success).

Also, possible (I'm not totally sure) that we have other subdevices using
the same firmware node, such as triggers.  I can't immediately think
of why they would need it, but I'd rather we were at least partly protected
against that.

>=20
> Anyways, I guess Jonathan can help in here...
>=20
>=20
> >  =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (idev =3D=3D NULL) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 of_node_put(iiospec.np);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fwnode_handle_put(iiospec.fwnode);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EPROBE_DEFER;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev =3D dev_to_iio_d=
ev(idev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel->indio_dev =3D ind=
io_dev;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (indio_dev->info->of_xl=
ate)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index =3D indio_dev->info->of_xlate(indio_dev,
> > > &iiospec);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index =3D __fwnode_to_of_xlate(indio_dev, &iiospec);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (indio_dev->info->fwnod=
e_xlate)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index =3D indio_dev->info->fwnode_xlate(indio_dev,
> > > &iiospec);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index =3D __of_iio_simple_xlate(indio_dev, &iiospec);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_node_put(iiospec.np);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index =3D __fwnode_iio_simple_xlate(indio_dev,
> > > &iiospec);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwnode_handle_put(iiospec.fwnod=
e);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (index < 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto err_put;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel->channel =3D &indi=
o_dev->channels[index];
> > > @@ -188,7 +209,8 @@ static int __of_iio_channel_get(struct
> > > iio_channel *channel,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return index;
> > > =C2=A0}

> >  =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *parent_lookup =3D false;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return chan;
> > > =C2=A0}
> > >=20
> > > -struct iio_channel *of_iio_channel_get_by_name(struct device_node
> > > *np,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name)
> > > +struct iio_channel *fwnode_iio_channel_get_by_name(struct
> > > fwnode_handle *fwnode,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const char
> > > *name)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_channel *chan;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_handle *parent;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool parent_lookup =3D tru=
e;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Walk up the tree of dev=
ices looking for a matching iio
> > > channel */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chan =3D __of_iio_channel_get_b=
y_name(np, name,
> > > &parent_lookup);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chan =3D __fwnode_iio_channel_g=
et_by_name(fwnode, name,
> > > &parent_lookup);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!parent_lookup)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return chan;
> > >=20
> > > @@ -255,33 +279,34 @@ struct iio_channel
> > > *of_iio_channel_get_by_name(struct device_node *np,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the parent node=
 has a "io-channel-ranges" property,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * then we can try on=
e of its channels.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 np =3D np->parent;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (np) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!of_get_property(np, "io-channel-ranges",
> > > NULL))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwnode_for_each_parent_node(fwn=
ode, parent) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!fwnode_property_present(parent, "io-channel-
> > > ranges")) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwnode_h=
andle_put(parent);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n chan; =20
> >=20
> > break; ? =20
>=20
> The return in place was a request from Jonathan in the RFC...

:)  I prefer not having to scroll down when we can get out quickly.

>=20
> >=20
> > (Yes, I understand pros and cons of each variant, up to you)
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 chan =3D __of_iio_channel_get_by_name(np, name,
> > > &parent_lookup);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!parent_lookup)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 chan =3D __fwnode_iio_channel_get_by_name(parent,
> > > name, &parent_lookup);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!parent_lookup) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwnode_h=
andle_put(parent);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n chan; =20
> >=20
> > Ditto.
> >  =20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 np =3D np->parent;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return chan;
> > > =C2=A0}
> > > -EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
> > > +EXPORT_SYMBOL_GPL(fwnode_iio_channel_get_by_name); =20
> >=20
> > Wondering if we may move this to the IIO namespace. =20
>=20
> I guess it makes sense but surely on a different patch...

Yup - moving to a IIO namespace is a work in progress (got snarled
up by the PM related macros needed for some of the sub namespaces
which is now sorted)  Let's do it after this.


