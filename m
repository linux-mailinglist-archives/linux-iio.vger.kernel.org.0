Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531C631B0BE
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 15:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBNOcB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 09:32:01 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14614 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhBNOcB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 09:32:01 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EET6mu013816;
        Sun, 14 Feb 2021 09:31:09 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gathfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 09:31:09 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11EEV7sr007466
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 14 Feb 2021 09:31:08 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Sun, 14 Feb 2021 06:31:06 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Sun, 14 Feb 2021 06:31:06 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 14 Feb 2021 06:31:05 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11EEV2tp027551;
        Sun, 14 Feb 2021 09:31:03 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/5] iio: kfifo: define a devm_iio_kfifo_buffer_setup helper
Date:   Sun, 14 Feb 2021 16:33:08 +0200
Message-ID: <20210214143313.67202-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=725 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140120
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a re-spin of an older set [1]:
 https://patchwork.kernel.org/project/linux-iio/patch/20200401125936.6398-1-alexandru.ardelean@analog.com/

Patch 'iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()' is
already be present in a fixes-togreg path. It did not make it yet
downstream in the iio-togreg path.

Following [1], where there was a suggestion to name this
'devm_iio_device_attach_new_kfifo_buffer()', I took another look and
devm_iio_kfifo_buffer_setup() made more sense, since there is already a
'{devm_}iio_triggered_buffer_setup()' helper.

This reduces the usage of the iio_device_attach_buffer() helper to a
more manage-able state.
This is related to comment:
  https://lore.kernel.org/linux-iio/CA+U=Dsp5hxd9=rNbigUMFALBpPVBqDZDRq_Pe69ggKak7p46=w@mail.gmail.com/T/#u

This should have gone before the multibuffer patch-set, but I was still
waiting on patch 'iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()'
to make it downstream in iio-togreg.

Regarding patch 'iio: kfifo: un-export devm_iio_kfifo_allocate() function'
I would have also wanted to un-export iio_kfifo_allocate() &
iio_kfifo_free(), but that still needs a bit of work to cleanup the IIO
dummy buffer.
Related to patchset:
  https://lore.kernel.org/linux-iio/20201203095005.72252-1-alexandru.ardelean@analog.com/

The IIO dummy driver seems to be one of those blockers in cleaning up
some IIO API.

Alexandru Ardelean (5):
  iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()
  iio: kfifo: add devm_iio_kfifo_buffer_setup() helper
  iio: make use of devm_iio_kfifo_buffer_setup() helper
  iio: accel: sca3000: use devm_iio_kfifo_buffer_setup() helper
  iio: kfifo: un-export devm_iio_kfifo_allocate() function

 .../driver-api/driver-model/devres.rst        |  2 +-
 drivers/iio/accel/sca3000.c                   | 19 ++-------
 drivers/iio/accel/ssp_accel_sensor.c          | 14 +++----
 drivers/iio/adc/ina2xx-adc.c                  | 14 +++----
 drivers/iio/adc/ti_am335x_adc.c               | 24 +++--------
 drivers/iio/buffer/kfifo_buf.c                | 42 ++++++++++++++++++-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 13 +++---
 drivers/iio/gyro/ssp_gyro_sensor.c            | 14 +++----
 drivers/iio/health/max30100.c                 | 16 ++++---
 drivers/iio/health/max30102.c                 | 16 ++++---
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 14 +++----
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 13 +++---
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 15 +++----
 drivers/iio/light/acpi-als.c                  | 12 +++---
 drivers/iio/light/apds9960.c                  | 16 ++++---
 .../staging/iio/impedance-analyzer/ad5933.c   | 23 ++--------
 include/linux/iio/kfifo_buf.h                 |  7 +++-
 17 files changed, 125 insertions(+), 149 deletions(-)

-- 
2.17.1

