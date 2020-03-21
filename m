Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E494F18E48E
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCUVCT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38067 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCUVCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id z25so946878pfa.5;
        Sat, 21 Mar 2020 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IkkGGKYdy07kXlFkS4u/vEhAKDSCz0CcoWuZRGasA+M=;
        b=mr0X1x08js3DFwYtte6hbtNLwTOvGbzifArLwjodhbuN3oST/RBnjOk2CcaZ9HLQRC
         +axvDTIqkOTGCfIo8VR69Qx/DOv/nIna9g54b7/omwe/rYkl2T+CmlSad/+BF74UjL2o
         Um7G7V/i6nWH1oKdvEd6wO/oSEnW82nYzG9U3phYcVCryWIm5z6AI9ao06iksBj4Wk+8
         WUQBJrYnuf92ItpDvULRdPwAqOkvyTx1HO+Y4JgsQ1u7u+F4CbQI+cEyb7l4P6+/+wnq
         ch8hgdzzTN3ihzkON3Pyr2VaAPPMZq1q+t+/83fDZM9RSd+ix3yvh8e3A5ahIanuouRc
         LHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IkkGGKYdy07kXlFkS4u/vEhAKDSCz0CcoWuZRGasA+M=;
        b=b2jrV5Xgn8QOQmkrCnnyO2wlPp2c0Fhob3znFPVcg5vcs8Aw0xur1OOW1aQoEP+MDO
         6oX9Gxjp6lfQg0ky5Di+ErMTWUby2AYmHMnHhtuAX03TIfH9X7unO+GcKPmzMZYbW0lb
         P5aYWPI21KF4PSjbgpACZ9xrex3l+qMqoxOC1r8XRVqiyL7jqcCFT21y2k3Sv5VSCvdZ
         n7oaV1ZpviKiKgNN2642qPiuRF2d8ylb3q47gX1POp+gtdzIwoW+k4W/hpxVmQOsXOAw
         64SvQ8COrVPEEEtD4XOKovuR3w2+SqTtX5a5svslok//Ggha2Satp/07AESsuS3s3tUq
         /MBw==
X-Gm-Message-State: ANhLgQ0emKE9CM7mg62Vxkuz9XfG5LTRkycfq0yWZx7ahatoGlXkq89q
        6A6Xexja68Lx4J5oyZUakaPrrC+G
X-Google-Smtp-Source: ADFU+vuNYCqW2lfB2CPmutlxgyin6MittV1u86EoTvAhy+/PtinzGIC4IkA1F4hnOsMtfHsImKRQFA==
X-Received: by 2002:a62:1a03:: with SMTP id a3mr16769314pfa.171.1584824537333;
        Sat, 21 Mar 2020 14:02:17 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id nu13sm7963131pjb.22.2020.03.21.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:16 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] iio: Use suitable format specifiers
Date:   Sun, 22 Mar 2020 02:31:51 +0530
Message-Id: <20200321210204.18106-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset utilizes suitable format specifiers while logging errors
which removes unnecessary explicit casting and logs symbolic error names
instead of the error number. 

Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>

Links: https://marc.info/?l=linux-iio&m=158427554607223&w=2
Links: https://marc.info/?l=linux-iio&m=158481647605891&w=2

Nishant Malpani (13):
  iio: accel: kxsd9: Use suitable format specifier
  iio: gyro: bmg160_i2c: Use suitable format specifier
  iio: gyro: bmg160_spi: Use suitable format specifier
  iio: gyro: mpu3050: Use suitable format specifier
  iio: imu: bmi160_i2c: Use suitable format specifier
  iio: imu: bmi160_spi: Use suitable format specifier
  iio: imu: inv_mpu6050_i2c: Use suitable format specifier
  iio: imu: inv_mpu6050_spi: Use suitable format specifier
  iio: magn: bmc150: Use suitable format specifier
  iio: light: st_uvis25_i2c: Use suitable format specifier
  iio: light: st_uvis25_spi: Use suitable format specifier
  iio: st_sensors_i2c: Use suitable format specifier
  iio: st_sensors_spi: Use suitable format specifier

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

