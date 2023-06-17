Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98409734332
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jun 2023 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjFQSva (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jun 2023 14:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFQSva (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jun 2023 14:51:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9819A3
        for <linux-iio@vger.kernel.org>; Sat, 17 Jun 2023 11:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A591460F38
        for <linux-iio@vger.kernel.org>; Sat, 17 Jun 2023 18:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D54AC433C8;
        Sat, 17 Jun 2023 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687027888;
        bh=06UD9g0l0YXvCz5XEdG9zzLF5eFs6oj1uYlz1+MyNfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qQbVwl4xC07vDsJdPaO1df5ZlgYtgfUEJ+9hkdXUI/SPoLulSHcQqCxMUUcskNWqc
         9aYl23A6zrdE3xgiMBTF87wJWKOiqhQuoYWYNRey2+EsLNo/5zu2OAf6ZLGZR9t2YX
         m2tRnV/eapG7C36QnmfGKB9RMpVXIuIsBc5aL9fxZ8ElmbxVe+royLQZwhxviuq6NR
         l2BcRwJtphh7J+HWUH6qUpI5kjQp0Ga66lZGRq95To+C6PS6yZ8OJGDTE5v+UVCH46
         OGIsKuQFxvD6vXeoGtwo/k6Z1nUlMctlcfzKqRi6BtBjBzWTkyDu62NHKupiFAYShc
         L+SrML7h2HICw==
Date:   Sat, 17 Jun 2023 19:51:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
        INV Git Commit <INV.git-commit@tdk.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 0/4] Factorize timestamp module
Message-ID: <20230617195122.484ad61d@jic23-huawei>
In-Reply-To: <20230608115740.00007695@Huawei.com>
References: <20230606162147.79667-1-inv.git-commit@tdk.com>
        <ZIAjFMhJbnndgL-G@surfacebook>
        <FR3P281MB17572FE25C24840A4030315ACE53A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
        <CAHp75Vd+VK2B=rjYitXSDhHxbbyUNxNpvD1KgrsB=3sBxk6Pkg@mail.gmail.com>
        <20230608115740.00007695@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Jun 2023 11:57:40 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 7 Jun 2023 17:44:39 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Wed, Jun 7, 2023 at 12:28=E2=80=AFPM Jean-Baptiste Maneyrol
> > <Jean-Baptiste.Maneyrol@tdk.com> wrote: =20
> > >
> > > Hello Andy,
> > >
> > > really sorry, I forgot to do that. I'm still not very familiar with a=
ll the details of the process, sorry.   =20
> >=20
> > Understand.
> >  =20
> > > I will send a new v3 with the Reviewed-by tag. Is it OK like this?   =
=20
> >=20
> > I believe no need to resend right now as I can simply repeat it here
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com> =20
>=20
> That works for me ;)
>=20
> Thanks Andy.
Applied to the togreg branch of iio.git.  However note that these aren't
going to make the coming merge window so will only be pushed out as testing=
 until
I can rebase on rc1.

Thanks,

Jonathan

>=20
> > But next time be more careful.
> >=20
> > And thank you for what you are doing!
> >  =20
> > > Thanks a lot, and sorry again.   =20
> >  =20
> > > From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>
> > > Sent: Wednesday, June 7, 2023 08:26
> > > To: INV Git Commit <INV.git-commit@tdk.com>
> > > Cc: jic23@kernel.org <jic23@kernel.org>; linux-iio@vger.kernel.org <l=
inux-iio@vger.kernel.org>; lars@metafoo.de <lars@metafoo.de>; Jean-Baptiste=
 Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > > Subject: Re: [PATCH v2 0/4] Factorize timestamp module
> > >
> > > [CAUTION] This is an EXTERNAL email. Do not click links or open attac=
hments unless you recognize the sender and know the content is safe.
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Tue, Jun 06, 2023 at 04:21:43PM +0000, inv.git-commit@tdk.com kirjoit=
ti:   =20
> > > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > > >
> > > > The purpose if this series is to make timestamping from
> > > > inv_icm42600 driver an independent module and use it for both
> > > > inv_icm42600 and inv_mpu6050 drivers.
> > > >
> > > > Create a new inv_sensors_timestamp common module based on
> > > > inv_icm42600 driver and use it in the 2 drivers.
> > > >
> > > > WARNING: this patch requires following commit in fixes-togreg
> > > > bbaae0c79ebd ("iio: imu: inv_icm42600: fix timestamp reset")   =20
> > >   =20
> > > > Changelog
> > > > - v2: do some headers cleanup and add some justifications in
> > > >       the patches descriptions.   =20
> > >
> > > What I haven't noticed is my tag. It's your responsibility to add giv=
en tag and
> > > it's polite to Cc to the reviewers (but this will imply by the tag an=
yway in
> > > this case).
> > >
> > > Any explanation why did you do so?
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >   =20
> >=20
> >  =20
>=20

