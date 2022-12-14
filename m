Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90264C5D8
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 10:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiLNJ1r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 14 Dec 2022 04:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLNJ1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 04:27:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7337A21271
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 01:27:13 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NX90j6x4Rz6H7Ht;
        Wed, 14 Dec 2022 17:24:05 +0800 (CST)
Received: from localhost (10.81.204.207) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 09:27:10 +0000
Date:   Wed, 14 Dec 2022 09:27:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
CC:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] IIO: More HID custom sensors
Message-ID: <20221214092707.0000046e@Huawei.com>
In-Reply-To: <cc35bdc25daedb32dbb5949f99559485a7f83080.camel@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
        <623f2206647e69199c64064c48eb8bf03afb99da.camel@linux.intel.com>
        <cc35bdc25daedb32dbb5949f99559485a7f83080.camel@gmx.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.204.207]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Tue, 13 Dec 2022 23:51:50 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Hello,
> 
> Is there something I still need to do for this to be merged in the next
> merge window?
> 
> I don't quite understand what would happen next. I'm curious and hope I
> don't bother in the busy times when approaching a merge window.
Given most of this is in HID, up to Jiri to pick it up when happy with it.

Has all the other responses I think it needs.  You are absolutely correct
to ping it given it's been a few weeks.

Jonathan
> 
> Regards,
> Philipp Jungkamp
> 
> On Sun, 2022-11-27 at 09:33 -0800, srinivas pandruvada wrote:
> > On Fri, 2022-11-25 at 00:38 +0100, Philipp Jungkamp wrote:  
> > > Hello,
> > > 
> > > I'm sorry for the confusion caused by me sending revisions as
> > > replies.
> > > I've now addresses the points raised. As I'm unfamiliar with
> > > mailing
> > > lists
> > > any recommendation on making the process more seamless is welcome.
> > > 
> > > Thank you for your time!
> > >   
> > 
> > For the series
> > 
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> >   
> > > v2:
> > > - Patch 1/4:
> > >   - Remove unnecessary comments.
> > >   - Change return type of functions to bool. (introduced an error,
> > > fixed in v4)
> > >   - Swallows return value of a function. (fixed in v4)
> > > - Patch 2/4:
> > >   - Create this 'noop' patch that just adds the LISS sensors to the
> > > custom
> > >     sensor match table.
> > > - Patch 3/4:
> > >   - Remove some unnecessary newlines in function calls.
> > > - Patch 4/4:
> > >   - Allow for 1 byte human presence reports.
> > > 
> > > v3:
> > > - Patch 2/4
> > >   - Add missing 'Signed-Off-By'
> > > 
> > > v4:
> > > - Patch 1/4:
> > >   - Fix return value and error codes on property query.
> > >   - Document and ignore return values for queries of optionally
> > > matched
> > >     properties.
> > >   - Don't modify *known in _get_known, return error when not
> > > matched.
> > >   - Remove comment on newly added sensors from commit message.
> > > - Patch 4/4:
> > >   - Clean up switch statement.
> > > 
> > > Regards,
> > > Philipp Jungkamp
> > > 
> > > Philipp Jungkamp (4):
> > >   HID: hid-sensor-custom: Allow more custom iio sensors
> > >   HID: hid-sensor-custom: Add LISS custom sensors
> > >   IIO: hid-sensor-als: Use generic usage
> > >   IIO: hid-sensor-prox: Use generic usage
> > > 
> > >  drivers/hid/hid-sensor-custom.c     | 233 +++++++++++++++++++-----
> > > ----
> > >  drivers/iio/light/hid-sensor-als.c  |  27 ++--
> > >  drivers/iio/light/hid-sensor-prox.c |  37 +++--
> > >  include/linux/hid-sensor-ids.h      |   1 +
> > >  4 files changed, 199 insertions(+), 99 deletions(-)
> > > 
> > > --
> > > 2.38.1
> > >   
> > 
> >   
> 

