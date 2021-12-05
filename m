Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8533F468D04
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 20:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhLETkI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 14:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbhLETkI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 14:40:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C9C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 11:36:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4526DB80E5C
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 19:36:39 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id AA5A6C00446;
        Sun,  5 Dec 2021 19:36:36 +0000 (UTC)
Date:   Sun, 5 Dec 2021 19:10:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: viio_trigger_alloc(): Correctly free trigger
 on error
Message-ID: <20211205191059.42ec4691@jic23-huawei>
In-Reply-To: <CAHp75VdeNcNTedxeOBAt2aFz8yWTzv37YWD1km8bs5fuAg0QfA@mail.gmail.com>
References: <20211031073231.13780-1-lars@metafoo.de>
        <20211031073231.13780-2-lars@metafoo.de>
        <CAHp75VfT-VgMODDdZCy8ERh1Uw8HVR6YuzmTukeP+nHbrx++sg@mail.gmail.com>
        <cfa7d882-7825-74d6-ff50-d8bd85dbf0f1@metafoo.de>
        <CAHp75VdeNcNTedxeOBAt2aFz8yWTzv37YWD1km8bs5fuAg0QfA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 Oct 2021 15:00:38 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Oct 31, 2021 at 11:15 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 10/31/21 9:54 AM, Andy Shevchenko wrote:  
> > > On Sunday, October 31, 2021, Lars-Peter Clausen <lars@metafoo.de
> > > <mailto:lars@metafoo.de>> wrote:  
> 
> ...
> 
> > >     -       if (trig->subirq_base) {
> > >     +       if (trig->subirq_base > 0) {
> > >  
> > > >= ?  
> >
> > I don't know. 0 is not supposed to be a valid irq number. And we
> > kzalloc() the struct, so if it hasn't been explicitly initialized we'd
> > get 0.  
> 
> But it will change the behaviour of the code.
> >=0 is the opposite of replacing < 0.  
> 
> 
> > The way the code is at the moment we'd never end up here without calling
> > irq_alloc_descs(), so it is either a valid irq or a negative error code
> > and I can see why you might want to use >= for consistency and symmetry.  
> 
> Right!
> 
> (But on some architectures and cases 0 might be a valid vIRQ)
> 
Given I'm fairly sure this will be after any other irqs we should be fine
but I don't think it would be a problem to allow 0.

If that's fine with both of you I can just change it to >= 0 whilst
applying, or Lars can do a v2 when has time.

Thanks,

Jonathan

