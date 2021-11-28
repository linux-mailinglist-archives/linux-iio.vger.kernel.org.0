Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4F460804
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbhK1R1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358646AbhK1RZH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:25:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58745C061756
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 09:19:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 448C8B80D25
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84035C004E1;
        Sun, 28 Nov 2021 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638119992;
        bh=wsSbwwsJ6BVGm5oexDgYiN6rjMDe54n1bV2uhmfS7E8=;
        h=From:To:Cc:Subject:Date:From;
        b=IkQ/seywLZ8QygpfEaPnlCyQrEhBgicw85PBo4TOq8LSmzuMRKhchk5HCRYBsPqzC
         nNxAvZvMe918D2ZLCsCFol8fKlZ0JwGwOjZlaoc1qXbpQhio0pQ/aQMlLB6ZgzcCnE
         cXvj4hhq+dhBI4qu1dsoKkUWlSltO7CQqcm6YRBPiec1FTWMYp8YhFqDuP08klD36I
         h58RQ6AHEQHN2VSc8+muffI2/cxO6NxynSWrcDtBug+tu5EFQ4anYPCt1LrDcrN4VY
         WS1rluSioQZsKHW0HbsgB2KSitzNUNLmrMEwrV8t9NImar3Q9mc9888ufMrEgEXUYE
         mBYdTSTB+JjoQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Baptiste Mansuy <bmansuy@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: [PATCH 00/12] IIO: clang W=1 warning cleanup.
Date:   Sun, 28 Nov 2021 17:24:33 +0000
Message-Id: <20211128172445.2616166-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi All,

In the interests of noise reduction in warnings during build tests of
new code, this series suppresses a bunch of warnings seen with
LLVM=1 W=1.

Note I am seeing two others I haven't fixed here.  One is tied up in
the existing CONFIG_PM* cleanup patch set and will be dealt with as
part of that.  The other in tsl2772 looks like it might be a bug that
needs further analysis. If anyone is curious:

drivers/iio/light/tsl2772.c:576:24: warning: variable 'prox_diode_mask' set but not used [-Wunused-but-set-variable]
        int i, ret, num_leds, prox_diode_mask;     

As is common with series like this, some of the drivers are old
and as such I haven't cc'd original authors etc and would appreciate
a sanity check from anyone who has the time.

Mauro and Arnd are cc'd on a bunch of them because a media patch that
I happened to see had similar fixes + discussion of type to use in the
casting. For some others I've just picked on people who touched
the driver in last year or so.

Nothing in this series should have any functional affect.

Jonathan

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: Baptiste Mansuy <bmansuy@invensense.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Jonathan Cameron (12):
  iio:accel:bma180: Suppress clang W=1 warning about pointer to enum
    conversion.
  iio:dc:ina2xx-adc: Suppress clang W=1 warning about pointer to enum
    conversion.
  iio:adc:rcar: Suppress clang W=1 warning about pointer to enum
    conversion.
  iio:adc:ti-ads1015: Suppress clang W=1 warning about pointer to enum
    conversion.
  iio:amplifiers:hmc425a: Suppress clang W=1 warning about pointer to
    enum conversion.
  iio:dac:mcp4725: Suppress clang W=1 warning about pointer to enum
    conversion.
  iio:imu:inv_icm42600: Suppress clang W=1 warning about pointer to enum
    conversion.
  iio:imu:inv_mpu6050: Suppress clang W=1 warning about pointer to enum
    conversion.
  iio:magn:ak8975: Suppress clang W=1 warning about pointer to enum
    conversion.
  iio:dummy: Drop set but unused variable len.
  iio:accel:bmc150: Mark structure __maybe_unused as only needed with
    for pm ops.
  iio:accel:kxcjk-1013: Mark struct __maybe_unused to avoid warning.

 drivers/iio/accel/bma180.c                      | 2 +-
 drivers/iio/accel/bmc150-accel-core.c           | 2 +-
 drivers/iio/accel/kxcjk-1013.c                  | 2 +-
 drivers/iio/adc/ina2xx-adc.c                    | 2 +-
 drivers/iio/adc/rcar-gyroadc.c                  | 3 +--
 drivers/iio/adc/ti-ads1015.c                    | 2 +-
 drivers/iio/amplifiers/hmc425a.c                | 2 +-
 drivers/iio/dac/mcp4725.c                       | 2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c     | 2 --
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c       | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c       | 2 +-
 drivers/iio/magnetometer/ak8975.c               | 2 +-
 14 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.34.1

