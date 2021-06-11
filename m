Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4403A4789
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhFKROH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhFKROH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6610E613CF;
        Fri, 11 Jun 2021 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431529;
        bh=ooftVA7kjYZVFGk66UEnydjAYTYq5y58V1yshQxX8uk=;
        h=From:To:Cc:Subject:Date:From;
        b=ex48lUHw2XH46VuaLsFrZljE1lYWD0vnC/vnVCM50W0/ZpJDShtcXoSuNK8WsjTED
         KAtFHuHyjYkOAQ+8oqViJG/1FevI1KFN2cwSL8tLG3+vI6KTxPB8j9uN17Sk0f2n63
         HDcjq8QP4p9KRwgUrdg7uGJi35TVlXCF9hu/dCuuPQ7mQLI8SHpAw0jkb7bGRAZ+z2
         EjtgfiZ6JcEcV0PKJbLAsN2viuEI4SCBV4iGSoWS5NEZTdw7FH28S+kBl+zPWBil+f
         INvct2w0ZW72krl+GonwXuR4To4uWd3t1hP/Q4Y6r6qGazac01rcutW0q2L/tHXdJu
         fhUdrHy42l+wQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Harinath Nampally <harinath922@gmail.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH 00/12] iio:accel: Header Cleanups.
Date:   Fri, 11 Jun 2021 18:13:42 +0100
Message-Id: <20210611171355.202903-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

0-day recently started running the include-what-you-use checker with LLVM builds.
After it identified a header we should have dropped in a particular patch,
I decided to experiment with it a little and see if it was useful for tidying
up includes that have gotten rather out of sync with the code over the years.

Note the tool is something I'd only advocate using to give you hints on what
might want adjusting so each of these was done by hand inspection.

I've grouped them by manufacturer as otherwise we would have a lot of patches.
Note that the big 'many device / device type' drivers have been done separately
so you won't see them in this series.

I'm rather hoping this approach may ease getting reviews of these, but we
shall see.  If people have time to look at ones I haven't directly cc'd them
on that would be great. There are some drivers touched in here where I don't
know of a current maintainer.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aleksei Mamlin <mamlinav@gmail.com>
Cc: Dan Robertson <dan@dlrobertson.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Harinath Nampally <harinath922@gmail.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Jonathan Bakker <xc-racer2@live.ca>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Sean Nyekjaer <sean@geanix.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>

Jonathan Cameron (12):
  iio:accel:adxl372: Cleanup includes
  iio:accel:bma180: Use generic device properties.
  iio:accel:bosch drivers: Cleanup includes
  iio:accel:miramems drivers: Cleanup headers
  iio:accel:domintech: Cleanup includes.
  iio:accel:fxls8962af: Add a few missing includes.
  iio:accel:kionix drivers: Cleanup includes
  iio:accel:mc3220: Cleanup includes.
  iio:accel:freescale drivers: Cleanup includes
  iio:accel:memsic drivers: Cleanup includes
  iio:accel:murata/vti drivers: Include cleanups for the sca**** parts.
  iio:accel:sensortek drivers: Add some includes

 drivers/iio/accel/adxl372.c           |  4 ++--
 drivers/iio/accel/adxl372.h           |  2 ++
 drivers/iio/accel/adxl372_spi.c       |  3 +--
 drivers/iio/accel/bma180.c            | 11 +++++------
 drivers/iio/accel/bma220_spi.c        |  2 +-
 drivers/iio/accel/bma400_core.c       |  1 -
 drivers/iio/accel/bma400_spi.c        |  1 -
 drivers/iio/accel/bmc150-accel-core.c |  1 +
 drivers/iio/accel/bmc150-accel-spi.c  |  1 -
 drivers/iio/accel/bmi088-accel-core.c |  3 ---
 drivers/iio/accel/bmi088-accel-spi.c  |  3 ++-
 drivers/iio/accel/da280.c             |  3 +--
 drivers/iio/accel/da311.c             |  4 ++--
 drivers/iio/accel/dmard06.c           |  4 +++-
 drivers/iio/accel/dmard09.c           |  2 ++
 drivers/iio/accel/dmard10.c           |  2 +-
 drivers/iio/accel/fxls8962af-core.c   |  3 ++-
 drivers/iio/accel/kxcjk-1013.c        |  4 +++-
 drivers/iio/accel/kxsd9-i2c.c         |  3 ---
 drivers/iio/accel/kxsd9-spi.c         |  5 +----
 drivers/iio/accel/kxsd9.c             |  1 -
 drivers/iio/accel/kxsd9.h             |  2 ++
 drivers/iio/accel/mc3230.c            |  2 +-
 drivers/iio/accel/mma7455_core.c      |  3 ++-
 drivers/iio/accel/mma7455_i2c.c       |  1 +
 drivers/iio/accel/mma7455_spi.c       |  1 +
 drivers/iio/accel/mma7660.c           |  3 +++
 drivers/iio/accel/mma8452.c           |  5 +++++
 drivers/iio/accel/mma9551.c           |  7 ++++---
 drivers/iio/accel/mma9551_core.h      |  2 ++
 drivers/iio/accel/mma9553.c           |  6 ++++--
 drivers/iio/accel/mxc4005.c           |  4 ++++
 drivers/iio/accel/mxc6255.c           |  5 ++---
 drivers/iio/accel/sca3000.c           |  5 ++---
 drivers/iio/accel/sca3300.c           |  3 ++-
 drivers/iio/accel/stk8312.c           |  3 +++
 drivers/iio/accel/stk8ba50.c          |  2 ++
 37 files changed, 69 insertions(+), 48 deletions(-)

-- 
2.31.1

