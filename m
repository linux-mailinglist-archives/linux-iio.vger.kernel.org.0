Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9455B1D3
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiFZMUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiFZMUv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745E1E029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32B56B80D8D
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFA6C341CA;
        Sun, 26 Jun 2022 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246048;
        bh=Jbc17BAv8JhOQORze3FdzpPnw8TTj/mEz2sLZINfUbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iX2tCXbGdXu06bO9l7bA3GbnRW9NWyUR0zTh3n/Zg6efiERj5cjzZAViSSgfgaBzs
         jvCOR4R5YFRMgrAjlvx/YHGj3WTZoDhTBZi7f+LUwm0OYY/wr0/3Xcgt3Ed8kXbZlE
         ydP2Rr2IH1HKmgBh5AhHyWxNdUI0CgoZ70XapGymuMtz8ATXR4JzW1WSeEncvd6PpX
         YVuNbsE+n00IpMGb7Dtl9CVWFDYiajJHRiOJK1xOxZ8l4vdhV+qXMrawUQB1vMW/Di
         rcFsA4i3vqzOASsE9MGUt3ftQdC/ai0kgScJBHpC/6xXI0Cicv1S/ZZgqFzj6/rbpI
         7QpVndDT9aB5Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 11/17] iio: core: Introduce _zeropoint for differential channels
Date:   Sun, 26 Jun 2022 13:29:32 +0100
Message-Id: <20220626122938.582107-12-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626122938.582107-1-jic23@kernel.org>
References: <20220626122938.582107-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Address an ABI gap for device where the offset of both lines in a
differential pair may be controlled so as to allow a wider range of
inputs, but without having any direct effect of the differential
measurement.

_offset cannot be used as to remain in line with existing usage,
userspace would be expected to apply it as (_raw + _offset) * _scale
whereas _zeropoint is not. i.e. If we were computing the differential
in software it would be.
((postive_raw + _zeropoint) - (negative_raw + zeropoint) + _offset) * _scale
= ((postive_raw - negative_raw) + _offset) * _scale
= (differential_raw + _offset) * _scale

Similarly calibbias is expected to tweak the measurement seen, not
the adjust the two lines of the differential pair.

Needed for in_capacitanceX-capacitanceY_zeropoint for the
AD7746 CDC driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 19 +++++++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/linux/iio/types.h               |  1 +
 3 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d3a0c0ef8948..1dfd6c3f2bd0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -204,6 +204,25 @@ Description:
 		is required is a consistent labeling.  Units after application
 		of scale and offset are nanofarads.
 
+What:		/sys/.../iio:deviceX/in_capacitanceY-capacitanceZ_zeropoint
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For differential channels, this an offset that is applied
+		equally to both inputs. As the reading is of the difference
+		between the two inputs, this should not be applied to the _raw
+		reading by userspace (unlike _offset) and unlike calibbias
+		it does not affect the differential value measured because
+		the effect of _zeropoint cancels out across the two inputs
+		that make up the differential pair. It's purpose is to bring
+		the individual signals, before the differential is measured,
+		within the measurement range of the device. The naming is
+		chosen because if the separate inputs that make the
+		differential pair are drawn on a graph in their
+		_raw  units, this is the value that the zero point on the
+		measurement axis represents. It is expressed with the
+		same scaling as _raw.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 8225d0c43010..fbd7d6bd6f98 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -169,6 +169,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
+	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index a7aa91f3a8dc..27143b03909d 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -63,6 +63,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
 	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
 	IIO_CHAN_INFO_CALIBAMBIENT,
+	IIO_CHAN_INFO_ZEROPOINT,
 };
 
 #endif /* _IIO_TYPES_H_ */
-- 
2.36.1

