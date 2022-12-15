Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AF64DE86
	for <lists+linux-iio@lfdr.de>; Thu, 15 Dec 2022 17:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLOQXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Dec 2022 11:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiLOQWc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Dec 2022 11:22:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBEE37FBD
        for <linux-iio@vger.kernel.org>; Thu, 15 Dec 2022 08:21:56 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NXy7z13c6z67KPR;
        Fri, 16 Dec 2022 00:18:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:21:53 +0000
Date:   Thu, 15 Dec 2022 16:21:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] IIO: More HID custom sensors
Message-ID: <20221215162152.0000693f@Huawei.com>
In-Reply-To: <nycvar.YFH.7.76.2212141819340.9000@cbobk.fhfr.pm>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
        <623f2206647e69199c64064c48eb8bf03afb99da.camel@linux.intel.com>
        <cc35bdc25daedb32dbb5949f99559485a7f83080.camel@gmx.net>
        <nycvar.YFH.7.76.2212141819340.9000@cbobk.fhfr.pm>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Wed, 14 Dec 2022 18:20:10 +0100 (CET)
Jiri Kosina <jikos@kernel.org> wrote:

> On Tue, 13 Dec 2022, Philipp Jungkamp wrote:
> 
> > Is there something I still need to do for this to be merged in the next
> > merge window?
> > 
> > I don't quite understand what would happen next. I'm curious and hope I
> > don't bother in the busy times when approaching a merge window.  
> 
> Unless Jonathan prefers to take this through iio.git for some reason, I'll 
> pick it up into hid.git for 6.3 once 6.2 merge window is over.

Probably more sensible if you pick it up through hid.git given the balance of changes.

If you can make an immutable branch even better on the off chance anything else
comes up that hits few lines changed in the IIO drivers.  I'd only pull that
into IIO if we needed to though (and I would be surprised if we do!)

Jonathan

> 
> Thanks,
> 

