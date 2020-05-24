Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA911E008C
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEXQZs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 12:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgEXQZs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 12:25:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5530520787;
        Sun, 24 May 2020 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590337547;
        bh=8Sow2b/gmRxdhLhwL/1TKHwvcuZIa5HKY7WTfS3ObwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lKUqdmL7BX21pzqiPn4lYuHypLtRe8EUcHU9E3pM0K1NNzzHlbFi7yv7uOzMEObL6
         mJL0PVz+X0UcMZUPfPpWZ3va+Wu5GEAGNIJqBqcGA0yfTKn9RHZUevbSlKv/70CUFm
         29ptM9hsJEneyIy1zYhNeH10rXnQWD4lYK2IE+yY=
Date:   Sun, 24 May 2020 17:25:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v2 0/4] Introduce the Counter character device interface
Message-ID: <20200524172542.31ff6ac7@archlinux>
In-Reply-To: <cover.1589654470.git.vilhelm.gray@gmail.com>
References: <cover.1589654470.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


...

> The following are some questions I have about this patchset:
> 
> 1. Should the data format of the character device be configured via a
>    sysfs attribute?
> 
>    In this patchset, the first 196095 bytes of the character device are
>    dedicated as a selection area to choose which Counter components or
>    extensions should be exposed; the subsequent bytes are the actual
>    data for the Counter components and extensions that were selected.

That sounds like the worst of all possible worlds.  Reality is you need
to do some magic library so at that point you might as well have ioctl
options to configure it.   I wonder if you can keep the data flow
to be a simple 'read' from the chardev but move the control away from
that.  Either control via some chrdevs but keep them to the 'set / get'
if this element is going to turn up in the read or not.  You rapidly
run into problems though, such as now to see how large a given element
is going to be etc.  Plus ioctls are rather messier to extend than
simply adding a new sysfs file.  Various subsystems do complex
'descriptor' type approaches to get around this, or you could do
self describing records rather than raw data - like an input
ev_dev event.

> 
>    Moving this selection to a sysfs attribute and dedicating the
>    character device to just data transfer might be a better design. If
>    such a design is chosen, should the selection attribute be
>    human-readable or binary?

Sysfs basically requires things are more or less human readable.
So if you go that way I think it needs to be.

> 
> 2. How much space should allotted for strings?
> 
>    Each Counter component and extension has a respective size allotted
>    for its data (u8 data is allotted 1 byte, u64 data is allotted 8
>    bytes, etc.); I have arbitrarily chosen to allot 64 bytes for
>    strings. Is this an apt size, or should string data be allotted more
>    or less space?

I'd go with that being big enough, but try to keep the expose interface
such that the size can change it it needs to the in the future.

> 
> 3. Should the owning component of an extension be handled by the device
>    driver or Counter subsystem?
> 
>    The Counter subsystem figures out the owner (enum counter_owner_type)
>    for each component/extension in the counter-sysfs and counter-chrdev
>    code. When a callback must be executed, there are various switch
>    statements throughout the code to check whether the respective
>    Device, Signal, or Count version of the callback should be executed;
>    similarly, the appropriate owner type must match for the struct
>    counter_data macros such as COUNTER_DATA_DEVICE_U64,
>    COUNTER_DATA_SIGNAL_U64, COUNTER_DATA_COUNT_U64, etc.
> 
>    All this complexity in the Counter subsystem code can be eliminated
>    if a single callback type with a `void *owner` parameter is defined
>    for use with all three owner types (Device, Signal, and Count). The
>    device driver would then be responsible for casting the callback
>    argument to the appropriate owner type; but in theory, this should
>    not be much of a problem since the device driver is responsible for
>    assigning the callbacks to the owning component anyway.

Whilst its more complex for subsytem I think it's better to keep everything
typed if we possibly can.  Always a trade off though, so use your discretion.

Jonathan


> 
> William Breathitt Gray (4):
>   counter: Internalize sysfs interface code
>   docs: counter: Update to reflect sysfs internalization
>   counter: Add character device interface
>   docs: counter: Document character device interface
> 
>  Documentation/driver-api/generic-counter.rst |  275 +++-
>  MAINTAINERS                                  |    3 +-
>  drivers/counter/104-quad-8.c                 |  547 +++----
>  drivers/counter/Makefile                     |    1 +
>  drivers/counter/counter-chrdev.c             |  656 ++++++++
>  drivers/counter/counter-chrdev.h             |   16 +
>  drivers/counter/counter-core.c               |  187 +++
>  drivers/counter/counter-sysfs.c              |  881 +++++++++++
>  drivers/counter/counter-sysfs.h              |   14 +
>  drivers/counter/counter.c                    | 1496 ------------------
>  drivers/counter/ftm-quaddec.c                |   89 +-
>  drivers/counter/stm32-lptimer-cnt.c          |  161 +-
>  drivers/counter/stm32-timer-cnt.c            |  139 +-
>  drivers/counter/ti-eqep.c                    |  211 +--
>  include/linux/counter.h                      |  626 ++++----
>  include/linux/counter_enum.h                 |   45 -
>  include/uapi/linux/counter-types.h           |   45 +
>  17 files changed, 2826 insertions(+), 2566 deletions(-)
>  create mode 100644 drivers/counter/counter-chrdev.c
>  create mode 100644 drivers/counter/counter-chrdev.h
>  create mode 100644 drivers/counter/counter-core.c
>  create mode 100644 drivers/counter/counter-sysfs.c
>  create mode 100644 drivers/counter/counter-sysfs.h
>  delete mode 100644 drivers/counter/counter.c
>  delete mode 100644 include/linux/counter_enum.h
>  create mode 100644 include/uapi/linux/counter-types.h
> 

