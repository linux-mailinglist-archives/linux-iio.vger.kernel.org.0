Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2B23FE9B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgHINsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 09:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHINsH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 09:48:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DDEF206B2;
        Sun,  9 Aug 2020 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596980886;
        bh=QFbCWOIw77RPUSpBEnXe/qUsqDO2Fuu1fu/YIqmRp7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MQUwZzNFX77Gyl0xvoJxmAgvhqPoqlBHOB1sH8j7Nx+PBTWHuD+wZr82yCEDSXuxc
         AiYMnxxiFcqd4usf8MwHlq7uvzzCNpYfPOQXVnhtlf2bKuGANZBA8OcyPNrCl3hZ9q
         MAv6nbJaAIL3TeYKX7QfMYk9+vlTngGD3Iqs+qZc=
Date:   Sun, 9 Aug 2020 14:48:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v4 0/5] Introduce the Counter character device interface
Message-ID: <20200809144800.6b067dea@archlinux>
In-Reply-To: <cover.1595358237.git.vilhelm.gray@gmail.com>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 15:35:46 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Changes in v4:
>  - Reimplement character device interface to report Counter events
>  - Implement Counter timestamps
>  - Implement poll() support
>  - Convert microchip-tcb-capture.c to new driver interface
>  - Add IRQ support for the 104-quad-8 Counter driver
> 
> Over the past couple years we have noticed some shortcomings with the
> Counter sysfs interface. Although useful in the majority of situations,
> there are certain use-cases where interacting through sysfs attributes
> can become cumbersome and inefficient. A desire to support more advanced
> functionality such as timestamps, multi-axes positioning tables, and
> other such latency-sensitive applications, has motivated a reevaluation
> of the Counter subsystem. I believe a character device interface will be
> helpful for this more niche area of counter device use.
> 
> To quell any concerns from the offset: this patchset makes no changes to
> the existing Counter sysfs userspace interface -- existing userspace
> applications will continue to work with no modifications necessary. I
> request that driver maintainers please test their applications to verify
> that this is true, and report any discrepancies if they arise.
> 
> However, this patchset does contain a major reimplementation of the
> Counter subsystem core and driver API. A reimplementation was necessary
> in order to separate the sysfs code from the counter device drivers and
> internalize it as a dedicated component of the core Counter subsystem
> module. A minor benefit from all of this is that the sysfs interface is
> now ensured a certain amount of consistency because the translation is
> performed outside of individual counter device drivers.
> 
> Essentially, the reimplementation has enabled counter device drivers to
> pass and handle data as native C datatypes now rather than the sysfs
> strings from before. A high-level view of how a count value is passed
> down from a counter device driver can be exemplified by the following:
> 
>                  ----------------------
>                 / Counter device       \
>                 +----------------------+
>                 | Count register: 0x28 |
>                 +----------------------+
>                         |
>                  -----------------
>                 / raw count data /
>                 -----------------
>                         |
>                         V
>                 +----------------------------+
>                 | Counter device driver      |----------+
>                 +----------------------------+          |
>                 | Processes data from device |   -------------------
>                 |----------------------------|  / driver callbacks /
>                 | Type: u64                  |  -------------------
>                 | Value: 42                  |          |
>                 +----------------------------+          |
>                         |                               |
>                  ----------                             |
>                 / u64     /                             |
>                 ----------                              |
>                         |                               |
>                         |                               V
>                         |               +----------------------+
>                         |               | Counter core         |
>                         |               +----------------------+
>                         |               | Routes device driver |
>                         |               | callbacks to the     |
>                         |               | userspace interfaces |
>                         |               +----------------------+
>                         |                       |
>                         |                -------------------
>                         |               / driver callbacks /
>                         |               -------------------
>                         |                       |
>                 +-------+---------------+       |
>                 |                       |       |
>                 |               +-------|-------+
>                 |               |       |
>                 V               |       V
>         +--------------------+  |  +---------------------+
>         | Counter sysfs      |<-+->| Counter chrdev      |
>         +--------------------+     +---------------------+
>         | Translates to the  |     | Translates to the   |
>         | standard Counter   |     | standard Counter    |
>         | sysfs output       |     | character device    |
>         |--------------------|     |---------------------+
>         | Type: const char * |     | Type: u64           |
>         | Value: "42"        |     | Value: 42           |
>         +--------------------+     +---------------------+
>                 |                               |
>          ---------------                 -----------------------
>         / const char * /                / struct counter_event /
>         ---------------                 -----------------------
>                 |                               |
>                 |                               V
>                 |                       +-----------+
>                 |                       | read      |
>                 |                       +-----------+
>                 |                       \ Count: 42 /
>                 |                        -----------
>                 |
>                 V
>         +--------------------------------------------------+
>         | `/sys/bus/counter/devices/counterX/countY/count` |
>         +--------------------------------------------------+
>         \ Count: "42"                                      /
>          --------------------------------------------------
> 
> Counter device data is exposed through standard character device read
> operations. Device data is gathered when a Counter event is pushed by
> the respective Counter device driver. Configuration is handled via ioctl
> operations on the respective Counter character device node.
> 
> The following are some questions I have about this patchset:
> 
> 1. Should I support multiple file descriptors for the character device
>    in this introduction patchset?
> 
>    I intend to add support for multiple file descriptors to the Counter
>    character device, but I restricted this patchset to a single file
>    descriptor to simplify the code logic for the sake of review. If
>    there is enough interest, I can add support for multiple file
>    descriptors in the next revision; I anticipate that this should be
>    simple to implement through the allocation of a kfifo for each file
>    descriptor during the open callback.

What is the use case?  I can conjecture one easily enough, but I'm not
sure how real it actually is.  We've been around this question a few
times in IIO :)

Certainly makes sense to design an interface that would allow you to
add this support later if needed though.


> 
> 2. Should struct counter_event have a union for different value types,
>    or just a value u8 array?
> 
>    Currently I expose the event data value via a union containing the
>    various possible Counter data types (value_u8 and value_u64). It is
>    up to the user to select the right union member for the data they
>    received. Would it make sense to return this data in a u8 array
>    instead, with the expectation that the user will cast to the
>    necessary data type?

Be careful on alignment if you do that. We would need to ensure that the
buffer is suitable aligned for a cast to work as expected.

> 
> 3. How should errors be returned for Counter data reads performed by
>    Counter events?
> 
>    Counter events are configured with a list of Counter data read
>    operations to perform for the user. Any one of those data reads can
>    return an error code, but not necessarily all of them. Currently, the
>    code exits early when an error code is returned. Should the code
>    instead continue on, saving the error code to the struct
>    counter_event for userspace to handle?

I'd argue that errors are expected to be rare, so it isn't a problem
to just fault out hard on the first one.

> 
> William Breathitt Gray (5):
>   counter: Internalize sysfs interface code
>   docs: counter: Update to reflect sysfs internalization
>   counter: Add character device interface
>   docs: counter: Document character device interface
>   counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
> 
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  |   32 +
>  Documentation/driver-api/generic-counter.rst  |  363 +++-
>  .../userspace-api/ioctl/ioctl-number.rst      |    1 +
>  MAINTAINERS                                   |    2 +-
>  drivers/counter/104-quad-8.c                  |  753 +++++----
>  drivers/counter/Kconfig                       |    6 +-
>  drivers/counter/Makefile                      |    1 +
>  drivers/counter/counter-chrdev.c              |  441 +++++
>  drivers/counter/counter-chrdev.h              |   16 +
>  drivers/counter/counter-core.c                |  188 +++
>  drivers/counter/counter-sysfs.c               |  849 ++++++++++
>  drivers/counter/counter-sysfs.h               |   14 +
>  drivers/counter/counter.c                     | 1496 -----------------
>  drivers/counter/ftm-quaddec.c                 |   59 +-
>  drivers/counter/microchip-tcb-capture.c       |  104 +-
>  drivers/counter/stm32-lptimer-cnt.c           |  161 +-
>  drivers/counter/stm32-timer-cnt.c             |  139 +-
>  drivers/counter/ti-eqep.c                     |  211 +--
>  include/linux/counter.h                       |  633 +++----
>  include/linux/counter_enum.h                  |   45 -
>  include/uapi/linux/counter.h                  |   90 +
>  21 files changed, 2919 insertions(+), 2685 deletions(-)
>  create mode 100644 drivers/counter/counter-chrdev.c
>  create mode 100644 drivers/counter/counter-chrdev.h
>  create mode 100644 drivers/counter/counter-core.c
>  create mode 100644 drivers/counter/counter-sysfs.c
>  create mode 100644 drivers/counter/counter-sysfs.h
>  delete mode 100644 drivers/counter/counter.c
>  delete mode 100644 include/linux/counter_enum.h
>  create mode 100644 include/uapi/linux/counter.h
> 

