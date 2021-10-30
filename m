Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBAB4409A1
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 16:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhJ3OqD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 10:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhJ3OqD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 10:46:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3884F60F4B;
        Sat, 30 Oct 2021 14:43:31 +0000 (UTC)
Date:   Sat, 30 Oct 2021 15:47:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        linux-kernel@vger.kernel.org
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        Vasyl.Vavrychuk@opensynergy.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v7 1/2] iio: core: Introduce IIO_VAL_INT_64.
Message-ID: <20211030154759.63be7331@jic23-huawei>
In-Reply-To: <20912d4e-8417-73d6-a42f-ceaada6e3cf3@opensynergy.com>
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
        <20211024091627.28031-2-andriy.tryshnivskyy@opensynergy.com>
        <20211024171015.3b6b46e5@jic23-huawei>
        <20912d4e-8417-73d6-a42f-ceaada6e3cf3@opensynergy.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Oct 2021 19:58:52 +0300
Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:

> On 24.10.21 19:10, Jonathan Cameron wrote:
> 
> > CAUTION: This email originated from outside of the organization.
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.

Ah. One thing I forgot.  Value formatting is the only bit of IIO where
we have self tests.

Would you mind writing some test cases in
drivers/iio/tests/iio-test-format.c ?

I'll pick this up in the meantime but definitely want to make
sure we don't forget the tests!

Jonathan


> >
> >
> > On Sun, 24 Oct 2021 12:16:26 +0300
> > Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
> >  
> >> Introduce IIO_VAL_INT_64 to read 64-bit value for
> >> channel attribute. Val is used as lower 32 bits.
> >>
> >> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
> >> ---
> >>   drivers/iio/industrialio-core.c | 3 +++
> >>   include/linux/iio/types.h       | 1 +
> >>   2 files changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> >> index 6d2175eb7af2..49e42d04ea16 100644
> >> --- a/drivers/iio/industrialio-core.c
> >> +++ b/drivers/iio/industrialio-core.c
> >> @@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
> >>        }
> >>        case IIO_VAL_CHAR:
> >>                return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
> >> +     case IIO_VAL_INT_64:
> >> +             tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
> >> +             return sysfs_emit_at(buf, offset, "%lld", tmp2);
> >>        default:
> >>                return 0;
> >>        }
> >> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> >> index 84b3f8175cc6..bb6578a5ee28 100644
> >> --- a/include/linux/iio/types.h
> >> +++ b/include/linux/iio/types.h
> >> @@ -24,6 +24,7 @@ enum iio_event_info {
> >>   #define IIO_VAL_INT_PLUS_NANO 3
> >>   #define IIO_VAL_INT_PLUS_MICRO_DB 4
> >>   #define IIO_VAL_INT_MULTIPLE 5
> >> +#define IIO_VAL_INT_64 6 /* 64-bit data, val is lower 32 bits) */  
> > I'm guessing the closing bracket is left over of some editing?
> >
> > Otherwise fine and I can tidy that up whilst applying.  
> 
> Yes, it's a typo. Please remove it while applying. Thanks!
> 
> > Note that this is almost certainly too late for this cycle (we are
> > about a week away from merge window subject to whatever Linus says
> > for rc7 and new stuff needs some time to soak in next), but I'll
> > plan to get it queued up early in the next one.
> >  
> Noted. Thanks a lot!
> 
> >>   #define IIO_VAL_FRACTIONAL 10
> >>   #define IIO_VAL_FRACTIONAL_LOG2 11
> >>   #define IIO_VAL_CHAR 12  
> 
> Best regards,
> Andriy.
> 
> 

