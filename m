Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5905F8AF8
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJILsC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 07:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJILsB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 07:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82B82D742
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 04:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 443AB60BA7
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 11:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E19DC433C1;
        Sun,  9 Oct 2022 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316079;
        bh=uLUT0ZlPLaW7vPy5rpn1T/wM8DNzywIgKzRvliwSObs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uSHU58/wL/H2hi+pxvpQh58nBsB4DtqePkrRlaUJruDvQEjhp4p1GLUWVTsqRQ+gY
         VrdcySZgRFyaxgRKML/KSVKS9xRIQqqcC9O6I4sc2YcWzwChGn/6mcCw0hAi/+HguH
         O5BJUGpUYwOreVA6JIyumu9actpMognRXPBiD/sNp+F4avVd3WOBTxZhjKodHS2hR+
         sJOCQhqZt28lvztXE7sUrMgfksWXOW+gICINq+AkzPtgb59EpU+4KT8Mi3Quh3xSCx
         JchuPduXpoJF10ZZDbNhtiqJaVdkIYy/0+jDqhtftKrALN6aU5iQvs2aU0Hq6nRdj4
         AcO686FjQBCqg==
Date:   Sun, 9 Oct 2022 12:48:15 +0100
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
Subject: Re: [PATCH v2 16/16] iio: core: move 'mlock' to 'struct
 iio_dev_opaque'
Message-ID: <20221009124815.3d34daff@jic23-huawei>
In-Reply-To: <f25507c2bfce7933684a2f1bfd00eb14609cd8b2.camel@gmail.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-17-nuno.sa@analog.com>
        <CAHp75VfpcrTpH83XqAC9xFrwYApORwoDcqmnhLLTkEWbj6zYVg@mail.gmail.com>
        <f25507c2bfce7933684a2f1bfd00eb14609cd8b2.camel@gmail.com>
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

On Wed, 05 Oct 2022 10:40:03 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2022-10-04 at 17:21 +0300, Andy Shevchenko wrote:
> > On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:=
 =20
> > >=20
> > > Now that there are no more users accessing 'mlock' directly, we can
> > > move
> > > it to the iio_dev private structure. Hence, it's now explicit that
> > > new
> > > driver's should not directly this lock. =20
> >=20
> > use this
> >=20
> >=20
> > I like the end result!
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >=20
> > P.S. Shouldn't we annotate the respective APIs with might_sleep() and
> > Co (if it's not done yet)?
> >=20
> >  =20
>=20
> Hmm, I would say this is the same story as with sparse annotations... I
> guess, at least, might_sleep() would make sense but I think we should
> probably do it for the complete IIO subsystem where it makes sense
> instead of having it in just this new API.

We definitely could add such annotations.

=46rom a documentation point of view that might be useful.=20
=46rom a protection / bug catching point of view the calls to mutex_lock()
should fire off much the same error reports, just one level down.

Jonathan

>=20
> - Nuno S=C3=A1=20
>=20

