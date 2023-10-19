Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92A57CF678
	for <lists+linux-iio@lfdr.de>; Thu, 19 Oct 2023 13:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjJSLR3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Oct 2023 07:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbjJSLR2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Oct 2023 07:17:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A49115;
        Thu, 19 Oct 2023 04:17:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB4tC2sFfz6K6gc;
        Thu, 19 Oct 2023 19:16:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 12:17:23 +0100
Date:   Thu, 19 Oct 2023 12:17:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?ISO-8859-1?Q?An?= =?ISO-8859-1?Q?dr=E9?= Apitzsch 
        <git@apitzsch.eu>, Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Message-ID: <20231019121722.00007e6e@Huawei.com>
In-Reply-To: <TYCPR01MB11269269A3237CC119644F4D286D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
        <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
        <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
        <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
        <20231018204533.39399b0b@jic23-huawei>
        <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
        <TYCPR01MB11269EEF17ABCE541CC7B38CE86D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
        <TYCPR01MB11269D21D7DD5356A64E5679586D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
        <ZTD0UN4+wQjguCDF@smile.fi.intel.com>
        <TYCPR01MB11269269A3237CC119644F4D286D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Oct 2023 09:41:06 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> > Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-  
> > >pointer for data in the match tables  
> > 
> > On Thu, Oct 19, 2023 at 07:08:23AM +0000, Biju Das wrote:  
> > > > Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-  
> > 
> > ...
> >   
> > > > As mentioned in the patch.
> > > > /* If enumerated via firmware node, fix the ABI */
> > > >
> > > > Looks like this issue is not introduced by this patch.
> > > > The previous code uses device_get_match_data() which returns a match
> > > > as it uses DT node and it uses dev_name(&client->dev) instead of
> > > > id->name;
> > > >
> > > > Am I missing anything here? If it is just a test program, can it be  
> > fixed??  
> > > >
> > > > Please correct me if I am wrong.  
> > >
> > > I just realized that there is no .data in previous code for OF tables.
> > >
> > > Maybe we should add a check, if it is DT node, return id->name?
> > >
> > > Is there any API to distinguish DT node from ACPI??  
> > 
> > Of course, but I discourage people to use that, you have to have a very
> > good justification why you need it (and this case doesn't sound good enough
> > to me, or please elaborate). Hence I leave it as a homework to find those
> > APIs.  
> 
> Andre, complained that his test app is broken with this patch. I am waiting for his response whether he can fix his test app? 
> If not, we need to find a solution. One solution
> is adding a name variable and use consistent name across
> OF/ACPI/I2C tables for various devices.
> 
> Other solution is just add this check,
> 
> if (dev_fwnode(&client->dev) && !(IS_ENABLED(CONFIG_OF) && dev->of_node))
> 	name = dev_name(&client->dev);
> else
> 	name = id->name;

Given this is a userspace regression (caused by accidental "fix" - I missed
the fact it had this impact :(), I think it is valid to special case the ACPI in this rare
case but definitely needs a big fat comment saying why we are doing it and that it
should not be copied into other drivers!!!

If we can get away with fixing the original (many years old ABI misuse - but IIRC from a time
where our ABI docs were lacking) then I'm keen on doing so, but I doubt we can.
Definitely don't want to accidentally spread that bug though to new cases!

Jonathan

> 
> Cheers,
> Biju
> 

