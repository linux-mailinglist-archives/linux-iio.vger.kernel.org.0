Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15B061FAD8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 18:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiKGRJF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 7 Nov 2022 12:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKGRJB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 12:09:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026414D1A
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 09:09:00 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N5d1f3nmYz67NY6;
        Tue,  8 Nov 2022 01:06:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 18:08:58 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 17:08:58 +0000
Date:   Mon, 7 Nov 2022 17:08:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        =?ISO-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH] iio: light: vcnl4000: Don't create sysfs PM nodes for
 child
Message-ID: <20221107170857.00002464@Huawei.com>
In-Reply-To: <20221107103636.bua6xd5tghuisddb@bogus>
References: <20221101122151.221029-1-marten.lindahl@axis.com>
        <20221106152307.4bfb4e49@jic23-huawei>
        <20221107103636.bua6xd5tghuisddb@bogus>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
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

On Mon, 7 Nov 2022 10:36:36 +0000
Sudeep Holla <sudeep.holla@arm.com> wrote:

> On Sun, Nov 06, 2022 at 03:23:07PM +0000, Jonathan Cameron wrote:
> > On Tue, 1 Nov 2022 13:21:51 +0100
> > Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >   
> > > PM runtime is enabled for the parent i2c device, but it is disabled for
> > > the iio child device and remains so in this driver. But as the child
> > > sysfs PM directory is created by default by iio_device_register =>
> > > cdev_device_add => dpm_sysfs_add it doesn't bring any value exposing it
> > > since it won't give any usable data for the user.
> > > 
> > > Tell dpm_sysfs to not create the PM directory for the iio device.
> > > 
> > > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>  
> > 
> > Ah this one..  +CC Sudeep who I am sure has considered such changes in other
> > similar cases (he did the original ones that mean this infastructure exists).
> >  
> 
> Yes it was added for cache devices which are child devices of CPU devices via
> Commit 85945c28b5a8 ("PM / core: Add support to skip power management in device/driver model")
> 
> Since CPU and its children are power managed quite differently(via cpuidle
> or cpu hotplug), the new API(device_set_pm_not_required) fits the usecase
> there well. I am not sure about this IIO usecase.
> 

These are effectively pseudo devices for purposes of the driver model, with parents
as the actual physical devices. As such all the PM infrastructure is associate
with the appropriate bus specific device rather than the struct iio_dev->dev.

So I'm fairly sure we should just not expose the sysfs attributes.
This is similar to CXL for which they are only exposed for the PCI devices, not
the bunch of subdevices created.

Jonathan
