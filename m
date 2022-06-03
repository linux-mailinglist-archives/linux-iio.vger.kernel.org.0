Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057A353CC05
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbiFCPKP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiFCPKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 11:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA2393FD
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 08:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8676A6186A
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 15:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0957C385A9;
        Fri,  3 Jun 2022 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654269012;
        bh=GNtn/MThudvT3IvHlIG1xqp6QO+1a2nZWR8RUVB2xe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UMCIL2QUFet4CLJDDIklrhoxJnm5lAqlFl34nX9Nwr+aSZfTClEWrSQ0tZUDzxZIU
         tOfeWL0kz6Yazx0arrmpZr1J0+N0knvpPm7vEYiavTnkJOcHozs0tNfK9e+XzNCrE8
         TsUh3Hs1N5DLJiS7kjSziC1BOR/LkOT84PezwgWMp4fxqQuqACjyBwrAoIFymnE577
         EM4HjzPxS/1Vf/mUmP5+Pwsbpc2jt/33qtmcjGYkiuH33d+newT64hgNHMMhsM9VFP
         Nr4CFu4O6y8235QoCgegPWdvsv+ZoHU8+s11eZutgTC6rnwJ8oRw1ssngCach1gLPc
         7v9LMtmyBYGWQ==
Date:   Fri, 3 Jun 2022 16:19:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH] io:health:afe4404: Remove duplicated error reporting in
 .remove()
Message-ID: <20220603161914.2191e4f1@jic23-huawei>
In-Reply-To: <20220603161638.604ab6b7@jic23-huawei>
References: <20220514130432.304674-1-u.kleine-koenig@pengutronix.de>
        <20220514143812.1d2325e6@jic23-huawei>
        <20220522195842.edba7snapyefug76@pengutronix.de>
        <20220603161638.604ab6b7@jic23-huawei>
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

On Fri, 3 Jun 2022 16:16:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 22 May 2022 21:58:42 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello Jonathan,
> >=20
> > On Sat, May 14, 2022 at 02:38:12PM +0100, Jonathan Cameron wrote: =20
> > > On Sat, 14 May 2022 15:04:32 +0200
> > > Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:
> > >    =20
> > > > Returning an error value in an i2c remove callback results in an er=
ror
> > > > message being emitted by the i2c core, but otherwise it doesn't mak=
e a
> > > > difference.
> > > >=20
> > > > As afe4404_remove() already emits an error message on failure and t=
he
> > > > additional error message by the i2c core doesn't add any useful
> > > > information, change the return value to zero to suppress this messa=
ge.
> > > >=20
> > > > This patch is a preparation for making i2c remove callbacks return =
void.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>   =20
> > > Applied.
> > >=20
> > > Like the others this will sit in testing until I can rebase the togreg
> > > branch.   =20
> >=20
> > Don't know if it's to late to fix already, but I just noticed we'd want
> > s/io/iio/ in the Subject line. =20
> Good spot. Fixed up as haven't pushed the tree out as non rebasing yet
> (I'm waiting as I normally rebase on rc1).
>=20

Might get delayed a little longer than that as I've just seen Greg has
sent a late pull request for char-misc (unrelated to the IIO changes),
so might need to wait a little past rc1.

Jonathan

> Jonathan
>=20
> >=20
> > Best regards
> > Uwe
> >  =20
>=20

