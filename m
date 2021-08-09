Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5F3E4D1A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhHITca (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 15:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233199AbhHITc3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Aug 2021 15:32:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0EE760551;
        Mon,  9 Aug 2021 19:32:04 +0000 (UTC)
Date:   Mon, 9 Aug 2021 20:34:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v15 00/13] Introduce the Counter character device
 interface
Message-ID: <20210809203455.59ad5a61@jic23-huawei>
In-Reply-To: <cover.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Aug 2021 21:37:25 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Changes in v15:
>  - Move the description for the member 'lock' in the 'quad8' structure
>    as a separate patch
>  - Reorganize the "counter: Internalize sysfs interface code" patch to
>    not call chrdev code; respective code moved to the "counter: Add
>    character device interface" patch with the other chrdev code
>  - Custom enums removed from the ftm-quaddec.c, stm32-lptimer-cnt.c, and
>    stm32-timer-cnt.c files; respective drivers refactored to use the
>    COUNTER_FUNCTION_* and COUNTER_SYNAPSE_* enum constants instead
Given this last one isn't trivial, I'll let patch 2 onwards sit
on the list for a little while just to see if anyone wants to take
a look at those changes.  Then I'll take up to patch 5. Whilst some
are precursors to the later patches, they don't do any harm and
will reduce the amount we are asking people to review going forwards.

As for the chrdev part.   My gut feeling is that needs more eyes
yet despite being fairly stable in form for a while now.
I'll try and take another look, and would definitely encourage
others to look at it as well.

New ABI is hard to get right so needs a bit more time than many other
forms of patch set.

Jonathan

> 
> For convenience, this patchset is also available on my personal git
> repo: https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v15
> 
> The patches preceding "counter: Internalize sysfs interface code" are
> primarily cleanup and fixes that can be picked up and applied now to the
> IIO tree if so desired. The "counter: Internalize sysfs interface code"
> patch as well may be considered for pickup because it is relatively safe
> and makes no changes to the userspace interface.
> 
> To summarize the main points of this patchset: there are no changes to
> the existing Counter sysfs userspace interface; a Counter character
> device interface is introduced that allows Counter events and associated
> data to be read() by userspace; the events_configure() and
> watch_validate() driver callbacks are introduced to support Counter
> events; and IRQ support is added to the 104-QUAD-8 driver, serving as an
> example of how to support the new Counter events functionality.
> 
> William Breathitt Gray (13):
>   counter: 104-quad-8: Describe member 'lock' in 'quad8'
>   counter: Internalize sysfs interface code
>   counter: Update counter.h comments to reflect sysfs internalization
>   docs: counter: Update to reflect sysfs internalization
>   counter: Move counter enums to uapi header
>   counter: Add character device interface
>   docs: counter: Document character device interface
>   tools/counter: Create Counter tools
>   counter: Implement signalZ_action_component_id sysfs attribute
>   counter: Implement *_component_id sysfs attributes
>   counter: Implement events_queue_size sysfs attribute
>   counter: 104-quad-8: Replace mutex with spinlock
>   counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
> 
>  Documentation/ABI/testing/sysfs-bus-counter   |   38 +-
>  Documentation/driver-api/generic-counter.rst  |  358 +++-
>  .../userspace-api/ioctl/ioctl-number.rst      |    1 +
>  MAINTAINERS                                   |    3 +-
>  drivers/counter/104-quad-8.c                  |  700 ++++----
>  drivers/counter/Kconfig                       |    6 +-
>  drivers/counter/Makefile                      |    1 +
>  drivers/counter/counter-chrdev.c              |  553 ++++++
>  drivers/counter/counter-chrdev.h              |   14 +
>  drivers/counter/counter-core.c                |  191 +++
>  drivers/counter/counter-sysfs.c               |  962 +++++++++++
>  drivers/counter/counter-sysfs.h               |   13 +
>  drivers/counter/counter.c                     | 1496 -----------------
>  drivers/counter/ftm-quaddec.c                 |   60 +-
>  drivers/counter/intel-qep.c                   |  144 +-
>  drivers/counter/interrupt-cnt.c               |   62 +-
>  drivers/counter/microchip-tcb-capture.c       |   91 +-
>  drivers/counter/stm32-lptimer-cnt.c           |  226 +--
>  drivers/counter/stm32-timer-cnt.c             |  179 +-
>  drivers/counter/ti-eqep.c                     |  180 +-
>  include/linux/counter.h                       |  715 ++++----
>  include/linux/counter_enum.h                  |   45 -
>  include/uapi/linux/counter.h                  |  154 ++
>  tools/Makefile                                |   13 +-
>  tools/counter/Build                           |    1 +
>  tools/counter/Makefile                        |   53 +
>  tools/counter/counter_example.c               |   93 +
>  27 files changed, 3568 insertions(+), 2784 deletions(-)
>  create mode 100644 drivers/counter/counter-chrdev.c
>  create mode 100644 drivers/counter/counter-chrdev.h
>  create mode 100644 drivers/counter/counter-core.c
>  create mode 100644 drivers/counter/counter-sysfs.c
>  create mode 100644 drivers/counter/counter-sysfs.h
>  delete mode 100644 drivers/counter/counter.c
>  delete mode 100644 include/linux/counter_enum.h
>  create mode 100644 include/uapi/linux/counter.h
>  create mode 100644 tools/counter/Build
>  create mode 100644 tools/counter/Makefile
>  create mode 100644 tools/counter/counter_example.c
> 
> 
> base-commit: c886885336b0b5f1a08ce580f7201a2ca30ab041
> prerequisite-patch-id: 8ca55ffcdd5d060dd5fa2b4dd50bf01dc1026da6
> prerequisite-patch-id: 46ef2668ca6bdc0d08dd488fe1d2b886189a5652
> prerequisite-patch-id: 2df1946c917d6408148306db30a071e67b00ad73
> prerequisite-patch-id: f81579f50552e6041a95403cc743c5f36962b111
> prerequisite-patch-id: 8a6860e75cdec162812c56dc39c5d7fc6fc5154e

