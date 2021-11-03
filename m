Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A65C444816
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 19:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhKCSTH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 14:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhKCSTH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 14:19:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F04160EDF;
        Wed,  3 Nov 2021 18:16:28 +0000 (UTC)
Date:   Wed, 3 Nov 2021 18:21:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Dmitry Maslov" <maslovdmitry@seeed.cc>
Cc:     "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>, north_sea@qq.com,
        baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
Subject: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver support
Message-ID: <20211103182102.2232e680@jic23-huawei>
In-Reply-To: <6f764cb4.e6.17cdd1249ee.Coremail.maslovdmitry@seeed.cc>
References: <20211031164603.4343-1-maslovdmitry@seeed.cc>
        <CAHp75Vd99uk+wZHpVyYEveNGTaK9Nj5-oYTRua2UhOKjtYnS_g@mail.gmail.com>
        <1d537660.dd.17cdbca2bb6.Coremail.maslovdmitry@seeed.cc>
        <CAHp75Vc+Yqcq=gtpMgzb5pDc9nuNbzzwVjfsTg20hZ7VfAQ88w@mail.gmail.com>
        <6f764cb4.e6.17cdd1249ee.Coremail.maslovdmitry@seeed.cc>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Nov 2021 03:55:35 +0800 (GMT+08:00)
"Dmitry Maslov" <maslovdmitry@seeed.cc> wrote:

> > -----Original Messages-----
> > From: "Andy Shevchenko" <andy.shevchenko@gmail.com>
> > Sent Time: 2021-11-01 16:20:35 (Monday)
> > To: "Dmitry Maslov" <maslovdmitry@seeed.cc>
> > Cc: "Jonathan Cameron" <jic23@kernel.org>, linux-iio <linux-iio@vger.kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, north_sea@qq.com, baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
> > Subject: Re: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver support
> > 
> > On Mon, Nov 1, 2021 at 3:57 PM Dmitry Maslov <maslovdmitry@seeed.cc> wrote:  
> > > > From: "Andy Shevchenko" <andy.shevchenko@gmail.com>
> > > > Sent Time: 2021-10-31 22:07:09 (Sunday)
> > > > On Sun, Oct 31, 2021 at 6:46 PM Maslov Dmitry <maslovdmitry@seeed.cc> wrote:  
> > 
> > ...
> >   
> > > > > Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>  
> > > >
> > > > I believe it should be Dmitry Maslov, i.e. First name Last name.  
> > >
> > > I could change that, but I do not think there is an international standard for that. The reason I put Maslov Dmitry
> > > is to be in line with corporate email address, which belongs to a Chinese company - in China surname is put first
> > > on the legal documents.  
> > 
> > Hmm... You are right, there is no such requirement in the Submitting
> > Patches document.
> > ...
> >   
> > > > > @@ -1597,6 +1610,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
> > > > >         {"LTER0501", ltr501},
> > > > >         {"LTER0559", ltr559},
> > > > >         {"LTER0301", ltr301},
> > > > > +       {"LTER0303", ltr303},  
> > > >
> > > > Any evidence of this ACPI ID being in the wild, please?  
> > >
> > > I'm sorry, I do not exactly understand the question. Do you mean where that particular sensor is used?  
> > 
> > Can you provide a name of the machine which has this ID in its DSDT
> > table, please?  
> 
> We're submitting this patch specifically for reTerminal.
> Here is DTS file for the reTerminal, currently awaiting merge in Raspberry Pi Linux kernel
> repository.
> https://github.com/raspberrypi/linux/blob/6ef732875d705ff15cc4c25d4d0a0eee87dc2a58/arch/arm/boot/dts/overlays/seeed-reterminal-core-overlay.dts#L99
> 
> So, while at the moment ACPI part is not being used, later we might use this sensor for other, x86 based
> boards, for example ODYSSEY - X86J4125800.
> 
> Is there a particular reason you think this part should be omitted for LTR303?
> 
ACPI IDs are supposed to be made up of either a PNP id or ACPI ID registered with
UEFI forum.

A 4 letter version is an ACPI ID (3 letters in PNP), so it should be in this table
https://uefi.org/acpi_id_list

It's not.  So that means the proper process wasn't followed.  If you were using this
ID on a server, chances are we'd just tell you go fix your firmware (it's happened
to me and we fixed it).  However the sad truth is in consumer / embedded devices that
may not be a practical solution.  As such, if the ID was known to be in the wild
we would probably let it in.

Unfortunately I only really got familiar with ACPI specs in the last 4 years
and before that time I didn't know what the rules were - so let a load of IDs in.
Some of those IDs are in use on hardware that is out there so we have to continue
supporting them or introduce a regression on that hardware.

The process of applying for a PNP or ACPI ID isn't that bad for a company - you ask
for a particular ID and request is then sent for a round of 'has anyone an objection'
to the ASWG (I'm a rather inactive member so I see these every week or so).
Instructions at https://uefi.org/PNP_ACPI_Registry

Note that there would be two options for Seeed.  Either you persuade liteon to apply
and then issue an appropriate number (which may well not be the part number - often
people just start counting from 0, or assign ranges to different people in the company
so there doesn't need to be a central registry) or seeed applies for an ACPI or PNP ID
and then issues IDs for any part you want to support on an ACPI platform that doesn't
yet have an ID issued by the supplier.

Note that it's also common to use someone else's ID. Once it's assigned to a device
it can't be reused anyway so if say, Intel or Hisilicon had assigned one to a part
already then you could just reuse it for your ACPI platforms.

Hope that clears up how this is supposed to work.

Also note that every now and then we 'guess' that IDs are just cut and paste
jobs and remove them.  So far we've only hit ones that were in actual use a
few times - the majority of invalid ones weren't in use.

Jonathan


> 
> 
> 

