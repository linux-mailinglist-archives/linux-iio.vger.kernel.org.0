Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7647B270F2E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgISPqu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgISPqu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 11:46:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D08208DB;
        Sat, 19 Sep 2020 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600530410;
        bh=eabHuXkeCY4sJejJMyd9BZNPN8C8a4AAjkrxcEOFEy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VGneF12mvKx5p8d5+4pnfdrwyUWlihJhruZRWmTaalGKHGvjiTY6lPgcmD030WJ6k
         ZHRgZojboD6SiP6giKjbZtcs+ccl+koEAXz6yk8LTLH4jia2a12sGsJZGy8+PN+Mc6
         kZyWZiXxgm49HaiBBDGbp3l33WbmKu5xbeZbA7xs=
Date:   Sat, 19 Sep 2020 16:46:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 08/27] iio:light:si1145: Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200919164645.2db1091d@archlinux>
In-Reply-To: <20200723122517.000070cf@Huawei.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-9-jic23@kernel.org>
        <CAHp75VdFQYtkA-g2S=Vcvk3Sxp7duTihr3XGfzbUEB5xM4UbTg@mail.gmail.com>
        <CAHp75VcL+-jxYiNVkXi=s8WDRvDuSVJ9w9AtKsKVp2eN_TEtXA@mail.gmail.com>
        <20200723122517.000070cf@Huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 12:25:17 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 22 Jul 2020 22:45:59 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Wed, Jul 22, 2020 at 10:43 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:  
> > >
> > > On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:    
> > > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > One of a class of bugs pointed out by Lars in a recent review.
> > > > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > > > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > > > this driver which uses a 24 byte array of smaller elements on the stack.
> > > > As Lars also noted this anti pattern can involve a leak of data to
> > > > userspace and that indeed can happen here.  We close both issues by
> > > > moving to a suitable array in the iio_priv() data with alignment
> > > > explicitly requested.  This data is allocated with kzalloc so no
> > > > data can leak appart from previous readings.
> > > >
> > > > Depending on the enabled channels, the  location of the timestamp
> > > > can be at various aligned offsets through the buffer.  As such we
> > > > any use of a structure to enforce this alignment would incorrectly
> > > > suggest a single location for the timestamp.    
> > >
> > > ...
> > >    
> > > > +       /* Ensure timestamp will be naturally aligned if present */
> > > > +       u8 buffer[24] __aligned(8);    
> > >
> > > Why can't we use proper structure here?
> > >    
> > > > @@ -445,7 +447,6 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
> > > >          *   6*2 bytes channels data + 4 bytes alignment +
> > > >          *   8 bytes timestamp
> > > >          */
> > > > -       u8 buffer[24];    
> > >
> > > Seems even the old comment shows how it should look like...    
> > 
> > I think I understand now. Basically it's a dynamic amount of channels
> > (up to 6) before you get a timestamp.
> >   
> Exactly.  Comment is giving the largest it can be, not what is needed for
> a given configuration of the device.
> 
> Should indeed drop that comment.  Obviously went into automated mode and stopped
> actually reading what was in front of me.

I've adjusted the comment as requested by Andy (and moved it!).  Fits
under Andy's class 2 so applied to the togreg branch of iio.git and marked
for stable.  No great rush for this, beyond the fact that I'll keep forgetting
to actually sort these out!

Thanks,

Jonathan

> 
> Jonathan
> 
> 

