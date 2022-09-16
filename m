Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2945BB038
	for <lists+linux-iio@lfdr.de>; Fri, 16 Sep 2022 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIPPau convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 16 Sep 2022 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIPPat (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Sep 2022 11:30:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9305AC75
        for <linux-iio@vger.kernel.org>; Fri, 16 Sep 2022 08:30:49 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MTdFh6xV9z67MnF;
        Fri, 16 Sep 2022 23:26:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 17:30:47 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 16:30:46 +0100
Date:   Fri, 16 Sep 2022 16:30:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2] ad5593r fix read protocol
Message-ID: <20220916163043.000059b3@huawei.com>
In-Reply-To: <d3d6ee8fdbbcf78a4b8b7f93bc8a417c811be18a.camel@gmail.com>
References: <20220913073413.140475-1-nuno.sa@analog.com>
        <20220915153836.7f8ef80e@jic23-huawei>
        <d3d6ee8fdbbcf78a4b8b7f93bc8a417c811be18a.camel@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Fri, 16 Sep 2022 08:05:29 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Thu, 2022-09-15 at 15:38 +0100, Jonathan Cameron wrote:
> > On Tue, 13 Sep 2022 09:34:11 +0200
> > Nuno Sá <nuno.sa@analog.com> wrote:
> >   
> > > This patchset fixes the read protocol since it needs a STOP
> > > condition
> > > between address write and data read.
> > > 
> > > The second change is trivial and only adds an i2c functionality
> > > check.  
> > 
> > Given we are late in the cycle, I've queued this up for the next
> > merge
> > window, with a stable tag for the first paatch so it'll get
> > backported
> > after the merge window.
> > 
> >   
> 
> Alright. BTW, not sure If I already asked this but do you have any
> preference with regards to CCing stable? Should I have done it when
> submitting or do you prefer to handle it yourself?

Generally I prefer submitters to not tag for stable and let me make that
decision.  Often I'll decide to not tag because I'm a little worried
about a fix and want it to be in mainline a little while before we
backport.  I don't mind people sending explicit backport requests
though once it's soaked a bit.

Mind you, these days the scripts that check for possible fixes
often pick these up before I've gotten to sending a backport
request. Sometimes I send a note when that happens to ask for
it to soak longer, but mostly the delay is enough that I'm happy
the patch got enough soaking before that happens.

Occasionally I just forget to tag with stable. If that happens
then I'm fine with a request to pick it up being sent out once
it is upstream!

Jonathan

> 
> - Nuno Sá
> 
> 

