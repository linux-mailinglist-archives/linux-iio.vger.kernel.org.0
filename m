Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF992B8FB9
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgKSKCl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 05:02:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:10879 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgKSKCl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Nov 2020 05:02:41 -0500
IronPort-SDR: lD+bOX7DJLR88sAEcmbPghNuQNX9QB1g1hAvyCySleaJZLi8o7dmWvCPDM3pl8sv37KYiffOMm
 HXNW6MTZrO3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170482230"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="170482230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 02:02:40 -0800
IronPort-SDR: cTX1HOqcgeoNj3FYRN2M3vITG/2KHztCISZWkOHxjseL6vncF1c2Ezp1qY4O6RdfqABbDqf8ih
 73S+cezSMlOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="359909707"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2020 02:02:38 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 0/4] add custom hinge sensor support
Date:   Thu, 19 Nov 2020 18:03:27 +0800
Message-Id: <20201119100331.2594-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Here three separate iio devices are presented which presents angle for
hinge, keyboard and screen.

This driver works on devices with Intel integrated sensor hub, where
hinge sensor is presented using a custom sensor usage id.

Here the angle is presented in degrees, which is converted to radians.

Changes since v1:
  - fixed errors reported by lkp

Ye Xiang (4):
  HID: hid-sensor-custom: Add custom sensor iio support
  iio: hid-sensor-trigger: Decrement runtime pm enable count on driver
    removal
  iio: hid-sensor-trigger: Use iio->trig instead trig field internal
    structure
  iio: hid-sensors: Add hinge sensor driver

 drivers/hid/hid-sensor-custom.c               | 170 ++++++++
 .../hid-sensors/hid-sensor-attributes.c       |   2 +
 .../common/hid-sensors/hid-sensor-trigger.c   |   8 +-
 drivers/iio/position/Kconfig                  |  16 +
 drivers/iio/position/Makefile                 |   3 +
 .../iio/position/hid-sensor-custom-hinge.c    | 412 ++++++++++++++++++
 include/linux/hid-sensor-ids.h                |  39 ++
 7 files changed, 647 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/position/hid-sensor-custom-hinge.c

-- 
2.17.1

