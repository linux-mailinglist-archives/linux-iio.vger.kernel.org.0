Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FB731D69C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 09:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhBQIdj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 03:33:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40520 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231666AbhBQIdg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 03:33:36 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H8UKC5026100;
        Wed, 17 Feb 2021 03:32:43 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb2hu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 03:32:43 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11H8WfGx055857
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Feb 2021 03:32:42 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Wed, 17 Feb 2021
 00:32:40 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Wed, 17 Feb 2021 00:32:40 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11H8WWlE007757;
        Wed, 17 Feb 2021 03:32:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 0/5] iio: Add output buffer support
Date:   Wed, 17 Feb 2021 10:34:33 +0200
Message-ID: <20210217083438.37865-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_06:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset is based on the new multibuffer set.
It doesn't require the high-speed/mmap interface.
That will come later on a v2.

Changelog v1 -> v2:
* https://lore.kernel.org/linux-iio/20210212102021.47276-4-alexandru.ardelean@analog.com/T/#u
* removed DMA patches for now
* in patch 'iio: Add output buffer support'
  - added /sys/bus/iio/devices/iio:deviceX/bufferY/direction attribute
  - thinking about this, an update to the new buffer infrastructure is
    required when adding ADDAC/MxFE/transceivers; right now there is no
    problem, because we have only ADCs and DACs; but when we get
    transceivers, a bufferY/ directory needs to filter in/out
    scan_elements/ ; this only occured to me recently (it's one of those
    things that pops up later in mind)
* added 'iio: Documentation: update definitions for bufferY and scan_elements'
  - seems I forgot this on the original multibuffer patchset
* added 'iio: triggered-buffer: extend support to configure output buffers'
  - basically output triggered buffer support
* added 'iio: dac: ad5686: Add PWM as a trigger source'
  - this is a first user of this infrastructure

Alexandru Ardelean (2):
  iio: Documentation: update definitions for bufferY and scan_elements
  iio: triggered-buffer: extend support to configure output buffers

Lars-Peter Clausen (2):
  iio: Add output buffer support
  iio: kfifo-buffer: Add output buffer support

Mircea Caprioru (1):
  iio: dac: ad5686: Add PWM as a trigger source

 Documentation/ABI/testing/sysfs-bus-iio       |  92 +++++++++++
 drivers/iio/accel/adxl372.c                   |   1 +
 drivers/iio/accel/bmc150-accel-core.c         |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c            |   4 +-
 .../buffer/industrialio-triggered-buffer.c    |   8 +-
 drivers/iio/buffer/kfifo_buf.c                |  50 ++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
 .../common/hid-sensors/hid-sensor-trigger.c   |   5 +-
 drivers/iio/dac/ad5686-spi.c                  |   2 +-
 drivers/iio/dac/ad5686.c                      | 146 +++++++++++++++++-
 drivers/iio/dac/ad5686.h                      |   7 +-
 drivers/iio/dac/ad5696-i2c.c                  |   2 +-
 drivers/iio/industrialio-buffer.c             | 128 ++++++++++++++-
 include/linux/iio/buffer.h                    |   7 +
 include/linux/iio/buffer_impl.h               |  11 ++
 include/linux/iio/triggered_buffer.h          |  11 +-
 16 files changed, 459 insertions(+), 17 deletions(-)

-- 
2.17.1

