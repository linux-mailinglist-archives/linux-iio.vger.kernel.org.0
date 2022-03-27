Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C84E884F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiC0PDJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 11:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiC0PDJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 11:03:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAF24F16
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 08:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57F361033
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 15:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FBAC340EC;
        Sun, 27 Mar 2022 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648393289;
        bh=u6fr6ldl97v51d9k4AIAYiDQiwhcP4Y1sNZK+PyWFHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I3/+5CvxC5aGLqTx6V9HLHE38yyraGRxL04dXQx7Gs8Kq/2eDgLDX8Sl2F2bRQMRM
         ctWuaEYxWScwcT5N1Ip6s8BrVWP/c6AnBIC31LTDJ05mPY2M2qbtI4KsedYuIYd+/N
         fGZAzlZHt3wtDQG9bndKZwVW/TTflja7YB9lZUfhp7uhCSJwv6xSU9VLcBHyznBO2X
         6aQquLdToMt8jnOsEadWVFHta41T09JlTfAeiinXiRekRXe8N5BuiXbc6ORfY9pNNj
         Z9Z8+EZ2Wrt+k9OnJVhZfMP2hMBPn/4yjo6gYj8Jv81e1Ou3SkJtDb4lAbaKElTItu
         wNizTNHdg7ltw==
Date:   Sun, 27 Mar 2022 16:09:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] iio: core: Print error in case sample bits do not
 fit storage bits
Message-ID: <20220327160903.63cde092@jic23-huawei>
In-Reply-To: <52553cf76f5d4c7d7224117b528d111ab7ca5ae3.camel@gmail.com>
References: <20220322111619.54808-1-marex@denx.de>
        <20220322214248.00007194@Huawei.com>
        <52553cf76f5d4c7d7224117b528d111ab7ca5ae3.camel@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Wed, 23 Mar 2022 13:05:01 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2022-03-22 at 21:42 +0000, Jonathan Cameron wrote:
> > On Tue, 22 Mar 2022 12:16:19 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >  =20
> > > Add runtime check to verify whether storagebits are at least as big
> > > as shifted realbits. This should help spot broken drivers which may
> > > set realbits + shift above storagebits.
> > >=20
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Andy Shevchenko <andy@kernel.org>
> > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
> >=20
> > Hmm. I was thinking we'd fail the probe if this happens,
> > though I guess there might be cases where we get away=20
> > (in kernel anyway) with a driver setting this wrong as
> > many drivers don't use realbits internally in an explicit
> > fashion, so maybe a message and skipping the channel is
> > the right choice...
> >=20
> > Userspace running against such a description is likely
> > to generate garbage though unless it's very lucky and
> > the spill past storage bits is into padding space and
> > the driver doesn't put anything in there (padding might
> > contain old data or similar).
> >=20
> > Either way it's a definite improvement so I'm probably fine
> > with the message and not failing the probe, (though will
> > think a bit more about it before picking this up.)
> >=20
> >=20
> > Jonathan`
> >  =20
>=20
> FWIW, if we assume we are ok with potentially some drivers starting to
> fail probe, I'm +1 on this should fail probe...

I think we are.  If anyone has messed this up the results are
pretty ugly and so good to know asap and get those drivers fixed.

I'm probably falsely hopeful that no one has messed this up because
it would normally be very easy to spot in a driver assuming there
isn't a bunch of macro magic hiding the actual value assignment.

So unless you feel strongly that it should be a warning, Marek
would you mind spinning a v3 that fails the probe by
returning an error.

Thanks,

Jonathan


>=20
> - Nuno S=C3=A1
> >  =20
> > > ---
> > > V2: Use dev_err() instead as WARN_ON() may panic() the kernel on
> > > existing machines
> > > ---
> > > =C2=A0drivers/iio/industrialio-buffer.c | 12 ++++++++++++
> > > =C2=A01 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-buffer.c
> > > b/drivers/iio/industrialio-buffer.c
> > > index b078eb2f3c9de..b5670398b06d7 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -1629,6 +1629,18 @@ static int
> > > __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (channels[i].scan_index < 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* =
Verify that sample bits fit into storage
> > > */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(channels[i].scan_type.storagebits <
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 channels[i].scan_type.realbits +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 channels[i].scan_type.shift) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(&indio_dev->dev,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0"Channel %d storagebits
> > > (%d) < shifted realbits (%d + %d)\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0i,
> > > channels[i].scan_type.storagebits,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0channels[i].scan_type.realb
> > > its,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0channels[i].scan_type.shift
> > > );
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ret =3D
> > > iio_buffer_add_channel_sysfs(indio_dev, buffer,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > &channels[i]);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (ret < 0) =20
> >  =20
>=20

