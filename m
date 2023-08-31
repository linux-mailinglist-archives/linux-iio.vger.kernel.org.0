Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE478E95F
	for <lists+linux-iio@lfdr.de>; Thu, 31 Aug 2023 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHaJ2Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 31 Aug 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243949AbjHaJ2Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Aug 2023 05:28:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E57CF4
        for <linux-iio@vger.kernel.org>; Thu, 31 Aug 2023 02:28:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rbwm66j6nz6HJjk;
        Thu, 31 Aug 2023 17:27:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 10:28:08 +0100
Date:   Thu, 31 Aug 2023 10:28:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Nuno Sa <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>
Subject: Re: [RFC PATCH 0/3] Add converter framework
Message-ID: <20230831102806.000026cd@Huawei.com>
In-Reply-To: <d4eead3eedb99e252f7c022ce5572a3a307b9b1e.camel@gmail.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
        <20230830172903.0000027f@Huawei.com>
        <d4eead3eedb99e252f7c022ce5572a3a307b9b1e.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Aug 2023 10:20:20 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Wed, 2023-08-30 at 17:29 +0100, Jonathan Cameron wrote:
> > On Fri, 4 Aug 2023 16:53:38 +0200
> > Nuno Sa <nuno.sa@analog.com> wrote:
> >   
> > > This is the initial RFC following the discussion in [1]. I'm aware this is
> > > by no means ready for inclusion and it's not even compilable since in
> > > the RFC I did not included the patch to add component_compare_fwnode()
> > > and component_release_fwnode().   
> > 
> > Whilst I haven't read this through yet, I suspect Olivier will be able to
> > offer some insight on some of this and likewise you may be able to
> > point out pitfalls etc in his series (I see you did some review already :)
> > 
> > https://lore.kernel.org/linux-iio/20230727150324.1157933-1-olivier.moysan@foss.st.com/
> > 
> > Both are about multiple interacting components of an overall datapath.
> > Whether there is commonality isn't yet clear to me.
> >   
> 
> I made a very general comment in that series but I need to look better at it. Not
> sure if we can merge them together but let's see...

Great. I wasn't sure either!  If nothing else more cross review is always
good even if we decide we need two frameworks.

My one takeaway from looking at this is I need to understand the component
framework better and do some messing around with simple cases before I'll
be confident on how this works.  Maybe we can get some input from developers
of that framework on future versions?

Jonathan
