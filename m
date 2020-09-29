Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FCE27CE2B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgI2Mzf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:55:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29438 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728215AbgI2Mze (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 08:55:34 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TCtI6F008005;
        Tue, 29 Sep 2020 08:55:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg63538-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 08:55:27 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08TCtPxX003287
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 08:55:25 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 05:55:17 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 05:55:17 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TCtIuN024384;
        Tue, 29 Sep 2020 08:55:19 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <srinivas.pandruvada@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/9] iio: remove iio_buffer_set_attrs() and assign buffer attrs during alloc
Date:   Tue, 29 Sep 2020 15:59:40 +0300
Message-ID: <20200929125949.69934-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_04:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=983
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290113
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a v2 & v3 for [1]:
  https://lore.kernel.org/linux-iio/20200925083743.46469-1-alexandru.ardelean@analog.com/

It also includes a at91-sama5d2_adc cleanup patch in this series:
  https://lore.kernel.org/linux-iio/20200924102902.136169-1-alexandru.ardelean@analog.com/
This patch is required, in order to make the removal of
iio_buffer_set_attrs() a bit cleaner in the at91-sama5d2_adc driver.

Following the discussion from [1], this patchset implements the
following:

Changelog v2 -> v3:
* in patch 'iio: buffer: dmaengine: unwrap the use of iio_buffer_set_attrs()'
  - minor stylistic change;

Changelog v1 -> v2:
* rename '{devm_}iio_triggered_buffer_setup()' -> 
         '{devm_}iio_triggered_buffer_setup_ext()'
  - wrap with macros the new ext functions to preserve backwards
    compatibility
  - add a new parameter to the ext functions, which are the
    buffer->attrs
* split into separate patches the removal [from each driver] of
  iio_buffer_set_attrs() and the switch to a
  {devm_}iio_triggered_buffer_setup_ext variant
* add patch to remove iio_buffer_set_attrs() from DMAEngine IIO buffer
* remove the iio_buffer_set_attrs() helper in a final/separate patch
* add 'at91-sama5d2_adc: merge buffer & trigger' patch in this series,
  so that the removal of iio_buffer_set_attrs() is easier to view

Alexandru Ardelean (9):
  iio: buffer: dmaengine: unwrap the use of iio_buffer_set_attrs()
  iio: adc: at91-sama5d2_adc: merge buffer & trigger init into a
    function
  iio: triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext
    variants
  iio: accel: adxl372: use devm_iio_triggered_buffer_setup_ext()
  iio: accel: bmc150: use iio_triggered_buffer_setup_ext()
  iio: adc: at91-sama5d2_adc: use devm_iio_triggered_buffer_setup_ext()
  iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()
  iio: hid-sensors: use iio_triggered_buffer_setup_ext()
  iio: buffer: remove iio_buffer_set_attrs() helper

 drivers/iio/accel/adxl372.c                   | 11 ++-
 drivers/iio/accel/bmc150-accel-core.c         | 25 +++---
 drivers/iio/adc/at91-sama5d2_adc.c            | 82 +++++++++----------
 .../buffer/industrialio-buffer-dmaengine.c    |  3 +-
 .../buffer/industrialio-triggered-buffer.c    | 31 ++++---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 15 ++--
 .../common/hid-sensors/hid-sensor-trigger.c   | 22 ++---
 drivers/iio/industrialio-buffer.c             | 12 ---
 include/linux/iio/buffer.h                    |  3 -
 include/linux/iio/triggered_buffer.h          | 23 ++++--
 10 files changed, 113 insertions(+), 114 deletions(-)

-- 
2.17.1

