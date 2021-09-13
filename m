Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA44085FD
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbhIMIDO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 04:03:14 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:36196 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhIMIDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 04:03:13 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id D7CF344A0251;
        Mon, 13 Sep 2021 10:01:11 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v2 4/4] iio: documentation: Document scd4x calibration use
Date:   Mon, 13 Sep 2021 10:00:20 +0200
Message-Id: <20210913080020.1265027-5-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913080020.1265027-1-roan@protonic.nl>
References: <20210913080020.1265027-1-roan@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add entries from Documentation/ABI/testing/sysfs-bus-iio-scd30
to Documentation/ABI/testing/sysfs-bus-iio. The attributes of the scd4x
and scd30 are common.

Remove Documentation/ABI/testing/sysfs-bus-iio-scd30.

Signed-off-by: Roan van Dijk <roan@protonic.nl>
---
 Documentation/ABI/testing/sysfs-bus-iio       | 35 +++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-iio-scd30 | 34 ------------------
 2 files changed, 35 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6ad47a67521c..56492c564f72 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1957,3 +1957,38 @@ Description:
 		Specify the percent for light sensor relative to the channel
 		absolute value that a data field should change before an event
 		is generated. Units are a percentage of the prior reading.
+
+What:		/sys/bus/iio/devices/iio:deviceX/calibration_auto_enable
+Date:		June 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Contaminants build-up in the measurement chamber or optical
+		elements deterioration leads to sensor drift.
+
+		One can compensate for sensor drift by using automatic self
+		calibration procedure (asc).
+
+		Writing 1 or 0 to this attribute will respectively activate or
+		deactivate asc.
+
+		Upon reading current asc status is returned.
+
+What:		/sys/bus/iio/devices/iio:deviceX/calibration_forced_value
+Date:		June 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Contaminants build-up in the measurement chamber or optical
+		elements deterioration leads to sensor drift.
+
+		One can compensate for sensor drift by using forced
+		recalibration (frc). This is useful in case there's known
+		co2 reference available nearby the sensor.
+
+		Picking value from the range [400 1 2000] and writing it to the
+		sensor will set frc.
+
+		Upon reading current frc value is returned. Note that after
+		power cycling default value (i.e 400) is returned even though
+		internally sensor had recalibrated itself.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-scd30 b/Documentation/ABI/testing/sysfs-bus-iio-scd30
deleted file mode 100644
index b9712f390bec..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-scd30
+++ /dev/null
@@ -1,34 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/calibration_auto_enable
-Date:		June 2020
-KernelVersion:	5.8
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Contaminants build-up in the measurement chamber or optical
-		elements deterioration leads to sensor drift.
-
-		One can compensate for sensor drift by using automatic self
-		calibration procedure (asc).
-
-		Writing 1 or 0 to this attribute will respectively activate or
-		deactivate asc.
-
-		Upon reading current asc status is returned.
-
-What:		/sys/bus/iio/devices/iio:deviceX/calibration_forced_value
-Date:		June 2020
-KernelVersion:	5.8
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Contaminants build-up in the measurement chamber or optical
-		elements deterioration leads to sensor drift.
-
-		One can compensate for sensor drift by using forced
-		recalibration (frc). This is useful in case there's known
-		co2 reference available nearby the sensor.
-
-		Picking value from the range [400 1 2000] and writing it to the
-		sensor will set frc.
-
-		Upon reading current frc value is returned. Note that after
-		power cycling default value (i.e 400) is returned even though
-		internally sensor had recalibrated itself.
-- 
2.30.2

