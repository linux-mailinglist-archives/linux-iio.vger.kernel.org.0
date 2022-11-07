Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8972261FA39
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 17:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiKGQol convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 7 Nov 2022 11:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiKGQoh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 11:44:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0081F2F6
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 08:44:35 -0800 (PST)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N5cTT1vzvz67y8F;
        Tue,  8 Nov 2022 00:42:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:44:33 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 16:44:32 +0000
Date:   Mon, 7 Nov 2022 16:44:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marten Lindahl <martenli@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>,
        =?ISO-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>
Subject: Re: [PATCH v3 0/2] Add ps_it attributes for vcnl4040
Message-ID: <20221107164431.00005c22@Huawei.com>
In-Reply-To: <Y2i4KmJ0Bd+WdWay@axis.com>
References: <20220926091900.1724105-1-marten.lindahl@axis.com>
        <Y2i4KmJ0Bd+WdWay@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Mon, 7 Nov 2022 08:47:54 +0100
Marten Lindahl <martenli@axis.com> wrote:

> On Mon, Sep 26, 2022 at 11:18:58AM +0200, Mårten Lindahl wrote:
> > Currently there is no way for userspace to make any configuration of
> > the VCNL4040 sensors, but only the sensor readings are exported in
> > sysfs. To support configuration for proximity integration time value,
> > sysfs attributes for this needs to be exported.
> > 
> > To begin with the runtime power management turns both sensors (ALS, and
> > PS) on before reading the sensor register values and then switches
> > them off again. But when doing so it writes the whole register instead
> > of just switching the power on/off bit. This needs to be fixed in order
> > to make other persistent configurations.
> > 
> > Kind regards
> > Mårten Lindahl  
> 
> Hi!
> 
> I suspect this mail may have slipped through unnoticed since there has
> not been any comments on it. v2 had some minor comments which I hope I
> fixed.
> 
> Jonathan?

It's queued up. Not sure why I failed to send an email though - I'll probably
find it's in my outbox on the other laptop or something equally silly.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/drivers/iio/light/vcnl4000.c?h=testing&id=1a09d52bf0cab10580ab52f04f8b182f279be455

Jonathan

> 
> Kind regards
> Mårten
> 
> > 
> > Changes in v3:
> >  - Rename defines for ALS/PS shutdown bits
> >  - Add local variable for building register value
> > 
> > Changes in v2:
> >  - Removed unnecessary switch for chip id
> >  - Guard read/write sequence against potential race
> >  - Remove confusing boolean operation
> >  - Use bitmask macros instead of local field shifting
> >  - Use .read_avail callback instead of using IIO_CONST_ATTR
> >  - Skip [PATCH 2/3] iio: light: vcnl4000: Add enable attributes for vcnl4040
> > 
> > Mårten Lindahl (2):
> >   iio: light: vcnl4000: Preserve conf bits when toggle power
> >   iio: light: vcnl4000: Add ps_it attributes for vcnl4040
> > 
> >  drivers/iio/light/vcnl4000.c | 185 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 179 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.30.2
> >   

