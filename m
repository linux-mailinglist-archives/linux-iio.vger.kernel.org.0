Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16DE48F786
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 16:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiAOPfK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 10:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiAOPfK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 10:35:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C4C061574;
        Sat, 15 Jan 2022 07:35:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A365060DE4;
        Sat, 15 Jan 2022 15:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEFDC36AE7;
        Sat, 15 Jan 2022 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642260909;
        bh=/VBeUKZXVWZTYhtG5JF/BtJ1VEpoQctqvNrVSZW3ftE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ec0yE40k5CG6UfEJVjP7TxLo2YkMakm6jbhxGGNus9HvzomtcZzVB2F/m8uqfcK7X
         3Lt/Wk90SRx6B2YgN+lYu2dTjhPBSd1Ga76m+XywUM0oNVm8Swp0GfgM9aArow+qa7
         1XeGHRtr/EGHN2eczUBwWPUTE4JfVThm2/22/2/qqSjiT97xr++kViOqTEfiUowqS5
         ULiNsRd8m6BDmLf1TGHtdhPlVWvGMhiavD/+Dzf4Rxo0fMartv46ebRpbzdjV9qz8n
         7bsOBTsH8opQesUelZmTa17NPx4k8k8/jV0nk2DFYR2293/4P8r7J/d/tKNzpeXas/
         pwr2BLfAktTSw==
Date:   Sat, 15 Jan 2022 15:41:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: sun4i-gpadc-iio: no temp sensor on R40
Message-ID: <20220115154052.51634f37@jic23-huawei>
In-Reply-To: <85db7e8a-2b9a-7e44-ec96-b804201a3491@wirenboard.com>
References: <20211119191456.510435-1-boger@wirenboard.com>
        <20211119191456.510435-2-boger@wirenboard.com>
        <20211122091132.yjudzei3bdqmnxq6@gilmour>
        <20211122124115.00005186@Huawei.com>
        <85db7e8a-2b9a-7e44-ec96-b804201a3491@wirenboard.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Jan 2022 16:13:02 +0300
Evgeny Boger <boger@wirenboard.com> wrote:

> 22.11.2021 15:41, Jonathan Cameron =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 22 Nov 2021 10:11:32 +0100
> > Maxime Ripard <maxime@cerno.tech> wrote:
> > =20
> >> On Fri, Nov 19, 2021 at 10:14:54PM +0300, Evgeny Boger wrote: =20
> >>> R40 SoC has touchscreen controller also serving as general-purpose AD=
C.
> >>> The hardware is very similar to A31, except that R40 has separate
> >>> calibrated thermal sensor IP (handled by sun8i_thermal).
> >>>
> >>> Despite the temperature sensor in the RTP is never mentioned in
> >>> the R40 family user manuals, it appears to be working. However,
> >>> it's not very useful as it lacks calibration data and there is another
> >>> fully functioning temperature sensor anyway.
> >>>
> >>> This patch disables the temperature sensor in RTP/GPADC IP on R40.
> >>>
> >>> The reason for disabling the temperature sensor is that the IP
> >>> needs to be switched back and forth between RTP and GPADC modes for
> >>> temperature measurements. Not only this introduces delays, but it also
> >>> disturbs external circuitry by injecting current into ADC inputs.
> >>>
> >>> Signed-off-by: Evgeny Boger <boger@wirenboard.com> =20
> >> Acked-by: Maxime Ripard <maxime@cerno.tech> =20
> > +Cc linux-iio@vger.kernel.org
> >
> > I'm fine with this and assuming Lee is happy to pick it up + send
> > me an immutable branch in case anything crosses with it this cycle..
> >
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
>=20
> Hi Jonathan!
>=20
> Is there anything else I should do to make this patch series accepted?

Perhaps try a resend to Lee Jones, making sure to cc linux-iio
Chances are it just got missed in the deluge!

Jonathan


>=20
>=20
> > Thanks,
> >
> > Jonathan
> > =20
> >> Maxime
> >> =20
>=20

