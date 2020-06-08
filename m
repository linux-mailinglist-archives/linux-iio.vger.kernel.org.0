Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2DC1F173C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgFHLJa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 07:09:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729439AbgFHLJ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 07:09:29 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 53537D8BE93D230426A4;
        Mon,  8 Jun 2020 12:09:27 +0100 (IST)
Received: from localhost (10.47.27.61) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 8 Jun 2020
 12:09:26 +0100
Date:   Mon, 8 Jun 2020 12:08:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
CC:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200608120843.00007870@Huawei.com>
In-Reply-To: <CACG_h5qG7xU0kL1-Hn8q4S338ESAzz4qjN56Z8Bfi9ekYRTTzg@mail.gmail.com>
References: <20200316124929.GA389@syed.domain.name>
        <20200318020506.GA45571@icarus>
        <20200322175831.74e10aa7@archlinux>
        <CACG_h5qctM0S2buQHHNnJ_qVY6YY2wYruj9aTKH9RiJ=9_LfoQ@mail.gmail.com>
        <20200404150633.2421decd@archlinux>
        <CACG_h5o=V_y33krqojmANnqG+Uf7FJmOVmkY-MGZ+zLJR+Q2YQ@mail.gmail.com>
        <20200607040850.GA80713@shinobu>
        <CACG_h5qG7xU0kL1-Hn8q4S338ESAzz4qjN56Z8Bfi9ekYRTTzg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.61]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Jun 2020 11:00:53 +0530
Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> On Sun, Jun 7, 2020 at 9:39 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > On Sun, Jun 07, 2020 at 09:28:40AM +0530, Syed Nayyar Waris wrote:  
> > > On Sat, Apr 4, 2020 at 7:36 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >
> > > > On Mon, 30 Mar 2020 23:54:32 +0530
> > > > Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > >  
> > > > > Hi Jonathan
> > > > >  
> > > > > >Looks good.  I'm not sure right now which tree I'll take this through
> > > > > >(depends on whether it looks like we'll get an rc8 and hence I can sneak
> > > > > >it in for the coming merge window or not).
> > > > > >
> > > > > >So poke me if I seem to have forgotten to apply this in a week or so.  
> > > > >
> > > > > Gentle Reminder.
> > > > > Thanks !
> > > > > Syed Nayyar Waris  
> > > >
> > > > Thanks.  I've applied it to the fixes-togreg branch of iio.git which will go
> > > > upstream after the merge window closes.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >  
> > >
> > > HI Jonathan,
> > >
> > > I think only the patch [1/3] has been applied. Patches [2/3] and [3/3] have not.
> > >
> > > The three patches were:
> > > https://lore.kernel.org/patchwork/patch/1210135/
> > > https://lore.kernel.org/patchwork/patch/1210136/
> > > https://lore.kernel.org/patchwork/patch/1210137/
> > >
> > > The last 2 patches need to be applied, I think.
> > >
> > > Regards
> > > Syed Nayyar Waris  
> >
> > Just a heads-up: the relevant bugs are present in the 5.7 release so it
> > would be prudent to tag those two patches with respective Fixes lines.
> >
> > William Breathitt Gray  
> 
> Mentioning below, the 'Fixes' tags just for reference:
> For patch [2/3]: counter: 104-quad-8: Add lock guards - differential encoder.
> Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential
> Encoder Cable Status")
> 
> For patch [3/3]: counter: 104-quad-8: Add lock guards - filter clock prescaler.
> Fixes: 9b74dddf79be ("counter: 104-quad-8: Support Filter Clock Prescaler")
> 
> I have replied on the v5 patches [2/3] and [3/3] with the (above)
> 'Fixes' tags. I have added the tags in the message.
> 
> I think that was what you meant.
> 
Gah. I lost them.   I feel slightly less guilty though because they aren't
all in a thread so are scattered randomly in my email.

Please keep a given version of a patch set in a single thread.  git will
do this by default unless you've specifically told it not to...

Ideally always use a cover letter as well except for single patch patch sets.

I'll sort these next time I'm on the right computer.

Jonathan

> Regards
> Syed Nayyar Waris


