Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEDC43234A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhJRPvB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 11:51:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4000 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhJRPvA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 11:51:00 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HY1Qc2Nfmz689PY;
        Mon, 18 Oct 2021 23:44:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 17:48:48 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 16:48:47 +0100
Date:   Mon, 18 Oct 2021 16:48:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "William Breathitt Gray" <vilhelm.gray@gmail.com>
Subject: Re: [PULL] 1st set of counter subsystem new features for the 5.16
 cycle.
Message-ID: <20211018164846.0000470b@Huawei.com>
In-Reply-To: <YW2WjGuci2d+gK5L@kroah.com>
References: <20211017112717.1c1d8779@jic23-huawei>
        <YW2WjGuci2d+gK5L@kroah.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Oct 2021 17:45:16 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Oct 17, 2021 at 11:27:17AM +0100, Jonathan Cameron wrote:
> > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > 
> >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/counter-for-5.16a
> > 
> > for you to fetch changes up to c9638a65d7982b5069a500cc5c504e7a7faa2676:  
> 
> I get the following error when trying to push this from my scripts:
> 
> Commit: 50cda7cc4ab1 ("counter: fix docum. build problems after filename change")
> 	Fixes tag: Fixes: d70e46af7531 ("counter: Internalize sysfs interface code")
> 	Has these problem(s):
> 	        - Target SHA1 does not exist
> 
> Was this caused by rebasing?
> 
> thanks,
> 
> greg k-h

Almost certainly.  I remember checking the IIO pull but guess I forgot to run
the test script on the Counter one.  Will tidy up and resend.

Thanks,

Jonathan
