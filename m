Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE459AD88
	for <lists+linux-iio@lfdr.de>; Sat, 20 Aug 2022 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbiHTLey (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Aug 2022 07:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344262AbiHTLex (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Aug 2022 07:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC1979D5
        for <linux-iio@vger.kernel.org>; Sat, 20 Aug 2022 04:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACA9D611D1
        for <linux-iio@vger.kernel.org>; Sat, 20 Aug 2022 11:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABD9C433C1;
        Sat, 20 Aug 2022 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660995291;
        bh=236kViLHFRYrFtRHGk5/TMO7rNY0F54rP9cAcSmBB3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U+ehez5nulYo1IwSf1wJzGkrdRp2ojyFd73F6tAYgJ9TljejNqEGzwyIbnLp5KITi
         VDxqLm/Bh4PFrxlgyIpncIUiiH9kKOyGegfq5cjton335rRMEtDuHojFC1kviGQx9c
         gSTfx3MKgkgeI06xyjReyXU6rWTDisl0LxD9zydmuxOhH1odtbRL1fMSAmXGv7XqsW
         ptgKeeQ696x5eWxuOzUIv4tG2CG4c1qI41mGxtCUV9NT3gBFO03ZpdFnMzc5G7yDtJ
         S/1EGMOBav2xafyeLkz7fwWVBJqbNC6EH5lIMR+xLqTNG4sAevC2MYv/Bf6nSWICUG
         n0PAByhoClklw==
Date:   Sat, 20 Aug 2022 12:45:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 11/13] iio: frequency: admv1013: Benefit from
 devm_clk_get_enabled() to simplify
Message-ID: <20220820124525.7da6a49c@jic23-huawei>
In-Reply-To: <CAHp75VdkeckbaoLj7kyDdiy=BLo6WAaRsPCc+Ue2hwwBHCbNug@mail.gmail.com>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
        <20220808204740.307667-11-u.kleine-koenig@pengutronix.de>
        <20220813173706.1cb77958@jic23-huawei>
        <CAHp75VdkeckbaoLj7kyDdiy=BLo6WAaRsPCc+Ue2hwwBHCbNug@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Aug 2022 22:04:35 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 13, 2022 at 7:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon,  8 Aug 2022 22:47:38 +0200
> > Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:
> > =20
> > > Make use of devm_clk_get_enabled() to replace some code that effectiv=
ely
> > > open codes this new function.
> > >
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 =20
> > Looks fine to me, but there is a subtle reordering + it does even more
> > non parsing stuff in a function called _parse.
> >
> > Anyhow, would like Antoniu or someone else from ADI to take a quick loo=
k if
> > possible before I pick this one up. =20
>=20
> ...
>=20
> > > -     st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> > > +     st->clkin =3D devm_clk_get_enabled(&spi->dev, "lo_in");
> > >       if (IS_ERR(st->clkin))
> > >               return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> > >                                    "failed to get the LO input clock\=
n"); =20
>=20
> So it seems better to drop above and...
>=20
> > > -     ret =3D clk_prepare_enable(st->clkin);
> > > -     if (ret)
> > > -             return ret;
> > > -
> > > -     ret =3D devm_add_action_or_reset(&spi->dev, admv1013_clk_disabl=
e, st->clkin);
> > > -     if (ret)
> > > -             return ret; =20
>=20
> ...put a call here. This will make parse() look more parse.
>=20
Agreed. I was thinking we actually did something (like get the rate) inbetw=
een but
there isn't anything like that.

Whilst it's sort of true that a devm_clk_get_enabled() is part of the firmw=
are
parsing, that's also true of the regulators that are already outside that f=
unction.
Hence the rearrangement Andy suggests makes sense to me.

Thanks,

Jonathan

