Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D543A39AAFA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFCTgR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 15:36:17 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:38438 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229617AbhFCTgR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jun 2021 15:36:17 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5FFD6100E7B45;
        Thu,  3 Jun 2021 19:34:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 23E44C417C;
        Thu,  3 Jun 2021 19:34:30 +0000 (UTC)
Message-ID: <7a7e5cf61177b168f465f2502fde7a1e04293063.camel@perches.com>
Subject: Re: General kernel misuse of vsnprintf SPECIAL %#<foo> (was: Re:
 [PATCH v2 0/4] iio: Drop use of %hhx and %hx format strings)
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Jun 2021 12:34:28 -0700
In-Reply-To: <20210603202546.0d12e7ad@jic23-huawei>
References: <20210603180612.3635250-1-jic23@kernel.org>
         <9499203f1e993872b384aabdec59ac223a8ab931.camel@perches.com>
         <20210603202546.0d12e7ad@jic23-huawei>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.40
X-Stat-Signature: xfx481amwwrkh5cxkk8dbt4ascae8j68
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 23E44C417C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18R1oAoqYfHFawgc7TCtPiuf41w4Q+rl74=
X-HE-Tag: 1622748870-966212
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2021-06-03 at 20:25 +0100, Jonathan Cameron wrote:
> On Thu, 03 Jun 2021 11:58:15 -0700 Joe Perches <joe@perches.com> wrote:
> > It looks to me as though %#<foo> is relatively commonly misused in the kernel.
> > 
> > Pehaps for the decimal portion of the format, checkpatch could have some
> > test for use of non-standard lengths.
> > 
> > Given the use is generally meant for a u8, u16, u32, or u64, perhaps
> > checkpatch should emit a warning whenever the length is not 4, 6, 10, or 18.
> 
> Would have saved me some trouble, so I'm definitely in favour of checkpatch
> catching this.
> 
> I wonder if a better option is to match on 1, 2, 4, 8, 16 as likely to be
> caused by people getting the usage wrong rather than a deliberate attempt
> to pretty print something a little unusual?

Dunno.  %#0x and %x[123] seems pretty silly as it'll always emit the number
of digits in the value.

There aren't too many other odd uses other than those.

> > $ git grep -P -h -o '%#\d+\w+' | sort | uniq -c | sort -rn

8 and 16 are perhaps commonly misused.
> >     392 %#08x
> >      17 %#08lx
> >       9 %#08zx
> >       6 %#8x
> >       4 %#08llx
> >       1 %#8lx
> >       1 %#08

> >       7 %#16llx
> >       5 %#16
> >       4 %#016Lx
> >       1 %#16x
> >       1 %#16lx

These are the odd ones:

> >     144 %#02x
> >      27 %#0x
> >      23 %#2x
> >      17 %#3lx
> >      15 %#3x
> >      14 %#03x
> >       6 %#012llx
> >       4 %#05x
> >       4 %#02X
> >       3 %#01x
> >       2 %#09x
> >       2 %#05lx
> >       1 %#5x
> >       1 %#5lx
> >       1 %#2Lx
> >       1 %#2llx
> >       1 %#12x
> >       1 %#0lx
> >       1 %#05llx
> >       1 %#03X


