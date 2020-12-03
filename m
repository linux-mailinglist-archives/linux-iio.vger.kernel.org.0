Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637FD2CD321
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 11:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgLCKFq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 05:05:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12814 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730207AbgLCKFp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 05:05:45 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B3A0JpP029234;
        Thu, 3 Dec 2020 05:04:53 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vjen9mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 05:04:53 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0B3A4pam054407
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 05:04:52 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 02:04:51 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 02:04:51 -0800
Received: from saturn.ad.analog.com ([10.48.65.108])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B3A4iAe003898;
        Thu, 3 Dec 2020 05:04:48 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 3/5] iio: remove modes init for INDIO_DIRECT_MODE only drivers (manual)
Date:   Thu, 3 Dec 2020 12:04:21 +0200
Message-ID: <20201203100423.77270-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201203100423.77270-1-alexandru.ardelean@analog.com>
References: <20201203100423.77270-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030060
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Coccinele could not catch these, because the 'modes' assignment is done in
a common-probe code for all these drivers.
These drivers support 2 probing modes, and the common probe code is the one
that initializes the 'modes'.

These change removes the 'modes' init for these drivers, since they only
initialize to INDIO_DIRECT_MODE only.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/st_accel_core.c       | 1 -
 drivers/iio/adc/ltc2497-core.c          | 1 -
 drivers/iio/gyro/st_gyro_core.c         | 1 -
 drivers/iio/magnetometer/st_magn_core.c | 1 -
 drivers/iio/pressure/ms5611_core.c      | 1 -
 drivers/iio/pressure/st_pressure_core.c | 1 -
 drivers/iio/temperature/tsys01.c        | 1 -
 drivers/staging/iio/meter/ade7854.c     | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 43c50167d220..18d91328a3ec 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1252,7 +1252,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	size_t channels_size;
 	int err;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &accel_info;
 
 	err = st_sensors_power_enable(indio_dev);
diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 2a485c8a1940..34e64252837a 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -171,7 +171,6 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &ltc2497core_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ltc2497core_channel;
 	indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index c8aa051995d3..a48e43544d46 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -463,7 +463,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	struct st_sensors_platform_data *pdata;
 	int err;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &gyro_info;
 
 	err = st_sensors_power_enable(indio_dev);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 79de721e6015..95606de1535e 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -491,7 +491,6 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 	int err;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &magn_info;
 
 	err = st_sensors_power_enable(indio_dev);
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 214b0d25f598..7c8094f5ae93 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -444,7 +444,6 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 	indio_dev->info = &ms5611_info;
 	indio_dev->channels = ms5611_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ms5611_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = ms5611_scan_masks;
 
 	ret = ms5611_init(indio_dev);
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 789a2928504a..695f77dd4f9f 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -686,7 +686,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 	struct st_sensors_platform_data *pdata = dev_get_platdata(press_data->dev);
 	int err;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &press_info;
 
 	err = st_sensors_power_enable(indio_dev);
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index bbfbad9a8767..6d42dfea050a 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -161,7 +161,6 @@ static int tsys01_probe(struct iio_dev *indio_dev, struct device *dev)
 
 	indio_dev->info = &tsys01_info;
 	indio_dev->name = dev->driver->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = tsys01_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tsys01_channels);
 
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 68da6ecde6a3..e350761dd3f5 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -540,7 +540,6 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &ade7854_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-- 
2.27.0

