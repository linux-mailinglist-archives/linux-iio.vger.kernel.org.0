Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7621261FAC1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 18:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiKGRE1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 12:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiKGREZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 12:04:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B02911817
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 09:04:20 -0800 (PST)
Received: from frapeml500004.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N5csx5JCbz67QRR;
        Tue,  8 Nov 2022 01:00:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500004.china.huawei.com (7.182.85.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 18:04:17 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 17:04:17 +0000
Date:   Mon, 7 Nov 2022 17:04:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gwendal Grignou <gwendal@chromium.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Jordi Torres" <majosamaso@gmail.com>
Subject: Re: [PATCH] iio: proximity: sx9360: Add a new ACPI hardware ID
Message-ID: <20221107170416.00004b94@Huawei.com>
In-Reply-To: <CAPUE2ut0z6QrMh778hPFpLYrw_nft_ky-ye3ZrwNXTBVgxPZYQ@mail.gmail.com>
References: <20221105225157.10081-1-gwendal@chromium.org>
        <20221106163200.7f889ade@jic23-huawei>
        <CAPUE2ut0z6QrMh778hPFpLYrw_nft_ky-ye3ZrwNXTBVgxPZYQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Nov 2022 20:28:22 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Sun, Nov 6, 2022 at 8:32 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat,  5 Nov 2022 15:51:57 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >  
> > > From
> > > https://treexy.com/products/driver-fusion/database/sensors/semtech/sx9360-proximity/
> > >
> > > sx9360 SAR sensor can be presented with ACPI ID SAMM0208.
> > >
> > > Reported-by: Jordi Torres <majosamaso@gmail.com>
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > ---
> > >  drivers/iio/proximity/sx9360.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> > > index d9a12e6be6ca6..4ebc5784aa6d9 100644
> > > --- a/drivers/iio/proximity/sx9360.c
> > > +++ b/drivers/iio/proximity/sx9360.c
> > > @@ -865,6 +865,7 @@ static SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
> > >
> > >  static const struct acpi_device_id sx9360_acpi_match[] = {
> > >       { "STH9360", SX9360_WHOAMI_VALUE },
> > > +     { "SAMM0208", SX9360_WHOAMI_VALUE },  
> >
> > SAMM doesn't immediately seem to be a valid ACPI vendor ID.
> > Anyone have a path to poke people to do this right or confirm whose ID that one is?
> >
> > Reality is we'll have to live with it, but I like to complain first in vague hope that
> > people will one day play by the rules!  
> Sorry for not having checked UEFI DB first. You are not the only one
> to complain: https://andy-shev.dreamwidth.org/151340.html
> >  Given semtech has a PNP ID (STH is valid)
> > I'm not sure why someone would use an ACPI ID that doesn't seem to be (unless it
> > is very recent and no one has updated the DB on uefi.org yet).  
> uefi.org says the last update is 2/14/2020, but that's not correct,
> some entries have been added in 2021:
> https://uefi.org/ACPI_ID_List?search=SECC

Time to use the fact I have a members account...
There are some more approved ones that aren't on that list yet but not SAMM as
far as I can find by looking through relevant approval threads.

> 
> From http://www.alsa-project.org/db/?f=6196fa05fcd368166cdeee8b0509be7ca64166ee,
> the sensor is present on device NT950QED from Samsung
> 
> From https://www.samsung.com/sec/galaxybook/galaxy-book2-pro-360-nt950qed-kc71g/NT950QED-KC71G/,
> that device is a Samsung Galaxy Book 2 360.
> 
> Surprisingly, Samsung does not have an ACPI ID defined, but does have
> a PNP ID (SAM). It may have been an uncontrolled spelling mistake.

Given you can always (almost?) use a PNP ID where you can use an ACPI one,
lots of companies don't bother with both.  

You are probably right on typo (or maybe extended by someone who didn't
realize you shouldn't do that).   I've had my moan, so I'll pick this up
when I'm on the right computer.

Jonathan


> 
> From https://treexy.com/products/driver-fusion/database/sensors/semtech/,
> Semtech sensors do appear under names different from STH.
> 
> Gwendal.
> 
> >
> > Jonathan
> >
> >  
> > >       { }
> > >  };
> > >  MODULE_DEVICE_TABLE(acpi, sx9360_acpi_match);  
> >  

