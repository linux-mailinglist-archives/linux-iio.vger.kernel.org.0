Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F89C25E991
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgIERtl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgIERtk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:49:40 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5B4208DB;
        Sat,  5 Sep 2020 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599328179;
        bh=2SOKWC0oReiK8/2VteDoCxuV9GTdXoOfk5Xbd7Et58k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcjeYJrswK3peHMtXQOJfZADe9fFtyPtEv+7gXCPhTOddt9BT1r/RU80fBWC6/rlR
         13hKBdXcuNA0MQGzGbO6Qri7u98nrhrWZs+eztrG66eaVAS4PVma3RajKELntYekPV
         WRS4u7lG/iSx71AFSC/7zj8yypfPAiU7tuCe0GfU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/4] staging:iio:light: drop stale ABI docs
Date:   Sat,  5 Sep 2020 18:47:20 +0100
Message-Id: <20200905174721.216452-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905174721.216452-1-jic23@kernel.org>
References: <20200905174721.216452-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There are no remaining light drivers in staging/iio.
The content of this file are either included in the non staging
ABI docs, or don't seem to be used in any current driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../iio/Documentation/sysfs-bus-iio-light     | 79 -------------------
 1 file changed, 79 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
deleted file mode 100644
index 7c7cd8456060..000000000000
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
+++ /dev/null
@@ -1,79 +0,0 @@
-What:		/sys/bus/iio/devices/device[n]/in_illuminance0[_input|_raw]
-KernelVersion:	2.6.35
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This should return the calculated lux from the light sensor. If
-		it comes back in SI units, it should also include _input else it
-		should include _raw to signify it is not in SI units.
-
-What:		/sys/.../device[n]/proximity_on_chip_ambient_infrared_suppression
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Hardware dependent mode for an ALS device to calculate the value
-		in proximity mode. When this is enabled, then the device should
-		use a infrared sensor reading to remove infrared noise from the
-		proximity reading. If this is not enabled, the driver can still
-		do this calculation manually by reading the infrared sensor
-		value and doing the negation in sw.
-
-What:		/sys/bus/iio/devices/device[n]/in_proximity[_input|_raw]
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property is supported by proximity sensors and should be
-		used to return the value of a reading by the sensor. If this
-		value is returned in SI units, it should also include _input
-		but if it is not, then it should include _raw.
-
-What:		/sys/bus/iio/devices/device[n]/intensity_infrared[_input|_raw]
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property is supported by sensors that have an infrared
-		sensing mode. This value should be the output from a reading
-		and if expressed in SI units, should include _input. If this
-		value is not in SI units, then it should include _raw.
-
-What:		/sys/bus/iio/devices/device[n]/in_illuminance0_target
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property gets/sets the last known external
-		lux measurement used in/for calibration.
-
-What:		/sys/bus/iio/devices/device[n]/in_illuminance0_integration_time
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property gets/sets the sensors ADC analog integration time.
-
-What:		/sys/bus/iio/devices/device[n]/in_illuminance0_lux_table
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property gets/sets the table of coefficients
-		used in calculating illuminance in lux.
-
-What:		/sys/bus/iio/devices/device[n]/in_intensity_clear[_input|_raw]
-What:		/sys/bus/iio/devices/device[n]/in_intensity_red[_input|_raw]
-What:		/sys/bus/iio/devices/device[n]/in_intensity_green[_input|_raw]
-What:		/sys/bus/iio/devices/device[n]/in_intensity_blue[_input|_raw]
-KernelVersion:	3.6.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property is supported by sensors that have a RGBC
-		sensing mode. This value should be the output from a reading
-		and if expressed in SI units, should include _input. If this
-		value is not in SI units (irradiance, uW/mm^2), then it should
-		include _raw.
-
-What:		/sys/bus/iio/devices/device[n]/in_cct0[_input|_raw]
-KernelVersion:	3.6.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This should return the correlated color temperature from the
-		light sensor. If it comes back in SI units, it should also
-		include _input else it should include _raw to signify it is not
-		in SI units.
-
-- 
2.28.0

