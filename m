Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8186E5E8DCE
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiIXPYN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiIXPXw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:23:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE688DCC
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 054A660A5A
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 15:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19371C433C1;
        Sat, 24 Sep 2022 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664033007;
        bh=8ZTQWTVeH3oTNXCofwKxdW1dGEo0jwBg7H7ydQ/CskQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S/5DlNRWGPoIqFtMx5J10lqW3MLJx3RrPAGxfNI45g2TM70jcKokKibQtcnZwOKox
         c34sfdJXAzcpDx6JZk1KA6lvAZlbW02gzK0mwbwBXNJkI6kFSdjZO4UlUzhtbn8eVJ
         ZbMW+lbEJ3NeWKev4U520ZbiJqofSUAmuY6TIGg8Wgmbf6FVpzGQgtBwiqTtva/p9m
         HfhvM5fX3dk3jVHZHZLLxHe5i/GxdFJBKuW9/On8Dbl1Rgpw5Us9Q30yf5lPAKFleH
         Fd5SjljThTd651c36JT14rqQSKiWni0UpaeZqxDvSC1A9MN2fF6ygBX4rDsv45iMVz
         jhJIramDe1XPw==
Date:   Sat, 24 Sep 2022 16:23:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-arm-kernel@lists.infradead.org" 
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        "Regus, Ciprian" <Ciprian.Regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 03/15] iio: adc: axp288_adc: do not use internal iio_dev
 lock
Message-ID: <20220924162329.5f0dd680@jic23-huawei>
In-Reply-To: <c487df06699aa53292909ff6be2b07de324793f4.camel@gmail.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-4-nuno.sa@analog.com>
        <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com>
        <SJ0PR03MB6778FFE254E9DDC103258FE8994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
        <CAHp75VdVbkXCC1PpT4h-+4HHpZX-zK34xH9dVG8vGcpQhXaQHQ@mail.gmail.com>
        <CAHp75VfdUOTd9tRXdTVq_prNf_T2=iQ4tEjusHC=gXDZvb3Qeg@mail.gmail.com>
        <SJ0PR03MB6778EEF81693C026CE131B49994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
        <CAHp75VdT0a2DevybjT4HN8xGFrKzrR0sPXA6P89xnBg1xcqbQA@mail.gmail.com>
        <c487df06699aa53292909ff6be2b07de324793f4.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Sep 2022 11:07:50 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2022-09-20 at 18:12 +0300, Andy Shevchenko wrote:
> > On Tue, Sep 20, 2022 at 4:46 PM Sa, Nuno <Nuno.Sa@analog.com> wrote: =20
> > > > -----Original Message-----
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Tuesday, September 20, 2022 3:39 PM
> > > > On Tue, Sep 20, 2022 at 4:37 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote: =20
> > > > > On Tue, Sep 20, 2022 at 4:18 PM Sa, Nuno <Nuno.Sa@analog.com>
> > > > > wrote: =20
> > > > > > > On Tue, Sep 20, 2022 at 2:28 PM Nuno S=C3=A1
> > > > > > > <nuno.sa@analog.com> =20
> > > > wrote:
> > > >=20
> > > > ...
> > > >  =20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info =3D iio_pri=
v(indio_dev);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&info->loc=
k);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->irq =3D pl=
atform_get_irq(pdev, 0);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (info->irq < =
0)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return info->irq; =20
> > > > > > >=20
> > > > > > > Consider initializing it as late as possible, like after
> > > > > > > IRQ retrieval
> > > > > > > in this context (maybe even deeper, but no context
> > > > > > > available). Ditto
> > > > > > > for the rest of the series. =20
> > > > > >=20
> > > > > > Any special reason for it (maybe related to lockdep
> > > > > > :wondering: ) ? Just
> > > > > > curious as I never noticed such a pattern when initializing
> > > > > > mutexes. =20
> > > > >=20
> > > > > Yes. Micro-optimization based on the rule "don't create a
> > > > > resource in
> > > > > case of known error".
> > > > >=20
> > > > > OTOH, you have to be sure that the mutex (and generally
> > > > > speaking a
> > > > > locking) should be initialized early enough. =20
> > >=20
> > > Typically not really needed during probe... =20
> >=20
> > Actually as long as you expose the ABI to the user anything can
> > happen, means that your code should be ready to receive the requests
> > in any possible callbacks / file ops. Same applies to the IRQ
> > handler.
> > So it's very important to initialize locking just in time. Hence I
> > can
> > say that "typically it needs to be carefully placed".
> >  =20
>=20
> Yes, I'm aware of that... For some reason I just thought about code
> paths directly on probe. Anyways, hopefully these drivers mostly do the
> right thing and register the IIO device as late as possible (ideally
> the last thing to be done). The same goes for IRQs and for IIO, when
> used as part of triggered buffering, the lock is often only used in the
> trigger handler which means it's only reachable after the ABI is
> exposed...=20

Can't say I feel that strongly about a mutex_init() placement, but
no harm in moving them later - indeed before the iio_device_register()
should be correct - though care needed as might be some unnecessary locks
taken in probe because of code sharing (and them previously being harmless)

Jonathan
>=20
> - Nuno S=C3=A1
> > >  =20

