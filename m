Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12AC31D0F2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 20:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBPT2H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 14:28:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhBPT2H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Feb 2021 14:28:07 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A079F64ED0;
        Tue, 16 Feb 2021 19:27:23 +0000 (UTC)
Date:   Tue, 16 Feb 2021 19:27:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 21/22] counter: 104-quad-8: Replace mutex with
 spinlock
Message-ID: <20210216192720.75082d22@archlinux>
In-Reply-To: <YCsq42hXqdRWrSEd@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <d2e72eac404ca5b7c99d8a642f2c07ebb2eb240a.1613131238.git.vilhelm.gray@gmail.com>
        <20210214181946.1d2f7e78@archlinux>
        <YCsq42hXqdRWrSEd@shinobu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Feb 2021 11:16:03 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sun, Feb 14, 2021 at 06:19:46PM +0000, Jonathan Cameron wrote:
> > On Fri, 12 Feb 2021 21:13:45 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > This patch replaces the mutex I/O lock with a spinlock. This is in
> > > preparation for a subsequent patch adding IRQ support for 104-QUAD-8
> > > devices; we can't sleep in an interrupt context, so we'll need to use a
> > > spinlock instead.
> > > 
> > > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> > 
> > Why do these need to be raw_spin_locks?
> > Normally only need to do that if in code related to interrupt chips etc,
> > not their use.
> > 
> > Jonathan  
> 
> This lock can be taken in an interrupt context in a subsequent patch:
> counter_push_event() called by quad8_irq_handler() can end up calling
> the Counter component callbacks which take this lock. We can't use a
> mutex nor a regular spinlock because those can sleep on RT setups [1]

But on RT setups the interrupts become threads and are preemptable etc,
so that shouldn't matter.  There are a few corner cases that cause
trouble, but in most normal drivers you should be fine with a
spin_lock.

Jonathan


> which would result in a deadlock due to the interrupt context here -- so
> therefore we're left with using raw_spin_lock.
> 
> [1] https://lwn.net/Articles/367219/
> 
> William Breathitt Gray

