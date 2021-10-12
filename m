Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2C42AB19
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhJLRuh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 13:50:37 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:53856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230522AbhJLRuh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 13:50:37 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Oct 2021 13:50:37 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 6907D1802BAA5
        for <linux-iio@vger.kernel.org>; Tue, 12 Oct 2021 17:43:27 +0000 (UTC)
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F267B182CF669;
        Tue, 12 Oct 2021 17:43:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id D433120A29E;
        Tue, 12 Oct 2021 17:43:24 +0000 (UTC)
Message-ID: <61c28865036cd40a96f2d1bb4c27fbbb08c2d3a5.camel@perches.com>
Subject: Re: [PATCH] iio: buffer: Fix double-free in
 iio_buffers_alloc_sysfs_and_mask()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Tue, 12 Oct 2021 10:43:23 -0700
In-Reply-To: <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
         <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
         <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.07
X-Stat-Signature: z9zzireukwma57cfoj7sp1d5aw93oafd
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D433120A29E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+7/cZM/LWiim6mvI2uBZUhz4Od5CT6vMA=
X-HE-Tag: 1634060604-209060
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2021-10-12 at 23:30 +0300, Andy Shevchenko wrote:
> On Tue, Oct 12, 2021 at 2:37 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> > 
> > On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
> > <yangyingliang@huawei.com> wrote:
> > > 
> > > When __iio_buffer_alloc_sysfs_and_mask() failed, 'unwind_idx' should be
> > > set to 'i - 1' to prevent double-free when cleanup resources.
[]
> 
> I prefer to see
> 
> - for (; unwind_idx >= 0; unwind_idx--) {
> + while (unwind_idx--)

Not the same code as unwind_idx would be decremented before entering
the code block.

You'd want

	do {
		...
	} while (unwind_idx--);


