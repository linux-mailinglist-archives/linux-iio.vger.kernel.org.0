Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1016259C8FA
	for <lists+linux-iio@lfdr.de>; Mon, 22 Aug 2022 21:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiHVTe1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Aug 2022 15:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbiHVTeX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2022 15:34:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDDADAD;
        Mon, 22 Aug 2022 12:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3C5EB818B8;
        Mon, 22 Aug 2022 19:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB1AC433D7;
        Mon, 22 Aug 2022 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661196859;
        bh=zgjk7hxjYBSH2/TkdSD1wgIOQi7oZA1Ywc+Z1t41FHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c9d3uADeMkfhYhKYIlIRBUA7KrnbYlwFNkcFrJWP8mZnzwTPIHyVSO615oV2JmTNV
         zCl4wKaLm/IaWATF4c6MrY4Bj4xPNov30v0aUu5HXmzt/K2F3y2s40zlTgmtkRIoX3
         LE0LGU42EbYi5WnEH2gVZqeJHVu5sQ+Et8M7Griz7TPqbPyniNj7Duu1rHaq1Nt3T7
         stzCxMvRfJRaZE3R0jXhfkeQlrTtbWIwmtkvlZgFOmb0sr2rpZZFXdzMVlfVj1eSup
         ahl2fJgnSJTQqgCo5RzZ+7QArMld+rmh2y9AsvwhCkTCb7eONfQLTx18K+gp2BPX0n
         qr66o2gH2uLqA==
Date:   Mon, 22 Aug 2022 19:59:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/5] PM: Introduce EXPORT_NS_GPL_DEV_PM_OPS() and use
 cases in IIO.
Message-ID: <20220822195950.1b1249c2@jic23-huawei>
In-Reply-To: <CACRpkdb6qxO38kS1=cEja-KZSR5RcV-oWX36ikxggsLm8Y5ixw@mail.gmail.com>
References: <20220807192038.1039771-1-jic23@kernel.org>
        <CACRpkdb6qxO38kS1=cEja-KZSR5RcV-oWX36ikxggsLm8Y5ixw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Aug 2022 11:04:18 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Aug 7, 2022 at 9:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Perhaps the most complex case we can have is a core driver module (usually
> > with accompanying per bus modules) that exports, in a namespace,
> > a struct dev_pm_ops. The driver has different handling for runtime and
> > sleep suspend / resume so (almost) all callbacks are provided.
> > The pm.h helper macro _EXPORT_DEV_PM_OPS() could be used here but the
> > handling of the last two parameters is unusual and very different from
> > the macros intended for driver usage. First parameter needs to be "_gpl"
> > and second needs to be the namespace specified as a string.  Other NS
> > macros take it without quotes.
> >
> > As such, this series proposes introducing a suitable macro and then provides
> > a number of IIO driver conversions. Where relevant the exports from the
> > driver are moved into the new namespace.
> >
> > If accepted we can either take the whole lot through the PM tree and hope
> > there is nothing much else overlapping with this driver code in this cycle,
> > or ideally we could use an immutable branch and pull this into both the
> > IIO and PM trees.
> >
> > Jonathan Cameron (5):
> >   PM: core: Add EXPORT_NS_GPL_DEV_PM_OPS to avoid drivers rolling own.
> >   iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
> >   iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
> >   iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
> >   iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace  
> 
> I like what you done here.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Unfortunately change of plan because the EXPORT_NS_GPL_DEV_PM_OPS isn't
general enough to cover some cases elsewhere.
https://lore.kernel.org/all/20220808174107.38676-2-paul@crapouillou.net/

I'll switch this series over to being based on that which will be
a large enough change that I'll probably not pick up any tags given on
this version.

Thanks

Jonathan


> 
> Yours,
> Linus Walleij

