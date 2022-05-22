Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA09B530277
	for <lists+linux-iio@lfdr.de>; Sun, 22 May 2022 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiEVKn2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 May 2022 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiEVKn1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2022 06:43:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADDD2CE29
        for <linux-iio@vger.kernel.org>; Sun, 22 May 2022 03:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB51DB80AE9
        for <linux-iio@vger.kernel.org>; Sun, 22 May 2022 10:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91588C385AA;
        Sun, 22 May 2022 10:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653216203;
        bh=eOTS+ONbE8NROdD7tQjY7SQpMb6jCz0ZbuGsxC8wi08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jk2mrXohfmERiBQFbZUE/Ph6qX6G1X1cdK/nAwQcQiW/xddwamPy3TtUgBosw1WiB
         1GXz1cecSOCPG8HmNxQkK5nZWo8Pthfdcv4rn02WWMCAUkYiC5r9t9idLjI/4Hot3z
         EEnm1Qe6Wu4g5FYZ1dh6mBGckWdv3U7QpWmseIaKZZD2muwnpYNzExIzmYWbwIgAMH
         u2MxLua0M9Xwe0bgxrqydF6mhY2wkJYFEBcufps2A7xR7Nw+wVzZAbxJZuChmGb5cs
         AiBB6j7ctBx1OSAI33V1TxWclQxkZf1oWLM9qKzG1vBMYsyTX6yRhpwp+Y1qW2C/L2
         +wd1cSiyulIoA==
Date:   Sun, 22 May 2022 11:52:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/8] iio: Improve error reporting for problems during
 .remove for various i2c drivers
Message-ID: <20220522115207.4bedc6e8@jic23-huawei>
In-Reply-To: <20220515180522.5cfedc85@jic23-huawei>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
        <20220515180522.5cfedc85@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 May 2022 18:05:22 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 15 May 2022 17:59:21 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello,
> >=20
> > the goal of this series is to improve the error messages emitted by
> > remove callbacks by several i2c drivers. The status quo is that these
> > might return an error code silently to the i2c core on remove. The
> > effect is a very unhelpful message:
> >=20
> > 	$bus $device: remove failed (EIO), will be ignored
> >=20
> > . Note there is no further error handling and the device will be
> > removed, all devm cleanups are called.
> >=20
> > With the patches from this series applied the emitted message better
> > tells what actually failed and the remove callback returns zero
> > unconditionally.
> >=20
> > The motivation for this change is to make i2c remove callbacks return
> > void. The ability to return a value is misleading as driver authors
> > might expect some kind of error handling from the i2c core. =20
>=20
> All look good to me, but I'll leave them on list for a little while
> to let others take a look.  Give me a poke if I seem to have lost them
> (it's been known to happen :( )

Applied to the togreg branch of iio.git and pushed out for now as testing.

Very unlikely these will make this cycle unless there is a delay for
some reason.  Hence queued up for 5.20 and I may not push out for next to
pick up until merge window has mostly gone by.

>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Best regards
> > Uwe
> >=20
> > Uwe Kleine-K=C3=B6nig (8):
> >   iio:adc:ina2xx: Improve error reporting for problems during .remove()
> >   iio:adc:ti-ads1015: Improve error reporting for problems during
> >     .remove()
> >   iio:chemical:atlas: Improve error reporting for problems during
> >     .remove()
> >   iio:chemical:ccs811: Improve error reporting for problems during
> >     .remove()
> >   iio:light:pa12203001: Improve error reporting for problems during
> >     .remove()
> >   iio:light:us5182d: Improve error reporting for problems during
> >     .remove()
> >   iio:light:vcnl4000: Improve error reporting for problems during
> >     .remove()
> >   iio:light:vcnl4035: Improve error reporting for problems during
> >     .remove()
> >=20
> >  drivers/iio/adc/ina2xx-adc.c        | 10 ++++++++--
> >  drivers/iio/adc/ti-ads1015.c        |  8 +++++++-
> >  drivers/iio/chemical/atlas-sensor.c |  8 +++++++-
> >  drivers/iio/chemical/ccs811.c       | 10 ++++++++--
> >  drivers/iio/light/pa12203001.c      |  8 +++++++-
> >  drivers/iio/light/us5182d.c         |  8 +++++++-
> >  drivers/iio/light/vcnl4000.c        |  8 +++++++-
> >  drivers/iio/light/vcnl4035.c        | 10 ++++++++--
> >  8 files changed, 59 insertions(+), 11 deletions(-)
> >=20
> >=20
> > base-commit: 3123109284176b1532874591f7c81f3837bbdc17 =20
>=20

