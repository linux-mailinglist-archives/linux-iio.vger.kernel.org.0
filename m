Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CB224129
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGQQ4B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgGQQ4A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B952DC0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:55:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so15936681wme.5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLkc9nPCuFBlzzdiW7QaC6+VUWcbfx+wZE7RZ/DJmNs=;
        b=sFPByDNA5iYDcZYuDfV45s4PhocxhrjliSkzVTpwzkpMoIJAC+Ow7ygouOnOQC05Fk
         UXof8K/SHdq9efQWfx79WDIdIGG7i3OmiIALVQr5Nh3pvDjdTVMuAGHVZgfiJlRfAvUQ
         /D6G5t/utAdZYH8VmsuOb0k5eBhQwdcvubu1hsT7byxwSm6vfttnDQE1F+cW3zYabv5k
         Y1H5tQZB/pqQcrpgoyd0QuxAowJXUZqHDMgF9+OzyVTHjafWt3j3Exkzm5K2o85Ni0Pn
         BD0IYGGRUFqUPpr4Z/ClpIz8oR50UQyWK3UFQQoh8NPaCYM/C/Alruk3FmmNg5+Rrbgj
         tVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLkc9nPCuFBlzzdiW7QaC6+VUWcbfx+wZE7RZ/DJmNs=;
        b=D+GBIILv32mSXywl/W9uUuQUQMPpYLsQ/mO3C7GEVRBXQ6/yN0OUP7/pKzDse42SjN
         7S3NIWhxkdZW04c0blDuu+1cb9MuZ1HiR8/7cfahRNLdh/RgTUzWmpPvdPyd3piJ9Kgg
         1e3ExPT0MUzXT+qxT68NmQyAhbH0LxhsyNOwFyvxST7LISEWnxeQsDWGkDU+Ogf33g35
         7QP+Kanc39cqkEqaBxSKtSnjPmleHGrRZ27zaD+MczSEDL4LpkFUdkkSvDYeQ2+c2K+b
         a1/RZW4dAtaJgUBxDj+cKiyaDU7/utJCRxs31D77PyaolN1MGQoZ8x/wMhjdZJ99OX4t
         PWdg==
X-Gm-Message-State: AOAM533BKTNqfwhto9/GCnkTf0wB8lDfUtOTSOyhGgOWcHCxx2FGZORT
        PjD4dMsjpVnBK6IFCVDJGecFxw==
X-Google-Smtp-Source: ABdhPJxlRLyTEBRgP66TpNStZ4Vf90Rbo/XRmlXZaoAy3SRK+ONsTDWdNXHOBfZIS1TD/U04dGJsbg==
X-Received: by 2002:a7b:c116:: with SMTP id w22mr9872360wmi.97.1595004958202;
        Fri, 17 Jul 2020 09:55:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:55:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/30] Second batch of W=1 fixes for IIO
Date:   Fri, 17 Jul 2020 17:55:08 +0100
Message-Id: <20200717165538.3275050-1-lee.jones@linaro.org>
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

Only a couple left after this.  I'll sort those next week.

Lee Jones (30):
  iio: adc: ti_am335x_adc: Remove a couple of unused 'read' variables
  iio: adc: twl4030-madc: Remove set but unused variables 'len'
  iio: adc: twl4030-madc: Fix misnamed struct attribute
  iio: magnetometer: hmc5843: 'hmc5843_pm_ops' is unused in 1 of 3 files
    including hmc5843_core.h
  iio: adc: twl6030-gpadc: Fix some misdocumentation and formatting
    issues
  iio: dac: ltc2632: Fix formatting in kerneldoc struct header
  iio: light: si1145: Demote obvious misuse of kerneldoc to standard
    comment blocks
  iio: resolver: ad2s1200: Change ordering of compiler attribute macro
  iio: temperature: mlx90632: Function parameter descriptions must match
    exactly
  iio: light: us5182d: Fix formatting in kerneldoc function block
  iio: adc: ad799x: Demote seemingly unintentional kerneldoc header
  iio: dac: ad5504: Fix formatting errors and demote non-compliant
    kerneldoc
  iio: adc: at91_adc: Fix 'bad line' warning
  iio: adc: at91-sama5d2_adc: Struct kerneldoc titles need to start with
    'struct '
  iio: adc: cpcap-adc: Demote seemingly unintentional kerneldoc header
  iio: accel: sca3000: Fix 2 misspellings and demote nonconforming
    kerneldocs
  iio: gyro: adxrs450: Change ordering of compiler attribute macro
  iio: gyro: fxas21002c: Move 'fxas21002c_reg_fields' to the only file
    its used
  iio: imu: st_lsm6dsx: st_lsm6dsx: Reorder 'inline' declaration
  iio: adc: max1363: Fix kerneldoc attribute formatting for 'lock'
  iio: adc: max9611: Demote obvious misuse of kerneldoc to standard
    comment blocks
  iio: adc: mcp320x: Change ordering of compiler attribute macro
  iio: adc: palmas_gpadc: Demote non-conforming kerneldoc header
  iio: imu: inv_mpu6050: inv_mpu_core: Demote obvious misuse of
    kerneldoc to standard comment blocks
  iio: imu: inv_mpu6050: inv_mpu_ring: Demote seemingly unintentional
    kerneldoc header
  iio: adc: qcom-pm8xxx-xoadc: Demote standard comment block and supply
    missing description
  iio: magnetometer: ak8974: Add description for ak8974's 'scan'
    attribute
  iio: imu: st_lsm6dsx: st_lsm6dsx_shub: Demote obvious misuse of
    kerneldoc to standard comment blocks
  iio: imu: st_lsm6dsx: st_lsm6dsx: Mark 'st_lsm6dsx_accel_ext_info' as
    __maybe_unused
  iio: adc: rockchip_saradc: Demote Demote seemingly unintentional
    kerneldoc header

 drivers/iio/accel/sca3000.c                  | 12 ++--
 drivers/iio/adc/ad799x.c                     |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c           |  4 +-
 drivers/iio/adc/at91_adc.c                   |  2 +-
 drivers/iio/adc/cpcap-adc.c                  |  6 +-
 drivers/iio/adc/max1363.c                    |  2 +-
 drivers/iio/adc/max9611.c                    |  4 +-
 drivers/iio/adc/mcp320x.c                    |  2 +-
 drivers/iio/adc/palmas_gpadc.c               |  3 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c          |  3 +-
 drivers/iio/adc/rockchip_saradc.c            |  2 +-
 drivers/iio/adc/ti_am335x_adc.c              |  8 +--
 drivers/iio/adc/twl4030-madc.c               | 14 ++---
 drivers/iio/adc/twl6030-gpadc.c              |  4 +-
 drivers/iio/dac/ad5504.c                     |  7 +--
 drivers/iio/dac/ltc2632.c                    |  6 +-
 drivers/iio/gyro/adxrs450.c                  |  2 +-
 drivers/iio/gyro/fxas21002c.h                | 66 --------------------
 drivers/iio/gyro/fxas21002c_core.c           | 66 ++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c   | 14 ++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c   |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  8 +--
 drivers/iio/light/si1145.c                   |  6 +-
 drivers/iio/light/us5182d.c                  |  8 +--
 drivers/iio/magnetometer/ak8974.c            |  1 +
 drivers/iio/magnetometer/hmc5843.h           |  6 +-
 drivers/iio/resolver/ad2s1200.c              |  2 +-
 drivers/iio/temperature/mlx90632.c           |  4 +-
 29 files changed, 136 insertions(+), 135 deletions(-)

-- 
2.25.1

