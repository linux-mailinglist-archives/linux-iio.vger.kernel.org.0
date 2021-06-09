Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117E3A165A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhFIOBw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 10:01:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3189 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbhFIOBv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 10:01:51 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0T5R0L0fz6L69t;
        Wed,  9 Jun 2021 21:50:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 15:59:54 +0200
Received: from localhost (10.52.124.126) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 14:59:54 +0100
Date:   Wed, 9 Jun 2021 14:59:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     <jic23@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <kernel@pengutronix.de>, <a.fatoum@pengutronix.de>,
        <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <alexandre.belloni@bootlin.com>, <david@lechnology.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <syednwaris@gmail.com>,
        <patrick.havelange@essensium.com>, <fabrice.gasnier@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <o.rempel@pengutronix.de>, <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v11 00/33] Introduce the Counter character device
 interface
Message-ID: <20210609145951.000005dd@Huawei.com>
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.126]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:03 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Changes in v11:
>  - Migrated Intel QEP to new interface
>  - Context adjustments made for documentation
> 
> I pulled out a lot of bits and pieces to their own patches; hopefully
> that makes reviewing this patchset much simpler than before. This
> patchset is also available on my personal public git repo for anyone who
> wants a quick way to clone:
> https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v11
> 
> The patches preceding "counter: Internalize sysfs interface code" are
> primarily cleanup and fixes that can be picked up and applied now to the
> IIO tree if so desired. The "counter: Internalize sysfs interface code"
> patch as well may be considered for pickup because it is relatively safe
> and makes no changes to the userspace interface.

Let us aim to do that in the interests of cutting down on the volume for future
versions!

However, it is made tricky by the fact patch 22 hasn't made it to me or
lore.kernel.org.  Could you send that one again.  Hopefully the in-reply-to
will ensure it's correctly threaded.

Jonathan


> 
> To summarize the main points of this patchset: there are no changes to
> the existing Counter sysfs userspace interface; a Counter character
> device interface is introduced that allows Counter events and associated
> data to be read() by userspace; the events_configure() and
> watch_validate() driver callbacks are introduced to support Counter
> events; and IRQ support is added to the 104-QUAD-8 driver, serving as an
> example of how to support the new Counter events functionality.
> 
> Something that should still be discussed: should the struct
> counter_event "status" member be 8 bits or 32 bits wide? This member
> will provide the return status (system error number) of an event
> operation.

> 
> William Breathitt Gray (33):
>   docs: counter: Consolidate Counter sysfs attributes documentation
>   docs: counter: Fix spelling
>   counter: 104-quad-8: Remove pointless comment
>   counter: 104-quad-8: Return error when invalid mode during
>     ceiling_write
>   counter: 104-quad-8: Annotate hardware config module parameter
>   counter: 104-quad-8: Add const qualifiers for
>     quad8_preset_register_set
>   counter: 104-quad-8: Add const qualifier for functions_list array
>   counter: interrupt-cnt: Add const qualifier for functions_list array
>   counter: microchip-tcb-capture: Add const qualifier for functions_list
>     array
>   counter: stm32-lptimer-cnt: Add const qualifier for functions_list
>     array
>   counter: stm32-timer-cnt: Add const qualifier for functions_list array
>   counter: 104-quad-8: Add const qualifier for actions_list array
>   counter: ftm-quaddec: Add const qualifier for actions_list array
>   counter: interrupt-cnt: Add const qualifier for actions_list array
>   counter: microchip-tcb-capture: Add const qualifier for actions_list
>     array
>   counter: stm32-lptimer-cnt: Add const qualifier for actions_list array
>   counter: stm32-timer-cnt: Add const qualifier for actions_list array
>   counter: Return error code on invalid modes
>   counter: Standardize to ERANGE for limit exceeded errors
>   counter: Rename counter_signal_value to counter_signal_level
>   counter: Rename counter_count_function to counter_function
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
>  Documentation/ABI/testing/sysfs-bus-counter   |  112 +-
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  |   61 -
>  .../ABI/testing/sysfs-bus-counter-ftm-quaddec |   16 -
>  Documentation/driver-api/generic-counter.rst  |  368 +++-
>  .../userspace-api/ioctl/ioctl-number.rst      |    1 +
>  MAINTAINERS                                   |    7 +-
>  drivers/counter/104-quad-8.c                  |  739 ++++----
>  drivers/counter/Kconfig                       |    6 +-
>  drivers/counter/Makefile                      |    1 +
>  drivers/counter/counter-chrdev.c              |  486 ++++++
>  drivers/counter/counter-chrdev.h              |   14 +
>  drivers/counter/counter-core.c                |  192 +++
>  drivers/counter/counter-sysfs.c               |  953 +++++++++++
>  drivers/counter/counter-sysfs.h               |   13 +
>  drivers/counter/counter.c                     | 1496 -----------------
>  drivers/counter/ftm-quaddec.c                 |   61 +-
>  drivers/counter/intel-qep.c                   |  150 +-
>  drivers/counter/interrupt-cnt.c               |   75 +-
>  drivers/counter/microchip-tcb-capture.c       |  105 +-
>  drivers/counter/stm32-lptimer-cnt.c           |  176 +-
>  drivers/counter/stm32-timer-cnt.c             |  149 +-
>  drivers/counter/ti-eqep.c                     |  221 +--
>  include/linux/counter.h                       |  716 ++++----
>  include/linux/counter_enum.h                  |   45 -
>  include/uapi/linux/counter.h                  |  133 ++
>  tools/Makefile                                |   13 +-
>  tools/counter/Build                           |    1 +
>  tools/counter/Makefile                        |   53 +
>  tools/counter/counter_example.c               |   95 ++
>  29 files changed, 3586 insertions(+), 2872 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
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

