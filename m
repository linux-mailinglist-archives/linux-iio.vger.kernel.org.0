Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F26A2AB2
	for <lists+linux-iio@lfdr.de>; Sat, 25 Feb 2023 17:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBYQWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Feb 2023 11:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBYQWM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2023 11:22:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE05CC22
        for <linux-iio@vger.kernel.org>; Sat, 25 Feb 2023 08:22:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB0860B51
        for <linux-iio@vger.kernel.org>; Sat, 25 Feb 2023 16:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A840C433EF;
        Sat, 25 Feb 2023 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677342129;
        bh=1so1HSVz0ETNHTl8zcCrxEfHypT4MW9Jll5ddDNa2XM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pPyX+1/vrCNryiHnMvBMYvsmLZaQUfpXAI+eG8GafqUiPkk6Yvn6K0oIgAN/Q+fGr
         mkqgu9p9VtPR2sIiX01kcxmm+KDLPf35uv032WCBUOe90lhFshZnQiCWMMAmiIFQxb
         1TRmzidCC2SwaJcPKsV2fB8+H95l7kIm0k2CNfeKvT1izMY1r1yvWBc9uYqRdid2nO
         rX4xCQOEgY/fO+LuZ7FYmzI6r3v5n6JGk3eMVuPYRq+RpmNxa8FxJwrtbRGTEEf6Gu
         fWoPTdHtA27PuBK7lNUbjX5kRupP5ZNuKwj83atcrO0gpVFTJ0+ZsVjsSjTyWRTXkd
         TXCD8My4KJU0Q==
Date:   Sat, 25 Feb 2023 16:36:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] iio: adc: meson_saradc: Better handle BL30 not
 releaseing the hardware
Message-ID: <20230225163632.4891019e@jic23-huawei>
In-Reply-To: <CAFBinCCF_wSt6qd125f=7wzCPm21iz6ZbJ2oHGnPNBJy30y_DA@mail.gmail.com>
References: <20230219204439.1641640-1-u.kleine-koenig@pengutronix.de>
        <CAFBinCCF_wSt6qd125f=7wzCPm21iz6ZbJ2oHGnPNBJy30y_DA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Sun, 19 Feb 2023 22:05:16 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hello Uwe,
>=20
> I think there's a typo in the subject line:
> s/releaseing/releasing/
>=20
> On Sun, Feb 19, 2023 at 9:44 PM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > meson_sar_adc_lock() might return an error if BL30 doesn't release its
> > lock on the hardware. Just returning early from .remove() is wrong
> > however as this keeps the clocks and regulators on which is never
> > cleaned up later.
> >
> > Given the BL30 not giving up its lock is a strong hint for broken
> > behaviour, and there is nothing we can do about that: Just clean up
> > ignoring the fact that we're not holding the lock.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =
=20
> Other than the typo (which maybe Jonathan can fix up while applying):
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Fixed up typo and applied to the togreg branch of iio.git.

Note I'll not push that out other than as testing until I can rebase on rc1.

Thanks,

Jonathan

>=20
>=20
> Thank you!
> Martin

