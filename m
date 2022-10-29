Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB26A612273
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJ2LhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ2LhL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1AE5E541
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A1660EA2
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3762DC433D6;
        Sat, 29 Oct 2022 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043429;
        bh=qXaaa4N4lKliREQo/pHNxSC1xGgbL68YG9IPm/y+CKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sxuf8OmXrZHt09Xfpu1li1sRwnrHf5+qgM2qG/hDJ2KsSVeu7V+NaReSyXiEDzNGH
         3kpGDi94b2KjmkGB3vrQstAB1lMwJVB1ErC5Dzu/2IhqWKFtXEuklf9SNwMveW24SY
         aPXel8rOUcKYO/cXbvHPZhsVuN1doZ+QFPfNlxmDg0w5tH6glhztxQn/PhORvZXW70
         UEZRJnw9/jrNNQGHu2i/8hiQHa8BAexN1hgDSnC7ykWby3P6ifaRv/t6LpXsGBtzxF
         gvtvdc/Ujk079o0arLcnY63+FS9unktkBJVmmtCrcQQDLjF7aoB0nRSX3ja14r7WDG
         odzUllMqcdDMg==
Date:   Sat, 29 Oct 2022 12:49:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Wolfram Sang <wsa@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's
 .probe_new
Message-ID: <20221029124902.510c713c@jic23-huawei>
In-Reply-To: <Y1Z5pMPrkUP64q1l@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
        <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
        <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
        <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
        <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
        <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
        <39f4b8f21f19361e2b87b581f11a348222ea3dd2.camel@gmail.com>
        <Y1Z5pMPrkUP64q1l@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Oct 2022 14:40:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Oct 24, 2022 at 12:22:19PM +0200, Nuno S=C3=A1 wrote:
> > On Mon, 2022-10-24 at 12:46 +0300, Andy Shevchenko wrote: =20
> > > On Mon, Oct 24, 2022 at 11:14:56AM +0200, Uwe Kleine-K=C3=B6nig wrote=
: =20
>=20
> ...
>=20
> > > > There is no win in postponing, is there?[1] What would be your
> > > > preferred
> > > > way to rework? =20
> > >=20
> > > My understand of the probe_new is that an attempt to unify i2c with
> > > how spi
> > > does. So, why not teach i2c_match_id() to handle this nicely for the
> > > caller?
> > >=20
> > > This will allow to leave tables where they are (or move closer to
> > > struct
> > > driver), reduce churn with the using of current i2c_match_id() as you
> > > showed the long line to get that table. This might need a new API to
> > > avoid
> > > changing many drivers at once. But it's business as usual. =20
> >=20
> > I guess something like spi_get_device_id() =20
>=20
> Right, that one I have had in mind when responding.
>=20

Agreed an i2c_client_get_device_id() seems like a good addition to me.

Jonathan
