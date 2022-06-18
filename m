Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADB2550618
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiFRQVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 12:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRQVd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 12:21:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71094DF1D
        for <linux-iio@vger.kernel.org>; Sat, 18 Jun 2022 09:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B762B80AF6
        for <linux-iio@vger.kernel.org>; Sat, 18 Jun 2022 16:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F2DC3411A;
        Sat, 18 Jun 2022 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655569289;
        bh=pB1ca7jnm3xzVJDPXmUQpOMmoftw0uVUDDBqV4XRGzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VvEgiGG0rm7qE2N8ccUWdgtXkz+F5DbqYbnVbuoK0joU4hDG7Jc2TQphk7xFTN35E
         2YUXapyR3Qq1RMwwEA6MUrAnymgLIDpPFBS3Ez+BoNCD/v2ZfokOj/q4fOInnC1Ak/
         P/BsFby4ZJX/p+tK8mV0F0wE+VWMnWm6OKDQ5xQUbW4rz2lyZkxrRErxwijQBnLD6N
         ++0/wIbkGqOqkG9PxxwVEfwnulgaGXALALRcuXuXmR9AuAx8ry5XrxF1cx5iHRkwNG
         6FSsSzTDcuOJqqGxc1xlAPnh0rdxF6I6q1h3staDcd7sI4+NpyhGl50kI9pMRmgLyi
         50fUfBkD0Oq0w==
Date:   Sat, 18 Jun 2022 17:30:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2] iio: accel: mma8452: ignore the return value of
 reset operation
Message-ID: <20220618173046.234ccce5@jic23-huawei>
In-Reply-To: <AM0PR04MB400175936806774093E463F590AC9@AM0PR04MB4001.eurprd04.prod.outlook.com>
References: <1655292718-14287-1-git-send-email-haibo.chen@nxp.com>
        <8690f687-8f9d-b03f-226f-3a289e718ed5@redhat.com>
        <20220615221552.0d8afb3b@jic23-huawei>
        <AM0PR04MB400175936806774093E463F590AC9@AM0PR04MB4001.eurprd04.prod.outlook.com>
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

On Thu, 16 Jun 2022 01:34:03 +0000
Bough Chen <haibo.chen@nxp.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: 2022=E5=B9=B46=E6=9C=8816=E6=97=A5 5:16
> > To: Hans de Goede <hdegoede@redhat.com>
> > Cc: Bough Chen <haibo.chen@nxp.com>; lars@metafoo.de;
> > linux-iio@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2] iio: accel: mma8452: ignore the return value of=
 reset
> > operation
> >=20
> > On Wed, 15 Jun 2022 18:10:47 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >  =20
> > > Hi,
> > >
> > > On 6/15/22 13:31, haibo.chen@nxp.com wrote: =20
> > > > From: Haibo Chen <haibo.chen@nxp.com>
> > > >
> > > > On fxls8471, after set the reset bit, the device will reset
> > > > immediately, will not give ACK. So ignore the return value of this
> > > > reset operation, let the following code logic to check whether the =
reset =20
> > operation works. =20
> > > >
> > > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com> =20
> > >
> > > Thanks, patch looks good to me:
> > >
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com> =20
> > Looks very much like a fix to me, so fixes tag please.
> > As it's otherwise good, just sending the tag in reply to this message w=
ill be fine. =20
>=20
> Thanks for your quick review.
>=20
> Fixes: ecabae713196 ("iio: mma8452: Initialise before activating")
Perfect.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> Best Regards
> Bough Chen
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > >
> > > Regards,
> > >
> > > Hans
> > >
> > >
> > > =20
> > > > ---
> > > >  drivers/iio/accel/mma8452.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/accel/mma8452.c
> > > > b/drivers/iio/accel/mma8452.c index e0f0c0abed28..c7d9ca96dbaa
> > > > 100644
> > > > --- a/drivers/iio/accel/mma8452.c
> > > > +++ b/drivers/iio/accel/mma8452.c
> > > > @@ -1511,10 +1511,14 @@ static int mma8452_reset(struct i2c_client =
=20
> > *client) =20
> > > >  	int i;
> > > >  	int ret;
> > > >
> > > > -	ret =3D i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
> > > > +	/*
> > > > +	 * Find on fxls8471, after config reset bit, it reset immediately,
> > > > +	 * and will not give ACK, so here do not check the return value.
> > > > +	 * The following code will read the reset register, and check whe=
ther
> > > > +	 * this reset works.
> > > > +	 */
> > > > +	i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG2,
> > > >  					MMA8452_CTRL_REG2_RST);
> > > > -	if (ret < 0)
> > > > -		return ret;
> > > >
> > > >  	for (i =3D 0; i < 10; i++) {
> > > >  		usleep_range(100, 200); =20
> > > =20
>=20

