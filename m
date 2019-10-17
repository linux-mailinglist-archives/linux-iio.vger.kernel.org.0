Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1324DB928
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 23:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441561AbfJQVl5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 17:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441334AbfJQVl4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Oct 2019 17:41:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6431C2067B;
        Thu, 17 Oct 2019 21:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571348515;
        bh=nL5RyYEfnCQ/xMkhILlMFuPBby2mRFtC95ZvlIcD5DM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L9h5G71ITKBOg+OObh19mJhCP2z0YPE5UKzQe1SOZIAWGWrU+4TMMmjQfoVben1Ji
         g06sKHmFk6jCgAXJ8GZpMVge6OEz+4J2FuxElTVe3b9Cqq/jW+qHX3M7n1BcOCQHRU
         CBbACUUL/kIJWOsSl/GrZglY/tLRGceGOXrqPXRs=
Date:   Thu, 17 Oct 2019 22:41:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        david@lechnology.com
Subject: Re: [PATCH v5 0/3] Simplify count_read/count_write/signal_read
Message-ID: <20191017224148.5f7edae2@archlinux>
In-Reply-To: <20191012145101.GA3463@icarus>
References: <cover.1570391994.git.vilhelm.gray@gmail.com>
        <20191012150012.5e3399f1@archlinux>
        <20191012145101.GA3463@icarus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 10:51:19 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sat, Oct 12, 2019 at 03:00:12PM +0100, Jonathan Cameron wrote:
> > Hi William
> > 
> > What's the status on these? If you are happy that reviews and
> > testing is complete enough, do you want me to take them after
> > I pick up the eqep driver (hopefully shortly dependent on
> > the pull request Greg has from me being fine).
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Yes, this is ready for you to take. So after the eqep driver is picked
> up you can apply this patchset.

Series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Thanks,
> 
> William Breathitt Gray
> 
> > 
> > On Sun,  6 Oct 2019 16:03:08 -0400
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > Changes in v5:
> > >  - Add changes and additions to generic-counter.rst to clarify theory
> > >    and use of the Generic Counter interface
> > >  - Fix typo in counter.h action_get description comment
> > > 
> > > The changes in this patchset will not affect the userspace interface.
> > > Rather, these changes are intended to simplify the kernelspace Counter
> > > callbacks for counter device driver authors.
> > > 
> > > The following main changes are proposed:
> > > 
> > > * Retire the opaque counter_count_read_value/counter_count_write_value
> > >   structures and simply represent count data as an unsigned integer.
> > > 
> > > * Retire the opaque counter_signal_read_value structure and represent
> > >   Signal data as a counter_signal_value enum.
> > > 
> > > These changes should reduce some complexity and code in the use and
> > > implementation of the count_read, count_write, and signal_read
> > > callbacks.
> > > 
> > > The opaque structures for Count data and Signal data were introduced
> > > originally in anticipation of supporting various representations of
> > > counter data (e.g. arbitrary-precision tallies, floating-point spherical
> > > coordinate positions, etc). However, with the counter device drivers
> > > that have appeared, it's become apparent that utilizing opaque
> > > structures in kernelspace is not the best approach to take.
> > > 
> > > I believe it is best to let userspace applications decide how to
> > > interpret the count data they receive. There are a couple of reasons why
> > > it would be good to do so:
> > > 
> > > * Users use their devices in unexpected ways.
> > > 
> > >   For example, a quadrature encoder counter device is typically used to
> > >   keep track of the position of a motor, but a user could set the device
> > >   in a pulse-direction mode and instead use it to count sporadic rising
> > >   edges from an arbitrary signal line unrelated to positioning. Users
> > >   should have the freedom to decide what their data represents.
> > > 
> > > * Most counter devices represent data as unsigned integers anyway.
> > > 
> > >   For example, whether the device is a tally counter or position
> > >   counter, the count data is represented to the user as an unsigned
> > >   integer value. So specifying that one device is representing tallies
> > >   while the other specifies positions does not provide much utility from
> > >   an interface perspective.
> > > 
> > > For these reasons, the count_read and count_write callbacks have been
> > > redefined to pass count data directly as unsigned long instead of passed
> > > via opaque structures:
> > > 
> > >         count_read(struct counter_device *counter,
> > >                    struct counter_count *count, unsigned long *val);
> > >         count_write(struct counter_device *counter,
> > >                     struct counter_count *count, unsigned long val);
> > > 
> > > Similarly, the signal_read is redefined to pass Signal data directly as
> > > a counter_signal_value enum instead of via an opaque structure:
> > > 
> > >         signal_read(struct counter_device *counter,
> > >                     struct counter_signal *signal,
> > >                     enum counter_signal_value *val);
> > > 
> > > The counter_signal_value enum is simply the counter_signal_level enum
> > > redefined to remove the references to the Signal data "level" data type.
> > > 
> > > William Breathitt Gray (3):
> > >   counter: Simplify the count_read and count_write callbacks
> > >   docs: driver-api: generic-counter: Update Count and Signal data types
> > >   counter: Fix typo in action_get description
> > > 
> > >  Documentation/driver-api/generic-counter.rst | 162 +++++++++++--------
> > >  drivers/counter/104-quad-8.c                 |  33 ++--
> > >  drivers/counter/counter.c                    | 101 ++----------
> > >  drivers/counter/ftm-quaddec.c                |  14 +-
> > >  drivers/counter/stm32-lptimer-cnt.c          |   5 +-
> > >  drivers/counter/stm32-timer-cnt.c            |  17 +-
> > >  drivers/counter/ti-eqep.c                    |  19 +--
> > >  include/linux/counter.h                      |  76 ++-------
> > >  8 files changed, 144 insertions(+), 283 deletions(-)
> > > 
> > > 
> > > base-commit: 0c3aa63a842d84990bd02622f2fa50d2bd33c652
> > > prerequisite-patch-id: ebe284609b3db8d4130ea2915f7f7b185c743a70
> > > prerequisite-patch-id: cbe857759f10d875690df125d18bc04f585ac7c9
> > > prerequisite-patch-id: 21f2660dc88627387ee4666d08044c63dd961dae  
> >   

