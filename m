Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57A7312228
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 08:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBGHBg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 02:01:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:37921 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhBGHBR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 02:01:17 -0500
IronPort-SDR: ADBC0v9EBCNAILqUA/a/QKzcJofefhrDVP1AxpCVU9i1VjUEwi4swHwwm+Sgml4UGsTEjtIfZ7
 pn8K5XV5bDcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="178080533"
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="178080533"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 23:00:06 -0800
IronPort-SDR: XOcYDw7ciNpumZCa9skWoQTIdNg3j1wXfiJiUGPMssUQ+F1gA+ExFx1FL8Z3SzuBM0i1eFIEb5
 xVe3yJ4AUkNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="374982618"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2021 23:00:05 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 3/3] iio: Add relative hysteresis in ABI documentation
Date:   Sun,  7 Feb 2021 15:00:48 +0800
Message-Id: <20210207070048.23935-4-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210207070048.23935-1-xiang.ye@intel.com>
References: <20210207070048.23935-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add relative hysteresis in ABI documentation for als sensor.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d957f5da5c04..0890bd113eea 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1823,3 +1823,12 @@ Description:
 		hinge, keyboard, screen. It means the three channels
 		each correspond respectively to hinge angle, keyboard angle,
 		and screen angle.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_hysteresis_relative
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_hysteresis_relative
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specify the percent for light sensor relative to the channel
+		absolute value that a data field should change before an event
+		is generated. Units are a percentage of the prior reading.
-- 
2.17.1

