Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E395278D5
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiEOQ4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEOQ4v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:56:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEBC2AC6D
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 09:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24358B80D2A
        for <linux-iio@vger.kernel.org>; Sun, 15 May 2022 16:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200E6C385B8;
        Sun, 15 May 2022 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652633807;
        bh=CYyLcQ34wRcIrBQgTHuMYTLMYxhqhKRInJyrTJp4izk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGUfTdAOO0nn+IUwP7KfxukjMGr52JNAV79IxvvRuw1MDSUgs2o1PjtYipChOJ6MB
         Fo1YKaPlyZ8LVq1Xu874n4PtgdV/nbK8HQ57ZNQ7qfImAd2E14P2Q0zV9zgL9RT5Xv
         kVkp+11nqKOKFLeRQOWXFcZJXrbIIgHEDqVKyscW+jN7WEFSXvo8ev94mjtLWxbORM
         MKiKLb6ev5w7xzuEyIkdIJU2t04jupz3YxSlX5rCqqKjLSliCY1NCFDyVOV1a1JraD
         /6HvDhgrc64QhgmSw9Aeg/5YCfW+1BuC7nWDhVDy5oo4KQOeXdnN4Bvb2NTndyz84h
         7WOjvtXjeZIgg==
Date:   Sun, 15 May 2022 18:05:22 +0100
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
Message-ID: <20220515180522.5cfedc85@jic23-huawei>
In-Reply-To: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
References: <20220515155929.338656-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 May 2022 17:59:21 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
>=20
> the goal of this series is to improve the error messages emitted by
> remove callbacks by several i2c drivers. The status quo is that these
> might return an error code silently to the i2c core on remove. The
> effect is a very unhelpful message:
>=20
> 	$bus $device: remove failed (EIO), will be ignored
>=20
> . Note there is no further error handling and the device will be
> removed, all devm cleanups are called.
>=20
> With the patches from this series applied the emitted message better
> tells what actually failed and the remove callback returns zero
> unconditionally.
>=20
> The motivation for this change is to make i2c remove callbacks return
> void. The ability to return a value is misleading as driver authors
> might expect some kind of error handling from the i2c core.

All look good to me, but I'll leave them on list for a little while
to let others take a look.  Give me a poke if I seem to have lost them
(it's been known to happen :( )

Thanks,

Jonathan

>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (8):
>   iio:adc:ina2xx: Improve error reporting for problems during .remove()
>   iio:adc:ti-ads1015: Improve error reporting for problems during
>     .remove()
>   iio:chemical:atlas: Improve error reporting for problems during
>     .remove()
>   iio:chemical:ccs811: Improve error reporting for problems during
>     .remove()
>   iio:light:pa12203001: Improve error reporting for problems during
>     .remove()
>   iio:light:us5182d: Improve error reporting for problems during
>     .remove()
>   iio:light:vcnl4000: Improve error reporting for problems during
>     .remove()
>   iio:light:vcnl4035: Improve error reporting for problems during
>     .remove()
>=20
>  drivers/iio/adc/ina2xx-adc.c        | 10 ++++++++--
>  drivers/iio/adc/ti-ads1015.c        |  8 +++++++-
>  drivers/iio/chemical/atlas-sensor.c |  8 +++++++-
>  drivers/iio/chemical/ccs811.c       | 10 ++++++++--
>  drivers/iio/light/pa12203001.c      |  8 +++++++-
>  drivers/iio/light/us5182d.c         |  8 +++++++-
>  drivers/iio/light/vcnl4000.c        |  8 +++++++-
>  drivers/iio/light/vcnl4035.c        | 10 ++++++++--
>  8 files changed, 59 insertions(+), 11 deletions(-)
>=20
>=20
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17

