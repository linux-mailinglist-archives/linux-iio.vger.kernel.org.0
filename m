Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451DA54DF95
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376262AbiFPK5g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 06:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiFPK5f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 06:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8E2BF2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 03:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9AF6187C
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 10:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FEFC34114;
        Thu, 16 Jun 2022 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655377052;
        bh=PODDCeCXTaW9rLJySVY7geTdl3v1DBymlxMXX+ClqH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcSumZbwoGnGKZuc6giE/N4ilqHIDvBLF8XLD41qmFOFlZpFqR3TS8v/nFplsr9iB
         soQH0DG60yljqQyxy4gx++d4auxG480quCmVzt9jp13rFwqCszJgQxLGvlYET+8+Wy
         ElvS5FC02Sar+rfvYP59ZqSFOCsyXznsH0JhwxNE=
Date:   Thu, 16 Jun 2022 12:57:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: iio: imu: Add CEVA BNO08x driver
Message-ID: <YqsMmmqhN3WEx1Lq@kroah.com>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
 <20220616100006.22045-3-jacopo+renesas@jmondi.org>
 <YqsFSrg+Q+jdsId/@kroah.com>
 <20220616103634.vkb7nkn555a5evlw@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616103634.vkb7nkn555a5evlw@uno.localdomain>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 16, 2022 at 12:36:34PM +0200, Jacopo Mondi wrote:
> Hi Greg
> 
> On Thu, Jun 16, 2022 at 12:26:18PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 16, 2022 at 12:00:06PM +0200, Jacopo Mondi wrote:
> > > From: Jacopo Mondi <jacopo@jmondi.org>
> > >
> > > Add support for CEVA BNO08x Sensor Hub.
> > >
> > > The BNO08X family (BNO080/85/86) is a System in Package (SiP) that
> > > integrates a triaxial accelerometer, triaxial gyroscope, magnetometer
> > > and a 32-bit ARM Cortex-M0+ microcontroller running CEVA's SH-2
> > > firmware.
> > >
> > > Datasheet:
> > > https://www.ceva-dsp.com/wp-content/uploads/2019/10/BNO080_085-Datasheet.pdf
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > > ---
> > >  MAINTAINERS                             |   7 +
> > >  drivers/staging/iio/Kconfig             |   1 +
> > >  drivers/staging/iio/Makefile            |   1 +
> > >  drivers/staging/iio/imu/bno08x/Kconfig  |  11 +
> > >  drivers/staging/iio/imu/bno08x/Makefile |   3 +
> > >  drivers/staging/iio/imu/bno08x/bno08x.c | 618 ++++++++++++++++++++++++
> >
> > Why are you adding a new driver to staging/iio/ and not to the real part
> > of the kernel?  What needs to be done to it to get it out of here?
> 
> Mostly because I don't have access to the hw development platform
> anymore, and the one I had was not reliable enough for any further
> development anyway.
> 
> I went for staging as I cannot guarantee I can test any requested
> change on the series.
> 
> I'm afraid this is a "take it or leave it" series, and as the driver
> does anyway work (even if for a single feature) I thought it was worth
> sending it upstream anyway.

Sure, but staging is not a dumping ground, if you want to submit it and
run away, I can't take it here, sorry.

Perhaps just let this live as a patch on the mailing list and if anyone
else wants to pick it up and maintain it, they can do so.

thanks,

greg k-h
