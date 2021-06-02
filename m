Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7BE398D33
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhFBOi5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 10:38:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3133 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhFBOiw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 10:38:52 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FwBFv2WSNz6V0nZ;
        Wed,  2 Jun 2021 22:28:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:37:07 +0200
Received: from localhost (10.52.124.142) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 15:37:07 +0100
Date:   Wed, 2 Jun 2021 15:37:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        <linux-iio@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v3] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <20210602153706.00003bbc@Huawei.com>
In-Reply-To: <YLeUcMWM7pSRIFhO@shinobu>
References: <20210527135838.3853285-1-jarkko.nikula@linux.intel.com>
        <YLcDJ+ZI1fXRpFRe@shinobu>
        <d9dc416f-100f-3fb8-d250-3aed8ca8f10b@linux.intel.com>
        <YLeUcMWM7pSRIFhO@shinobu>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.142]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Jun 2021 23:23:44 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Jun 02, 2021 at 02:41:29PM +0300, Jarkko Nikula wrote:
> > Hi
> > 
> > On 6/2/21 7:03 AM, William Breathitt Gray wrote:  
> > > On Thu, May 27, 2021 at 04:58:38PM +0300, Jarkko Nikula wrote:  
> > >>   Documentation/ABI/testing/sysfs-bus-counter |   9 +
> > >>   drivers/counter/Kconfig                     |  10 +
> > >>   drivers/counter/Makefile                    |   1 +
> > >>   drivers/counter/intel-qep.c                 | 546 ++++++++++++++++++++
> > >>   4 files changed, 566 insertions(+)
> > >>   create mode 100644 drivers/counter/intel-qep.c  
> > > 
> > > Hi Jarkko,
> > > 
> > > I noticed the intel-qep.c file is missing an entry in the MAINTAINERS
> > > file. Would you be able to resubmit this patch with a proper entry added
> > > to MAINTAINERS so that users have the relevant contact info to reach the
> > > maintainers of this driver? You can keep my Signed-off tag on as well so
> > > that we know the code has already been reviewed.
> > >   
> > Ah, added now. I sent the update and didn't dare to add your signature 
> > due the sidenote below :-)
> > 
> > Sidenote, to my understanding Signed-off-by requires patch went through 
> > that person and Acked-by is used when maintainer accepts the patch but 
> > another person commits it with his/her Signed-off-by.
> > 
> > Jarkko  
> 
> Is that so? I'm not really sure myself of the particular nuances -- I
> wonder if there's an explanation somewhere in the Documentation files,
> or if someone else can explain it more in-depth. Regardless you've made
> all the changes I've requested so here's my Ack for your troubles. :-)
There is quite a it in https://www.kernel.org/doc/html/latest/process/submitting-patches.html
 
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 

Reviewed-by also fine for this case given I know you are the maintainer
and will only give that if happy.  Exactly what the meaning of
Acked-by / Reviewed-by when given by a maintainer is a question that
has been hotly debated a few times in the past.

Jonathan
