Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905C53D53AC
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhGZGdo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhGZGdl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 02:33:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2DC061760
        for <linux-iio@vger.kernel.org>; Mon, 26 Jul 2021 00:14:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nd39so14967172ejc.5
        for <linux-iio@vger.kernel.org>; Mon, 26 Jul 2021 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+qLKSiIn7HNMf6/bTQMR2K4OTHRd9f7CQlxNuufkvY=;
        b=OCatUbQgWGAWcsrCHABpdl78tzlAWqGos/HhsOUNhWsGIWWuPdY6tZ9Jv0UivBtUO5
         fqPXGHHWhIP/FjmaaXrL8CuBK9vQ8yEMzzRHy1NjilHWOmPYS8gvceB2Dx3PwT/3VoXH
         zKRVPsy1hkrBxsyu2BxaZVPZXpwqooHTUSi8lVnmgS76V4zfbXzT4YsQxmiHKc8lHC4x
         zKDczljKTbshKSNYFC2iNXAs9qzfz9k4SQy1C8x5qHOVRSKMCWZm217ceMVTpCV9dlfz
         nxVxNYg12flYjwbe+uv5ikU0E7vhTMERkJOSHvSdHvT5cFOhpIT0EFSh2H96Pw670kta
         p83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+qLKSiIn7HNMf6/bTQMR2K4OTHRd9f7CQlxNuufkvY=;
        b=neOh4nBvS+XBljXsbNdfUQFajYIvT4/Jxd0T8qTEP0aKgflecbgdlHEchptXrsM4Qk
         AjNmQFBYZ1shNSWYJkCvsUJVQAXbdHjmUnPZgP3y4pPZ/LZis5PvqpKVnxuzeAx5S8g6
         q+JRvSi4DPFEE9M4P6uazVUqfOr3ChbR7/p5AwLXj4VO58jYXdvxs4L+FJHWYpNOFJRp
         4hiQ0R/fuIhTZuVSHzz88QLDJuTGK42WVo1U+M0UFDP62OqUl0hZJrsy9PiILLGQb0ry
         4r0fnggDTVSILHIQYaXICfkoUXf4fEALyMZFNChfRfy9J7KWGvcXwFCHvERDKOz0mavG
         9IXg==
X-Gm-Message-State: AOAM530mou4UQhKQD2hfCQnyAcAWH0TIuzMvOgzJQLGPKbZdDu94WT8Y
        mf75FNe1x0nGwX1rdf7K69rHNLoG5rUk5BA/hFg=
X-Google-Smtp-Source: ABdhPJyBVOGyomVCr8mSL5bNCaaf6WTJVa8QAaQ6XmuOwO5GCeSNXDXC2544TgU3Ddk3IA+DxKrsKg==
X-Received: by 2002:a17:906:4f01:: with SMTP id t1mr7438109eju.388.1627283647775;
        Mon, 26 Jul 2021 00:14:07 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id v13sm13863772ejh.62.2021.07.26.00.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 00:14:07 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 0/4] iio: st_sensors: convert probe functions to full devm
Date:   Mon, 26 Jul 2021 10:14:00 +0300
Message-Id: <20210726071404.14529-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Continuing from series:
  https://lore.kernel.org/linux-iio/20210720074642.223293-1-aardelean@deviqon.com/

This goes a little further and converts all ST drivers using the st_common
bits to devm functions.
As mentioned by Jonathan, the devm unwind is often attached to
iio_dev->dev.parent, and something it's attached to some other pointer
which references the same device object.

In the last patch, that point is removed, to eliminate doubt about this
mix-n-match.
An alternative would be an assert/check somewhere to ensure that
'iio_dev->dev.parent == adata->dev'. But I [personally] don't like it that
much.

As mentioned previously, I was also thinking of sending this set with the
previous one. But I am usually reserved to send large sets; also, because I
don't really like to review large sets [when I'm reviewing other people's
code].

Alexandru Ardelean (4):
  iio: st_sensors: remove st_sensors_deallocate_trigger() function
  iio: st_sensors: remove st_sensors_power_disable() function
  iio: st_sensors: remove all driver remove functions
  iio: st_sensors: remove reference to parent device object on
    st_sensor_data

 drivers/iio/accel/st_accel_core.c             | 32 +++--------
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
 21 files changed, 60 insertions(+), 371 deletions(-)

-- 
2.31.1

