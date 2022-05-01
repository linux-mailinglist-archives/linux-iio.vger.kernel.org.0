Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212335166A7
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 19:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353149AbiEARhD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiEARhC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 13:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305FFFD0A
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 10:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE8760F43
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 17:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E79AC385A9;
        Sun,  1 May 2022 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651426416;
        bh=AHB9bar0IfBudIEGsWMYtdzlpMKE2QEGRjwBrpBpF3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RFXboTEFc+bd+cCM6rvbGg2pm5RXwT1+8Lt8kRmKiobOVn9YLtyg8vDw2+EDWRd02
         XM4wfCthOtCSkF4Dc0GjCg7SDK0UIShIRP3rQeM41fQILqmJ/g9YkE93K2C5/zzQgP
         mzRhcFMgBYneprOe9TubNnTiFuK+jCn4vF3yEZLrl0/z+CFhmKC2GFmm74TsatJ2n/
         iAAZq4nnPqAUbGTCl0C883XqYxiunTtNcNahnhED58wW9mb7M/yz+NciZTcswRtPqt
         5whH9Jqfx4o7T0u70H4aQyx5hyjMDf5JnrvUg+BOOyjdyxJrAGE3qFXIubQ8U8maCY
         JYz8jzo1DCByg==
Date:   Sun, 1 May 2022 18:41:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jiri Valek - 2N <valek@2n.cz>,
        Colin Ian King <colin.king@intel.com>,
        Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 0/9] iio: Remove duplicated error reporting in .remove()
Message-ID: <20220501184149.10b40610@jic23-huawei>
In-Reply-To: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Sat, 30 Apr 2022 10:15:58 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
>=20
> this series adapts several i2c drivers that emit two error messages if
> something in their remove function fails. The relevant issue is that the
> i2c core emits an error message if the remove callback returns a
> non-zero value but the drivers already emit a (better) message. So
> these patches change the drivers to return 0 even after an error. Note
> there is no further error handling in the i2c core, if a remove callback
> returns an error code, the device is removed anyhow, so the only effect
> of making the return value zero is that the error message is suppressed.
>=20
> The motivation for this series is to eventually change the prototype of
> the i2c remove callback to return void. As a preparation all remove
> functions should return 0 such that changing the prototype doesn't
> change behaviour of individual drivers.

I think I'd rather have seen these called out as simply moving towards
this second change as it feels wrong to deliberately not report an error
so as to avoid repeated error messages!

Meh, I don't care that strongly and you call out the real reason in each
patch.

>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (9):
>   iio:accel:mc3230: Remove duplicated error reporting in .remove()
>   iio:accel:stk8312: Remove duplicated error reporting in .remove()
>   iio:accel:stk8ba50: Remove duplicated error reporting in .remove()
>   iio:light:bh1780: Remove duplicated error reporting in .remove()
>   iio:light:isl29028: Remove duplicated error reporting in .remove()
>   iio:light:jsa1212: Remove duplicated error reporting in .remove()
>   iio:light:opt3001: Remove duplicated error reporting in .remove()
>   iio:light:stk3310: Remove duplicated error reporting in .remove()
>   iio:light:tsl2583: Remove duplicated error reporting in .remove()
>=20
>  drivers/iio/accel/mc3230.c   | 4 +++-
>  drivers/iio/accel/stk8312.c  | 4 +++-
>  drivers/iio/accel/stk8ba50.c | 4 +++-
>  drivers/iio/light/bh1780.c   | 7 +++----
>  drivers/iio/light/isl29028.c | 4 +++-
>  drivers/iio/light/jsa1212.c  | 4 +++-
>  drivers/iio/light/opt3001.c  | 3 +--
>  drivers/iio/light/stk3310.c  | 5 ++++-
>  drivers/iio/light/tsl2583.c  | 4 +++-
>  9 files changed, 26 insertions(+), 13 deletions(-)
>=20
>=20
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17

