Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190502EA5DA
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 08:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbhAEHV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 02:21:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:63487 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbhAEHV3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 02:21:29 -0500
IronPort-SDR: d1wS9ZizdpekpSkIDpTwVpMzx8vUvLalNWgIy6q0DrnSTr1Ih9tL9DQ9v+D8pyvRaue0wl2n/Z
 UxURqtF31QWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="261829285"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="261829285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 23:20:48 -0800
IronPort-SDR: 8y1Lz43BHXXMGaV6M+0bjOS2YzkdWgwTTo9FlxR9ohtpreCZpz7ydt6QORdrJ4MSdiZdh6L031
 7qoiYZEBFDpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="350260533"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2021 23:20:45 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v3 0/6] add timestamp channel for hid-sensors
Date:   Tue,  5 Jan 2021 15:21:57 +0800
Message-Id: <20210105072203.5701-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series add a timestamp channel for hid sensors,
including gravity sensor, gyro sensor, magnetometer sensor,
ambient light sensor, inclinometer sensor, and rotation sensor.

With this patch series, user can get the time when sensor yield
a sample.

---
v3:
  - hid-sensor-magn-3d: fix iio_val buffer len issue.
  - hid-sensor-accel-3d: refine commit message

v2:
  - remove unrelated changes.

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

