Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123596E3214
	for <lists+linux-iio@lfdr.de>; Sat, 15 Apr 2023 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDOPUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Apr 2023 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDOPUv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Apr 2023 11:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC673C11
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 08:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3082603F7
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 15:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E729C433EF;
        Sat, 15 Apr 2023 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681572048;
        bh=ClyZVPK6rpue/2Mw5K3gJs7mBW1F3/aYu+M1A/FQ7aM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lhObwP0UTeN+6fGGVu3l3tx90Ja8iJSDf1xOAaqVYsajt2vLrO9qFAUpQpZip7Y82
         hrrDQAAKSCQr4VSvgEZGiv2Qw63nFGuE4CbtVwRNCAn15sEBledQ8GBvxmFG5LYG14
         nHiels4USrwGRxAqaAAGfm5ixXoqBSYQmOSpfpwfO6mTJYeWEvsuc2eZSa3chaDhvy
         RhgBXGYoTxtCrQ6w2TyJ+XLbTNyITIXcU8CZHJHr+O4uly6nthLZTyqD3yLO+1SydW
         AtGZwZkg6hHby01gBnjDaI9ANU0dxsR3JW1Zeu1cSd3GBXLvP1SYgfRXGdwB/PL1CO
         G86k+aRBCoc5w==
Date:   Sat, 15 Apr 2023 16:20:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: tmag5273: Fix runtime PM leak on measurement error
Message-ID: <20230415162049.25566ce3@jic23-huawei>
In-Reply-To: <8d5256ae-3b06-aadd-de5c-73105cb91d74@wolfvision.net>
References: <20230414013752.498767-1-lars@metafoo.de>
        <ce69fcd4ed928cf5cb47847235826668e9b61beb.camel@gmail.com>
        <8d5256ae-3b06-aadd-de5c-73105cb91d74@wolfvision.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Apr 2023 12:17:36 +0200
Gerald Loacker <gerald.loacker@wolfvision.net> wrote:

> Am 14.04.2023 um 07:57 schrieb Nuno S=C3=A1:
> > On Thu, 2023-04-13 at 18:37 -0700, Lars-Peter Clausen wrote: =20
> >> The tmag5273 gets a runtime PM reference before reading a measurement
> >> and
> >> releases it when done. But if the measurement fails the
> >> tmag5273_read_raw()
> >> function exits before releasing the reference.
> >>
> >> Make sure that this error path also releases the runtime PM
> >> reference.
> >>
> >> Fixes: 866a1389174b ("iio: magnetometer: add ti tmag5273 driver")
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >> --- =20
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >  =20
>=20
> Acked-by: Gerald Loacker <gerald.loacker@wolfvision.net>
Applied to the fixes-togreg branch of iio.git.

I'm not going to rush this in before the merge window. It might
even wait until after rc1 as it would have had any time in linux-next
before I send final pull request for the merge window.=20

Jonathan

>=20
> >> =C2=A0drivers/iio/magnetometer/tmag5273.c | 5 +++--
> >> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/magnetometer/tmag5273.c
> >> b/drivers/iio/magnetometer/tmag5273.c
> >> index 28bb7efe8df8..e155a75b3cd2 100644
> >> --- a/drivers/iio/magnetometer/tmag5273.c
> >> +++ b/drivers/iio/magnetometer/tmag5273.c
> >> @@ -296,12 +296,13 @@ static int tmag5273_read_raw(struct iio_dev
> >> *indio_dev,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return ret;
> >> =C2=A0
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D tmag5273_get_measure(data, &t, &x, &y, &=
z,
> >> &angle, &magnitude);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret)
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ret;
> >> =C2=A0
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pm_runtime_mark_last_busy(data->dev);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pm_runtime_put_autosuspend(data->dev);
> >> =C2=A0
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ret;
> >> +
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (chan->address) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0case TEMPERATURE:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
*val =3D t; =20
> >  =20

