Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4422224C8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgGPOBy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgGPN7d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86E4C08C5CE
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b6so7136182wrs.11
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAwxCR3FswqosS52SCWPUccYu39mwWTweivr1S93PDQ=;
        b=WbSrvjzZ+me1f7OJ0qgvWTaTmehnJm51LUwmlCUhKUbF+qlvIe4uGE2/KNcZJqlOMU
         uSIqdcHRC43EfSL5b4dXl6pKp874ICuqayB9J64srbBrfJwvtaZxqRKfAj9d7qxBqecw
         wiARRCC5VitFz7463p6C8ZsZ0lAIZn+Fxeh9/LcDBlMNuE7BWSGzOopUiEQQ9eTAB3R1
         OSdUPfuXprrxgsUFw0giAdc6jEoVZ9kNHpbRjelXdNxQnvuswdbseDlIWzXKlmBn2AOt
         nDRPyfJZ9B1LtPSVozgoje/+YG8yIBAwjX3KADMyfMSv31gUA3TMnue9Jc7CZUrSxJQ5
         27Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAwxCR3FswqosS52SCWPUccYu39mwWTweivr1S93PDQ=;
        b=JniYqPkfxX8GaQ23utZERj2iqVmzX4DUW/GmyO/cRMSHj8HM1geuwdYAYsSfeSlo9P
         G7k6EN8XnlQ/504DQe9I4aw8PztBehrPLVpuiC3PfDlGshNpTuKfm823DB91BKGFq5wq
         4eO1sjxwZJyoPayCADq2Izxmm9iw/gSWcqnVUIYq0ZSw3zet/I0OA97mr4eGvA3/ryaq
         /+o8i7Mtu+v2BGNa7jSm9Ki++myYJevpl9lVXwGpkfQCB0wiY50p57u9E4SbSaxDUBg9
         Nl5YSViJdqXCbaV1OwT8rIaU1eyHQX4R5qmBddnC0LXYKZ84x8zkcWx7mgJ5M8ZFWVN/
         pq2g==
X-Gm-Message-State: AOAM533sfRzU2R4+UxeAT3+mhqlQlkzvK3h7rZLGgnfztZdwK/XIRpVo
        gpykAFQGoFFNajpHZYwiWhN1IA==
X-Google-Smtp-Source: ABdhPJzpkee4iDYRSwY5SxXKdttWlHBS7plXBxXLtYs5VNEVnJJ6o7JJbBDYVzv8HwciPazGJkB60Q==
X-Received: by 2002:adf:ef46:: with SMTP id c6mr5230088wrp.34.1594907971551;
        Thu, 16 Jul 2020 06:59:31 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/30] First batch of W=1 fixes for IIO
Date:   Thu, 16 Jul 2020 14:58:58 +0100
Message-Id: <20200716135928.1456727-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (30):
  iio: adc: ad_sigma_delta: Remove unused variable 'ret'
  iio: accel: bma220_spi: Do not define 'struct acpi_device_id' when
    !CONFIG_ACPI
  iio: common: ms_sensors: ms_sensors_i2c: Fix misspelling of parameter
    'client'
  iio: adc: ad7298: Demote obvious misuse of kerneldoc to standard
    comment blocks
  iio: chemical: sgp30: Add description for sgp_read_cmd()'s
    'duration_us'
  iio: adc: ad7923: Demote obvious misuse of kerneldoc to standard
    comment blocks
  iio: dac: ad5360: Fix kerneldoc attribute formatting for 'lock'
  iio: dac: ad5380: Fix kerneldoc attribute formatting for 'lock'
  iio: dummy: iio_simple_dummy: Demote unworthy kerneldocs and correct
    misspelling
  iio: dummy: iio_simple_dummy: Add newline after function-end
  iio: dac: ad5421: Fix kerneldoc attribute formatting for 'lock'
  iio: gyro: adis16080: Fix formatting issue and compiler attribute
    ordering
  iio: dummy: iio_simple_dummy_events: Demote file header and supply
    descriptions for val2 params
  iio: dac: ad5064: Value returned by ad5064_vref_name may not be 'const
    * const'
  iio: dummy: iio_dummy_evgen: Demote file header and supply description
    for 'irq_sim_domain'
  iio: adc: ad7887: Demote seemingly unintentional kerneldoc header
  iio: adc: ad7949: Fix misspelling issue and compiler attribute
    ordering
  iio: dummy: iio_simple_dummy_buffer: Demote file header and correct
    misspelling
  iio: dac: ad5064: Fix a few kerneldoc misdemeanours
  iio: dac: ad5446: Complete 'struct ad5446_state' doc and demote
    unworthy kerneldocs
  iio: dac: ad5449: Fix kerneldoc attribute formatting for 'lock'
  iio: dac: ad5755: Fix kerneldoc attribute formatting for 'lock'
  iio: dac: ad5758: Move and fix-up kerneldoc header and demote unworthy
    kerneldoc
  iio: dac: ad5761: Fix kerneldoc attribute formatting for 'lock'
  iio: dac: ad5764: Fix misdocumenting and formatting error
  iio: dac: ad5791: Complete 'struct ad5791_chip_info' documentation
  iio: light: cm32181: Fix formatting and docrot issues in
    cm32181_acpi_get_cpm()
  iio: magnetometer: mmc35240: Fix function header formatting
  iio: imu: kmx61: Fix formatting in kerneldoc function headers
  iio: dac: ad7303: Complete 'struct ad7303_state' doc and reorder
    compiler attribute

 drivers/iio/accel/bma220_spi.c                 |  2 ++
 drivers/iio/adc/ad7298.c                       |  8 ++++----
 drivers/iio/adc/ad7887.c                       |  2 +-
 drivers/iio/adc/ad7923.c                       |  8 ++++----
 drivers/iio/adc/ad7949.c                       |  4 ++--
 drivers/iio/adc/ad_sigma_delta.c               |  7 ++-----
 drivers/iio/chemical/sgp30.c                   |  1 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c |  2 +-
 drivers/iio/dac/ad5064.c                       | 10 +++++-----
 drivers/iio/dac/ad5360.c                       |  2 +-
 drivers/iio/dac/ad5380.c                       |  2 +-
 drivers/iio/dac/ad5421.c                       |  2 +-
 drivers/iio/dac/ad5446.c                       | 11 +++++++----
 drivers/iio/dac/ad5449.c                       |  2 +-
 drivers/iio/dac/ad5755.c                       |  2 +-
 drivers/iio/dac/ad5758.c                       | 18 +++++++++---------
 drivers/iio/dac/ad5761.c                       |  2 +-
 drivers/iio/dac/ad5764.c                       |  5 ++---
 drivers/iio/dac/ad5791.c                       | 10 ++++------
 drivers/iio/dac/ad7303.c                       |  5 ++++-
 drivers/iio/dummy/iio_dummy_evgen.c            |  4 +++-
 drivers/iio/dummy/iio_simple_dummy.c           |  7 ++++---
 drivers/iio/dummy/iio_simple_dummy_buffer.c    |  4 ++--
 drivers/iio/dummy/iio_simple_dummy_events.c    |  4 +++-
 drivers/iio/gyro/adis16080.c                   |  4 ++--
 drivers/iio/imu/kmx61.c                        | 14 +++++++-------
 drivers/iio/light/cm32181.c                    |  8 ++++----
 drivers/iio/magnetometer/mmc35240.c            |  4 ++--
 28 files changed, 81 insertions(+), 73 deletions(-)

-- 
2.25.1

