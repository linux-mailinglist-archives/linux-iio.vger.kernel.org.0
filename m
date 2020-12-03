Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740D62CCD9C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 04:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgLCDxc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 22:53:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:12273 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbgLCDxc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Dec 2020 22:53:32 -0500
IronPort-SDR: jEJqWFdUzzKNjbJTyh0d3TBEHsSV0QLz15hZhUHJwRgKnynlYctt72oSPyE4TUDsLGmwGjMqhn
 2wA5kIHBXsTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="257842976"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="257842976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 19:52:51 -0800
IronPort-SDR: l0YdXfNiKZsWtjx681fhtTA9zLIPjGYM4qZ5ZjxSD3RmrJmDR0QTHPI8mw2m4GHPhibwsOxQAy
 ZfxzIMzll37w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="550330025"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2020 19:52:49 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: add custom hinge sensor support
Date:   Thu,  3 Dec 2020 11:53:49 +0800
Message-Id: <20201203035352.13918-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Here three separate iio devices are presented which presents angle for
hinge, keyboard and screen.

This driver works on devices with Intel integrated sensor hub, where
hinge sensor is presented using a custom sensor usage id.

Here the angle is presented in degrees, which is converted to radians.

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

 Documentation/ABI/testing/sysfs-bus-iio       |  17 +
 drivers/hid/hid-sensor-custom.c               | 181 ++++++++
 .../hid-sensors/hid-sensor-attributes.c       |   2 +
 drivers/iio/position/Kconfig                  |  16 +
 drivers/iio/position/Makefile                 |   1 +
 .../position/hid-sensor-custom-intel-hinge.c  | 393 ++++++++++++++++++
 include/linux/hid-sensor-ids.h                |  14 +
 7 files changed, 624 insertions(+)
 create mode 100644 drivers/iio/position/hid-sensor-custom-intel-hinge.c

-- 
2.17.1

