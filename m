Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522325FFB2B
	for <lists+linux-iio@lfdr.de>; Sat, 15 Oct 2022 18:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJOQKV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Oct 2022 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJOQKU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2022 12:10:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A03385C
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2022 09:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DBEC6CE0ABB
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2022 16:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A251C433D6;
        Sat, 15 Oct 2022 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665850215;
        bh=D//XcxJog8utf5JWgKGHosmjgzzQXF1s66dbBI6h7ZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q9fdUh3ghfGtWiHVvDuCCm6pG2pSew6EF7QtCtc+ucggEVDzvnP6A54POu938HPbb
         gBde7DyBpDuEu+LbedpUXBHbBE4S+1L8Q5fVGH+pDVMV6faNltKGtfnOSacLeD7eVU
         48uLdKnR94cWekBfvZPmBMRv1J5lVxDnGOb4OV32Wu6iI/nCYkIm5HWmMwH1ZxLSvF
         OtRtmGZjrE24jriajRjriKAFeyv+h9Ljx3X0uIE6q5ixrOMvYnjZupzMItHv1r1rWk
         INT/eU8PcE274UYCnq5WzERqGxJC854ftui86ut194DAOEbLoZU0vy/fZW/quhG6JO
         YU8wvgSHT3d4g==
Date:   Sat, 15 Oct 2022 17:10:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com,
        Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 0/4] Make 'mlock' really private
Message-ID: <20221015171033.54ccfa09@jic23-huawei>
In-Reply-To: <CAHp75VcUaSaAQ5Gs32bmpUyROqRLjMuDykdKp34p+2DYsovSPw@mail.gmail.com>
References: <20221012151620.1725215-1-nuno.sa@analog.com>
        <CAHp75VcUaSaAQ5Gs32bmpUyROqRLjMuDykdKp34p+2DYsovSPw@mail.gmail.com>
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

On Wed, 12 Oct 2022 20:49:13 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Oct 12, 2022 at 6:15 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >
> > This patchset cleans all the drivers directly using the iio_device 'mlo=
ck'.
> > This lock is private and should not be used outside the core (or by usi=
ng
> > proper helpers).
> >
> > Most of the conversions where straight, but there are some that really =
need
> > extra looking. Mainly patches [13/15] and [14/15] were a bit hacky since
> > iio_device_claim_direct_mode() does not fit 100%. The reason is that we
> > want to check if the device is buffering and do something if it is (in
> > which case the API return -EBUSY and released the lock. I just used a
> > combinations of locks to get around this (hopefully I did not messed up=
).
> >
> > Note that this series was only compiled tested using allyesconfig for
> > ARM. I ran 'git grep' to make sure there were no more users of 'mlock'.
> > Hopefully I covered them all... =20
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> I haven't seen any serious issues, some small ones regarding spelling,
> indentation and comment are per individual patches.

Tweaked inline with Andy's suggestions whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for now
as I'll be rebasing on rc1 once available.

Thanks,

Jonathan

>=20
> > v2:
> >
> > [PATCH 1-8, 10-12/16]
> >  * Mention the inclusion of mutex.h in the commit message.
> >
> > [PATCH 1-8, 10, 12/16]
> >  * Initialize mutex as late as possible.
> > Note that [PATCH 11/16] was not included since the code to do so was not
> > direct enough. Would need to get a pointer to the private struture
> > outside of scmi_alloc_iiodev() to do it. While not hard, the added chan=
ges
> > in the code is not really worth it (IMO of course).
> >
> > [PATCH 1/16]
> >  * Refactored the commit message a bit. I guess this one will still nee=
ds
> > more discussion...
> >
> > [PATCH 9/16]
> >  * New patch to add an helper function to read the samples.
> >
> > [PATCH 13/16]
> >  * New patch to introduce iio_device_{claim|release}_buffer_mode() APIs.
> >
> > [PATCH 14/16]
> >  * Make use of the new iio_device_{claim|release}_buffer_mode() helpers
> >
> > [PATCH 15/16]
> >  * Make use of the new iio_device_{claim|release}_buffer_mode() helpers
> > in combination with claim_direct_mode(). This is needed so that we make=
 sure
> > we always get one of the modes (and hence the iio_dev lock) to safely c=
all
> > max30102_get_temp(). Note that I'm not particular "happy" with the code=
 but
> > OTOH, it does not look as bad as I thought :). Anyways, if there are no
> > complains with it, I'm ok to leave it as-is. Otherwise, I think we can =
think
> > on the flag approach (briefly discussed in the first series).
> >
> > v3:
> >
> > [PATCH 1/4]
> >  * fix 'make W=3D1' warning about prototypes mismatch.
> >
> > [PATCH 2/4]
> >  * improved commit message to explain why we are shadowing error codes.
> >
> > [PATCH 4/4]
> >  * minor English fix on the commit message (as suggested by Andy).
> >
> > Nuno S=C3=A1 (4):
> >   iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs
> >   iio: health: max30100: do not use internal iio_dev lock
> >   iio: health: max30102: do not use internal iio_dev lock
> >   iio: core: move 'mlock' to 'struct iio_dev_opaque'
> >
> >  drivers/iio/TODO                   |  3 --
> >  drivers/iio/health/max30100.c      |  9 ++---
> >  drivers/iio/health/max30102.c      | 19 +++++++---
> >  drivers/iio/industrialio-buffer.c  | 29 ++++++++-------
> >  drivers/iio/industrialio-core.c    | 58 +++++++++++++++++++++++++-----
> >  drivers/iio/industrialio-event.c   |  4 +--
> >  drivers/iio/industrialio-trigger.c | 12 +++----
> >  include/linux/iio/iio-opaque.h     |  2 ++
> >  include/linux/iio/iio.h            |  5 ++-
> >  9 files changed, 97 insertions(+), 44 deletions(-)
> >
> > --
> > 2.38.0
> > =20
>=20
>=20

