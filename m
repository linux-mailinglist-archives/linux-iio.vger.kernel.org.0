Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626B830A2D4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 08:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhBAHoI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 02:44:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:46032 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232285AbhBAHoB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Feb 2021 02:44:01 -0500
IronPort-SDR: TsiY7dA5Rk3U5IiRovrPr/W61CtNZvc7vckQzdPEFQn1wEr2Wxamb56x7MEParlTI38aSeQ/kZ
 iWOu5kKOEpkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="159813887"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="159813887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 23:43:13 -0800
IronPort-SDR: Dp7Tncf4Y6O97lcls1oo+CIOzvj2eMyjQhvy41JB6QYqa/XQesTDMb8K5aLWTFN3DG+GKlsAyo
 yFu71bFfJc4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="432235972"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2021 23:43:11 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 3/3] iio: Add relative hysteresis in ABI documentation
Date:   Mon,  1 Feb 2021 15:43:58 +0800
Message-Id: <20210201074358.18435-4-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201074358.18435-1-xiang.ye@intel.com>
References: <20210201074358.18435-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add relative hysteresis in ABI documentation.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d957f5da5c04..1c51db7eb8ef 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1823,3 +1823,11 @@ Description:
 		hinge, keyboard, screen. It means the three channels
 		each correspond respectively to hinge angle, keyboard angle,
 		and screen angle.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_Y_hysteresis_relative
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specify the percent relative to the current sensor channel
+		Y absolute value that a data field should change before an event
+		is generated. Units are a percentage of the prior reading.
-- 
2.17.1

