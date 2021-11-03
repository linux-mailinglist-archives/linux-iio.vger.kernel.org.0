Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9D4447D6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 19:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhKCSDQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 14:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhKCSDD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 14:03:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8EDA60FC2;
        Wed,  3 Nov 2021 18:00:24 +0000 (UTC)
Date:   Wed, 3 Nov 2021 18:04:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Maslov <maslovdmitry@seeed.cc>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, north_sea@qq.com,
        baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
Subject: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver support
Message-ID: <20211103180458.6f0bc4c8@jic23-huawei>
In-Reply-To: <CAHp75Vc+Yqcq=gtpMgzb5pDc9nuNbzzwVjfsTg20hZ7VfAQ88w@mail.gmail.com>
References: <20211031164603.4343-1-maslovdmitry@seeed.cc>
        <CAHp75Vd99uk+wZHpVyYEveNGTaK9Nj5-oYTRua2UhOKjtYnS_g@mail.gmail.com>
        <1d537660.dd.17cdbca2bb6.Coremail.maslovdmitry@seeed.cc>
        <CAHp75Vc+Yqcq=gtpMgzb5pDc9nuNbzzwVjfsTg20hZ7VfAQ88w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Nov 2021 16:20:35 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Nov 1, 2021 at 3:57 PM Dmitry Maslov <maslovdmitry@seeed.cc> wrote:
> > > From: "Andy Shevchenko" <andy.shevchenko@gmail.com>
> > > Sent Time: 2021-10-31 22:07:09 (Sunday)
> > > On Sun, Oct 31, 2021 at 6:46 PM Maslov Dmitry <maslovdmitry@seeed.cc> wrote:  
> 
> ...
> 
> > > > Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>  
> > >
> > > I believe it should be Dmitry Maslov, i.e. First name Last name.  
> >
> > I could change that, but I do not think there is an international standard for that. The reason I put Maslov Dmitry
> > is to be in line with corporate email address, which belongs to a Chinese company - in China surname is put first
> > on the legal documents.  
> 
> Hmm... You are right, there is no such requirement in the Submitting
> Patches document.

Curiously we (Huawei) got push back on using conventional Chinese name
ordering, so now submit everything with names swapped. I can't remember
exactly which maintainer was determined we should do that... After some
internal discussions we decided it was easier to just swap people's names
than to argue about it.  No one expressed any particularly
strong opinions about the decision but perhaps people were just being polite.

E.g. A random patch with sign-off from leizhen and xuwei.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2bbc8687e43df456a6d194bc2c3ab9431b770cb

Still I don't care or consider it a problem so accept whatever people
prefer as long as it's in some sense their legal name for purposes of
DCO.

Jonathan


> ...
> 
> > > > @@ -1597,6 +1610,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
> > > >         {"LTER0501", ltr501},
> > > >         {"LTER0559", ltr559},
> > > >         {"LTER0301", ltr301},
> > > > +       {"LTER0303", ltr303},  
> > >
> > > Any evidence of this ACPI ID being in the wild, please?  
> >
> > I'm sorry, I do not exactly understand the question. Do you mean where that particular sensor is used?  
> 
> Can you provide a name of the machine which has this ID in its DSDT
> table, please?
> 

