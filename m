Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685C053CBFF
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245326AbiFCPHm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiFCPHl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 11:07:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A056FD30
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 08:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D42CCB82345
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 15:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E17C385A9;
        Fri,  3 Jun 2022 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654268857;
        bh=59NTbelirBWwsBYnPdzofxrleNSFoy2zAFd0FdXLezg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eAn4VyX+ja3LW43ESjPbCzk4hiZXCkesUYvvLSr1rsl+P2iqPreRjmpwfoDHwh/NR
         qDah8BCbd7iPicDaRCe+sjKNxLjZoMNtBwjxvRWjfuXgGWsFF9yJIsHo9Iv6Tp+h/h
         ozc7kRMhEcp6ZSykpQudYT0qYdSMVaf6fcaOS6LIxqY+ePgTs83L3BiUIyObNSFdaW
         9I1ANeYym7NUZx03bXZ4ttjMUjUOzn/iRfY8l+6OCj8PJ0/bz10TbnI9B+QQaoQq+F
         CHwRJK+FNRjyAeJOMhut6B1Pv+GnM6O4HqEbKJgx/aiA5A7lXDnynsShvUtOD/n8Oo
         SJpTVSAg2Xdkw==
Date:   Fri, 3 Jun 2022 16:16:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH] io:health:afe4404: Remove duplicated error reporting in
 .remove()
Message-ID: <20220603161638.604ab6b7@jic23-huawei>
In-Reply-To: <20220522195842.edba7snapyefug76@pengutronix.de>
References: <20220514130432.304674-1-u.kleine-koenig@pengutronix.de>
        <20220514143812.1d2325e6@jic23-huawei>
        <20220522195842.edba7snapyefug76@pengutronix.de>
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

On Sun, 22 May 2022 21:58:42 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Jonathan,
>=20
> On Sat, May 14, 2022 at 02:38:12PM +0100, Jonathan Cameron wrote:
> > On Sat, 14 May 2022 15:04:32 +0200
> > Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:
> >  =20
> > > Returning an error value in an i2c remove callback results in an error
> > > message being emitted by the i2c core, but otherwise it doesn't make a
> > > difference.
> > >=20
> > > As afe4404_remove() already emits an error message on failure and the
> > > additional error message by the i2c core doesn't add any useful
> > > information, change the return value to zero to suppress this message.
> > >=20
> > > This patch is a preparation for making i2c remove callbacks return vo=
id.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 =20
> > Applied.
> >=20
> > Like the others this will sit in testing until I can rebase the togreg
> > branch. =20
>=20
> Don't know if it's to late to fix already, but I just noticed we'd want
> s/io/iio/ in the Subject line.
Good spot. Fixed up as haven't pushed the tree out as non rebasing yet
(I'm waiting as I normally rebase on rc1).

Jonathan

>=20
> Best regards
> Uwe
>=20

