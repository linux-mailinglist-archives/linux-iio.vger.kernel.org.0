Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B323FE90
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgHINc0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 09:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgHINc0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 09:32:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F98206B6;
        Sun,  9 Aug 2020 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596979945;
        bh=x6hX5hmHtgNXUpMMJKzfq2gMV3FBFrP/xYq9lyBrJcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cdU7jvqsvRA99y1tAOZjJre7pKdrkjgJGNC1NJRQStZ5+VBClhBupnCfrwhR7ZzcI
         h2FTdhTCSM5lC/pYXU76djpASYaCUEBvFVY3mMKl15iQHwU4N97qFmhQYMY9KnH8g4
         eXfoW2EWAD6HUzECMNTluDfaat1XoE0MAf5Z2+0M=
Date:   Sun, 9 Aug 2020 14:32:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] iio:temperature:mlx90632: Adding extended
 calibration option
Message-ID: <20200809143222.4e19ea38@archlinux>
In-Reply-To: <CAKv63uv-+r6M=G2rviSedgdCUd_0nzHKWXK363bJNERTQHRYXA@mail.gmail.com>
References: <20200808121026.1300375-1-cmo@melexis.com>
        <20200808121026.1300375-3-cmo@melexis.com>
        <CAHp75VfWk7pCy4Osv0uY0UH4yFS=PRGbE1CNCakuRFTE33SDJg@mail.gmail.com>
        <CAKv63uv-+r6M=G2rviSedgdCUd_0nzHKWXK363bJNERTQHRYXA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 8 Aug 2020 23:57:59 +0200
Crt Mori <cmo@melexis.com> wrote:

> Hi,
> I am very sorry you missed them, I thought you saw it (reply on v3 of
> the patch). Maybe something happened to that mail, as it contained
> link to datasheet, so I will omit it now.
> 
> Except for the order, only the remarks below are still open (did you
> get the polling trail I did?)
> 
> On Sat, 8 Aug 2020 at 22:04, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Sat, Aug 8, 2020 at 3:11 PM Crt Mori <cmo@melexis.com> wrote:  
> > >
> > > For some time the market wants medical grade accuracy in medical range,
> > > while still retaining the declared accuracy outside of the medical range
> > > within the same sensor. That is why we created extended calibration
> > > which is automatically switched to when object temperature is too high.
> > >
> > > This patch also introduces the object_ambient_temperature variable which
> > > is needed for more accurate calculation of the object infra-red
> > > footprint as sensor's ambient temperature might be totally different
> > > than what the ambient temperature is at object and that is why we can
> > > have some more errors which can be eliminated. Currently this temperature
> > > is fixed at 25, but the interface to adjust it by user (with external
> > > sensor or just IR measurement of the other object which acts as ambient),
> > > will be introduced in another commit.  
> >
> > The kernel doc patch should go before this patch.
> >
> > ...
> >  
> > > +       *ambient_new_raw = (s16)read_tmp;  
> >  
> > > +       *ambient_old_raw = (s16)read_tmp;  
> >
> > Sorry, did I miss your answer about these castings all over the patch?
> >  
> 
> These castings are in fact needed. You read unsigned integer, but the
> return value is signed integer. Without the cast it did not extend the
> signed bit, but just wrote the value to signed. Also I find it more
> obvious with casts, that I did not "accidentally" convert to signed.

Should we perhaps be making this explicit for the cases where we
are sign extending?  That doesn't include these two as the lvalue
is s16, but does include some of the others.

sign_extend32(read_tmp, 15)

> 
> > ...
> >  
> > > +       ret = regmap_read(regmap, MLX90632_RAM_1(17), &read_tmp);
> > > +       ret = regmap_read(regmap, MLX90632_RAM_2(17), &read_tmp);
> > > +       ret = regmap_read(regmap, MLX90632_RAM_1(18), &read_tmp);
> > > +       ret = regmap_read(regmap, MLX90632_RAM_2(18), &read_tmp);
> > > +       ret = regmap_read(regmap, MLX90632_RAM_1(19), &read_tmp);
> > > +       ret = regmap_read(regmap, MLX90632_RAM_2(19), &read_tmp);  
> >
> > What so special about these magic 17, 18, 19? Can you provide definitions?
> >  
> When we started 0 to 19 were all open for access, from userspace, then
> only 1 and 2 were used with calculations, and now we use 17, 18 and
> 19. Matter of fact is, I can't provide a descriptive name as it
> depends on DSP version and as you can see now within the same DSP
> version, also on the ID part. While RAM3 vs RAM1 and RAM2 could be
> named RAM_OBJECT1, RAM_OBJECT2, RAM_AMBIENT, knowing our development
> that might not be true in the next configuration, so I rather keep the
> naming as in the datasheet.
Normal solution for that is to version the defines as well.

MLX90632_FW3_RAM_1_AMBIENT etc
When a new version changes this, then you introduced new defines to
support that firmware.

> 
> > ...
> >  
> > > +       int tries = 4;  
> >  
> > > +       while (tries-- > 0) {
> > > +               ret = mlx90632_perform_measurement(data);
> > > +               if (ret < 0)
> > > +                       goto read_unlock;
> > > +
> > > +               if (ret == 19)
> > > +                       break;
> > > +       }
> > > +       if (tries < 0) {
> > > +               ret = -ETIMEDOUT;
> > > +               goto read_unlock;
> > > +       }  
> >
> > Please avoid ping-pong type of changes in the same series (similar way
> > as for kernel doc), which means don't introduce something you are
> > going to change later on. Patch to move to do {} while () should go
> > before this one.  
> 
> OK, will fix that ordering in v5, but will wait till we solve also
> above discussions to avoid adding new versions.
> 
> >
> > --
> > With Best Regards,
> > Andy Shevchenko  
> 
> And about that voodoo stuff with numbers:
> 
> Honestly, the equation is in the datasheet[1] and this is just making
> floating point to fixed point with proper intermediate scaling
> (initially I had defines of TENTOX, but that was not desired). There
> is no better explanation of this voodoo.

We all love fixed point arithmetic :)

Jonathan
