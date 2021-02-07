Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFABA31221F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 08:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBGHBF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 02:01:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:37921 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhBGHAj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 02:00:39 -0500
IronPort-SDR: Gr+bell6oMoAuXw/gbuoI+J2HoycL4WjNC2wx2nezfdHkih6gvU+2xRW5CcVVhnSv+um4vvUMU
 nXwYFkU0b0vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="178080521"
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="178080521"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 22:59:57 -0800
IronPort-SDR: hBvHocRx/Q5jLWLzE2EGC06S8naubn7q8XeuF7gscqOwscTc6kXL4p2m986quZamRU9okLOJYX
 XHb2vLqrR3UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="374982534"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2021 22:59:55 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 0/3] Add relative hysteresis support for hid sensors
Date:   Sun,  7 Feb 2021 15:00:45 +0800
Message-Id: <20210207070048.23935-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, hid sensor als are using the relative hysteresis.
This patch series add the relative hysteresis for hid sensors.

---
v2:
  - (1/3) fix the formatting issue in hid_sensor_read_raw_hyst_rel_value.
  - (3/3) add documentation just for light sensor.

Ye Xiang (3):
  iio: Add relative sensitivity support
  iio: hid-sensor-als: Add relative hysteresis support
  iio: Add relative hysteresis in ABI documentation

 Documentation/ABI/testing/sysfs-bus-iio       |  9 +++
 .../hid-sensors/hid-sensor-attributes.c       | 74 ++++++++++++++++++-
 drivers/iio/industrialio-core.c               |  1 +
 drivers/iio/light/hid-sensor-als.c            | 14 +++-
 include/linux/hid-sensor-hub.h                |  5 ++
 include/linux/hid-sensor-ids.h                |  1 +
 include/linux/iio/types.h                     |  1 +
 7 files changed, 99 insertions(+), 6 deletions(-)

-- 
2.17.1

