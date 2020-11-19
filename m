Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE72B8A3C
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 04:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKSDCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Nov 2020 22:02:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:54164 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgKSDCu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Nov 2020 22:02:50 -0500
IronPort-SDR: ee1+osEuvZgj1J9ZwKw8FWlvUOttCWRB51bsYIwXeniPjb5cGss/WM2XAGffeKGiMpQAgGrbC+
 8DdE0ZGaNaUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="232837897"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="232837897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 19:02:49 -0800
IronPort-SDR: lJSURVluzSCIombdtw+q469gHLy4a5D0p8LkVpbB72G1Ln76A1ZmyTmc5Xflq//UQq2Ila6LOq
 WTWfFf8xt8xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="534584527"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2020 19:02:47 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 0/4] add custom hinge sensor support
Date:   Thu, 19 Nov 2020 11:03:22 +0800
Message-Id: <20201119030326.6447-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Here three separate iio devices are presented which presents angle for
hinge, keyboard and screen.

This driver works on devices with Intel integrated sensor hub, where
hinge sensor is presented using a custom sensor usage id.

Here the angle is presented in degrees, which is converted to radians.

Ye Xiang (4):
  HID: hid-sensor-custom: Add custom sensor iio support
  iio: hid-sensor-trigger: Decrement runtime pm enable count on driver
    removal
  iio: hid-sensor-trigger: Use iio->trig instead trig field internal
    structure
  iio: hid-sensors: Add hinge sensor driver

 drivers/hid/hid-sensor-custom.c               | 169 +++++++
 .../hid-sensors/hid-sensor-attributes.c       |   2 +
 .../common/hid-sensors/hid-sensor-trigger.c   |   8 +-
 drivers/iio/position/Kconfig                  |  16 +
 drivers/iio/position/Makefile                 |   3 +
 .../iio/position/hid-sensor-custom-hinge.c    | 412 ++++++++++++++++++
 include/linux/hid-sensor-ids.h                |  39 ++
 7 files changed, 646 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/position/hid-sensor-custom-hinge.c

-- 
2.17.1

