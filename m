Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792DD357037
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353530AbhDGP1j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 11:27:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2800 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353534AbhDGP1i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 11:27:38 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFp3s74z0z680TF;
        Wed,  7 Apr 2021 23:20:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 17:27:10 +0200
Received: from localhost (10.47.92.157) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 16:27:09 +0100
Date:   Wed, 7 Apr 2021 16:25:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: iio togreg branch rebase.
Message-ID: <20210407162545.000041c2@Huawei.com>
In-Reply-To: <CAHp75VcEEx8GOnBEV=U1sYAaSokpwYQBR1uA1=XQHRaza3YrmQ@mail.gmail.com>
References: <20210325191855.5bfdf0e3@jic23-huawei>
        <CAHp75VcEEx8GOnBEV=U1sYAaSokpwYQBR1uA1=XQHRaza3YrmQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.157]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021 13:10:04 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Mar 25, 2021 at 9:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > Hi All,
> >
> > Unfortunately the mess I made of building the immutable branch earlier
> > in this cycle to deal with the SCMI driver meant I'd missed some
> > fixes tags that needed updating.
> >
> > Anyhow, upshot is I only realised during last minute tests before
> > a pull request.   Had to rebase to fix, so apologies to anyone who
> > happened to be basing their trees on IIO.
> >
> > No actual code changes, but the history will be different.
> >
> > I need to redo the SCMI IB merge on top, but for now the togreg
> > branch should be good again.  
> 
> To make less impact I use --rebase-merges option for `git rebase
> --interactive ...`, so I can save as much history as possible in this
> case.
> 

Thanks!  That came in very handy this morning :)

Jonathan

> > It's likely any fixes in flight for stuff this cycle will need
> > their tags updating, but hopefully I'll spot them this time!  
> 
> 
> 

