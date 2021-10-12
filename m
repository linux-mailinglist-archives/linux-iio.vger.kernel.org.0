Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BAA42AB50
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhJLR57 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 13:57:59 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:42404 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229554AbhJLR56 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 13:57:58 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A4B18182CF669;
        Tue, 12 Oct 2021 17:55:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 81F68268E45;
        Tue, 12 Oct 2021 17:55:53 +0000 (UTC)
Message-ID: <fe8a022750e911159abcac979bada51940c03d72.camel@perches.com>
Subject: Re: [PATCH] iio: buffer: Fix double-free in
 iio_buffers_alloc_sysfs_and_mask()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Tue, 12 Oct 2021 10:55:52 -0700
In-Reply-To: <CAHp75VfBXuMboFr6czRipXKfBpBNj8Syo9cvhiMXD7VaVaka+Q@mail.gmail.com>
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
         <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
         <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
         <61c28865036cd40a96f2d1bb4c27fbbb08c2d3a5.camel@perches.com>
         <CAHp75VfBXuMboFr6czRipXKfBpBNj8Syo9cvhiMXD7VaVaka+Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 81F68268E45
X-Spam-Status: No, score=-1.34
X-Stat-Signature: roa6x5szrh86r7675hp6tuxrmjnex4a3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Rn99EslbBn9uCCYRti4U8IiiQI0WsXWs=
X-HE-Tag: 1634061353-282032
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2021-10-12 at 23:48 +0300, Andy Shevchenko wrote:
> On Tue, Oct 12, 2021 at 8:43 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Tue, 2021-10-12 at 23:30 +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 12, 2021 at 2:37 PM Alexandru Ardelean
> > > <ardeleanalex@gmail.com> wrote:
> > > > 
> > > > On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
> > > > <yangyingliang@huawei.com> wrote:
> > > > > 
> > > > > When __iio_buffer_alloc_sysfs_and_mask() failed, 'unwind_idx' should be
> > > > > set to 'i - 1' to prevent double-free when cleanup resources.
> > []
> > > 
> > > I prefer to see
> > > 
> > > - for (; unwind_idx >= 0; unwind_idx--) {
> > > + while (unwind_idx--)
> > 
> > Not the same code as unwind_idx would be decremented before entering
> > the code block.
> 
> It's kinda cryptic what you are pointing out.

Not really,

> What's needed additionally is to change
> 
> - unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
> + unwind_idx = i;

You left out that 'additional change' above from your reply.

> Of course not. See above. The usual pattern is
> 
>   while (i--)
>     do_clean_item(i);

Of course, but that's not what you replied.
I was merely pointing out that your reply included a logic change
converting a loop from for to while.

cheers, Joe

