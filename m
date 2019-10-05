Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CBBCCB9C
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 19:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfJERT7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 13:19:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37001 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfJERT7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2019 13:19:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id m7so3538137ywe.4;
        Sat, 05 Oct 2019 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MGAToH7gf0cf1NNYqYOLRrO0bNygR1ZINN+gs4KcfjI=;
        b=hInKtJ1wQDIAaaHqSxMc1KyxX4ngqQzK06TYsc/fewv9OUTewxjNvhoAA22E2/loFi
         wasFDBlq9zqGi2r4tcMli2676VkrYeWc1VXonj2huB9BN3/KO62U593XrF3cCPk9zh6/
         Ro3i0ArBfq+DiD4Hjv4cx+SzU6bYwnUpYuNYZyv3BwS51hHP+2oNYpbFzTziWvHPq8uA
         rxkpkdoCpCasIyeZOFSod3u9r/N1cd2scssUF3wZUa98SWne/8/bY2otB/XZ9Pu6S6ie
         GdABnngINi8bA5qSz0P8R+JqRAjS6T41wKr3An9fF/dYeSQaFX8z5Jmv3S99rwN62CoH
         a1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MGAToH7gf0cf1NNYqYOLRrO0bNygR1ZINN+gs4KcfjI=;
        b=ar4ZQ2DbRujuifOQqYF29wn1um0T2hCrz0+e0O/xQSeVaE8Jni/nFkf+zvybjTwgbb
         XTGKPnFUUlPV4Hu6Q59jFyHyV7Cy5Fopcz0PiPqrzoThdTGxbypiHdCRBefRrJBpblkb
         wiNpxveRBcb45/zjLXFSvt/kPhCBuAVUn4PjMaTclBzL7aRZOrIzDIa4oys6BTPWnnJs
         xwzKTHln4fwpjs/q6+Jrsq/3YLvFLv+8eymnc/j9B+k2Ee+RwwAIPs+j+ZXelh8q96iX
         NYyHjJPkad49DDmYUbRV8OScpVd7kwGcxAfmucC0noVACTJMBHcK9NPyJwguvsXiJ2vm
         cncA==
X-Gm-Message-State: APjAAAW7iGxYVIfiI2PebtI6pwqTILfCSsy8wLtASpwRykG5ehESlYVK
        ekRpdTk91WaWEbEKCYGLEz4=
X-Google-Smtp-Source: APXvYqwwjA05OEJO+32btwCbv0PRqgBlNIanc9PkgxO2kfSjusl2VL25zMbuvWbNGxLNX46za0Mg4Q==
X-Received: by 2002:a81:3601:: with SMTP id d1mr15208844ywa.103.1570295998277;
        Sat, 05 Oct 2019 10:19:58 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id y205sm2445684ywc.6.2019.10.05.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 10:19:57 -0700 (PDT)
Date:   Sat, 5 Oct 2019 13:19:38 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        David Lechner <david@lechnology.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH v3 0/2] Simplify count_read/count_write/signal_read
Message-ID: <20191005171938.GA7199@icarus>
References: <cover.1568816248.git.vilhelm.gray@gmail.com>
 <20191005153255.4290ce81@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191005153255.4290ce81@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 05, 2019 at 03:33:08PM +0100, Jonathan Cameron wrote:
> Hi William,
> 
> This all makes sense to me.  Do you want to wait for some more reviews
> or should I pick them up now through IIO?  We are really early in
> the cycle so plenty of time, unless there are new drivers coming you
> want to use these from the start.
> 
> Thanks,
> 
> Jonathan

Getting this in sooner would be better since that will save Fabien from
having to introduce the COUNTER_COUNT_TALLY type in the cros_ec patch
submission.

The only concern left now is that the TI eQEP driver needs to be updated
as well for these changes, but it's not in the IIO testing branch yet.

Do you want to merge this patchset first, or wait until TI eQEP makes it
into the testing branch? Alternatively, I can merge the cros_ec patchset
and Intel QEP patchset into my personal repository when they are ready,
then later submit a git pull request to you with these changes if you
prefer that route.

William Breathitt Gray

> On Wed, 18 Sep 2019 23:22:44 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > Changes in v3:
> >  - Squash code changes to single patch to avoid compilation error
> > 
> > The changes in this patchset will not affect the userspace interface.
> > Rather, these changes are intended to simplify the kernelspace Counter
> > callbacks for counter device driver authors.
> > 
> > The following main changes are proposed:
> > 
> > * Retire the opaque counter_count_read_value/counter_count_write_value
> >   structures and simply represent count data as an unsigned integer.
> > 
> > * Retire the opaque counter_signal_read_value structure and represent
> >   Signal data as a counter_signal_value enum.
> > 
> > These changes should reduce some complexity and code in the use and
> > implementation of the count_read, count_write, and signal_read
> > callbacks.
> > 
> > The opaque structures for Count data and Signal data were introduced
> > originally in anticipation of supporting various representations of
> > counter data (e.g. arbitrary-precision tallies, floating-point spherical
> > coordinate positions, etc). However, with the counter device drivers
> > that have appeared, it's become apparent that utilizing opaque
> > structures in kernelspace is not the best approach to take.
> > 
> > I believe it is best to let userspace applications decide how to
> > interpret the count data they receive. There are a couple of reasons why
> > it would be good to do so:
> > 
> > * Users use their devices in unexpected ways.
> > 
> >   For example, a quadrature encoder counter device is typically used to
> >   keep track of the position of a motor, but a user could set the device
> >   in a pulse-direction mode and instead use it to count sporadic rising
> >   edges from an arbitrary signal line unrelated to positioning. Users
> >   should have the freedom to decide what their data represents.
> > 
> > * Most counter devices represent data as unsigned integers anyway.
> > 
> >   For example, whether the device is a tally counter or position
> >   counter, the count data is represented to the user as an unsigned
> >   integer value. So specifying that one device is representing tallies
> >   while the other specifies positions does not provide much utility from
> >   an interface perspective.
> > 
> > For these reasons, the count_read and count_write callbacks have been
> > redefined to pass count data directly as unsigned long instead of passed
> > via opaque structures:
> > 
> >         count_read(struct counter_device *counter,
> >                    struct counter_count *count, unsigned long *val);
> >         count_write(struct counter_device *counter,
> >                     struct counter_count *count, unsigned long val);
> > 
> > Similarly, the signal_read is redefined to pass Signal data directly as
> > a counter_signal_value enum instead of via an opaque structure:
> > 
> >         signal_read(struct counter_device *counter,
> >                     struct counter_signal *signal,
> >                     enum counter_signal_value *val);
> > 
> > The counter_signal_value enum is simply the counter_signal_level enum
> > redefined to remove the references to the Signal data "level" data type.
> > 
> > William Breathitt Gray (2):
> >   counter: Simplify the count_read and count_write callbacks
> >   docs: driver-api: generic-counter: Update Count and Signal data types
> > 
> >  Documentation/driver-api/generic-counter.rst |  22 ++--
> >  drivers/counter/104-quad-8.c                 |  33 ++----
> >  drivers/counter/counter.c                    | 101 +++----------------
> >  drivers/counter/ftm-quaddec.c                |  14 +--
> >  drivers/counter/stm32-lptimer-cnt.c          |   5 +-
> >  drivers/counter/stm32-timer-cnt.c            |  17 +---
> >  include/linux/counter.h                      |  74 ++------------
> >  7 files changed, 53 insertions(+), 213 deletions(-)
> > 
> 
