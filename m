Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9F2DA7D6
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 06:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgLOFod (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 00:44:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:57001 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgLOFoX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Dec 2020 00:44:23 -0500
IronPort-SDR: VvwCcBJN0DSjAsgS2uKt6hEj0y9opGndLzo2y4Xf4QK/k976IkPxJUvKN4uYHC1rXLmeAfjTEB
 KeW2CelJyfGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="162576864"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="162576864"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:43:37 -0800
IronPort-SDR: jIxZw/brTBRn9cR8X64lGTxIUlvmorASMbO8/fL0W6mSp1oUVD/e/OvIfx4xlmliwANWDZxAsP
 Bawv0iPbUQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="351719719"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2020 21:43:36 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v4 0/3] add custom hinge sensor support
Date:   Tue, 15 Dec 2020 13:44:41 +0800
Message-Id: <20201215054444.9324-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Here we register one iio device with three channels which present angle for
hinge, keyboard and screen.

This driver works on devices with Intel integrated sensor hub, where
hinge sensor is presented using a custom sensor usage id.

Here the angle is presented in degrees, which is converted to radians.

Changes since v3:
  - hid-sensor-custom: remove sensor_inst::custom_pdev_exposed.
  - hid-sensor-custom: use static buf, w_buf to avoid using goto in 
    get_known_custom_sensor_index.
  - hid-sensor-custom-intel-hinge: use devm_ prefix function instead.
  - sysfs-bus-iio: put in_anglY_raw together with in_angl_raw.

Changes since v2:
  - use 1 iio device instead of 3 for hinge sensor.
  - use indexed channel instead of modified channel and added channel
    labels.
  - remove 2,3 patch in last version, add a document patch to describe the
    hinge channels.
  - hid-sensor-custom: use meaningful return value in 
    get_known_custom_sensor_index and checked in call side.
  - hid-sensor-ids.h: use HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x) to 
    define custom sensor value.

Changes since v1:
  - fixed errors reported by lkp

Ye Xiang (3):
  HID: hid-sensor-custom: Add custom sensor iio support
  iio: hid-sensors: Add hinge sensor driver
  iio:Documentation: Add documentation for hinge sensor channels

 Documentation/ABI/testing/sysfs-bus-iio       |  11 +
 drivers/hid/hid-sensor-custom.c               | 143 +++++++
 .../hid-sensors/hid-sensor-attributes.c       |   2 +
 drivers/iio/position/Kconfig                  |  16 +
 drivers/iio/position/Makefile                 |   1 +
 .../position/hid-sensor-custom-intel-hinge.c  | 391 ++++++++++++++++++
 include/linux/hid-sensor-ids.h                |  14 +
 7 files changed, 578 insertions(+)
 create mode 100644 drivers/iio/position/hid-sensor-custom-intel-hinge.c

-- 
2.17.1

