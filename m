Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF613F5E7C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbhHXNAL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 09:00:11 -0400
Received: from first.geanix.com ([116.203.34.67]:37278 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236910AbhHXNAL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Aug 2021 09:00:11 -0400
Received: from skn-laptop (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 86910440F4E;
        Tue, 24 Aug 2021 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1629809965; bh=IpuyqW3nFGzrvA6myjD6qcMlcb4Gw3WjLyCuiQql5O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MyQv+yHI+mFJVbVOm7WPuL6RwS5gEjW8yTdhJ/z/V81audt8sj9AlxcIKlsXTSKPA
         vgmdfpNlyOXZ7DWLk+HUueaDcZAJ33rjNYWWAsf4DMa8TNp63/h4qHJJPzpY1uXPUq
         tMnT29bNSwNcL2gnum2Z/8UJTdJ4BNIWUxvHOHoQjHKfQSsiWbCpK/DwYWewPf5Mca
         TutLBEWU0VctM/BDyMb/QqOJwKsquOEQI95hOir2pODA/hNWGLDxqmV53joxQ00X5h
         XC8BgrZPB4YCjBYED++g25Ira1J7xuaLzVGd5+46hPYBQr6T9a4uqCtWz3ZQKyHqcW
         wrgfHqZXzXDzQ==
Date:   Tue, 24 Aug 2021 14:59:24 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: accel: fxls8962af: add threshold event
 handling
Message-ID: <20210824125924.7z3ufe6zdvgdb7am@skn-laptop>
References: <20210824113709.1834195-1-sean@geanix.com>
 <CAHp75VeMzs+xyksGB8Kcnr-09a740eoWYmEJQHgbhMNVbuzAwA@mail.gmail.com>
 <20210824123245.z5o452x5s5m2wcyx@skn-laptop>
 <CAHp75VcfcAyjSuX=xrVcWdLbDVpoOT2_NKsMmKmRwagL1EZ=Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VcfcAyjSuX=xrVcWdLbDVpoOT2_NKsMmKmRwagL1EZ=Og@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 24, 2021 at 03:42:58PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 24, 2021 at 3:32 PM Sean Nyekjaer <sean@geanix.com> wrote:
> > On Tue, Aug 24, 2021 at 03:15:28PM +0300, Andy Shevchenko wrote:
> > > On Tue, Aug 24, 2021 at 2:38 PM Sean Nyekjaer <sean@geanix.com> wrote:
> 
> ...
> 
> > > > +       /*
> > > > +        * Add the same value to the lower-threshold register with a reversed sign
> > > > +        * in 2-complement 12 bit format.
> > > > +        */
> > > > +       data->lower_thres = (~val & GENMASK(11, 0)) + 1;
> > >
> > > This looks suspicious.
> > >
> > > 0 => 0xfff + 1 => 0x1000. Is it what is wanted?
> > > I thought that -val & mask is what you need.
> > >
> > > Can you explain more in the comment (maybe with examples) on what is
> > > coming and what is expected?
> >
> > It's a bit messy I know :)
> >
> > Some examples:
> > val = 0 => upper = 0x0, lower = 0x0
> > val = 500 => upper = 0x1F4, lower = 0xe0c
> > val = 1000 => upper = 0x3e8, lower = 0xc18
> >
> > Guess it could work if we special case val = 0...
> >
> > It doesn't even makes sense to write 0 to this register as noise would
> > trigger events.
> >
> > > > +       data->upper_thres = val & GENMASK(10, 0);
> 
> So, I just tested all three and with '-' (minus) it works, while your
> code is buggy :-)

Agree, just tested with:

---
#include <stdio.h>

int main() {
	signed int lower_thres, upper_thres, lower, upper;

	int val;

	for (val = 0; val <= 1000; val+=500) {
		lower = -val & 0xFFF;
		upper = val & 0x7FF;

		printf("val %d, upper 0x%x, lower 0x%x\n", val, upper, lower);
	}
}
---

val 0, upper 0x0, lower 0x0
val 500, upper 0x1f4, lower 0xe0c
val 1000, upper 0x3e8, lower 0xc18

Thanks :)

/Sean
