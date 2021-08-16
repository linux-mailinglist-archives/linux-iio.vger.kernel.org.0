Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410623ED041
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhHPIan (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhHPIam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:30:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E9C0613C1
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i22so6411631edq.11
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sguei1c/h61zjHr2lg83Dxlja5iaCKAVm3XBX1DjStw=;
        b=dHn+G6xxvhjTJifDvs/b0ZOJ29t0Kr/9D85CGF/SuaJgqAHCDdnvGGLLBwZqwvB+ee
         77CIv07LyQt2yaZQlx26MsSr/YTmh8XODzLSCWWi6+dkr1um5xqFH9S+te3+J1BKFxBh
         FQ/4+BpZZRykTOSxKELdqn4Pgq4wUH7HmOO15Ru1fxg93xVqlvttTfT846uOnVx39ssK
         bvXLKsK2rSLOKoS2JRSZDfNqL1HePDtzx5vgy0PoLtFD5illQIQf0utm2jSuxjemQYfG
         qlwSnhcmV8ovtTjR+EIKrauz25czwdhf0dzpMmEc5lE+FdyqGskXhjVBk+CxvybuYGn+
         eUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sguei1c/h61zjHr2lg83Dxlja5iaCKAVm3XBX1DjStw=;
        b=VRT8MAFTkQG0vjNjitFCUX2hp94Wh/bViANSALoGQUPgmMzNdG97rwU7h5CvVWH30b
         ur9skrpSW631OdAUbAvM3ac2tVymfV8tUiQ52bea8FLw9zAcdxYNCatdezdchSO+hj3H
         gDwAVFPeB8zJc0Fln55HoB1HbIUP/Ig0pyrvv77ZhvCxC+PQ0DScs+5OefgcvgXX6He7
         09KMRDjhTidUz5HOQGFbNg/mCv4gQP26u1K4yKRq/o5ecNtFoSEDhaPg3UK/O8x2XIvb
         NsceHp1WW1GqlseNpJzImHf6sgbhLWNMS9+czT1r8UfVqznu41965OZvUrIrFx73Fc4a
         LCXg==
X-Gm-Message-State: AOAM532dbSXtYOzGblh47W9Exsdox2ifKVd/dCppuaJp2ZbP0eZ/ono6
        Ir8eqrYgMAESTVEbKPPtFGoXEGRWxC+KYU+H
X-Google-Smtp-Source: ABdhPJz9vtplg3RDLAOkBIVgz2gWX8LPgMckWpmXk2GFQO0/L3k96Gex/nn/LNdDu6yCS1LNpVU3Kg==
X-Received: by 2002:aa7:c585:: with SMTP id g5mr18704540edq.340.1629102610043;
        Mon, 16 Aug 2021 01:30:10 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id q30sm4516878edi.84.2021.08.16.01.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:30:09 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 0/5] iio: st_sensors: convert probe functions to full devm
Date:   Mon, 16 Aug 2021 11:28:31 +0300
Message-Id: <20210816082836.67511-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

