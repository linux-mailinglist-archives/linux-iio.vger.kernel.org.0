Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2AC31A4FA
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 20:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBLTGF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 14:06:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhBLTFo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Feb 2021 14:05:44 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F6C64EA6;
        Fri, 12 Feb 2021 19:05:00 +0000 (UTC)
Date:   Fri, 12 Feb 2021 19:04:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wilfried Wessner <wilfried.wessner@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: Re: [PATCH v3] iio: ad7949: fix wrong ADC result due to incorrect
 bit mask
Message-ID: <20210212190455.76b38d94@archlinux>
In-Reply-To: <CAHp75VcT_7=MKErF0oVn5PFT1_7OeD4cZaw5WAANvhHouB7V6g@mail.gmail.com>
References: <20210208142705.GA51260@ubuntu>
        <CAHp75Vc1VWYLO1rF-NNnW3qkgiGycgpTHvr5Q2Yn91aZcFuyJg@mail.gmail.com>
        <CAMwq6HiAufEjLPn2hSnQ7iBvrrCZUzwE_hdFE8s51ewbuJOMYA@mail.gmail.com>
        <CAHp75VcT_7=MKErF0oVn5PFT1_7OeD4cZaw5WAANvhHouB7V6g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Feb 2021 21:24:04 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Feb 11, 2021 at 8:42 PM Wilfried Wessner
> <wilfried.wessner@gmail.com> wrote:
> > On Mon, Feb 8, 2021 at 5:06 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:  
> > > On Mon, Feb 8, 2021 at 4:27 PM Wilfried Wessner
> > > <wilfried.wessner@gmail.com> wrote:  
> 
> ...
> 
> > > Shouldn't be blank like here, but I think Jonathan can fix when applying.
> > > Jonathan, can you also amend the subject (I totally forgot about
> > > subsubsystem prefix)?
> > > Should be like:
> > > "iio: adc: ad7949: fix wrong results due to incorrect bit mask"  
> >
> > Should I send a v4 with the changes proposed by Andy?
> > It would change the subject.  
> 
> Depends on you. Jonothan usually processes the queue during weekends,
> so no hurry.
> 
> > And if so, should I add the tags:
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>  
> 
> If resend, yes, you need to add them.
> 
Applied with the minor spacing and title tweak Andy suggested

Applied to the fixes-togreg branch of iio.git. Given this has been
there a while, I'm going to wait until after the merge window to
send this upstream.  So it will be a few weeks.

Thanks,

Jonathan


