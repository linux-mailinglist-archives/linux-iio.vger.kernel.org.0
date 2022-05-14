Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F2A5272DC
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiENQWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiENQWM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 12:22:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB726568
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 09:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BF32B80139
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 16:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7BCC340EE;
        Sat, 14 May 2022 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652545328;
        bh=XMoMmnxxRXzbmyVFvt9hwG6Ed304NqNzsLXSemeanok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q45Kn/PlYLhgC3Lsp9qz+jlOZ0FjNCsndtBVj5bb1LrY8ZEGtVkE45baNC/BhUkJ8
         SinMTdu27+3Y0Mt2QQJrhY/NSSm/HRKdWmxRe3OJN6aw7c4QokABUVLx+F35VhIJdZ
         +vnR3xFlgEhG1fnHlDc9mDOfaF/8ldVYC/PilfQIohWJqgZvBpGAhrZ3pLgskCG+5A
         3KVaKq7xFDtSsF+s6/94nw8cr5Uk/C1UQKaLhiKzpQErPH8PHynDlhS/8nqDx0p4bq
         NDFM+HAe+0UYCaI6n1sZvliJ5XtllI4qITd43OERWVlG2vwGltE26v+OKvR/NiANRx
         bEUkatdi+X8Gg==
Date:   Sat, 14 May 2022 17:30:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Jiri Valek - 2N <valek@2n.cz>
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
        Colin Ian King <colin.king@intel.com>,
        Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 0/9] iio: Remove duplicated error reporting in .remove()
Message-ID: <20220514173044.360424f6@jic23-huawei>
In-Reply-To: <20220514134159.snmis45rx6qotppe@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
        <20220501184149.10b40610@jic23-huawei>
        <20220501185123.3ba0367b@jic23-huawei>
        <20220507153855.6174601e@jic23-huawei>
        <20220513072424.kudt3whbgpt3ryih@pengutronix.de>
        <20220514143151.52f514a0@jic23-huawei>
        <20220514134159.snmis45rx6qotppe@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Sat, 14 May 2022 15:41:59 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Jonathan,
>=20
> On Sat, May 14, 2022 at 02:31:51PM +0100, Jonathan Cameron wrote:
> > On Fri, 13 May 2022 09:24:24 +0200
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote: =20
> > > On Sat, May 07, 2022 at 03:38:55PM +0100, Jonathan Cameron wrote: =20
> > > > On Sun, 1 May 2022 18:51:23 +0100
> > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > >    =20
> > > > > On Sun, 1 May 2022 18:41:49 +0100
> > > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > > >    =20
> > > > > > On Sat, 30 Apr 2022 10:15:58 +0200
> > > > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> > > > > >      =20
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > this series adapts several i2c drivers that emit two error me=
ssages if
> > > > > > > something in their remove function fails. The relevant issue =
is that the
> > > > > > > i2c core emits an error message if the remove callback return=
s a
> > > > > > > non-zero value but the drivers already emit a (better) messag=
e. So
> > > > > > > these patches change the drivers to return 0 even after an er=
ror. Note
> > > > > > > there is no further error handling in the i2c core, if a remo=
ve callback
> > > > > > > returns an error code, the device is removed anyhow, so the o=
nly effect
> > > > > > > of making the return value zero is that the error message is =
suppressed.
> > > > > > >=20
> > > > > > > The motivation for this series is to eventually change the pr=
ototype of
> > > > > > > the i2c remove callback to return void. As a preparation all =
remove
> > > > > > > functions should return 0 such that changing the prototype do=
esn't
> > > > > > > change behaviour of individual drivers.       =20
> > > > > >=20
> > > > > > I think I'd rather have seen these called out as simply moving =
towards
> > > > > > this second change as it feels wrong to deliberately not report=
 an error
> > > > > > so as to avoid repeated error messages!
> > > > > >=20
> > > > > > Meh, I don't care that strongly and you call out the real reaso=
n in each
> > > > > > patch.     =20
> > > > >=20
> > > > > Series looks fine to me, but I'll leave the on list for a few day=
s to let
> > > > > others have time to take a look.
> > > > >=20
> > > > > Worth noting that some of these are crying out for use
> > > > > of devm_add_action_or_reset() and getting rid of the remove funct=
ions
> > > > > entirely now you've dropped the oddity of them returning non 0.
> > > > >=20
> > > > > Low hanging fruit for any newbies who want to do it, or maybe I w=
ill
> > > > > if I get bored :)   =20
> > > >=20
> > > > Series applied to the togreg branch of iio.git and pushed out as te=
sting for
> > > > 0-day to see if it can find anything we missed.   =20
> > >=20
> > > They are in testing
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=
=3Dtesting)
> > > but not in togreg
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=
=3Dtogreg).
> > >=20
> > > Not sure if that is how it's supposed to be? Only togreg seems to be =
in
> > > next. =20
> > Yup. That's intentional because I don't rebase the togreg branch unless
> > something goes wrong when it hits next.  The intent being it's a stable
> > base to build upon.  Normally there is a delay of up to a week to let
> > 0-day take a look at testing and for me to happen to get time sat at
> > the right computer, but sometimes it's longer :(
> >=20
> > Right now I'm waiting on a pull request being picked up by Greg KH,
> > after which I'll fast forward the togreg branch as I have some patches
> > waiting to be queued up that are dependent on things that have reached
> > char-misc-next via other paths. =20
>=20
> Not sure I understood that correctly. Do you let Greg pull the togreg
> branch? If you instead let him pull tags, you don't have to wait in such
> a situation to apply new patches to a for-next branch. (Or just don't
> use "togreg" for both, sending PRs to Greg and put patches into next.)

The pull request is indeed for a tag.

I could expose what is currently only out as testing to next, but that
means pushing it out as togreg.
As a general rule (the vast majority of the time) I do not rebase togreg
once I've pushed that out to kernel.org. (Testing gets rebased all the
time but hopefully the name makes it clear it's not stable!)

I need to rebase my local togreg currently to get some fixes that are
in Greg's tree, but not mine. If I do that before he's take my pull
things will look unecessarily messy in the history.

It's one of those silly corner cases where by waiting a little while
I can hide the mess under the covers :)


>=20
> > Unfortunately I'm doubtful about whether I can squeeze in a second
> > pull request this cycle, so they may get queued up for next cycle.
> > A bit of bad timing :( =20
>=20
> It's not a big problem for me. There is still much to do (also a bit in
> drivers/iio) before I tackle the final bits of my quest and actually
> change struct i2c_driver (and so depend on these patches having hit
> mainline). The only downside for you is, that you might have to endure
> me asking again for the state of these patches ;-)
>=20
> Thanks for your feedback. Compared to pinging repeatedly and getting no
> maintainer reply, knowing about your problems is much appreciated.
>=20
> Best regards and have a nice week-end,
Likewise!

Jonathan

> Uwe
>=20

