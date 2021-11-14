Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3C44F8E8
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhKNQDW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 11:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235329AbhKNQDV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 11:03:21 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5094360FBF;
        Sun, 14 Nov 2021 16:00:25 +0000 (UTC)
Date:   Sun, 14 Nov 2021 16:05:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     davidcomponentone@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] tools: iio: use swap() to make code cleaner
Message-ID: <20211114160511.404fcb4f@jic23-huawei>
In-Reply-To: <CAHp75VeUfRQ279iY3tZs298h7Vpnca_Lso=N2THEKuqc=hW1_A@mail.gmail.com>
References: <20211104062032.1505899-1-yang.guang5@zte.com.cn>
        <CAHp75VedwDcBoz=dOGf_-7aOHC1mdvT8+hyvyK+hbK-5soJoYw@mail.gmail.com>
        <CAHp75VeUfRQ279iY3tZs298h7Vpnca_Lso=N2THEKuqc=hW1_A@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 Nov 2021 12:36:52 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Nov 4, 2021 at 12:33 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Nov 4, 2021 at 8:21 AM <davidcomponentone@gmail.com> wrote:  
> 
> > > Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> > > opencoding it.  
> >
> > Same as per other patches. Don't be a dump addon to the robot, think
> > about the code a little bit more.
> >  
> > >  void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt)
> > >  {
> > > -       struct iio_channel_info temp;
> > >         int x, y;
> > >
> > >         for (x = 0; x < cnt; x++)
> > >                 for (y = 0; y < (cnt - 1); y++)
> > >                         if (ci_array[y].index > ci_array[y + 1].index) {
> > > -                               temp = ci_array[y + 1];
> > > -                               ci_array[y + 1] = ci_array[y];
> > > -                               ci_array[y] = temp;
> > > +                               swap(ci_array[y + 1], ci_array[y]);
> > >                         }  
> >
> > Name of the function suggests it's a sort, we have the sort_r() API,
> > use it instead.  
> 
> Ah, it's the tools folder...
> Anyway, the first part of the comment stays valid for all your contribution.
> 

Also check this builds as it doesn't for me precisely because this is in tools and
hence should be using uapi includes only.  Maybe there is one going in for this
during the merge window but it's not in my tree yet at least.

Jonathan


