Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5FE4307DE
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhJQKZM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 06:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234815AbhJQKZM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 06:25:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677E561179;
        Sun, 17 Oct 2021 10:23:02 +0000 (UTC)
Date:   Sun, 17 Oct 2021 11:27:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PULL] 1st set of counter subsystem new features for the 5.16
 cycle.
Message-ID: <20211017112717.1c1d8779@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/counter-for-5.16a

for you to fetch changes up to c9638a65d7982b5069a500cc5c504e7a7faa2676:

  docs: counter: Include counter-chrdev kernel-doc to generic-counter.rst (2021-10-17 10:57:18 +0100)

----------------------------------------------------------------
First set of and counter subsystem new feature support for the 5.16 cycle

Most interesting element this time is the new chrdev based interface
for the counter subsystem.  Affects all drivers. Some minor precursor
patches.

Major parts:
* Bring all the sysfs attribute setup into the counter core rather than
  leaving it to individual drivers.  Docs updates accompany these changes.
* Move various definitions to a uapi header as now needed from userspace.
* Add the chardev interface + extensive documentation and example tool
* Add new ABI needed to identify indexes needed for chrdev interface
* Implement new interface for the 104-quad-8
* Follow up deals with wrong path for documentation build
* Various trivial cleanups and missing feature additions related to this
  series

----------------------------------------------------------------
Jonathan Cameron (1):
      counter: microchip-tcb-capture: Tidy up a false kernel-doc /** marking.

Randy Dunlap (1):
      counter: fix docum. build problems after filename change

William Breathitt Gray (15):
      counter: stm32-lptimer-cnt: Provide defines for clock polarities
      counter: stm32-timer-cnt: Provide defines for slave mode selection
      counter: Internalize sysfs interface code
      counter: Update counter.h comments to reflect sysfs internalization
      docs: counter: Update to reflect sysfs internalization
      counter: Move counter enums to uapi header
      counter: Add character device interface
      docs: counter: Document character device interface
      tools/counter: Create Counter tools
      counter: Implement signalZ_action_component_id sysfs attribute
      counter: Implement *_component_id sysfs attributes
      counter: Implement events_queue_size sysfs attribute
      counter: 104-quad-8: Replace mutex with spinlock
      counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
      docs: counter: Include counter-chrdev kernel-doc to generic-counter.rst

 Documentation/ABI/testing/sysfs-bus-counter        |   38 +-
 Documentation/driver-api/generic-counter.rst       |  363 ++++-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 MAINTAINERS                                        |    3 +-
 drivers/counter/104-quad-8.c                       |  699 +++++----
 drivers/counter/Kconfig                            |    6 +-
 drivers/counter/Makefile                           |    1 +
 drivers/counter/counter-chrdev.c                   |  578 ++++++++
 drivers/counter/counter-chrdev.h                   |   14 +
 drivers/counter/counter-core.c                     |  191 +++
 drivers/counter/counter-sysfs.c                    |  960 +++++++++++++
 drivers/counter/counter-sysfs.h                    |   13 +
 drivers/counter/counter.c                          | 1496 --------------------
 drivers/counter/ftm-quaddec.c                      |   60 +-
 drivers/counter/intel-qep.c                        |  146 +-
 drivers/counter/interrupt-cnt.c                    |   62 +-
 drivers/counter/microchip-tcb-capture.c            |   93 +-
 drivers/counter/stm32-lptimer-cnt.c                |  212 ++-
 drivers/counter/stm32-timer-cnt.c                  |  195 +--
 drivers/counter/ti-eqep.c                          |  180 +--
 include/linux/counter.h                            |  720 +++++-----
 include/linux/counter_enum.h                       |   45 -
 include/linux/mfd/stm32-lptimer.h                  |    5 +
 include/linux/mfd/stm32-timers.h                   |    4 +
 include/uapi/linux/counter.h                       |  154 ++
 tools/Makefile                                     |   13 +-
 tools/counter/Build                                |    1 +
 tools/counter/Makefile                             |   53 +
 tools/counter/counter_example.c                    |   92 ++
 29 files changed, 3604 insertions(+), 2794 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter.h
 create mode 100644 tools/counter/Build
 create mode 100644 tools/counter/Makefile
 create mode 100644 tools/counter/counter_example.c
