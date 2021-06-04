Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D535D39B4CE
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFDI1X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 4 Jun 2021 04:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhFDI1W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Jun 2021 04:27:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBB96140F;
        Fri,  4 Jun 2021 08:25:34 +0000 (UTC)
Date:   Fri, 4 Jun 2021 09:27:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-iio@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: General kernel misuse of vsnprintf SPECIAL %#<foo> (was: Re:
 [PATCH v2 0/4] iio: Drop use of %hhx and %hx format strings)
Message-ID: <20210604092720.5b59319b@jic23-huawei>
In-Reply-To: <7a7e5cf61177b168f465f2502fde7a1e04293063.camel@perches.com>
References: <20210603180612.3635250-1-jic23@kernel.org>
        <9499203f1e993872b384aabdec59ac223a8ab931.camel@perches.com>
        <20210603202546.0d12e7ad@jic23-huawei>
        <7a7e5cf61177b168f465f2502fde7a1e04293063.camel@perches.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 03 Jun 2021 12:34:28 -0700
Joe Perches <joe@perches.com> wrote:

> On Thu, 2021-06-03 at 20:25 +0100, Jonathan Cameron wrote:
> > On Thu, 03 Jun 2021 11:58:15 -0700 Joe Perches <joe@perches.com> wrote:  
> > > It looks to me as though %#<foo> is relatively commonly misused in the kernel.
> > > 
> > > Pehaps for the decimal portion of the format, checkpatch could have some
> > > test for use of non-standard lengths.
> > > 
> > > Given the use is generally meant for a u8, u16, u32, or u64, perhaps
> > > checkpatch should emit a warning whenever the length is not 4, 6, 10, or 18.  
> > 
> > Would have saved me some trouble, so I'm definitely in favour of checkpatch
> > catching this.
> > 
> > I wonder if a better option is to match on 1, 2, 4, 8, 16 as likely to be
> > caused by people getting the usage wrong rather than a deliberate attempt
> > to pretty print something a little unusual?  
> 
> Dunno.  %#0x and %x[123] seems pretty silly as it'll always emit the number
> of digits in the value.

Good point for those two cases - definitely want to catch them.

> 
> There aren't too many other odd uses other than those.

Perhaps you are right - after all anyone who is deliberately doing something
unusual will know they are doing it and can ignore the checkpatch warning.
Not as though it's going to happen very often from your stats below - looks
like maybe 17 of those cases 'might' be deliberate.

Jonathan
> 
> > > $ git grep -P -h -o '%#\d+\w+' | sort | uniq -c | sort -rn  
> 
> 8 and 16 are perhaps commonly misused.
> > >     392 %#08x
> > >      17 %#08lx
> > >       9 %#08zx
> > >       6 %#8x
> > >       4 %#08llx
> > >       1 %#8lx
> > >       1 %#08  
> 
> > >       7 %#16llx
> > >       5 %#16
> > >       4 %#016Lx
> > >       1 %#16x
> > >       1 %#16lx  
> 
> These are the odd ones:
> 
> > >     144 %#02x
> > >      27 %#0x
> > >      23 %#2x
> > >      17 %#3lx
> > >      15 %#3x
> > >      14 %#03x
> > >       6 %#012llx
> > >       4 %#05x
> > >       4 %#02X
> > >       3 %#01x
> > >       2 %#09x
> > >       2 %#05lx
> > >       1 %#5x
> > >       1 %#5lx
> > >       1 %#2Lx
> > >       1 %#2llx
> > >       1 %#12x
> > >       1 %#0lx
> > >       1 %#05llx
> > >       1 %#03X  
> 
> 

