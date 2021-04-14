Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78AA35FC08
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 21:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353523AbhDNTzX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 15:55:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:35237 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353557AbhDNTzV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Apr 2021 15:55:21 -0400
IronPort-SDR: 3PfOXKML9eXtcbSriSwLYu0zqfSxBGvol+LkqOEwJF6EYxd/8LaSjjPIad8+G/p/8cnMNwLPs/
 wJuk3dokdGnA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258686526"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="258686526"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:54:58 -0700
IronPort-SDR: 6vhpZ4Hej12rSFO4cFI5+VgBbFUISmrtcjkqGX9qoL8JF5KM8B0zRN8TK054frgtM/JfRHyxct
 HyC4eo8KcC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="612222039"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2021 12:54:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C66A12A; Wed, 14 Apr 2021 22:55:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 7/7] dt-bindings: iio: st,st-sensors: Add LSM9DS0 compatible string
Date:   Wed, 14 Apr 2021 22:54:54 +0300
Message-Id: <20210414195454.84183-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enumerate LSM9DS0 (accelerometer and magnetometer parts) via
'st,lsm9ds0-imu' compatible string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index db291a9390b7..43d29a7d46f1 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -74,6 +74,8 @@ properties:
       - st,lps33hw
       - st,lps35hw
       - st,lps22hh
+        # IMU
+      - st,lsm9ds0-imu
 
   reg:
     maxItems: 1
-- 
2.30.2

