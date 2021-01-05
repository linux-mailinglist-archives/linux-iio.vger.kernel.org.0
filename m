Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3812EA7A0
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 10:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbhAEJek (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 04:34:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:51517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbhAEJej (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 04:34:39 -0500
IronPort-SDR: iIZjQI8lTTWOnFQZ4k0uYher14n+PmsxMavVJ0faCHBI+Qs3Ccg7YjgLOXfxHUMz5Sg384Wr9i
 dzS1U9N/cetw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156864057"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="156864057"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:33:58 -0800
IronPort-SDR: ayhnyVIbtcxpWaoh+NV2jXWd2dSblSzETMdRw2UHa5/WbzXcSUVyPVwEBZ0xn0zMMlz7Y5w1ax
 0jNC6Ge7Lm9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="569665126"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2021 01:33:57 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 0/6] Add timestamp channel for hid-sensors
Date:   Tue,  5 Jan 2021 17:35:09 +0800
Message-Id: <20210105093515.19135-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series add a timestamp channel for hid sensors,
including gravity sensor, gyro sensor, magnetometer sensor,
ambient light sensor, inclinometer sensor, and rotation sensor.

With this patch series, user can get the time when sensor yield
a sample.

Ye Xiang (6):
  iio: hid-sensor-accel-3d: Add timestamp channel for gravity sensor
  iio: hid-sensor-gyro-3d: Add timestamp channel
  iio: hid-sensor-als: Add timestamp channel
  iio: hid-sensor-magn-3d: Add timestamp channel
  iio: hid-sensor-incl-3d: Add timestamp channel
  iio: hid-sensor-rotation: Add timestamp channel

 drivers/iio/accel/hid-sensor-accel-3d.c       |  6 ++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 40 +++++++++-------
 drivers/iio/light/hid-sensor-als.c            | 39 ++++++++-------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 48 ++++++++++++-------
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 43 ++++++++++-------
 drivers/iio/orientation/hid-sensor-rotation.c | 46 ++++++++++--------
 6 files changed, 134 insertions(+), 88 deletions(-)

-- 
2.17.1

