Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6967C18EAB9
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgCVRX2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:23:28 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:34923 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCVRX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:23:28 -0400
Received: by mail-pg1-f169.google.com with SMTP id 7so5933777pgr.2;
        Sun, 22 Mar 2020 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJ3fGMQWCHxOuVVihas81IZRU1KVlIH9WxSFiTv3G5M=;
        b=d3IqceXgvXTrFeMfM3doyrG/sooVRTCix2Cj3v1VR8UpHzL1dw5KT1PnUxxf0FHwBm
         VOwEnmTPB8hL9XTIX1y6/a7BdBOkustIXF5ahYWF4ewaJsSGEe+DlU050LLn4FaWyvE7
         /jI64vesDb/YS2RQR7tV6F9jnV+/yMeeP4/murbJKFUou+2KLChuBZ28DFrxzqGZXI/a
         ibb8sU+7A5hBjju5UI+aBIzY0ARMkHmW7TpLLOSNBsl0t5G9+LHd7PbMQa5amKSGQtSv
         BIVAOw1/54nBOKSEVCN+1CPYql9Zl8hS8jZmTPt+a/UWbb5Gckevwo7V+Tju52Mhn2QI
         NaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJ3fGMQWCHxOuVVihas81IZRU1KVlIH9WxSFiTv3G5M=;
        b=BPrSs1318OsX7MZv/j8RN5CWoQZK+o+f7BjYY8jqWH+VtphLJJiQTCUiodjbrJT7O+
         kc3IzNum9iLH2cOqZCb3L33W33iJIl2oAKw94MSD2E9FPRJ8eJldB2AHmvfvu3D3aLMS
         KpvKE+fYYbXQidF3l39xucAB9VtFhSLfv4u67tA5MvF7zOtO1KQWiFMIff1Dy7UIBiRm
         iaF33b86MtCqM06x3gLPrM/HPPbh9QFDWualhzEBoEVKerccWDUgPQtbfVFJWf/q/B6T
         HlK0OkfwquxopMPSPeKDhK96J1mLjaORLJfuPnsZsAZ7Jkxf+mWwuyCMg3cQ6eRfau2o
         2DnQ==
X-Gm-Message-State: ANhLgQ0XEWvPOh3kz4PW8ub5sN7D8upIDfYoq2RbvRJO7rNS9HwKlsId
        v4fHHELSmtiYZnR+li5n0lJGinAK
X-Google-Smtp-Source: ADFU+vsqGXGNTiN3/mAwZuvL8NLxyOKlbPjyFxSn+m9C2ctQ6jUnEgOvgm7Kp8GTlbngv9FaOvpuzg==
X-Received: by 2002:a63:5123:: with SMTP id f35mr17515337pgb.217.1584897807087;
        Sun, 22 Mar 2020 10:23:27 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id k17sm10782879pfp.194.2020.03.22.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:23:26 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] Use vsprintf extension %pe for symbolic error
Date:   Sun, 22 Mar 2020 22:53:02 +0530
Message-Id: <cover.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset utilizes %pe format specifier from vsprintf while logging
errors which removes unnecessary explicit casting and logs symbolic error
names instead of the error number.

Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
[2] https://marc.info/?l=linux-iio&m=158481647605891&w=2

Changes in v2:
  - Rewrite commit subject line outlining the usage of %pe.
  - Add a separator between regmap and its error name.

Nishant Malpani (13):
  iio: accel: kxsd9: Use vsprintf extension %pe for symbolic error name
  iio: st_sensors_i2c: Use vsprintf extension %pe for symbolic error
    name
  iio: st_sensors_spi: Use vsprintf extension %pe for symbolic error
    name
  iio: gyro: bmg160_i2c: Use vsprintf extension %pe for symbolic error
    name
  iio: gyro: bmg160_spi: Use vsprintf extension %pe for symbolic error
    name
  iio: gyro: mpu3050: Use vsprintf extension %pe for symbolic error name
  iio: imu: bmi160_i2c: Use vsprintf extension %pe for symbolic error
    name
  iio: imu: bmi160_spi: Use vsprintf extension %pe for symbolic error
    name
  iio: imu: inv_mpu6050_i2c: Use vsprintf extension %pe for symbolic
    error name
  iio: imu: inv_mpu6050_spi: Use vsprintf extension %pe for symbolic
    error name
  iio: light: st_uvis25_i2c: Use vsprintf extension %pe for symbolic
    error name
  iio: light: st_uvis25_spi: Use vsprintf extension %pe for symbolic
    error name
  iio: magn: bmc150: Use vsprintf extension %pe for symbolic error name

 drivers/iio/accel/kxsd9-i2c.c                  | 4 ++--
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
 drivers/iio/common/st_sensors/st_sensors_spi.c | 4 ++--
 drivers/iio/gyro/bmg160_i2c.c                  | 4 ++--
 drivers/iio/gyro/bmg160_spi.c                  | 4 ++--
 drivers/iio/gyro/mpu3050-i2c.c                 | 4 ++--
 drivers/iio/imu/bmi160/bmi160_i2c.c            | 4 ++--
 drivers/iio/imu/bmi160/bmi160_spi.c            | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c      | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c      | 4 ++--
 drivers/iio/light/st_uvis25_i2c.c              | 4 ++--
 drivers/iio/light/st_uvis25_spi.c              | 4 ++--
 drivers/iio/magnetometer/bmc150_magn_spi.c     | 4 ++--
 13 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.20.1

