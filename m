Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B138B4C8AD0
	for <lists+linux-iio@lfdr.de>; Tue,  1 Mar 2022 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiCALcm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Mar 2022 06:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiCALcl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2022 06:32:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3F95498;
        Tue,  1 Mar 2022 03:31:49 -0800 (PST)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K7FRb6VMRz67wcQ;
        Tue,  1 Mar 2022 19:30:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 12:31:47 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Mar
 2022 11:31:46 +0000
Date:   Tue, 1 Mar 2022 11:31:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-iio@vger.kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Tomasz Duszynski" <tomasz.duszynski@octakon.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/8] PM: core: Add NS varients of
 EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and runtime pm equiv
Message-ID: <20220301113145.00004ce4@Huawei.com>
In-Reply-To: <CAJZ5v0iwFJizKf-SEr10M-8HFirMzH8=LkONLvtZ30pfEk4AOA@mail.gmail.com>
References: <20220220181522.541718-1-jic23@kernel.org>
        <20220220181522.541718-3-jic23@kernel.org>
        <6cd17744-d060-1094-098d-e30a10f96600@intel.com>
        <20220227114628.219c7055@jic23-huawei>
        <CAJZ5v0iwFJizKf-SEr10M-8HFirMzH8=LkONLvtZ30pfEk4AOA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Feb 2022 21:13:25 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Sun, Feb 27, 2022 at 12:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 21 Feb 2022 20:37:57 +0100
> > "Rafael J. Wysocki" <rafael.j.wysocki@intel.com> wrote:
> >
> > Hi Rafael,  
> > > CC: linux-pm  
> >
> > Oops. Stupid omission on my part, sorry about that!
> >  
> > >
> > > On 2/20/2022 7:15 PM, Jonathan Cameron wrote:  
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > As more drivers start to use namespaces, we need to have varients of these
> > > > useful macros that allow the export to be in a particular namespace.
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Paul Cercueil <paul@crapouillou.net>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>  
> > >
> > > I'd rather route this through linux-pm unless you have dependent changes.  
> >
> > Ok.
> >
> > The kxsd9 patch (4) is dependent on other changes queued for
> > the merge window in IIO. If we want to do it through linux-pm I'd
> > love it if we can manage to get the ground work in for the coming merge window.
> >
> > So options are:
> >
> > 1) This patch alone via linux-pm and I queue the users up for next cycle
> >    Fine by me but always awkward to have infrastructure with no users.
> > 2) First 3 patches via linux-pm so we have a user (scd30) in a low churn
> >    driver and I'll queue the rest for 5.19.  Fine by me as well.
> >    That goes on cleanly on 5.17-rc1 and there is nothing else in my review
> >    queue touching that driver.  
> 
> That would work for me.

Great.  Let's do that then.  Are you fine picking them from this thread, or
would you like me to resend with just those 3 patches as a fresh series?

> 
> > I'm also interested to hear your view on the discussion going on in reply
> > to the cover letter. Specifically Paul suggested we 'only' have the
> > namespaced versions of these macros.  
> 
> Well, I'm a bit afraid that providing the namespaced versions only
> would slow down the adoption.

Agreed, that's a concern and as Paul was happy with the route of
adding NS and perhaps looking eventually at dropping the non NS variant
I think we can move forward with this patch.

Thanks,

Jonathan


