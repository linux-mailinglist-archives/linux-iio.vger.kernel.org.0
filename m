Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0061FAEC
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiKGRPD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 12:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiKGRPC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 12:15:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28C181C429
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 09:15:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1483C1FB;
        Mon,  7 Nov 2022 09:15:08 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6994E3F534;
        Mon,  7 Nov 2022 09:15:00 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:14:57 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?Q?M=C3=A5rten?= Lindahl <marten.lindahl@axis.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] iio: light: vcnl4000: Don't create sysfs PM nodes for
 child
Message-ID: <20221107171457.jkvs77atcnb2eqqn@bogus>
References: <20221101122151.221029-1-marten.lindahl@axis.com>
 <20221106152307.4bfb4e49@jic23-huawei>
 <20221107103636.bua6xd5tghuisddb@bogus>
 <20221107170857.00002464@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107170857.00002464@Huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 07, 2022 at 05:08:57PM +0000, Jonathan Cameron wrote:
> On Mon, 7 Nov 2022 10:36:36 +0000
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> > On Sun, Nov 06, 2022 at 03:23:07PM +0000, Jonathan Cameron wrote:
> > > On Tue, 1 Nov 2022 13:21:51 +0100
> > > Mårten Lindahl <marten.lindahl@axis.com> wrote:
> > >   
> > > > PM runtime is enabled for the parent i2c device, but it is disabled for
> > > > the iio child device and remains so in this driver. But as the child
> > > > sysfs PM directory is created by default by iio_device_register =>
> > > > cdev_device_add => dpm_sysfs_add it doesn't bring any value exposing it
> > > > since it won't give any usable data for the user.
> > > > 
> > > > Tell dpm_sysfs to not create the PM directory for the iio device.
> > > > 
> > > > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>  
> > > 
> > > Ah this one..  +CC Sudeep who I am sure has considered such changes in other
> > > similar cases (he did the original ones that mean this infastructure exists).
> > >  
> > 
> > Yes it was added for cache devices which are child devices of CPU devices via
> > Commit 85945c28b5a8 ("PM / core: Add support to skip power management in device/driver model")
> > 
> > Since CPU and its children are power managed quite differently(via cpuidle
> > or cpu hotplug), the new API(device_set_pm_not_required) fits the usecase
> > there well. I am not sure about this IIO usecase.
> > 
> 
> These are effectively pseudo devices for purposes of the driver model, with parents
> as the actual physical devices. As such all the PM infrastructure is associate
> with the appropriate bus specific device rather than the struct iio_dev->dev.
>

Ah if there are psuedo devices or companion like devices, then yes I agree
worth not exposing the sysfs.

> So I'm fairly sure we should just not expose the sysfs attributes.

Agreed if it is psuedo device like you mention above.

> This is similar to CXL for which they are only exposed for the PCI devices, not
> the bunch of subdevices created.
> 

OK

-- 
Regards,
Sudeep
