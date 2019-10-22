Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33976E0372
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 13:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbfJVLxT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 07:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387868AbfJVLxT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 07:53:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B980A21783;
        Tue, 22 Oct 2019 11:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571745197;
        bh=mFRL1cOPVqH8M3jRF0HmpTCPqEWt43++I19E5TTgXoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mAWvrBfIzsX978Bzhdz58X/RJTv4gaboqshUmS6jwmj6zeg755OZ1YhtbD+8hQbVZ
         ZNIUd5psvHtZ5ukNKWPaAZTL+5E8oPMJnkx5FjKs/sDTT77PGDgqrvtMFvIihct+Xb
         5t9LLmHOLRS/r5RFu8rrVNphbzdHeXAvJouX2KNM=
Date:   Tue, 22 Oct 2019 12:53:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Olivier MOYSAN <olivier.moysan@st.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH][RFC] iio: core: add a class hierarchy on iio device
 lock
Message-ID: <20191022125312.68aa514a@archlinux>
In-Reply-To: <9ddc41c4-3d84-cc94-5494-a5ef06697ce8@metafoo.de>
References: <20191011151314.5365-1-olivier.moysan@st.com>
        <20191012095747.3acd95e6@archlinux>
        <db362ddf-390e-0847-1269-f3cd0c757d2a@st.com>
        <9ddc41c4-3d84-cc94-5494-a5ef06697ce8@metafoo.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Oct 2019 23:11:43 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/14/19 5:59 PM, Olivier MOYSAN wrote:
> > Hello Jonathan,
> > 
> > Thanks for your comment.
> > 
> > On 10/12/19 10:57 AM, Jonathan Cameron wrote:  
> >> On Fri, 11 Oct 2019 17:13:14 +0200
> >> Olivier Moysan <olivier.moysan@st.com> wrote:
> >>  
> >>> The aim of this patch is to correct a recursive locking warning,
> >>> detected when setting CONFIG_PROVE_LOCKING flag (as shown in message below).
> >>> This message was initially triggered by the following call sequence
> >>> in stm32-dfsdm-adc.c driver, when using IIO hardware consumer interface.
> >>>
> >>> in stm32_dfsdm_read_raw()
> >>> 	iio_device_claim_direct_mode
> >>> 		mutex_lock(&indio_dev->mlock);			-> lock on dfsdm device
> >>> 	iio_hw_consumer_enable
> >>> 		iio_update_buffers
> >>> 			mutex_lock(&indio_dev->mlock);		-> lock on hw consumer device  
> >> Hmm.  I'm not sure I follow the logic.  That lock is
> >> for one thing and one thing only, preventing access
> >> to the iio device that are unsafe when it is running
> >> in a buffered mode.  We shouldn't be in a position where
> >> we both say don't do this if we are in buffered mode, + enter
> >> buffered mode whilst doing this, or we need special functions
> >> for entering buffering mode if in this state.  We are in
> >> some sense combining internal driver logic with overall
> >> IIO states.  IIO shouldn't care that the device is using
> >> the same methods under the hood for buffered and non
> >> buffered operations.
> >>
> >> I can't really recall how this driver works.   Is it actually
> >> possible to have multiple hw_consumers at the same time?
> >>
> >> So do we end up with multiple buffers registered and have
> >> to demux out to the read_raw + the actual buffered path?
> >> Given we have a bit of code saying grab one sample, I'm
> >> going to guess we don't...
> >>
> >> If so, the vast majority of the buffer setup code in IIO
> >> is irrelevant here and we just need to call a few of
> >> the callbacks from this driver directly... (I think
> >> though I haven't chased through every corner.
> >>
> >> I'd rather avoid introducing this nesting for a corner
> >> case that makes no 'semantic' sense in IIO as it leaves us
> >> in two separate states at the same time that the driver
> >> is trying to make mutually exclusive.  We can't both
> >> not be in buffered mode, and in buffered mode.
> >>
> >> Thanks and good luck with this nasty corner!
> >>
> >> Jonathan
> >>  
> > Here I consider the following use case:
> > A single conversion is performed. The dfsdm (filter) is chained with a 
> > front-end, which can be an ADC or a sensor. So we have two IIO devices, 
> > the dfsdm and its front-end handled through the hw consumer interface.
> > 
> > You are right. There is something wrong here, in buffered/non-buffered 
> > mode mixing.
> > iio_hw_consumer_enable() call is used to enable the front-end device. 
> > But this interface is intended for buffered mode.
> > So this is not coherent with the expected single conversion mode, 
> > indeed. Another interface is required to manage the front-end device. I 
> > have a poor knowledge of iio framework, but it seems to me that there is 
> > no interface to manage this.
> > 
> > My understanding regarding mlock, is that it is used to protect the 
> > state of the iio device.
> > I we want to do a conversion from the chained devices, I think we need 
> > to activate the first device
> > and keep it performing conversion, as long as the second device has done 
> > its conversion.
> > We need to protect both devices, and we should have to do it in a nested 
> > way.
> > So, I guess that anyway, nested mutexes would be required in this case.
> >  
> 
> Others like regmap have solved this by having a lockclass per instance.
> Although that is not ideal either since it will slow down lockdep.
> 
> See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/regmap.h#n629

It'll take me a while to get back to this as my understanding is
currently very limited.  Poke me if I've not replied in a few weeks.

Thanks,

Jonathan


