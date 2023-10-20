Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30727D1246
	for <lists+linux-iio@lfdr.de>; Fri, 20 Oct 2023 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377601AbjJTPKQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Oct 2023 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377578AbjJTPKP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Oct 2023 11:10:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA32BD52;
        Fri, 20 Oct 2023 08:10:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SBnxz6Rxtz6K6DS;
        Fri, 20 Oct 2023 23:07:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 20 Oct
 2023 16:10:05 +0100
Date:   Fri, 20 Oct 2023 16:10:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
CC:     =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Message-ID: <20231020161004.00001fd5@Huawei.com>
In-Reply-To: <TYCPR01MB11269399FE198E67DAD1CA6F986DBA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
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
        <6191b1a5e4891fda992f6c0d57ea8f101429428a.camel@apitzsch.eu>
        <TYCPR01MB11269399FE198E67DAD1CA6F986DBA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Oct 2023 07:39:38 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Andre,
> 
> > Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-  
> > >pointer for data in the match tables  
> > 
> > Am Donnerstag, dem 19.10.2023 um 09:41 +0000 schrieb Biju Das:  
> > > > Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert
> > > > enum-  
> > > > > pointer for data in the match tables  
> > > >
> > > > On Thu, Oct 19, 2023 at 07:08:23AM +0000, Biju Das wrote:  
> > > > > > Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert
> > > > > > enum-  
> > > >
> > > > ...
> > > >  
> > > > > > As mentioned in the patch.
> > > > > > /* If enumerated via firmware node, fix the ABI */
> > > > > >
> > > > > > Looks like this issue is not introduced by this patch.
> > > > > > The previous code uses device_get_match_data() which returns a
> > > > > > match as it uses DT node and it uses dev_name(&client->dev)
> > > > > > instead of
> > > > > > id->name;
> > > > > >
> > > > > > Am I missing anything here? If it is just a test program, can it
> > > > > > be  
> > > > fixed??  
> > > > > >
> > > > > > Please correct me if I am wrong.  
> > > > >
> > > > > I just realized that there is no .data in previous code for OF
> > > > > tables.
> > > > >
> > > > > Maybe we should add a check, if it is DT node, return id->name?
> > > > >
> > > > > Is there any API to distinguish DT node from ACPI??  
> > > >
> > > > Of course, but I discourage people to use that, you have to have a
> > > > very good justification why you need it (and this case doesn't sound
> > > > good enough to me, or please elaborate). Hence I leave it as a
> > > > homework to find those APIs.  
> > >
> > > Andre, complained that his test app is broken with this patch. I am
> > > waiting for his response whether he can fix his test app?
> > > If not, we need to find a solution. One solution is adding a name
> > > variable and use consistent name across OF/ACPI/I2C tables for various
> > > devices.  
> > 
> > Just to make it clear, the functionality of the test application
> > (hwtest) is not affected by this patch. Only a less/none telling name is
> > shown now in the Model column of its output.
> > 
> > I'm not that familiar with the interfaces provided by the kernel. Is there
> > another way to get the device name if not from for example
> > 
> > /sys/bus/iio/devices/iio:device2/name
> > 
> > (which now shows '0-000d' instead of 'ak09911')
> > 
> > For the bmi160 device[1] the following code is used to get the name
> > 
> > 	if (id)
> > 		name = id->name;
> > 	else
> > 		name = dev_name(&client->dev);  
> 
> This looks good, but what about introducing a new api to get device names for
> fwnodes. (strip vendor from compatible for OF and use name from ACPI id table)??
> So that driver don't depend upon I2C ID to get device names for fw nodes??

ACPI Ids are normally irrelevant stuff we should not have userspace care about.
The correctly assigned ones have to be assigned by a vendor with appropriate
base ID. That isn't necessarily anything to do with the hardware or even
the same vendor. If I want to provide ACPI support for a device and
the device vendor either doesn't have an ACPI manufacturer ID or is ignoring
me I can (after some internal proceses) get a hisilicon one as HISIXXXX
for example.

That lack of meaning (unlike compatibles) is why we normally push the name into
a structure in the driver that is then looked up - hence giving us a meaningful
part number.

Note this is for correctly assigned ACPI ids. There are lots of device vendors
who do it wrong and ship products where the name matches the part number
despite that not being a registered ACPI vendor ID. Where we have contacts
we moan at them and try and get this fixed in updated firmware, where we
don't we sometime add the ID to the kernel tables.
I'll add that this mess is typically from consumer device manufacturers.
If I tried that garbage in a server, there is no way I'd get it upstream,
it would be considered a firmware bug that we'd have to get our firmware
team to fix.

Jonathan


> 
> Cheers,
> Biju

