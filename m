Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A365F8AF1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJILlI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJILlF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 07:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A62BB1B
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 04:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3832F60BA2
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 11:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62715C433D7;
        Sun,  9 Oct 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665315663;
        bh=f1VoKZXNgofSuY7kHfAakcUS845fjP5e/h0mPwmW+64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VgOam0GCCwF/f4WkQPha60Y2yxmMNuhOsp3exvUan+5OtsbAleFj55hDAHYvnHRpb
         s8ulQ4YWiEeCmO9S3+z1zLH21o+7p8Ii5oJvywskxxPzwitr4a6remWsYzVdBwv1SU
         eBqLzVbGGFeZPLrkHNFv/mNcwQMEXTT35I1jb8dJAS3KU//SSvjUNqAMi7PiwA3k87
         kO/ENazwQ7OLppxlJZiSexO3U0QTI5dEEVBsduI2tfwrM4fIuCty3oEODFZqk0kTY5
         TkMUFDeERRbHPx9J3dDyONgHKHOENz6MjTpF4qGuvqZhaaZD8aw7KhzD/kv8ddmR58
         emz58odusvM1g==
Date:   Sun, 9 Oct 2022 12:41:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 13/16] iio: core: introduce
 iio_device_{claim|release}_buffer_mode() APIs
Message-ID: <20221009124120.39a43103@jic23-huawei>
In-Reply-To: <609d7e50d76a2a2aa2bbaddfed8a846c91854065.camel@gmail.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-14-nuno.sa@analog.com>
        <CAHp75VfmMWonUV1jahbAmBZJixfdxA=ZAm-NNt7XiO+RDbupyg@mail.gmail.com>
        <609d7e50d76a2a2aa2bbaddfed8a846c91854065.camel@gmail.com>
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

On Wed, 05 Oct 2022 10:37:39 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2022-10-04 at 17:08 +0300, Andy Shevchenko wrote:
> > On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:=
 =20
> > >=20
> > > These APIs are analogous to iio_device_claim_direct_mode() and
> > > iio_device_release_direct_mode() but, as the name suggests, with
> > > the
> > > logic flipped. While this looks odd enough, it will have at least
> > > two
> > > users (in following changes) and it will be important to move the
> > > iio
> > > mlock to the private struct. =20
> >=20
> > ...
> >  =20
> > > +int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&indio_dev->mlock);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_buffer_enabled(indio_de=
v)) =20
> >=20
> > Do you need to annotate these two APIs to make sparse happy about
> > locking balance?
> >=20
> > (Try to run `make W=3D1 C=3D1 ...` with your patches and look if any new
> > warnings appear.) =20
>=20
> make W=3D1 C=3D1 drivers/iio/industrialio-core.o
> #  UPD     include/config/kernel.release

...

> drivers/iio/industrialio-core.c:2100: warning: expecting prototype for
> iio_device_claim_buffered_mode(). Prototype was for
> iio_device_claim_buffer_mode() instead

That one wants fixing as this patch introduces it.

>=20
> Don't really see anything odd in here... Am I missing something?=20
>=20
> Anyways, I guess you mean annotations as __acquires() and
> __releases()... Well, this API is pretty much analogous to
> iio_device_claim_direct_mode() which also don't have such annotations.
> Thus, I would say to add them (if we are going too) in a future patch
> to both APIs...
>=20
> Also fine with adding them now if Jonathan feels it's necessary.

I've wondered for a while why we don't get reports as
a result of those not being annotated.  However, follow up patch
probably makes sense rather than rolling it into this series.

Jonathan
>=20

