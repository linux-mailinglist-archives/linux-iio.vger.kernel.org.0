Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAE0361285
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 20:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhDOSw7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 14:52:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:31157 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhDOSw6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Apr 2021 14:52:58 -0400
IronPort-SDR: iCQog4TSMRZgcB/LMvbyZy8VkTsQayTTur8j5c2Ogt0EpUq2BMBTK4iPvznEQ0Tu5G5ROAZxnd
 XNJoU0PcuKqg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="192792352"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="192792352"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 11:52:34 -0700
IronPort-SDR: DFBCUJEtDxUksTKRKNaAlzx0BVuxqACJB5p62qimFIR67QXky9d9LfVyRQsFMzqUCKGbsjveTz
 8urLasqI4jbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="384108664"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2021 11:52:33 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, jic23@kernel.org, benjamin.tissoires@redhat.com
Cc:     jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] HID: hid-sensor-custom: Process failure of sensor_hub_set_feature()
Date:   Thu, 15 Apr 2021 11:52:32 -0700
Message-Id: <20210415185232.2617398-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When user modifies a custom feature value and sensor_hub_set_feature()
fails, return error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Replaces patch: HID: hid-sensor-custom: remove useless variable
by Jiapeng Chong <jiapeng.chong@linux.alibaba.com> 

 drivers/hid/hid-sensor-custom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 2628bc53ed80..58b54b127cdf 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -406,6 +406,8 @@ static ssize_t store_value(struct device *dev, struct device_attribute *attr,
 								report_id;
 		ret = sensor_hub_set_feature(sensor_inst->hsdev, report_id,
 					     index, sizeof(value), &value);
+		if (ret)
+			return ret;
 	} else
 		return -EINVAL;
 
-- 
2.27.0

