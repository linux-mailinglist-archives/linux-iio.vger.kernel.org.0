Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4254DF36
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 12:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiFPKgk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 06:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiFPKgk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 06:36:40 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930D5C87A
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 03:36:39 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 02CD8C0005;
        Thu, 16 Jun 2022 10:36:35 +0000 (UTC)
Date:   Thu, 16 Jun 2022 12:36:34 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: iio: imu: Add CEVA BNO08x driver
Message-ID: <20220616103634.vkb7nkn555a5evlw@uno.localdomain>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
 <20220616100006.22045-3-jacopo+renesas@jmondi.org>
 <YqsFSrg+Q+jdsId/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqsFSrg+Q+jdsId/@kroah.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Greg

On Thu, Jun 16, 2022 at 12:26:18PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 16, 2022 at 12:00:06PM +0200, Jacopo Mondi wrote:
> > From: Jacopo Mondi <jacopo@jmondi.org>
> >
> > Add support for CEVA BNO08x Sensor Hub.
> >
> > The BNO08X family (BNO080/85/86) is a System in Package (SiP) that
> > integrates a triaxial accelerometer, triaxial gyroscope, magnetometer
> > and a 32-bit ARM Cortex-M0+ microcontroller running CEVA's SH-2
> > firmware.
> >
> > Datasheet:
> > https://www.ceva-dsp.com/wp-content/uploads/2019/10/BNO080_085-Datasheet.pdf
> >
> > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > ---
> >  MAINTAINERS                             |   7 +
> >  drivers/staging/iio/Kconfig             |   1 +
> >  drivers/staging/iio/Makefile            |   1 +
> >  drivers/staging/iio/imu/bno08x/Kconfig  |  11 +
> >  drivers/staging/iio/imu/bno08x/Makefile |   3 +
> >  drivers/staging/iio/imu/bno08x/bno08x.c | 618 ++++++++++++++++++++++++
>
> Why are you adding a new driver to staging/iio/ and not to the real part
> of the kernel?  What needs to be done to it to get it out of here?

Mostly because I don't have access to the hw development platform
anymore, and the one I had was not reliable enough for any further
development anyway.

I went for staging as I cannot guarantee I can test any requested
change on the series.

I'm afraid this is a "take it or leave it" series, and as the driver
does anyway work (even if for a single feature) I thought it was worth
sending it upstream anyway.

>
> I'd prefer that we not add any new iio drivers if at all possible,
> please fix them up properly and merge them to the correct location.
>
> thanks,
>
> greg k-h
