Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0031C2DA7D2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 06:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgLOFpQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 00:45:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:57027 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgLOFpI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Dec 2020 00:45:08 -0500
IronPort-SDR: 8sSUJL44ZN4IpVaJbayI3/8x6LXNkFHNhUpJZJcopSG6bQgqTJHRF94+kcW72hNV14pwWEEq0M
 MDT3+J0c23Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="162576872"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="162576872"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:43:48 -0800
IronPort-SDR: P15/LseWliFRAsFWwvVkv+igRmbMS0t+FKp5XnIUewP+PCT8b9h0MyYUP+oRO7YgNOEEJ/EoE0
 HXaPbOYqgLAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="351719754"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2020 21:43:46 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v4 3/3] iio:Documentation: Add documentation for hinge sensor channels
Date:   Tue, 15 Dec 2020 13:44:44 +0800
Message-Id: <20201215054444.9324-4-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215054444.9324-1-xiang.ye@intel.com>
References: <20201215054444.9324-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add channel description for hinge sensor, including channel label
attribute and raw data description.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index df42bed09f25..5c0a84c50d43 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -198,6 +198,7 @@ Description:
 		Units after application of scale and offset are m/s^2.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
 KernelVersion:	4.17
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1802,3 +1803,13 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Unscaled light intensity according to CIE 1931/DIN 5033 color space.
 		Units after application of scale are nano nanowatts per square meter.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Optional symbolic label for channel Y.
+		For Intel hid hinge sensor, the label values are:
+		hinge, keyboard, screen. It means the three channels
+		each correspond respectively to hinge angle, keyboard angle,
+		and screen angle.
-- 
2.17.1

