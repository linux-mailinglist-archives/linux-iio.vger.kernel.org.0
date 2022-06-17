Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355D254FC01
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiFQRPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiFQRPd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 13:15:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595D915FEF
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 10:15:31 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPlzT2cVLz6857p;
        Sat, 18 Jun 2022 01:15:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 19:15:29 +0200
Received: from localhost (10.81.209.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 18:15:28 +0100
Date:   Fri, 17 Jun 2022 18:15:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Sangannavar, Mallikarjunappa\" <mallikarjunappa.sangannavar@intel.com>, T R"@domain.invalid,
        "Thejesh Reddy <thejesh.reddy.t.r@intel.com>"@domain.invalid
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
Message-ID: <20220617181526.0000067b@Huawei.com>
In-Reply-To: <YqyJslf2UsM32xRP@fedora>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
        <YqyJslf2UsM32xRP@fedora>
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

On Fri, 17 Jun 2022 10:03:30 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> On Fri, Jun 17, 2022 at 06:37:14AM +0000, N, Pandith wrote:
> > Hi,
> > 
> > We have a Intel Timed IO peripheral with following functionalities :
> > 
> > 1. Event capture capability - Captures event count and timestamp.
> > 2. Pulse generation - periodic or single event generation.
> > 3. Return cross-timestamp on request.
> > 
> > Timed IO device is being used in various Industrial use cases such as : time capture, synchronization, fan speed calculation etc.
> > 
> > IIO or counter subsystem seems to be suitable for timed-io driver.
> > 
> > Is it favourable to implement as part of IIO or counter subsystem ? Wanted to know your feedback.
> > 
> > We may need to use custom ABI for sysfs based user interaction OR
> > Can we enhance ioctl interface to accommodate our use case (counter-chardev.c) ?
> > Since timed-io works in nano second precision, ioctl is more suitable.
> > 
> > Regards,
> > Pandith and Sowjanya
> > 
> > ps : resent the mail with plain text as delivery to linux-iio@vger.kernel.org failed.  
> 
> Hello Pandith and Sowjanya,
> 
> What you are describing sounds similar to what counter-chardev.c tries
> to solve (i.e. Counter events with timestamps). Would you elaborate more
> on how this device works and what you are trying to accomplish with it?
> 
> For example, when you refer to an "event count and timestamp", does
> count here mean the internal device hardware timestamp or is this the
> Linux system timestamp? Does "pulse generation" refer to capturing the
> count on some physical line signal, or is this a device-internal timer
> countdown trigger event? Is "cross-timestamp" referring to a difference
> calculation between two count events?
> 
> Thanks,
> 
> William Breathitt Gray
> 

If there is any chance of some docs access it might cut down people trying to
interpret what "Captures event count and timestamp" means! :) That could be
read as encoder type cases or it could be read as single event capture.

As you've discovered, the boundaries can get rather blurred!

Jonathan
