Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED754FC1A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 19:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiFQRUr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiFQRUp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 13:20:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAF233880
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 10:20:44 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPm3k3wPhz67M7g;
        Sat, 18 Jun 2022 01:18:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 19:20:41 +0200
Received: from localhost (10.81.209.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 18:20:40 +0100
Date:   Fri, 17 Jun 2022 18:20:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Andrea Merello <andrea.merello@gmail.com>,
        "Magnus Damm" <magnus.damm@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-staging@lists.linux.dev>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 2/2] staging: iio: imu: Add CEVA BNO08x driver
Message-ID: <20220617182037.00007469@Huawei.com>
In-Reply-To: <20220616123014.ogdutud3lsnqmexa@uno.localdomain>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
        <20220616100006.22045-3-jacopo+renesas@jmondi.org>
        <YqsFSrg+Q+jdsId/@kroah.com>
        <20220616103634.vkb7nkn555a5evlw@uno.localdomain>
        <YqsMmmqhN3WEx1Lq@kroah.com>
        <20220616123014.ogdutud3lsnqmexa@uno.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.131]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jun 2022 14:30:14 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hi Greg
> 
> On Thu, Jun 16, 2022 at 12:57:30PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 16, 2022 at 12:36:34PM +0200, Jacopo Mondi wrote:  
> > > Hi Greg
> > >
> > > On Thu, Jun 16, 2022 at 12:26:18PM +0200, Greg Kroah-Hartman wrote:  
> > > > On Thu, Jun 16, 2022 at 12:00:06PM +0200, Jacopo Mondi wrote:  
> > > > > From: Jacopo Mondi <jacopo@jmondi.org>
> > > > >
> > > > > Add support for CEVA BNO08x Sensor Hub.
> > > > >
> > > > > The BNO08X family (BNO080/85/86) is a System in Package (SiP) that
> > > > > integrates a triaxial accelerometer, triaxial gyroscope, magnetometer
> > > > > and a 32-bit ARM Cortex-M0+ microcontroller running CEVA's SH-2
> > > > > firmware.
> > > > >
> > > > > Datasheet:
> > > > > https://www.ceva-dsp.com/wp-content/uploads/2019/10/BNO080_085-Datasheet.pdf
> > > > >
> > > > > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > > > > ---
> > > > >  MAINTAINERS                             |   7 +
> > > > >  drivers/staging/iio/Kconfig             |   1 +
> > > > >  drivers/staging/iio/Makefile            |   1 +
> > > > >  drivers/staging/iio/imu/bno08x/Kconfig  |  11 +
> > > > >  drivers/staging/iio/imu/bno08x/Makefile |   3 +
> > > > >  drivers/staging/iio/imu/bno08x/bno08x.c | 618 ++++++++++++++++++++++++  
> > > >
> > > > Why are you adding a new driver to staging/iio/ and not to the real part
> > > > of the kernel?  What needs to be done to it to get it out of here?  
> > >
> > > Mostly because I don't have access to the hw development platform
> > > anymore, and the one I had was not reliable enough for any further
> > > development anyway.
> > >
> > > I went for staging as I cannot guarantee I can test any requested
> > > change on the series.
> > >
> > > I'm afraid this is a "take it or leave it" series, and as the driver
> > > does anyway work (even if for a single feature) I thought it was worth
> > > sending it upstream anyway.  
> >
> > Sure, but staging is not a dumping ground, if you want to submit it and
> > run away, I can't take it here, sorry.
> >
> > Perhaps just let this live as a patch on the mailing list and if anyone
> > else wants to pick it up and maintain it, they can do so.  
> 
> That would be fine with me. Dan already had a comment, let's see if
> Jonathan or others from the IIO subsystem have more and see what to
> do.
>

We can do a superficial review, but I'm thinking the same as Greg - maybe
just living on the mailing list until someone has hardware and can test is
the best plan long term.  Note, one option would be to emulate it. We've done
that for a few bits of hard to setup or hard to acquire hardware where we
want to be able to refactor the code.  Also because it's nice to have CI :)
Vincent's (+CC) Roadtest is great for that though this device may be a bit complex
to easily emulate.

https://lore.kernel.org/all/20220311162445.346685-1-vincent.whitchurch@axis.com/

Jonathan

> Thanks
>    j
> >
> > thanks,
> >
> > greg k-h  

