Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5825F8B20
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 14:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJIMQV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJIMQU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 08:16:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195A1ADAF
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 05:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7CA70CE0E6B
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 12:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF9C433D6;
        Sun,  9 Oct 2022 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317775;
        bh=b62qZ/wRsncRtD4d6NTTlOS81wG617HjE3oXMVJXJyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UspNBuaqbI2pPkxbCJ4BP1yMgPfxpbpHLTWm7QXzeUgK/5h2F3ZZrNfCme+dussU4
         Z03/2XCobXlADxRr5Tv7m1loDYV8gRfsDjoamwwH2Qrsg87kdlry+KN2a87u6NbZa7
         duJKkLW2wpG9K90k1iFyL+Rw9ZK6GomCxlTQS3B7nRF4xHCxIk0yDj0d7xE/skjLm9
         tHgLIsIIyRJiirXLtO9XBHQ+ksHCr607PSE6HXdknb0VXNLNTxGzWko4vpWV++aUnG
         BILxz/e6jF1W7dgizLogP9Pmgx2h/FLxolv1SSqHuEXtB6oT34vxTsBrfmAcqAfFNz
         F3tjPEmW4qR2w==
Date:   Sun, 9 Oct 2022 13:16:31 +0100
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
Subject: Re: [PATCH v2 15/16] iio: health: max30102: do not use internal
 iio_dev lock
Message-ID: <20221009131631.6dcfe842@jic23-huawei>
In-Reply-To: <20221009124440.71adf505@jic23-huawei>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-16-nuno.sa@analog.com>
        <CAHp75VdiAzOUNMB3wD5og-uZi1W_7UWkqV6+s7jCxpaBs1VWRQ@mail.gmail.com>
        <428661431e54744064946ced681cc0351d51d698.camel@gmail.com>
        <20221009124440.71adf505@jic23-huawei>
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

On Sun, 9 Oct 2022 12:44:40 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 05 Oct 2022 10:17:00 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2022-10-04 at 17:15 +0300, Andy Shevchenko wrote: =20
> > > On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrot=
e:   =20
> > > >=20
> > > > The pattern used in this device does not quite fit in the
> > > > iio_device_claim_direct_mode() typical usage. In this case, we want
> > > > to
> > > > know if we are in buffered mode or not to know if the device is
> > > > powered
> > > > (buffer mode) or not. And depending on that max30102_get_temp()
> > > > will
> > > > power on the device if needed. Hence, in order to keep the same
> > > > functionality, we try to:
> > > >=20
> > > > 1. Claim Buffered mode;
> > > > 2: If 1) succeeds call max30102_get_temp() without powering on the
> > > > =C2=A0=C2=A0 device;
> > > > 3: Release Buffered mode;
> > > > 4: If 1) fails, Claim Direct mode;
> > > > 5: If 4) succeeds call max30102_get_temp() with powering on the
> > > > device;
> > > > 6: Release Direct mode;
> > > > 7: If 4) fails, goto to 1) and try again.
> > > >=20
> > > > This dance between buffered and direct mode is not particularly
> > > > pretty
> > > > (as well as the loop introduced by the goto statement) but it does
> > > > allow
> > > > us to get rid of the mlock usage while keeping the same behavior.  =
 =20
> > >=20
> > > ...
> > >    =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (iio_device_claim_buffer_mode(indio_dev)) {   =20
> > >=20
> > > Why is ret not used here?
> > >    =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
This one is a *bit* hacky. If we cannot
> > > > claim buffer
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
mode, then try direct mode so that we
> > > > make sure
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
things cannot concurrently change. And
> > > > we just keep
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
trying until we get one of the modes...
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if
> > > > (iio_device_claim_direct_mode(indio_dev))   =20
> > >=20
> > > ...and here?
> > >    =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto any_mode_retry;   =20
> > >    =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else {   =20
> > >    =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }   =20
> > >=20
> > > I.o.w. what error code will be visible to the caller and why.
> > >    =20
> >=20
> > Note that we do not really care about the error code returned by both
> > iio_device_claim_buffer_mode() and iio_device_claim_direct_mode(). We
> > just loop until we get one of the modes (thus ret =3D 0) so that we can
> > safely call one of the max30102_get_temp() variants. And that will be
> > the visible error code (if any). That said, you can look at the first
> > version of the series about this (and the previous patch) and why this
> > is being done like this (note that I'm also not 100% convinced about
> > this ping pong between getting one of the IIO modes but it's also not
> > that bad and if there's no major complains, I'm fine with it). =20
>=20
> This is a vanishingly rare corner case and not in a remotely high perform=
ance
> path so I'm not keen on introducing a more complex API just to handle
> this corner. If we added a means to get the lock independent of mode
> we'd have an interface that is far to likely to get missused.
> What you have here does the job and looks nasty enough to put people off
> copying it unless they really need it!
>=20
> Jonathan
>=20
I should probably have said lgtm for how you have it here.

Jonathan


