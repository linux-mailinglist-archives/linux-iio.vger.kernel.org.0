Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA8C5FF131
	for <lists+linux-iio@lfdr.de>; Fri, 14 Oct 2022 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJNPXR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 14 Oct 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiJNPWw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2022 11:22:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA1B7F4A
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2022 08:22:28 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpqpB4bcPz67FSP;
        Fri, 14 Oct 2022 23:20:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 17:21:25 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 16:21:24 +0100
Date:   Fri, 14 Oct 2022 16:21:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <linux-imx@nxp.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Jyoti Bhayana" <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 3/4] iio: health: max30102: do not use internal
 iio_dev lock
Message-ID: <20221014162123.00000420@huawei.com>
In-Reply-To: <fccf3f41b32e881eb79ee78852fa40a62b134c00.camel@gmail.com>
References: <20221012151620.1725215-1-nuno.sa@analog.com>
        <20221012151620.1725215-4-nuno.sa@analog.com>
        <20221012204556.7648df2e@xps-13>
        <fccf3f41b32e881eb79ee78852fa40a62b134c00.camel@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Fri, 14 Oct 2022 09:25:59 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Wed, 2022-10-12 at 20:45 +0200, Miquel Raynal wrote:
> > Hi Nuno,
> > 
> > nuno.sa@analog.com wrote on Wed, 12 Oct 2022 17:16:19 +0200:
> >   
> > > The pattern used in this device does not quite fit in the
> > > iio_device_claim_direct_mode() typical usage. In this case, we want
> > > to
> > > know if we are in buffered mode or not to know if the device is
> > > powered
> > > (buffer mode) or not. And depending on that max30102_get_temp()
> > > will
> > > power on the device if needed. Hence, in order to keep the same
> > > functionality, we try to:
> > > 
> > > 1. Claim Buffered mode;
> > > 2: If 1) succeeds call max30102_get_temp() without powering on the
> > >    device;
> > > 3: Release Buffered mode;
> > > 4: If 1) fails, Claim Direct mode;
> > > 5: If 4) succeeds call max30102_get_temp() with powering on the
> > > device;
> > > 6: Release Direct mode;
> > > 7: If 4) fails, goto to 1) and try again.
> > > 
> > > This dance between buffered and direct mode is not particularly
> > > pretty
> > > (as well as the loop introduced by the goto statement) but it does
> > > allow
> > > us to get rid of the mlock usage while keeping the same behavior.  
> > 
> > What about adding a TODO comment saying something like: "this comes
> > from static analysis and helped dropping mlock access, but someone
> > with
> > the device needs to figure out if we can simplify this dance"?
> > Because
> > the reason behind all this is that we don't want to risk breaking the
> > driver, but perhaps a simpler approach would work, right?
> >   
> 
> Hi Miquel,
> 
> AFAIU, either the device is powered (when buffer mode enabled) and we
> can do the reading or it's not and we need to power it on/off
> "manually" while making sure we don't race against enable/disabling
> buffers. This "dance" is needed mainly to make sure that we grab
> 'mlock' one way or another... The other way would be to use some
> specific device lock together with a flag (as discussed) but as
> discussed with Jonathan we decided to go down this road... So,
> honestly, I don't really see the necessity of "marking" this code with
> a TODO but of course if someone comes in with something simpler, great
> :).

Agreed.  I don't expect to see any improvement in this in the future
so a TODO would just be noise and might encourage people to propose
the 'get the lock on it's own function' that we are going through this
dance to avoid adding.

Jonathan

> 
> Anyways, as I said, I'm not really keen in spinning a new version to
> add this comment so I will defer the decision to Jonathan :)  
> 
> Thanks for the help!
> - Nuno Sá
> 

