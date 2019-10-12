Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC21D503A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJLOAT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 10:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfJLOAT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 10:00:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C42602089C;
        Sat, 12 Oct 2019 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570888817;
        bh=Mz0BL3/C+OrOXXcjjKTuqtWi5Ny6ZYS0L4vIH8ltkfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bipuAx3KMl+7dalmmCW/eKNVAhz7kU3AXJhnZJBdnEjXNPfkwuz455QiBKVrPhfmd
         PfIJViUdRtB9otkEn2Fzk7E4EhojB23oxtPUci/AhSdup6Tbzg7/FBu9jwLdiMeABm
         ZedXiIlxroMXFMHZfbWTaPplcVGqZuxfUEmQ1JdI=
Date:   Sat, 12 Oct 2019 15:00:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        david@lechnology.com
Subject: Re: [PATCH v5 0/3] Simplify count_read/count_write/signal_read
Message-ID: <20191012150012.5e3399f1@archlinux>
In-Reply-To: <cover.1570391994.git.vilhelm.gray@gmail.com>
References: <cover.1570391994.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William

What's the status on these? If you are happy that reviews and
testing is complete enough, do you want me to take them after
I pick up the eqep driver (hopefully shortly dependent on
the pull request Greg has from me being fine).

Thanks,

Jonathan

On Sun,  6 Oct 2019 16:03:08 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Changes in v5:
>  - Add changes and additions to generic-counter.rst to clarify theory
>    and use of the Generic Counter interface
>  - Fix typo in counter.h action_get description comment
> 
> The changes in this patchset will not affect the userspace interface.
> Rather, these changes are intended to simplify the kernelspace Counter
> callbacks for counter device driver authors.
> 
> The following main changes are proposed:
> 
> * Retire the opaque counter_count_read_value/counter_count_write_value
>   structures and simply represent count data as an unsigned integer.
> 
> * Retire the opaque counter_signal_read_value structure and represent
>   Signal data as a counter_signal_value enum.
> 
> These changes should reduce some complexity and code in the use and
> implementation of the count_read, count_write, and signal_read
> callbacks.
> 
> The opaque structures for Count data and Signal data were introduced
> originally in anticipation of supporting various representations of
> counter data (e.g. arbitrary-precision tallies, floating-point spherical
> coordinate positions, etc). However, with the counter device drivers
> that have appeared, it's become apparent that utilizing opaque
> structures in kernelspace is not the best approach to take.
> 
> I believe it is best to let userspace applications decide how to
> interpret the count data they receive. There are a couple of reasons why
> it would be good to do so:
> 
> * Users use their devices in unexpected ways.
> 
>   For example, a quadrature encoder counter device is typically used to
>   keep track of the position of a motor, but a user could set the device
>   in a pulse-direction mode and instead use it to count sporadic rising
>   edges from an arbitrary signal line unrelated to positioning. Users
>   should have the freedom to decide what their data represents.
> 
> * Most counter devices represent data as unsigned integers anyway.
> 
>   For example, whether the device is a tally counter or position
>   counter, the count data is represented to the user as an unsigned
>   integer value. So specifying that one device is representing tallies
>   while the other specifies positions does not provide much utility from
>   an interface perspective.
> 
> For these reasons, the count_read and count_write callbacks have been
> redefined to pass count data directly as unsigned long instead of passed
> via opaque structures:
> 
>         count_read(struct counter_device *counter,
>                    struct counter_count *count, unsigned long *val);
>         count_write(struct counter_device *counter,
>                     struct counter_count *count, unsigned long val);
> 
> Similarly, the signal_read is redefined to pass Signal data directly as
> a counter_signal_value enum instead of via an opaque structure:
> 
>         signal_read(struct counter_device *counter,
>                     struct counter_signal *signal,
>                     enum counter_signal_value *val);
> 
> The counter_signal_value enum is simply the counter_signal_level enum
> redefined to remove the references to the Signal data "level" data type.
> 
> William Breathitt Gray (3):
>   counter: Simplify the count_read and count_write callbacks
>   docs: driver-api: generic-counter: Update Count and Signal data types
>   counter: Fix typo in action_get description
> 
>  Documentation/driver-api/generic-counter.rst | 162 +++++++++++--------
>  drivers/counter/104-quad-8.c                 |  33 ++--
>  drivers/counter/counter.c                    | 101 ++----------
>  drivers/counter/ftm-quaddec.c                |  14 +-
>  drivers/counter/stm32-lptimer-cnt.c          |   5 +-
>  drivers/counter/stm32-timer-cnt.c            |  17 +-
>  drivers/counter/ti-eqep.c                    |  19 +--
>  include/linux/counter.h                      |  76 ++-------
>  8 files changed, 144 insertions(+), 283 deletions(-)
> 
> 
> base-commit: 0c3aa63a842d84990bd02622f2fa50d2bd33c652
> prerequisite-patch-id: ebe284609b3db8d4130ea2915f7f7b185c743a70
> prerequisite-patch-id: cbe857759f10d875690df125d18bc04f585ac7c9
> prerequisite-patch-id: 21f2660dc88627387ee4666d08044c63dd961dae

