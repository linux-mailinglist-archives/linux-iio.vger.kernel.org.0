Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4747B3F499E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhHWLXT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 07:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhHWLXS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 07:23:18 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63C2C061757
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:22:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e21so20336436ejz.12
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ogj0NVywnjlLLKG1/1qOFRC5dRW1kNgnUReqK85wfg=;
        b=iN0rYLlArwbPjzfMxoJzqhhxJb5WIc8HpucPW+PCKIm/ysh8CnZmDuqWVafdl2GQzc
         gY/i47lP+Z2pdm16aC07i3R2mzGX+FVVKM1YMZpn6oy+YH03w3CofbEsCyIvjuhtbIaG
         Xj2xrWZNjRe5kxYwqsE6AYl9WXT/8ji5jn234l81NAOhkWuqekFywzs2humjVpg9Hrvm
         rJhKyrrEH349JiqjXnLRp5QILd2lfR0ges9PmAY7O7Qr+gz9jzziIcepYz/8FgXRkrlS
         LHXKPEs3ST1Qy0VUuMHYsTuJKCOPUuw5YFcWAOc3QeQynYssq11ftdpvUNXbizG7iXyn
         lWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ogj0NVywnjlLLKG1/1qOFRC5dRW1kNgnUReqK85wfg=;
        b=oiKBbQaePbXNidqxLX+vSp6G3PSUS0+YWtzv8OQDPWpg6ZUGOEtAFLcDRkc5V/8RmE
         4yPPv5aT9S9nwhaYq4bAggtpP1ZgSMyzN94AYcOpNcBkXOW20uMb94bU1ZyfZzHc3bNJ
         YPalHSWeQKMA7wY7+4CgsPMnU6soriI7px7jaopa1uTzbDncfcOEvi5UmgvZ4dLuO2BZ
         tGGaiQ1a/gR+uQ882vWGKGiXdlTzhNFBpUhh0/JFT2cxOI0yGLL2jQ+sc52g7z+UPeT2
         ZXEz7PO+H4bgzK5mkqakFFzOu3aZcPHgVXzMB/TVZa5Boaz9bw3BJvy8zEXzy0rBXBrc
         hj9Q==
X-Gm-Message-State: AOAM533cQ8gNVTBLOkL8myMYjamZCCFtXFqLjf/LwhHIPO3HqKsR8EDL
        ADGjX+z0JK9cP9CdoPi3BpB6OsXLmpRae/hE
X-Google-Smtp-Source: ABdhPJyf3hmgp/3IdXQcOWkgrYROTHTyqyg6zR8AFEwtPs3o/RxQPCnhzpW0kFZXtklr4XhmErjf1g==
X-Received: by 2002:a17:906:7847:: with SMTP id p7mr27314091ejm.335.1629717754090;
        Mon, 23 Aug 2021 04:22:34 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id d22sm7382212ejj.47.2021.08.23.04.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:22:33 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, andy.shevchenko@gmail.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 0/5] iio: st_sensors: convert probe functions to full devm 
Date:   Mon, 23 Aug 2021 14:21:59 +0300
Message-Id: <20210823112204.243255-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v2 - v3:
* https://lore.kernel.org/linux-iio/20210816082836.67511-1-aardelean@deviqon.com/
* Fixed a build warning
  - When debugging is disabled dev_dbg() ops become a noop and this causes 
    a warning
  - Reported-by: kernel test robot <lkp@intel.com>
  - https://lore.kernel.org/linux-iio/202108180707.05EmDSHt-lkp@intel.com/
* added tag 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' to
  series
* added tag 'Reviewed-by: Linus Walleij <linus.walleij@linaro.org>' to
  patch 'iio: st_sensors: disable regulators after device unregistration'

Changelog v1 - v2:
* https://lore.kernel.org/linux-iio/20210726071404.14529-1-aardelean@deviqon.com/
* added patch 'iio: st_sensors: disable regulators after device unregistration'
  - splits the regulator disable fix in a separate patch


Alexandru Ardelean (5):
  iio: st_sensors: disable regulators after device unregistration
  iio: st_sensors: remove st_sensors_deallocate_trigger() function
  iio: st_sensors: remove st_sensors_power_disable() function
  iio: st_sensors: remove all driver remove functions
  iio: st_sensors: remove reference to parent device object on
    st_sensor_data

 drivers/iio/accel/st_accel_core.c             | 31 ++---------
 drivers/iio/accel/st_accel_i2c.c              | 23 +-------
 drivers/iio/accel/st_accel_spi.c              | 23 +-------
 .../iio/common/st_sensors/st_sensors_core.c   | 34 ++++++------
 .../iio/common/st_sensors/st_sensors_i2c.c    |  1 -
 .../iio/common/st_sensors/st_sensors_spi.c    |  1 -
 .../common/st_sensors/st_sensors_trigger.c    | 53 +++++++------------
 drivers/iio/gyro/st_gyro_core.c               | 27 ++--------
 drivers/iio/gyro/st_gyro_i2c.c                | 23 +-------
 drivers/iio/gyro/st_gyro_spi.c                | 23 +-------
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h       |  1 -
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  | 17 +-----
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  6 ---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  6 ---
 drivers/iio/magnetometer/st_magn_core.c       | 29 ++--------
 drivers/iio/magnetometer/st_magn_i2c.c        | 23 +-------
 drivers/iio/magnetometer/st_magn_spi.c        | 23 +-------
 drivers/iio/pressure/st_pressure_core.c       | 27 ++--------
 drivers/iio/pressure/st_pressure_i2c.c        | 23 +-------
 drivers/iio/pressure/st_pressure_spi.c        | 23 +-------
 include/linux/iio/common/st_sensors.h         | 13 -----
 21 files changed, 59 insertions(+), 371 deletions(-)

-- 
2.31.1

