Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E054E0CC
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 14:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiFPMaV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376910AbiFPMaU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 08:30:20 -0400
X-Greylist: delayed 8985 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 05:30:19 PDT
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C94DF7E
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 05:30:19 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 90CB7E0004;
        Thu, 16 Jun 2022 12:30:15 +0000 (UTC)
Date:   Thu, 16 Jun 2022 14:30:14 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: iio: imu: Add CEVA BNO08x driver
Message-ID: <20220616123014.ogdutud3lsnqmexa@uno.localdomain>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
 <20220616100006.22045-3-jacopo+renesas@jmondi.org>
 <YqsFSrg+Q+jdsId/@kroah.com>
 <20220616103634.vkb7nkn555a5evlw@uno.localdomain>
 <YqsMmmqhN3WEx1Lq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqsMmmqhN3WEx1Lq@kroah.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Greg

On Thu, Jun 16, 2022 at 12:57:30PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 16, 2022 at 12:36:34PM +0200, Jacopo Mondi wrote:
> > Hi Greg
> >
> > On Thu, Jun 16, 2022 at 12:26:18PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jun 16, 2022 at 12:00:06PM +0200, Jacopo Mondi wrote:
> > > > From: Jacopo Mondi <jacopo@jmondi.org>
> > > >
> > > > Add support for CEVA BNO08x Sensor Hub.
> > > >
> > > > The BNO08X family (BNO080/85/86) is a System in Package (SiP) that
> > > > integrates a triaxial accelerometer, triaxial gyroscope, magnetometer
> > > > and a 32-bit ARM Cortex-M0+ microcontroller running CEVA's SH-2
> > > > firmware.
> > > >
> > > > Datasheet:
> > > > https://www.ceva-dsp.com/wp-content/uploads/2019/10/BNO080_085-Datasheet.pdf
> > > >
> > > > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > > > ---
> > > >  MAINTAINERS                             |   7 +
> > > >  drivers/staging/iio/Kconfig             |   1 +
> > > >  drivers/staging/iio/Makefile            |   1 +
> > > >  drivers/staging/iio/imu/bno08x/Kconfig  |  11 +
> > > >  drivers/staging/iio/imu/bno08x/Makefile |   3 +
> > > >  drivers/staging/iio/imu/bno08x/bno08x.c | 618 ++++++++++++++++++++++++
> > >
> > > Why are you adding a new driver to staging/iio/ and not to the real part
> > > of the kernel?  What needs to be done to it to get it out of here?
> >
> > Mostly because I don't have access to the hw development platform
> > anymore, and the one I had was not reliable enough for any further
> > development anyway.
> >
> > I went for staging as I cannot guarantee I can test any requested
> > change on the series.
> >
> > I'm afraid this is a "take it or leave it" series, and as the driver
> > does anyway work (even if for a single feature) I thought it was worth
> > sending it upstream anyway.
>
> Sure, but staging is not a dumping ground, if you want to submit it and
> run away, I can't take it here, sorry.
>
> Perhaps just let this live as a patch on the mailing list and if anyone
> else wants to pick it up and maintain it, they can do so.

That would be fine with me. Dan already had a comment, let's see if
Jonathan or others from the IIO subsystem have more and see what to
do.

Thanks
   j
>
> thanks,
>
> greg k-h
