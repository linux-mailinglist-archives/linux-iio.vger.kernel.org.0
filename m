Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583DA4EEED0
	for <lists+linux-iio@lfdr.de>; Fri,  1 Apr 2022 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbiDAOIP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Apr 2022 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346741AbiDAOID (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2022 10:08:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDF214FB2;
        Fri,  1 Apr 2022 07:06:14 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KVMMk0Rstz67ww1;
        Fri,  1 Apr 2022 22:03:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 16:06:07 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 15:06:06 +0100
Date:   Fri, 1 Apr 2022 15:06:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-iio@vger.kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Tomasz Duszynski" <tomasz.duszynski@octakon.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/8] PM: core: Add NS varients of
 EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and runtime pm equiv
Message-ID: <20220401150604.00007acc@huawei.com>
In-Reply-To: <CAJZ5v0j47Ub=kXU5ZB_JF35xwBtUuLCwiFyEw-+B=r5z-Ac78Q@mail.gmail.com>
References: <20220220181522.541718-1-jic23@kernel.org>
        <20220220181522.541718-3-jic23@kernel.org>
        <6cd17744-d060-1094-098d-e30a10f96600@intel.com>
        <20220227114628.219c7055@jic23-huawei>
        <CAJZ5v0iwFJizKf-SEr10M-8HFirMzH8=LkONLvtZ30pfEk4AOA@mail.gmail.com>
        <20220301113145.00004ce4@Huawei.com>
        <20220330133037.000044b2@Huawei.com>
        <CAJZ5v0j47Ub=kXU5ZB_JF35xwBtUuLCwiFyEw-+B=r5z-Ac78Q@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Mar 2022 19:21:14 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> Hi Jonathan,
> 
> On Wed, Mar 30, 2022 at 2:30 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 1 Mar 2022 11:31:45 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  
> > > On Mon, 28 Feb 2022 21:13:25 +0100
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >  
> > > > On Sun, Feb 27, 2022 at 12:39 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > > >
> > > > > On Mon, 21 Feb 2022 20:37:57 +0100
> > > > > "Rafael J. Wysocki" <rafael.j.wysocki@intel.com> wrote:
> > > > >
> > > > > Hi Rafael,  
> > > > > > CC: linux-pm  
> > > > >
> > > > > Oops. Stupid omission on my part, sorry about that!
> > > > >  
> > > > > >
> > > > > > On 2/20/2022 7:15 PM, Jonathan Cameron wrote:  
> > > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > >
> > > > > > > As more drivers start to use namespaces, we need to have varients of these
> > > > > > > useful macros that allow the export to be in a particular namespace.
> > > > > > >
> > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > Cc: Paul Cercueil <paul@crapouillou.net>
> > > > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>  
> > > > > >
> > > > > > I'd rather route this through linux-pm unless you have dependent changes.  
> > > > >
> > > > > Ok.
> > > > >
> > > > > The kxsd9 patch (4) is dependent on other changes queued for
> > > > > the merge window in IIO. If we want to do it through linux-pm I'd
> > > > > love it if we can manage to get the ground work in for the coming merge window.
> > > > >
> > > > > So options are:
> > > > >
> > > > > 1) This patch alone via linux-pm and I queue the users up for next cycle
> > > > >    Fine by me but always awkward to have infrastructure with no users.
> > > > > 2) First 3 patches via linux-pm so we have a user (scd30) in a low churn
> > > > >    driver and I'll queue the rest for 5.19.  Fine by me as well.
> > > > >    That goes on cleanly on 5.17-rc1 and there is nothing else in my review
> > > > >    queue touching that driver.  
> > > >
> > > > That would work for me.  
> > >
> > > Great.  Let's do that then.  Are you fine picking them from this thread, or
> > > would you like me to resend with just those 3 patches as a fresh series?  
> > Hi Rafael,
> >
> > I've not heard back from you, so have been assuming you'd pick those first
> > 3 patches up from this series.  Is that a correct assumption?  
> 
> This was my intention, but then I lost track of them and now I can't
> find them in the linux-pm Patchwork.  Sorry about this.

My fault, I think I forgot to cc linux-pm on the initial send and
you added it in your reply.

> 
> Can you please resend just the 3 patches?

On their way.  

> 
> Thanks!

